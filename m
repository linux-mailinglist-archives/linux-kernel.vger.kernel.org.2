Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CA230D2D8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 06:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhBCFVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 00:21:32 -0500
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223]:39559
        "HELO zg8tmja2lje4os4yms4ymjma.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229735AbhBCFVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 00:21:19 -0500
Received: from centos7u5.localdomain (unknown [202.43.158.76])
        by c1app2 (Coremail) with SMTP id AgINCgA3PLh8Mhpg7ACuAQ--.55402S3;
        Wed, 03 Feb 2021 13:19:57 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     Dave.Martin@arm.com, broonie@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] arm64/kernel: minor coding style tweaks
Date:   Wed,  3 Feb 2021 13:19:12 +0800
Message-Id: <1612329552-17977-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AgINCgA3PLh8Mhpg7ACuAQ--.55402S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW8Kw43CF4rur48uryUKFg_yoWkWFb_C3
        WSvF4xCryFyrnIvr18Gan3A3WS93yUJFy8Cws7tFWqyayqq345Cw45JFn2kw1UWw18Kw4f
        Xr9rJF98CF17GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4r
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUeNVyDUUUU
X-Originating-IP: [202.43.158.76]
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed two coding style issues in kernel/trap.c
1. spaces required around that '='
2. Missing a blank line after declarations

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 arch/arm64/kernel/traps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 6895ce7..4001a39 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -45,7 +45,7 @@
 #include <asm/system_misc.h>
 #include <asm/sysreg.h>
 
-static const char *handler[]= {
+static const char *handler[] = {
 	"Synchronous Abort",
 	"IRQ",
 	"FIQ",
@@ -318,6 +318,7 @@ static int call_undef_hook(struct pt_regs *regs)
 	} else if (compat_thumb_mode(regs)) {
 		/* 16-bit Thumb instruction */
 		__le16 instr_le;
+
 		if (get_user(instr_le, (__le16 __user *)pc))
 			goto exit;
 		instr = le16_to_cpu(instr_le);
@@ -332,6 +333,7 @@ static int call_undef_hook(struct pt_regs *regs)
 	} else {
 		/* 32-bit ARM instruction */
 		__le32 instr_le;
+
 		if (get_user(instr_le, (__le32 __user *)pc))
 			goto exit;
 		instr = le32_to_cpu(instr_le);
-- 
1.8.3.1

