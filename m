Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A2C3106BB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhBEIbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhBEIbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:31:31 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B408C06178B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 00:30:50 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id r12so10506303ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 00:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+ylPOmVqxiwI3Mekr9xiE5Ov1z7xP6kqenxfg8J3H8=;
        b=oa8tmGM+AmeFGtvqDJCuZkdvBIJN7ltjyDQe8/Nr7zCn4xfCihxZAlowFHMnUiA4Hh
         7K/YRitiR0/G7MpGf/nU+5aemA1UZ7139JzG8SLWaeU+xGOBXuSKk9CUT9KiOhEkcrUg
         xqb2ITyP7MNpVeM0KUyAK7MrqDV/lBiK/ZRj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+ylPOmVqxiwI3Mekr9xiE5Ov1z7xP6kqenxfg8J3H8=;
        b=A7ud7vEngbezjosb1VnQV9+w5OtZQ3hqliV7qq79uQjmbOI8KkQrx1x97k5iaYFdOj
         RV0IGfhwjr5W+llsADpPM8BiagIF01XejwUp8JxESC/IndeYPsFyGptBZhphf95sEMPu
         WOxZvsJdCV6UkomJZdIT77jdvaUSo6TD1y2uYMSuPRuMq/z+6YEYu0ecT/RvZOU629Ff
         x0uR6TXGICC31fdxZUGBC3s6bT+MzZJSjzGxwlxw7rIkcwf6OvF8P991bQ4QIGz9rqVl
         to/ZH04Lu/oSMONBwvlzEw2lAH7Q4Cn6uKujI7ZcqoahsSu5OeHUiBL/jwkVqZnr0yeS
         JSUQ==
X-Gm-Message-State: AOAM530KVhjtCA7iDSeAix5G7F1CG1Zo3sXZK8+YXwxCT+xAMSVEt/k5
        XdEJ4kPkOka0cNFbAABqVyCyadOQEs611lltR06uVQ==
X-Google-Smtp-Source: ABdhPJyrgtcgk1gvRXUJeAHKakFmL/Gl9g9udzyY62k9eYBNyjE7YAy+aSD8k+pxV1stsSIWt2joswrMvstVkMdJkKA=
X-Received: by 2002:a17:906:8252:: with SMTP id f18mr3041674ejx.418.1612513848888;
 Fri, 05 Feb 2021 00:30:48 -0800 (PST)
MIME-Version: 1.0
References: <20210203071256.42050-1-jagan@amarulasolutions.com>
 <20210203071256.42050-2-jagan@amarulasolutions.com> <YBx1T3U1pNaLfJLQ@pendragon.ideasonboard.com>
 <ae346027-a58e-e773-60ce-92a79f0d99d6@denx.de>
In-Reply-To: <ae346027-a58e-e773-60ce-92a79f0d99d6@denx.de>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 5 Feb 2021 14:00:37 +0530
Message-ID: <CAMty3ZApHx=o5SR14nL62Mc9Skd3a0HJyqsZVW06NBiF7uwR=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm: bridge: Add SN65DSI84 DSI to LVDS bridge
To:     Marek Vasut <marex@denx.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 4:50 AM Marek Vasut <marex@denx.de> wrote:
>
> On 2/4/21 11:29 PM, Laurent Pinchart wrote:
> > Hi Jagan,
> >
> > Thank you for the patch.
> >
> > On Wed, Feb 03, 2021 at 12:42:56PM +0530, Jagan Teki wrote:
> >> SN65DSI84 is a Single Channel DSI to Dual-link LVDS bridge from
> >> Texas Instruments.
> >>
> >> SN65DSI83, SN65DSI85 are variants of the same family of bridge
> >> controllers.
> >>
> >> Right now the bridge driver is supporting a single link, dual-link
> >> support requires to initiate I2C Channel B registers.
> >
> > MArek Vasut (on CC) has very recently posted a driver for the SN65DSI86.
> > Should the two drivers be merged together ?
>
> Since Jagan's V1 was out first, I will let Jagan pick whatever might be
> useful from the driver I posted, probably the O(1) clock rate
> calculation and some of the regmap stuff, and once there is some merged
> result, I am happy to test it on my hardware. The DSI83 is I think the
> same as DSI84, except with half of the channels.

Thanks. please wait for the v3 series, we can discuss further on top.

Jagan.
