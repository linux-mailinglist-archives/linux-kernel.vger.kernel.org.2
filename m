Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB98B3206CC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 20:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBTTMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 14:12:17 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:46492 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhBTTMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 14:12:09 -0500
Received: by mail-wr1-f54.google.com with SMTP id t15so14485737wrx.13;
        Sat, 20 Feb 2021 11:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AP8Qz4CyqLCo3NhHxc8oaozrdLe2+NNTf4O5yIMTDZs=;
        b=MmkqC0XOCQPGR0+zzhT1p2L+eW2eYFkDOiwJ7c4+ibr1SwHVQzwxdOdtUescP2FZIH
         f57rdgIiI9sNRduGkhE95IuUFFP5QYKM9Chv5sd/pihbZ5xvf0KKOvM4Wz50e8w3KAAV
         QATWHjK1IMRp49DMRLNs/fvpaWjZxT91zMTzi+HNGWt63qYA1JGQ3EjDZXMdnd9i/PBx
         3ZCRMlxY3dMVHefmw6MmtWJeKOh3pvd7vRB7VK4G3vvt6Iffhk82BkwQ5NBsfYequHYM
         c2zCMtMYxYMf7ZLfdN2Uis5dyluh9OmDrk5Qr2rU4VJYaJ/BfuXFN0EQfHlAfa4jVvhv
         gbYA==
X-Gm-Message-State: AOAM5317w8kHSos0Uu/PA+JXemLYpQDYhYVEJI+F7JoiK6I6OS8Y8Cbo
        nx7XxROJjPyggvf26HY0evQ=
X-Google-Smtp-Source: ABdhPJxBMP1FyAVRPUHU97bTnL2Py6n86AFr2ysvpg9k2xugwJ1xH2BjBMPhVY/EduC0v8exbqtj+g==
X-Received: by 2002:adf:818a:: with SMTP id 10mr11367651wra.31.1613848287129;
        Sat, 20 Feb 2021 11:11:27 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id q140sm22790571wme.0.2021.02.20.11.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 11:11:26 -0800 (PST)
Date:   Sat, 20 Feb 2021 20:11:24 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/25] tty: serial: samsung_tty: IRQ rework
Message-ID: <20210220191124.wjkkqz2boxsdkf2b@kozik-lap>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-20-marcan@marcan.st>
 <20210215184012.sf6p6dbk5c25phdm@kozik-lap>
 <31068a51-736b-08f6-6c00-1779734465ea@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31068a51-736b-08f6-6c00-1779734465ea@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 10:53:10PM +0900, Hector Martin wrote:
> > Separate patch for trivial renaming.
> 
> I think it makes sense to do this rename together with the first change
> above, as it keeps both functions symmetric. Otherwise we end up with an
> inconsistent function naming between both patches. If you really want it
> separate though, I can do that.

OK, keep your version.

> 
> > 
> > > 
> > > Signed-off-by: Hector Martin <marcan@marcan.st>
> > > ---
> > >   drivers/tty/serial/samsung_tty.c | 41 +++++++++++++++++++-------------
> > >   1 file changed, 24 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> > > index 21955be680a4..821cd0e4f870 100644
> > > --- a/drivers/tty/serial/samsung_tty.c
> > > +++ b/drivers/tty/serial/samsung_tty.c
> > > @@ -151,6 +151,9 @@ struct s3c24xx_uart_port {
> > >   #endif
> > >   };
> > > +static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport);
> > > +static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport);
> > > +
> > >   /* conversion functions */
> > >   #define s3c24xx_dev_to_port(__dev) dev_get_drvdata(__dev)
> > > @@ -316,8 +319,6 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
> > >   	ourport->tx_mode = 0;
> > >   }
> > > -static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport);
> > > -
> > 
> > Why moving this? Why adding s3c24xx_serial_tx_chars() forward
> > declaration?
> 
> This should've gone in the next patch. A previous reviewer told me to put
> declarations at the top of the file, so I put it there and moved this one
> along with it, but I'll keep it to the additon only for v3.

Maybe I missed something in the context but it looked like
forward declaration s3c24xx_serial_tx_chars() was not needed? In such
case no need to move it.

Best regards,
Krzysztof

