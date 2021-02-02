Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A1A30CBD9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbhBBThQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhBBTgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:36:50 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B25C0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 11:36:09 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id c3so11162729ybi.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 11:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mJRuYCsACyjbu2bTi4zs+lKukZqRlpJel5M3D22wH5U=;
        b=Lq/9seBMFnU+4UyAjSWVG5UnuBUR0c7wil7/tBHsR5KVpgBTzegsn9UhWvcNzqmhvl
         mZmw83KQeTXehx95rDkE5GLviFdWg5hzPfuAIszoAXqpBa/vji0I4q5K/HBbd3HG62xn
         m+dFt5t3SkP0bWztk9w76PPzwBngR5E1MUiTvazUEVECMn+dw2O0MSyV/DIAlnS0HggO
         rdzFtHZE53R0prr13ZZAYjp7vEKcW+Ex+nF3AmHu2pLwDoS+CuyGIWdykgl+EqM1ybHO
         NLALbQnKQkb8mvMtEFB5+QWYm+dVfG9kJ2SrbmR8nyFvY9ELN54VdcoYOSPCoeMYMZtK
         jobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJRuYCsACyjbu2bTi4zs+lKukZqRlpJel5M3D22wH5U=;
        b=qi0VF2ZrmgMFw8iarGZk1tiR4crC16u4ld/ZmRQo3axC0ur9XmTrmGwfOeCrUdTFP6
         c9oTsPd6BmpAke6Cgpu5g40iBjneY+aPBIFmSyAsoiGE7L0UqotlPCH2r7BV7KAm5pr7
         W5uGRFzgaUq0egV1p5ZVmwNivjU3XUipqeQvAvLsGOYqo+94vy2DrXT0W/lvnOJZrgtB
         prAIoNXVWGeM6DtLdcqp1V25FtXcAm8XCBGLO0k1VpgI8IENFABxDMTjz7+mUeXIcv73
         chT1w1pER79f8ZkJU7FLE8hjOsG4iSZyeS+1J4liOlAOb+Oy09Na4yVLSFzeMMsIzMQS
         y2vQ==
X-Gm-Message-State: AOAM533/y0PLM2DaTs3nvreCPNs1HEy/pZaULZUyQKrHY1F8+JVPM3gJ
        Wxx3QuuwzzCwhBdVpzzunZZXXMM9SvLoqBTSpFUsqg==
X-Google-Smtp-Source: ABdhPJz8gu3KaqjHBuCbAj6P0BapdPRW9atnTP1aMeUs9VOBOz5Lkid8nxWj9FHgeK6gAH6eDP3ClYOcs7/r5JQJcGc=
X-Received: by 2002:a05:6902:1025:: with SMTP id x5mr34361582ybt.96.1612294568994;
 Tue, 02 Feb 2021 11:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com>
 <20210202043345.3778765-2-saravanak@google.com> <CAJZ5v0j=ib_0tziOrEtafuezhgihNxh-Tv4-jT57z0b34uUHPw@mail.gmail.com>
In-Reply-To: <CAJZ5v0j=ib_0tziOrEtafuezhgihNxh-Tv4-jT57z0b34uUHPw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 2 Feb 2021 11:35:33 -0800
Message-ID: <CAGETcx_UF8H_Fo-goSgMg8iKjV_+LQvSyxsYXa+q5vmDAAOB8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] driver core: fw_devlink: Detect supplier devices
 that will never be added
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 6:12 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 2, 2021 at 5:33 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > During the initial parsing of firmware by fw_devlink, fw_devlink might
> > infer that some supplier firmware nodes would get populated as devices.
> > But the inference is not always correct. This patch tries to logically
> > detect and fix such mistakes as boot progresses or more devices probe.
> >
> > fw_devlink makes a fundamental assumption that once a device binds to a
> > driver, it will populate (i.e: add as struct devices) all the child
> > firmware nodes that could be populated as devices (if they aren't
> > populated already).
> >
> > So, whenever a device probes, we check all its child firmware nodes. If
> > a child firmware node has a corresponding device populated, we don't
> > modify the child node or its descendants. However, if a child firmware
> > node has not been populated as a device, we delete all the fwnode links
> > where the child node or its descendants are suppliers. This ensures that
> > no other device is blocked on a firmware node that will never be
> > populated as a device. We also mark such fwnodes as NOT_DEVICE, so that
> > no new fwnode links are created with these nodes as suppliers.
> >
> > Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Still ACKed.

Thanks. I didn't want to add your Ack when I made changes since your Ack.

-Saravana
