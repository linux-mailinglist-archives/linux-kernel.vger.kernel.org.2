Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DC6345A78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCWJLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhCWJKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:10:55 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC04C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:10:55 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h25so11033748pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WbW5E3Qe4WZYEnKi/sCmjQ1D+Tk7jZ1l2FTPgjhfZMQ=;
        b=yo8DL/aCSBDBcC0tqsQubEuqRWy6eLT5ir9zRrGsKjmyULNbNnccMqMnD7jmadxDw3
         BGBok2NgqzzaR3uNkDmIajtKjfw1xjOqIJ/YLBW7GZNZbbv5CvEI9cgeue+5MtK4BpKN
         S1arzGTW1r4QJhbOQlc9o3b2oa2Lw+Ahw1ZqH5D2F0AMxncx0PgX2TScKhHBj8o47wKQ
         dADPkn6khGV+qRPCxXNv3qWXWtC0UTJPjxleX2xzunTLpcwnYPyR7WxEqEmzwO/kCH97
         BvOa35YvQG7GVC9RhR+xBt2MsYZYMEWcBUIATnocN31bsvzJxFJWzKx+r42IA62GTkkc
         BzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WbW5E3Qe4WZYEnKi/sCmjQ1D+Tk7jZ1l2FTPgjhfZMQ=;
        b=SB5ds5vWEFiy2ss+Pfv9rqQjIOmhjVWERhStBgZvLzr2Eo9LjpPgg7Ig96L78lHADc
         in5QXMtM24UpY140TfYEL9vaunxSVSiW/EROteu3d2Sklfk0z7sHvfW/aqKgoOeD9n4O
         SurhfENXcnu3LI9iyt3MiaunGd7/5zrD0QquZN803q7hYxVcnPW4XRwsSWjBWxOHhKh1
         OrqtcQKUgCy7L2pgawuv2vr/3ZlczpgVAyTWHpVQrxipTWnUTlVb91ktSPgO2cYDdmlE
         Vztuj8+QH0dpsoKO4FMbov52+xyByeYtll9xL7IxA0q0OSAfMYUAMk1LLc57PNqKL0UG
         GWWg==
X-Gm-Message-State: AOAM5300rEIorPnTUv0RvtkFOLhf2WfJ11XPuCteK/8mIYBL+zsuu6+k
        JzF5afcwE9zlKAJKOxollNeF5jvR3hDvZcrwn7mRtxZTUUFvXBIHro0=
X-Google-Smtp-Source: ABdhPJxIS20E4tfWyNlD9+niQr2Ru+nuZgsxwL8HvALaLQyatNmIeXyoZrtnqaDhRUCxdvIm1IRm+HpRgaUET82BHa4=
X-Received: by 2002:a63:ee4b:: with SMTP id n11mr3235216pgk.265.1616490654726;
 Tue, 23 Mar 2021 02:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210308120555.252524-1-adrien.grassein@gmail.com> <20210308120555.252524-3-adrien.grassein@gmail.com>
In-Reply-To: <20210308120555.252524-3-adrien.grassein@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 23 Mar 2021 10:10:43 +0100
Message-ID: <CAG3jFytoE9hWvq2e2Caqn4qP_RuEOnm4r9VQ85ffbAcguSLf+w@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] drm/bridge: Introduce LT8912B DSI to HDMI bridge
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Adrien,

Sorry about the slow reply, but I just received the documentation from
the vendor. So let's dig in to the HPD issue.

> +static enum drm_connector_status lt8912_check_cable_status(struct lt8912 *lt)
> +{
> +       int ret;
> +       unsigned int reg_val;
> +
> +       ret = regmap_read(lt->regmap[I2C_MAIN], 0xC1, &reg_val);
> +       if (ret)
> +               return connector_status_unknown;
> +
> +       if (reg_val & BIT(7))
> +               return connector_status_connected;

Register 0xc0 & BIT(7) - HPD signal after debounce
Register 0xc0 & BIT(6) - HPD signal for TX HPD pad

> +
> +static int lt8912_probe(struct i2c_client *client,
> +        const struct i2c_device_id *id)
> +{
> +       static struct lt8912 *lt;
> +       int ret = 0;
> +       struct device *dev = &client->dev;
> +
> +       lt = devm_kzalloc(dev, sizeof(struct lt8912), GFP_KERNEL);
> +       if (!lt)
> +               return -ENOMEM;
> +
> +       lt->dev = dev;
> +       lt->i2c_client[0] = client;
> +       lt->cable_status = connector_status_unknown;
> +       lt->workq = create_workqueue("lt8912_workq");

Looking at [1] and maybe even better [2], I think this polling
approach is the wrong way to go. And with access to documentation, I
think we should be able to sort this out.

Using the irq driver approach requires the interrupt pin to be
configured. Pin 63 of the lt8912b is the IRQ output pin.

In order to trigger interrupts based on it, the dt-binding would need
to be updated[3][4] as well as whichever DTS you're using.


[1] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/bridge/analogix/anx7625.c#L1751

[2] https://github.com/torvalds/linux/blob/v5.11/drivers/gpu/drm/bridge/lontium-lt9611.c#L1160

[3] https://github.com/torvalds/linux/blob/v5.11/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml#L27

[4] https://github.com/torvalds/linux/blob/v5.11/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml#L144
