Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB6E3A1BD1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 19:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhFIRdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 13:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhFIRdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 13:33:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0CEC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 10:31:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v12so12915149plo.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 10:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUPG/wDsBT1M/DbB2ioTvbHMxGRFVGhJkYMa6URVYao=;
        b=OqLVYpcj7UzPpZKlf9miLxtPsb2DUZVQ1LwDmXSIljXUCxe/F6MxkCmIwABnOjgGBl
         6RYYHLehy48lEHzzA8Mfa6YRaZB29Rae/9eiqgmQJjTOSelGolMsAfNSRX1tdNpZ3ycG
         QTF/2c8uxv46FCJEtYL0KJSY0elhxp0EYh79/KndJ4FekLpxwvRJLU97TQrh2W4Coz11
         w6c+K/EKE3SkAE4YWWzPEsiv2EvNbtFfX/otQsy3lQ0bf7WKwcsKkVj2VpPLhawg3zo6
         +C4dXk401sjNAK77GJAqL5bB/czy4pyNYbYvmAmJr3nA9tPA+p1x+zQxICNRhb5pw2Bs
         /fMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUPG/wDsBT1M/DbB2ioTvbHMxGRFVGhJkYMa6URVYao=;
        b=Y2s2V807qepG/CKEfSWC9VM/yLkrI0s5JFxsyoqT+z/6u6NzWwCLgQXm7SOFX/cAev
         uwv1edEO4wior4uhKiczDlHvRIY0cd9hOQ9rLb6ifJVdfW9zdi7dp69hSvBy7dBjeePH
         +eCZU5S+5g3bMsl4EDQnJVePuW0A2y6o6GXeCX0/kTbjps1Zd4obvIUHkVGsAF2XRZ3I
         9zBkeVp/0s3Vc7eQqleV5dm3cW79gP1XU4MWRUyOeMVwAXrGQ3/mpCLOJEsYTeUIoBO4
         mjgTOuX3nHxp7MUaswjPXQcVisIJ1wkCxRBPSdey3Ts63lb6HMQ4AvSzZaRc0+yDAp63
         VAiQ==
X-Gm-Message-State: AOAM5324ndjCCOxULRUd3JlNmT2TFhUWuegJ8PlMVBXB0V+Jv/Zmb4ZZ
        R9dMfMEL96Wf1SpEdk2rB7OIwhNq8Gwm7YnK7CLLCw==
X-Google-Smtp-Source: ABdhPJw3j8oHgzrzFnFt6CwBHswyEdXL4KTtQN0bkClZFg/U2jHFXENgY/vmlyLA6yAG7hhMRvj+KVkKmzIK6kdYFCk=
X-Received: by 2002:a17:90a:8589:: with SMTP id m9mr5280132pjn.168.1623259888393;
 Wed, 09 Jun 2021 10:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
 <20210609011030.751451-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4gLeKPfYOx1kmg-mO1_mNd+XGqVO-CbqX+2d52GZ+DSFw@mail.gmail.com>
 <682f0239-8da0-3702-0f14-99b6244af499@linux.intel.com> <CAPcyv4jfFPGm2-cvPExeujZnaSKKky3AQRp69tzG1gcZ09dj8A@mail.gmail.com>
 <ffedf1d2-e5ec-e0e3-8e83-edd186231029@linux.intel.com> <CAPcyv4haWYhqk_xLD56QnB0ahK+fynOmqGdSD907UW-=7B176g@mail.gmail.com>
 <c2f4254d-3d28-544a-efd2-e65dd40d99f1@kernel.org> <59484871-8ef1-b7c3-fb29-b143bd53f074@linux.intel.com>
In-Reply-To: <59484871-8ef1-b7c3-fb29-b143bd53f074@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Jun 2021 10:31:17 -0700
Message-ID: <CAPcyv4hrwOuSBS9g+9=zetaCKY2=4J1e7ky1w9aojTJq9CNFQg@mail.gmail.com>
Subject: Re: [RFC v2-fix-v4 1/1] x86/tdx: Skip WBINVD instruction for TDX guest
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 10:28 AM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 6/9/21 9:12 AM, Andy Lutomirski wrote:
> > On 6/9/21 8:09 AM, Dan Williams wrote:
> >> On Tue, Jun 8, 2021 at 9:27 PM Andi Kleen <ak@linux.intel.com> wrote:
> >>>
> >>>
> >>> here is no resume path.
> >>>
> >>>> Host is free to go into S3 independent of any guest state.
> >>>
> >>> Actually my understanding is that none of the systems which support TDX
> >>> support S3. S3 has been deprecated for a long time.
> >>
> >> Ok, I wanted to imply any power state that might power-off caches.
> >>
> >>>
> >>>
> >>>>    A hostile
> >>>> host is free to do just enough cache management so that it can resume
> >>>> from S3 while arranging for TDX guest dirty data to be lost. Does a
> >>>> TDX guest go fatal if the cache loses power?
> >>>
> >>> That would be a machine check, and yes it would be fatal.
> >>
> >> Sounds good, so incorporating this and Andy's feedback:
> >>
> >> "TDX guests, like other typical guests, use standard ACPI mechanisms
> >> to signal sleep state entry (including reboot) to the host. The ACPI
> >> specification mandates WBINVD on any sleep state entry with the
> >> expectation that the platform is only responsible for maintaining the
> >> state of memory over sleep states, not preserving dirty data in any
> >> CPU caches. ACPI cache flushing requirements pre-date the advent of
> >> virtualization. Given guest sleep state entry does not affect any host
> >> power rails it is not required to flush caches. The host is
> >> responsible for maintaining cache state over its own bare metal sleep
> >> state transitions that power-off the cache. A TDX guest, unlike a
> >> typical guest, will machine check if the CPU cache is powered off."
> >>
> >> Andi, is that machine check behavior relative to power states
> >> mentioned in the docs?
> >
> > I don't think there's anything about power states.  There is a general
> > documented mechanism to integrity-check TD guest memory, but it is *not*
> > replay-resistant.  So, if the guest dirties a cache line, and the cache
> > line is lost, it seems entirely plausible that the guest would get
> > silently corrupted.
> >
> > I would argue that, if this happens, it's a host, TD module, or
> > architecture bug, and it's not the guest's fault.
>
> If you want to apply this fix for all hypervisors (using boot_cpu_has
> (X86_FEATURE_HYPERVISOR) check), then we don't need any TDX specific
> reference in commit log right? It can be generalized for all VM guests.
>
> agree?

No, because there is a note needed about the integrity implications in
the TDX case that makes it distinct from typical hypervisor enabling.
