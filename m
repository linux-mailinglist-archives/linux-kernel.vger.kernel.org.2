Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A9337ECE2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384819AbhELUC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358187AbhELSnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 14:43:05 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9012AC06138D
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 11:40:56 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g14so28288479edy.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 11:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OkykOuJqZae9glR7PkYcJ6/fmElj4y6zH2p9RvY0yOE=;
        b=q4YLVmA/vXDoeMzZwiqs0gAK4tI7M1zCqcEN5dUWxzdE/VBfjWFbLAqRdEO+d0MDjP
         z00HVfmGM3LNt8e0pY51YznMD/FX5SLAIoaqNqQdUDBqPwbn8GlInANggFNSKYGWWxLL
         KunfGkhdKxtzEw8wLm+gmZzyzsgDuNxnyoeocVJQr36fYt81u+O+G3OA2ilQIAUSz/bj
         BfduaQr0uRn1z/7zhDz2mOuF6pTLtPvEcoIMC/NIqp1Lh2YgtDYP40USFmyejGp8DTbU
         bKdWyy0Ffc/Mfgy7lfbdoTefjK8TiDQuXfFVGrTT6NTDktzO3+HQw79IwKBe+mrxeWxj
         BnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OkykOuJqZae9glR7PkYcJ6/fmElj4y6zH2p9RvY0yOE=;
        b=Z6syFp9aJKO8opmTfkyAdp0ez0PjHHoXdDcvn8B/wJxP2bvGYRZKjEftmsdZSuazAq
         ABFW4A/reE6JRlNGXVWnvdBMN76I6/2I8O/NUsp4cIczVobyKhlxi4YcDPdQQWT44doj
         xNEY6tfTWmqlRZeQXea58XO8Dy7s1i+i8wlafAtf7Qpey6WFMCdopDfsRsFD/SHDuXxq
         a5lf627VXtAIO6G5He85/gGrbM5SxqhP6ML/hb4Csfba45PJGVRxhGLEcl6CgW07qQRz
         I2hDcwAWP1uuuq133Kj9y0bhugIlG3pggwVg/e/w7wtUYCWfGgiNllDnhQzv4RrrD/xI
         8Rug==
X-Gm-Message-State: AOAM530GM8756uEz755dKmfvHHc/ReAIJkgm5WEx8Ujv1A7LxgSsWyTl
        dN7ICw+L2IZaPZOmVJ7wDJw=
X-Google-Smtp-Source: ABdhPJyxA1YMRWlOkQvZpAfROvmNMRe2OLaox9DZa2C/Q+uZNA5Oo/DJQBeqTAnXHmVdnofE710YOw==
X-Received: by 2002:a05:6402:3546:: with SMTP id f6mr45368980edd.267.1620844855337;
        Wed, 12 May 2021 11:40:55 -0700 (PDT)
Received: from gmail.com (0526E777.dsl.pool.telekom.hu. [5.38.231.119])
        by smtp.gmail.com with ESMTPSA id ga3sm344287ejb.34.2021.05.12.11.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 11:40:54 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 12 May 2021 20:40:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] x86/irq: merge common code in
 DEFINE_IDTENTRY_SYSVEC[_SIMPLE]
Message-ID: <YJwhNTwzI1nhqqHC@gmail.com>
References: <20210511005531.1065536-1-hpa@zytor.com>
 <20210511005531.1065536-5-hpa@zytor.com>
 <87lf8lfizj.ffs@nanos.tec.linutronix.de>
 <d6789f7c-9c44-cb57-2a52-03ac9474d2e2@zytor.com>
 <YJuUG5qhGW3A1fUD@gmail.com>
 <35c78aaa-4621-6a32-5c53-c2680a4b66c5@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35c78aaa-4621-6a32-5c53-c2680a4b66c5@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* H. Peter Anvin <hpa@zytor.com> wrote:

> 
> 
> On 5/12/21 1:38 AM, Ingo Molnar wrote:
> > 
> > * H. Peter Anvin <hpa@zytor.com> wrote:
> > 
> > > On 5/11/21 7:22 AM, Thomas Gleixner wrote:
> > > > 
> > > > That's not really making the code more readable. Something like the
> > > > below perhaps?
> > > > 
> > > > #define IDTENTRY_INVOKE_SYSVEC(func, regs, raw)				\
> > > > do {									\
> > > > 	irqentry_state_t state = irqentry_enter(regs);			\
> > > > 									\
> > > > 	instrumentation_begin();					\
> > > > 	kvm_set_cpu_l1tf_flush_l1d();					\
> > > >           if (raw) {							\
> > > > 		__irq_enter_raw();					\
> > > > 		func(regs);						\
> > > > 		__irq_exit_raw();			                \
> > > > 	} else {	                                                \
> > > > 		run_sysvec_on_irqstack_cond(func, regs);	        \
> > > >           }                                                               \
> > > > 	instrumentation_end();						\
> > > >           irqentry_exit(regs, state);					\
> > > > } while (0)								\
> > > > 
> > > 
> > > Digging more into it, it looks like a *lot* of the macros in
> > > <asm/irq_stack.h> and <asm/idtentry.h> can be replaced with inlines without
> > > any change in functionality or generated code.
> > 
> > That would be a much preferred outcome ...
> 
> Well, here is an RFC. This is obviously a much bigger change and I don't
> feel it is mature yet, but it would be good to know if you (plural) feel it
> is in the right direction.

Looks much cleaner IMO, and there's also some linecount reduction:

>  7 files changed, 117 insertions(+), 142 deletions(-)

Thanks,

	Ingo
