Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD993F5031
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhHWSO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhHWSO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:14:28 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A17C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 11:13:45 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id z128so35758228ybc.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qcrJUn9SIsn9OtjuWFuCLDPINuV6hNlpD1UCcJXEpKA=;
        b=TXhX6kzROMX7aShYApBsIAaTL/0UNLI2yhyqlPz1I1AyHDfKPAGux7G0aKABOlIh6E
         14COCM9PSN/nXqGZwo3uWS2B1FnmkpV9CA88m4ZYeuzvScQMZgXAvmvUhK2TlfwKMVPl
         Xv3Mn2AIJD4unJGAxw4Bf2bB7A02pZ0zmy0wJFmrHsgEgJj6TcwhYhZZZvq7eAmwq6uR
         jGFBxgtszxDNR6tP695CDgQgcowfRy2gr5Pq4F/6EToWr9BQlNx1M7iGQ9ggeq7z1dbg
         tVxgeP+2tWlztMPB7mprWN6vRK683goLVDdA0Xp4ZiRlEF1KpyFtmsLRwSA5dXVoYI7V
         FyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcrJUn9SIsn9OtjuWFuCLDPINuV6hNlpD1UCcJXEpKA=;
        b=bOPmRxldvds2gZJA3Y4IwwNv8XEuwwV7bYSS02Pru4qFzrWxScJnClWiu7RK/ifjXu
         ZgwHIuq49nbtGlVkeP3OT9C38P3d+0+KOWnnR+1FAp3Voc+OwUSZIy8DETr8x7la4tXh
         tlnQvRpf/fsuDFycFDApv6CdqNOjo5XwFSp57xDr8cjSSVeQF9tpS3X5c5dSjanffF/B
         BnJ7PHy1x3SwI2EId8Lto+RVufeFLyGRRq5vZhb4dnMTrJhUs+pDGjvnAllaLwna+se9
         QFRnZZbXKm/agMydXWZ7XHAws7NKwGXimeOsx/GFXS8bLZvXpCZKWuZF6vCh79Tahzas
         jy6Q==
X-Gm-Message-State: AOAM532fwXXAdDk7ACEE7cEUe2GXjWac3N6bFim5d2HGlkQT/5qmc6wH
        rKBYklDmIkMdkHhN6pRk6OXg39CDH9Y9pTrYrnQsdg==
X-Google-Smtp-Source: ABdhPJzqw6BPhf6oRCv5BRo82ewq6xgec0g4rBKEuXqPvbalz4BrNgRFkSM+GKVVNHr1aceAGL/E82+5mc8jUR1HrVw=
X-Received: by 2002:a25:b7c8:: with SMTP id u8mr44633182ybj.268.1629742424526;
 Mon, 23 Aug 2021 11:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210818021717.3268255-1-saravanak@google.com>
 <CGME20210823120849eucas1p11d3919886444358472be3edd1c662755@eucas1p1.samsung.com>
 <0a2c4106-7f48-2bb5-048e-8c001a7c3fda@samsung.com> <YSOfvMIltzWPCKc/@lunn.ch>
In-Reply-To: <YSOfvMIltzWPCKc/@lunn.ch>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 23 Aug 2021 11:13:08 -0700
Message-ID: <CAGETcx_eUE1gLAaqXdLjCb2XxttH20066kXs969khnrEZQ71mA@mail.gmail.com>
Subject: Re: [PATCH v2] of: property: fw_devlink: Add support for "phy-handle" property
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, netdev@vger.kernel.org,
        kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 6:16 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 23, 2021 at 02:08:48PM +0200, Marek Szyprowski wrote:
> > Hi,
> >
> > On 18.08.2021 04:17, Saravana Kannan wrote:
> > > Allows tracking dependencies between Ethernet PHYs and their consumers.
> > >
> > > Cc: Andrew Lunn <andrew@lunn.ch>
> > > Cc: netdev@vger.kernel.org
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> >
> > This patch landed recently in linux-next as commit cf4b94c8530d ("of:
> > property: fw_devlink: Add support for "phy-handle" property"). It breaks
> > ethernet operation on my Amlogic-based ARM64 boards: Odroid C4
> > (arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts) and N2
> > (meson-g12b-odroid-n2.dts) as well as Khadas VIM3/VIM3l
> > (meson-g12b-a311d-khadas-vim3.dts and meson-sm1-khadas-vim3l.dts).
> >
> > In case of OdroidC4 I see the following entries in the
> > /sys/kernel/debug/devices_deferred:
> >
> > ff64c000.mdio-multiplexer
> > ff3f0000.ethernet
> >
> > Let me know if there is anything I can check to help debugging this issue.
>
> Hi Marek
>
> Please try this. Completetly untested, not even compile teseted:
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 0c0dc2e369c0..7c4e257c0a81 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1292,6 +1292,7 @@ DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
>  DEFINE_SIMPLE_PROP(leds, "leds", NULL)
>  DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
>  DEFINE_SIMPLE_PROP(phy_handle, "phy-handle", NULL)
> +DEFINE_SIMPLE_PROP(mdio_parent_bus, "mdio-parent-bus", NULL);
>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
>  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
>
> @@ -1381,6 +1382,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>         { .parse_prop = parse_leds, },
>         { .parse_prop = parse_backlight, },
>         { .parse_prop = parse_phy_handle, },
> +       { .parse_prop = parse_mdio_parent_bus, },
>         { .parse_prop = parse_gpio_compat, },
>         { .parse_prop = parse_interrupts, },
>         { .parse_prop = parse_regulators, },

Looking at the code, I'm fairly certain that the device that
corresponds to a DT node pointed to by mdio-parent-bus will be a "bus"
device that's registered with the mdio_bus_class.

If my understanding is right, then Nak for this patch. It'll break a
lot of probes.

TL;DR is that stateful/managed device links don't make sense for
devices that are never probed/bound to a driver. I plan to improve
device links to try and accommodate these cases nicely, but that's in
my TO DO list. Until that's completed, this patch will break stuff.

-Saravana
