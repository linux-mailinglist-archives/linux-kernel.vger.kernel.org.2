Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5A4423756
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 07:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhJFFFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 01:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhJFFFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 01:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633496597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jpUquQ+TSbcBWrdGCbweYOaUjNx4Fqghxa/0j010Ebw=;
        b=R8E0JbTwSZbbenVNosITNJ9MH50H1h4eY82i5NlvPyLqptKiFIGDqmpkTQgl4oll89Gbst
        XndgBDgzOzD3dsjuDxS3ZB2ltZFNQH9kZj7XpDeXaRXntUYhCUkbQFomug/K/NHkny6rdT
        9BfpkbmGxy3acOANzCJQ5iJ4c+gEAT0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-XDlFp0sGNMa4vz7LPlTWeg-1; Wed, 06 Oct 2021 01:03:16 -0400
X-MC-Unique: XDlFp0sGNMa4vz7LPlTWeg-1
Received: by mail-qv1-f72.google.com with SMTP id gi5-20020a056214248500b00382f7a7c7e6so1737559qvb.21
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 22:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jpUquQ+TSbcBWrdGCbweYOaUjNx4Fqghxa/0j010Ebw=;
        b=gPO6upTHBwTpTBT/Z/H+qM4V2ZSFEUeOPbKk++evL8gTWX9pm0eUXiZBUTABj0Hdz6
         6ddl9yEQYYXkoVmFKM24nomjPgktq3pYoF1BSZjxWRJthT0LLIlv6Y23Dro/FjF2Xe3J
         4VENH+6SEPlXy3JFI2a2anOKD/KpVYKtefYFdcMe0SpB+XLHbJWkjwg11kz1PWYGNElX
         aCO0+joJ/rTrR2rHk0pdjk1Wlg+ocEez6UBA7XOF7ldTVbiHRusQzUybJFobsVITU+xT
         knv11i8kSHbgteFU/kB9sCHpeG4dB4ovj3fmToaArfWkJhg1XEfhfCWMy8DeRppG2Foe
         g8bw==
X-Gm-Message-State: AOAM5314pm+Cizl1tiQz48NO/DMbjen1G1VRQmq1kmOgtNK73WpUliXY
        6NQDvXx8pKSDkXwckp/vaxMxVE9GxXCtYYly/1S9Y9OPmCEtQls1y6rTN9W+iNqKeCwX/86SJ6t
        yW9grtaijrpp3ROjXs11DAhwu
X-Received: by 2002:a37:66d6:: with SMTP id a205mr18163175qkc.138.1633496595889;
        Tue, 05 Oct 2021 22:03:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF58i/a0BwQvg07ObRSR19xQUEcvhNdFoeXrq8AUT7fQydUAOuUbV+a/MDafQBNVPh8moXbA==
X-Received: by 2002:a37:66d6:: with SMTP id a205mr18163156qkc.138.1633496595642;
        Tue, 05 Oct 2021 22:03:15 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id l195sm10881615qke.98.2021.10.05.22.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 22:03:15 -0700 (PDT)
Date:   Tue, 5 Oct 2021 22:03:09 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Kuppuswamy, Sathyanarayanan" 
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
Subject: Re: [PATCH v8 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <20211006050309.ldn5myznmpurnomm@treble>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005210423.yfftpxxmj3cjprtv@treble>
 <15a07997-2659-6be1-b8a3-da57e72562b5@linux.intel.com>
 <20211006034218.ynamwigsvpgad7sr@treble>
 <f15d1b41-e4fb-0203-88f7-dbac3f4e5307@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f15d1b41-e4fb-0203-88f7-dbac3f4e5307@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 09:33:35PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 10/5/21 8:42 PM, Josh Poimboeuf wrote:
> > > is_tdx_guest was mainly introduced to support cc_platform_has()
> > > API in early boot calls (similar to sme_me_mask in AMD code).
> > > Regarding FEATURE flag it will be useful for userspace tools to
> > > check the TDX feature support.
> > FEATURE flags can also be checked in the kernel, with boot_cpu_has().
> > Or am I missing something?
> 
> Yes, previously we have been using x86_feature_enabled() check in
> cc_platform_has() call. Now with the introduction of is_tdx_guest
> global variable, we don't use it in kernel. But I still want to
> keep the feature flag for user space use case.

I'm not suggesting getting rid of the feature flag.  I'm suggesting
getting rid of the global variable.  Is there a reason you can't check
the feature flag instead of checking the global variable?

-- 
Josh

