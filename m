Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837073A0ACF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 05:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbhFIDnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 23:43:49 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:51044 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbhFIDnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 23:43:47 -0400
Received: by mail-pj1-f41.google.com with SMTP id g4so582885pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 20:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNKkenGRml23xBg4KjGJ5A1pC8GmzKqPKLNjmgj9/iA=;
        b=QO64MZcTAU1MIQgs6Mut78CoM4BDAdIhwucUOW0xobxe46j5YlwyMptYoglN9QAJWv
         4crKp84dUXgrQrEv59RjlcAVOPfsHgSsNcWfx7ehzjiU+ReMvqABOGQR4QIMl6OJCeWm
         JQPoeBvsU42PLbmLD3MJ0oqCsysumAA9KIYAWSUm88+jwWQq7HI7CONzaeVOphKYDgHu
         G8Nbfv118GXi7h+2o09GC01K+8lovkdPABHOp281BDk+ay/lwi3yXLTWPx2FLlD1wIyU
         sfzo/fVbv9iSI7z/G6ngvt6/1uXUFFGp3OqpzHRpQttiOSMWeIylIMXRPQLlswCNWXBU
         030w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNKkenGRml23xBg4KjGJ5A1pC8GmzKqPKLNjmgj9/iA=;
        b=JSNtbTB9EPMqyMCbvj0+oePifIvOzAdrnhTXf4EeW5QPDHAJN0wrHCfxXU0cnyOlft
         wWSv6F4PFBNZbwh6HzpbtHQkFavlJP/LE3B9gmesZ5PfElxy0NW3o2ImI5edEyQx/slm
         FNdjOKkQChQFiAMJIBd9tEb+7CLCdC0p26tRTh6y/jZVmXcQfk9B9ZO0cFxY4/lZu8iv
         pQMaIn3juUbL2ofAT9/Vg/4O+v+i8kk6oKJV6l6VXh/JEXZWoxy7lKCZCRd0yO4MlTAY
         vFzAf3fJwgGsVNDHAYeHoJ4QBiboHBV4pG9RlYTwlpUzEomnXu7e++sIjQ80SMqBAUQ0
         HC1g==
X-Gm-Message-State: AOAM5317qWFmgUNQnQ4UP+VLYrKmM13ZySvOZkl4hLK673bSAzyAOlh6
        fb7hxLCxk1Uk2N0oFZHfbl2CHk4atXP+eV8P9fndsw==
X-Google-Smtp-Source: ABdhPJzkWkiEhNzVyIlsGgMPd41zkyzt3aTtFuY4VMzPKh52dSGnqoueK8/SVhL4VCLC4/HB7Y6jPNlBnbBQ8BMIfBo=
X-Received: by 2002:a17:902:f1cb:b029:10c:5c6d:88b with SMTP id
 e11-20020a170902f1cbb029010c5c6d088bmr3409979plc.52.1623210053487; Tue, 08
 Jun 2021 20:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
 <20210609011030.751451-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210609011030.751451-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jun 2021 20:40:42 -0700
Message-ID: <CAPcyv4gLeKPfYOx1kmg-mO1_mNd+XGqVO-CbqX+2d52GZ+DSFw@mail.gmail.com>
Subject: Re: [RFC v2-fix-v4 1/1] x86/tdx: Skip WBINVD instruction for TDX guest
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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

On Tue, Jun 8, 2021 at 6:10 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Current TDX spec does not have support to emulate the WBINVD
> instruction. If any feature that uses WBINVD is enabled/used
> in TDX guest, it will lead to un-handled #VE exception, which
> will be handled as #GP fault.
>
> ACPI drivers also uses WBINVD instruction for cache flushes in
> reboot or shutdown code path. Since TDX guest has requirement
> to support shutdown feature, skip WBINVD instruction usage
> in ACPI drivers for TDX guest.

This sounds awkward...

> Since cache is always coherent in TDX guests, making wbinvd as

This is incorrect, ACPI cache flushing is not about I/O or CPU coherency...

> noop should not cause any issues in above mentioned code path.

..."should" is a famous last word...

> The end-behavior is the same as KVM guest (treat as noops).

..."KVM gets away with it" is not a justification that TDX can stand
on otherwise we would not be here fixing up ACPICA properly.

How about:

"TDX guests use standard ACPI mechanisms to signal sleep state entry
(including reboot) to the host. The ACPI specification mandates WBINVD
on any sleep state entry with the expectation that the platform is
only responsible for maintaining the state of memory over sleep
states, not preserving dirty data in any CPU caches. ACPI cache
flushing requirements pre-date the advent of virtualization. Given TDX
guest sleep state entry does not affect any host power rails it is not
required to flush caches. The host is responsible for maintaining
cache state over its own bare metal sleep state transitions that
power-off the cache. If the host fails to manage caches over its sleep
state transitions the guest..."

I don't know how to finish the last sentence. What does TDX do if it
is resumed after host suspend and the host somehow arranged for dirty
TDX lines to be lost. Will that be noticed by TDX integrity
mechanisms? I did not immediately find an answer to this with a brief
look at the specs.

>
> In future, once TDX guest specification adds support for WBINVD
> hypercall, we can pass the handle to KVM to handle it.

I expect if the specification wanted operating systems to plan for
this eventuality it would have made a note of it. I expect this
sentence can just be deleted.
