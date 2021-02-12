Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A5F31A62C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhBLUpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhBLUpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:45:43 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AFFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:45:03 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t2so311257pjq.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T5XtV1zKLaPDDpJm+haMaAY787MEldcJF2+52pVxJmg=;
        b=fdTLoryrM9/7lgSKiAEHb24UPW9IA/tf3KURhdT0AjdwnJOuVO3Ei7JYQbIREOu8js
         yznYy7Lnd7ltSGtnZZ/kmPGDVh/22ekC4+QWTUD8HWc6Wf5/5nlgpWYKrfjvZJruCU8W
         JCBtAldYsLQtQ6m3LP9I75uyqVra49ImJYGGMAVUztImjhmrP8rK4Oe8QTdPnXq8Yfyj
         /UIpaZN5tgIYGiTg9zR+Ocym7wqhV5hjSkvKcSAoC+nX90/o2ouHU9Z5A/Uj+fDaV4oo
         CM/NbOMkY/rOyvaKMzRYy2bSVXMIi1xh9M5Ji5nJuOaxTGDTlMgxVerZlGztH7Re7Le2
         Mffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T5XtV1zKLaPDDpJm+haMaAY787MEldcJF2+52pVxJmg=;
        b=A3lCBzApa/ghfABFOgpKV2dU3HxuRWuiwh868gMYzWWy7q8FMlJlFlvkHww6CZYzXF
         25jXfb2eRWe4GOgCRAa5etwOZi3lfnysLiKAiAxtpauh+QFXZ1JWwXvVMDnBXAsjvcCm
         OFvPi/DMfbxiwmSN0Wpu7NJgq+dvlcFD2dYj4+UFZJoGrhUKwPakOHCu56IsFCsK9uxJ
         9NFyR7ObP31YxP/JQndaP8+l5WB0b8O+awLejHB9yGt+qAlHw/zmN8xo6XuKTM8h4V3R
         sN3FAK1Qel+K461AhFaCmeFzdD2nlNLtC4fH9mez4/djIcQD7TTQmeiK5vKfLxQrCJKv
         FWgg==
X-Gm-Message-State: AOAM532a9k/4Dheu04gR6EbikraMO7n7J60isDPoqsYqE19yeHIO0nXR
        2eLEWS6IAmIi3ds5wmfIMYC61A==
X-Google-Smtp-Source: ABdhPJxwniz/mprQnnacqbUM9CPi+CxHD5L35oLH5Tg5cr3+JZLrmm3qgnHNbf3kObTjL25l8kNdoA==
X-Received: by 2002:a17:90b:795:: with SMTP id l21mr4083431pjz.5.1613162702361;
        Fri, 12 Feb 2021 12:45:02 -0800 (PST)
Received: from google.com ([2620:15c:f:10:b407:1780:13d2:b27])
        by smtp.gmail.com with ESMTPSA id o11sm8088766pjo.43.2021.02.12.12.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 12:45:01 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:44:55 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
Message-ID: <YCbox5Z5zAQxwZkQ@google.com>
References: <YCbfyde9jl7ti0Oz@google.com>
 <A06CFC3D-53A8-45C1-9580-8459585F458E@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A06CFC3D-53A8-45C1-9580-8459585F458E@amacapital.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021, Andy Lutomirski wrote:
> 
> > On Feb 12, 2021, at 12:06 PM, Sean Christopherson <seanjc@google.com> wrote:
> > 
> > ﻿On Fri, Feb 12, 2021, Andy Lutomirski wrote:
> >>> On Fri, Feb 5, 2021 at 3:39 PM Kuppuswamy Sathyanarayanan
> >>> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >>> 
> >>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >>> 
> >>> The TDX module injects #VE exception to the guest TD in cases of
> >>> disallowed instructions, disallowed MSR accesses and subset of CPUID
> >>> leaves. Also, it's theoretically possible for CPU to inject #VE
> >>> exception on EPT violation, but the TDX module makes sure this does
> >>> not happen, as long as all memory used is properly accepted using
> >>> TDCALLs.
> >> 
> >> By my very cursory reading of the TDX arch specification 9.8.2,
> >> "Secure" EPT violations don't send #VE.  But the docs are quite
> >> unclear, or at least the docs I found are.
> > 
> > The version I have also states that SUPPRESS_VE is always set.  So either there
> > was a change in direction, or the public docs need to be updated.  Lazy accept
> > requires a #VE, either from hardware or from the module.  The latter would
> > require walking the Secure EPT tables on every EPT violation...
> > 
> >> What happens if the guest attempts to access a secure GPA that is not
> >> ACCEPTed?  For example, suppose the VMM does THH.MEM.PAGE.REMOVE on a secure
> >> address and the guest accesses it, via instruction fetch or data access.
> >> What happens?
> > 
> > Well, as currently written in the spec, it will generate an EPT violation and
> > the host will have no choice but to kill the guest.
> 
> Or page the page back in and try again?

The intended use isn't for swapping a page or migrating a page.  Those flows
have dedicated APIs, and do not _remove_ a page.

E.g. the KVM RFC patches already support zapping Secure EPT entries if NUMA
balancing kicks in.  But, in TDX terminology, that is a BLOCK/UNBLOCK operation.

Removal is for converting a private page to a shared page, and for paravirt
memory ballooning.

> In regular virt guests, if the host pages out a guest page, it’s the host’s
> job to put it back when needed. In paravirt, a well designed async of
> protocol can sometimes let the guest to useful work when this happens. If a
> guest (or bare metal) has its memory hot removed (via balloon or whatever)
> and the kernel messes up and accesses removed memory, the guest (or bare
> metal) is toast.
> 
> I don’t see why TDX needs to be any different.

The REMOVE API isn't intended for swap.  In fact, it can't be used for swap. If
a page is removed, its contents are lost.  Because the original contents are
lost, the guest is required to re-accept the page so that the host can't
silently get the guest to consume a zero page that the guest thinks has valid
data.

For swap, the contents are preserved, and so explicit re-acceptance is not
required.  From the guest's perspective, it's really just a high-latency memory
access.
