Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732C642319F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbhJEUXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:23:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235947AbhJEUXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633465311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pkWw02S1GzmyKKu8izkPkaiuAJwfLFlPVE9ao+BtAv0=;
        b=XERVEiBvubH7+WqK2kwzHNWSPKEEc9j9rZLUoT7tbWkGiOVp7DCCE4iSP+J8YW0UrrgOMn
        6fXRmQwmmYBuGE1VJ1cUu5aeACps3/V++YF++QlTjGhGSmN/YJlGQBZqfv/kXUwWcAN/tg
        cNLLLFtShPmhf1ixEcrSpgKR/PC+QaE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-fFiVlLh-OFCmKU09BWSXWA-1; Tue, 05 Oct 2021 16:21:50 -0400
X-MC-Unique: fFiVlLh-OFCmKU09BWSXWA-1
Received: by mail-qk1-f200.google.com with SMTP id m1-20020a05620a290100b0045e5e0b11e6so125566qkp.23
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pkWw02S1GzmyKKu8izkPkaiuAJwfLFlPVE9ao+BtAv0=;
        b=kPot0onsxdkjryTVTA0J/lmWDHQLnkDUWEYc9QskjeKlSZWbbhqvJK452hZyDCZRA1
         z3+XsH8aXx6RJadMhaj/8b1Y0dKxzcANtsERGoE0pr5BSRYdoZte63PXLrhnwp2USllI
         IJY+T9lLW7KxsxNJzBUYYrQagPNQSSs1xw/YZFY0B9ckcV9GPeh22re+F3DjILjmRL48
         6epTCybpF3Ez5lKX+y08EA0JBC+lPGjzqg0VvBTWiDm7T10gDIQ13qtEhdJ3a33w2Jr2
         U4kSm+lePPVeqUjqFOZcPjjzqP0BF9eSnDe2IPMIZbj05fSEfmGEcdx2O42ai9tywk1o
         k4VQ==
X-Gm-Message-State: AOAM530vJkpcSaSWbPdSpQktzHjb6G779na7gNYUmdi/g2db2QL/BB96
        gSjkOjCsR9PSf16D/hzPhqBQEM6q4tmS/wE0ZDtifRdWKbyiGPi6XnNGvdUEI/DqmZD2ix88eL9
        iHQmD5QLk5hT+o18TY6xj75gB
X-Received: by 2002:a37:e93:: with SMTP id 141mr16428894qko.132.1633465310327;
        Tue, 05 Oct 2021 13:21:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwu5a/lUk25783+7Qo+0nCkRrXeECton31JCntW+m62zu3q4LXFlmRn31Ljf/FhLXVcyRwNig==
X-Received: by 2002:a37:e93:: with SMTP id 141mr16428875qko.132.1633465310109;
        Tue, 05 Oct 2021 13:21:50 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id r19sm1012176qtc.55.2021.10.05.13.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:21:49 -0700 (PDT)
Date:   Tue, 5 Oct 2021 13:21:46 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config option
Message-ID: <20211005202146.s3ptxhabwyz3nacm@treble>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <cf33750f-615a-1edd-0fee-28e720bb38ce@infradead.org>
 <CAC41dw-U85dCGDm_QzyyOQfhbbaZZ5m9CvLuDjdXjuxEyid8qw@mail.gmail.com>
 <YVxdhtRbJfd9feA4@zn.tnic>
 <ba068e29-aefd-8e78-48e0-5431abd93f31@linux.intel.com>
 <YVyLaLTK6MgLi/rS@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YVyLaLTK6MgLi/rS@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 07:29:12PM +0200, Borislav Petkov wrote:
> On Tue, Oct 05, 2021 at 07:48:25AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> > Since x2APIC will always exist in TDX guest case, we have used select to
> > enable the support. But since we have dependency on it, I  think "depends"
> > might be a better choice.
> 
> Right, and while we're on the subject, this looks silly to me too:
> 
> +       depends on SECURITY
> ...
> +       select SECURITY_LOCKDOWN_LSM
> 
> because
> 
> Symbol: SECURITY_LOCKDOWN_LSM [=n]
>   │ Type  : bool
>   │ Defined at security/lockdown/Kconfig:1
>   │   Prompt: Basic module for enforcing kernel lockdown
>   │   Depends on: SECURITY [=n]
> 		  ^^^^^^^^^
> 
> so that symbol already depends on SECURITY.
> 
> And I have SECURITY=n in my config so I still have to go select SECURITY
> by hand so that CONFIG_INTEL_TDX_GUEST becomes visible. And when I
> select it, SECURITY_LOCKDOWN_LSM gets enabled too.
> 
> But since I have to go select SECURITY, I can just as well enable
> SECURITY_LOCKDOWN_LSM in order to have TDX guest support.
> 
> IOW, I don't see the point for the evil "select"s - just make everything
> depends on and be done with it.
> 
> Unless there's an aspect I'm missing...

It would also be helpful to explain the dependencies (particularly
X86_X2APIC and SECURITY_LOCKDOWN_LSM) in the commit message.

-- 
Josh

