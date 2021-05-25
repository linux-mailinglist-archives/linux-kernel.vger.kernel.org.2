Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867D638F719
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 02:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhEYAwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 20:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhEYAwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 20:52:13 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3475C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:50:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n8so10269493plf.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypHKpyRTob+xrgfwU5gGLsKAe8BKVFOM0sRqnb3sj+E=;
        b=SXAGlGz12w/hj2kefafkJ/glyQo61147RyvoAyOQLTctRXwWe8J8Mrl8/MZ3ZDqPm2
         Qe8dh0NHy5YEuUpXhd/9ST/wNFNn5+pfXXPoFVjam1iJ8/sRV3ClycXeStDk/6pQdlOX
         xQcYC5/20tMt3Ug5yfhBM48bQ7QAi72CLQ+CivRgzMbKhoA4KErL6BXo4YwbBSJ3DY33
         gm02oDjUHRZB6jcCCTDvnmSMusRTJg7Gk82hdxRdwXNW2ekT93RHFWKqytRq8nbj6rwR
         /aSH55zBsWGCpNPhm//d6sJFochLT//85ldaC8WILCEPNl43SCru/TKqR9VVhTrE2LRP
         VlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypHKpyRTob+xrgfwU5gGLsKAe8BKVFOM0sRqnb3sj+E=;
        b=X6F4CStUkpF/ufM/jR6uvUAUoKNJJc64FCdmBcFKx7Zh5UzIKuUAdXncrKIHVa+kf/
         f04+wjzeFzBuE1YR948GTdBBh5c2soY4K2ss/I27lLj4ckyktW+l3uK1nrMOe+uF8y7n
         f6k/FUWryx5/YyUxxmR4i3RCOweirVaq/6WsEsr3FLQOixmI7IPt44RnttbJGMV2wlsM
         6IV94RSryafoW7hQCQk7bx6JdSRDYarZ5xwTrNdjxprMbmJEXqUqA3zs2J5Bh6uiG2T3
         54FtWwWscF4imuWp3arhRi8e42QBzqf44X0ia+d9LINNCvQH+0pdQ5giHqnnIYhUleLs
         a2+w==
X-Gm-Message-State: AOAM530ztX8u+56FT122jO/IOq4fhnRIUqYwtKA9jNjvKIrPMTphMpfC
        mfW6IMATU/xpJ8k8yVk4Xa974scxGXR76+xKErjWktY7YA4=
X-Google-Smtp-Source: ABdhPJz1w49aF5ykWYclIUAXcDMV6iYhe0z3N1OSBVOO2gVN2KALi2qy6i898NpzS8jzVUr+tK9btCKfjNyWRzGgR+o=
X-Received: by 2002:a17:90b:3709:: with SMTP id mg9mr1885892pjb.149.1621903844281;
 Mon, 24 May 2021 17:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <37ad50ca-f568-4c62-56e2-9e9b1f34084c@linux.intel.com>
 <20210524233211.802033-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210524233211.802033-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jKY0rmewFnyL6My5-b+w8ANAwDY2tLXZk4CYKydoVbtg@mail.gmail.com> <b420a7af-5202-fee9-9e0b-39680d0cc9c8@linux.intel.com>
In-Reply-To: <b420a7af-5202-fee9-9e0b-39680d0cc9c8@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 24 May 2021 17:50:37 -0700
Message-ID: <CAPcyv4gNz9gKsHVcindp3OsHz4hMRWPZgsNu1A5xrDQg7tYqNA@mail.gmail.com>
Subject: Re: [RFC v2-fix-v2 2/2] x86/tdx: Ignore WBINVD instruction for TDX guest
To:     "Kuppuswamy, Sathyanarayanan" 
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

On Mon, May 24, 2021 at 5:30 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 5/24/21 4:39 PM, Dan Williams wrote:
> >> Functionally only DMA devices can notice a side effect from
> >> WBINVD's cache flushing. But, TDX does not support DMA,
> >> because DMA typically needs uncached access for MMIO, and
> >> the current TDX module always sets the IgnorePAT bit, which
> >> prevents that.
>
> > I thought we discussed that there are other considerations for wbinvd
> > besides DMA? In any event this paragraph is actively misleading
> > because it disregards ACPI and Persistent Memory secure-erase whose
> > usages of wbinvd have nothing to do with DMA. I would much prefer a
> > patch to shutdown all the known wbinvd users as a precursor to this
> > patch rather than assuming it's ok to simply ignore it. You have
> > mentioned that TDX does not need to use those paths, but rather than
> > assume they can't be used why not do the audit to explicitly disable
> > them? Otherwise this statement seems to imply that the audit has not
> > been done.
>
> But KVM also emulates WBINVD only if DMA is supported. Otherwise it
> will be treated as noop.
>
> static bool need_emulate_wbinvd(struct kvm_vcpu *vcpu)
> {
>          return kvm_arch_has_noncoherent_dma(vcpu->kvm);
> }

That makes KVM also broken for the cases where wbinvd is needed, but
it does not make the description of this patch correct.
