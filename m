Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8D437AACC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhEKPir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbhEKPiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:38:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6937DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:37:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t4so30503011ejo.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGTzZBgGl9E3Ob3Swj3ghtaI+ZQhTYwB5Fnq/6Gnk8w=;
        b=E7vrY4JG20ktVwkGyZOq3RjGWui6ptu5QvBIFsXE2zfL0+hn6HxvULr0CMM9y0bZ0z
         0o5MIaF9dfDdl0jHqQzS/VGg/Ip3Mw1OX8P3YasaApoeSzZU4mLYZc+nR4wp+j9ri8hX
         jt2nVwhHIipnSsGC6P7TZclTPXad+RWR80d8N1/yCh42Rm3ZCo5JLjsOYBxXe6LzqoEL
         8yH9kbX5bKMnKqEcmVR6umBrj9GVSq/c5H+NisceUUEo8SoXQMTStlOt8JyArrUybdCb
         MeC795alrL0zgfVzOg+Faw5g+E7jPx8lR/yZyliKnLoyEhgFKzePLACmnTR81Ay+OeWu
         4Bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGTzZBgGl9E3Ob3Swj3ghtaI+ZQhTYwB5Fnq/6Gnk8w=;
        b=llcBcWdWAs/8iKbUz3dJrOd7Lh+pUGHZQUg95FlQEpdPppPpVix099Hcmq9bU31Deq
         CM6da1Mlk6RKx+XPOjVQHO2aHGjGDWgTJdR/OxX0FZBrEzEeZCVkTc9VUnHSmEPOBcyM
         SO5lOMiqy2bsqL9SmUivW+3Bu9kzy9jGGRJQQZXhwsz1FVAwvpW7bKv+KdU2Y3Z7JizG
         Wwd6JDTtmwZqG9SLsYAdk+wcClLT3aIxwpG/HCuGV0OBy96SD2HLfxircrXiae0Ytxy8
         nx+AycEdm5KsAT1inSHCu6nxBwBVVaSCEcCZRJRARMgnvZ5MwrxsdMRcuVETnCrEwRmX
         HzjA==
X-Gm-Message-State: AOAM531qIiuHWigAB2zYw3bOzPypJCSLVDRbjb0T7Je4JxG8bjKvdDFF
        uxWbUUMjN2Qluuv7SpEFadhn3HMkQX2IAP6gZa4tYNncBdw=
X-Google-Smtp-Source: ABdhPJyPZrBzlX9ulxmdthwfYJBNzVK+tNC1qlQKoSYHi7zM/zx4v9K+AxNJG5Ck/MjFImM6redoRPNk1XKOznBQ06A=
X-Received: by 2002:a17:906:9381:: with SMTP id l1mr31949739ejx.45.1620747458133;
 Tue, 11 May 2021 08:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d6ca05720290060e909c1f4d12858f900f1be0e7.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jGmhkrd+Zr4RNcZ5qfXkYO-416Bw2_idVbrgij41yvYg@mail.gmail.com> <0e577692-101e-38f7-ebe2-2e7222016a9f@linux.intel.com>
In-Reply-To: <0e577692-101e-38f7-ebe2-2e7222016a9f@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 May 2021 08:37:28 -0700
Message-ID: <CAPcyv4jLMA=jehxdFi=A-xtjSRQ_v7XxSVYrZPAU3XKC39qWRA@mail.gmail.com>
Subject: Re: [RFC v2 16/32] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
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

On Mon, May 10, 2021 at 7:17 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> >> To prevent TD guest from using MWAIT/MONITOR instructions,
> >> support for these instructions are already disabled by TDX
> >> module (SEAM). So CPUID flags for these instructions should
> >> be in disabled state.
> > Why does this not result in a #UD if the instruction is disabled by
> > SEAM?
>
> It's just the TDX module (SEAM is the execution mode used by the TDX module)
>
>
> > How is it possible to execute a disabled instruction (one
> > precluded by CPUID) to the point where it triggers #VE instead of #UD?
>
> That's how the TDX module works. It never injects anything else other
> than #VE. You can still get other exceptions of course, but they won't
> come from the TDX module.
>
> >> After the above mentioned preventive measures, if TD guests still
> >> execute these instructions, add appropriate warning messages in #VE
> >> handler. For WBIND instruction, since it's related to memory writeback
> >> and cache flushes, it's mainly used in context of IO devices. Since
> >> TDX 1.0 does not support non-virtual I/O devices, skipping it should
> >> not cause any fatal issues.
> > WBINVD is in a different class than MWAIT/MONITOR since it is not
> > identified by CPUID, it can't possibly have the same #UD behaviour.
> > It's not clear why WBINVD is included in the same patch as
> > MWAIT/MONITOR?
>
> Because these are all instructions we never expect to execute, so
> nothing special is needed for them. That's a unique class that logically
> fits together.
>
>
> >
> > I disagree with the assertion that WBINVD is mainly used in the
> > context of I/O devices, it's also used for ACPI power management
> > paths.
>
> You mean S3? That's of course also not supported inside TDX.
>
>
> >   WBINVD dependent functionality should be dynamically disabled
> > rather than warned about.
> >
> > Does a TDX guest support out-of-tree modules?  The kernel is already
> > tainted when out-of-tree modules are loaded. In other words in-tree
> > modules preclude forbidden instructions because they can just be
> > audited, and out-of-tree modules are ok to trigger abrupt failure if
> > they attempt to use forbidden instructions.
>
> We already did a lot of bi^wdiscussion on this on the last review.
>
> Originally we had a different handling, this was the result of previous
> feedback.
>
> It doesn't really matter because it should never happen.
>
>
> >
> >> But to let users know about its usage, use
> >> WARN() to report about it.. For MWAIT/MONITOR instruction, since its
> >> unsupported use WARN() to report unsupported usage.
> > I'm not sure how useful warning is outside of a kernel developer's
> > debug environment. The kernel should know what instructions are
> > disabled and which are available. WBINVD in particular has potential
> > data integrity implications. Code that might lead to a WBINVD usage
> > should be disabled, not run all the way up to where WBINVD is
> > attempted and then trigger an after-the-fact WARN_ONCE().
>
> We don't expect the warning to ever happen. Yes all of this will be
> disabled. Nearly all are in code paths that cannot happen inside TDX
> anyways due to missing PCI-IDs or different cpuids, and S3 is explicitly
> disabled and would be impossible anyways due to lack of BIOS support.
>
>
>
>
> >
> > The WBINVD change deserves to be split off from MWAIT/MONITOR, and
> > more thought needs to be put into where these spurious instruction
> > usages are arising.
>
> I disagree. We already spent a lot of cycles on this. WBINVD makes never
> sense in current TDX and all the code will be disabled.

Why not just drop the patch if it continues to cause people to spend
cycles on it and it addresses a problem that will never happen?
