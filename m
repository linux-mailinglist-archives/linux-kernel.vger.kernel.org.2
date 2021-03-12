Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5430833865B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 08:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhCLHH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 02:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhCLHHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 02:07:00 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE8AC061761
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 23:07:00 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id j15so1034407vkc.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 23:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlkgJ0e/mATMT1DjnyWZT9jNAGl5EV/7fKkGhZxsPIA=;
        b=kTUcxycJPBqZPZ2dfvWmTTPpNjNojVdSaothU1jLeV5GkspuyxZ35wjnZaI8ijEutH
         2XTazjjtLpippeDNa9tKAga1I830gS3Bed2ZZ14gfyIoR7Mc3MwAJQabMTNMPxLSgbBG
         dC0tWApXA84jZE9y2y/0OWdnRQcblx+9RRYUDeUj3krQONqh1zV/SCnFrpGxuJC7s2e3
         j3wNpm5AFRHejmo5Tld3mIMJP1AreHlb+Nfcd/XI+VprQAjnDm80dKs62zxLaMTKcdiY
         azn9y5DaUZq7OWCzAHREXmQCEXMEEZmhs/gKmp6BbCuFw4O6SN75dmNI48FjTV5bCZ3E
         9mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlkgJ0e/mATMT1DjnyWZT9jNAGl5EV/7fKkGhZxsPIA=;
        b=bj5c3tuN/XLq3pQYngQHAT26fl0WcjdBjuOaYMV4+hZOpesEV6Qa3gaX/Ba7YJBcv8
         LH7fxfxeOWva1Ld9DsZ2Ng6UPrzv0nyem5tAU9Ln62Sizz0q3taDt51+9BH8CapxLi/V
         wzNuQG1DCshYDu1rKVI2CqkoN48cUMf8fu8kvOTMJQXFzne4seSwyvLThe2VOBHo5v10
         iO/xea/a6mMojUtDr69xeAd/tujlbtXLKjouFgNpbX8K3RDThN+W1PO9G8GBUX31ic5i
         xMOgX00kOWVhwmrY3gxGIwcoO+uEtOVoOKr2mO62/dzcm4l0y/6F/vmPk4Y5rPugUDIa
         wKsA==
X-Gm-Message-State: AOAM5326A1ixpRxFwih7Y/D8k51337LqIG/wzG4JP1P0N1VgbFZA4Oqv
        jMz2RxLhHIW7Dimn4GVH+wRjCmY5u14f9ykw07ZsMHy+azE=
X-Google-Smtp-Source: ABdhPJwkZuh6HMgxlvtQV+BJGBqkN4cLWqD+uC35+gkLbrfifKfRtAjyQmT7E/Um3xWlN5Qc85W52joe9ofGBqVeJz4=
X-Received: by 2002:a1f:5c88:: with SMTP id q130mr7170475vkb.14.1615532819455;
 Thu, 11 Mar 2021 23:06:59 -0800 (PST)
MIME-Version: 1.0
References: <20210312052443.3797674-1-badhri@google.com> <YEsLSevhzYja0fwk@kroah.com>
 <YEsLgogC66Fzx7Vk@kroah.com>
In-Reply-To: <YEsLgogC66Fzx7Vk@kroah.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 11 Mar 2021 23:06:23 -0800
Message-ID: <CAPTae5L9GRGCXhM7jUtsiJKhpeuek5dp=_R7G2KVJu73p8XyQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] usb: typec: tcpci: Add tcpc chip level callbacks
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:34 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 12, 2021 at 07:33:45AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Mar 11, 2021 at 09:24:42PM -0800, Badhri Jagan Sridharan wrote:
> > > This change adds chip callbacks for the following operations:
> > > 1. Notifying port role
> > > 2. Notifying orientation
> >
> > This should be 2 different patches, one per callback, right?
> >
> > And where is the code using these callbacks?  We can't add any hooks
> > without in-tree users, as you know.
>
> Ah, your second patch added that, sorry, missed it.
>
> This should be a 4 patch series, remember, only do one thing per patch.

Sure. Will do in the next version.

Thanks,
Badhri

>
> thanks,
>
> greg k-h
