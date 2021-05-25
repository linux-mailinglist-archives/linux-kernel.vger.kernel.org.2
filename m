Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8166138F8F0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 05:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhEYDmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 23:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhEYDmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 23:42:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFB0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 20:40:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b7so11505158plg.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 20:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYxoO7yBBzqdzyOxDkIoKwGSFZKwMeGZb66v0c/avEE=;
        b=TffITMriBqjrMlYEwaN2fzQJvKIqqDn6b7MCg3RMNPRHXLbWKZfeb0DcSQMvKvyfWi
         6rmZgeYfuPBncqp5wshTfLLHxK7QGye3ENIZrEbAUOC1XLlE2hObZzuaXodtuwHWyiE9
         urFchfogdnddL40KAwxA8FxatTFJesIJGNHc+7Bt15cGs26MCaM9i5sDI1lsWUqJqG6J
         ooYlqpn/UETWvlnbFquR8BbGNuquIhf0TGeXR9im+rt/mZVHdoGX4LPeKOPagDd2uP0r
         yoqSCabdDkdUZIU4vD07NxuAkdD2LZWuFnZKQiyzOv4fHUFl8qGxqvkh736bmR6ydexu
         OF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYxoO7yBBzqdzyOxDkIoKwGSFZKwMeGZb66v0c/avEE=;
        b=i28xNQgmnJBf9BS4aaiEIQ/w008Fw6YBIdSuFhgiNfqGdYksfBKp96FDudD4dwj7kT
         jtOSrxx87OVX43Pt8/u93LGJFfrI4pGMV4oA2aTr44ESYapUrjZgTohwZSXa+Xi9QtY3
         P53689BC6bEhY61PYDEQ4UAq4nYaB4ZOeuBM5cFcHOyfoLR7+R3ROahp11BUhKa/Qp7S
         T7s4L5oNekg6Uye7FI8btZ+EtB0KeI/SvcS4zNHDuF/B+X5I0KpDLIolSvh/fsOu0Adg
         yLfZswzunCWsNZ14BgRypy78AiyLS1NJ2CcYL9g2/o4icvq3gpSEfXVJlAaRnRiFqpdG
         oGPw==
X-Gm-Message-State: AOAM532V4sW2W0WnOQTyWhX9LensxNSZg5tclprUlo4kgQmosnxygi9Y
        V53YuWPE9w5t/oBNdTpz5UzeEfG+4GhT/j1TljHwHw==
X-Google-Smtp-Source: ABdhPJy0lhM6x8nWUcjp0XKAqxswwG+UAKhML6qiTJF+4cGc7W7i+1LNu0q09OGLEM8Io7176Z+RD2gwrn0tqAJZRJY=
X-Received: by 2002:a17:902:8693:b029:eb:53f:1336 with SMTP id
 g19-20020a1709028693b02900eb053f1336mr28650609plo.52.1621914048846; Mon, 24
 May 2021 20:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <37ad50ca-f568-4c62-56e2-9e9b1f34084c@linux.intel.com>
 <20210524233211.802033-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210524233211.802033-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jKY0rmewFnyL6My5-b+w8ANAwDY2tLXZk4CYKydoVbtg@mail.gmail.com>
 <b420a7af-5202-fee9-9e0b-39680d0cc9c8@linux.intel.com> <CAPcyv4gNz9gKsHVcindp3OsHz4hMRWPZgsNu1A5xrDQg7tYqNA@mail.gmail.com>
 <cea7c704-5f1c-3f84-e47b-c62da18e358e@linux.intel.com> <CAPcyv4h4=eNZFS7d13WvzpWzTkHAMF7Mxo0frqf2gdmaFN3++Q@mail.gmail.com>
 <125f8362-b1e3-d304-f943-3fc2f07b5d79@linux.intel.com> <CAPcyv4gRDnm0y4=RWhvTSoY2sk=BOyeDDNcCifZD=opyJf05LQ@mail.gmail.com>
 <6f44fbeb-a8be-d2e4-5161-d46ddf09482e@linux.intel.com>
In-Reply-To: <6f44fbeb-a8be-d2e4-5161-d46ddf09482e@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 24 May 2021 20:40:42 -0700
Message-ID: <CAPcyv4iLNkWpopY6gN9bXtTxnM3qm0YatwV4jc-zVn-VEYpprw@mail.gmail.com>
Subject: Re: [RFC v2-fix-v2 2/2] x86/tdx: Ignore WBINVD instruction for TDX guest
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
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

On Mon, May 24, 2021 at 8:27 PM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 5/24/2021 7:49 PM, Dan Williams wrote:
> > On Mon, May 24, 2021 at 7:13 PM Andi Kleen <ak@linux.intel.com> wrote:
> > [..]
> >>> ...to explicitly error out a wbinvd use case before data is altered
> >>> and wbinvd is needed.
> >> I don't see any point of all of this. We really just want to be the same
> >> as KVM. Not get into the business of patching a bazillion sub systems
> >> that cannot be used in TDX anyways.
> > Please let's not start this patch off with dubious claims of safety
> > afforded by IgnorePAT. Instead make the true argument that wbinvd is
> > known to be problematic in guests
>
> That's just another reason to not support WBINVD, but I don't think it's
> the main reason. The main reason is that it is simply not needed, unless
> you do DMA in some form.
>
> (and yes I consider direct mapping of persistent memory with a complex
> setup procedure a form of DMA -- my guess is that the reason that it
> works in KVM is that it somehow activates the DMA code paths in KVM)

No, it doesn't. Simply no one has tried to pass through the security
interface of bare metal nvdimm to a guest, or enabled the security
commands in a virtualized nvdimm. If a guest supports a memory map it
supports PMEM I struggle to see DMA anywhere in that equation.

>
> IMNSHO that's the true reason.

I do see why it would be attractive if IgnorePAT was a solid signal to
ditch wbinvd support. However, it simply isn't, and to date nothing
has cared trip over that gap.
