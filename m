Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B045C30D312
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 06:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhBCF2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 00:28:21 -0500
Received: from mail.loongson.cn ([114.242.206.163]:54836 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231270AbhBCF16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 00:27:58 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz_MwNBpgenUCAA--.3008S2;
        Wed, 03 Feb 2021 13:27:12 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     James.Bottomley@HansenPartnership.com, Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: Replace test_ti_thread_flag() with test_tsk_thread_flag()
Date:   Wed,  3 Feb 2021 13:27:12 +0800
Message-Id: <1612330032-6034-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxz_MwNBpgenUCAA--.3008S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw1ftryUGrWxXr4xZry3XFb_yoWfKFcE93
        WxXanrWrWfZr4fJrn8Wa93XF1Dt393ury5XrWvqwnrArykAr1UJayvvrnrZ34fur4DGF42
        ka4kJryFkw1qkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7AYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GrWl42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8trcDUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use test_tsk_thread_flag() directly instead of test_ti_thread_flag() to
improve readability when the argument type is struct task_struct, it is
similar with commit 5afc78551bf5 ("arm64: Use test_tsk_thread_flag() for
checking TIF_SINGLESTEP").

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/parisc/include/asm/compat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index 8f33085..1a609d3 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -179,7 +179,7 @@ static __inline__ void __user *arch_compat_alloc_user_space(long len)
 
 static inline int __is_compat_task(struct task_struct *t)
 {
-	return test_ti_thread_flag(task_thread_info(t), TIF_32BIT);
+	return test_tsk_thread_flag(t, TIF_32BIT);
 }
 
 static inline int is_compat_task(void)
-- 
2.1.0

