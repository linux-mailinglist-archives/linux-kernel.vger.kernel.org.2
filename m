Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEAE3E1BED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241740AbhHETB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhHETB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:01:57 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E77C0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:01:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cl16-20020a17090af690b02901782c35c4ccso8108350pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8rgxwLRPKfKRs5Day4e6JuDr2G47VjuZVduSzU3YGM=;
        b=uJoC+XvkELEyV96zslG8ZZH8bHHs0oITVSMKlzN2BlwhQl1d98Vp35s4tevlIsXU/j
         Sx4TTfvmbFJ/dsIdq0LWfsQtmXzlXlzTFJjM7jYiWAzrLdWmV1wR5JrSOePwcKdUVErZ
         3HpzVph/MxhiflxWpV0G9eyNVgiAxcECuToU/fvcPMBCA8ChxhCdsGTJwCGhaNArRLvt
         1vJV7DB9zOL3iKrXR/EJUiTvqGNygjgPgc6ycFRPrE0ZM+AGDvW0Jp2G8Nus0lpJsue4
         xCoA4gA4JYIM1UPnEYq0SP3mIwt4nv+tQT3Z33avNvfUmoSLCGi8v5PiWPgJMMFFFWix
         V9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8rgxwLRPKfKRs5Day4e6JuDr2G47VjuZVduSzU3YGM=;
        b=WtRYyLbSFCqDYnK5Eos2/F/c5BgpTHqdti9JM3tXzcim3A8krk9JrJvDpAP7uERYHZ
         0NQjMbN3tB/XotCAEXQyf2NcZ8DTe+75yD/tRHpvgiP4imITeb90G1aJRyTwkhIKgQKY
         674DKQrkbpYaiK9e5nRoRm+Y0HtQilE6owo0ZJjfhlrJrvj0DVrorxQ5b+M9Kc/MHiJc
         ZKlM/nR3wKzbMdCbJugXV1YUdsYKhqb+un/NtXEPo7fQLj/+r563RB3E89aruadxgPPM
         45C4mDwYh1o8hCQfR3gR7ez39HewSM50iy4FOGIAhwUjeTtEobqHoCmEc7nQtNvMMeOU
         mVCQ==
X-Gm-Message-State: AOAM5328t+mNFgawjtYLEuZ+EXZYrY6Uabx2+unZfk4dHLp24wcAVlgF
        CkLoVmCzWheVxc8IuCZ929WRefQU0sST5VGZfXtfTw==
X-Google-Smtp-Source: ABdhPJzREWkvJnn0U5OC8p5NMCWVUuOcpyq4KMj3djWHEKxkVS9biP1Cz0WWbkofTKx6lzHWf8hvfV679eIWNcxcsbY=
X-Received: by 2002:a17:903:22c6:b029:12c:8da8:fd49 with SMTP id
 y6-20020a17090322c6b029012c8da8fd49mr5050471plg.79.1628190102561; Thu, 05 Aug
 2021 12:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com> <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
 <YQuYCePPZEmVbkfc@kroah.com> <YQuZdVuaGG/Cr62y@kroah.com> <YQuaJ78y8j1UmBoz@kroah.com>
 <fdf8b6b6-58c3-8392-2fc6-1908a314e991@linux.intel.com> <YQwlHrJBw79xhTSI@kroah.com>
 <21db8884-5aa1-3971-79ef-f173a0a95bef@linux.intel.com> <YQwpa+LAYt7YZ5dh@kroah.com>
 <1e0967ee-c41e-fd5d-f553-e4d7ab88838c@linux.intel.com>
In-Reply-To: <1e0967ee-c41e-fd5d-f553-e4d7ab88838c@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 5 Aug 2021 12:01:31 -0700
Message-ID: <CAPcyv4h26QmPhJKjtUB-VPc4TP95rBAer78OzkgXncg77tFWVw@mail.gmail.com>
Subject: Re: [PATCH v1] driver: base: Add driver filter support
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 11:44 AM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 8/5/2021 11:09 AM, Greg Kroah-Hartman wrote:
> > On Thu, Aug 05, 2021 at 10:58:46AM -0700, Andi Kleen wrote:
> >> On 8/5/2021 10:51 AM, Greg Kroah-Hartman wrote:
> >>> It's controlled by whatever you want to use in userspace.  usbguard has
> >>> been handling this logic in userspace for over a decade now just fine.
> >>
> >> So how does that work with builtin USB drivers? Do you delay the USB binding
> >> until usbguard starts up?
> > Yes.
>
> That won't work for confidential guests, e.g. we need a virtio driver
> for the console and some other things.
>
>
> >
> >>>> This doesn't help us handle builtin drivers that initialize before user
> >>>> space is up.
> >>> Then have the default setting for your bus be "unauthorized" like we
> >>> allow for some busses today.
> >> We need some early boot drivers, just not all of them. For example in your
> >> scheme we would need to reject all early platform drivers, which would break
> >> booting. Or allow all early platform drivers, but then we exactly get into
> >> the problem that there are far too many of them to properly harden.
> > Define "harden" please.  Why not just allow all platform drivers, they
> > should all be trusted.  If not, well, you have bigger problems...
>
> Trusted here means someone audited them and also fuzzed them. That's all
> a lot of work and also needs to be maintained forever so we're trying to
> do only a minimum set. There are actually quite a few platform drivers,
> it's difficult to audit them all.
>

What's wrong with the generic authorized proposal? The core can
default to deauthorizing devices on the platform bus, or any bus,
unless on an allow list. It's a bit more work to uplevel the local
"authorized" implementations from USB and Thunderbolt to the core, but
it's functionally identical to the "filter" approach in terms of
protection, i.e. avoiding probe of unnecessary unvetted drivers.

[..]
> That's why I think the builtin allow list hook is still needed. Thoughts?

I see nothing that prevents a built-in allow list to augment the
driver-core default. Is there a gap I'm missing?
