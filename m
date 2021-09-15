Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD9D40CF15
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhIOV7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhIOV7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:59:04 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC765C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:57:44 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b7so5452272iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TzpBTwqbvFq/TilgQetFLjjI03dWCIPzcsLrYptjiKc=;
        b=K6TMOauirSkiFMCwCeX2VqFIOB5bE6uQEXKKkqTILVEQ91KLpfHsDFwiS5d9bhVgbZ
         IXMsjXJ8tPickITCEI9YSB4pK1mF2nWDXBajTRZ9yYTPo08FP5w5PSgK1EJiKI+9MxtD
         flsuvMHCXjN2ePJgCg7E55UUs+Skjlpgj+9KM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzpBTwqbvFq/TilgQetFLjjI03dWCIPzcsLrYptjiKc=;
        b=5597ebV1PPTQ8Q2jOo4Av5Djl7hm13i5ArunqxVwHoZtHGZIurTQD9xNv8j/uL9C2x
         jqRbGfcuzmfy7Y7564YEhHA8gkV18/he2G+tgXyZ9qz0hqBp7lKPiaen3NX+0jbzLIQF
         WTPfdsetBKMhJvmkRCJfYMMdTqIPXzwVvUCbWrh/Cm5DIbQHZjM9gSQmxyG6muKUp8Ct
         s7tB6gB1ciRm8ifNv7NHp3HlT4Q7TjVMx1Eqz0H2jt+q3GUkWI50wYhJlQ6xric3LZSr
         z2Ke5V7e/HiZdJXHDoFglkwDKKg9L9Gf98J8nFxbZ99SXVnZsR5BaYJapA6w1Wv8+IBp
         //Mw==
X-Gm-Message-State: AOAM532mTxvkj/vrKafWqaRB1ZvW/4QpLoTHl6uo8of/46iJbCyjRqcp
        6MKylHYVcaWK2OJ1BHjC11G6oatYCiZEBQ==
X-Google-Smtp-Source: ABdhPJyOxkBvW5/czybj3Os2hx6RG+xVr0/ts5ekVehqIz33FbHDH6cEhkhPB9k+VnOj/RCIjGUPjg==
X-Received: by 2002:a05:6638:22d1:: with SMTP id j17mr1761184jat.129.1631743064103;
        Wed, 15 Sep 2021 14:57:44 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id g14sm668816ila.28.2021.09.15.14.57.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 14:57:43 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id j18so5387324ioj.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:57:43 -0700 (PDT)
X-Received: by 2002:a02:6d59:: with SMTP id e25mr1826747jaf.68.1631743062700;
 Wed, 15 Sep 2021 14:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210913143255.RFC.v2.1.I8ad7a535bb18a1f41f3858f83379beedb397a9db@changeid>
 <20210913143255.RFC.v2.2.I2f55fee564b0008908d8a25a8825117119c80c4a@changeid>
 <CAD=FV=UGicZhuZHmc8asQU6kGgGGg+nZDqKPJ5QOc5tH3eBf9Q@mail.gmail.com> <CA+cxXhnqOjRah_K5OoTE1SN8u5WK0WkLkZwsaTiFoBVijaVw_Q@mail.gmail.com>
In-Reply-To: <CA+cxXhnqOjRah_K5OoTE1SN8u5WK0WkLkZwsaTiFoBVijaVw_Q@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Sep 2021 14:57:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VH767enDNFO01+Y9Y3QEyAqSzCLzCd=cTuGGYziK5icA@mail.gmail.com>
Message-ID: <CAD=FV=VH767enDNFO01+Y9Y3QEyAqSzCLzCd=cTuGGYziK5icA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] drm/bridge: parade-ps8640: Add support for AUX channel
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

On Tue, Sep 14, 2021 at 5:28 PM Philip Chen <philipchen@chromium.org> wrote:
>
> > > Changes in v2:
> > > - Handle the case where an AUX transaction has no payload
> > > - Add a reg polling for p0.0x83 to confirm AUX cmd is issued and
> > >   read data is returned
> > > - Replace regmap_noinc_read/write with looped regmap_read/write,
> > >   as regmap_noinc_read/write doesn't read one byte at a time unless
> > >   max_raw_read/write is set to 1.
> >
> > What about if you set val_bytes? I think you just need to set that to
> > "1" and it'll work?
> I think val_bytes is already set to 1 as we set val_bits to 8. See:
> map->format.val_bytes = DIV_ROUND_UP(config->val_bits, 8);

To me that feels like a bug in the regmap API, then. I can't see how
it would make any sense for this function not to take val_bytes into
account...

I wonder if other users are somehow getting lucky today. Maybe users
that are using this for MMIO get lucky because max_raw_read is set
properly. ...and maybe other i2c users get lucky because some
peripherals are OK w/ this bug? AKA, maybe this actually works in most
cases for FIFOs:

write address of bridge chip on i2c bus
write R/W bit on i2c bus
write FIFO register address on i2c bus
read byte
read byte
read byte
...
read byte
read byte
end transaction

Normally for i2c you assume that the other side will read from
subsequent register addresses for each "read byte", but I suppose it's
possible that some i2c devices are setup to realize that if the
register address was the address of a FIFO that it shouldn't read from
the next register address but should just read the next byte in the
FIFO?


In any case, it's fine to do it with a loop like you're doing but it
still seems weird that you'd need to.


-Doug
