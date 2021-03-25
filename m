Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A423F348D60
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhCYJvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:51:07 -0400
Received: from out28-145.mail.aliyun.com ([115.124.28.145]:38568 "EHLO
        out28-145.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCYJu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:50:58 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09102357|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0016827-9.8908e-05-0.998218;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=liu.xiang@zlingsmart.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.Jq2JGyY_1616665851;
Received: from localhost(mailfrom:liu.xiang@zlingsmart.com fp:SMTPD_---.Jq2JGyY_1616665851)
          by smtp.aliyun-inc.com(10.194.97.246);
          Thu, 25 Mar 2021 17:50:52 +0800
From:   Liu Xiang <liu.xiang@zlingsmart.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com, liuxiang1999@gmail.com,
        Liu Xiang <liu.xiang@zlingsmart.com>
Subject: [PATCH] ARM: fix smp_processor_id() in preemptible warning in harden_branch_predictor()
Date:   Thu, 25 Mar 2021 17:50:49 +0800
Message-Id: <20210325095049.6948-1-liu.xiang@zlingsmart.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_HARDEN_BRANCH_PREDICTOR is selected and user aborts occur,
there is a warning:

BUG: using smp_processor_id() in preemptible [00000000] code: errnotest/577
caller is __do_user_fault.constprop.4+0x24/0x88
CPU: 1 PID: 577 Comm: errnotest Not tainted 4.14.188-rt87-fmsh-00004-g58055877a #1
Hardware name: FMSH PSOC Platform
[<8010d6d4>] (unwind_backtrace) from [<8010a228>] (show_stack+0x10/0x14)
[<8010a228>] (show_stack) from [<80698f44>] (dump_stack+0x7c/0x98)
[<80698f44>] (dump_stack) from [<803d17d0>] (check_preemption_disabled+0xc4/0xfc)
[<803d17d0>] (check_preemption_disabled) from [<80110eb8>] (__do_user_fault.constprop.4+0x24/0x88)
[<80110eb8>] (__do_user_fault.constprop.4) from [<801112e4>] (do_page_fault+0x2dc/0x310)
[<801112e4>] (do_page_fault) from [<801012a8>] (do_DataAbort+0x38/0xb8)
[<801012a8>] (do_DataAbort) from [<8010b03c>] (__dabt_usr+0x3c/0x40)
Exception stack(0xb21d1fb0 to 0xb21d1ff8)
1fa0:                                     fffffff4 00000000 00000054 fffffff4
1fc0: 00000000 00000000 7ed81cc8 7ed81ca0 0007a440 00000000 00000000 00000000
1fe0: 00000000 7ed81ca0 00010493 0001f330 20030010 ffffffff

Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
---
 arch/arm/include/asm/system_misc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
index 66f6a3ae6..4a55cfbdf 100644
--- a/arch/arm/include/asm/system_misc.h
+++ b/arch/arm/include/asm/system_misc.h
@@ -22,9 +22,10 @@ DECLARE_PER_CPU(harden_branch_predictor_fn_t, harden_branch_predictor_fn);
 static inline void harden_branch_predictor(void)
 {
 	harden_branch_predictor_fn_t fn = per_cpu(harden_branch_predictor_fn,
-						  smp_processor_id());
+						  get_cpu());
 	if (fn)
 		fn();
+	put_cpu();
 }
 #else
 #define harden_branch_predictor() do { } while (0)
-- 
2.17.1

