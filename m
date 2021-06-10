Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721133A2E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhFJOb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhFJOb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:31:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD23C061760
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 07:29:30 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m21so3538944lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 07:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MvpsVeT4v+qs8w/vvF442+MNQiRIgnPGMMOPxB1N4UM=;
        b=wvZenha5ehc9n1QOhCznIWzmjzi2EEB1U6vTj2YdN0geUuH5YCEuAB2bbnkmtk9gCh
         GwzywDheeUg/o/3F/6Z3hbf8yByZHh7BcC5auAZreRHR7cMIMycf2E73NHiYf/FJjmh5
         I/mjmj8MCDYHZC1OEQBqILFNPwBSM0sbzF/kwwuBY5eHI2ZsTx17drAvzu1Wv4EVnXKN
         +0e9h/HkUKtu8SBpBqbTDN7q6XzPhQ+mgi+taqES7W6h/ubXnXvStFjvzJsbPFUrSCdq
         OgPedVCcvlmPHYccxu5TeWOshsQwQBUSbo7i9fqtzuNL+FoMzO3sQ+Ge4SJEJ6X94zMs
         rODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MvpsVeT4v+qs8w/vvF442+MNQiRIgnPGMMOPxB1N4UM=;
        b=i09Anm2q8CgmRwXuyGIXyj+6LClGdnCyUai8UujwLVPc6e7pzZGE2MduEJpBfnIsnw
         SkXNsPX8LLV+R/YEzJhz/y14NvVCAyPbMT9BPtDCbOPFXDFkrRibA8vCwxfZIVkT8Sx9
         EWc7EVZLk2brwpwXqko43EQBY2EMatveYlZKZz7JygiYuQKO761x/2vy5WG0x+RKcInD
         +hzajN2qTrlQZXHSYIUhTqRPfaArjf2r6LMRHq2sXlwDdZjLYWwDEnAHcdlqVfLvd/kV
         2IxWJ3/wOfzc2UiAmNPAL8AMDAOcs58lJAmdGJhOPun1dpMkYbeXdsihLmUv+upLFAkO
         +oUA==
X-Gm-Message-State: AOAM53146fUD/FRaJFXNmoDZh9c1hNMao8NgMslPmg4gSNQ8wPHKYO50
        R47pA03vb409j7GmH15TYPxx2Q==
X-Google-Smtp-Source: ABdhPJzWOzaOYro3OInn1ETscjtiKZZYjUr18zDFJq5xf6aXhyp05i1P5SUUBidd5vCSpM699dr4Rg==
X-Received: by 2002:a05:6512:1c4:: with SMTP id f4mr2075452lfp.95.1623335368791;
        Thu, 10 Jun 2021 07:29:28 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y17sm315585lfy.14.2021.06.10.07.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:29:27 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 945741027EE; Thu, 10 Jun 2021 17:29:43 +0300 (+03)
Date:   Thu, 10 Jun 2021 17:29:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v1 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <20210610142943.uohw6nzpip5yi4no@box.shutemov.name>
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210602022136.2186759-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YMIFVh9WpDiUuRsa@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMIFVh9WpDiUuRsa@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 02:28:06PM +0200, Borislav Petkov wrote:
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index ac37830ae941..dddc3a27cc8a 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -238,6 +238,7 @@
> >  #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL hypercall instruction */
> >  #define X86_FEATURE_PVUNLOCK		( 8*32+20) /* "" PV unlock function */
> >  #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* "" PV vcpu_is_preempted function */
> > +#define X86_FEATURE_TDX_GUEST		( 8*32+22) /* Trusted Domain Extensions Guest */
> 
> What's the name of the feature bit? "TDX guest"? Why not only
> X86_FEATURE_TDX and then you can have "tdx" in cpuinfo?

No, "tdx" is host feature. It is part TDX host enabling. This feature
indicates that kernel runs within TDX guest and named accordingly.

-- 
 Kirill A. Shutemov
