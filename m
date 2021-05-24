Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A0038F32C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhEXSqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhEXSqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:46:30 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEFBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:45:01 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 27so19449437pgy.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m6eGfenY2P0BaGTTnn0auyALz2UEWiGJKnP8rapZx9o=;
        b=CpZNKjfXtU+FhYiQVwTAqeTEsDhbyKFqjPSC7qd5dBiwrnFHiUZS45czjUbidCmGNs
         Wutuy/KJXrNSWKoDyodp2b7rAUqxl0dXCb3nx5I5flfcVu5g2SryUoxSqnYPILfbbMZQ
         Wq7JpGxsoSQxCk6t72iPFVxvAb3R2KWlMaVZ+S5BvE7sgH31Z4p5lHbocrXTp+ds1tyF
         B/NrPCfoMNWCqobAJ20lkJr67sP7URiJz5MTaDnD/RR9RKSRAFJtKoBqO6lZdVnfBH9V
         51uXQgRzrTX5Y1LrRkoWNl2sH3hp97V8uUF8gfBuTvuZBqbYQJTFnDPe1dd4lH+6Z59s
         Y4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m6eGfenY2P0BaGTTnn0auyALz2UEWiGJKnP8rapZx9o=;
        b=Fa+Tjt6hOr2OGspQd1JYfU5Aqzp9vk6gUZBI0d0D10qnWVxK3AX1R4Sl4AoFP9aqYa
         dQJn1pVr23BILq9OtejWPZie/g6usyZe96o2q61VEeyn1oqwB/9bpBOdDKseijR8GdXr
         qUjvHrcFv6mvOB2QNyjpXFCIOjWdTgEOGu9Jq0LYwlsTszfFxdS38d8WNOMaNWSiz33k
         KuUkS7bfsw19MTRBchh0xhfCrY54O+JI4bMqsbhbBW/2DChSCewoaphxQ7KUfKY7XBMQ
         60C4xzVpihyg6i9smZcN26bouR5612SN8MExyjTfr4rPgjKGuf9Woe/pDmXSJb+tTT+F
         ZClQ==
X-Gm-Message-State: AOAM533/RNmlks8RlUYxOsr5pE8NHylEzSwHzYHLydqFK3wsE1IEM55j
        4sm5a0Is8k4tz7I98RcOC1ZAow==
X-Google-Smtp-Source: ABdhPJyiTIuWIMMPYjg1iPzWh9JK40z272F3hx6ijUlEJdhIUXwjo9/QnNnRwq3V7urfns/JQqmGNA==
X-Received: by 2002:a05:6a00:26d4:b029:2df:87f2:fcc4 with SMTP id p20-20020a056a0026d4b02902df87f2fcc4mr26477272pfw.20.1621881901114;
        Mon, 24 May 2021 11:45:01 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id o187sm2070349pfg.129.2021.05.24.11.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 11:45:00 -0700 (PDT)
Date:   Mon, 24 May 2021 18:44:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Ilias Stamatis <ilstam@amazon.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, zamsden@gmail.com, mtosatti@redhat.com,
        dwmw@amazon.co.uk
Subject: Re: [PATCH v3 09/12] KVM: VMX: Remove vmx->current_tsc_ratio and
 decache_tsc_multiplier()
Message-ID: <YKv0KA+wJNCbfc/M@google.com>
References: <20210521102449.21505-1-ilstam@amazon.com>
 <20210521102449.21505-10-ilstam@amazon.com>
 <2b3bc8aff14a09c4ea4a1b648f750b5ffb1a15a0.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b3bc8aff14a09c4ea4a1b648f750b5ffb1a15a0.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021, Maxim Levitsky wrote:
> On Fri, 2021-05-21 at 11:24 +0100, Ilias Stamatis wrote:
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 4b70431c2edd..7c52c697cfe3 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -1392,9 +1392,8 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
> >  	}
> >  
> >  	/* Setup TSC multiplier */
> > -	if (kvm_has_tsc_control &&
> > -	    vmx->current_tsc_ratio != vcpu->arch.tsc_scaling_ratio)
> > -		decache_tsc_multiplier(vmx);
> > +	if (kvm_has_tsc_control)
> > +		vmcs_write64(TSC_MULTIPLIER, vcpu->arch.tsc_scaling_ratio);
> 
> This might have an overhead of writing the TSC scaling ratio even if
> it is unchanged. I haven't measured how expensive vmread/vmwrites are but
> at least when nested, the vmreads/vmwrites can be very expensive (if they
> cause a vmexit).
> 
> This is why I think the 'vmx->current_tsc_ratio' exists - to have
> a cached value of TSC scale ratio to avoid either 'vmread'ing
> or 'vmwrite'ing it without a need.

Yes, but its existence is a complete hack.  vmx->current_tsc_ratio has the same
scope as vcpu->arch.tsc_scaling_ratio, i.e. vmx == vcpu == vcpu->arch.  Unlike
per-VMCS tracking, it should not be useful, keyword "should".

What I meant by my earlier comment:

  Its use in vmx_vcpu_load_vmcs() is basically "write the VMCS if we forgot to
  earlier", which is all kinds of wrong.

is that vmx_vcpu_load_vmcs() should never write vmcs.TSC_MULTIPLIER.  The correct
behavior is to set the field at VMCS initialization, and then immediately set it
whenever the ratio is changed, e.g. on nested transition, from userspace, etc...
In other words, my unclear feedback was to make it obsolete (and drop it) by 
fixing the underlying mess, not to just drop the optimization hack.
