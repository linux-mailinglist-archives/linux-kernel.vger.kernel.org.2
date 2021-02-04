Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A505330EA0E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 03:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhBDCUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 21:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbhBDCUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 21:20:19 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B376C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 18:19:39 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id a16so922359plh.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 18:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bI15oVQgc1lFGULeaCog8tE69ZYTPzxNtQA/R861SRY=;
        b=Ul6QJPOqgKCpkIj2uU3Ya196bFz7RuWWlxzfr/nMwlbTiEGDHGVJTmdhE83/bPxc84
         6J3JrRSXI8eEVh+dxZ1/9JzGIz+k5HZQn4NAzVeTnMx3iG/wLMNk/T8mM3jmPkrKSwWi
         canJoZNADlCZC/y6Ej4WVzdIU5Vmb4YIbQCuuh1Cv/kDcze5rxHO0wd4iZIhF1oZS97J
         jgaeP/ZYjTSP1vXp6b7p7Wi3rUkb7ZN6x8FCp89VRtGctCyV5gg1LlkcefV48s6qHRPL
         bdE5ZIgnyhgsnAMnR+YoPYVZ7pDOBP2BkEBOhzBTi6kW1q75dsEAFi1w9eHRS7bDiATT
         s2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bI15oVQgc1lFGULeaCog8tE69ZYTPzxNtQA/R861SRY=;
        b=apVmiEgNocg6rpkwrk2qcc6wBQ+SRRx2oAqoU8/ZDp0302h9Q6wNWdYWn7+b37lu5y
         HbWqQCAI2LQl+fpcU72LxdR6E5bJQC3AhjUKuQsNxX3BUBWQIpHdgcSGMMhHTV1+n2ZC
         /eCJ1nDhxnvWGLvTcYLCui3DPdkX5ZUA6pr8z6nHa6t2ZI5GgF6sIlIDDXsDD20yIKGx
         Uce+2vOETXaubktuSHZGK0VydYlLdOCIhF5zl1yjej2Qul2ne8v1iQhxzIoP/phmRWoF
         FQI4zWjFQWDJwNKPH5M/e0cQ05Ox9eFhK4xn7i9poYfX1DaT898li4uMThoZAESPEelL
         xAig==
X-Gm-Message-State: AOAM532vWp48HX2ItHQWNj5Mkv5P7G0a55PAY9Jkiejwn1nVLoc4T/1b
        jNymywl5WiCu18LphhrCdjT/Fw==
X-Google-Smtp-Source: ABdhPJypw/YUgiSi5ZA2WhWPE4I6mYx08kPE1EXRXSSrf4FwN3n6GhJer5RMDpiqQP5ClCUruKsa0w==
X-Received: by 2002:a17:90b:4c85:: with SMTP id my5mr6184510pjb.225.1612405178717;
        Wed, 03 Feb 2021 18:19:38 -0800 (PST)
Received: from google.com ([2620:15c:f:10:a9a0:e924:d161:b6cb])
        by smtp.gmail.com with ESMTPSA id u26sm3497603pfm.61.2021.02.03.18.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 18:19:38 -0800 (PST)
Date:   Wed, 3 Feb 2021 18:19:31 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>
Subject: Re: [PATCH 07/12] KVM: x86: SEV: Treat C-bit as legal GPA bit
 regardless of vCPU mode
Message-ID: <YBtZs4Z2ROeHyf3m@google.com>
References: <20210204000117.3303214-1-seanjc@google.com>
 <20210204000117.3303214-8-seanjc@google.com>
 <5fa85e81a54800737a1417be368f0061324e0aec.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fa85e81a54800737a1417be368f0061324e0aec.camel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021, Edgecombe, Rick P wrote:
> On Wed, 2021-02-03 at 16:01 -0800, Sean Christopherson wrote:
> >  
> > -       unsigned long cr3_lm_rsvd_bits;
> > +       u64 reserved_gpa_bits;
> 
> LAM defines bits above the GFN in CR3:
> https://software.intel.com/content/www/us/en/develop/download/intel-architecture-instruction-set-extensions-programming-reference.html
> 
> KVM doesn't support this today of course, but it might be confusing to
> try to combine the two concepts.

Ah, took me a few minutes, but I see what you're saying.  LAM will introduce
bits that are repurposed for CR3, but not generic GPAs.  And, the behavior is
based on CPU support, so it'd make sense to have a mask cached in vcpu->arch
as opposed to constantly generating it on the fly.

Definitely agree that having a separate cr3_lm_rsvd_bits or whatever is the
right way to go when LAM comes along.  Not sure it's worth keeping a duplicate
field in the meantime, though it would avoid a small amount of thrash.

Paolo, any thoughts?
