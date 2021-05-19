Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087CB3895C5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 20:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhESStO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 14:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhESStK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 14:49:10 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8FCC061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 11:47:51 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id l70so10106421pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 11:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jsZ/ogGdK7ONzFDyLTBWnJutfIfdTiTEe+CqEIq+g4w=;
        b=wUvDXi9VP0MO3xZHoCWYzzauHfGA9Pj8v++JGlseU33ryljXJRW2C6jM5nNgmYIVur
         WB3bkEN/yB/bHHzRoujUd5eYTV0ooyAexFSkoyO2WGopoPcnXYc7FwKXF+YRNKxkAK1e
         Y7IQhL0/NI/6l0AdDYkqYRX2wKurf3X/RMVL1KGMQ2kge9kvpqUvFKZ59GIxy4hfP8N+
         7i1JL8fG1cqh0pF2Fr+zmy5R3tqpkDjMyb/xCudbBnw9xpjvbvs6oSveeH/unNnIKwMh
         s4dlREP9cIp7iAFoGIbCVvDVsw3H9/V94yW90Mzjbx6S0Is0bdifq6nrLFqP6esy22eO
         PULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jsZ/ogGdK7ONzFDyLTBWnJutfIfdTiTEe+CqEIq+g4w=;
        b=ajW6INL7Nsfwjzs/vhrljK7XTczQlF8W1jS2ew5iQ0vPlfcx11alusDTG+hLIbJhOD
         VTBrkk9EkjtPn5JjV0vV5EhT+84l16WIMzuiburtc5UpU6GBXAT1o+dMHM7P8N46vBE5
         qnslmzwlcKqj/VdvYrgnhjbnHuz5R7/tcpTJrf5h/mM0/6flKRA86sNwhRYiA1SgwCGO
         FEvTM4FA98l/SoqWZ3QIN3N0eydztRp2OCLLv6IaUGv0BJSRPDT6AHvGk0g2DtHL/ccY
         Gk8hVKX1Fq1u5M8AZ8Or43QGqlc8uAft4Zhmm2OjuhKBuaY8DgL8jdRKRAORm9ba+w/G
         GI3g==
X-Gm-Message-State: AOAM533mBV7YGiUP5iFrwYAl6wxOrjQpOAfsSyLYwFFZkjalzlkPpDCC
        YdWbgcFWTtuw7QwZaHo3wb9b8g==
X-Google-Smtp-Source: ABdhPJwlTLgCCUmWjaZgts4TPHmgsBjfkqKSJPsie9lBoJinAjfPXoaOwO9i/FV3jV4NP2fYk1OfDA==
X-Received: by 2002:a05:6a00:22c1:b029:2dc:edbe:5e9 with SMTP id f1-20020a056a0022c1b02902dcedbe05e9mr438875pfj.51.1621450070464;
        Wed, 19 May 2021 11:47:50 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id n21sm130697pfu.99.2021.05.19.11.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 11:47:49 -0700 (PDT)
Date:   Wed, 19 May 2021 18:47:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Reiji Watanabe <reijiw@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/43] KVM: VMX: Set EDX at INIT with CPUID.0x1,
 Family-Model-Stepping
Message-ID: <YKVdUtvSg7/I7Ses@google.com>
References: <20210424004645.3950558-1-seanjc@google.com>
 <20210424004645.3950558-3-seanjc@google.com>
 <CAAeT=FyNo1CGvnamc3_J9EEQUn6WcdkMp50-QgmLYYVCFA2fZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeT=FyNo1CGvnamc3_J9EEQUn6WcdkMp50-QgmLYYVCFA2fZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021, Reiji Watanabe wrote:
> > @@ -4504,7 +4505,11 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
> >
> >         vmx->msr_ia32_umwait_control = 0;
> >
> > -       vmx->vcpu.arch.regs[VCPU_REGS_RDX] = get_rdx_init_val();
> > +       eax = 1;
> > +       if (!kvm_cpuid(vcpu, &eax, &dummy, &dummy, &dummy, true))
> > +               eax = get_rdx_init_val();
> > +       kvm_rdx_write(vcpu, eax);
> 
> Reviewed-by: Reiji Watanabe <reijiw@google.com>
> 
> For RESET, I assume that rdx should be set by userspace
> when userspace changes CPUID.0x1.EAX.

Ya, although the ideal solution is to add a proper RESET ioctl() so userspace can
configure the vCPU model and then pull RESET#.

> BTW, I would think having a default CPUID for CPUID.(EAX=0x1) would be better
> for consistency of a vCPU state for RESET.  I would think it doesn't matter
> practically anyway though.

Probably, but that would require defining default values for all of CPUID.0x0 and
CPUID.0x1, which is a can of worms I'd rather not open.  E.g. vendor info, basic
feature set, APIC ID, etc... would all need default values.  On the other hand,
the EDX value stuffing predates CPUID, so using 0x600 isn't provably wrong, just
a bit anachronistic. :-)

