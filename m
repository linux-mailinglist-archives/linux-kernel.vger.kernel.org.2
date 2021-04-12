Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0197D35CC16
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 18:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244049AbhDLQ06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 12:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243258AbhDLQYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 12:24:18 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC42DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 09:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=8lRS5PKRg+wSW2+e9kKETn+Cn0NAuvZahd
        IC8PRgBYM=; b=WC+KjpWaqSKQ1sOC4IQyxTGw3Mxis3xFPpTlZNEYw3pW5vJZU4
        JjvPk+sdW2CS7lnpHTwoO0St0X60St3GzO6ON78S5jYa18zIELSBXZvZ2sbpJ6nM
        HFeYcMhmEd4rFWJJVPtfVRyCgMhhbsHA02A3+deg0/2bLLovs0NIMA3VM=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDX3Ejzc3RgBUDLAA--.24267S2;
        Tue, 13 Apr 2021 00:23:16 +0800 (CST)
Date:   Tue, 13 Apr 2021 00:18:13 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        " =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=" <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>, Anup Patel <anup@brainfault.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/10] riscv: bpf: Write protect JIT code
Message-ID: <20210413001813.36b397bc@xhacker>
In-Reply-To: <20210413001110.7209bae6@xhacker>
References: <20210413001110.7209bae6@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygDX3Ejzc3RgBUDLAA--.24267S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyfAF4xCFy7WrW5tr4UXFb_yoW3XFg_Z3
        W8ta4xW3s3Jr4xAr4DZr4rZr10yw1FkFZ5Zr1xXryUAas0gr15KasaqrWFgr97ursYqrW3
        Wr97JryxXw4aqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4AYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
        04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8S1v3
        UUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

Call bpf_jit_binary_lock_ro() to write protect JIT code.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/net/bpf_jit_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 3630d447352c..40d5bf113fee 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -152,6 +152,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bpf_flush_icache(jit_data->header, ctx->insns + ctx->ninsns);
 
 	if (!prog->is_func || extra_pass) {
+		bpf_jit_binary_lock_ro(jit_data->header);
 out_offset:
 		kfree(ctx->offset);
 		kfree(jit_data);
-- 
2.31.0


