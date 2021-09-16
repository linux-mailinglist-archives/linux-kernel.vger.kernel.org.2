Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAC440EBB8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 22:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbhIPUcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 16:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbhIPUcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:32:32 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08C2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 13:31:11 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id b15so7900965ils.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 13:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1AU52RUPeNagngZIGjbgtR+Kyw10FlJo3rtHRZkX030=;
        b=D5HGBVoup86TJJsbyDbU1gcIdKgoPI4+y43ulvc2Q3yz4lEaMtGYVUfgQJzK6ZAHoN
         gNLGdtTWHs4DtDitY0Mx+YKm6fQjgAs4q4NNVmWvuEKMZMYIfj9G0tHkDX0EnB5/GAcd
         XIYXEq0UvZYenRXBPGv3fu1piVfcmunO7Fqj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1AU52RUPeNagngZIGjbgtR+Kyw10FlJo3rtHRZkX030=;
        b=V8DjQBGD242qYyO1TvbqBckP0CMqfcYcrBbCVI2ATO9MDGbp2qCT4z6gmfi75xYAuY
         Au8uNmNj/RZhm68xGLnDKggZlahPj3NzTI6f2i+nEanr8V94LJdhUHJKVPJanfsu/wiA
         YUEnsqvzhKaFbwV8JPA0NbjDadCZFilznyIgSSU24aYz1OWLLTRrkRkp5BCiHgfeCPQX
         Z50taZ+JQ1RLRroCnzFiBqnCCwFGO3CMBaEfYDH0QH2Df1TpzB7oYZBo/At7J/082hnk
         avafeDJSKaw6XS2VYq2xjTA2wG/4BusN3/5xPEadBZBdoSAHCUSebk8LRkkVViB9vMZn
         M22w==
X-Gm-Message-State: AOAM531RfcMLVKpRSTADqPrIFl/8njJ9c6d1SP+0p2pXRStWshNON3P2
        hqWfdyQ2x01uJGVWf5MX+lyzlJhlgyz8xA==
X-Google-Smtp-Source: ABdhPJwaVs4PfPxHu71JYMadO3F4lHopTBvOkg2+L9ZElbrRV1CCk3hjIHnMOFEqrZfbliShyycvmQ==
X-Received: by 2002:a92:d18c:: with SMTP id z12mr5398876ilz.59.1631824271196;
        Thu, 16 Sep 2021 13:31:11 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id r13sm2498547ilh.80.2021.09.16.13.31.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 13:31:10 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id q14so7948635ils.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 13:31:10 -0700 (PDT)
X-Received: by 2002:a92:da0c:: with SMTP id z12mr5216828ilm.120.1631824270174;
 Thu, 16 Sep 2021 13:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210914162825.v3.1.I85e46da154e3fa570442b496a0363250fff0e44e@changeid>
 <20210914162825.v3.3.Ibf9b125434e3806b35f9079f6d8125578d76f138@changeid>
 <CAE-0n51JFM_yYdOsCQyvdMw5xXJ7REcbOJC6qi=6nfiNcdvnWw@mail.gmail.com>
 <CAD=FV=WtC3AQr44idgzVe9RCjb9i=+ekJ_wKKnKMcHRSQX7dfQ@mail.gmail.com> <CAE-0n51AAXbDGH-V6527nT1Fp1BU8oWKEYmHnL6FkYs=P9OPOw@mail.gmail.com>
In-Reply-To: <CAE-0n51AAXbDGH-V6527nT1Fp1BU8oWKEYmHnL6FkYs=P9OPOw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 Sep 2021 13:30:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W2wTtZtTKw4n9cSo1SYjs3KS84inKCeeHa8bybOc+sfw@mail.gmail.com>
Message-ID: <CAD=FV=W2wTtZtTKw4n9cSo1SYjs3KS84inKCeeHa8bybOc+sfw@mail.gmail.com>
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

On Thu, Sep 16, 2021 at 1:15 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       /* Assume it's good */
> > > > +       msg->reply = 0;
> > > > +
> > > > +       addr_len[0] = msg->address & 0xff;
> > > > +       addr_len[1] = (msg->address >> 8) & 0xff;
> > > > +       addr_len[2] = ((msg->request << 4) & SWAUX_CMD_MASK) |
> > > > +               ((msg->address >> 16) & SWAUX_ADDR_19_16_MASK);
> > >
> > > It really feels like this out to be possible with some sort of
> > > cpu_to_le32() API. We're shoving msg->address into 3 bytes and then
> > > adding in the request and some length. So we could do something like:
> > >
> > >         u32 addr_len;
> > >
> > >         addr_len = FIELD_PREP(SWAUX_ADDR_MASK, msg->address);
> > >         addr_len |= FIELD_PREP(SWAUX_CMD_MASK, msg->request);
> > >         if (len)
> > >                 addr_len |= FIELD_PREP(LEN_MASK, len - 1);
> > >         else
> > >                 addr_len |= FIELD_PREP(LEN_MASK, SWAUX_NO_PAYLOAD );
> > >
> > >         cpu_to_le32s(&addr_len);
> > >
> > >         regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, &addr_len, sizeof(addr_len));
> >
> > You're arguing that your version of the code is more efficient? Easier
> > to understand? Something else? To me, Philip's initial version is
> > crystal clear and easy to map to the bridge datasheet but I need to
> > think more to confirm that your version is right. Thinking is hard and
> > I like to avoid it when possible.
> >
> > In any case, it's definitely bikeshedding and I'll yield if everyone
> > likes the other version better. ;-)
>
> Yeah it's bikeshedding. I don't really care about this either but I find
> it easier to read when the assignment isn't wrapped across multiple
> lines. If the buffer approach is preferable then maybe use the address
> macros to clarify which register is being set?
>
>         unsigned int base = PAGE0_SWAUX_ADDR_7_0;
>
>         addr_len[PAGE0_SWAUX_ADDR_7_0 - base] = msg->address;
>         addr_len[PAGE0_SWAUX_ADDR_15_8 - base] = msg->address >> 8;
>         addr_len[PAGE0_SWAUX_ADDR_23_16 - base] = msg->address >> 16;
>         addr_len[PAGE0_SWAUX_ADDR_23_16 - base] |= msg->request << 4;

Sure, this looks nice to me. :-)


> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       switch (data & SWAUX_STATUS_MASK) {
> > > > +       /* Ignore the DEFER cases as they are already handled in hardware */
> > > > +       case SWAUX_STATUS_NACK:
> > > > +       case SWAUX_STATUS_I2C_NACK:
> > > > +               /*
> > > > +                * The programming guide is not clear about whether a I2C NACK
> > > > +                * would trigger SWAUX_STATUS_NACK or SWAUX_STATUS_I2C_NACK. So
> > > > +                * we handle both cases together.
> > > > +                */
> > > > +               if (is_native_aux)
> > > > +                       msg->reply |= DP_AUX_NATIVE_REPLY_NACK;
> > > > +               else
> > > > +                       msg->reply |= DP_AUX_I2C_REPLY_NACK;
> > > > +
> > > > +               len = data & SWAUX_M_MASK;
> > > > +               return len;
> > >
> > > Why no 'return data & SWAUX_M_MASK;' and skip the assignment?
> >
> > Actually, I think it's the "return" that's a bug, isn't it? If we're
> > doing a "read" and we're returning a positive number of bytes then we
> > need to actually _read_ them. Reading happens below, doesn't it?
> >
>
> Oh I missed that. We're still supposed to return data to upper
> layers on a NACKed read?

It seems highly likely not to matter in practice, but:

* The docs from parade clearly state that when a NAK is returned that
the number of bytes transferred before the NAK will be provided to us.

* The i2c interface specifies NAK not as a return code but as a bit in
the "reply". That presumably is to let us return the number of bytes
transferred before the NAK to the next level up.

* If we're returning the number of bytes and it's a read then we'd
better return the data too!

It looks like we handled this OK in the TI bridge driver. From reading
the TI docs we'll get both AUX_IRQ_STATUS_AUX_SHORT and
AUX_IRQ_STATUS_NAT_I2C_FAIL in the case of a partial transfer and so
we'll do the right thing.

-Doug
