Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC40740404D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 22:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350412AbhIHUt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 16:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbhIHUt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 16:49:27 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF01C061575;
        Wed,  8 Sep 2021 13:48:19 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id s16so3738956ilo.9;
        Wed, 08 Sep 2021 13:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nqyp+lOHavn3kMru/T+vHedvAXQzg5WGRJd6AHmc1Kc=;
        b=gkSXmAj13MhVsl8YuiUAR4XRq//FNYriVENQAcmlDsIi2uvoXQijlr5P5Owc+6C9dI
         VzBbmXkY0cRcds0m74u7YbCdvWCEx7JE30ch7jCOOYfiqughpLViaW5+XbSAizDBhDWW
         Hrc3nQTwBfIJskn/+DylLyX4ErYCyUVDPPCZlytYBSlHXBZHcwwwk4OIcNeSJtfLIvW+
         Ut9+V5nY/yzQ/W+5X/Yp/UpPkP8F6926Q1hzNpU+0lgZDibbsg5OISoEq8VpVCwWEtr5
         cSsOuLRuI5GdvGlxwfF4IbOqr51LoUIC4z9bp21PXaCrcN14eXiz67mFGFcCtv64lGsx
         tWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nqyp+lOHavn3kMru/T+vHedvAXQzg5WGRJd6AHmc1Kc=;
        b=p9clUjCGlOhsxR7zIlRW/xsE/E+Ke0AtJZaFVd0NsIvcBuMnLHupp4xnPRlJzJepYE
         227y/v/h8xbrNvOsvJqShCtPSaZIwS8/pIRLkK49O1FtYe8uOaWKex/7irZclU257Dm7
         R7gwRulSzP80hLqzj6wmjgZ0+B6kzWyQYIx7dmj7ZMLo/vJLovBKBjW5KArc/p39O5PG
         DzIU14D+pXg50KrsSErhgcvsUPr9iTFs8r1KbNbZkawegBxaItDElKVlwWZEJAsW+H6c
         1PnAfeEccW5khbXUQ1P1KUYLfPrbtG//07EU+FXN4zvtRGVaH0UP0upYXy/Uu/dBOF4j
         maEA==
X-Gm-Message-State: AOAM530wuBLCr9r53LUkF+W/nnlSvjTEiOBAdyOYWig5nCLYi5L2H1K+
        jhT5fLabk46+5MvfXlGqFVHKadqYe+hkxpns9do=
X-Google-Smtp-Source: ABdhPJxscfKmm1/CQTSYMiUFfz+THsOWK+HjU4mIjEHc79iG0Pfz489s6fK2xfOP7ppE6ne+csoYycaAvz/IrhwousM=
X-Received: by 2002:a92:c144:: with SMTP id b4mr126876ilh.67.1631134099131;
 Wed, 08 Sep 2021 13:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210907145501.69161-1-sven@svenpeter.dev>
In-Reply-To: <20210907145501.69161-1-sven@svenpeter.dev>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 8 Sep 2021 15:48:08 -0500
Message-ID: <CABb+yY3LYwybJfXTndPx5T+zKu4DdrSzNY0SAsZBr_qvfscEmw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Apple Mailbox Controller support
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 9:55 AM Sven Peter <sven@svenpeter.dev> wrote:
>
> Hi,
>
> This series adds support for the mailbox HW found in the Apple M1. These SoCs
> have various co-processors controlling different peripherals (NVMe, display
> controller, SMC (required for WiFi), Thunderbolt, and probably more
> we don't know about yet). All these co-processors communicate with the main CPU
> using these mailboxes. These mailboxes transmit 64+32 bit messages, are
> backed by a hardware FIFO and have four interrupts (FIFO empty and FIFO not
> empty for the transmit and receive FIFO each).
>
> The hardware itself allows to send 64+32 bit message using two hardware
> registers. A write to or read from the second register transmits or receives a
> message. Usually, the first 64 bit register is used for the message itself and
> 8 bits of the second register are used as an endpoint. I originally considered
> to have the endpoint exposed as a mailbox-channel, but finally decided against
> it: The hardware itself only provides a single channel to the co-processor and
> the endpoint bits are only an implementation detail of the firmware. There's
> even one co-processor (SEP) which uses 8 bits of the first register as its
> endpoint number instead.
> There was a similar discussion about the BCM2835 / Raspberry Pi mailboxes
> which came to the same conclusion [1].
>
> These mailboxes also have a hardware FIFO which make implementing them with the
> current mailbox a bit tricky: There is no "transmission done" interrupt because
> most transmissions are "done" immediately. There is only a "transmission fifo
> empty" level interrupt. I have instead implemented this by adding a fast-path to
> the core mailbox code as a new txready_fifo mode.
> The other possibilities (which would not require any changes to the core mailbox
> code) are to either use the polling mode or to enable the "tx fifo empty"
> interrupt in send_message and then call txready from the irq handler before
> disabling it again. I'd like to avoid those though since so far I've never seen
> the TX FIFO run full which allows to almost always avoid the context switch when
> sending a message. I can easily switch to one of these modes if you prefer to
> keep the core code untouched though.
>
Yes, please keep the api unchanged.
Let us please not dig our own tunnels when the existing ways serve the purpose.

Thanks.
