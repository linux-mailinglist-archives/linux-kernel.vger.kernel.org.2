Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAEF34F1C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 21:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhC3Tqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 15:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbhC3Tq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 15:46:29 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7492CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 12:46:29 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id o66so18614309ybg.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 12:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6DYqoHmA+zYKq7nKYyDZpLfhv3PQpbvtdseyGxtr+2w=;
        b=J7o+HmrVDPnqlk05er+9iEO0yix6U99sBC6tcMNMjDGJDn20EJaxiybf8++QhkNApK
         N3sQSpSxQf520/WDjOcKHqJHvWVfxEHrLTBZgz0gZFdwjsnJAloM4TmFtV39RE33JdF6
         fmb5XMZabYNyAXQpiGJykMiKifky7e7xaBknmrOL4LJbWmFl5vXiiIozqGKboPlDyhf4
         astdReaFgb+7tDbMbH3p3JIEbGGlOn6wNCC1wKGIc+sgPOom1O4KERLknIiG/CYf7AY3
         98oonNrjp/VgxRtvAO58eXssMmnZZX+WjvUF5UP1UnFr+w4tvX23xUT5+sGJhPoegw6Q
         /dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6DYqoHmA+zYKq7nKYyDZpLfhv3PQpbvtdseyGxtr+2w=;
        b=YaTFYdRm6hoCsBhsYStxSlNH6Tn5/s7r3/dNc9CXBemoMN7GKqHlsQbOxMWfQhOQsQ
         eWYTyQgU6f4MUySfBRdjFhhZXq97kMj5ofdtISu1Fg1Hk7jyD1Ofsvd3YOacQag7SKtf
         qTThbd70MjKnWX7tiN5By2tPxAz8uDhLDSn1x9SeMEGp3g2FmisSsLounKeZ2hOesCTR
         OZS8Ws4SwyLx2395VxyoUPW7bgM71wgVu+3QYiTLbHS8/2wmIG4FZqSCWphR2k+tONj8
         tauKrDKkql3Fk0J+rNcYS3pvOToVgeDA122ZzGcZw3RMpiU32Sm7D7evfsO/BYWtCcjw
         WuAQ==
X-Gm-Message-State: AOAM530mwNIk41UBC+7ewsWuWIqEVdDxZmZ+g97VcXdsnEl1+D3SNEZJ
        w2M/X+3W7g3DYKgvUlMEywrOhBDgbrt+NU9kJSxvhQ==
X-Google-Smtp-Source: ABdhPJwi/ZbH0+s08CVaWjRfNYgE500YFCldoEQ2eRbid+iECt0ft7NXVGlGrXJ+JpwTn7UASmw/L6E8AOoaUlrbgyw=
X-Received: by 2002:a25:698a:: with SMTP id e132mr36525292ybc.412.1617133588489;
 Tue, 30 Mar 2021 12:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210330185056.1022008-1-saravanak@google.com> <161713296600.2260335.7459463781834702722@swboyd.mtv.corp.google.com>
In-Reply-To: <161713296600.2260335.7459463781834702722@swboyd.mtv.corp.google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 30 Mar 2021 12:45:52 -0700
Message-ID: <CAGETcx9W+J2aSKBV-qH0Fe5yoDebcf2+kH8wL061YG7LS_KavA@mail.gmail.com>
Subject: Re: [PATCH v1] of: property: fw_devlink: Add support for remote-endpoint
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 12:36 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Saravana Kannan (2021-03-30 11:50:55)
> > remote-endpoint property seems to always come in pairs where two devices
> > point to each other. So, we can't really tell from DT if there is a
> > functional probe order dependency between these two devices.
> >
> > However, there can be other dependencies between two devices that point
> > to each other with remote-endpoint. This non-remote-endpoint dependency
> > combined with one of the remote-endpoint dependency can lead to a cyclic
> > dependency[1].
> >
> > To avoid this cyclic dependency from incorrectly blocking probes,
> > fw_devlink needs to be made aware of remote-endpoint dependencies even
> > though remote-endpoint dependencies by themselves won't affect probe
> > ordering (because fw_devlink will see the cyclic dependency between
> > remote-endpoint devices and ignore the dependencies that cause the
> > cycle).
> >
> > Also, if a device ever needs to know if a non-probe-blocking
> > remote-endpoint has finished probing, it can now use the sync_state() to
> > figure it out.
> >
> > [1] - https://lore.kernel.org/lkml/CAGETcx9Snf23wrXqjDhJiTok9M3GcoVYDSyNYSMj9QnSRrA=cA@mail.gmail.com/#t
> > Fixes: ea718c699055 ("Revert "Revert "driver core: Set fw_devlink=on by default""")
> > Reported-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
>
> Tested-by: Stephen Boyd <swboyd@chromium.org>

Thanks!

>
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index 5036a362f52e..2bb3158c9e43 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1225,6 +1230,8 @@ static struct device_node *parse_##fname(struct device_node *np,       \
> >   * @parse_prop.prop_name: Name of property holding a phandle value
> >   * @parse_prop.index: For properties holding a list of phandles, this is the
> >   *                   index into the list
> > + * @optional: The property can be an optional dependency.
>
> This bit conflicted for me on linux-next today so I dropped it in favor
> of 3915fed92365 ("of: property: Provide missing member description and
> remove excess param").

Ah looks like a change went into DT git repo but not in driver-core
yet. Yeah, dropping this bit is fine.

Rob/Greg,

I'll leave it to you to deal with the conflict?  I can't send to DT
because the fix needs to land in driver-core because of boot issues
and I can't resolve the conflict in driver-core because the
conflicting change isn't in driver-core yet.

Thanks,
Saravana
