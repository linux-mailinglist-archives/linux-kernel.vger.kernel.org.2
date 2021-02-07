Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47993312768
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 21:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBGU36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 15:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBGU34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 15:29:56 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662FDC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 12:29:16 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id q12so19038033lfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 12:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9sjBuurXuCRLTK7WBgtpDGv+6PLRJ/KauaGTkl6DnYA=;
        b=epWcFHVc2LXA+n9fYEyvBJuVljCuMGaWTK02BvCBbwqQKVGO/LQde7vvIlJswMCcR8
         aJvPxjbcit3r8KPHxtKmIzzUw++F3c9PGnR13C/c4Ih5sUxsHQBUT/Pfo645HlH5opD+
         pz8gTWWrt1HO5XMgzcIl59xiq9i8N1f95TEKb/O9pTMIGY1T/M9dXBNXWM1eEGJrpGpF
         UcD388HuT9A/JJPqTWhIDDTuP1Ipuk1blqyobFRlcvt+EvuXcqPhbBeM/Ya2LegRd7aS
         6rjdeAsNbsPy31tpJCtIXzlhLXCMbv+YUov44rzzj4EENJVtVv8b74eH+C3306AOMus+
         KOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9sjBuurXuCRLTK7WBgtpDGv+6PLRJ/KauaGTkl6DnYA=;
        b=ELhW1EO0blzxb/i+GVh9TBYVgbEQoU7sh3FZ5VJQdp5fsw+9j9aVeFD9/RKTUH8LKR
         kQefET1uJfaR8xzDFErH7AxKWYBhxHqgqrCarxemVbie14QHOV0G56F3nN85QLQoTobE
         OCoAKuuN/fLnVV+ATsLZXJur1v91snXPDyw2CC+tdSP9KdkQUpo+mpTL6ZkeAVBDx2ES
         6Md18ptjLtO4kB9XghEd+jKSeDFUQRtdgoAJp03LxvszMc1X7AKj4giPgyh8bsiym1LZ
         HX+76k0OLMthokw1JsB0wPOT/lu9f5BvSN0OXLRTGm10pxhyWW4/WiKr8Ott/zc9MBNL
         ELqA==
X-Gm-Message-State: AOAM5325GnqomE6fGf9v1WEBCOjOSu1H2ltLQvxXuiapUCoTYly/W9bE
        9c3RoF/akKFhkrbmgj6xO3TrbR3EYAv6lg==
X-Google-Smtp-Source: ABdhPJw6kyZ6V55OS4xnJlX/HEi2AIzycOKdrsvFVWX3FKss68SWVeop1ban2WUeHbkGTpT+P3UyNw==
X-Received: by 2002:a19:6a07:: with SMTP id u7mr8096422lfu.97.1612729754807;
        Sun, 07 Feb 2021 12:29:14 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j20sm1812898lfh.288.2021.02.07.12.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 12:29:14 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id E1FD3101B7A; Sun,  7 Feb 2021 23:29:13 +0300 (+03)
Date:   Sun, 7 Feb 2021 23:29:13 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v1 09/26] x86/tdx: Handle CPUID via #VE
Message-ID: <20210207202913.ov3kwlwnsn47v3tb@box>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <e45fcb584cd9fd67e6585ad8a904659a8b2ff9a5.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CALCETrW3+mzHaCUcWC1YUSwiuHkDWo=S4xnavk0CMcBiZd17+Q@mail.gmail.com>
 <20210207141304.kdjg732lzh5uzz7i@box>
 <dcaf6c92-2e2b-81d2-4755-c311d800ce2c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcaf6c92-2e2b-81d2-4755-c311d800ce2c@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 08:01:50AM -0800, Dave Hansen wrote:
> On 2/7/21 6:13 AM, Kirill A. Shutemov wrote:
> >>> +       /* Allow to pass R10, R11, R12, R13, R14 and R15 down to the VMM */
> >>> +       rcx = BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(14) | BIT(15);
> >>> +
> >>> +       asm volatile(TDCALL
> >>> +                       : "=a"(ret), "=r"(r10), "=r"(r11), "=r"(r12), "=r"(r13),
> >>> +                         "=r"(r14), "=r"(r15)
> >>> +                       : "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11), "r"(r12),
> >>> +                         "r"(r13)
> >>> +                       : );
> >> Some "+" constraints would make this simpler.  But I think you should
> >> factor the TDCALL helper out into its own function.
> > Factor out TDCALL into a helper is tricky: different TDCALLs have
> > different list of registers passed to VMM.
> 
> Couldn't you just have one big helper that takes *all* the registers
> that get used in any TDVMCALL and sets all the rcx bits?  The users
> could just pass 0's for the things they don't use.
> 
> Then you've got the ugly inline asm in one place.  It also makes it
> harder to screw up the 'rcx' mask and end up passing registers you
> didn't want into a malicious VMM.

For now we only pass down R10-R15, but the interface allows to pass down
much wider set of registers, including XMM. How far do we want to get it?

-- 
 Kirill A. Shutemov
