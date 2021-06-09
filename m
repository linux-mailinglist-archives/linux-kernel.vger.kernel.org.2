Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF793A0B18
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhFIEY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:24:57 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:41750 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhFIEYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:24:54 -0400
Received: by mail-pg1-f170.google.com with SMTP id l184so2825766pgd.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 21:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCuwdVMuxX4l4nzVD8KUa4bL0bYgx6E/Vou2OvI9Vzs=;
        b=qX1fL8ae8GhP+ipPT+HkavV7Q+cNOS8IKQUouAO+j1QqrD4al6Aln5fX1UIqs8leKQ
         C5FT+Svs3KonSyR6YvPeZxF5ueKS2fgfOKYlhjfmlO7T5LMxCPQxLp8zjSLNuIwlaKPC
         wFxzQHx2kz64srQYOj6gv4AunCyamnRXzbr2m8t8ntfC/VZijwwevmlu87hqMKSQgSzf
         n7VBbQfrvo81+HTsRH/bHAG5kYrbQFTPVmnQXdry0eIo9eozmp3gF7C/gxF4azoNahTl
         shUYWZkI40yW+aTQIkFyqe55OWPilK1wVOHVRz8kMoeWJa/cSdDBW4ZtNrnHpcjSTHdT
         UKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCuwdVMuxX4l4nzVD8KUa4bL0bYgx6E/Vou2OvI9Vzs=;
        b=k7wrFL56Ycs0ecSOvz8s9KcFAVYcoa7F5lDhIvwblriSPAN2C+8UHSs2Yn+KOz4n0N
         7z2RZabSPBhqDckxwBCmMuglmKRjDb13hKJzaMFGL9kw4x9kRb3ALPpd5LKIswziqEqb
         5hWnNOrowbjvjGBXvtYAA0MuPn/ceBvH5dcsW2H4l9SEUFKx+7NSRNNjoZC2G7YIP0JN
         yi8m804jkepKSPAa0VxASo7jZ7mnNNfg7hqKuiP5u9pLiG4kJuRKDk+nWoYOXfFqeMP/
         W09MNWlNMUMhulpWyRKJ4i2kJiP3oO0NGUS1tm5WplFWJRrkAPtBckAzQsS6sI62gPuD
         sEcw==
X-Gm-Message-State: AOAM531UuNn/zs4+IFLWD1t51FpMbtu8mQ8qZH1+p8766DbcJhbgDUF/
        H4/sYmmZJwX+TiADN7IJ7YNEZoo0GcJU5K53uzBDGQ==
X-Google-Smtp-Source: ABdhPJxdsBZE6CxuKnbvCh6k3MxShcVaa4Cpnci0waUne1U3tDVaPOeKepZfka98Y3LpuR3HE2EnLGNZZ7v0FvIuBF8=
X-Received: by 2002:a63:5c4a:: with SMTP id n10mr1789731pgm.279.1623212520647;
 Tue, 08 Jun 2021 21:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
 <20210609011030.751451-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4gLeKPfYOx1kmg-mO1_mNd+XGqVO-CbqX+2d52GZ+DSFw@mail.gmail.com> <23418f34-7c03-7477-6fbf-1b36b4718cb9@kernel.org>
In-Reply-To: <23418f34-7c03-7477-6fbf-1b36b4718cb9@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jun 2021 21:21:49 -0700
Message-ID: <CAPcyv4gXGgBPmk1MuE2jQ6VpKmPqz7eh2_uQO=1pTCqCCqFQTQ@mail.gmail.com>
Subject: Re: [RFC v2-fix-v4 1/1] x86/tdx: Skip WBINVD instruction for TDX guest
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Tue, Jun 8, 2021 at 9:02 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On 6/8/21 8:40 PM, Dan Williams wrote:
> > On Tue, Jun 8, 2021 at 6:10 PM Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >>
> >> Current TDX spec does not have support to emulate the WBINVD
> >> instruction. If any feature that uses WBINVD is enabled/used
> >> in TDX guest, it will lead to un-handled #VE exception, which
> >> will be handled as #GP fault.
> >>
> >> ACPI drivers also uses WBINVD instruction for cache flushes in
> >> reboot or shutdown code path. Since TDX guest has requirement
> >> to support shutdown feature, skip WBINVD instruction usage
> >> in ACPI drivers for TDX guest.
> >
> > This sounds awkward...
> >
> >> Since cache is always coherent in TDX guests, making wbinvd as
> >
> > This is incorrect, ACPI cache flushing is not about I/O or CPU coherency...
> >
> >> noop should not cause any issues in above mentioned code path.
> >
> > ..."should" is a famous last word...
> >
> >> The end-behavior is the same as KVM guest (treat as noops).
> >
> > ..."KVM gets away with it" is not a justification that TDX can stand
> > on otherwise we would not be here fixing up ACPICA properly.
> >
> > How about:
> >
> > "TDX guests use standard ACPI mechanisms to signal sleep state entry
> > (including reboot) to the host. The ACPI specification mandates WBINVD
> > on any sleep state entry with the expectation that the platform is
> > only responsible for maintaining the state of memory over sleep
> > states, not preserving dirty data in any CPU caches. ACPI cache
> > flushing requirements pre-date the advent of virtualization. Given TDX
> > guest sleep state entry does not affect any host power rails it is not
> > required to flush caches. The host is responsible for maintaining
> > cache state over its own bare metal sleep state transitions that
> > power-off the cache. If the host fails to manage caches over its sleep
> > state transitions the guest..."
> >
>
> I like this description, but shouldn't the logic be:
>
> if (!CPUID has hypervisor bit set)
>   wbinvd();
>
> As far as I know, most hypervisors will turn WBINVD into a noop and,
> even if they don't, it seems to be that something must be really quite
> wrong for a guest to need to WBINVD for ACPI purposes.

Agree, a well behaved guest should not pretend its callouts to the
virtual ACPI BIOS actually affect a host power rail.
