Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F15E3A163E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbhFIN6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:58:25 -0400
Received: from mail-yb1-f181.google.com ([209.85.219.181]:33606 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236832AbhFIN6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:58:16 -0400
Received: by mail-yb1-f181.google.com with SMTP id f84so35663623ybg.0;
        Wed, 09 Jun 2021 06:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXjV+7f0WBEMMRJY6HHsrOAPf0kxeVuUsWsm/eKN1x0=;
        b=nuBjQAL5dmQJsfGHqyV7lCsKg8VMnGOS9MjB4dcjlxggDE1PTZzaBxPooYUgttS4Rr
         7tOQzWL/RfBcaJ6PI6DPfn2hTAecrr6GYpTXIcfO93nzx2HxsuZ88BiUZlUUx38vCGDw
         eAST/XodvPIcd2jBnsBpIhfp5cU/Zd3B1/HHDnLc9c6HgiDEpQyKilQPQIKSuU9fH/Mz
         JDJBBeLKKQMryZvSh+nAzh4VhMNKvIMnUun3iwj0VjFfuhKh0aiJX8SCmanSXnkmR/7r
         SG2lT9t0tjvH31htXiqpg6fKdBs5np/gIHDLHruwOyGRRc9nS5ty6qc6lfxkzyLSXyyl
         CZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXjV+7f0WBEMMRJY6HHsrOAPf0kxeVuUsWsm/eKN1x0=;
        b=ZDfIh+40c6p+WsunrD/TWEL7O87EZSp2Qip7Z1fYv3/Xk31zfEsxhale5LKQFLtDw0
         1suBZsSWb2R69B8ylUxTB4bQBegWEav+hPpixBH67lXxLI+0jz6zB8uD7J3s4zSuLUmz
         whTsCf8wYW2sCwb+XfT/2EQd6DxZ51ehRQ0i2dAwIgdlqL0fhq4wuPD5x0xt8qlXmKUJ
         cxgADKTKeH7h5iZbxP6nS99KvFZfg977uZOx16oyjoT/+3txAPGcSGrb4P6GyGeg3H0o
         EGsI4DlPkiARm7CI+xNAS/AsGDT49zItQXn4y9x/6bQIPfcSnyYAZjer8oRZd1M3IRxm
         2lwg==
X-Gm-Message-State: AOAM531gVPjzZz80j5EhRvOITOjPx3kbHmyEvlCbNSe98zKcSqvMH1EF
        ARiuaCP9PoMQdLJbHjg9VXlsVa4xRkxnigeBUGEWycO1XKo=
X-Google-Smtp-Source: ABdhPJz8f3xgTQQ46PvVqRFbiiyhAukL7Qu0iE18p8GB/7VEmTdV0b5PltB8mP8HWP+bDHJmDEPn0pfX1jI6hylRwyw=
X-Received: by 2002:a25:a289:: with SMTP id c9mr245565ybi.26.1623246921522;
 Wed, 09 Jun 2021 06:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210106113730.k5qveshjgcd57kgx@runtux.com> <20210106113929.fizyg6fcsmsntkiy@runtux.com>
 <CANiq72=Cfv=Qo2fs+HDjUc8pV37mL326SDS5JpGotUfHLwK_rQ@mail.gmail.com>
 <CAMuHMdUW3U6DVkHp3xiHFzvRUDJ1FwTNCnBWp5LCuDGxhds9wg@mail.gmail.com>
 <CANiq72mCFwYnbynQgwNGTt0mzo_rMrnQfpinz6DrPttFxUpyNQ@mail.gmail.com>
 <20210517152035.GA2581887@robh.at.kernel.org> <20210519090047.e63d2im5vgskqpcs@runtux.com>
 <CAMuHMdV80XUo5ihXUkogCikGA4H71Ada9w=9W9d9d1zdgrw0uA@mail.gmail.com> <20210519115450.qoqpy7d5dgnjtenx@runtux.com>
In-Reply-To: <20210519115450.qoqpy7d5dgnjtenx@runtux.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 9 Jun 2021 15:55:10 +0200
Message-ID: <CANiq72m+gqGWpUnA1tk0GX-wKdDnXF_1dKftjOLEAt4rjsnoaw@mail.gmail.com>
Subject: Re: [PATCH 1/1] auxdisplay: Add I2C gpio expander example
To:     Ralf Schlatterbeck <rsc@runtux.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Lars Poeschel <poeschel@lemonage.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf, Rob,

On Wed, May 19, 2021 at 1:54 PM Ralf Schlatterbeck <rsc@runtux.com> wrote:
>
> The hd44780 displays are often used with pcf8574 based I/O expanders.
> Add example to documentation.
>
> Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>

I have queued this one into -next, adding the `Suggested-by` tag.

Cheers,
Miguel
