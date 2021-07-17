Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488863CC46D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 18:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhGQQX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 12:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhGQQXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 12:23:18 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DF59C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 09:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=YJt+haE2Sm3TLKcrxpxqRl/5JPhip7THLelT9v5ADVo=; b=WWt45czOxtIdP
        Tia0fhXd3+CSEOeDje5VRQ5SXcfIGxO7d0knPtE4a9SmB6L+36MlK5iG3xAUdAMl
        Hl/LAbHWUaWy240U97AFPI3LhV7y2160d9boGtIRW5rOeg7Runi+X0CojZMqHkGZ
        9icv1Kn7WlwGb0E2NoEHEzwArdOtjo=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCXnPw9A_Ngex6CAA--.1530S2;
        Sun, 18 Jul 2021 00:20:14 +0800 (CST)
Date:   Sun, 18 Jul 2021 00:14:23 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: enable GENERIC_FIND_FIRST_BIT
Message-ID: <20210718001423.6b8e1d23@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygCXnPw9A_Ngex6CAA--.1530S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyDGF1kGFyxtFyDAw15CFg_yoWDKrg_Gr
        yxArZ5G34UZrWIyrWvvF4Sqa1Ykayqga98Zr9Fyr4UWFy3Gw1fJa95tryFqr1xGw4fXFWU
        Za92qFnF9rnrXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbrAYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z2
        80aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        W3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
        JbIYCTnIWIevJa73UjIFyTuYvjxUcVWlDUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

riscv doesn't implement architecture-optimized bitsearching functions
such as find_first_{zero}_bit() etc.

When GENERIC_FIND_FIRST_BIT=n, find_first_bit() is implemented with
find_next_bit() which is less efficient. Enable GENERIC_FIND_FIRST_BIT
for riscv to get more optimized find_first_bit() implementation, an
initial test(lib/find_bit_benchmark) shows find_first_bit() performance
is improved by nearly 32%.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8fcceb8eda07..7ebc54c5c245 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -47,6 +47,7 @@ config RISCV
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_EARLY_IOREMAP
+	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
 	select GENERIC_IOREMAP
 	select GENERIC_IRQ_MULTI_HANDLER
-- 
2.32.0


