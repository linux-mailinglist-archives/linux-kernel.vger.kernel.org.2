Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5D037317D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhEDUhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbhEDUhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:37:12 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0B0C06138A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 13:36:14 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id m190so35470pga.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 13:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u5wx41z50pCB3+EhCZHMkwVSScXyhuneIJqUcIw0yxo=;
        b=X50cSRFP/zhaGlqtpXk5ERLSQ3V/fLVmzPvQ0svEtG42GKZ5bZU0Otm9tX8X16D/6R
         tH7kkO25tK5gE32+2NETMJz713wkX1slowKJj5HLN5ZLm1O9SMAKKW4eGoHHjH+/Yx6n
         GPwLScjAKKkrsQhVeJWB2s84UkF4Ahqk+/v9PPWRm+X8PsRn1jedNhyfkuvGpeP/uPQU
         flxq3h+cjEgq3FuMZuBgqOIXb9UtcANXI3RaJ0XgCMBG9EqYpLyCpQ4H8+2IL0iTdlS6
         gZouv77UQEyjiRAefIG+qoJBOUhs/ULQIcQaDR0qDKfu2rDtAFnQA8OmKZcusmOD8Swh
         sYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u5wx41z50pCB3+EhCZHMkwVSScXyhuneIJqUcIw0yxo=;
        b=d+UAP6GRoM7vHVupSyI1KcP4V357XlWJun0idlN87JSjLC4DzEAED5Hgq31B0SgEb9
         JLR3+K04YOy3uZegJPC6od93cG/XAzf+Bl0SBtmQlp4i9pSGMYOxhtzppQ6eJDm0rQOH
         Wh1sx5qCiyttwCraS91KomErxtzrgJ/JQdeATThfIKwtYrtuVO5GiOkvhH1AZSvlXRhz
         tFUUR0ae/H4faleimNSQK51Yro1lSE8QwWij2CqYN94Q9Z7W9+aLqEAF95eFIwmvQsnc
         yonI4QG1htN09gW6Vt/8PsutOLxd053cljaCL/QsMkPg5V71AddRzk7TCKAhMF4tjRo3
         YqRA==
X-Gm-Message-State: AOAM531DMHmYMHAadDVieXSCyBt1kFrLMyzqhXti9tI4WJUzyGQ/O6bf
        DjtwC/M29yjlAtURMa8xzouriQaIx+42Gg==
X-Google-Smtp-Source: ABdhPJyED65rMQLUeYEl+sOxFJ98lFAokv9/xtsH+mYINfeH+YUCj0/ep3IgwticVbBLKeZPTFNnpg==
X-Received: by 2002:a63:5757:: with SMTP id h23mr7111744pgm.279.1620160574215;
        Tue, 04 May 2021 13:36:14 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id v123sm12979793pfb.80.2021.05.04.13.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 13:36:13 -0700 (PDT)
Date:   Tue, 4 May 2021 20:36:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH v2 1/7] KVM: x86/mmu: Track if shadow MMU active
Message-ID: <YJGwOfzTtj4kJIVp@google.com>
References: <20210429211833.3361994-1-bgardon@google.com>
 <20210429211833.3361994-2-bgardon@google.com>
 <YJGmpOzaFy9E0f5T@google.com>
 <edfadb98-b86e-6d03-bdfc-9025fac73dee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edfadb98-b86e-6d03-bdfc-9025fac73dee@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021, Paolo Bonzini wrote:
> On 04/05/21 21:55, Sean Christopherson wrote:
> > But, I think we we can avoid bikeshedding by simply eliminating this flag.  More
> > in later patches.
> 
> Are you thinking of checking slot->arch.rmap[0] directly?  That should work
> indeed.
> 
> > > -	kvm_mmu_init_tdp_mmu(kvm);
> > > +	if (!kvm_mmu_init_tdp_mmu(kvm))
> > > +		activate_shadow_mmu(kvm);
> > Doesn't come into play yet, but I would strongly prefer to open code setting the
> > necessary flag instead of relying on the helper to never fail.
> > 
> 
> You mean
> 
> kvm->arch.shadow_mmu_active = !kvm_mmu_init_tdp_mmu(kvm);
> 
> (which would assign to alloc_memslot_rmaps instead if shadow_mmu_active is
> removed)?  That makes sense.

Ya, that or:

	if (kvm_mmu_init_tdp_mmu(kvm))
		kvm->arch.memslots_have_rmaps = true;

I don't have a preference between the two variants.
