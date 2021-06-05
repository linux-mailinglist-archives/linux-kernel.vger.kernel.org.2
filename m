Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F1E39C585
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 05:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFEDhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 23:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFEDha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 23:37:30 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CD2C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 20:35:43 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c12so8849164pfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 20:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZseS8aSnULurPdZf/si9iNA+qWf4+HN6oG8w6/+geQ=;
        b=uCcYmDmD0mdD2R/F6Gx+4Lbo0Twudda2tFrZ7DfTrInQq5Ll/iB15gFtdu/unlvR3X
         35GsCTp+XPoAqExK9lGFbn2ufkny/LzF5L93Jy7ykmZUrJ3iVqdIjf5kUBLPhoLat7Vd
         cSjF86b/MNToAntmJB5RbAY/bhs3TqfA4plcoHzc0u6MCEfViwP7+KdfdTTxrAKTamky
         Tyw6Eau1CpxfJ2BU4oKQhUCHZ2p2uwjQRi/Y/iUBGzDWfMivR1BMMHkLnxskRe9XUcQv
         tDTINfeuJRDjTAs66Y877GWpFqyRwxMVpHtXCbvIyezP0GVaEAKeHQG2qZLtsf0MuzaF
         cKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZseS8aSnULurPdZf/si9iNA+qWf4+HN6oG8w6/+geQ=;
        b=g+JgwqoUeYf7xIgzqqkDm6YUWGoxP9HOm96oxxxq6xOBIYKb0q7GMWtdw2O4JY70mb
         M2a5VioNr023T1Z7SVUpLQSfMkFlwR9+nsMcElVmTn5a8kwCFUAAc+Nnfifg0b8h4cTz
         Q/xGE1eDeLo1mZayexMXoqLOu1uoGcZ+yxm/DQeP8wfrDeJFPyk7jKkRbqiPGCBovbq4
         Vowci6pwcqBMJzHGBrmSM1luekBJ/x3Fj64tAgUQ+KmK95VE5/KPY7UgjQTluaQcQlO6
         AD92dKe7Z4WYh4pRGUYyVH7qnndsH4cdKAXcmkfvwpoUMfANbWmu8R4c/2B2nAjmh7DC
         STzA==
X-Gm-Message-State: AOAM533tB6q1y7YBr2rzgNbkl1TT8/V3CaG0uVmwz7ZBmDO+TQBL98l3
        ix5/KCQbi5lRnAsPiqvTvrnG/MqbIEHpwTI6hEdc9Q==
X-Google-Smtp-Source: ABdhPJzC4T3loAglaejl0UiqBemGIs4bGYkYnOW46p5Q/X/h47kR6SkpiVLR0cu/SmxvMk7BPsg5VUwrGtTSagPi+Gg=
X-Received: by 2002:a05:6a00:234f:b029:2c4:b8d6:843 with SMTP id
 j15-20020a056a00234fb02902c4b8d60843mr7547776pfj.71.1622864142613; Fri, 04
 Jun 2021 20:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <fe11bf3c-c0f8-7c25-8fc0-99bee9c1d164@linux.intel.com> <20210527043832.3984374-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210527043832.3984374-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Jun 2021 20:35:31 -0700
Message-ID: <CAPcyv4jQ=Fcga3jyUzthjPW9O962vhy3L5XUM6jqR5Z_Zq83LQ@mail.gmail.com>
Subject: Re: [RFC v2-fix-v3 1/1] x86/tdx: Ignore WBINVD instruction for TDX guest
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

On Wed, May 26, 2021 at 9:38 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Functionally only devices outside the CPU (such as DMA devices,
> or persistent memory for flushing) can notice the external side
> effects from WBINVD's cache flushing for write back mappings. One
> exception here is MKTME, but that is not visible outside the TDX
> module and not possible inside a TDX guest.
>
> Currently TDX does not support DMA, because DMA typically needs
> uncached access for MMIO, and the current TDX module always sets
> the IgnorePAT bit, which prevents that.
>
> Persistent memory is also currently not supported. There are some
> other cases that use WBINVD, such as the legacy ACPI sleeps, but
> these are all not supported in virtualization and there are better
> mechanisms inside a guest anyways. The guests usually are not
> aware of power management. Another code path that uses WBINVD is
> the MTRR driver, but EPT/virtualization always disables MTRRs so
> those are not needed. This all implies WBINVD is not needed with
> current TDX.
>
> So handle the WBINVD instruction as nop. Currently, #VE exception
> handler does not include any warning for WBINVD handling because
> ACPI reboot code uses it. This is the same behavior as KVM. It
> only allows WBINVD in a guest when the guest supports VT-d (=DMA),
> but just handles it as a nop if it doesn't .
>
> If TDX ever gets DMA support, or persistent memory support, or
> some other devices that can observe flushing side effects, a
> hypercall can be added to implement it similar to AMD-SEV. But
> current TDX does not need it.

Please just drop this patch. It serves no purpose especially when the
assertion is that nothing in TDX will miss WBINVD. Why would Linux
merge a patch that has no claimed end user benefit? If the only known
usage of WBINVD in a TDX guest is the ACPI reboot path then add an
is_protected_guest() to that one usage.

If a TDX guest runs an unexpected WBINVD that's a bug that needs a kernel fix.
