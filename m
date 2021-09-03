Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE883FFCF0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348753AbhICJU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348703AbhICJUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:20:25 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08636C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 02:19:26 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id g14so8593969ljk.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 02:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rp0EGO/pcBNE5nFyNDRlzZhW/qiQU8M3avwR43x/s+8=;
        b=WfXXOZhzjkqlLQVzbuBuTrKUZsJt/MUEjwGKzF4HDJk2MlKZEp/BmnHqvF1cD+3Atb
         kFx+HnIafDVssOl+em2KEtP4hzI0UbaAJN4HiugVLWgEo7aYzaxu6B6dTl4Pq+2GHCGd
         b2mKdzlLyGA6Dj0xBlKkZ4hTJ6jXWFZQVRTwF5cTWaegrEYqdGlxuaeDC3TY4Zxb6DSI
         tY/cEKxYrJsbvZpD449kTut0MzC6l2/MUvdo8SD6UcU29XSS4dobSPk3N6rhHiW2C+fR
         EdxpOs2upiuiz4/AKAvsI02LFG/sQ6uwJmEDwI6DIOlSTC7CWOFTa8VGP3SxQyUAh+Zu
         H3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rp0EGO/pcBNE5nFyNDRlzZhW/qiQU8M3avwR43x/s+8=;
        b=oJG1QyESTwmcOxo6sniSCe5dL+D7AUQCrE4ZBue94cNetERmVOkJ9BW6jc0wDL5VoK
         XXmM7cqgu3vTicHa4Y3RYF4YTqfEDxC+nZ6Z7q/Anbq47OLFOLtn6TD0bi+qpyLgGWrq
         Uy1tW4HrruXt3WgPqtXOWnrmyNCB9dps1eEhJteYfq8LLGXdNGiGMeMlEwFci93QMnt/
         qB99vtVRjwYco0GA/gUKn9I7mS5gwz0jkCl0DNnV89LzPt98oHMGagTHxN0FPCjYvLHG
         dQLfe7xalVEAdeF+uRlNlkxAzMjGiMwXrsu+hAXc70OdR6GTJGIxiJTDLa4RVAoNhmSB
         x/Yg==
X-Gm-Message-State: AOAM533LM0B5PdOaVXaHpItZ/pW8ekT9JidPrM14RL9c54IsQpF8Nc+s
        hzl72okasy5AKqKgwmidHIVeNgCDi4ezBhIuUreu/A==
X-Google-Smtp-Source: ABdhPJxm+ipPBBxNeFC7UXaLGhwAeg4rDigpRO21Sv8HIeu/8jQAE+UczWJ1wlGPHrGCgupwZwslDqryNFoDLjwsLbs=
X-Received: by 2002:a05:651c:158f:: with SMTP id h15mr2128591ljq.249.1630660764228;
 Fri, 03 Sep 2021 02:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210902230442.1515531-1-saravanak@google.com> <20210902230442.1515531-2-saravanak@google.com>
In-Reply-To: <20210902230442.1515531-2-saravanak@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Sep 2021 11:18:48 +0200
Message-ID: <CAPDyKFpP6pSRSw8_OAW8+ZJNH+CwXtfWBNDcD182gQmzqW=O5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] of: platform: Make sure bus only devices get probed
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sept 2021 at 01:04, Saravana Kannan <saravanak@google.com> wrote:
>
> fw_devlink could end up creating device links for bus only devices.
> However, bus only devices don't get probed and can block probe() or
> sync_state() [1] call backs of other devices. To avoid this, set up
> these devices to get probed by the simple-pm-bus.
>
> [1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Tested-by: Saravana Kannan <saravanak@google.com>

Again, this looks like a nice solution to the problem.

One question though. The Kconfig SIMPLE_PM_BUS, should probably be
"default y" - or something along those lines to make sure fw_devlink
works as expected.

Kind regards
Uffe


> ---
>  drivers/of/platform.c | 45 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 74afbb7a4f5e..b010e2310131 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -97,6 +97,48 @@ static void of_device_make_bus_id(struct device *dev)
>         }
>  }
>
> +/**
> + * of_match_only_simple_bus - Check if a device node is only a simple bus
> + * @np: device node to check
> + *
> + * A simple bus in this context is defined as a transparent bus whose child
> + * devices are automatically populated but has no hardware specific
> + * functionality.
> + *
> + * Returns true if the device node is only a simple bus and can never match
> + * with any other specific driver.  Otherwise, returns false.
> + */
> +static bool of_match_only_simple_bus(struct device_node *np)
> +{
> +       /* List of buses that don't have an explicit driver. */
> +       static const char * const of_simple_bus_table[] = {
> +               "simple-bus",
> +               "simple-mfd",
> +               "isa",
> +               "arm,amba-bus",
> +       };
> +       const char *cp;
> +       struct property *prop;
> +       int i;
> +
> +       prop = of_find_property(np, "compatible", NULL);
> +       for (cp = of_prop_next_string(prop, NULL); cp;
> +            cp = of_prop_next_string(prop, cp)) {
> +               bool match = false;
> +               const char *bus = of_simple_bus_table[i];
> +
> +               for (i = 0; i < ARRAY_SIZE(of_simple_bus_table); i++)
> +                       if (!of_compat_cmp(cp, bus, strlen(bus))) {
> +                               match = true;
> +                               break;
> +                       }
> +               if (!match)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
>  /**
>   * of_device_alloc - Allocate and initialize an of_device
>   * @np: device node to assign to device
> @@ -143,6 +185,9 @@ struct platform_device *of_device_alloc(struct device_node *np,
>         dev->dev.fwnode = &np->fwnode;
>         dev->dev.parent = parent ? : &platform_bus;
>
> +       if (of_match_only_simple_bus(np))
> +               dev->driver_override = "simple-pm-bus";
> +
>         if (bus_id)
>                 dev_set_name(&dev->dev, "%s", bus_id);
>         else
> --
> 2.33.0.153.gba50c8fa24-goog
>
