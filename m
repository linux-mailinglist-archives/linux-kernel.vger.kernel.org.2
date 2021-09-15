Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7532040CE52
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 22:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhIOUmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 16:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhIOUmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 16:42:44 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CA9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:41:25 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id z5so8443456ybj.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOwRRNdP5RTehvQQFvtVE54eH5moBuF/WcjgpG+gUas=;
        b=RhROcGG30BL0HDU4a/Od+WELadl6Cc6pMPaZpYO07qsTzvYZZcRAr5v0fftPXoH6VK
         7JQ3epsZH7geLdoTE0qUUXtW9GFHp6djMmI1S8ayW07LNvPusLgPNwg7XUmgwBRXBTNT
         jwR8W64S70ahfFFlLxvya8zrObqydeV8uJSQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOwRRNdP5RTehvQQFvtVE54eH5moBuF/WcjgpG+gUas=;
        b=cvZBEGi0g+5BqEWl8YMyloWtucy/SpVpLk7bc1P0a1j+LCExrFyLZqZqIiMFn8fzPM
         xeaHC9FdADrb0ERsmWh6T3fhXQTmKYgibIA38U9bUhY7l3xtNwD2sD++o6OzQWiBAS8J
         LpRY4AC9EvDcWgBxBtfZtxhB49W0SnX2o34ry+DJpWJnkshrSjgqxYwp9KMBo+hvGJJ1
         FjT3Io0KpT1LbfD4M1s/wwqsY9HlQqT+GKTVJK2zrGV79vh6VDvHG0SJ+D1YWq+5Zh9Q
         RYXZclhBz+PdPISv1Y5v4RQUNHDIXSlcCaU2++rG+1MOyVZ+DCVcN7oTG45LBSE3vRr3
         UuaA==
X-Gm-Message-State: AOAM533LpWvBuJ1ltUD9TVQtMG9FzR7sFiDoD/8tiVHLKreffDY+7TPS
        QZVqOb78KBWwUMGlPj9Cdg2nb8pqXeztkltZ1U/CTg==
X-Google-Smtp-Source: ABdhPJxuw1UVY9mdyVtVp2uqcXdjj6QjLVEq8HaBH7ts9OLd0qawyCvUaN0bf9BPa5nRyAjyHfbxHZhdyH06+HHruW0=
X-Received: by 2002:a25:afce:: with SMTP id d14mr2555411ybj.14.1631738484342;
 Wed, 15 Sep 2021 13:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210914162825.v3.1.I85e46da154e3fa570442b496a0363250fff0e44e@changeid>
 <20210914162825.v3.3.Ibf9b125434e3806b35f9079f6d8125578d76f138@changeid> <CAE-0n51JFM_yYdOsCQyvdMw5xXJ7REcbOJC6qi=6nfiNcdvnWw@mail.gmail.com>
In-Reply-To: <CAE-0n51JFM_yYdOsCQyvdMw5xXJ7REcbOJC6qi=6nfiNcdvnWw@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Wed, 15 Sep 2021 13:41:12 -0700
Message-ID: <CA+cxXhn-gLt37oyEq3wSh3qf=UkY=H6fY3ahC=gyhKhGwu_dXw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/bridge: parade-ps8640: Add support for AUX channel
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Sep 14, 2021 at 5:57 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Philip Chen (2021-09-14 16:28:45)
> > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> > index 8d3e7a147170..dc349d729f5a 100644
> > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > @@ -117,6 +144,129 @@ static inline struct ps8640 *bridge_to_ps8640(struct drm_bridge *e)
> [...]
> > +       case DP_AUX_I2C_WRITE:
> > +       case DP_AUX_I2C_READ:
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret = regmap_write(map, PAGE0_AUXCH_CFG3, AUXCH_CFG3_RESET);
> > +       if (ret) {
> > +               dev_err(dev, "failed to write PAGE0_AUXCH_CFG3: %d\n", ret);
>
> Can we use DRM_DEV_ERROR()?
Sure.
>
> > +               return ret;
> > +       }
> > +
> > +       /* Assume it's good */
> > +       msg->reply = 0;
> > +
> > +       addr_len[0] = msg->address & 0xff;
> > +       addr_len[1] = (msg->address >> 8) & 0xff;
> > +       addr_len[2] = ((msg->request << 4) & SWAUX_CMD_MASK) |
> > +               ((msg->address >> 16) & SWAUX_ADDR_19_16_MASK);
>
> It really feels like this out to be possible with some sort of
> cpu_to_le32() API. We're shoving msg->address into 3 bytes and then
> adding in the request and some length. So we could do something like:
>
>         u32 addr_len;
>
>         addr_len = FIELD_PREP(SWAUX_ADDR_MASK, msg->address);
>         addr_len |= FIELD_PREP(SWAUX_CMD_MASK, msg->request);
>         if (len)
>                 addr_len |= FIELD_PREP(LEN_MASK, len - 1);
>         else
>                 addr_len |= FIELD_PREP(LEN_MASK, SWAUX_NO_PAYLOAD );
>
>         cpu_to_le32s(&addr_len);
>
>         regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, &addr_len, sizeof(addr_len));
>
Yes, thanks for the advice.
Will add this change to v4.

> > +       addr_len[3] = (len == 0) ? SWAUX_NO_PAYLOAD :
> > +                       ((len - 1) & SWAUX_LENGTH_MASK);
> > +
> > +       regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
> > +                         ARRAY_SIZE(addr_len));
> > +
> > +       if (len && (request == DP_AUX_NATIVE_WRITE ||
> > +                   request == DP_AUX_I2C_WRITE)) {
> > +               /* Write to the internal FIFO buffer */
> > +               for (i = 0; i < len; i++) {
> > +                       ret = regmap_write(map, PAGE0_SWAUX_WDATA, buf[i]);
> > +                       if (ret) {
> > +                               dev_err(dev, "failed to write WDATA: %d\n",
>
> DRM_DEV_ERROR?
Sure.
>
> > +                                       ret);
> > +                               return ret;
> > +                       }
> > +               }
> > +       }
> > +
> > +       regmap_write(map, PAGE0_SWAUX_CTRL, SWAUX_SEND);
> > +
> > +       /* Zero delay loop because i2c transactions are slow already */
> > +       regmap_read_poll_timeout(map, PAGE0_SWAUX_CTRL, data,
> > +                                !(data & SWAUX_SEND), 0, 50 * 1000);
> > +
> > +       regmap_read(map, PAGE0_SWAUX_STATUS, &data);
> > +       if (ret) {
> > +               dev_err(dev, "failed to read PAGE0_SWAUX_STATUS: %d\n", ret);
>
> DRM_DEV_ERROR?
Sure.
>
> > +               return ret;
> > +       }
> > +
> > +       switch (data & SWAUX_STATUS_MASK) {
> > +       /* Ignore the DEFER cases as they are already handled in hardware */
> > +       case SWAUX_STATUS_NACK:
> > +       case SWAUX_STATUS_I2C_NACK:
> > +               /*
> > +                * The programming guide is not clear about whether a I2C NACK
> > +                * would trigger SWAUX_STATUS_NACK or SWAUX_STATUS_I2C_NACK. So
> > +                * we handle both cases together.
> > +                */
> > +               if (is_native_aux)
> > +                       msg->reply |= DP_AUX_NATIVE_REPLY_NACK;
> > +               else
> > +                       msg->reply |= DP_AUX_I2C_REPLY_NACK;
> > +
> > +               len = data & SWAUX_M_MASK;
> > +               return len;
>
> Why no 'return data & SWAUX_M_MASK;' and skip the assignment?
I want to make it clear that we are returning the number of bytes that
we have read/written instead of some error code.
If you think it's not super helpful, I can just return data & SWAUX_M_MASK.

>
> > +       case SWAUX_STATUS_ACKM:
>
> Move this up and add fallthrough?
Thanks.
Will add this change to v4.
>
> > +               len = data & SWAUX_M_MASK;
> > +               return len;
> > +       case SWAUX_STATUS_INVALID:
> > +               return -EOPNOTSUPP;
> > +       case SWAUX_STATUS_TIMEOUT:
> > +               return -ETIMEDOUT;
> > +       }
> > +
> > +       if (len && (request == DP_AUX_NATIVE_READ ||
> > +                   request == DP_AUX_I2C_READ)) {
> > +               /* Read from the internal FIFO buffer */
> > +               for (i = 0; i < len; i++) {
> > +                       ret = regmap_read(map, PAGE0_SWAUX_RDATA, &data);
> > +                       buf[i] = data;
>
> Can drop a line
regmap_read() wants to read to an unsigned int, but buf is an u8 array.
To be safe, I read RDATA to data and then assign data to buf[i].

As regmap_read() should always read 1 byte at a time, should I just do:
regmap_read(map, PAGE0_SWAUX_RDATA, (unsigned int*)(buf + i))

>
>                 ret = regmap_read(map, PAGE0_SWAUX_RDATA, buf + i);
>
> > +                       if (ret) {
> > +                               dev_err(dev, "failed to read RDATA: %d\n",
> > +                                       ret);
> > +                               return ret;
> > +                       }
> > +               }
> > +       }
> > +
> > +       return len;
> > +}
