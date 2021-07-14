Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1383C7B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbhGNCUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbhGNCUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:20:19 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1716C0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 19:17:27 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id g5so597914ybu.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 19:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtGRkP2Wmindi+aA2Tem/8osxLapjS6fE2xSA3aZ7y8=;
        b=cLAg/lXumymtrJ5mdGcbDDJ1M05ObnQfXyP+Er7BnvhL0VYCZdGzdbKgILX3lHn8U1
         l8L/YWUoIuvJUbg5bkxSBVIWsjXYIWuEjSWXfZnPzLNtAYW7CWLFvEEdrZJNucWk9zhI
         xArbdcMEwxsA3kY64IsnscK41PTe0V92eqln/GSWtYPsa+s162vFtOoZs4Pi63l0r/nR
         E3S3KUNMA2PKq0m7NCLGZctBR8rYLml7JkZuDWgx+rQO+XeNi+SAOXea+wDXoXsG1Y58
         CqupP9lFSSQ+6gZRLKdGWkXDohOIrx/IyVoUFZ6AfE+SmVLTk3gj3S35R3fcIm/lntKi
         sgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtGRkP2Wmindi+aA2Tem/8osxLapjS6fE2xSA3aZ7y8=;
        b=C1wC/AYZHdIFc8kWkBfMLk5FaKZIKi1IPhm7CGIMiiXBN3Ljz4sRxiuUA6f04y7XjM
         S6A2pEIe7Xzx3g+4KNUnbVQ3SFXrS17OSfhqk+RzSo7PJZ6H4vxMxhEV7cSafdTOGDEt
         aCfu/R6ecdZrS4kNKvugAb5d9mO/XVtHw9W5t5fAvWQGKdg6NqKGFTTIze2MeW4iZM9P
         LMrMnuxwnkKG395MekU9+CzPYw/gqB/HqU/dUOYeQeTNtSvN+JcrxnizPtnw50eeKRqh
         oNTLPpiwGkDgCDIQTdH9yesoIyz27OvP9TuSr9Ta4rowMirm14OZ2NMpFCs2EnCObcwd
         LmUA==
X-Gm-Message-State: AOAM533DHtzm8NUveKocaNw8iTUga8Mn0JP3Fvx9kt9vJ+Lok1L/KUQC
        hb86k6Qli97gYhcqQiMiH8pj54L8mRZFFg3Qp6SjvQ==
X-Google-Smtp-Source: ABdhPJzNEdZvqCNOB1vNLQXpTFAjWdjdhGs2uRmDL/1gW2BIzZ/77PKOXtx/iAi6mH63IzqMuuLLv+qS31H88Yup0Fg=
X-Received: by 2002:a25:8b91:: with SMTP id j17mr9948186ybl.228.1626229046590;
 Tue, 13 Jul 2021 19:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210713073946.102501-1-martin.kepplinger@puri.sm> <YO1VowaJ1Impm1U7@kuha.fi.intel.com>
In-Reply-To: <YO1VowaJ1Impm1U7@kuha.fi.intel.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 13 Jul 2021 19:16:46 -0700
Message-ID: <CAGETcx83TDPLwnm+63Wk_bo-mZfkA+XnBZC2GU=WQT60EgnozQ@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tipd: Don't block probing of consumer of
 "connector" nodes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        kernel@puri.sm, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 1:58 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> +Rafael, Saravana
>
> On Tue, Jul 13, 2021 at 09:39:46AM +0200, Martin Kepplinger wrote:
> > Similar as with tcpm this patch lets fw_devlink know not to wait on the
> > fwnode to be populated as a struct device.
> >
> > Without this patch, USB functionality can be broken on some previously
> > supported boards.
> >
> > Fixes: 28ec344bb891 ("usb: typec: tcpm: Don't block probing of consumers of "connector" nodes")
>
> That patch has gone under my radar.
>
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> > hi,
> >
> > at least the boards based on imx8mq-librem5.dtsi suffer from this, possibly
> > more.
> >
> > thanks,
> >                            martin
> >
> >
> >  drivers/usb/typec/tipd/core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> > index 938219bc1b4b..b31aaf57eb3b 100644
> > --- a/drivers/usb/typec/tipd/core.c
> > +++ b/drivers/usb/typec/tipd/core.c
> > @@ -629,6 +629,8 @@ static int tps6598x_probe(struct i2c_client *client)
> >       if (!fwnode)
> >               return -ENODEV;
> >
> > +     fw_devlink_purge_absent_suppliers(fwnode);

Martin,

Please include the comment from 28ec344bb891 that explains why the
function is called.

>
> Why do we have to care about this kind of stuff in the drivers? It
> sounds like something that only affects DT platforms, so why isn't
> this being fixed in the DT core code?
>
> I didn't have time to study this fw_deflink thing yet,

To give some context, fw_devlink (it's NOT limited to DT, but
currently only implemented for DT) parses the firmware and infers the
inter-device dependencies. And it creates device links between
supplier and consumer devices and that has a lot of benefits: No
initcall chicken between drivers, no/lot less deferred probing,
allowing more drivers to be modules, support for sync_state() ops in
drivers, allowing massively asynchronous probing, etc.

There's a lot of nuance and corner cases on how the dependencies are
inferred (without any help from drivers), but simplifying the
explanation to talk about the stuff relevant to this patch: fw_devlink
expects all nodes with "compatible" property to be probed by a driver.
That's what the "compatible" property is used by Linux for.

In this specific case, instead of probing the "connector" with a
driver, the USB framework/this driver directly parses the node based
on the name (why even have the "compatible" property then?) and uses
the info from the node and never probes this DT node. Since this
driver/DT node doesn't follow the norms, this specific driver needs to
inform fw_devlink that this is the case (that it's not going to probe
this DT node). That's what this one line call is doing.

> it is
> completely new to me and unfortunately I'm going on vacation now, but
> it looks like something that has been added to the driver core in a
> haste without enough thinking, and which is now causing problems. Not
> cool.

I'm sorry that you didn't get a chance to look into fw_devlink before,
but it certainly wasn't done in haste :) It took close to 2 years to
get this in and I talked about this in at least 2 of the LPCs. It also
had a trial run to catch issues from 5.12-rc1 (or something early like
that) till 5.12-rc7 and then reverted before 5.12 release. And then
finally enabled again in 5.13-rc1 and merged in 5.13.

-Saravana
