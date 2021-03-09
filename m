Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133DC33224F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhCIJpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:45:40 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:49741 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229992AbhCIJpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:45:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UR6tdTj_1615283103;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UR6tdTj_1615283103)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Mar 2021 17:45:11 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] perf/x86/intel/lbr: Assign boolean values to a bool variable
Date:   Tue,  9 Mar 2021 17:45:02 +0800
Message-Id: <1615283102-47377-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./arch/x86/events/intel/lbr.c:917:9-10: WARNING: return of 0/1 in
function 'get_lbr_predicted' with return type bool.

./arch/x86/events/intel/lbr.c:909:9-10: WARNING: return of 0/1 in
function 'get_lbr_mispred' with return type bool.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/x86/events/intel/lbr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 21890da..edf8247 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -906,7 +906,7 @@ static __always_inline int get_lbr_br_type(u64 info)
 static __always_inline bool get_lbr_mispred(u64 info)
 {
 	if (static_cpu_has(X86_FEATURE_ARCH_LBR) && !x86_pmu.lbr_mispred)
-		return 0;
+		return false;
 
 	return !!(info & LBR_INFO_MISPRED);
 }
@@ -914,7 +914,7 @@ static __always_inline bool get_lbr_mispred(u64 info)
 static __always_inline bool get_lbr_predicted(u64 info)
 {
 	if (static_cpu_has(X86_FEATURE_ARCH_LBR) && !x86_pmu.lbr_mispred)
-		return 0;
+		return false;
 
 	return !(info & LBR_INFO_MISPRED);
 }
-- 
1.8.3.1

