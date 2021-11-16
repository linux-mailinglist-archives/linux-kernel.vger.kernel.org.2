Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EC5453ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 21:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhKPURi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 15:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhKPURh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 15:17:37 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01117C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 12:14:40 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i12so442915pfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 12:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7yrz1CWUd+4P4ldThWioPJyhOtCTVO4W1naFTnjYxys=;
        b=FyDrtGq5haDbqgqZ+gfAxvoBsl5cLfYJxhHfPqH+UDQGjdS5fDBtiNdn0IqPlHY54b
         v05Ne3kzZWy4gGpxupnJgDjKMfStvZSNwg3bLBceN0zN+VPGA6gX4Hs/f9fFbbhf90pX
         OiBe/hicATMHqHuvkfd0QvEZp4R5EzJ4Ww1vlsuvnw1GtYyV9Gwt8dV1HVu4WvsLSPfi
         UKUK8mY6HAFgL1x5k0to2V4khgsq0WSLi8Tyx+P3nNdFNmEVPWEgs3BjAYTx8+eGmffE
         K31dPTlRSUgbOK0WuBYJedEhLh/r4RueUZLf/7hXkxLOuUwx3KJPfb2Bpo+NYZfHQKEA
         5zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7yrz1CWUd+4P4ldThWioPJyhOtCTVO4W1naFTnjYxys=;
        b=OOTijtUtbwOmLqp5v4JaclHydhkX84viCrg8siX+bkGUIHv/cA/zWp6bcrCkWQf3Lr
         10Xiq7nmS3dkpQos+X1l7vX6i/l4DayGERxCMZVrvMX7wBre2U/bgOvlu5q2psh38Vez
         ffTRub3fHFInVgcb/szlLjuTXUs5N+dnseD3X/UHhYWyq5sWLMySjKF7031f0b1myoK6
         X/E37/vTOkyXFctFabf+y0IdC5REyh9zSXnCA2kDywPBQtGprEpYbcSvuw3crYM6tEil
         kveD6ZLbSYN/kfOEfnKjaLLeawTm1tuIbbHlwufUv2vEFMywiYkicaZ9gC3154m250lQ
         kSpQ==
X-Gm-Message-State: AOAM530NrfUcYbeHUC2ddIPlOD4B3xNx+A2E/zaGaRmHPabuNHAsg7CV
        gJ4SFz3nKDv2b++henrcRCdZLA==
X-Google-Smtp-Source: ABdhPJy0qqczmU3dj3Vf1DoJfDEJeVsv8C7UwdZfRh8Af0kNEg9ad9xaHMXT4OyUxgm5zASxBM8MZg==
X-Received: by 2002:a05:6a00:c81:b029:30e:21bf:4c15 with SMTP id a1-20020a056a000c81b029030e21bf4c15mr1800627pfv.70.1637093679397;
        Tue, 16 Nov 2021 12:14:39 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f19sm13219209pgj.7.2021.11.16.12.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 12:14:38 -0800 (PST)
Date:   Tue, 16 Nov 2021 20:14:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jing Liu <jing2.liu@linux.intel.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Subject: Re: Thoughts of AMX KVM support based on latest kernel
Message-ID: <YZQRK2EUyhy/I7n1@google.com>
References: <BYAPR11MB325685AB8E3DFD245846F854A9939@BYAPR11MB3256.namprd11.prod.outlook.com>
 <87k0h85m65.ffs@tglx>
 <YZPWsICdDTZ02UDu@google.com>
 <87ee7g53rp.ffs@tglx>
 <04978d6d-8e1a-404d-b30d-402a7569c1f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04978d6d-8e1a-404d-b30d-402a7569c1f0@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021, Paolo Bonzini wrote:
> On 11/16/21 19:55, Thomas Gleixner wrote:
> > We can do that, but I'm unhappy about this conditional in schedule(). So
> > I was asking for doing a simple KVM only solution first:
> > 
> > vcpu_run()
> >          kvm_load_guest_fpu()
> >              wrmsrl(XFD, guest_fpstate->xfd);
> >              XRSTORS
> >          do {
> > 
> >             local_irq_disable();
> > 
> >             if (test_thread_flag(TIF_NEED_FPU_LOAD))
> > 		switch_fpu_return()
> >                    wrmsrl(XFD, guest_fpstate->xfd);
> > 
> >             do {
> >                  vmenter();              // Guest modifies XFD
> >             } while (reenter);
> > 
> >             update_xfd_state();          // Restore consistency
> > 
> >             local_irq_enable();
> > 
> > and check how bad that is for KVM in terms of overhead on AMX systems.
> 
> I agree, this is how we handle SPEC_CTRL for example and it can be extended
> to XFD.  We should first do that, then switch to the MSR lists.  Hacking
> into schedule() should really be the last resort.

Agreed as well.

> >            local_irq_enable();     <- Problem starts here
> > 
> >            preempt_enable();	   <- Becomes wider here
> 
> It doesn't become that much wider because there's always preempt notifiers.
> So if it's okay to save XFD in the XSAVES wrapper and in
> kvm_arch_vcpu_put(), that might be already remove the need to do it
> schedule().

Assuming AMX can be accessed from (soft) IRQ context, hooking the preempt notifiers
isn't sufficient.  That's also why KVM waits until IRQs are disabled before
handling TIF_NEED_FPU_LOAD.
