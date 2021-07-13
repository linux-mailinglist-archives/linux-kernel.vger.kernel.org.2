Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894243C7822
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 22:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhGMUsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 16:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhGMUsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 16:48:43 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8383C0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 13:45:52 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h4so22612229pgp.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 13:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eQX4kZnsLTyg7teV0XbJWRhjVPkHV+0yk2IpmzFd8ms=;
        b=RGhls4yq6tFoTm/Xjmjres/ZZ6a9ARR4qMBHONUr6+qg7imnynLE2R9mR+cwfIoXm9
         gtwqRV9hcDquUdbhIJzZgj3+N1gJKnZqsDYU5umnmNcqe5k/+ZCkFc7OSaDsJdADcU19
         AorUUQK2Dqrsy4vEeE5YUHYsaGbnSqL3zMLATx2AWjxUHyTbMCuGlf1BdvYGQfVB/MNC
         PKRXJ9bi8ljuXXxRFBHsOZDjsUUJhEPx73P/kabj00kWC/LC71vB1yaL6P9Yb5o7o6ao
         qoyHj0GcNM54fRr3d7rWi+7RGLKwEZX1Dl045nGqBuLiDm3G2irY3RSGDa52B/rryWa7
         UkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eQX4kZnsLTyg7teV0XbJWRhjVPkHV+0yk2IpmzFd8ms=;
        b=KtrRMHuERhz6sFtcVpFM8VToewy4L4fc8vvfPGItPzguNojFChwEBNDmZDjOYP9tHM
         MubbP/8z8PRLTEcC9OB0om92rofnmAsaDT47CuMhpdf+mwhyAOfDUDun7Szyj8v868vh
         KPPa+iV7M6suBX1QveevVFYwIthocMNbufyQp8DmN9/VfHwew/1FVpOgStXvwGpAGGWM
         lXyCp7XVbJ+fr1Fq8aJ0Um9mM7Og7v7MWhGvPBZEnVDb4sAf2HaBxYJNzGAvB0IrWqdE
         oUYD/qeu8EJ5y6+Wh0BgLw+rxtAUn0rEZLY9+JW4sr5OmAsHm0WoVtOzesY/kd8+PQqh
         NDJA==
X-Gm-Message-State: AOAM532QpZCoYYvUMJKyFz5cQvjBnXjnGvQ4bHmd3ZBP0cHSmkAz3Q1d
        6Mcfqu2dncV1L9SZmWELZSJtbg==
X-Google-Smtp-Source: ABdhPJxflGK9WxEcu/h2vs+/KkCJ0jsMv1UYctADE9K1Hof7R+4DlRUb7WeQaiAYK/v6e3ZJRaVDfA==
X-Received: by 2002:a63:5a5b:: with SMTP id k27mr6009568pgm.74.1626209152218;
        Tue, 13 Jul 2021 13:45:52 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w10sm7006820pgl.46.2021.07.13.13.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 13:45:51 -0700 (PDT)
Date:   Tue, 13 Jul 2021 20:45:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        isaku.yamahata@gmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC PATCH v2 63/69] KVM: VMX: Move .get_interrupt_shadow()
 implementation to common VMX code
Message-ID: <YO37fMf/verI0QYR@google.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <11a3389da6184785b238b0d5a7f60279aa0a93b1.1625186503.git.isaku.yamahata@intel.com>
 <3343767a-f7b3-715b-8d99-9821a458a708@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3343767a-f7b3-715b-8d99-9821a458a708@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021, Paolo Bonzini wrote:
> On 03/07/21 00:05, isaku.yamahata@intel.com wrote:
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index d69d4dc7c071..d31cace67907 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -1467,15 +1467,7 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
> >   u32 vmx_get_interrupt_shadow(struct kvm_vcpu *vcpu)
> >   {
> > -	u32 interruptibility = vmcs_read32(GUEST_INTERRUPTIBILITY_INFO);
> > -	int ret = 0;
> > -
> > -	if (interruptibility & GUEST_INTR_STATE_STI)
> > -		ret |= KVM_X86_SHADOW_INT_STI;
> > -	if (interruptibility & GUEST_INTR_STATE_MOV_SS)
> > -		ret |= KVM_X86_SHADOW_INT_MOV_SS;
> > -
> > -	return ret;
> > +	return __vmx_get_interrupt_shadow(vcpu);
> >   }
> >   void vmx_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
> > 
> 
> Is there any reason to add the __ version, since at this point kvm_x86_ops
> is already pointing to vt_get_interrupt_shadow?

Yeah, no idea what I was thinking, the whole thing can be moved as is, just need
to delete the prototype in vmx.h.
