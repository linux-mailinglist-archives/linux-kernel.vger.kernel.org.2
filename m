Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE252394DAF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 20:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhE2SmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 14:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhE2SmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 14:42:15 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1044C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 11:40:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id z26so1805764pfj.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 11:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Y5eeuuk+L/opcH1pywf9XaZz1CvayeU6mj335HgHfKQ=;
        b=ICvFaD3jWrVFqzIKbhlTkKMyMhVw8JNUOBos7wMlnhofEwbn86h/BC77sKLPjNsPgP
         HiddcDkdZjwCdGm5EJgM+5X7eX/0HGui8ZCraI7n7sqBhUleV4OL9CONlK5yRe33TyxU
         rBncFJS2sOHEpWBcLqhqV6C16Ljd3l2I2Wf8BQu606roIDWx/UEP6Wfo8+WPR74TryVF
         pknTxXPFYEI0UR5rIfdG47/or7IrzYZbwZ5V51Mr1q6rjn2dliovcvYksMbzksyPoyhM
         fPugpjLMDYoIqkamDWrGVKZfkp4F1kjErN+/9HI79jFhbq1Mi2hhYWBTSZU6+VjZf7ZZ
         Wo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Y5eeuuk+L/opcH1pywf9XaZz1CvayeU6mj335HgHfKQ=;
        b=qWZDXDwiUIuSD0HZsGb5addzQpHM6dgelJdZPKx7z8HSYYELCCjkgacStrFazbKrKK
         wAt1oI+Nk3DgmxiDqlWmhKR6g7KG15i2bQtRTOCthmQwLQuVkNWo0HMkZR9hIaxd/biv
         XnE7siQy2ds2IVg68I1osNHT5n+DMR6zj0uvYZKuPux9bDAD9+KMFlGMNRGaIFjv08/F
         b/YgDCxiaJNEVYEnK38eTbrwUvLhaQsdPgX/yj2umwWquE8goUrDln7JTj0la/nzTaP1
         WmrWdFzVfsTsYXWqO6ijRpVKk4wn97s/1cmZ2SsexEdKVHYGVCNkxELbohYPVwx0F8FX
         p79Q==
X-Gm-Message-State: AOAM531gdUCQgnTTrq+K9tApD29y1hGf++E6Z5omxUl/IoY9ewWGw0cR
        wOF21wBsfVjQJHNo748bJUaazw==
X-Google-Smtp-Source: ABdhPJzc9dWVDPV7LCQvfbx+/+RbqsGuI3x8/CE9rDTRAvtwI5+otwsABJqdCAPxFQip/idPDNa3cg==
X-Received: by 2002:a63:f74b:: with SMTP id f11mr14943415pgk.327.1622313638156;
        Sat, 29 May 2021 11:40:38 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v11sm6925372pgs.6.2021.05.29.11.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 11:40:37 -0700 (PDT)
Date:   Sat, 29 May 2021 11:40:37 -0700 (PDT)
X-Google-Original-Date: Sat, 29 May 2021 11:34:23 PDT (-0700)
Subject:     Re: [PATCH] riscv: kprobes: Remove redundant kprobe_step_ctx
In-Reply-To: <20210512225819.6756c0b0@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        mhiramat@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-458b641d-fe97-4d92-8a6a-e43240aeb0c3@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 07:58:19 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> On Mon, 19 Apr 2021 00:29:19 +0800
> Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
>
>> From: Jisheng Zhang <jszhang@kernel.org>
>>
>> Inspired by commit ba090f9cafd5 ("arm64: kprobes: Remove redundant
>> kprobe_step_ctx"), the ss_pending and match_addr of kprobe_step_ctx
>> are redundant because those can be replaced by KPROBE_HIT_SS and
>> &cur_kprobe->ainsn.api.insn[0] + GET_INSN_LENGTH(cur->opcode)
>> respectively.
>>
>> Remove the kprobe_step_ctx to simplify the code.
>
> Hi all,
>
> This patch can still be applied to 5.13-rc1, could you please review? Let me
> know if a rebase on 5.13-rc1 is needed.

Sorry, I missed this one.  This is on for-next.

>
> Thanks
>
>>
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> ---
>>  arch/riscv/include/asm/kprobes.h   |  7 ------
>>  arch/riscv/kernel/probes/kprobes.c | 40 +++++++-----------------------
>>  2 files changed, 9 insertions(+), 38 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
>> index 4647d38018f6..9ea9b5ec3113 100644
>> --- a/arch/riscv/include/asm/kprobes.h
>> +++ b/arch/riscv/include/asm/kprobes.h
>> @@ -29,18 +29,11 @@ struct prev_kprobe {
>>  	unsigned int status;
>>  };
>>
>> -/* Single step context for kprobe */
>> -struct kprobe_step_ctx {
>> -	unsigned long ss_pending;
>> -	unsigned long match_addr;
>> -};
>> -
>>  /* per-cpu kprobe control block */
>>  struct kprobe_ctlblk {
>>  	unsigned int kprobe_status;
>>  	unsigned long saved_status;
>>  	struct prev_kprobe prev_kprobe;
>> -	struct kprobe_step_ctx ss_ctx;
>>  };
>>
>>  void arch_remove_kprobe(struct kprobe *p);
>> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
>> index 8c1f7a30aeed..4c1ad5536748 100644
>> --- a/arch/riscv/kernel/probes/kprobes.c
>> +++ b/arch/riscv/kernel/probes/kprobes.c
>> @@ -17,7 +17,7 @@ DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
>>  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>>
>>  static void __kprobes
>> -post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
>> +post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
>>
>>  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>>  {
>> @@ -43,7 +43,7 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
>>  		p->ainsn.api.handler((u32)p->opcode,
>>  					(unsigned long)p->addr, regs);
>>
>> -	post_kprobe_handler(kcb, regs);
>> +	post_kprobe_handler(p, kcb, regs);
>>  }
>>
>>  int __kprobes arch_prepare_kprobe(struct kprobe *p)
>> @@ -149,21 +149,6 @@ static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ctlblk *kcb,
>>  	regs->status = kcb->saved_status;
>>  }
>>
>> -static void __kprobes
>> -set_ss_context(struct kprobe_ctlblk *kcb, unsigned long addr, struct kprobe *p)
>> -{
>> -	unsigned long offset = GET_INSN_LENGTH(p->opcode);
>> -
>> -	kcb->ss_ctx.ss_pending = true;
>> -	kcb->ss_ctx.match_addr = addr + offset;
>> -}
>> -
>> -static void __kprobes clear_ss_context(struct kprobe_ctlblk *kcb)
>> -{
>> -	kcb->ss_ctx.ss_pending = false;
>> -	kcb->ss_ctx.match_addr = 0;
>> -}
>> -
>>  static void __kprobes setup_singlestep(struct kprobe *p,
>>  				       struct pt_regs *regs,
>>  				       struct kprobe_ctlblk *kcb, int reenter)
>> @@ -182,8 +167,6 @@ static void __kprobes setup_singlestep(struct kprobe *p,
>>  		/* prepare for single stepping */
>>  		slot = (unsigned long)p->ainsn.api.insn;
>>
>> -		set_ss_context(kcb, slot, p);	/* mark pending ss */
>> -
>>  		/* IRQs and single stepping do not mix well. */
>>  		kprobes_save_local_irqflag(kcb, regs);
>>
>> @@ -219,13 +202,8 @@ static int __kprobes reenter_kprobe(struct kprobe *p,
>>  }
>>
>>  static void __kprobes
>> -post_kprobe_handler(struct kprobe_ctlblk *kcb, struct pt_regs *regs)
>> +post_kprobe_handler(struct kprobe *cur, struct kprobe_ctlblk *kcb, struct pt_regs *regs)
>>  {
>> -	struct kprobe *cur = kprobe_running();
>> -
>> -	if (!cur)
>> -		return;
>> -
>>  	/* return addr restore if non-branching insn */
>>  	if (cur->ainsn.api.restore != 0)
>>  		regs->epc = cur->ainsn.api.restore;
>> @@ -355,16 +333,16 @@ bool __kprobes
>>  kprobe_single_step_handler(struct pt_regs *regs)
>>  {
>>  	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +	unsigned long addr = instruction_pointer(regs);
>> +	struct kprobe *cur = kprobe_running();
>>
>> -	if ((kcb->ss_ctx.ss_pending)
>> -	    && (kcb->ss_ctx.match_addr == instruction_pointer(regs))) {
>> -		clear_ss_context(kcb);	/* clear pending ss */
>> -
>> +	if (cur && (kcb->kprobe_status & (KPROBE_HIT_SS | KPROBE_REENTER)) &&
>> +	    ((unsigned long)&cur->ainsn.api.insn[0] + GET_INSN_LENGTH(cur->opcode) == addr)) {
>>  		kprobes_restore_local_irqflag(kcb, regs);
>> -
>> -		post_kprobe_handler(kcb, regs);
>> +		post_kprobe_handler(cur, kcb, regs);
>>  		return true;
>>  	}
>> +	/* not ours, kprobes should ignore it */
>>  	return false;
>>  }
>>
