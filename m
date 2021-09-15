Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4E240CEC3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhIOV3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhIOV3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:29:14 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9AEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:27:55 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id u21so3743735qtw.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xdzl68kgUwZsmDH1EOQb6npCsfHZBZag3uzeD/gnyF0=;
        b=dXtqHIzgU5z0jfyNbPBAdO6dyOruzGJqO7SF8KPSfg+bsVT/RjMQd049CA7t89Gysc
         +WgEUpfDGwtgJloX3zzSa1FOvOYu3f8dw7VO6TL5Anyu6ciPSOIYFD2yXSUlolcsRzlv
         8srN5A8mW91oOQksU6orqNMRDt9SAmZSbXIsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xdzl68kgUwZsmDH1EOQb6npCsfHZBZag3uzeD/gnyF0=;
        b=BDW8tCCJeQ7M3GdIG7Isw7k4gbO1voiopA8QEnxHTgKrznKJIXEp7LLtisrtbdVDfy
         kx/Nn1Qn0UV0xndV6Y2fKzERtDXz9Ph3fAQw2rVmr7ud7Vj6rOljEIvghhIkIIa+yheG
         E7rZg/bucBaamP94vDatAhzFLBt1B5dTozzgqdhcHKbOeVLjuS9bdxHZZt0gPEjDsG5r
         JpfK0fX0kJpcxE0QDcf+yRlF/S2dVjbqFKzYqQgRoGjU3JM4CVuYZA3qpw/X7QhraKpe
         XWkuPApouIi+//4R1YgUVUokBh8THIWdN+OZ5wKiCPzbgRuvQmxfjbhfHz9OII0TUf1t
         thSQ==
X-Gm-Message-State: AOAM53000Wny9EhEwUm66ymebv6pm027k6mK+xYCYhRmxRF1J7Xdqar+
        Cma2IjBehPo1W5pivTyJygc9H3dWlETO+w==
X-Google-Smtp-Source: ABdhPJxDigAnjLA+rAkZCxcZUCntpdJ2t2TwhHPxFfFRX+atN0RGl/DNeoLhcVjuUNZ+xSn5PG6hdA==
X-Received: by 2002:ac8:411d:: with SMTP id q29mr1991655qtl.349.1631741273273;
        Wed, 15 Sep 2021 14:27:53 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id z11sm740724qtw.8.2021.09.15.14.27.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 14:27:52 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id y13so8651328ybi.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:27:52 -0700 (PDT)
X-Received: by 2002:a25:bb93:: with SMTP id y19mr2716698ybg.266.1631741272077;
 Wed, 15 Sep 2021 14:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210914162825.v3.1.I85e46da154e3fa570442b496a0363250fff0e44e@changeid>
 <20210914162825.v3.3.Ibf9b125434e3806b35f9079f6d8125578d76f138@changeid> <CAE-0n51JFM_yYdOsCQyvdMw5xXJ7REcbOJC6qi=6nfiNcdvnWw@mail.gmail.com>
In-Reply-To: <CAE-0n51JFM_yYdOsCQyvdMw5xXJ7REcbOJC6qi=6nfiNcdvnWw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Sep 2021 14:27:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WtC3AQr44idgzVe9RCjb9i=+ekJ_wKKnKMcHRSQX7dfQ@mail.gmail.com>
Message-ID: <CAD=FV=WtC3AQr44idgzVe9RCjb9i=+ekJ_wKKnKMcHRSQX7dfQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/bridge: parade-ps8640: Add support for AUX channel
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>,
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

Hi,

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

I've never gotten clear guidance here. For instance, in some other
review I suggested using the DRM wrapper and got told "no" [1]. ;-)
The driver landed without the DRM_ERROR versions. I don't really care
lots so it's fine with me to use use DRM_DEV_ERROR, I just wish I
understood the rules...

[1] https://lore.kernel.org/all/49db7ef3-fa53-a274-7c69-c2d840b13058@denx.de/


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

You're arguing that your version of the code is more efficient? Easier
to understand? Something else? To me, Philip's initial version is
crystal clear and easy to map to the bridge datasheet but I need to
think more to confirm that your version is right. Thinking is hard and
I like to avoid it when possible.

In any case, it's definitely bikeshedding and I'll yield if everyone
likes the other version better. ;-)


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

Actually, I think it's the "return" that's a bug, isn't it? If we're
doing a "read" and we're returning a positive number of bytes then we
need to actually _read_ them. Reading happens below, doesn't it?


-Doug
