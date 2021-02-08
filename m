Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26DD312D9B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 10:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhBHJoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 04:44:30 -0500
Received: from mail-ej1-f46.google.com ([209.85.218.46]:42702 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbhBHJhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 04:37:09 -0500
Received: by mail-ej1-f46.google.com with SMTP id l25so6227613eja.9;
        Mon, 08 Feb 2021 01:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a83njXoovn0qtrB4EyPB9Yl+LzkRQ7pFu3WjHr3iefI=;
        b=DexBJFFt9wXulSi3SXjgwB0Fn94NDyf3XyDCakA4Yafke8oH4V+bDY0FwgZ7gZAXqi
         9xJK0sEwAmVy1yhm+jR1TwwH/6h+nAUxumbfuGpmiiiRGC0Vw6VKTaudc1csAmxbovij
         QYp93EgT1TPKZHiE7DYAM3lWVv5OwvkwCBOYI4KEMZWgHqdnm+s0fpL3ZGl6JqnG8Qj0
         V81DIBR5KkbktrtlpEF50qPHjQov2HgZBr3k1rf93ACDF2faujnV9GquEpMzMGmFfeTT
         Vhj2y6eEUaCU/xdxRiFFUOznPfx0I4B0wu1gWu4B9tSi/1N/bIYkZMQUIQQ/nAFwXtoS
         LPig==
X-Gm-Message-State: AOAM5310gRoVB49lZs3WyP7ji6t+MZysd0+yjUNiyhRa1lnN23QqaECI
        7E297WA8gZL5rm72+Ni8Pga7u9Z/Kyw=
X-Google-Smtp-Source: ABdhPJxsEsOQPr31EIv/8wBxOnZllOnQfSoEJaey/Jsc/XmZpEyjNY737e5BsGWYE7T4PnSiPWWklw==
X-Received: by 2002:a17:906:199a:: with SMTP id g26mr16161672ejd.485.1612776987720;
        Mon, 08 Feb 2021 01:36:27 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id df15sm8949477edb.24.2021.02.08.01.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 01:36:26 -0800 (PST)
Date:   Mon, 8 Feb 2021 10:36:25 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hector Martin 'marcan' <marcan@marcan.st>
Cc:     Marc Zyngier <maz@kernel.org>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 05/18] tty: serial: samsung_tty: add support for Apple
 UARTs
Message-ID: <20210208093625.trpm3tte2gw24w4l@kozik-lap>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-6-marcan@marcan.st>
 <87lfc1l4lo.wl-maz@kernel.org>
 <e842f37d-d788-2d34-05e4-86ef94aed8f5@marcan.st>
 <e2bd8f99-58db-4cae-30b3-6fa608bc76dd@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2bd8f99-58db-4cae-30b3-6fa608bc76dd@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 06:26:43PM +0900, Hector Martin 'marcan' wrote:
> On 07/02/2021 18.12, Hector Martin 'marcan' wrote:
> > On 06/02/2021 22.15, Marc Zyngier wrote:
> > > The default should be IRQ_NONE, otherwise the kernel cannot detect a
> > > screaming spurious interrupt.
> > 
> > Good point, and this needs fixing in s3c64xx_serial_handle_irq too then
> > (which is what I based mine off of).
> > 
> > > > +	ret = request_irq(port->irq, apple_serial_handle_irq, IRQF_SHARED,
> > > > +			  s3c24xx_serial_portname(port), ourport);
> > > 
> > > Why IRQF_SHARED? Do you expect any other device sharing the same line
> > > with this UART?
> > 
> > This also came from s3c64xx_serial_startup and... now I wonder why that
> > one needs it. Maybe on some SoCs it does get shared? Certainly not for
> > discrete rx/tx irq chips (and indeed those don't set the flag)...
> > 
> > CCing Thomas, who added the S3C64xx support (and should probably review
> > this patch); is there a reason for IRQF_SHARED there? NB: v1 breaks the
> > build on arm or with CONFIG_PM_SLEEP, those will be fixed for v2.
> 
> Seems Thomas does not work for Linaro any more :)
> 
> CCing Krzysztof instead, who is the Samsung arch maintainer.

Please use the scripts/get_maintainers.pl to get the list of people to
Cc. The script would point necessary folks.

A different issue is that all your emails from this thread were marked
by Google as spam.  I don't see any particular warning signs in the
header so it looks more of content-based match for spam.

> > Either way, certainly not for Apple SoCs; I'll get rid of IRQF_SHARED
> > for v2.

Please send a v2 after fixing issues pointed out by kbuild.

Best regards,
Krzysztof

