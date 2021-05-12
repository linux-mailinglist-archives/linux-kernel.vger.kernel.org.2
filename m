Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA3B37C94A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 18:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbhELQRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 12:17:00 -0400
Received: from mail-vk1-f179.google.com ([209.85.221.179]:34726 "EHLO
        mail-vk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbhELPdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:33:25 -0400
Received: by mail-vk1-f179.google.com with SMTP id q135so4845103vke.1;
        Wed, 12 May 2021 08:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHUHY47xKY6M8wsOsrnoPowybpfBI0bLg/vVropFhTc=;
        b=de9Vp95qpRi12wNI3UGvV24nKQPfSd79FOiEtyHjwEYGUYYvuzTwrUFb4HQFYGJ+pm
         +UJTf07bxLgEHkOF8YuAScTCseKXWykPZimRlw4oaT/i+bPVkE4MsYJ3LBOX+0QbRQ//
         vlV2WyyZuKo0r6cn9tAbQpAwX+OL14KMJE0iWGYjoUqBIYWEko72LzKadbdPj7CfHTog
         AUr7liZe2tVlgj36YQi0HdMjf4wJ5+n82lmLsrvHtpgTufLhLrRbAUsnUnzI8sxQhfxs
         Ozl0pMziu5MIS12RzHHNcaoZURHvRZSDt/RBDHfkT7OGpsWBNyNO7uRtBEEHSC+wMV1W
         tEgg==
X-Gm-Message-State: AOAM531TDmqbCOepG8z11m45UkmEFE7NG6hBm8Z72m87Oz+QJDyjOhna
        bWdUUrUwJ36uvD8CWmDQa2xeEMORHo1ywFOjYMs=
X-Google-Smtp-Source: ABdhPJy4j45rbhSUmGa2sukaqCXSAXpQu8R4tysokooKoUeP72NCQxu5ym8wZwCL1KfOXU7HkrCIogzLFhaUDmo8j04=
X-Received: by 2002:a1f:a388:: with SMTP id m130mr29310938vke.1.1620833535781;
 Wed, 12 May 2021 08:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210106113730.k5qveshjgcd57kgx@runtux.com> <20210106113929.fizyg6fcsmsntkiy@runtux.com>
 <CANiq72=Cfv=Qo2fs+HDjUc8pV37mL326SDS5JpGotUfHLwK_rQ@mail.gmail.com>
In-Reply-To: <CANiq72=Cfv=Qo2fs+HDjUc8pV37mL326SDS5JpGotUfHLwK_rQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 May 2021 17:32:04 +0200
Message-ID: <CAMuHMdUW3U6DVkHp3xiHFzvRUDJ1FwTNCnBWp5LCuDGxhds9wg@mail.gmail.com>
Subject: Re: [PATCH 1/1] auxdisplay: Add I2C gpio expander example
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Ralf Schlatterbeck <rsc@runtux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Lars Poeschel <poeschel@lemonage.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On Wed, Jan 6, 2021 at 1:18 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Wed, Jan 6, 2021 at 12:39 PM Ralf Schlatterbeck <rsc@runtux.com> wrote:
> > The hd44780 displays are often used with pcf8574 based I/O expanders.
> > Add example to documentation.
> >
> > Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>

> Rob, if you are taking this on your tree:
>
>     Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> Otherwise, I will pick it up.

Seems like so far no one has picked this up?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
