Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C93D3E2059
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 03:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243028AbhHFBAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 21:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241665AbhHFBAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 21:00:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01C4C061798
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 18:00:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ca5so13192371pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 18:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7IDk0OOcPz9sjDYMNk5T/RupZIK0JqXEvQggcu39zs=;
        b=1pZjWJu4hLZMNv5w60zzSykGHHIynNfYnmKW0wuP7QWWiZNkQGAwrcrlgTmKqaX1Od
         l2TiIXCxznuo7KCeshlQks4ieeWTYkuq0prskhjY5uPB7DMLA0Q5hedgvJbNdlWEC1X4
         D6/bUGTwlZZEBhbMfggEfD4Ul/Zh73js7m2rs1sA+mmWt4Qod0s/aWEIicv5LoOd5oj/
         zMCjazOXZKyko/1KnawIOtyGIXG9u98Xz771VDgJBRbMSTDh01yqs93xSJxbF1/0wa7M
         4+yrs7V9CEUTA+cdCB4lMKnS+YzKDBa9jF401Z1k/1mi+yhYGuhkWS3XQRlqeT9MhTsR
         FNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7IDk0OOcPz9sjDYMNk5T/RupZIK0JqXEvQggcu39zs=;
        b=GymUYdI8a96tifkOoKPLfLZlHzrayKKbg0NkKN1INJaCb59KFG8H0ojI5oSc74dW4n
         opn9vbtaMZT+EKBazuEnhYAz5yIaf5z/d/ceT2N3/pEOuE1+xVK79EY8kpXqt+xiHM8D
         SpWCLISxL00NwwIa/vtNSiHbqj8//bQvdLtx6ekS75rvKHGK2HJVDc2MBFDyUkNnTEdM
         3SjajwuGLpSyHR+FpOd9hsa5V3rWXyVOzNcRhS2FrlT8Ls4LkyIWvYW0aiWnpo3oOHbP
         R3rLxAKBHVkKaecCEK8HABDvcwOOPqS5+sXlxzG27RY9jLUwe2Eh1Ghi7dj3THki5iqg
         a1ew==
X-Gm-Message-State: AOAM533RSFXpTSqKVFUq3vYQ2cTMFfQsjnAXW5tAMZaLSbutwLRPx3r6
        rs95OKJjKupnhGUmNCciZ3rgL57bvmIBi/9L/bh0vA==
X-Google-Smtp-Source: ABdhPJxE2QKAJPcZukBoS7qcJCom1QZzMm2eoXxCrq0uf8zs/Wv1nkWh/RsJBzeeJnm/88PbSSA+pQbyQtF6OGK0QB0=
X-Received: by 2002:a17:90b:3810:: with SMTP id mq16mr10441923pjb.168.1628211636334;
 Thu, 05 Aug 2021 18:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com> <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
 <YQuYCePPZEmVbkfc@kroah.com> <YQuZdVuaGG/Cr62y@kroah.com> <YQuaJ78y8j1UmBoz@kroah.com>
 <fdf8b6b6-58c3-8392-2fc6-1908a314e991@linux.intel.com> <YQwlHrJBw79xhTSI@kroah.com>
 <21db8884-5aa1-3971-79ef-f173a0a95bef@linux.intel.com> <YQwpa+LAYt7YZ5dh@kroah.com>
 <1e0967ee-c41e-fd5d-f553-e4d7ab88838c@linux.intel.com> <CAPcyv4h26QmPhJKjtUB-VPc4TP95rBAer78OzkgXncg77tFWVw@mail.gmail.com>
 <9b2956f5-3acf-e798-ff0f-002d2d5254db@linux.intel.com>
In-Reply-To: <9b2956f5-3acf-e798-ff0f-002d2d5254db@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 5 Aug 2021 18:00:25 -0700
Message-ID: <CAPcyv4ju0kzUuamiuE=xC_DoEArk1KxD+n+-TUw0LLTWoSj2VA@mail.gmail.com>
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

On Thu, Aug 5, 2021 at 2:10 PM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 8/5/2021 12:01 PM, Dan Williams wrote:
>
> >> That's why I think the builtin allow list hook is still needed. Thoughts?
> > I see nothing that prevents a built-in allow list to augment the
> > driver-core default. Is there a gap I'm missing?
>
>
> Okay so you're suggesting to build the builtin allow list on top of the
> existing framework?
>
> I thought Greg's suggestion was to only rely on user space only.
>
> But if we have a way to change the authorized defaults by device (not
> just bus) from inside the kernel at early boot that could well work.

The default usb authorization is set at device creation time inherited
from controller policy, which is in turn inherited from usbcore
policy. So appending a built-in way to augment that policy further
seems doable.

> Doing it only on the bus level I suspect wouldn't work though.

I think /sys/devices/.../$dev/authorized attribute can be used
generically as the override interface, not that the TDX use case cares
about user overrides, but that was the bulk of the unnecessary
reinvention. That also addresses the ABI confusion so tools like
usbguard don't need to look in 2 places to find a device is not
authorized.

That said, per-device authorization is a little bit different than
per-driver trust. Driver trust is easy to reason about for a built-in
policy, while per-device authorization is easy for userspace to reason
about for "why is this device not talking to its driver?".

So a strawman (I'm willing to watch go up in flames like
driver-filter) is an arch overridable callback in driver_sysfs_add()
as a central location where a device could have its authorization
state set if it has not been previously changed from its
initialization value. That callback could then consider device-name,
bus-name, and/or driver-name for the default authorization.

driver_sysfs_add() should also catch drivers that are manually bound
without a bus.
