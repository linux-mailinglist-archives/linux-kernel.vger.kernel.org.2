Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CF0424DAB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 09:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbhJGHHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 03:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbhJGHHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:07:13 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90372C061755;
        Thu,  7 Oct 2021 00:05:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y12so5547380eda.4;
        Thu, 07 Oct 2021 00:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wqn76qJv9uCeYt3ifw4xiTG7bBEeRW82kssbj6n+DwY=;
        b=RsVEUBYzV53Sc1xDUhgr1kigVQ2UynziPlwvqxOGOwF+jgUdvUkWnbruoXhSvRKMJg
         0QA9GY1NV+mIbTZijJ9AXKm3D4hXoSHCIAQ8UM3pItoquHvYpk/I6BTz/cDF2SHByl7a
         T2dq6M3/pK5HNcABomX3fWoGtHdUhai5lJvh1d57VZ341hUL7d8/+wye9F895myruAHF
         GSDSRZfpeKnR168UpQ/S3Uz0U3t+C2zqCgU56NH5g7Z4IZR4QkWJYqIHO5KIA+0s/qqc
         W6+YscUOwDuAJrdfb1989oa8KRYnCvN+ZbzFR9J8NCYFuzYj+qXi7/GVSgdUx33Cd136
         oZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wqn76qJv9uCeYt3ifw4xiTG7bBEeRW82kssbj6n+DwY=;
        b=DcGSK6YCX2PIRONJqSIHoFa0xyxiw2N9aoQipsWtj0TvvahhYElyQNfDymTV0+ESPS
         rP87ZkCj5Ei2yUvx+pxW/rCH3Jmz76nBHHNUPcwLinE0BBWQMzyc6Wsz3fs2IUMRF3Dp
         a2QlT9Lsd4+yc0zvlR2mTRPmdK8BCt/ildx5hPjnVk6DrAXhOn2BrAB0/QNi5Pn+EiQz
         SMjt3M4wkgVntrBo5vFNON1sP4xnKZfH1NqRCHvIZgxhf828xCHf7tktmYlARVTCcFna
         BLIovauh3LC0BanonVnDzZx2017S6+aCc0TB5BrXWZ+lvwBL1ViKH6RFRLuYaEzr7l52
         gmnQ==
X-Gm-Message-State: AOAM531BsHG0qRflVHXBdTHhv87xoYKCR1uKbLV5b5M/Pjz2kgsVD41D
        AkzEQuW53ocQrtsyuje0ed6DNz+bmcAhhDwc1B+96mNoHZc=
X-Google-Smtp-Source: ABdhPJzUE8HsjY7/kyV6PcjePjU7eLH4cPaRxilurRHokYB77t73wLTNt9Effos7MxcrBay+PColQjOUnAP/0TynxlM=
X-Received: by 2002:a17:907:62a2:: with SMTP id nd34mr3454447ejc.356.1633590318049;
 Thu, 07 Oct 2021 00:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211007000954.30621-1-zev@bewilderbeest.net>
In-Reply-To: <20211007000954.30621-1-zev@bewilderbeest.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Oct 2021 10:04:41 +0300
Message-ID: <CAHp75VdYBB_FaMr-uKswdvDBdobTYZkiE6ncoALuG+YYVoMwyw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Dynamic DT device nodes
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Frank Rowand <frowand.list@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Kees Cook <keescook@chromium.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Axtens <dja@axtens.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 3:10 AM Zev Weiss <zev@bewilderbeest.net> wrote:
> This patch series is in some ways kind of a v2 for the "Dynamic
> aspeed-smc flash chips via 'reserved' DT status" series I posted
> previously [0], but takes a fairly different approach suggested by Rob
> Herring [1] and doesn't actually touch the aspeed-smc driver or
> anything in the MTD subsystem, so I haven't marked it as such.
>
> To recap a bit of the context from that series, in OpenBMC there's a
> need for certain devices (described by device-tree nodes) to be able
> to be attached and detached at runtime (for example the SPI flash for
> the host's firmware, which is shared between the BMC and the host but
> can only be accessed by one or the other at a time).

This seems quite dangerous. Why do you need that? Why can't device
tree overlays be used?

> To provide that
> ability, this series adds support for a new common device-tree
> property, a boolean "dynamic" that indicates that the device may come
> and go at runtime.  When present on a node, the sysfs file for that
> node's "status" property is made writable, allowing userspace to do
> things like:
>
>   $ echo okay > /sys/firmware/devicetree/.../status
>   $ echo reserved > /sys/firmware/devicetree/.../status
>
> to activate and deactivate a dynamic device.
>
> Because it leans on the OF_DYNAMIC machinery internally, this
> functionality will only work on busses that register for OF reconfig
> notifications and handle them appropriately (presently platform, i2c,
> and spi).  This series does not attempt to solve the "dynamic devices
> further down the tree" problem [2]; my hope is that handling for OF
> reconfig notifications can be extended to other families of devices
> (e.g. individual MTD spi-nor flash chips) in the future.

What about ACPI and software nodes?
How will all this affect the host?

> [0] https://lore.kernel.org/openbmc/20210929115409.21254-1-zev@bewilderbeest.net/
> [1] https://lore.kernel.org/openbmc/CAL_JsqJH+b5oFuSP+KBLBsN5QTA6xASuqXJWXUaDkHhugXPpnQ@mail.gmail.com/
> [2] https://lore.kernel.org/openbmc/20210929220038.GS17315@packtop/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?id=6663ae07d995f5fbe2988a19858b2f87e68cf929


-- 
With Best Regards,
Andy Shevchenko
