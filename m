Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67423388B39
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347240AbhESJz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:55:29 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:34724 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245745AbhESJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:55:24 -0400
Received: by mail-ua1-f53.google.com with SMTP id x1so3721494uau.1;
        Wed, 19 May 2021 02:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gvr46UuP/aK1hvdWUxVGtDfsF8ud4ousl9JTfPPOif0=;
        b=p+zANF9XY5zG5BIdAtRAjyTyBdFWiGUEpYfrHZYkO/EgpRpGWpu+irpLgOC2zby3J9
         4ajOHQGu0U81QTvLbOrCqyQewtsFDgmWwnWL1N/flY53vh9LWZHAZ+O/2FMVUCm5hXLS
         GSt2YviG+Z/DmHS8FdapBkXQh37XpdxMFRpYhnNV5uhsDfTtCCNVS1FxuCFjvKiSZbhs
         y9Rxay1F8qDFvSfua88mHtvSnqv15I6zlSwi9gOogcJsG6MOZw1b+in3nZFYeHmCwMi1
         mt3wKTNj47HCrKLujSdCX8WB2g+eGTVlJ+C36sTybr7Hds03zAlAi3Kj1oyTcE7rfs16
         fc3g==
X-Gm-Message-State: AOAM530hS4mGbsCGHKrrCCWNQiExtPujElgNuMVnfzwgMm2KQFN7lKcA
        W0PT9NV9o5KZ6lquchrg4L7elZq4OSL+/7DM5Uo=
X-Google-Smtp-Source: ABdhPJxQeHn6vy6se+92JGjupVPtNrd9RHNFzUY140wdZNDAlJ5Rg2eg8vPbVYUEqYCgsh7Ls2X9pNQOobSI3duXejY=
X-Received: by 2002:ab0:2242:: with SMTP id z2mr8817879uan.58.1621418043172;
 Wed, 19 May 2021 02:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210106113730.k5qveshjgcd57kgx@runtux.com> <20210106113929.fizyg6fcsmsntkiy@runtux.com>
 <CANiq72=Cfv=Qo2fs+HDjUc8pV37mL326SDS5JpGotUfHLwK_rQ@mail.gmail.com>
 <CAMuHMdUW3U6DVkHp3xiHFzvRUDJ1FwTNCnBWp5LCuDGxhds9wg@mail.gmail.com>
 <CANiq72mCFwYnbynQgwNGTt0mzo_rMrnQfpinz6DrPttFxUpyNQ@mail.gmail.com>
 <20210517152035.GA2581887@robh.at.kernel.org> <20210519090047.e63d2im5vgskqpcs@runtux.com>
In-Reply-To: <20210519090047.e63d2im5vgskqpcs@runtux.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 May 2021 11:53:51 +0200
Message-ID: <CAMuHMdV80XUo5ihXUkogCikGA4H71Ada9w=9W9d9d1zdgrw0uA@mail.gmail.com>
Subject: Re: [PATCH 1/1] auxdisplay: Add I2C gpio expander example
To:     Ralf Schlatterbeck <rsc@runtux.com>
Cc:     Rob Herring <robh@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Lars Poeschel <poeschel@lemonage.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

On Wed, May 19, 2021 at 11:00 AM Ralf Schlatterbeck <rsc@runtux.com> wrote:
> On Mon, May 17, 2021 at 10:20:35AM -0500, Rob Herring wrote:
> > Now it warns in linux-next:
> >
> > Documentation/devicetree/bindings/auxdisplay/hit,hd44780.example.dts:52.18-62.11: Warning (unit_address_vs_reg): /example-1/i2c@2000: node has a unit name, but no reg or ranges property
>
> [I'm the author of that patch]
> Can someone point me to the documentation of how to check a single
> example against the dt schemata? I think I had that figured out how to
> run the dt-checks over the whole tree in january but didn't bother with
> warnings since the whole devtree was riddled with warnings at the time.

It's much better in v5.13-rc2.

> Docs on how to quickly check for warnings/errors would help me a lot. My
> naive usage of dt-validate on an example yields a traceback, I've opened
> a report on github because I think that even with gross mis-usage the
> tool shouldn't traceback...

make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml

That still runs some checks on all files, unless you apply
https://lore.kernel.org/linux-devicetree/20210309112148.2309116-1-geert+renesas@glider.be/
first

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
