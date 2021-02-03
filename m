Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3292230DBD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhBCNvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:51:37 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44260 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhBCNvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:51:18 -0500
Received: by mail-ot1-f45.google.com with SMTP id e70so23335942ote.11;
        Wed, 03 Feb 2021 05:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8HkciKMM6o9dgVPvicJ6NQscrL/NEhPkMR7TexeH8o=;
        b=Iv8jUhHiFJjOgjVpp2JT/dmqWs/EQx3jNR4zgiATv8y33L1ojJsGNYEmMft4f+wVvq
         +eRIsz4f9K9KujJMdphSS6cGTgscOKVWY+QzKLkhOK42NMKRvjSRShEMqkIBDdoiKJpz
         WbCNpOXr8L7AXw4Yz9VMQEIE7cisWEYoE2flgT+slJ4qaWRbF9cUnqyuEyG39M6BFYzS
         Xn930h9APOYrcbDbjojJzhznby3Cu/GADCxHMNjkkuEClVZHyTRJZGTUxeKt7pLGSCOV
         /hHBKIErG7spoYtcCkpcj4RCpiyENQHEe9g9PtzuK0aLBm22u64DlTn9YLqx40k366kU
         /Uag==
X-Gm-Message-State: AOAM530HiQyCNsOW20LOEPAwubf430jtiezF5ndZxC82rHPK0EEEsbjx
        ax/97H985/QdNczB0jgA6jc3+LpGWx9A7+4eyxUWaO37
X-Google-Smtp-Source: ABdhPJy/w6aat1SNPMJE/L6i1l3uurPRYogijtTl2hxq2ZlTgvLCSnwnTz5m6d4DxbBI39pPaNNaOQ8Qz07h19BezGQ=
X-Received: by 2002:a05:6830:2313:: with SMTP id u19mr2184762ote.321.1612360236609;
 Wed, 03 Feb 2021 05:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20210202125032.64982-1-heikki.krogerus@linux.intel.com>
 <20210202125032.64982-2-heikki.krogerus@linux.intel.com> <CAJZ5v0gMEBV=Gm-R=5zkN-J_p7cMTBwoOJrv=ec1j6SfSYRg_w@mail.gmail.com>
 <20210202150102.GA1687065@kuha.fi.intel.com> <CAJZ5v0hVZBhqzLPGPHDZYPcYyJPfwgYwjzKGYaUMZOBw7Eh7CQ@mail.gmail.com>
 <20210203094535.GC1687065@kuha.fi.intel.com>
In-Reply-To: <20210203094535.GC1687065@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Feb 2021 14:50:24 +0100
Message-ID: <CAJZ5v0j6oY=hXOJtoJ=_vdWqwLDDAO8SJoG1N3nehaAcAz8G8w@mail.gmail.com>
Subject: Re: [PATCH 1/6] software node: Provide replacement for device_add_properties()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 10:45 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Feb 02, 2021 at 05:08:40PM +0100, Rafael J. Wysocki wrote:
> > It looks like there is a use case that cannot be addressed by using
> > device_add_properties() and that's why you need this new function.
> >
> > Can you describe that use case, please, and explain what the problem
> > with using device_add_properties() in it is?
>
> The problem with device_add_properties() is that it gives false
> impression that the device properties are somehow directly attached to
> the devices, which is not true. Now, that should not be a major issue,
> but it seems that it is. I think Lee Jones basically used that as an
> argument to refuse changes (and pretty minor changes) that would have
> allowed us to use software nodes with the MFD drivers.
>
> Nevertheless, I was not planning to provide a replacement for it
> originally. We do in any case have the real issue caused by that
> device_remove_properties() call in device_del() which has to be fixed.

What's that issue, specifically?

> I started to fix that by moving device_add_properties() under
> drivers/base/swnode.c so I can implement it like I've implemented now
> that new function, but after that when I started to tackle the second
> issue by removing the subsystem wrappers like
> platform_device_add_device_properties() and replacing them with things
> like platform_device_add_software_node() in order to give the drivers
> a chance to actually use software nodes, I realised that there isn't
> much use for device_add_properties() after that.
>
> Also, even though I'm not super happy about adding more API to this
> thing, this function - device_create_managed_software_node() - I do
> like. Not only is it implemented so that we don't have to rely on
> anything else in drivers core in order to achieve the lifetime link
> with the device, it is also much more descriptive. The function name
> alone does not leave any questions about what is going to happen if
> that function is called. You'll end up with a software node that just
> happens to be attached to the device.
>
> On top of those two things, by adding the new function it also gives
> me a nice stepping stone to do these changes in the normal stages:
>
>         1. Add feature/modification.
>         2. Convert users.
>         3. Cleanup.
>
> And finally, even though we may not have any users left for
> device_add_properties() after I have updated all the subsystems and
> drivers, this new function will still be useful. That is because, even
> though it can be used as a drop-in replacement for
> device_add_properties(), it does add that one small but important
> change. It allows the nodes created with it to be part of node
> hierarchy, and that alone is useful to me, and I'm planning on using
> that feature later.
>
> I'm sorry about the long explanation.

No need to be sorry,  now I know what this really is about. :-)

I'm not against this patch, but I IMO the "motivation" part of the
changelog needs to be improved.

If the final goal is to get rid of device_add_properties(), please
spell it out and say what problems there are with it and why the new
function will be better.
