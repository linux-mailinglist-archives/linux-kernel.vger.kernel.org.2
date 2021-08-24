Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E266A3F5908
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbhHXHcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbhHXHcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:32:36 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8EAC061764
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:31:43 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i8so39181475ybt.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nAbhJg9KzDnSNui0yJFPZ9VTbEY+6KHkXkiM9wTMo7U=;
        b=nw4GMUAkEusgHcP8d+XatSp56K8mVrgcAEDxlvnhk5nj3gCmkWNUhunL8PbtN2+Su2
         aAE8EeODCWz5wgPJtYsnyCsiaBlaonNAUyXmi49vtlFPWD+bIzy9D9MtWMGtg2UddqPY
         frTZm0fjszj+0N3xpRKkIhJT8Hvl1lpr4Dt+Lf//YDmw+FID7xex/zLoXT76jJ0ohc7F
         2E62YNsI9hbs4mxQncZc6hIvbELPWQhroUCkJLB5QuCJ/WmKemulF0GYj63+xCG4dQFq
         UjDRMt2JEPyRRu7U0qIMdJpC/puZIpFCl2Z71FWFkrC5UnIFWGpK1nImA0Oy4nhku4CO
         acUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nAbhJg9KzDnSNui0yJFPZ9VTbEY+6KHkXkiM9wTMo7U=;
        b=bajEpGMj3QDKFsuuA96Ia5qrAN92jHD8Ix2yvA2deTGW3zLpH31bYKipO8Ibi7p6Cv
         KZlk1RFv8Y7SG0Ah58azcSE5M2hbX9ucaU+ovLa3fnsFqf/jc2k7WpZvV1tIkkT1C5sa
         sfSnWDD22PXG0Onzzmb1PJBdAfz0psH5+QXJoGboUjExv7ifgXeXq1GaU80XYfTF3NNR
         bASYIaws9QmTI3B2d3IIYIu/J+dcUDlonOe5fPqthKBtufQZ3lQWRLQI9VPyx3q0GgBm
         7iN6VvlLiTr4ZZ/Pyy3OC2qFbpPSy8enXH9FLq8s7PeRxYpXCjgu1N+v+cJEhaA5mPdc
         8k+w==
X-Gm-Message-State: AOAM533Z+HNZXHSZGJ2zj6gGq+tgzqwos+lGh55Qe4vMloAwjwWNzrBc
        zIxJ0pjk1wHeP3YVOJwIZvbd6BNhni7xEhw56auCeg==
X-Google-Smtp-Source: ABdhPJymfsqgvR+b9ZJBIHgV7DoRSEBfuTSnP4UhGjvYXCirnQKW+aO1kLAlKKbxF8PIZ0jHatdmxdXWNg621TxPflU=
X-Received: by 2002:a25:da50:: with SMTP id n77mr19168506ybf.96.1629790302026;
 Tue, 24 Aug 2021 00:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210823120849eucas1p11d3919886444358472be3edd1c662755@eucas1p1.samsung.com>
 <20210818021717.3268255-1-saravanak@google.com> <0a2c4106-7f48-2bb5-048e-8c001a7c3fda@samsung.com>
 <CAGETcx_xJCqOWtwZ9Ee2+0sPGNLM5=F=djtbdYENkAYZa0ynqQ@mail.gmail.com> <427ce8cd-977b-03ae-2020-f5ddc7439390@samsung.com>
In-Reply-To: <427ce8cd-977b-03ae-2020-f5ddc7439390@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 24 Aug 2021 00:31:05 -0700
Message-ID: <CAGETcx8cRXDciKiRMSb=ybKo8=SyiNyAv=7oeHU1HUhkZ60qmg@mail.gmail.com>
Subject: Re: [PATCH v2] of: property: fw_devlink: Add support for "phy-handle" property
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 12:03 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi,
>
> On 23.08.2021 20:22, Saravana Kannan wrote:
> > On Mon, Aug 23, 2021 at 5:08 AM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >> On 18.08.2021 04:17, Saravana Kannan wrote:
> >>> Allows tracking dependencies between Ethernet PHYs and their consumers.
> >>>
> >>> Cc: Andrew Lunn <andrew@lunn.ch>
> >>> Cc: netdev@vger.kernel.org
> >>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >> This patch landed recently in linux-next as commit cf4b94c8530d ("of:
> >> property: fw_devlink: Add support for "phy-handle" property"). It breaks
> >> ethernet operation on my Amlogic-based ARM64 boards: Odroid C4
> >> (arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts) and N2
> >> (meson-g12b-odroid-n2.dts) as well as Khadas VIM3/VIM3l
> >> (meson-g12b-a311d-khadas-vim3.dts and meson-sm1-khadas-vim3l.dts).
> >>
> >> In case of OdroidC4 I see the following entries in the
> >> /sys/kernel/debug/devices_deferred:
> >>
> >> ff64c000.mdio-multiplexer
> >> ff3f0000.ethernet
> >>
> >> Let me know if there is anything I can check to help debugging this issue.
> > I'm fairly certain you are hitting this issue because the PHY device
> > doesn't have a compatible property. And so the device link dependency
> > is propagated up to the mdio bus. But busses as suppliers aren't good
> > because busses never "probe".
> >
> > PHY seems to be one of those cases where it's okay to have the
> > compatible property but also okay to not have it. You can confirm my
> > theory by checking for the list of suppliers under
> > ff64c000.mdio-multiplexer. You'd see mdio@0 (ext_mdio) and if you look
> > at the "status" file under the folder it should be "dormant". If you
> > add a compatible property that fits the formats a PHY node can have,
> > that should also fix your issue (not the solution though).
>
> Where should I look for the mentioned device links 'status' file?
>
> # find /sys -name ff64c000.mdio-multiplexer
> /sys/devices/platform/soc/ff600000.bus/ff64c000.mdio-multiplexer
> /sys/bus/platform/devices/ff64c000.mdio-multiplexer
>
> # ls -l /sys/devices/platform/soc/ff600000.bus/ff64c000.mdio-multiplexer
> total 0

This is the folder I wanted you to check.

> lrwxrwxrwx 1 root root    0 Jan  1 00:04
> consumer:platform:ff3f0000.ethernet ->
> ../../../../virtual/devlink/platform:ff64c000.mdio-multiplexer--platform:ff3f0000.ethernet

But I should have asked to look for the consumer list and not the
supplier list. In any case, we can see that the ethernet is marked as
the consumer of the mdio-multiplexer instead of the PHY device. So my
hunch seems to be right.

> -rw-r--r-- 1 root root 4096 Jan  1 00:04 driver_override
> -r--r--r-- 1 root root 4096 Jan  1 00:04 modalias
> lrwxrwxrwx 1 root root    0 Jan  1 00:04 of_node ->
> ../../../../../firmware/devicetree/base/soc/bus@ff600000/mdio-multiplexer@4c000
> drwxr-xr-x 2 root root    0 Jan  1 00:02 power
> lrwxrwxrwx 1 root root    0 Jan  1 00:04 subsystem ->
> ../../../../../bus/platform
> lrwxrwxrwx 1 root root    0 Jan  1 00:04
> supplier:platform:ff63c000.system-controller:clock-controller ->
> ../../../../virtual/devlink/platform:ff63c000.system-controller:clock-controller--platform:ff64c000.mdio-multiplexer
> -rw-r--r-- 1 root root 4096 Jan  1 00:04 uevent
> -r--r--r-- 1 root root 4096 Jan  1 00:04 waiting_for_supplier
>
> # cat
> /sys/devices/platform/soc/ff600000.bus/ff64c000.mdio-multiplexer/waiting_for_supplier
> 0
>
> I'm also not sure what compatible string should I add there.

It should have been added to external_phy: ethernet-phy@0. But don't
worry about it (because you need to use a specific format for the
compatible string).

-Saravana

>
> > I'll send out a fix this week (once you confirm my analysis). Thanks
> > for reporting it.
>
> Best regards
>
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
