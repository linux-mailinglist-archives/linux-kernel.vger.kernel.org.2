Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03903ECEEE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhHPHC6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Aug 2021 03:02:58 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:40183 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbhHPHC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:02:57 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id AF17724000A;
        Mon, 16 Aug 2021 07:02:24 +0000 (UTC)
Date:   Mon, 16 Aug 2021 09:02:23 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH V4 8/8] i3c: master: svc: enable the interrupt in the
 enable ibi function
Message-ID: <20210816090223.32475a5c@xps13>
In-Reply-To: <20210809063645.2289988-9-xiaoning.wang@nxp.com>
References: <20210809063645.2289988-1-xiaoning.wang@nxp.com>
        <20210809063645.2289988-9-xiaoning.wang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,

Clark Wang <xiaoning.wang@nxp.com> wrote on Mon,  9 Aug 2021 14:36:45
+0800:

> If enable interrupt in the svc_i3c_master_bus_init() but do not call
> enable ibi in the device driver, it will cause a kernel dump in the
> svc_i3c_master_handle_ibi() when a slave start occurs on the i3c bus,
> because the data->ibi_pool is not initialized.
> So only enable the interrupt in svc_i3c_master_enable_ibi() function.

Is this situation actually happening or is this purely theoretical?

Anyway this doesn't hurt so:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> 
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> ---
> V4: New patch in this patchset
> ---
>  drivers/i3c/master/svc-i3c-master.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 77f67d407acd..b802afd8eb7d 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -569,8 +569,6 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  	if (ret)
>  		goto rpm_out;
>  
> -	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
> -
>  rpm_out:
>  	pm_runtime_mark_last_busy(master->dev);
>  	pm_runtime_put_autosuspend(master->dev);
> @@ -1398,6 +1396,8 @@ static int svc_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
>  		return ret;
>  	}
>  
> +	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
> +
>  	return i3c_master_enec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
>  }
>  
> @@ -1407,6 +1407,8 @@ static int svc_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
>  	struct svc_i3c_master *master = to_svc_i3c_master(m);
>  	int ret;
>  
> +	svc_i3c_master_disable_interrupts(master);
> +
>  	ret = i3c_master_disec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
>  
>  	pm_runtime_mark_last_busy(master->dev);

Thanks,
Miquèl
