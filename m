Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFB339DE45
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhFGOEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:04:04 -0400
Received: from mail-yb1-f180.google.com ([209.85.219.180]:42762 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFGODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:03:50 -0400
Received: by mail-yb1-f180.google.com with SMTP id g142so5760304ybf.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 07:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9E8O5w/zkKI+sZ2afykxRWuriykTpkma4WIu7fNyIo=;
        b=FIt3KmJd++bHSzROQDE1qiyb4qF2bS66n6OFSnPYsreDNZpn5ikyqiNPMudRhHQE/o
         Q9yErBnO6nU8cItuUZqnITfjxBd6n8imCs4RajexvQvy1laeZScfSPWJJG2NuHdc8nhT
         TkRgHnqlXr7ukioUCXvlW5BWu4Fa0cWbzAR5Ju8MWFy0fZsazoqacWF+k+oGqsSMIl28
         XWDlL+VYSO3fhmx1rVxccM8s/kYFztMVjGXwc4pq84h7AWtySpUMsV9NBYNc8mDdn4hV
         2km8FRrWQk7UhYPrlemBLlKv8jqnPjSc6tMXVR0xxg+3pp8+vpS1gTfMUyA3QlxeMkT4
         vdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9E8O5w/zkKI+sZ2afykxRWuriykTpkma4WIu7fNyIo=;
        b=GF5R66joLD6LkvzK0tZSgXfB5fXugcsW07PjuCHbYQXPatcT2mdOKpJ3TKINJbQ2PI
         kdGTHguDbEztkY8IK1CCnjqGfuNAv6Nd60Qo9juV7Z10D+Kq0Y4Fmfxz008QbP4qTLPk
         VryQhZAGB2Lqk8UJc+oeOfkQLIj6CdkqzKjNvnrqhJCTDsUGFrylyTu0rpHk4OBda4ri
         OfxNH7DemCsASwP7DfSxdI2T3xR3GrfNEcug3m4AKGdwNIUPHEzoTxoOpbHMpyWW5xRD
         7ICMvxvfnQa1vis3lXl4EVvSdZtqTd8yClNkJfGRDGk5TdCqbHz0qzl8RqYsVjB16Zsd
         Cvow==
X-Gm-Message-State: AOAM532pHtihs/g0iIrumu3G9H9wszutBWRVPbq974mnY5Q9nPatOy5C
        ZIMyDbMNiOj+6ncQaO3so7S5nJpSIwKlN31i4D9gz8IL5OY=
X-Google-Smtp-Source: ABdhPJxQAjRPnrTamhPFtLVjNmDSjKsYm8FSssRCgIhEJ9WM4D5e+Rb2US2TlunEUXj5ul/iDseg0wsMSaRxHx6dEjE=
X-Received: by 2002:a25:420c:: with SMTP id p12mr23656144yba.25.1623074458505;
 Mon, 07 Jun 2021 07:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210514123309.134048-1-tsbogend@alpha.franken.de>
 <20210604122223.GA8940@alpha.franken.de> <CACRpkdafaMUjai4VCxePX2kWFkh4=Ks5qQvHTtYvVtkeHPhKKA@mail.gmail.com>
In-Reply-To: <CACRpkdafaMUjai4VCxePX2kWFkh4=Ks5qQvHTtYvVtkeHPhKKA@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 7 Jun 2021 16:00:47 +0200
Message-ID: <CAMpxmJUH7ap1r4EM8h=moXOinBP6=FKt9hDwOiu_oMedNinyeA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] gpio: Add support for IDT 79RC3243x GPIO controller
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 12:04 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Jun 4, 2021 at 2:22 PM Thomas Bogendoerfer
> <tsbogend@alpha.franken.de> wrote:
>
> > is there anything a still need to do to get this integrated for v5.14 ?
>
> IMO not really:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Bartosz is collecting the patches for v5.14.
>
> Yours,
> Linus Walleij

Sorry for the delay, I'm currently overwhelmed with a house renovation
and the approaching move. Now applied (together with the bindings),
thanks!

Bartosz
