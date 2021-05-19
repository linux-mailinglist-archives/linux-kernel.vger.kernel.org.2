Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8C3388869
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 09:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241524AbhESHqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 03:46:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:51685 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240919AbhESHqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 03:46:14 -0400
IronPort-SDR: t0vRVs4yrqKWCp1nnhWOgswiQHmgn1/nu6DA75Jfghl5oRPj0lp42F/QiBriu6tHTSBrTc0uRV
 FBOMWdM0j/HQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200964063"
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="200964063"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 00:44:53 -0700
IronPort-SDR: rpa6mYkfnevFRK4NQSk9hrWCOLxMvaJCvMJewlKGfi3swTiUE0cACnKlNzZGfCVh/MNiSlDtnF
 Wi/NYjOJx9CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="411625027"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 19 May 2021 00:44:50 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf intel-pt: Fix transaction abort handling
Date:   Wed, 19 May 2021 10:45:13 +0300
Message-Id: <20210519074515.9262-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210519074515.9262-1-adrian.hunter@intel.com>
References: <20210519074515.9262-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding support for power events, some handling of FUP packets was
unified. That resulted in breaking reporting of TSX aborts, by not
considering the associated TIP packet. Fix that.

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

 # perf script --itrace=be -F+flags,+addr,-period,-event --ns
          xabort  1478 [007] 92161.431348552:   tr strt                             0 [unknown] ([unknown]) =>           400b6d main+0x0 (/root/xabort)
          xabort  1478 [007] 92161.431348624:   jmp                            400b96 main+0x29 (/root/xabort) =>           400bae main+0x41 (/root/xabort)
          xabort  1478 [007] 92161.431348624:   return                         400bb4 main+0x47 (/root/xabort) =>           400b87 main+0x1a (/root/xabort)
          xabort  1478 [007] 92161.431348637:   jcc                            400b8a main+0x1d (/root/xabort) =>           400b98 main+0x2b (/root/xabort)
          xabort  1478 [007] 92161.431348644:   tr end  call                   400ba9 main+0x3c (/root/xabort) =>           40f690 printf+0x0 (/root/xabort)
          xabort  1478 [007] 92161.431360859:   tr strt                             0 [unknown] ([unknown]) =>           400bae main+0x41 (/root/xabort)
          xabort  1478 [007] 92161.431360882:   tr end  return                 400bb4 main+0x47 (/root/xabort) =>           401139 __libc_start_main+0x309 (/root/xabort)

After:

 # perf script --itrace=be -F+flags,+addr,-period,-event --ns
          xabort  1478 [007] 92161.431348552:   tr strt                             0 [unknown] ([unknown]) =>           400b6d main+0x0 (/root/xabort)
          xabort  1478 [007] 92161.431348624:   tx abrt                        400b93 main+0x26 (/root/xabort) =>           400b87 main+0x1a (/root/xabort)
          xabort  1478 [007] 92161.431348637:   jcc                            400b8a main+0x1d (/root/xabort) =>           400b98 main+0x2b (/root/xabort)
          xabort  1478 [007] 92161.431348644:   tr end  call                   400ba9 main+0x3c (/root/xabort) =>           40f690 printf+0x0 (/root/xabort)
          xabort  1478 [007] 92161.431360859:   tr strt                             0 [unknown] ([unknown]) =>           400bae main+0x41 (/root/xabort)
          xabort  1478 [007] 92161.431360882:   tr end  return                 400bb4 main+0x47 (/root/xabort) =>           401139 __libc_start_main+0x309 (/root/xabort)

Fixes: a472e65fc490a ("perf intel-pt: Add decoder support for ptwrite and power event packets")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 0db5f948801f..cb2520abf261 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1205,6 +1205,8 @@ static bool intel_pt_fup_event(struct intel_pt_decoder *decoder)
 		decoder->set_fup_tx_flags = false;
 		decoder->tx_flags = decoder->fup_tx_flags;
 		decoder->state.type = INTEL_PT_TRANSACTION;
+		if (decoder->fup_tx_flags & INTEL_PT_ABORT_TX)
+			decoder->state.type |= INTEL_PT_BRANCH;
 		decoder->state.from_ip = decoder->ip;
 		decoder->state.to_ip = 0;
 		decoder->state.flags = decoder->fup_tx_flags;
@@ -1279,8 +1281,10 @@ static int intel_pt_walk_fup(struct intel_pt_decoder *decoder)
 			return 0;
 		if (err == -EAGAIN ||
 		    intel_pt_fup_with_nlip(decoder, &intel_pt_insn, ip, err)) {
+			bool no_tip = decoder->pkt_state != INTEL_PT_STATE_FUP;
+
 			decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
-			if (intel_pt_fup_event(decoder))
+			if (intel_pt_fup_event(decoder) && no_tip)
 				return 0;
 			return -EAGAIN;
 		}
-- 
2.17.1

