Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF3A30A5EE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhBAK4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:56:02 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:45308 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbhBAKzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:55:31 -0500
Received: by mail-oi1-f171.google.com with SMTP id g69so18291577oib.12;
        Mon, 01 Feb 2021 02:55:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TsZddNdEu5n1CGxavoWBCizkLcHFPyez/OBFVu2/Ol4=;
        b=uZZpSLxlc9IrMJpLJ3ZPp/etwR6FkMSHS45sM5GphC+qvUzPJnL9cLz6icY5RcfpTI
         pQdfKo0RTE6nZbS/wslaPxsUCNH+VXSTe7MZ3u0L4BKGNM9GPTT6I95+Ih4fdvg3xsMP
         3sCIPBTu8LMeMxL7fOPDj7Kew3z1ebVb2Aad0EL44c2Dt1qPHLbvR+jTwzk0FJsjyMqn
         286lQgNhpdWD9NAw0RJldh/z9eOvXaOE3eYtyCSGOda5VoxzI+p26DsqkWqznsllGE8I
         i8McmBxqQw8/n99lYkBXIYpRPIWg7D8pIormuDm9C62Ap0CLhBKyl9d49J7lwYOgyYsl
         TMRg==
X-Gm-Message-State: AOAM532wHNjigD30ZL3O34rQ0i1YTI5OUG4tWgXj9AJPWOdOtZyTReq5
        aSzHjBcwbDDggIs0ccXcz4rZkuUmakp+G9ehYto=
X-Google-Smtp-Source: ABdhPJyN2ZpzXcNCMXgUY3hrigvtGooBg8Ikn1SHhUS4Nh5ldPH91gGT2AWWgTkluWm7nrP3FGpgBWJnKTnSMsXIHs0=
X-Received: by 2002:aca:4d8d:: with SMTP id a135mr10215866oib.153.1612176890041;
 Mon, 01 Feb 2021 02:54:50 -0800 (PST)
MIME-Version: 1.0
References: <20210128104446.164269-1-tudor.ambarus@microchip.com> <CAGETcx9CodHDeqSYM1zQXRi-p_rFUJQgwMtnuWeKvCt_B3dCOw@mail.gmail.com>
In-Reply-To: <CAGETcx9CodHDeqSYM1zQXRi-p_rFUJQgwMtnuWeKvCt_B3dCOw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 1 Feb 2021 11:54:38 +0100
Message-ID: <CAMuHMdXqQL3PQvgC-zACkMyF8S3kg9-RPxvJMK8WXqu45EhwEg@mail.gmail.com>
Subject: Re: [PATCH] clk: at91: sama5d2: Mark device OF_POPULATED after setup
To:     Saravana Kannan <saravanak@google.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>, mirq-linux@rere.qmqm.pl,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Thu, Jan 28, 2021 at 6:08 PM Saravana Kannan <saravanak@google.com> wrote:
> I already accounted for early clocks like this when I designed
> fw_devlink. Each driver shouldn't need to set OF_POPULATED.
> drivers/clk/clk.c already does this for you.
>
> I think the problem is that your driver is using
> CLK_OF_DECLARE_DRIVER() instead of CLK_OF_DECLARE(). The comments for
> CLK_OF_DECLARE_DRIVER() says:
> /*
>  * Use this macro when you have a driver that requires two initialization
>  * routines, one at of_clk_init(), and one at platform device probe
>  */
>
> In your case, you are explicitly NOT having a driver bind to this
> clock later. So you shouldn't be using CLK_OF_DECLARE() instead.

Unless I'm missing something, name##_of_clk_init_driver() clearing
OF_POPULATED again causes consumer driver probing to be postponed by
fw_devlink until the second initialization phase of the provider has been
completed?

This is wrong if the consumer only needs a clock instantiated during the
first phase, and may cause issues if the consumer is a critical device.
E.g. a timer, on ARM SoCs lacking an architecture timer (pre-Cortex
A7/A15) or global timer (pre-Cortex A9, or single-core Cortex A9).
Probably there are more examples.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
