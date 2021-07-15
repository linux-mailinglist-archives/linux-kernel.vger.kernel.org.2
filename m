Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD37D3CAF74
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 00:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhGOWzC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jul 2021 18:55:02 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33071 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhGOWzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:55:01 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 7C2E51C0002;
        Thu, 15 Jul 2021 22:52:06 +0000 (UTC)
Date:   Fri, 16 Jul 2021 00:52:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        vitor.soares@synopsys.com, boris.brezillon@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] i3c: master: svc: fix atomic issue
Message-ID: <20210716005205.5e218d47@xps13>
In-Reply-To: <20210715082413.3042149-3-xiaoning.wang@nxp.com>
References: <20210715082413.3042149-1-xiaoning.wang@nxp.com>
        <20210715082413.3042149-3-xiaoning.wang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,

Clark Wang <xiaoning.wang@nxp.com> wrote on Thu, 15 Jul 2021 16:24:11
+0800:

> do_daa_locked() function is in a spin lock environment, use
> readl_poll_timeout_atomic() to replace the origin
> readl_poll_timeout().
> 
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index c25a372f6820..9d80435638ea 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -656,7 +656,7 @@ static int svc_i3c_master_readb(struct svc_i3c_master *master, u8 *dst,
>  	u32 reg;
>  
>  	for (i = 0; i < len; i++) {
> -		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> +		ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
>  					 SVC_I3C_MSTATUS_RXPEND(reg), 0, 1000);

You forgot to align the parameters of the function here and below.

Otherwise,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

>  		if (ret)
>  			return ret;
> @@ -687,7 +687,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
>  		 * Either one slave will send its ID, or the assignment process
>  		 * is done.
>  		 */
> -		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> +		ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
>  					 SVC_I3C_MSTATUS_RXPEND(reg) |
>  					 SVC_I3C_MSTATUS_MCTRLDONE(reg),
>  					 1, 1000);
> @@ -744,7 +744,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
>  		}
>  
>  		/* Wait for the slave to be ready to receive its address */
> -		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> +		ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
>  					 SVC_I3C_MSTATUS_MCTRLDONE(reg) &&
>  					 SVC_I3C_MSTATUS_STATE_DAA(reg) &&
>  					 SVC_I3C_MSTATUS_BETWEEN(reg),




Thanks,
Miquèl
