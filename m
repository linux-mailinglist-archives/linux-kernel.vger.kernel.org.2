Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522DA455B43
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344554AbhKRMNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344535AbhKRMM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:12:56 -0500
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5D69C061570
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 04:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=RAv3ldc+YtKig7hsLOKSrSUz10bjjpekX4e3Vo2jfPE=; b=p1NOk9Z5H0wGg
        rfDNp9AniCQdGCvIM3sV+30eAulKsuT8jcFjLtvUTfiQpFn7t6wldIODukwl6exn
        kWPn1ukCF/gKR/6wOA6EGiQnHKw57cmcozoEtEwoILh7xVbhhSM7c4YXZKpk0ZSC
        0Igxyl+jzcy3gD2A8Dc/uUuWy9YVSU=
Received: from xhacker (unknown [101.86.18.22])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygAHD9+OQpZhfM9cAQ--.27594S2;
        Thu, 18 Nov 2021 20:09:51 +0800 (CST)
Date:   Thu, 18 Nov 2021 20:02:49 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: extable: remove unsed ex_handler_t definition
Message-ID: <20211118200249.73172ce5@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygAHD9+OQpZhfM9cAQ--.27594S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyfJF1DCF4DZry3try3XFb_yoWxZFc_X3
        42ya1kWryFyr1SkFyrG3Z8CrySkw4vqry7ZF4IqrWvyr9FqrWrAr4qqFn3Kr1vgF4fursa
        q3ZrJr15GrW2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbFkYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        WUJVWrZr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j
        6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUxsXoUUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

The type ex_handler_t is defined but not used, remove it.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/arm64/mm/extable.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index c3d53811a15e..c0181e60cc98 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -10,9 +10,6 @@
 #include <asm/asm-extable.h>
 #include <asm/ptrace.h>
 
-typedef bool (*ex_handler_t)(const struct exception_table_entry *,
-			     struct pt_regs *);
-
 static inline unsigned long
 get_ex_fixup(const struct exception_table_entry *ex)
 {
-- 
2.33.0


