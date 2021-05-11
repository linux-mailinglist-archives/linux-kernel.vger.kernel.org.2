Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFA037AD04
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhEKRX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhEKRX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:23:28 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:22:22 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id v24so615154oiv.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=kBVcvZUWLveCtoaSFYEtvOho8NuPT8wfogjqViKCem4=;
        b=bGeeaHgkMRAiEzAiOMBkbhFfbfdKjjSITm87Bv0AoChwtUG2c8YAWnI05dia559YuN
         mgiOj1UTWCPm9AJQuBCkVKXICibZtAntxbALaYRvMoCmPGjh3ihHmH8VEXsZLDGlhx3L
         anvf/2nyihKzP4hsUgroUw+uuBy0ugJkx3eB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=kBVcvZUWLveCtoaSFYEtvOho8NuPT8wfogjqViKCem4=;
        b=pblHv7RTJ5UVl2Xxls+UX27zhoeLfaeR7lK/1y+85uoEEKiMmBKN7uuGpV5tc85u13
         sZbxJA/IngJNGre13g+AJLPU1QMoyqAKEbWVEuh3AgWe1wx1AodY8xcwqZ7g0M7ahMOE
         RFCe74k2EGHs+6/Zr+o4+ndBk72t2qMAkswzMEEagA/9PSD0euH7OowpycaNmwGxTinS
         FvxDLWYlWDyI3eYfbTIahp4fKhqfilJrI6HBuITYE+GoGgrQIxg/nCX6+sozkjdtaRKR
         7FWA4Vd97MV4eXM9Ju/0+66yUPk96Bz6hNbT8Fi0ioDWyaZgBna/WpYxs4KHwiVMCDCx
         viyA==
X-Gm-Message-State: AOAM533NmnixXM2kcvTMH9yEetcr75X7pEsUavRPL4F9046PRpd6GJZK
        Hf5xgglKdMdveYF4Dw9UwNKNJSYehB9eJmSz4CQUrA==
X-Google-Smtp-Source: ABdhPJxhtavmqGziqaonlgvaKYkKq+a6axmGzXqcHFibLbDeZ31Hd8hRDkuZP3dRsQcOuXUlmakwitSITitjnH49xhE=
X-Received: by 2002:a05:6808:144e:: with SMTP id x14mr3321270oiv.166.1620753741645;
 Tue, 11 May 2021 10:22:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 May 2021 10:22:21 -0700
MIME-Version: 1.0
In-Reply-To: <20210511144236.GL1336@shell.armlinux.org.uk>
References: <20210508074118.1621729-1-swboyd@chromium.org> <20210511144236.GL1336@shell.armlinux.org.uk>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 11 May 2021 10:22:21 -0700
Message-ID: <CAE-0n5039Zf+60qiQFExN49=iCBBEGC5JVgOQ+cJ8PeYnA=BZg@mail.gmail.com>
Subject: Re: [PATCH] component: Move host device to end of device lists on binding
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Russell King - ARM Linux admin (2021-05-11 07:42:37)
> On Sat, May 08, 2021 at 12:41:18AM -0700, Stephen Boyd wrote:
> > Within the component device framework this usually isn't that bad
> > because the real driver work is done at bind time via
> > component{,master}_ops::bind(). It becomes a problem when the driver
> > core, or host driver, wants to operate on the component device outside
> > of the bind/unbind functions, e.g. via 'remove' or 'shutdown'. The
> > driver core doesn't understand the relationship between the host device
> > and the component devices and could possibly try to operate on component
> > devices when they're already removed from the system or shut down.
>
> You really are not supposed to be doing anything with component devices
> once they have been unbound. You can do stuff with them only between the
> bind() and the unbind() callbacks for the host device.

Got it. The device is not unbound in this case so this isn't the
problem.

>
> Access to the host devices outside of that is totally undefined and
> should not be done.
>
> The shutdown callback should be fine as long as the other devices are
> still bound, but there will be implications if the shutdown order
> matters.
>
> However, randomly pulling devices around in the DPM list sounds to me
> like a very bad idea. What happens if such re-orderings result in a
> child device being shutdown after a parent device has been shut down?
>

Fair enough. I'll cook up a 'component' bus and see if that can fix this
properly. It will add a new device for the aggregate driver that does
the bind/unbind so the host/parent device will still be ordered on the
DPM list at the same place. The new aggregate device will be after the
components and we'll attach the PM ops and shutdown hooks to that.
