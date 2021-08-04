Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B603E092E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 22:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240824AbhHDULz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 16:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239598AbhHDULw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 16:11:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41710C061799
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 13:11:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so10529605pjs.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lSoF03p8b1Z5Nc1r1ep6zuU1PTL9sbSjD74lutL89qs=;
        b=J6Xqf9I5DMW6LfgXHQ0h0/o4nRNKQXqTQ+AXgg/V2QHDZrxY0A0srNX1LgS74xffi/
         HJTPPJ4zPPOxMsByUO/xsb8VuRrTksZS5adff7Re9g/c7oBOEPB1XmJ57T7Ulk6+Bdhz
         iI2QSHQtxnj/QEKt75qXdzCxsRTJtI27FiiYilL8OXu7Xd2PDg4vdrD+QgeZRH06OscO
         DKDAURRWnihF/NrNLRsuRyFztW5NmD3xVqSJTRMPlomyQngs7ZrfDL0TeRT/5fcN1Pjs
         NrYCAkUdX21jy6KKRx8vaVWYidBrKUwou34cqeWYAnDQBOBejphg3bpY7KBX5WAL9Awl
         PSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSoF03p8b1Z5Nc1r1ep6zuU1PTL9sbSjD74lutL89qs=;
        b=Y2D6P/eKHLzLHtrAuIR+l6gvulF8Y/rjmDhmr6QmZ7lHUy5pbsq2NAtDu5qw+L4UR1
         23ZHy2qkF/SM9EZeYuOxmz2lzr7d0RmZObkOhXnAQwFI+ej78NI8YJWWMNw6j+qCgXvW
         OydUZ5Ce92VNMcRqLaQvBQOlVZO9sgFyV6hHIG/Wq678NNSqDec8Bylg66xoWrh/RO2Q
         hdq1G+/UhLoY8Pc+KxMPcNNx28QxHTk2IqYsTaxZYOYpg9vsDMJ9PUmMUBIY+w6gulsv
         tMZX+YG0UJ8ogry88Yv9ou7uSA60ZZ5sqK/10s+uHGXAy+laNFjVCc8cOO5S+nNcxSU3
         CglQ==
X-Gm-Message-State: AOAM533vbe0n3QOYmXf/1f3VYEeZAs7fcCdkGA9Up7XpIQfDAQjDsxJa
        SKvW6XaqZy+fHTEYdQQEBEBm8Ms7EqyBgGChQmS2lQ==
X-Google-Smtp-Source: ABdhPJzNziVYtIOkoXBhMQp/azxjP/x76GkpwQ7esjl+gsDLwrDrFVtktUl8in51X3uFR/ndmk+nF9IS06RItVZQs1A=
X-Received: by 2002:a63:d54b:: with SMTP id v11mr116312pgi.450.1628107898803;
 Wed, 04 Aug 2021 13:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com>
In-Reply-To: <YQrqhYEL64CSLRTy@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 Aug 2021 13:11:27 -0700
Message-ID: <CAPcyv4iEEDCz5719d0vNi=zi=6oN5vctcVfY5P=WQ9j_Zpz6eA@mail.gmail.com>
Subject: Re: [PATCH v1] driver: base: Add driver filter support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 12:29 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Aug 04, 2021 at 10:43:22AM -0700, Kuppuswamy Sathyanarayanan wrote:
> > Intel's Trust Domain Extensions (TDX) is a new Intel technology that
> > adds support for VMs to maintain confidentiality and integrity in the
> > presence of an untrusted VMM.
> >
> > Given the VMM is an untrusted entity and the VMM presents emulated
> > hardware to the guest, a threat vector similar to Thunderclap [1] is
> > present. Also, for ease of deployment, it is useful to be able to use
> > the same kernel binary on host and guest, but that presents a wide
> > attack surface given the range of hardware supported in typical
> > builds. However, TDX guests only require a small number of drivers, a
> > number small enough to audit for Thunderclap style attacks, and the
> > rest can be disabled via policy. Add a mechanism to filter drivers
> > based on a "protected-guest trusted" indication.
>
> So you are trying to work around the "problem" that distro kernels
> provides drivers for everything by adding additional kernel complexity?
>
> What prevents you from using a sane, stripped down, kernel image for
> these vms which would keep things sane and simpler and easier to audit
> and most importantly, prove, that the image is not doing something you
> don't expect it to do?
>
> Why not just make distros that want to support this type of platform,
> also provide these tiny kernel images?  Why are you pushing this work on
> the kernel community instead?

In fact, these questions are where I started when first encountering
this proposal. Andi has addressed the single kernel image constraint,
but I want to pick up on this "pushing work to the kernel community"
contention. The small list of vetted drivers that a TDX guest needs
will be built-in and maintained in the kernel by the protected guest
developer community, so no "pushing work" there. However, given that
any driver disable mechanism needs to touch the driver core I
advocated to go ahead and make this a general purpose capability to
pick up where this [1] conversation left off. I.e. a general facility
for the corner cases that modprobe and kernel config policy can not
reach. Corner cases like VMM attacking the VM, or broken hardware with
a built-in driver that can't be unbound after the fact.

[1]: https://lore.kernel.org/lkml/20170928090901.GC12599@kroah.com/

>
> > An alternative solution is to disable untrusted drivers using a custom
> > kernel config for TDX, but such solution will break our goal of using
> > same kernel binary in guest/host or in standard OS distributions. So
> > it is not considered.
>
> Why is that a goal that you _have_ to have?  Who is making that
> requirement?
>
> > Driver filter framework adds support to filter drivers at boot
> > time by using platform specific allow list. This is a generic
> > solution that can be reused by TDX. Driver filter framework adds a
> > new hook (driver_allowed()) in driver_register() interface which
> > will update the "allowed" status of the driver based on platform
> > specific driver allow list or deny list. During driver bind process,
> > trusted status is used to determine whether to continue or deny the
> > bind process. If platform does not register any allow or deny list,
> > all devices will be allowed. Platforms can use wildcard like "ALL:ALL"
> > in bus_name and driver_name of filter node to allow or deny all
> > bus and drivers.
> >
> > Per driver opt-in model is also considered as an alternative design
> > choice, but central allow or deny list is chosen because it is
> > easier to maintain and audit. Also, "driver self serve" might be
> > abused by mistake by driver authors cutting and pasting the code.
> >
> > Also add an option in kernel command line and sysfs to update the
> > allowed or denied drivers list. Driver filter allowed status
> > can be read using following command.
> >
> > cat /sys/bus/$bus/drivers/$driver/allowed
>
> You added a sysfs file without Documentation/ABI/ update as well?
>
> {sigh}

Argh, my fault, that one slipped through in the internal review.
