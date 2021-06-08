Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F4A39FE2C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhFHRvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:51:44 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:56213 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbhFHRvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:51:41 -0400
Received: by mail-pj1-f48.google.com with SMTP id k7so12356545pjf.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gdt4JghUB3/7yWBfA2YVguJPrCC6pOa4/tpNkl/xRaw=;
        b=U1mWIsbVQwUvyUewrceBoWKWWMBrOcc5Obhhmq2UySkeBn67aN8GoM+KzPFENv9d93
         AtqaX9qtmoxBnW9T0TflIGlf5xTnoslmvMgrHLWpOF/5DK1F0UGM0veB77SH5PJl1CIM
         yTf/W0K/rwx/8HsvPUYjZbHQ3ajmkYCNZXt31U7GFkFmBjWLM9Ii45fz0nZH8SIqSuuI
         5t1jUPptTKB40Jltzjhq4WjR+OwFkK7/YFW6HUdqUejLxeWg0TLt/xFeMaTdjxtpwWrb
         M45GQtOm82NZjFZPsnjbGURDqv/GHOZNws+O+W08jqwDJLkyHoh68BfeUlNBluemMRH7
         VpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gdt4JghUB3/7yWBfA2YVguJPrCC6pOa4/tpNkl/xRaw=;
        b=OSg6z3y7qv4xCm2NstN+QxWNoii7E/07HhObctL9ywdps6ERMBOu+FLmetkorSNPn3
         t4es97HwMHdemNM2ga/JWt65wStTzwYCHPVvJZboA8ffPuumHZkxp8nRZGW0sjGEfnDn
         PLahGwdinZ8CdSE5zpG3i1EmKW5yWyvfkNEnOtlhRHnB8ujOQE9TubbnhjGPh7sd6Ckk
         cxyD2sjwx1K3+JtrFhOwG24iIa9DZ1e6eWE05N5Xrq+NqYiDyo6+ujnnwgbJk7dt8JT1
         LEOP/3z9K7DM+iPupjZLh/LqOVBcL4cGHgw8zDx1qIE6qz2DCxB+/yePFmxB7dMOi//g
         Grow==
X-Gm-Message-State: AOAM530r0TGyVSSfPrIyKEhG2xckOzyLIZVt7jxsGDa7+EdNZOAXCjnz
        ml3eiEe6VEi/T2t+m5EmCyEfPg==
X-Google-Smtp-Source: ABdhPJzotGA3OBLIY8mJnF8AbWwu3glAB6D8umkDLtk5ekcf3oKfz3gCLKFNcPqDx4dkrKo1fmg9Hg==
X-Received: by 2002:a17:902:edcf:b029:10c:768:b657 with SMTP id q15-20020a170902edcfb029010c0768b657mr836025plk.56.1623174528484;
        Tue, 08 Jun 2021 10:48:48 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id h186sm11187688pfe.4.2021.06.08.10.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:48:48 -0700 (PDT)
Date:   Tue, 8 Jun 2021 17:48:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 08/32] x86/traps: Add #VE support for TDX guest
Message-ID: <YL+tfGOMWEvDJTwc@google.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <8a1d6930f784cb57c957cf20cea870947db91e05.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <fe05830e-e82b-f338-2ba1-02651cb8087e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe05830e-e82b-f338-2ba1-02651cb8087e@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021, Dave Hansen wrote:
> On 4/26/21 11:01 AM, Kuppuswamy Sathyanarayanan wrote:
> > +#ifdef CONFIG_INTEL_TDX_GUEST
> > +DEFINE_IDTENTRY(exc_virtualization_exception)
> > +{
> > +	struct ve_info ve;
> > +	int ret;
> > +
> > +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> > +
> > +	/*
> > +	 * Consume #VE info before re-enabling interrupts. It will be
> > +	 * re-enabled after executing the TDGETVEINFO TDCALL.
> > +	 */
> > +	ret = tdg_get_ve_info(&ve);
> 
> Is it safe to have *anything* before the tdg_get_ve_info()?  For
> instance, say that RCU_LOCKDEP_WARN() triggers.  Will anything in there
> do MMIO?

I doubt it's safe, anything that's doing printing has the potential to trigger
#VE.  Even if we can prove it's safe for all possible paths, I can't think of a
reason to allow anything that's not absolutely necessary before retrieving the
#VE info.
