Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC23CAF78
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 00:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhGOXAe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jul 2021 19:00:34 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:45971 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGOXAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 19:00:33 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 8287F1BF205;
        Thu, 15 Jul 2021 22:57:38 +0000 (UTC)
Date:   Fri, 16 Jul 2021 00:57:37 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        vitor.soares@synopsys.com, boris.brezillon@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] i3c: master: svc: set ODSTOP to let I2C device see
 the STOP signal
Message-ID: <20210716005737.49760d66@xps13>
In-Reply-To: <20210715082413.3042149-5-xiaoning.wang@nxp.com>
References: <20210715082413.3042149-1-xiaoning.wang@nxp.com>
        <20210715082413.3042149-5-xiaoning.wang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,

Clark Wang <xiaoning.wang@nxp.com> wrote on Thu, 15 Jul 2021 16:24:13
+0800:

> If using I2C/I3C mixed mode, need to set ODSTOP. Otherwise, the I2C
> devices cannot see the stop signal. It may cause message sending errors.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> 
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 892e57fec4b0..b05cc7f521e6 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -449,7 +449,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  	struct i3c_device_info info = {};
>  	unsigned long fclk_rate, fclk_period_ns;
>  	unsigned int high_period_ns, od_low_period_ns;
> -	u32 ppbaud, pplow, odhpp, odbaud, i2cbaud, reg;
> +	u32 ppbaud, pplow, odhpp, odbaud, odstop, i2cbaud, reg;
>  	int ret;
>  
>  	/* Timings derivation */
> @@ -479,6 +479,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  	switch (bus->mode) {
>  	case I3C_BUS_MODE_PURE:
>  		i2cbaud = 0;
> +		odstop = 0;
>  		break;
>  	case I3C_BUS_MODE_MIXED_FAST:
>  	case I3C_BUS_MODE_MIXED_LIMITED:
> @@ -487,6 +488,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  		 * between the high and low period does not really matter.
>  		 */
>  		i2cbaud = DIV_ROUND_UP(1000, od_low_period_ns) - 2;
> +		odstop = 1;
>  		break;
>  	case I3C_BUS_MODE_MIXED_SLOW:
>  		/*
> @@ -494,6 +496,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  		 * constraints as the FM+ mode.
>  		 */
>  		i2cbaud = DIV_ROUND_UP(2500, od_low_period_ns) - 2;
> +		odstop = 1;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -502,7 +505,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  	reg = SVC_I3C_MCONFIG_MASTER_EN |
>  	      SVC_I3C_MCONFIG_DISTO(0) |
>  	      SVC_I3C_MCONFIG_HKEEP(0) |
> -	      SVC_I3C_MCONFIG_ODSTOP(0) |
> +	      SVC_I3C_MCONFIG_ODSTOP(odstop) |
>  	      SVC_I3C_MCONFIG_PPBAUD(ppbaud) |
>  	      SVC_I3C_MCONFIG_PPLOW(pplow) |
>  	      SVC_I3C_MCONFIG_ODBAUD(odbaud) |




Thanks,
Miquèl
