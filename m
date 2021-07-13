Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F933C7853
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 22:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhGMVAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 17:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbhGMVAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 17:00:48 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44418C0613EE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 13:57:58 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g4-20020a17090ace84b029017554809f35so2056615pju.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 13:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1DqW0KvhYSIK42zC7O5KI/TTNeM/zzYloShAYV2CzpE=;
        b=eWyy0jddXtN29MpB2D2HVwuG3z4IKomgwIsIgLyaih5fTxUChd13N0JRqGOH80TUV+
         WtqjwGggJAMvnUEwcpeOUkWoICip1CFGD6LSbIFPQ+wQDcOTBSZGeJgdu0so8TLAuQCw
         oHmKKJAgNUnMBXm4STr7NZLHun8HTh6onEXkPPMIj1AZVA3wPrmK32lV7O5UckRUb1XD
         AtVCkzcbSJxZBStCGdGEtsIi7kZkgRq/EyKjVjlA+ASpzY3kMPEyHObTlEUF1UhOXWC1
         Dpc6t6V9iaEwfyb6IENuWGS/42LpLBpiqEfkPie3xpwF0fn/zPrKcoUu3w/T0kVE/AmE
         NouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1DqW0KvhYSIK42zC7O5KI/TTNeM/zzYloShAYV2CzpE=;
        b=h6/GJXdLxa7ppgub9mRLiQNAnL02rvQuALIiC+M7ZSwjwHLAafRLeqMv1OQScLAUo1
         A47Fs8H8NzMe/EjRRz+IWgbxo18lSqT+Mx26GcCZplDt8w5PTB+Vgl7dk5VHjh8kplxR
         ubBeLXz8bSrLsGBLOUl0EpCVfh/njep7eISd8O/fLpP9BTh00Cv/z6f8taELXO+u6MAI
         Pt1xcx8mBVqXfXxmrO37aOyutW7HpvK5+WLTRg5ya0uET5VKr+QiNZtELHhRN2vEVbWE
         qZ1JAO+1Ya4JU9iOOOo/XKwMr2ZlL26NAsp36HDeLTe4Brln3RxyF5pKOjziVaAzF/0A
         Ed5Q==
X-Gm-Message-State: AOAM532flJIq5fRCicyQqPc4WYCnCgGsYJkY7iUu8VWFweCS2+O/FbC/
        MTlBg41cPyf2Y7eDwPsb7zBREg==
X-Google-Smtp-Source: ABdhPJwSZs/McCYhg/hhS8WKfqryjNr8b0GDcFuBCWzj9pFrQyNjwnmRhy2UDrMeRnVoncYXBv7KMg==
X-Received: by 2002:a17:902:8ec4:b029:129:7649:87b7 with SMTP id x4-20020a1709028ec4b0290129764987b7mr4881431plo.23.1626209877658;
        Tue, 13 Jul 2021 13:57:57 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m24sm6619pgv.24.2021.07.13.13.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 13:57:57 -0700 (PDT)
Date:   Tue, 13 Jul 2021 20:57:53 +0000
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
Subject: Re: [RFC PATCH v2 52/69] KVM: VMX: Split out guts of EPT violation
 to common/exposed function
Message-ID: <YO3+UTNfbxdKNCJt@google.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <8e246d479e8986172d19704ef4ef4d2b666d5ac1.1625186503.git.isaku.yamahata@intel.com>
 <6e129879-bb76-622e-19a9-afb62fcf864b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e129879-bb76-622e-19a9-afb62fcf864b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021, Paolo Bonzini wrote:
> On 03/07/21 00:04, isaku.yamahata@intel.com wrote:
> > +static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
> > +					     unsigned long exit_qualification)
> > +{

...

> > +}
> > +

...

> > @@ -5379,7 +5356,7 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
> >   	if (unlikely(allow_smaller_maxphyaddr && kvm_vcpu_is_illegal_gpa(vcpu, gpa)))
> >   		return kvm_emulate_instruction(vcpu, 0);
> > -	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
> > +	return __vmx_handle_ept_violation(vcpu, gpa, exit_qualification);
> >   }
> >   static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
> > 
> 
> This should be in main.c, not in a header (and named
> __vt_handle_ept_qualification).

Yar, though I'm guessing you meant __vt_handle_ept_violation?
