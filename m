Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1F537B5CC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 08:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhELGSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 02:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhELGS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 02:18:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C82C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 23:17:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u21so33181037ejo.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 23:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyAFybX2Od+U00wmf4KH3ogCb1hpEKFtKmOGSfGvdsY=;
        b=OtLlgaB89klOWQqgLAAs4xSxccyf6q06P7khs1MhZFxVXrADN+3HTeF4uMldwKY2+d
         wUtLm0X0xwUPtcIQlV6Nb3Gb6aav43l9q2aSy8hSjKQxOoWBnVGoJH1fpvsHF9jWs6wk
         qb88q18hgRBm6cK6Kwxs+CiZze2ll9aPupxcmEnFAg0XNGwB1+Vk7E+O2Ng+GryUqbng
         KfY0bnXHtrpzDeFzunNGfGoO7jrqcy65guzugWXCgXajHWBWcxT1dkGx6sn9dKqhZ/RG
         VhIlQSLbpbsfrHcX4IMz57AzC30SzZWgxCiF/YlKhQFnUOwdMGcvZFg8j82JBa8tcyRo
         XUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyAFybX2Od+U00wmf4KH3ogCb1hpEKFtKmOGSfGvdsY=;
        b=cwQurykeKGNVmXChPv3jhdL9/nzCCV93FaK/PEJzwejGJNRPgPgN064XVU46GxwAwn
         hRKWHv/qaLfAJFJDIw3fMmh4lwCvbsi5ybWCKZe5fFs9GOdi2h4kNwdmB9ClaCc52p13
         yXmtyYucLHQCMS3Qm5EY2+S1TdyC6TeCZznrfDbfnN/IJAVUwcbQ2yye7tt+sZofSkYf
         1/5KocTqorooT+Kt9fmATr/VytILR+uz/cC4rMTkIzXNYB7VlGyN75NFLg8DHkciF379
         kY7fD5np1H3qtsWACaIuOXrY/jdhwpnWSF6JQXcsnwhQ7ZVlhZVS+4S7aLInFzXbFT0o
         0B2w==
X-Gm-Message-State: AOAM531OkPfQbKgolLC4NmInT0gUK/vsO3ovjK0+yAVA1QGXB80fWYQF
        HW4Bn1QrK8H6qakZqclR1Bx8M94QnkgDjjv2KkUM8g==
X-Google-Smtp-Source: ABdhPJyuZgqkUBW0m030Ol4meIJ402+TMNcBZgwwRzezpdd+iEGAS+Xoq86SSlZ5szTmu/qi7tAjyl/gjXyE54+ZEKA=
X-Received: by 2002:a17:907:1183:: with SMTP id uz3mr34969481ejb.264.1620800240796;
 Tue, 11 May 2021 23:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0e7e94d1ee4bae49dfd0dd441dc4f2ab6df76668.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jPLGs6p0PNZQB6yKB3QDtEcGb234zcgCbJutXxZZEGnA@mail.gmail.com> <6ea92e98-a243-ef7c-4263-bafb8946feef@intel.com>
In-Reply-To: <6ea92e98-a243-ef7c-4263-bafb8946feef@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 May 2021 23:17:10 -0700
Message-ID: <CAPcyv4gBNqDFQEYjWqYTckPg-yy=LrvMw_FNY+tUuEwD35CfyA@mail.gmail.com>
Subject: Re: [RFC v2 14/32] x86/tdx: Handle port I/O
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 8:36 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/10/21 2:57 PM, Dan Williams wrote:
> >> Decompression code uses port IO for earlyprintk. We must use
> >> paravirt calls there too if we want to allow earlyprintk.
> > What is the tradeoff between teaching the decompression code to handle
> > #VE (the implied assumption) vs teaching it to avoid #VE with direct
> > TDVMCALLs (the chosen direction)?
>
> To me, the tradeoff is not just "teaching" the code to handle a #VE, but
> ensuring that the entire architecture works.
>
> Intentionally invoking a #VE is like making a function call that *MIGHT*
> recurse on itself.  Sure, you can try to come up with a story about
> bounding the recursion.  But, I don't see any semblance of that in this
> series.
>
> Exception-based recursion is really nasty because it's implicit, not
> explicit.  That's why I'm advocating for a design where the kernel never
> intentionally causes a #VE: it never intentionally recurses without bounds.

So this circles back to the common problem with the
mwait/monitor/wbinvd patch and this one. "Can't happen" #VE conditions
should be fatal. I.e. have a nice clear message about why the kernel
failed and halt. All the uses of these #VE triggering instructions can
be eliminated ahead of time with auditing and people that load
unaudited out-of-tree modules that trigger #VE get to keep the pieces.
Said pieces will be described to them by the #VE triggered fail
message. This isn't like split lock disable where the code is
difficult to audit.

What am I missing?
