Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D944B40BCC9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 02:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhIOA6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 20:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhIOA6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 20:58:37 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0C4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 17:57:19 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so1236515otf.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 17:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=A+8E2Y0vn6pdEtI3eg1yYcrgDg6slBoozFfrvzmkDcg=;
        b=FDTRV2auKoz4uUsAoyif0Q11y2E562FCDY7HCF7DFrPkkI6Kfce2CyG8oB/DMgR+0q
         LGmgXs3MLsFmNga+bucZQniDLmW5O9s6p5QExDDHdx0QpYQHBkx3epWlMnq/D3AGc6lp
         pFaf8Ctzrx53uDIsf1X7WHwfjRPnMAELSSL1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=A+8E2Y0vn6pdEtI3eg1yYcrgDg6slBoozFfrvzmkDcg=;
        b=Ear6JgN5AN1hD+heFJqPNdQidAeQfzUOQwkdsFte0E4MAmbSHUkarP6V2UZRtda4Zx
         LmvaDmsA9+8NiepKCAsFpF0WFQNnK41V/HL2aOy1JUgqzsndc8mFHrg7BUV4i9iT17fa
         FOr/x2fzFJe9+q6smQWmNrJnIcEDER/BwvquHxMZFHp16LhALcahtCGpq/75yGvTKDLE
         S8BZZfIM6Ga7qeOofEGGKcFBWLotWwV/SBwOJqjJuMFiu7gVIYObmOvvJr8pN82zEJtm
         cR3McjvaeziF3cY/N1cImwZ6lj7BwMEirrfs4axJUj+jh8J+KM06NJe12wuo5HQ29T4f
         HDrw==
X-Gm-Message-State: AOAM5302ZkIpYACLxkTxiEfx9nespcvh++pkfaBXM8XVx8b6WI+bleRd
        h3Aa7Y4stS7U9oQ5OrqGvcdgN/7HypLbiVhYqlgvIGG2/98=
X-Google-Smtp-Source: ABdhPJwhCQ4YlSpqKn4QcawGKsoKnUPsrOU6EgMd9jfkqCyoLjwLS+kyW1x+b1hMSt3cYBytE10AaSLnR4fGJxqsgWY=
X-Received: by 2002:a05:6830:18c7:: with SMTP id v7mr17202302ote.126.1631667438319;
 Tue, 14 Sep 2021 17:57:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Sep 2021 17:57:17 -0700
MIME-Version: 1.0
In-Reply-To: <20210914162825.v3.3.Ibf9b125434e3806b35f9079f6d8125578d76f138@changeid>
References: <20210914162825.v3.1.I85e46da154e3fa570442b496a0363250fff0e44e@changeid>
 <20210914162825.v3.3.Ibf9b125434e3806b35f9079f6d8125578d76f138@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 14 Sep 2021 17:57:17 -0700
Message-ID: <CAE-0n51JFM_yYdOsCQyvdMw5xXJ7REcbOJC6qi=6nfiNcdvnWw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/bridge: parade-ps8640: Add support for AUX channel
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

Quoting Philip Chen (2021-09-14 16:28:45)
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 8d3e7a147170..dc349d729f5a 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -117,6 +144,129 @@ static inline struct ps8640 *bridge_to_ps8640(struct drm_bridge *e)
[...]
> +       case DP_AUX_I2C_WRITE:
> +       case DP_AUX_I2C_READ:
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       ret = regmap_write(map, PAGE0_AUXCH_CFG3, AUXCH_CFG3_RESET);
> +       if (ret) {
> +               dev_err(dev, "failed to write PAGE0_AUXCH_CFG3: %d\n", ret);

Can we use DRM_DEV_ERROR()?

> +               return ret;
> +       }
> +
> +       /* Assume it's good */
> +       msg->reply = 0;
> +
> +       addr_len[0] = msg->address & 0xff;
> +       addr_len[1] = (msg->address >> 8) & 0xff;
> +       addr_len[2] = ((msg->request << 4) & SWAUX_CMD_MASK) |
> +               ((msg->address >> 16) & SWAUX_ADDR_19_16_MASK);

It really feels like this out to be possible with some sort of
cpu_to_le32() API. We're shoving msg->address into 3 bytes and then
adding in the request and some length. So we could do something like:

	u32 addr_len;

	addr_len = FIELD_PREP(SWAUX_ADDR_MASK, msg->address);
	addr_len |= FIELD_PREP(SWAUX_CMD_MASK, msg->request);
	if (len)
		addr_len |= FIELD_PREP(LEN_MASK, len - 1);
	else
		addr_len |= FIELD_PREP(LEN_MASK, SWAUX_NO_PAYLOAD );
	
	cpu_to_le32s(&addr_len);

	regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, &addr_len, sizeof(addr_len));

> +       addr_len[3] = (len == 0) ? SWAUX_NO_PAYLOAD :
> +                       ((len - 1) & SWAUX_LENGTH_MASK);
> +
> +       regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
> +                         ARRAY_SIZE(addr_len));
> +
> +       if (len && (request == DP_AUX_NATIVE_WRITE ||
> +                   request == DP_AUX_I2C_WRITE)) {
> +               /* Write to the internal FIFO buffer */
> +               for (i = 0; i < len; i++) {
> +                       ret = regmap_write(map, PAGE0_SWAUX_WDATA, buf[i]);
> +                       if (ret) {
> +                               dev_err(dev, "failed to write WDATA: %d\n",

DRM_DEV_ERROR?

> +                                       ret);
> +                               return ret;
> +                       }
> +               }
> +       }
> +
> +       regmap_write(map, PAGE0_SWAUX_CTRL, SWAUX_SEND);
> +
> +       /* Zero delay loop because i2c transactions are slow already */
> +       regmap_read_poll_timeout(map, PAGE0_SWAUX_CTRL, data,
> +                                !(data & SWAUX_SEND), 0, 50 * 1000);
> +
> +       regmap_read(map, PAGE0_SWAUX_STATUS, &data);
> +       if (ret) {
> +               dev_err(dev, "failed to read PAGE0_SWAUX_STATUS: %d\n", ret);

DRM_DEV_ERROR?

> +               return ret;
> +       }
> +
> +       switch (data & SWAUX_STATUS_MASK) {
> +       /* Ignore the DEFER cases as they are already handled in hardware */
> +       case SWAUX_STATUS_NACK:
> +       case SWAUX_STATUS_I2C_NACK:
> +               /*
> +                * The programming guide is not clear about whether a I2C NACK
> +                * would trigger SWAUX_STATUS_NACK or SWAUX_STATUS_I2C_NACK. So
> +                * we handle both cases together.
> +                */
> +               if (is_native_aux)
> +                       msg->reply |= DP_AUX_NATIVE_REPLY_NACK;
> +               else
> +                       msg->reply |= DP_AUX_I2C_REPLY_NACK;
> +
> +               len = data & SWAUX_M_MASK;
> +               return len;

Why no 'return data & SWAUX_M_MASK;' and skip the assignment?

> +       case SWAUX_STATUS_ACKM:

Move this up and add fallthrough?

> +               len = data & SWAUX_M_MASK;
> +               return len;
> +       case SWAUX_STATUS_INVALID:
> +               return -EOPNOTSUPP;
> +       case SWAUX_STATUS_TIMEOUT:
> +               return -ETIMEDOUT;
> +       }
> +
> +       if (len && (request == DP_AUX_NATIVE_READ ||
> +                   request == DP_AUX_I2C_READ)) {
> +               /* Read from the internal FIFO buffer */
> +               for (i = 0; i < len; i++) {
> +                       ret = regmap_read(map, PAGE0_SWAUX_RDATA, &data);
> +                       buf[i] = data;

Can drop a line

		ret = regmap_read(map, PAGE0_SWAUX_RDATA, buf + i);

> +                       if (ret) {
> +                               dev_err(dev, "failed to read RDATA: %d\n",
> +                                       ret);
> +                               return ret;
> +                       }
> +               }
> +       }
> +
> +       return len;
> +}
