Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8184738886D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 09:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242252AbhESHqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 03:46:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:51685 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241271AbhESHqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 03:46:14 -0400
IronPort-SDR: Y2dhkEqs6sahEssVlSEaPtNmp4JlZVKxN7SuiyR4f05uDMg6etRPl8E9b5+DRWapYQEKfBZb+g
 MgHFBVdIzTSQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200964066"
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="200964066"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 00:44:54 -0700
IronPort-SDR: QPlfJBlhpP/4QgiQSvuGlob0ZPaDri3VhcOD6DXnyVdzxmBbOdGCoefjHDxZcRThVi5bWrohl8
 rvT8kY/BScIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="411625031"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 19 May 2021 00:44:52 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf intel-pt: Fix sample instruction bytes
Date:   Wed, 19 May 2021 10:45:14 +0300
Message-Id: <20210519074515.9262-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210519074515.9262-1-adrian.hunter@intel.com>
References: <20210519074515.9262-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decoder reports the current instruction if it was decoded. In some
cases the current instruction is not decoded, in which case the instruction
bytes length must be set to zero. Ensure that is always done.

Note perf script can anyway get the instruction bytes for any samples where
they are not present.

Also note, that there is a redundant "ptq->insn_len = 0" statement which is
not removed until a subsequent patch in order to make this patch apply
cleanly to stable branches.

Example:

A machne that supports TSX is required. It will have flag "rtm". Kernel
parameter tsx=on may be required.

 # for w in `cat /proc/cpuinfo | grep -m1 flags `;do echo $w | grep rtm ; done
 rtm

Test program:

 #include <stdio.h>
 #include <immintrin.h>

 int main()
 {
        int x = 0;

        if (_xbegin() == _XBEGIN_STARTED) {
                x = 1;
                _xabort(1);
        } else {
                printf("x = %d\n", x);
        }
        return 0;
 }

Compile with -mrtm i.e.

 gcc -Wall -Wextra -mrtm xabort.c -o xabort

Record:

 perf record -e intel_pt/cyc/u --filter 'filter main @ ./xabort' ./xabort

Before:

 # perf script --itrace=xe -F+flags,+insn,-period --xed --ns
          xabort  1478 [007] 92161.431348581:   transactions:   x                              400b81 main+0x14 (/root/xabort)          mov $0xffffffff, %eax
          xabort  1478 [007] 92161.431348624:   transactions:   tx abrt                        400b93 main+0x26 (/root/xabort)          mov $0xffffffff, %eax

After:

 # perf script --itrace=xe -F+flags,+insn,-period --xed --ns
          xabort  1478 [007] 92161.431348581:   transactions:   x                              400b81 main+0x14 (/root/xabort)          xbegin 0x6
          xabort  1478 [007] 92161.431348624:   transactions:   tx abrt                        400b93 main+0x26 (/root/xabort)          xabort $0x1

Fixes: faaa87680b25d ("perf intel-pt/bts: Report instruction bytes and length in sample")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 tools/perf/util/intel-pt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 2a5fe1514e65..4428dba24aa7 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -778,8 +778,10 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 
 			*ip += intel_pt_insn->length;
 
-			if (to_ip && *ip == to_ip)
+			if (to_ip && *ip == to_ip) {
+				intel_pt_insn->length = 0;
 				goto out_no_cache;
+			}
 
 			if (*ip >= al.map->end)
 				break;
@@ -1301,6 +1303,7 @@ static void intel_pt_set_pid_tid_cpu(struct intel_pt *pt,
 
 static void intel_pt_sample_flags(struct intel_pt_queue *ptq)
 {
+	ptq->insn_len = 0;
 	if (ptq->state->flags & INTEL_PT_ABORT_TX) {
 		ptq->flags = PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TX_ABORT;
 	} else if (ptq->state->flags & INTEL_PT_ASYNC) {
-- 
2.17.1

