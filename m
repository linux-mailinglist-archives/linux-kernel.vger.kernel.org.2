Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C56314000
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbhBHULB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:11:01 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:35832 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbhBHSiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:38:08 -0500
Received: by mail-wm1-f48.google.com with SMTP id j21so106327wmj.0;
        Mon, 08 Feb 2021 10:37:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LCazIuYzBZltynFuvPO11MbeG9djR0YG9Vn4Gd94Mj8=;
        b=QGfiMaFFqYMrxxD9dr1LLO2QXdRd8oDIAgBVmNmZGKSQV9jfes9BxzduerLUDqcL7r
         WxpxAIbE8v10JbwjQE4DN1A8ci3mYwklZgnxvdnAsdXx00pK5puCCZ+NNnAQtOVaxk+X
         ndB3UF3nPAu2BCoiZ+KNh8zq8JtQxLhIEITCBborkWXw839IiaYmElWpcSLDXS0lp/g8
         ddU+b0mkLa6q4N2kDc9kAxBe7UgAbcxfqF4jUKOBlkNe52u1hpj14p84W6acKVsfSpOq
         BjiNjZ9uVRXuJKtkx0QLIxY9Mw2DHS/D9yOVhAHaIkAM8DFWxb3uvt0R99IenYKqhtni
         bknw==
X-Gm-Message-State: AOAM533oPjCIelrBHnvxyBYve31smROscGcFpvRYOSYps5g5XUfuBZQP
        fakfR2yhbFRAA/d7t5W/E04=
X-Google-Smtp-Source: ABdhPJx5+93U+Vf00VOHmUASuEOURE6VEeP94SC6giYw0Z/wDYFCVRw7Hu+lyDXt+hRbtNuLKTqKbA==
X-Received: by 2002:a1c:39d5:: with SMTP id g204mr92727wma.127.1612809444236;
        Mon, 08 Feb 2021 10:37:24 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id x15sm13363628wro.66.2021.02.08.10.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 10:37:23 -0800 (PST)
Date:   Mon, 8 Feb 2021 19:37:21 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 05/18] tty: serial: samsung_tty: add support for Apple
 UARTs
Message-ID: <20210208183721.4gc7vyfgtpk7nch3@kozik-lap>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-6-marcan@marcan.st>
 <20210208105451.yumjjunjeyrglfnw@kozik-lap>
 <11d36c47-45c6-03ee-2d08-6692b5d0e241@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11d36c47-45c6-03ee-2d08-6692b5d0e241@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 01:10:02AM +0900, Hector Martin wrote:
> On 08/02/2021 19.54, Krzysztof Kozlowski wrote:
> > > +enum s3c24xx_irq_type {
> > > +	IRQ_DISCRETE = 0,
> > > +	IRQ_S3C6400 = 1,
> > > +	IRQ_APPLE = 2,
> > 
> > It seems you add the third structure to differentiate type of UART.
> > There is already port type and s3c24xx_serial_drv_data, no need for
> > third structure (kind of similar to tries of Tamseel Shams in recent
> > patches). It's too much. Instead, differentiate by port type or prepare
> > own set of uart_ops if it's really different (like you did with startup
> > op).
> 
> This ties into little changes in a bunch of places, so separate uart_ops
> callbacks for every one of those would end up duplicating a lot of code :(
> 
> That list is just used to map the port type to something that only
> represents the type of IRQs, but its only real purpose for the indirection
> is so I can do "== IRQ_DISCRETE" in some codepaths to mean "not apple or
> S3C6400".
> 
> e.g.
> 
>     if (s3c24xx_irq_type(port) == IRQ_DISCRETE)
>         free_irq(ourport->rx_irq, ourport);
> 
> Would have to become
> 
>     if (port->type != IRQ_S3C6400 && port->type != IRQ_APPLE)
>         free_irq(ourport->rx_irq, ourport);
> 
> or
> 
>     switch (port->type) {
>     case IRQ_S3C6400:
>     case IRQ_APPLE:
>         break;
>     default:
>         free_irq(ourport->rx_irq, ourport);
>     }
> 
> Which one do you prefer?

The latter, especially that switches will appear quite a lot in such
case.

However this pattern (== IRQ_DISCRETE) appears only in three places so
it should not be the main case considered here.

However I saw later you actually replaced the
s3c24xx_serial_has_interrupt_mask(), so it's not that bad.

In most of your code, there will be actually a switch with all three
cases.

> 
> Aside: Marc didn't like introducing new port types into uapi, but if we
> don't do that then we need a "real" port type in drv_data that isn't the
> uapi-exposed port or something along those lines, with a separate enum
> containing all the true port type values for that.

Looking at Greg's comment, we can get rid of the PORT_ stuff entirely.
First of all, PORT_S3C2410 == PORT_S3C2412, so this define is not
accurate.

This leaves us with three types (s3c2400, s3c2440, s3c6410 and Apple).
The s3c2440 could be removed with adding a new "ucon_mask" field to
s3c24xx_serial_drv_data.

This would end with s3c24xx, s3c6410 and Apple - quite nice choice.

> 
> > >   	/* Startup sequence is different for s3c64xx and higher SoC's */
> > > -	if (s3c24xx_serial_has_interrupt_mask(port))
> > > +	case IRQ_S3C6400:
> > >   		s3c24xx_serial_ops.startup = s3c64xx_serial_startup;
> > 
> > Don't overwrite specific ops. It's difficult to see then which ops are
> > being used. Instead create a new set of uart_ops matching the needs.
> 
> s3c24xx_serial_ops was already doing that here, but I can move that to a a
> separate uart_ops too.

You're right. This one would have to be improved before your change.
Instead of replacing specific op calls in startup, I think it's better
to have entirely separate ops instance for each variant:

static const struct uart_ops s3c24xx_serial_ops;
static const struct uart_ops s3c64xx_serial_ops;
static const struct uart_ops s5l_serial_ops;

This allows to add a "const", since uart_port takes such const pointer.

Still during s3c24xx_serial_probe() correct ops would have to be
assigned, but at least all ops are easily visible.

Best regards,
Krzysztof

