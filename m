Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5BB4246B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbhJFTgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239377AbhJFTgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633548886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x7PJpkoqOXRnnq6BuAxUmUUioNSk1/jMjBh6/To47EU=;
        b=S2Ngx6/Rf8ITbnAk3naIEyE+SDhl6H+jLUKVHa92WrLJ/mcclHkajU5BK8bAMgBq4tfE9T
        wOQNe+KNnKAl0mQaAutuxiirkNMZwoqgf7PfqZmSSmIeGppLYRMRrnSGda/49JDhyOOZx8
        Pw2LrvMTweLFfFdLqXAKc5XKTjXLhcI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-_NwhPMePPd2wS2NsI9_LDQ-1; Wed, 06 Oct 2021 15:34:46 -0400
X-MC-Unique: _NwhPMePPd2wS2NsI9_LDQ-1
Received: by mail-qt1-f200.google.com with SMTP id s10-20020ac80d8a000000b002a753776238so3063410qti.15
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 12:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x7PJpkoqOXRnnq6BuAxUmUUioNSk1/jMjBh6/To47EU=;
        b=hhNuaCCAFSER1SVHQoDYG5bK+JTuENvGod8hT1Avf0rqAeuZg2GJMrMj3UP1SgegXu
         u76UgUWyruUdpSqAv8nXEThYh7vQekXilAiL+km/kfu5NH7aFfFAf5m4Wi26gZ4Zo0G1
         LPVWwDXP/5U6Eyfg1VKcouf4ehErVrCkSNZ8gqR/OJnEa1+G937U25QcbZ0VEHW4pCNZ
         cNnYH6/dFJNCWccavEmhb7J7Sk9tgcebdBHbYt3eCb0eRfWDeodNl6ft8AaxBQuvA8zX
         NjyEs+dicC8+o+N0ja/5kRYtFxJGdyMAwy7QCIPgKAsjv8t2ZAilX+uOyRthjMKC1qAp
         pSfQ==
X-Gm-Message-State: AOAM531tDkQ8kzrzJNIaU0+IJCca1z3tLCyJpoc1dJRVrtkECtxhJ3gF
        9e8jlL5ZiJVgszsPi80NZfB12iJKEJreMOPmKpaWTeEjFBtraFbuCT+0Ot+lPdUN4HmPKfsztVn
        OS96Tc8U3JyzevXFeBq3Cl75H
X-Received: by 2002:a37:668d:: with SMTP id a135mr489290qkc.288.1633548885402;
        Wed, 06 Oct 2021 12:34:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbp9cAS2cuJkezXGUJKocrinG+MX6lUETfnMOYKgvWetq4/5pG9GkY++XALg3YV1nFYXT11A==
X-Received: by 2002:a37:668d:: with SMTP id a135mr489254qkc.288.1633548885110;
        Wed, 06 Oct 2021 12:34:45 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id c6sm14253619qtc.77.2021.10.06.12.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 12:34:44 -0700 (PDT)
Date:   Wed, 6 Oct 2021 12:34:40 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 08/11] x86/tdx: Wire up KVM hypercalls
Message-ID: <20211006193440.jgmagja3vynqnnis@treble>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-9-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005025205.1784480-9-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:52:02PM -0700, Kuppuswamy Sathyanarayanan wrote:
>  static inline long kvm_hypercall0(unsigned int nr)
>  {
>  	long ret;
> +
> +	if (cc_platform_has(CC_ATTR_GUEST_TDX))
> +		return tdx_kvm_hypercall(nr, 0, 0, 0, 0);

Hm, I'm still thinking that figuring out a way to convert all the
cc_platform_has() stuff to normal cpu features -- or at least inline
wrappers around them -- would be really nice here.  Then this could just
be a nice fast static_cpu_has().

-- 
Josh

