Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D51369663
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242829AbhDWPv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhDWPv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:51:27 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA278C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:50:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id lr7so7182697pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zobnoZkfsomgs6u07I7F/AdmQpe1Hs0oIcqXdTG3AhA=;
        b=hZooTYnfRVus2wBuhtfIEk/L2IRbPLXEiyC5Ys5SJk3E4ruvfaOHK6LHmVpIlOepQP
         K9O5HdVBTGDrgVay1XQuwDCa9CCQ+cOnbpCojU00NZm9l9teUFspJPO5+jqI8X/Yvv5p
         NnBS7/vFcs/8/0lJ+cA+RiUWDASveP6iHa8gfLbuLEtUX058XK4NaajBlSCRnlFZ0hY3
         QQqyMhFnJXz7mgMF5PipbSf5Rz5VznCRM6guTNoLFESZyjvPkhBRkHATYuJ39w2dJqK+
         1HCtv//iWTB+IgynqEzA9ZjUCFhSiYmLa6TyBZcmleB0pnWRft6/89OPhQ+LhiFkAZn5
         GXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zobnoZkfsomgs6u07I7F/AdmQpe1Hs0oIcqXdTG3AhA=;
        b=RkEzwDuogyZra6Bgy8ZgM88mvjMCLK43qPn/YjoAZSvS6JyjEeAk7fV6RRszkESiJV
         xjfUc7qqa6O+hcp8zVQhfcQD9bFHaFJJMMzz9v030Zhp4glahipcCHXW5AsWBYcKx7RI
         zjFFVP3FQ0U7w/ChVWLYfvnpcKyn7RS4QB5w/GsT8FRd/AfEuJ9XxN5zDV5CFssrPdJA
         vZ6GGVogN9TWgsqE0XhCbWXtT/sioDTtGc5nmfvugHK6OKJd3lPl1lwVTGdPbUnqVLRd
         QbVmFWJyzd6bfJlKrUZifnnvAHlYGAUfdhdtxHUvn4btaWkxMp3kr2Bpf/TUce7jdpBn
         ZRHg==
X-Gm-Message-State: AOAM532ix6yjWkvK1BxqmpzxQIroVcvz5HHwd1GfBHq1EiGvk6dDyszl
        MkfpOC93ThCGN7OIEbXxf4ATrg==
X-Google-Smtp-Source: ABdhPJwU1mKpmkJTZUuwfYL6G4ET3Al5hL9i2y67aRfjfovceIzvtwhaIbomkzu9XtONokOyGEjTCA==
X-Received: by 2002:a17:902:8688:b029:ea:f782:5eae with SMTP id g8-20020a1709028688b02900eaf7825eaemr4549507plo.15.1619193050203;
        Fri, 23 Apr 2021 08:50:50 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id c21sm4951921pfc.165.2021.04.23.08.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 08:50:49 -0700 (PDT)
Date:   Fri, 23 Apr 2021 15:50:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] x86/tdx: Add __tdcall() and __tdvmcall() helper
 functions
Message-ID: <YILs1QUBl0R1XAWG@google.com>
References: <77a13ae9-0220-030e-7ae4-fd26edd7b110@intel.com>
 <2a3f6b3d-cd80-0734-ce83-c067666c8326@linux.intel.com>
 <14332abf-c78c-3bc2-9a7c-ceacfa7a0661@intel.com>
 <596175e3-9d1e-6c9c-fadb-ad02c396e3ad@linux.intel.com>
 <d99941db-6ee6-267e-dece-6220af0ea305@intel.com>
 <9161efc0-fd25-d239-32b7-5d2c726579b0@linux.intel.com>
 <4ac4ed35-212b-f7ad-55f4-937946ffec1a@intel.com>
 <20210423013546.GK1401198@tassilo.jf.intel.com>
 <YILkl3C4YjGPM5Jr@google.com>
 <CAPcyv4gwDeLzG98CegHQs8AAAdctD4vLrAzncu=ciVMyBSDxAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gwDeLzG98CegHQs8AAAdctD4vLrAzncu=ciVMyBSDxAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021, Dan Williams wrote:
> On Fri, Apr 23, 2021 at 8:15 AM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Thu, Apr 22, 2021, Andi Kleen wrote:
> > > On Thu, Apr 22, 2021 at 06:21:07PM -0700, Dave Hansen wrote:
> > > > On 4/22/21 6:09 PM, Kuppuswamy, Sathyanarayanan wrote:
> > > > > But let me try to explain it here. What I meant by complication is,
> > > > > for in/out instruction, we use alternative_io() to substitute in/out
> > > > > instructions with tdg_in()/tdg_out() assembly calls. So we have to ensure
> > > > > that we don't corrupt registers or stack from the substituted instructions
> > > > >
> > > > > If you check the implementation of tdg_in()/tdg_out(), you will notice
> > > > > that we have added code to preserve the caller registers. So, if we use
> > > > > C wrapper for this use case, there is a chance that it might mess
> > > > > the caller registers or stack.
> > > > >
> > > > >     alternative_io("in" #bwl " %w2, %" #bw "0",            \
> > > > >             "call tdg_in" #bwl, X86_FEATURE_TDX_GUEST,    \
> >
> > Has Intel "officially" switched to "tdg" as the acronym for TDX guest?  As much
> > as I dislike having to juggle "TDX host" vs "TDX guest" concepts, tdx_ vs tdg_
> > isn't any better IMO.  The latter looks an awful lot like a typo, grepping for
> > "tdx" to find relevant code will get fail (sometimes), and confusion seems
> > inevitable as keeping "TDX" out of guest code/comments/documentation will be
> > nigh impossible.
> >
> > If we do decide to go with "tdg" for the guest stuff, then _all_ of the guest
> > stuff, file names included, should use tdg.  Maybe X86_FEATURE_TDX_GUEST could
> > be left as a breadcrumb for translating TDX->TDG.
> >
> > > > >             "=a"(value), "d"(port))
> > > >
> > > > Are you saying that calling C functions from inline assembly might
> > > > corrupt the stack or registers?  Are you suggesting that you simply
> > >
> > > It's possible, but you would need to mark a lot more registers clobbered
> > > (the x86-64 ABI allows to clobber many registers)
> > >
> > > I don't think the stack would be messed up, but there might be problems
> > > with writing the correct unwind information (which tends to be tricky)
> > >
> > > Usually it's better to avoid it.
> >
> > For me, the more important justification is that, if calling from alternative_io,
> > the input parameters will be in the wrong registers.  The OUT wrapper would be
> > especially gross as RAX (the value to write) isn't an input param, i.e. shifting
> > via "ignored" params wouldn't work.
> >
> > But to Dave's point, that justfication needs to be in the changelog.
> 
> It's not clear to me that in()/out() need to be inline asm with an
> alternative vs out-of-line function calls with a static branch?

Code footprint is the main argument, especially since Intel presumably is hoping
most distros will build their generic kernels with CONFIG_TDX_GUEST=y.  IIRC, a
carefully crafted assembly helper with a custom ABI can keep the overhead to
three bytes (or maybe even one byte?) versus raw IN and OUT.  Using a static
branch would incur significantly more overhead since the register prologues would
be different.

Or are you saying make the inb/outb() helpers themselves functions?  That would
be quite brutal, too.  

On a related topic, this changelog also needs to justify changing "Nd" to "d".
Maybe no one cares too much about imm8 port I/O and code footprint, but
effectively killing off "IN AL, imm8" should at least be called out.
