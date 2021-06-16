Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3173AA174
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhFPQhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhFPQhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:37:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7339C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 09:35:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m3so1634772wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 09:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zS7RuUlJcHUs9ttjVxWOJPdiajaZF3G5dbHgPSXLs3o=;
        b=jFsXmYTbfnJulEbJiGZ7OAzRc/ubvrabMa0le9Kgt5AUC+vQKOcECD0WXOjfQuFfeI
         FdYDwfpTpGDR4kXLO6oxTiR6BsD4l5J9fGrjD6iyYCyPXm75k2QjGIZmn5FG+iSghVqR
         30ZvFRQujiMJ7ubg+5RroDPt6Hjg0J1G0/lprtNEV4MH+XiBwW/h3qqKQ926wCQ40rLF
         Obei1snoSBNs9UOrHycUfCfNwtarip2a+pBxSApz8v/5wweWAUN6C0Ri4TrbJGXTAmUS
         HgtTHdhsndgM7tELVR/RvttWhqDttaFt+OELF2CbEeWvP+EKmbR20KqP/3QWNyCNgDnK
         8pQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zS7RuUlJcHUs9ttjVxWOJPdiajaZF3G5dbHgPSXLs3o=;
        b=i4OGe0R4U11Hw//ATDmRCFXUDT7EU12/77CiZafPG2/Vyau7S/+9Zqle/4fJ69t7GQ
         YXkcsje9AdmL9yc5GqcvkHNFGJ/0offiq2cOM9m/k/W70BETFrdoOLKBq4FgMr7Da6fQ
         OgjRZBtzkDZOvRszWaKUzGEZt/Sdxjj2MmBj+Syq0qMoj4tKHckCJ+woVkigcbTUxJm8
         QIMXPc0AmJhszgSwL/Rv449ZcNd/VSBg/wAoArlThNuXNYmzkpUXY5lufuVCNgtJXFfu
         dbEd0/2bYNgUp6lg8xO4yC8cru+SqD05HnIdd2tUlfOY8mjqwR3VQQMwmLB/25TJYW4z
         nlag==
X-Gm-Message-State: AOAM530NCSaVADLrVAlAA2OXVfAUKoSoPB14OWRyJPrRi3JnvwfNZHJa
        PnpTJhLG1Y75p6A2Hk2vD4/g2w==
X-Google-Smtp-Source: ABdhPJwrvT30Z7kLQZLQ6Ed4sSIei3AFNUBLiNU7IdQ+zo6HFKeAaiYpViVRCGhSvctOdbCA3SnNcA==
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr12280755wmk.147.1623861342227;
        Wed, 16 Jun 2021 09:35:42 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id 2sm2575130wrz.87.2021.06.16.09.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:35:41 -0700 (PDT)
Date:   Wed, 16 Jun 2021 17:35:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH mfd v2] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <YMooW5AALqdaGjXz@dell>
References: <1622652224-19103-1-git-send-email-min.li.xe@renesas.com>
 <YMiwEYLkbKocs8ux@dell>
 <OS3PR01MB65937F621F5A7B6C855D3627BA0F9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB65937F621F5A7B6C855D3627BA0F9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021, Min Li wrote:

> > > diff --git a/drivers/mfd/rsmu_spi.c b/drivers/mfd/rsmu_spi.c
> > > new file mode 100644
> > > index 0000000..f3a087b
> > > --- /dev/null
> > > +++ b/drivers/mfd/rsmu_spi.c
> > > @@ -0,0 +1,265 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * SPI driver for the IDT ClockMatrix(TM) and 82P33xxx families of
> > > + * timing and synchronization devices.
> > > + *
> > > + * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas
> > Company.
> > > + */
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/init.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/spi/spi.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/of.h>
> > > +#include <linux/mfd/core.h>
> > > +#include <linux/mfd/rsmu.h>
> > > +#include "rsmu_private.h"
> > > +
> > > +/*
> > > + * 16-bit register address: the lower 7 bits of the register address come
> > > + * from the offset addr byte and the upper 9 bits come from the page
> > register.
> > > + */
> > > +#define	RSMU_CM_PAGE_ADDR		0x7C
> > > +#define	RSMU_SABRE_PAGE_ADDR		0x7F
> > > +#define	RSMU_HIGHER_ADDR_MASK		0xFF80
> > > +#define	RSMU_HIGHER_ADDR_SHIFT		7
> > > +#define	RSMU_LOWER_ADDR_MASK		0x7F
> > > +
> > > +static int rsmu_read_device(struct rsmu_dev *rsmu, u8 reg, u8 *buf,
> > u16 bytes)
> > > +{
> > > +	struct spi_device *client = to_spi_device(rsmu->dev);
> > > +	struct spi_transfer xfer = {0};
> > > +	struct spi_message msg;
> > > +	u8 cmd[256] = {0};
> > > +	u8 rsp[256] = {0};
> > > +	int ret;
> > > +
> > > +	cmd[0] = reg | 0x80;
> > > +	xfer.rx_buf = rsp;
> > > +	xfer.len = bytes + 1;
> > > +	xfer.tx_buf = cmd;
> > > +	xfer.bits_per_word = client->bits_per_word;
> > > +	xfer.speed_hz = client->max_speed_hz;
> > > +
> > > +	spi_message_init(&msg);
> > > +	spi_message_add_tail(&xfer, &msg);
> > > +
> > > +	ret = spi_sync(client, &msg);
> > > +	if (ret >= 0)
> > > +		memcpy(buf, &rsp[1], xfer.len-1);
> > 
> > What's at rsp[0]?  Worth a comment?
> > 
> 
> I don't really know. This code is being used as is and tested working.
> Can I find out and add the comment later?

Yes, please find out before you submit the next version.

> > > +MODULE_LICENSE("GPL");
> > > diff --git a/include/linux/mfd/idt82p33_reg.h
> > b/include/linux/mfd/idt82p33_reg.h
> > > new file mode 100644
> > > index 0000000..fb41ab0
> > > --- /dev/null
> > > +++ b/include/linux/mfd/idt82p33_reg.h
> > > @@ -0,0 +1,112 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > +/* idt82p33_reg.h
> > 
> > Remove the filename, they have a habit of becoming out of date.
> > 
> > > + *
> > > + * Register Map - AN888_SMUforIEEE_SynchEther_82P33xxx_RevH.pdf
> > > + *
> > > + */
> > 
> > Copyright.
> 
> Sorry, what do you mean by this?

This file is missing a copyright header/statement.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
