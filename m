Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7F74136E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbhIUQED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbhIUQEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:04:02 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD79C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:02:34 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n71so8482513iod.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hLKvecr7rVDv4E5rFe3ar/63VqLQrIXucEIO2M9I4t8=;
        b=HTv0g8JFV4VYzaYPYW+h2sTqr/myWOJeCcTCbkbR7Q8b9rDWU7AdrnoQEhzwDf21B1
         olE/Pi/Fv04FDKuQoXhdjReyIhzaeAZQVUzw4B39OFQrO/iUFQcdxCt6rTH9qvToBk24
         /vA9SSGB9PCJKZGIDW7U8WbLZCAVyNDakk0zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLKvecr7rVDv4E5rFe3ar/63VqLQrIXucEIO2M9I4t8=;
        b=nQtcRqvgB2r1Uq4d9yLX34lMFnY+GvTU2U5kIJKxiqf7MqS6Uo/P0ETrAJJ9JvdOls
         8e7cqwTlQP9qubVeTUZgMUZ4xMec0SsmLL1okh0SiH7iTwXKUuOeWYwPwQFn/lkzJgYY
         TD9aVeKUsqq0b+1rfu3hR75lLWn09jvF+bs9WMGqHRVnTGwx7jmwvhUe520tsEKM1OuC
         WwQmiUW8CQN1reOyH2Idw0YSs2R6Wf53kQTCCU0f4s0bluP4dn0T9XgGprSAQeWLLuJh
         hEHMAtyTshBo4I2I9Mn6vPFEECiUPbZEkAeMjmgGP+9LkvwefHI6YY9Czbq+FICGQxQw
         mn0A==
X-Gm-Message-State: AOAM532BqAn8Q7AqBMRWgUNBjHV0jqNC4R9rCngePpC8Xlh04bpzACgE
        DRWcUDJPeI8xLnkdynCKtrFrEFIeBXarbw==
X-Google-Smtp-Source: ABdhPJwVGJh+RkQXxiLNXPMg39w0C78GKLDvOlynccMukRGOOLjclw1fmlGwn08bIq3P0fzeP6Wrng==
X-Received: by 2002:a6b:2bce:: with SMTP id r197mr600912ior.212.1632240153316;
        Tue, 21 Sep 2021 09:02:33 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id 12sm5286889ilq.23.2021.09.21.09.02.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 09:02:32 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id h20so23228317ilj.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:02:32 -0700 (PDT)
X-Received: by 2002:a92:c8c3:: with SMTP id c3mr21290506ilq.165.1632240152306;
 Tue, 21 Sep 2021 09:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210918102058.v5.1.I2351df94f18d5d8debc22d4d100f36fac560409a@changeid>
 <20210918102058.v5.2.Ifcb5df5de5b1cead7c99e0f37b044ef5cfc69eda@changeid>
In-Reply-To: <20210918102058.v5.2.Ifcb5df5de5b1cead7c99e0f37b044ef5cfc69eda@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 21 Sep 2021 09:02:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VgQWLmPEFBv=Ufnm8Gc4srRUd15GNbSrL-pYBGysCYqw@mail.gmail.com>
Message-ID: <CAD=FV=VgQWLmPEFBv=Ufnm8Gc4srRUd15GNbSrL-pYBGysCYqw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] drm/bridge: parade-ps8640: Add support for AUX channel
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
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

On Sat, Sep 18, 2021 at 10:21 AM Philip Chen <philipchen@chromium.org> wrote:
>
> +static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
> +                                  struct drm_dp_aux_msg *msg)
> +{
> +       struct ps8640 *ps_bridge = aux_to_ps8640(aux);
> +       struct regmap *map = ps_bridge->regmap[PAGE0_DP_CNTL];
> +       struct device *dev = &ps_bridge->page[PAGE0_DP_CNTL]->dev;
> +
> +       unsigned int len = msg->size;

nit: usually no blank lines in the variable definition section.


> +       base = PAGE0_SWAUX_ADDR_7_0;
> +       addr_len[PAGE0_SWAUX_ADDR_7_0 - base] = msg->address;
> +       addr_len[PAGE0_SWAUX_ADDR_15_8 - base] = msg->address >> 8;
> +       addr_len[PAGE0_SWAUX_ADDR_23_16 - base] = (msg->address >> 16) &
> +                                                 SWAUX_ADDR_19_16_MASK;
> +       addr_len[PAGE0_SWAUX_ADDR_23_16 - base] |= (msg->request << 4) &
> +                                                  SWAUX_CMD_MASK;

optional nit: Probably you could get rid of the mask for the request.
After all, you're storing it to a thing that's a byte (so bits above
bit 7 will implicitly be masked) and you're left shifting by 4 (so
bits 0-3 will implicitly be masked) so this just makes it uglier. ;-)

optional nit: In theory you could also get rid of the
SWAUX_ADDR_19_16_MASK and if you really wanted to you could error
check that the address wasn't bigger than 20-bits since giving an
error for an invalid address would actually be better than silently
masking it anyway...


> +       if (len && (request == DP_AUX_NATIVE_READ ||
> +                   request == DP_AUX_I2C_READ)) {
> +               /* Read from the internal FIFO buffer */
> +               for (i = 0; i < len; i++) {
> +                       ret = regmap_read(map, PAGE0_SWAUX_RDATA,
> +                                         (unsigned int *)(buf + i));

The cast to "unsigned int *" looks wrong to me. You can't just cast
like this for a number of reasons. Go back to reading into a local
variable and copy the byte into your buffer.


Other than the regmap_read() this looks fine to me. If you send a v6
with that fixed I'll plan to wait a day or two and then apply it with
Sam's tags.

-Doug
