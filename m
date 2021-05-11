Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15A837AD83
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhEKSBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhEKSBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:01:12 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F324C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:00:05 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v39so27476857ybd.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BslBRWHM+4cdme20xuuO/o0FHKbwbUaPbtdNmBJo3LU=;
        b=TwuY1ji5xZt7+mKwiBaF5SNDSaL0dbGg1dU7Xyz1vYDyPGqH3ov+II/jeWyH9iJP+u
         R3ZU7S84k3LJ5IPZKhKlyxKtDNdJNNHeCR3EjSZBzKtEQmMZaOKK2VQ85nczzxa5pRZM
         xUXAnI29lnLIiapSRyShbhIlIJaqcLoDBI60sVpMBwWag4kX3oVOu1jzZ+bSQpyMBGD8
         3KYXzxqOGbkvoErikCUrNkvo4zxJDvwAmPzJIt7ejzEYA20yGNswFRPbP2XW6SYuwVVb
         ax4YSjbC1tP25BmoHC1xqvjsCAMe4MJWrEpt4ZWL0M1hxTFdb7X6YaosUgCRUssmZuHr
         B2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BslBRWHM+4cdme20xuuO/o0FHKbwbUaPbtdNmBJo3LU=;
        b=qXOv4A7NWujzmekY48v+PB7Jh6xOa7ctLvZqd928THROnekwfFFI0GNMNJLFrwt/0u
         NqcTXP2UirtoGpcjP8Y6U1LDdMpOyZ5ossyT5uGFmfo31DUYossu06K+DaxwgxbzaU01
         25c1IlrXuPwuyAUJmDBV/gkwzoGBlV5HW9pVKUod17U8prJrwVVliGNPHwnqIZgtZGV7
         +cgIw2QMzBTJTH+CsDu6OGHgEH2Ge1MxKN0Lat8R97HaVGM0bDRU0q+4K6NOItxCsGe6
         yYtnBI0G/75VRFJo9kDu3ZhFkV0PsWKRLQDrIjBnXzPFdZHnfD4EeUL71rSxYsccHEme
         deyg==
X-Gm-Message-State: AOAM531hKid2FzSvp3RgSoETlBG/m/SDEZQxCD9cfF8SUjdEf0wf1JV7
        lySYWzEaHqmraUER8mSA4ROYpIJeGXqbttAXSCrkPQ==
X-Google-Smtp-Source: ABdhPJwDqYiG2hVm1vCvoYoeeT+APZLR6RGHMfcEoH/R9v6KlVOVzGUVNUG5VtBw2c/wp0nl5JtkQDx/PEsu3/sJsIY=
X-Received: by 2002:a25:6003:: with SMTP id u3mr45044151ybb.96.1620756003695;
 Tue, 11 May 2021 11:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210508074118.1621729-1-swboyd@chromium.org> <CAJZ5v0jX4ef+oO95dyFmKC0hnfKR7kSmHKQzD=RHgN51O1w_uQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jX4ef+oO95dyFmKC0hnfKR7kSmHKQzD=RHgN51O1w_uQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 11 May 2021 10:59:27 -0700
Message-ID: <CAGETcx88Qd71hr-VbU-UY0G43SyOJxfVdcqbUY48UdzACPmnmA@mail.gmail.com>
Subject: Re: [PATCH] component: Move host device to end of device lists on binding
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 4:59 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, May 8, 2021 at 9:41 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > The device lists are poorly ordered when the component device code is
> > used. This is because component_master_add_with_match() returns 0
> > regardless of component devices calling component_add() first. It can
> > really only fail if an allocation fails, in which case everything is
> > going bad and we're out of memory. The host device (called master_dev in
> > the code), can succeed at probe and be put on the device lists before
> > any of the component devices are probed and put on the lists.
> >
> > Within the component device framework this usually isn't that bad
> > because the real driver work is done at bind time via
> > component{,master}_ops::bind(). It becomes a problem when the driver
> > core, or host driver, wants to operate on the component device outside
> > of the bind/unbind functions, e.g. via 'remove' or 'shutdown'. The
> > driver core doesn't understand the relationship between the host device
> > and the component devices and could possibly try to operate on component
> > devices when they're already removed from the system or shut down.
> >
> > Normally, device links or probe defer would reorder the lists and put
> > devices that depend on other devices in the lists at the correct
> > location, but with component devices this doesn't happen because this
> > information isn't expressed anywhere. Drivers simply succeed at
> > registering their component or host with the component framework and
> > wait for their bind() callback to be called once the other components
> > are ready. We could make various device links between 'master_dev' and
> > 'component->dev' but it's not necessary. Let's simply move the hosting
> > device to the end of the device lists when the component device fully
> > binds. This way we know that all components are present and have probed
> > properly and now the host device has really probed so it's safe to
> > assume the host driver ops can operate on any component device.
>
> Moving a device to the end of dpm_list is generally risky in cases
> when some dependency information may be missing.
>
> For example, if there is a device depending on the hosting one, but
> that dependency is not represented by a device link or a direct
> ancestor-descendant relationship (or generally a path in the device
> dependency graph leading from one of them to the other), then moving
> it to the end of dpm_list would cause system-wide suspend to fail (the
> hosting device would be suspended before the one depending on it).
>
> That may not be a concern here, but at least it would be good to
> document why it is not a concern.

I've been reading up on the component code and at least one of the msm
drivers that use it. I've also read part of the other thread that's
going on.

If device links work, why not use them? Also, are you trying this with
fw_devlink=on?

Looks like what you are missing (I can't tell without looking at the
DT/your specific driver) is a device link from the DSI bridge to the
I2C bridge/controller? If we add that, will things work properly? If
yes, why not add that?

Also, can you please add me to all the threads on this topic (if you
reply to them) so it's easier for me to reply?

Thanks,
Saravana
