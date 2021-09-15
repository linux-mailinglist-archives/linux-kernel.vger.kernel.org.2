Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6C440CB92
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 19:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhIORUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 13:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhIORUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:20:43 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4DDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:19:24 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id i12so7158808ybq.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fcARgMDO3sHmRKPtN7f2pmzPFunzoTl53IPz4NJSUaI=;
        b=dKM6iCxT5AAQBmagGlPrp9ttSolaaBPV0lgwA6vmAQjNnNbzqaa3H3COonvJb/XbWm
         2ihe9WBo5GOxOTwRZ+OgyvsAdLwtyZ4SBFC09Uqhjs2cM/B0SpCWhmoU0dfxd1S7IjUs
         CZWLXk+kkWjvkYkMK5CUcd5JAkYdpAyjR1QTWhQ8GNNAk2vvJioOhWoDvUesjf/8GbNO
         Z3eJSYo0cUs/NYdX1pUhkNHeHaY+ogdvGGDQzaWc7gScKuUJ7fcfOqms8y24HmFlDCRT
         XmswJP69F3LoGSvqLSbvmJm0Hwxf7yt+WhMeBbCgFy2kx2NX8vasm/fiKScjoNRqFkRs
         njDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcARgMDO3sHmRKPtN7f2pmzPFunzoTl53IPz4NJSUaI=;
        b=O9W3pSimcuqS+1kiXiXVpvV9gFo0cLrmlocYwHJ6YxU8JvOiM+R6sv5ppAKFyL+ggz
         XmxL9eTQPY7wz+1xZMfcSn9AhvMGuFRM6aXd1f7oo2XYSGgpVsCuFgwm8ESjKZGWOlWJ
         kfbEo5A0JTNLPQfFZDhYvx3YfLnx2VprL5R5JdNGkpk6lD5r0wrnWJJw/Z4OkfVQg9w8
         DMTvc6cro6T4lFKz6x92BkMav3Lt79UiQIKKujNPZeYBRNuZFT2ddK/gAhK3NW18w7f3
         qJXYeGOeNE7h7DeklgkDXUBJqQBIIDwvbsxdrBM48Ivc4ob9MlIUZDbFmqS6/rTJqhZt
         NZgg==
X-Gm-Message-State: AOAM532IalkX2OMDyEZc+vUAYg68Prw2WHWfajc0B8inZ8tjXdI364N6
        k0xPWdqI1/FSH/FFgRbSM7d4VDpke5MBuX9tOp5XqA==
X-Google-Smtp-Source: ABdhPJyO2jRMPKX2+rlE4hInFo5Tt738OyUO7N0J4cYlu9nL/Yd0y23SxmKlAUGsgPZIE8l2eCiodmmbiAd9PAEkuOk=
X-Received: by 2002:a25:b94:: with SMTP id 142mr1334731ybl.508.1631726362131;
 Wed, 15 Sep 2021 10:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210915081139.480263-1-saravanak@google.com> <YUHjvKRX76Jf7Bt5@lunn.ch>
In-Reply-To: <YUHjvKRX76Jf7Bt5@lunn.ch>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 15 Sep 2021 10:18:46 -0700
Message-ID: <CAGETcx8s9iKJnw=LP_p6rtB+Lx7orkKF5hicGWPGc+bL8kpk=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] fw_devlink improvements
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 5:14 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Sep 15, 2021 at 01:11:32AM -0700, Saravana Kannan wrote:
> > Patches ready for picking up:
> > Patch 1 fixes a bug in fw_devlink.
> > Patch 2-4 are meant to make debugging easier
> > Patch 5 and 6 fix fw_devlink issues with PHYs and networking
> >
> > Andrew,
> >
> > I think Patch 5 and 6 should be picked up be Greg too. Let me know if
> > you disagree.
> >
> > -Saravana
>
> You are mixing fixes and development work. You should not do that,
> please keep them separate. They are heading in different
> directions. Fixed should get applied to -rc1, where as development
> work will be queued for the next merge window.

Done.
https://lore.kernel.org/lkml/20210915170940.617415-1-saravanak@google.com/

-Saravana


-Saravana

>
> You are also missing Fixes: tags for the two MDIO patches. Stable
> needs them to know how far back to port the fixes.
>
>       Andrew
