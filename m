Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA70737B82D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhELIkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhELIkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:40:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB5AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 01:38:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id w3so33792800ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 01:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xpv7E7m0/0rGiji1ncsswDm/EzxICdxuwDJh772j9n0=;
        b=gV5nshzUNBLeAszIp22vouVL7PMVADVEqeNUnusNOkANOf7Tg/Lt/JG9kU7hgV8T09
         S+es/Rd8xcOIh0ZNj9eUNP2RNF+2RFd3fjfxz9f8465QJaMjVgkkrFBD2J5MZ6/vX0i/
         M7s4K9Bssn/KwTh5vRKMVXnxw/DNcfK7KOjz1t4i0Klofwh6BZDfzIW7OywPk1cN/yBe
         3SZ5IZaX3u4UIbQ5azUHLgg4hk5wPbVq4z2YNBXzDFR3I30AjfG5HSBUnHp58QpF/lfz
         5iOqGED+S4auMOrDx+F77imX6fATgMrkypZs6o6kVYvqW2uU9exYEUNjEYgkfyKTMwZL
         rp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Xpv7E7m0/0rGiji1ncsswDm/EzxICdxuwDJh772j9n0=;
        b=cI2B9WywAviFmgHe+mR0x5F6a0GlD4/t3VubmFk34kZ/5jADRXKR0xMZy/aTwXshWa
         59X3LKSj6vKmnV/OPKa7E8Qbc79R7oq7jT9uSObfhn9gor9aHlmeyAUZrHg8mKePHOMY
         0QFehugxjftVQ1alRg5qe8r5AcnX2SY6cWeyFNk0030J/oCwlHsVZRqXDu7oblanU4jG
         t53KsOUTmdMNZmzMIxg1YZMW3vnCsSjM3jCr7GykBAiszp9prN5zamY3Fzj0fvGQIHJf
         vcmuyA8NB9/fRUKcromsvUvP4HTIKyGW07hlfhHzFMHlpdAoN48wKukSVl3blajUgwwe
         2NWA==
X-Gm-Message-State: AOAM532kywgbuUJTbf3dwJ+lWqPk7cMB2hy3Aysa/5klTm9S0znyKRfz
        reriXldNZpTkJGjHbaRSuW7zxklT31g=
X-Google-Smtp-Source: ABdhPJw8Ci94AXfF/DkYp976yQHl8GYsu0fdSeRBRp/txoOC/ky+B11y1uN6l1/iAGVLBO3JjlhoFg==
X-Received: by 2002:a17:906:c448:: with SMTP id ck8mr5534671ejb.497.1620808733842;
        Wed, 12 May 2021 01:38:53 -0700 (PDT)
Received: from gmail.com (0526E777.dsl.pool.telekom.hu. [5.38.231.119])
        by smtp.gmail.com with ESMTPSA id l2sm13354681ejs.125.2021.05.12.01.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 01:38:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 12 May 2021 10:38:51 +0200
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
Message-ID: <YJuUG5qhGW3A1fUD@gmail.com>
References: <20210511005531.1065536-1-hpa@zytor.com>
 <20210511005531.1065536-5-hpa@zytor.com>
 <87lf8lfizj.ffs@nanos.tec.linutronix.de>
 <d6789f7c-9c44-cb57-2a52-03ac9474d2e2@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6789f7c-9c44-cb57-2a52-03ac9474d2e2@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* H. Peter Anvin <hpa@zytor.com> wrote:

> On 5/11/21 7:22 AM, Thomas Gleixner wrote:
> > 
> > That's not really making the code more readable. Something like the
> > below perhaps?
> > 
> > #define IDTENTRY_INVOKE_SYSVEC(func, regs, raw)				\
> > do {									\
> > 	irqentry_state_t state = irqentry_enter(regs);			\
> > 									\
> > 	instrumentation_begin();					\
> > 	kvm_set_cpu_l1tf_flush_l1d();					\
> >          if (raw) {							\
> > 		__irq_enter_raw();					\
> > 		func(regs);						\
> > 		__irq_exit_raw();			                \
> > 	} else {	                                                \
> > 		run_sysvec_on_irqstack_cond(func, regs);	        \
> >          }                                                               \
> > 	instrumentation_end();						\
> >          irqentry_exit(regs, state);					\
> > } while (0)								\
> > 
> 
> Digging more into it, it looks like a *lot* of the macros in
> <asm/irq_stack.h> and <asm/idtentry.h> can be replaced with inlines without
> any change in functionality or generated code.

That would be a much preferred outcome ...

Thanks,

	Ingo
