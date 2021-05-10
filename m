Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B071C3792B2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbhEJPaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbhEJP3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:29:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F5EC06124F
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 08:13:59 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gq14-20020a17090b104eb029015be008ab0fso10242549pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Y1KdAD1SHJv1YNjWpRn+4bVw4mSZfD7sO0/DVapSfM=;
        b=HV5vHRW6IBGVG1j476M254EywlT6j6j7J8qWfdR5X1n3+SMZZ/zXuWJ9qDKS1xaaS0
         hHRlHR+Eazz+aw5M5vAtvnWo2D38f7dVSj2F6jEJFt+QjcZAGeGY3njt2ETSyK1p4W0l
         UkgGCTnmIdZci2ZxnGU7NpHCypwG0aGE7JPucbO6ldx11T+hc9t7MMo2EUOML8Vg8/Uv
         R28HaHOy7/T7lKn6f63XmLrYydwjve8ftgbgsuztnCVpERie9HKG7ptDYcCJaWpOitpw
         vMVEbAz51nhVa0rKO44TsfB3mBeIpFXT61NU3oy9VNi8wl+/2v+njiL/AmATrNCmTb9V
         vs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Y1KdAD1SHJv1YNjWpRn+4bVw4mSZfD7sO0/DVapSfM=;
        b=WD3AUGDEClpWTWEDHFdn79iFacuACMuEm7IUrgOccj5+FmrD7PxCrbY3PkJ05nT+H+
         1rEyv56K+P4zBZ1C1jcb+CjvWYRkN34YEfSKQtFkwAFSc6zlpLJsEPJnk8LCXnkqAED0
         eTKV9Wz5++a6Js2x0o+T0I9CNmYeMG46tyMEaEmoEfQYQmVSxoluwSc7/rLl3EJfawjw
         PsU7FPdLAx9F2UsJve4XEif7txQ3nu4oRpJWkmqCZQXt2onpxD2KKYfpFre1VzmWN1eZ
         rFaOa3ryJWjaABS3PrI46tIBSppxEk4MOCKwybIy239m6sXRD+wcU1rFw+zPlaHgE9Kq
         pfJQ==
X-Gm-Message-State: AOAM530bQQSlXIvLvm+4t6ADpDFMWsb4rUF9IhTrFSkycxEUf9JrqDbq
        nbtCFr091rVxw38pNbVCMDlhOg==
X-Google-Smtp-Source: ABdhPJxwrdO4H1zGRZa2R82VK975IkIJ+LPRnF+U/P64bASwOPcwnpG0CsKzMuBRfuMyTzBLNNkpvw==
X-Received: by 2002:a17:902:7b82:b029:ee:f548:2a18 with SMTP id w2-20020a1709027b82b02900eef5482a18mr13850290pll.75.1620659639229;
        Mon, 10 May 2021 08:13:59 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id b21sm11012376pfl.82.2021.05.10.08.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:13:58 -0700 (PDT)
Date:   Mon, 10 May 2021 15:13:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH 08/15] KVM: VMX: Configure list of user return MSRs at
 module init
Message-ID: <YJlNsvKoFIKI2V/V@google.com>
References: <20210504171734.1434054-1-seanjc@google.com>
 <20210504171734.1434054-9-seanjc@google.com>
 <db161b4dd7286870db5adb9324e4941f0dc3f098.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db161b4dd7286870db5adb9324e4941f0dc3f098.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021, Maxim Levitsky wrote:
> On Tue, 2021-05-04 at 10:17 -0700, Sean Christopherson wrote:
> > @@ -6929,18 +6942,10 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
> >  			goto free_vpid;
> >  	}
> >  
> > -	BUILD_BUG_ON(ARRAY_SIZE(vmx_uret_msrs_list) != MAX_NR_USER_RETURN_MSRS);
> > +	for (i = 0; i < vmx_nr_uret_msrs; ++i) {
> > +		vmx->guest_uret_msrs[i].data = 0;
> >  
> > -	for (i = 0; i < ARRAY_SIZE(vmx_uret_msrs_list); ++i) {
> > -		u32 index = vmx_uret_msrs_list[i];
> > -		int j = vmx->nr_uret_msrs;
> > -
> > -		if (kvm_probe_user_return_msr(index))
> > -			continue;
> > -
> > -		vmx->guest_uret_msrs[j].slot = i;
> I don't see anything initalizing the .slot after this patch.
> Now this code is removed later which masks this bug, 
> but for the bisect sake, I think that this patch 
> should still be fixed.

Egad, indeed it's broken.  I'll retest the whole series to verify the other
patches will bisect cleanly.

Nice catch!
