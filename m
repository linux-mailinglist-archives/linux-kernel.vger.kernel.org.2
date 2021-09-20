Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D76E4118E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhITQMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbhITQMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:12:15 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667E3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:10:48 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w8so17837399pgf.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RHPENS35TK70dwgRtuqMxqQYFvEywydxESq3g0YeWeY=;
        b=a+D32SSgnrOzLf2jTTB3XXObCufAjGVIs0SqMoiQUV7ljWXr4dz4YtA+HOcz+prtgm
         5s8aG0yU5rTM2wmxo1wlsWi2IjIAIOCC4wS5T7rT7gl1MLstD6X4zH3J3dUDcYaSScIi
         pU9yWEXihPjBpN0472qyPrL1LIwtZEzBsxcu7521ETNdy555l/L+OPfvWyDwtrHwq3KX
         5Yy5s2XogiXel6mGab+Mgl8BANm7UD4s9PtRVksaZ5w5DICYmKnWrTmAAXHR0ky9MUUx
         +O4cfzZADqj+nhpcUB8vMDH2T6+CjBTupY76CQsuFUD2muVBVp6hp+KUgJ2PISB3B/j8
         wrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RHPENS35TK70dwgRtuqMxqQYFvEywydxESq3g0YeWeY=;
        b=yJJI5eJmEH7lZ5MLbMoNxeHAZmuTZodyBIQm0DfX600hC4ajFnEeH33wyCq4l968GX
         l0SOyhq9DwpGx1LHYYT+lN09Wfuh6msNWvtnJli8UCmAtM3+U88MPbjzACHmzL8/xhAd
         mKV3lCDI5exhntdUULXgnQyMsj5Ogp+WgVOQ3Vi8+aQIdYfxI2pe0Am/IkHq3ont8u7D
         b3oa6/SYOterD9phPk6UYKljmt+gqCPmhYvrI+PAfyIcKwKXdFWVo4z8mTM1b95X9eF1
         D0SynVSDdBNyw6FD74uMzlvEfBQyP4iPS9M1h3sK9CvOwihrfi+4JjywHj1zVEC2A4uk
         nJyg==
X-Gm-Message-State: AOAM532a1D06AziONGI/eQ5sojQhySSmhU2uxqDhlOj0pWyerkiP1BZx
        EKzje2ycJyg2rjCUXvKl7w0lyA==
X-Google-Smtp-Source: ABdhPJx5qH4XRk3aI1atwoaavXlPJ3g+FMogcSusD/ahOJ1VHNmO+V2cxDDuhPlNlaQNjZaeRkUToQ==
X-Received: by 2002:a63:7402:: with SMTP id p2mr24070517pgc.472.1632154247688;
        Mon, 20 Sep 2021 09:10:47 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j6sm15420414pgq.0.2021.09.20.09.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 09:10:47 -0700 (PDT)
Date:   Mon, 20 Sep 2021 16:10:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 1/4] KVM: SVM: Get rid of *ghcb_msr_bits() functions
Message-ID: <YUiyg1W1cDxVbgzs@google.com>
References: <20210722115245.16084-1-joro@8bytes.org>
 <20210722115245.16084-2-joro@8bytes.org>
 <YS/sqmgbS6ACRfSD@google.com>
 <YToM5akzNrlqHTJz@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YToM5akzNrlqHTJz@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021, Joerg Roedel wrote:
> On Wed, Sep 01, 2021 at 09:12:10PM +0000, Sean Christopherson wrote:
> > On Thu, Jul 22, 2021, Joerg Roedel wrote:
> > >  	case GHCB_MSR_TERM_REQ: {
> > >  		u64 reason_set, reason_code;
> > >  
> > > -		reason_set = get_ghcb_msr_bits(svm,
> > > -					       GHCB_MSR_TERM_REASON_SET_MASK,
> > > -					       GHCB_MSR_TERM_REASON_SET_POS);
> > > -		reason_code = get_ghcb_msr_bits(svm,
> > > -						GHCB_MSR_TERM_REASON_MASK,
> > > -						GHCB_MSR_TERM_REASON_POS);
> > > +		reason_set  = GHCB_MSR_TERM_REASON_SET(control->ghcb_gpa);
> > > +		reason_code = GHCB_MSR_TERM_REASON(control->ghcb_gpa);
> > > +
> > >  		pr_info("SEV-ES guest requested termination: %#llx:%#llx\n",
> > >  			reason_set, reason_code);
> > > +
> > >  		fallthrough;
> > 
> > Not related to this patch, but why use fallthrough and more importantly, why is
> > this an -EINVAL return?  Why wouldn't KVM forward the request to userspace instead
> > of returning an opaque -EINVAL?
> 
> I guess it is to signal an error condition up the call-chain to get the
> guest terminated, like requested.

Yes, but it's odd bizarre/unfortunate that KVM doesn't take this opportunity to
forward the termination info to the VMM.  The above pr_info() should not exist.
If that information is relevant then it should be handed to the VMM directly, not
dumped to dmesg.
