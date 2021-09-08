Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209904040C3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 23:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbhIHVzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 17:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbhIHVzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 17:55:52 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2736EC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 14:54:44 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id y128so4985407oie.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 14:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=id1AC9x8vyJiUkyhS8f6o/K9GxgIl6ioqhTgdnqtmHw=;
        b=No3Q7Hwhui8zWlFb5CeTFJxyT8/3MnSJ7OK4NxBc7YRGvJpjmfXVdHmXiNuWHn4agA
         ZeTwh2NMwGDD2cwVqE6uZCG8udQ+ZXxsBBPJ79QJwPYReN+sOzcTK27HXvtYK1rBzhDi
         hLDZtdx91gW4OvDS4WlgAtwTcswVwJOK279EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=id1AC9x8vyJiUkyhS8f6o/K9GxgIl6ioqhTgdnqtmHw=;
        b=QTcgURBHLKwdxDo4eywk6jjS347R1iI7PQKNa4gJLOx/CV5o+RFUZ/hBwc5owBcWp5
         r/OGsPoyMOF/1i8IcoXreyKqyvdkKfskhRajCrr2ER+ZOhQxs/fX741IUcuw6/GLO5+8
         J0kL+2h5jc6UK4WLCtciDzYPOf9le7PM2uGer4MogA619xVhZAq9GbK8MV/DMP/8/FsS
         BIVI0AuZrDzoY5DWLLpajtyKC3b0ly3Yk+YJ+zH+Fu/qwnM20BTyYnIYORC3fdz+7vRP
         mh79gbSE+dXtBW+thm8u4qnfwLotCbwSGKo7B7dfyKdn4KN2ulqZulREoXUADoHS6HVr
         UUFg==
X-Gm-Message-State: AOAM533on0dDJBLXJ4JkLQ5Hhdj+jS8TloECm69CsaE63s+ayD/uG/ZQ
        WNqfQIFNUYmOi3QN0KgulLpqAeTa+MrzVQd3Rh7fuVHu0oI=
X-Google-Smtp-Source: ABdhPJxWU3grarEQsUaCCHFBb3wbhF7sDBy11V69yCq1eU0H9QPsoF6IVdQIGYwa0KGqsnm3YWxKgwVmNunQEZRB9Ow=
X-Received: by 2002:a05:6808:909:: with SMTP id w9mr3975413oih.164.1631138083381;
 Wed, 08 Sep 2021 14:54:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Sep 2021 21:54:42 +0000
MIME-Version: 1.0
In-Reply-To: <20210908111500.1.I9f6dac462da830fa0a8ccccbe977ca918bf14e4a@changeid>
References: <20210908111500.1.I9f6dac462da830fa0a8ccccbe977ca918bf14e4a@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 8 Sep 2021 21:54:42 +0000
Message-ID: <CAE-0n52ia_Em6GYU-ketmzi4OQxcdux3uLjMGhzVTUJbC0Yz-Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: parade-ps8640: Use regmap APIs
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>
Cc:     dianders@chromium.org, Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-09-08 11:18:05)
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 685e9c38b2db..a16725dbf912 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -64,12 +65,29 @@ struct ps8640 {
>         struct drm_bridge *panel_bridge;
>         struct mipi_dsi_device *dsi;
>         struct i2c_client *page[MAX_DEVS];
> +       struct regmap   *regmap[MAX_DEVS];
>         struct regulator_bulk_data supplies[2];
>         struct gpio_desc *gpio_reset;
>         struct gpio_desc *gpio_powerdown;
>         bool powered;
>  };
>
> +static const struct regmap_range ps8640_volatile_ranges[] = {
> +       { .range_min = 0, .range_max = 0xff },

Is the plan to fill this out later or is 0xff the max register? If it's
the latter then I think adding the max register to regmap_config is
simpler.

> +};
> +
> +static const struct regmap_access_table ps8640_volatile_table = {
> +       .yes_ranges = ps8640_volatile_ranges,
> +       .n_yes_ranges = ARRAY_SIZE(ps8640_volatile_ranges),
> +};
> +
> +static const struct regmap_config ps8640_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +       .volatile_table = &ps8640_volatile_table,
> +       .cache_type = REGCACHE_NONE,
> +};
> +
>  static inline struct ps8640 *bridge_to_ps8640(struct drm_bridge *e)
>  {
>         return container_of(e, struct ps8640, bridge);
> @@ -78,13 +96,13 @@ static inline struct ps8640 *bridge_to_ps8640(struct drm_bridge *e)
>  static int ps8640_bridge_vdo_control(struct ps8640 *ps_bridge,
>                                      const enum ps8640_vdo_control ctrl)
>  {
> -       struct i2c_client *client = ps_bridge->page[PAGE3_DSI_CNTL1];
> -       u8 vdo_ctrl_buf[] = { VDO_CTL_ADD, ctrl };
> +       struct regmap *map = ps_bridge->regmap[PAGE3_DSI_CNTL1];
> +       u8 vdo_ctrl_buf[] = {VDO_CTL_ADD, ctrl};

Nitpick: Add a space after { and before }.

>         int ret;
>
> -       ret = i2c_smbus_write_i2c_block_data(client, PAGE3_SET_ADD,
> -                                            sizeof(vdo_ctrl_buf),
> -                                            vdo_ctrl_buf);
> +       ret = regmap_bulk_write(map, PAGE3_SET_ADD,
> +                               vdo_ctrl_buf, sizeof(vdo_ctrl_buf));
> +
>         if (ret < 0) {
>                 DRM_ERROR("failed to %sable VDO: %d\n",
>                           ctrl == ENABLE ? "en" : "dis", ret);
