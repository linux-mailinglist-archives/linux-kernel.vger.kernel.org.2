Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD10537C42D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 17:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhELP3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 11:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbhELPOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:14:16 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7F51C06134D
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=l7RZxnql5klUqc/JYLPFMAZ9vl2oURQedf
        Q8t+ojKTY=; b=PNo7qZlmMkXossjSSO6zH2PM1hK5dCmHh8Wc9+XB466E8cHbPG
        xPyXcqEbQ3Gu6re/GQnWh6VzDfBm8TqxiiEmgKVN6hxedJnmnu+IM0+Py35cTZsW
        Yw6easWjIPCalX0IwMyG1vSBpFaLVzJ2or6L2OSp7TR51nBxdtjTjW6oM=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDn7Z1F7ptgzS_JAA--.64496S2;
        Wed, 12 May 2021 23:03:34 +0800 (CST)
Date:   Wed, 12 May 2021 22:58:19 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: kprobes: Remove redundant kprobe_step_ctx
Message-ID: <20210512225819.6756c0b0@xhacker>
In-Reply-To: <20210419002919.1a0a539d@xhacker>
References: <20210419002919.1a0a539d@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygDn7Z1F7ptgzS_JAA--.64496S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryfJr1kZFy8tFW3Ar1DWrg_yoWrKw1kpF
        ZIk3W3KrZ5Jas5uFy2yw4UZr1Svr48ZrW2kry8C34ftw1ayr13JF1xW3yjyrn8Gr95Kw1a
        yFy7trW8J3s7AFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUy2b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s02
        6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
        0_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
        Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnNVgUUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 00:29:19 +0800
Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:

> From: Jisheng Zhang <jszhang@kernel.org>
> 
> Inspired by commit ba090f9cafd5 ("arm64: kprobes: Remove redundant
> kprobe_step_ctx"), the ss_pending and match_addr of kprobe_step_ctx
> are redundant because those can be replaced by KPROBE_HIT_SS and
> &cur_kprobe->ainsn.api.insn[0] + GET_INSN_LENGTH(cur->opcode)
> respectively.
> 
> Remove the kprobe_step_ctx to simplify the code.

Hi all,

This patch can still be applied to 5.13-rc1, could you please review? Let me
know if a rebase on 5.13-rc1 is needed.

Thanks

> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/kprobes.h   |  7 ------
>  arch/riscv/kernel/probes/kprobes.c | 40 +++++++-----------------------
>  2 files changed, 9 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
> index 4647d38018f6..9ea9b5ec3113 100644
> --- a/arch/riscv/include/asm/kprobes.h
> +++ b/arch/riscv/include/asm/kprobes.h
> @@ -29,18 +29,11 @@ struct prev_kprobe {
>  	unsigned int status;
>  };
>  
> -/* Single step context for kprobe */
> -struct kprobe_step_ctx {
> -	unsigned long ss_pending;
> -	unsigned long match_addr;
> -};
> -
>  /* per-cpu kprobe control block */
>  struct kprobe_ctlblk {
>  	unsigned int kprobe_status;
>  	unsigned long saved_status;
>  	struct prev_kprobe prev_kprobe;
> -	struct kprobe_step_ctx ss_ctx;
>  };
>  
>  void arch_remove_kprobe(struct kprobe *p);
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index 8c1f7a30aeed..4c1ad5536748 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -17,7 +17,7 @@ DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
>  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>  
>  static void __kprobes
> -post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
> +post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
>  
>  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>  {
> @@ -43,7 +43,7 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
>  		p->ainsn.api.handler((u32)p->opcode,
>  					(unsigned long)p->addr, regs);
>  
> -	post_kprobe_handler(kcb, regs);
> +	post_kprobe_handler(p, kcb, regs);
>  }
>  
>  int __kprobes arch_prepare_kprobe(struct kprobe *p)
> @@ -149,21 +149,6 @@ static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ctlblk *kcb,
>  	regs->status = kcb->saved_status;
>  }
>  
> -static void __kprobes
> -set_ss_context(struct kprobe_ctlblk *kcb, unsigned long addr, struct kprobe *p)
> -{
> -	unsigned long offset = GET_INSN_LENGTH(p->opcode);
> -
> -	kcb->ss_ctx.ss_pending = true;
> -	kcb->ss_ctx.match_addr = addr + offset;
> -}
> -
> -static void __kprobes clear_ss_context(struct kprobe_ctlblk *kcb)
> -{
> -	kcb->ss_ctx.ss_pending = false;
> -	kcb->ss_ctx.match_addr = 0;
> -}
> -
>  static void __kprobes setup_singlestep(struct kprobe *p,
>  				       struct pt_regs *regs,
>  				       struct kprobe_ctlblk *kcb, int reenter)
> @@ -182,8 +167,6 @@ static void __kprobes setup_singlestep(struct kprobe *p,
>  		/* prepare for single stepping */
>  		slot = (unsigned long)p->ainsn.api.insn;
>  
> -		set_ss_context(kcb, slot, p);	/* mark pending ss */
> -
>  		/* IRQs and single stepping do not mix well. */
>  		kprobes_save_local_irqflag(kcb, regs);
>  
> @@ -219,13 +202,8 @@ static int __kprobes reenter_kprobe(struct kprobe *p,
>  }
>  
>  static void __kprobes
> -post_kprobe_handler(struct kprobe_ctlblk *kcb, struct pt_regs *regs)
> +post_kprobe_handler(struct kprobe *cur, struct kprobe_ctlblk *kcb, struct pt_regs *regs)
>  {
> -	struct kprobe *cur = kprobe_running();
> -
> -	if (!cur)
> -		return;
> -
>  	/* return addr restore if non-branching insn */
>  	if (cur->ainsn.api.restore != 0)
>  		regs->epc = cur->ainsn.api.restore;
> @@ -355,16 +333,16 @@ bool __kprobes
>  kprobe_single_step_handler(struct pt_regs *regs)
>  {
>  	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +	unsigned long addr = instruction_pointer(regs);
> +	struct kprobe *cur = kprobe_running();
>  
> -	if ((kcb->ss_ctx.ss_pending)
> -	    && (kcb->ss_ctx.match_addr == instruction_pointer(regs))) {
> -		clear_ss_context(kcb);	/* clear pending ss */
> -
> +	if (cur && (kcb->kprobe_status & (KPROBE_HIT_SS | KPROBE_REENTER)) &&
> +	    ((unsigned long)&cur->ainsn.api.insn[0] + GET_INSN_LENGTH(cur->opcode) == addr)) {
>  		kprobes_restore_local_irqflag(kcb, regs);
> -
> -		post_kprobe_handler(kcb, regs);
> +		post_kprobe_handler(cur, kcb, regs);
>  		return true;
>  	}
> +	/* not ours, kprobes should ignore it */
>  	return false;
>  }
>  


