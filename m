Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E7530745B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhA1LD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhA1LDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:03:51 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F7DC061573;
        Thu, 28 Jan 2021 03:03:09 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b8so3106976plh.12;
        Thu, 28 Jan 2021 03:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=sBkTD1ZtjeS8jkP5hzFFT8Mun2/mkX9YEzpaHUFxKDc=;
        b=oWU+dINW3A0WDBPghq7TwOLXYGxn8ZkRNOSVDRg1ZoLaH3tdPLGkRb+/TjL3IYxi/t
         yL01IxDEFsbuWL4/FWKNeq1HG3nMJdFjnT2B+aCjX71phI82H9u7q+C3c6FPZBQmQ5Xm
         TpjmQbpkFZzMPm029X2JLq2jCljq1OAfy3e177WBsYDvmrP+uingSJpcWoKlqG18IpS9
         PUxzurfgaUSLguu4Hw5ChRSCchxcXAUIY7YqXj129oIJ+GGqABf2Jp9ctWIVMxJrFmMj
         qERYj5C96cgwnz//AGUDzeow2Ps8or8pBU4WPRZZcO0P8+S3B7XWK2ABKcw0nlHrM8YP
         J4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=sBkTD1ZtjeS8jkP5hzFFT8Mun2/mkX9YEzpaHUFxKDc=;
        b=qR1Bl23z1jZ7e5zXhnQGYM68jLUFjipk3DECmSm1RtvjlYkVqhT+agxwYtLwkFu575
         ttXYYv440h1qd6n0adOFAKKegtGXRoV1p3h3NyB/kOaBPVIF1SEI1JyiBTYPKTbzqVUR
         9dOzGoydKbBg78wVr2AnTzR1/JqjY71R2z+0+4TAj97SygU9ZUIKDOm2kDtUTsqTvscm
         oslGU41CzTjd0Sc22I4RkwuQZn01KfpnkIv+yIq80nJDlcJ39PvC28mxCdYurkcQ4pbC
         iurSFBOyVyTn9tocERrSMNRKst72Yt6ET0oB++AVXTEUCwLwaBRR5Z/tm/gZ8Uecj3S3
         P8Dw==
X-Gm-Message-State: AOAM530U1APRxvR7dV4uqXROZM53n8imEVxyJc+E37NFsiuU/OKF+oq1
        xUHIoTqPKF7k9vojN2wtYk4=
X-Google-Smtp-Source: ABdhPJxuKefhxuATg5SzADrFU6X/JMwte19Bjrcs0K6eys/yFrX6MPMndXfWktd7S71LXqppupaCdg==
X-Received: by 2002:a17:90a:db50:: with SMTP id u16mr10793125pjx.39.1611831789172;
        Thu, 28 Jan 2021 03:03:09 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id h6sm5685953pfr.47.2021.01.28.03.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 03:03:08 -0800 (PST)
Date:   Thu, 28 Jan 2021 19:03:01 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Colin King <colin.king@canonical.com>,
        oliver.graute@kococonnector.com, zhangxuezhi1@yulong.com,
        mh12gx2825@gmail.com, Stefano Brivio <sbrivio@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10] staging: fbtft: add tearing signal detect
Message-ID: <20210128190301.00007ebe@gmail.com>
In-Reply-To: <CAMuHMdWK0wbMVJNwSW=pafsyjDVg14h2AX=haJeAkyivehP=JQ@mail.gmail.com>
References: <1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com>
        <20210127223222.3lavtl3roc4cabso@kari-VirtualBox>
        <20210128094258.000012c3@gmail.com>
        <20210128065233.ji4b7ea54ihyu2l5@kari-VirtualBox>
        <CAMuHMdWK0wbMVJNwSW=pafsyjDVg14h2AX=haJeAkyivehP=JQ@mail.gmail.com>
Organization: Tyzmig-ryrjum-8kedto
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jan 2021 10:42:54 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Kari,
> 
> On Thu, Jan 28, 2021 at 7:53 AM Kari Argillander
> <kari.argillander@gmail.com> wrote:
> > On Thu, Jan 28, 2021 at 09:42:58AM +0800, carlis wrote:  
> > > On Thu, 28 Jan 2021 00:32:22 +0200
> > > Kari Argillander <kari.argillander@gmail.com> wrote:  
> > > > >  #include "fbtft.h"
> > > > >
> > > > >  #define DRVNAME "fb_st7789v"
> > > > > @@ -66,6 +69,32 @@ enum st7789v_command {
> > > > >  #define MADCTL_MX BIT(6) /* bitmask for column address order
> > > > > */ #define MADCTL_MY BIT(7) /* bitmask for page address order
> > > > > */
> > > > >
> > > > > +#define SPI_PANEL_TE_TIMEOUT     400 /* msecs */
> > > > > +static struct mutex te_mutex;/* mutex for set te gpio irq
> > > > > status */  
> > > >
> > > > Space after ;  
> > > hi, i have fix it in the patch v11  
> > > >  
> >
> > Yeah sorry. I accidentally review wrong patch. But mostly stuff are
> > still relevant.
> >  
> > > > > @@ -82,6 +111,33 @@ enum st7789v_command {
> > > > >   */
> > > > >  static int init_display(struct fbtft_par *par)
> > > > >  {
> > > > > + int rc;
> > > > > + struct device *dev = par->info->device;
> > > > > +
> > > > > + par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0,
> > > > > GPIOD_IN);
> > > > > + if (IS_ERR(par->gpio.te)) {
> > > > > +         rc = PTR_ERR(par->gpio.te);
> > > > > +         dev_err(par->info->device, "Failed to request te
> > > > > gpio: %d\n", rc);
> > > > > +         return rc;
> > > > > + }  
> > > >
> > > > You request with optinal and you still want to error out? We
> > > > could just continue and not care about that error. User will be
> > > > happier if device still works somehow.  
> 
> devm_gpiod_get_index_optional() returns NULL, not an error, if the
> GPIO is not found.  So if IS_ERR() is the right check.
> 
> And checks for -EPROBE_DEFER can be handled automatically
> by using dev_err_probe() instead of dev_err().
> 
hi, i fix it like below!?
	par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0,
	GPIOD_IN); if (IS_ERR(par->gpio.te)) {
		rc = PTR_ERR(par->gpio.te);
		dev_err_probe(par->info->device, rc, "Failed to request
	te gpio\n"); return rc;
	}
	if (par->gpio.te) {
		init_completion(&spi_panel_te);
		rc = devm_request_irq(dev,
				      gpiod_to_irq(par->gpio.te),
				     spi_panel_te_handler,
	IRQF_TRIGGER_RISING, "TE_GPIO", par);
		if (rc) {
			dev_err(par->info->device, "TE request_irq
	failed.\n"); return rc;
		}

		disable_irq_nosync(gpiod_to_irq(par->gpio.te));
	} else {
		dev_info(par->info->device, "%s:%d, TE gpio not
		specified\n", __func__, __LINE__);
	}


> > > You mean i just delete this dev_err print ?!
> > > like this:
> > >       par->gpio.te = devm_gpiod_get_index_optional(dev, "te",
> > > 0,GPIOD_IN);
> > >         if (IS_ERR(par->gpio.te))
> > >               return PTR_ERR(par->gpio.te);  
> >
> > Not exactly. I'm suggesting something like this.
> >
> > if (IS_ERR(par->gpio.te) == -EPROBE_DEFER) {
> >         return -EPROBE_DEFER;
> >
> > if (IS_ERR(par->gpio.te))
> >         par-gpio.te = NULL;
> >
> > This like beginning of your patch series but the difference is that
> > if EPROBE_DEFER then we will try again later. Any other error and
> > we will just ignore TE gpio. But this is up to you what you want to
> > do. To me this just seems place where this kind of logic can work.  
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

regards,
zhangxuezhi
