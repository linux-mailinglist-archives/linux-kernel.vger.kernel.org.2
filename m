Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746193BE2D8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 07:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhGGGAN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jul 2021 02:00:13 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:34309 "EHLO
        einhorn-mail-out.in-berlin.de" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230192AbhGGGAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 02:00:13 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id 1675v4nD012588
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 7 Jul 2021 07:57:04 +0200
Date:   Wed, 7 Jul 2021 07:57:03 +0200
From:   Stefan Richter <stefanr@s5r6.in-berlin.de>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 4/4] bus: Make remove callback return void
Message-ID: <20210707075703.32908b84@kant>
In-Reply-To: <20210706154803.1631813-5-u.kleine-koenig@pengutronix.de>
References: <20210706154803.1631813-1-u.kleine-koenig@pengutronix.de>
        <20210706154803.1631813-5-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 06 Uwe Kleine-König wrote:
> The driver core ignores the return value of this callback because there
> is only little it can do when a device disappears.
> 
> This is the final bit of a long lasting cleanup quest where several
> buses were converted to also return void from their remove callback.
> Additionally some resource leaks were fixed that were caused by drivers
> returning an error code in the expectation that the driver won't go
> away.
> 
> With struct bus_type::remove returning void it's prevented that newly
> implemented buses return an ignored error code and so don't anticipate
> wrong expectations for driver authors.

Acked-by: Stefan Richter <stefanr@s5r6.in-berlin.de> (for drivers/firewire)

[...]
>  drivers/firewire/core-device.c            | 4 +---
[...]
> diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
> index 68216988391f..90ed8fdaba75 100644
> --- a/drivers/firewire/core-device.c
> +++ b/drivers/firewire/core-device.c
> @@ -187,14 +187,12 @@ static int fw_unit_probe(struct device *dev)
>  	return driver->probe(fw_unit(dev), unit_match(dev, dev->driver));
>  }
>  
> -static int fw_unit_remove(struct device *dev)
> +static void fw_unit_remove(struct device *dev)
>  {
>  	struct fw_driver *driver =
>  			container_of(dev->driver, struct fw_driver, driver);
>  
>  	driver->remove(fw_unit(dev));
> -
> -	return 0;
>  }
>  
>  static int get_modalias(struct fw_unit *unit, char *buffer, size_t buffer_size)
[...]
-- 
Stefan Richter
-======--=-= -=== --===
http://arcgraph.de/sr/
