Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E9C40BCAE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 02:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbhIOAbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 20:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhIOAbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 20:31:13 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058F9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 17:29:55 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id v2so1776516oie.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 17:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=JukkaUTsG0GonnjXzrW/GiofJ5UBspcWxgvtjkWtQ1U=;
        b=AuuJcS90PlV274We64tcJ6Vja+tX9GL//WLswy6oBmmnJMa7VGj/eLcCwShK9DARKD
         zqdTE/OS/pw60d80+8u2tcQqEkfWV/C87yp9w8+ukZ8gTLV8gDdSQ5jfWgxZwg75mWST
         Y1B1iOoQZ0vvZqXLaavPaARDqld6N0eLdsH/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=JukkaUTsG0GonnjXzrW/GiofJ5UBspcWxgvtjkWtQ1U=;
        b=kIqgFKRg0rz9mVGbJOGCnJNCrOL0hkVtgBiWDme0fMuSSD8FfDkGmNGFFAAWNsMMey
         TOSMqFrkr/eoJq8IbRofMljMZhzOF0gIocHInIVdHe0/tAgGX7m8bbtW60gISILtyy8F
         zzksnuj0Z2zGRPHohwVqElp0IywnY6PjzhGtRit+/4PUrYVMuGx08+YOef8DzAYa/SY1
         Sw6I2m7lHytYPD+yjGvcViY73Gxqz165hjzRTZC+PYUh7r00O+YRyMk4J6ADY8jW9W3Y
         yPrVWJ/AHedSHByGFfto+aEnEYeJoXZVowQW8JUmBSBSv60kje/mcqEjwrZp8f+JQuKn
         9ItA==
X-Gm-Message-State: AOAM532Tu0T5ukqV/OZsipZDGTOzEzRNWeuSQpEqJduL8b73he2nalgs
        mViO9UxDaU0QhgQw1i9UDUSvDxowIa577BssvIfInM/NNOg=
X-Google-Smtp-Source: ABdhPJxeexSkYU4JqkvTpWYP1ROeGk6cSocDZiQTYPtbiYojnNHQl/XbgMWKHp6Oo+RybVeFCkQ1T11g8h9Q9f6LEr0=
X-Received: by 2002:a05:6808:909:: with SMTP id w9mr3380549oih.164.1631665794244;
 Tue, 14 Sep 2021 17:29:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Sep 2021 17:29:53 -0700
MIME-Version: 1.0
In-Reply-To: <20210914162825.v3.2.Ib06997ddd73e2ac29e185f039d85cfa8e760d641@changeid>
References: <20210914162825.v3.1.I85e46da154e3fa570442b496a0363250fff0e44e@changeid>
 <20210914162825.v3.2.Ib06997ddd73e2ac29e185f039d85cfa8e760d641@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 14 Sep 2021 17:29:53 -0700
Message-ID: <CAE-0n53BXh3_6jEW5oTbPA-V=MSaN=RvqaU8uoY9GNOm-0Pv_g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/bridge: parade-ps8640: Use regmap APIs
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

Quoting Philip Chen (2021-09-14 16:28:44)
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index e340af381e05..8d3e7a147170 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -368,6 +396,12 @@ static int ps8640_probe(struct i2c_client *client)
>
>         ps_bridge->page[PAGE0_DP_CNTL] = client;
>
> +       ps_bridge->regmap[PAGE0_DP_CNTL] = devm_regmap_init_i2c(client, ps8640_regmap_config);
> +       if (IS_ERR(ps_bridge->regmap[PAGE0_DP_CNTL])) {
> +               return dev_err_probe(dev, PTR_ERR(ps_bridge->regmap[PAGE0_DP_CNTL]),
> +                                    "Error initting page 0 regmap\n");

This one also doesn't return -EPROBE_DEFER? The dev_err_probe() should
really only be used on "get" style APIs that can defer.

> +       }
> +
>         for (i = 1; i < ARRAY_SIZE(ps_bridge->page); i++) {
>                 ps_bridge->page[i] = devm_i2c_new_dummy_device(&client->dev,
>                                                              client->adapter,
