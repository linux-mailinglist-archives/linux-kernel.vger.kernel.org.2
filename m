Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B264945695A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 05:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhKSE40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 23:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhKSE4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 23:56:24 -0500
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DED4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 20:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=gqlxegaNjjpmliJ2YUphkr3nRsImY8w2y2NUeQorNDM=; b=fOo+/m3lMdQZF
        fW7XTylRWcD1NiPBoqvPUM4FdA6mX4F1K/rZGswkTlQ/v2UjbukqLKYXexF7v8wd
        /DOrR0oGZ6eJOkJm6cIKbnmu7neDvWTBOZ4KrasQsTBKalUVzWaPFBLFTsnARlpT
        59dbF1xaw29lNEom6XOO+5/rwtE7fI=
Received: from xhacker (unknown [101.86.18.22])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDHzU25LZdh+gliAQ--.1195S2;
        Fri, 19 Nov 2021 12:53:13 +0800 (CST)
Date:   Fri, 19 Nov 2021 12:46:08 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: extable: remove unsed ex_handler_t definition
Message-ID: <20211119124608.3f03380b@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygDHzU25LZdh+gliAQ--.1195S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy3uw4xXFyUuFWxCr1xKrg_yoWfurb_Z3
        4IyaykWryFyr1SyryrW3ZxCry0k34vqryUJFsYqrZYyF97XrWrCrWqqFnakr1vgFWS9r1v
        93Z7Jr15Kr42qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbrkYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
        80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
        zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
        8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCa
        FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WF
        yUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4U
        YxBIdaVFxhVjvjDU0xZFpf9x07jY6wZUUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

The ex_handler_t type was introduced in commit d6e2cc564775 ("arm64:
extable: add `type` and `data` fields"), but has never been used, and
is unnecessary. Remove it.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---

Since v1:
 - update commit msg as Mark suggested, thank Mark
 - add Mark's Acked-by tag

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


