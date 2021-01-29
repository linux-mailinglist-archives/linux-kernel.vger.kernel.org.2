Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CBC308705
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 09:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhA2H6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhA2H54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:57:56 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEFFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:58:40 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id jx18so5923357pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y3XAOAi8AnxCKeXOkyy7rIFzv/9lzK05Mk3CCQ4/jzk=;
        b=n5QXesFbEUXm66Aqiu9+VDEsajddyoZrsl6SXB5B5G4YLZnAJ0cR2rNYwwOK/bjA5G
         9tetoYFzzCeDPWDe1dl4hIgmlmpqvrNHAvB5JlyWkctaupqHHCwYJ9NgdbKRsU5rve7P
         /khHpP7Y20zUXnLJTk2ybB7zXc3dqlgiGKjnEDDhcyBKaguLOjPwJUq/D1YxiVhGmtlH
         vpjjktkaovF+vskOJWT9FKXc1FmsHAEhn4atcw1VxboDlXJzswPcucPj6aegJRFwR3E3
         H555hZYwli24TPn5CC1j0D9JBJbofgkLIMhZtqh+WLgwcNWGZokbq+j8Pxnhgf9DiMfP
         LcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y3XAOAi8AnxCKeXOkyy7rIFzv/9lzK05Mk3CCQ4/jzk=;
        b=jeuX6KSANVVhsk4ZFTgBwfL8a9UX6TC5m6WwMEpM3rqYYLG5p0iBXBdFyV/0SH7g17
         X4U0VsWxw246IU/+k5zdRhbiLwU+AOMla/PbyshpfLykbjUPcDG41cjrnWulL8BOgXWE
         s3ISnpbsOgCwCbLEP9hGhnUleO0BZExwtxym4zm8fKmlj6jWK/y1x5I9PM+yWGaWkEv/
         J0pZ4oODvaw2GOy9Zxpc75FyP3jJIMzHc7lQq9JWtd4Ia0S7pD7E+mmrjJLy1ZMMZ7N0
         s/AXl+XS1Ebx+NVfvQgPRP1P19i3xhjAJOwBUAh5gLMw9J94HoyndijQu6KT6/kXgcyu
         LVsw==
X-Gm-Message-State: AOAM5305yNut3zAkUmKNpRGfdOeY/kKDYf+7dDVfWmiGD2KZwNNt4fsm
        M8DyxgSh3hwl5kO+Kx3Wnps=
X-Google-Smtp-Source: ABdhPJy/ZRQ7lsbJdJDRdQWTjVP5I9qsKAdeKgTUhFf/AMbl4WD6L7ntbq6ZOQ4JpAGvwBqjATkgPQ==
X-Received: by 2002:a17:90a:5303:: with SMTP id x3mr3468699pjh.54.1611907119492;
        Thu, 28 Jan 2021 23:58:39 -0800 (PST)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id j26sm4652613pfa.35.2021.01.28.23.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 23:58:38 -0800 (PST)
Date:   Thu, 28 Jan 2021 23:56:59 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64/ptrace: introduce NT_ARM_PRSTATUS to get a
 full set of registers
Message-ID: <20210129075659.GA155266@gmail.com>
References: <20210119220637.494476-1-avagin@gmail.com>
 <20210119220637.494476-3-avagin@gmail.com>
 <20210127145304.GC13952@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210127145304.GC13952@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 02:53:07PM +0000, Dave Martin wrote:
> On Tue, Jan 19, 2021 at 02:06:36PM -0800, Andrei Vagin wrote:
> > This is an alternative to NT_PRSTATUS that clobbers ip/r12 on AArch32,
> > x7 on AArch64 when a tracee is stopped in syscall entry or syscall exit
> > traps.
> > 
> > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> 
> This approach looks like it works, though I still think adding an option
> for this under PTRACE_SETOPTIONS would be less intrusive.

Dave, thank you for the feedback. I will prepare a patch with an option
and then we will see what looks better.

> 
> Adding a shadow regset like this also looks like it would cause the gp
> regs to be pointlessly be dumped twice in a core dump.  Avoiding that
> might require hacks in the core code...
> 
> 
> > ---
> >  arch/arm64/kernel/ptrace.c | 39 ++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/elf.h   |  1 +
> >  2 files changed, 40 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > index 1863f080cb07..b8e4c2ddf636 100644
> > --- a/arch/arm64/kernel/ptrace.c
> > +++ b/arch/arm64/kernel/ptrace.c
> > @@ -591,6 +591,15 @@ static int gpr_get(struct task_struct *target,
> >  	return ret;
> >  }
> >  
> > +static int gpr_get_full(struct task_struct *target,
> > +		   const struct user_regset *regset,
> > +		   struct membuf to)
> > +{
> > +	struct user_pt_regs *uregs = &task_pt_regs(target)->user_regs;
> > +
> > +	return membuf_write(&to, uregs, sizeof(*uregs));
> > +}
> > +
> >  static int gpr_set(struct task_struct *target, const struct user_regset *regset,
> >  		   unsigned int pos, unsigned int count,
> >  		   const void *kbuf, const void __user *ubuf)
> > @@ -1088,6 +1097,7 @@ static int tagged_addr_ctrl_set(struct task_struct *target, const struct
> >  
> >  enum aarch64_regset {
> >  	REGSET_GPR,
> > +	REGSET_GPR_FULL,
> 
> If we go with this approach, "REGSET_GPR_RAW" might be a preferable
> name.  Both regs represent all the regs ("full"), but REGSET_GPR is
> mangled by the kernel.

I agree that REGSET_GPR_RAW looks better in this case.

> 
> >  	REGSET_FPR,
> >  	REGSET_TLS,
> >  #ifdef CONFIG_HAVE_HW_BREAKPOINT
> > @@ -1119,6 +1129,14 @@ static const struct user_regset aarch64_regsets[] = {
> >  		.regset_get = gpr_get,
> >  		.set = gpr_set
> >  	},
> > +	[REGSET_GPR_FULL] = {
> > +		.core_note_type = NT_ARM_PRSTATUS,

...

> > diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> > index 30f68b42eeb5..a2086d19263a 100644
> > --- a/include/uapi/linux/elf.h
> > +++ b/include/uapi/linux/elf.h
> > @@ -426,6 +426,7 @@ typedef struct elf64_shdr {
> >  #define NT_ARM_PACA_KEYS	0x407	/* ARM pointer authentication address keys */
> >  #define NT_ARM_PACG_KEYS	0x408	/* ARM pointer authentication generic key */
> >  #define NT_ARM_TAGGED_ADDR_CTRL	0x409	/* arm64 tagged address control (prctl()) */
> 
> What happened to 0x40a..0x40f?

shame on me :)

> 
> [...]
> 
> Cheers
> ---Dave
