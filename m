Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE383CAF77
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 00:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhGOW6u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jul 2021 18:58:50 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:40943 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGOW6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:58:48 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 23C041BF204;
        Thu, 15 Jul 2021 22:55:53 +0000 (UTC)
Date:   Fri, 16 Jul 2021 00:55:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        vitor.soares@synopsys.com, boris.brezillon@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] i3c: master: svc: add support for slave to stop
 returning data
Message-ID: <20210716005552.6078c7eb@xps13>
In-Reply-To: <20210715082413.3042149-4-xiaoning.wang@nxp.com>
References: <20210715082413.3042149-1-xiaoning.wang@nxp.com>
        <20210715082413.3042149-4-xiaoning.wang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,

Clark Wang <xiaoning.wang@nxp.com> wrote on Thu, 15 Jul 2021 16:24:12
+0800:

> When i3c controller reads data from slave device, slave device can stop
> returning data with an ACK after any byte.
> Add this support for svc i3c controller. Otherwise, it will go TIMEOUT
> error path when the slave device ends the read operation early.

Is this part of the I3C specification? I am not aware about it.

> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 9d80435638ea..892e57fec4b0 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -865,7 +865,7 @@ static int svc_i3c_master_read(struct svc_i3c_master *master,
>  			       u8 *in, unsigned int len)
>  {
>  	int offset = 0, i, ret;
> -	u32 mdctrl;
> +	u32 mdctrl, mstatus;
>  
>  	while (offset < len) {
>  		unsigned int count;
> @@ -874,8 +874,15 @@ static int svc_i3c_master_read(struct svc_i3c_master *master,
>  					 mdctrl,
>  					 !(mdctrl & SVC_I3C_MDATACTRL_RXEMPTY),
>  					 0, 1000);
> -		if (ret)
> -			return ret;
> +		if (ret) {
> +			ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS,
> +				 mstatus, SVC_I3C_MSTATUS_COMPLETE(mstatus),
> +				 0, 1000);
> +			if (ret)
> +				return ret;
> +			else
> +				return offset;
> +		}
>  
>  		count = SVC_I3C_MDATACTRL_RXCOUNT(mdctrl);
>  		for (i = 0; i < count; i++)
> @@ -884,7 +891,7 @@ static int svc_i3c_master_read(struct svc_i3c_master *master,
>  		offset += count;
>  	}
>  
> -	return 0;
> +	return offset;
>  }
>  
>  static int svc_i3c_master_write(struct svc_i3c_master *master,
> @@ -917,7 +924,7 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
>  static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  			       bool rnw, unsigned int xfer_type, u8 addr,
>  			       u8 *in, const u8 *out, unsigned int xfer_len,
> -			       unsigned int read_len, bool continued)
> +			       unsigned int *read_len, bool continued)
>  {
>  	u32 reg;
>  	int ret;
> @@ -927,7 +934,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  	       SVC_I3C_MCTRL_IBIRESP_NACK |
>  	       SVC_I3C_MCTRL_DIR(rnw) |
>  	       SVC_I3C_MCTRL_ADDR(addr) |
> -	       SVC_I3C_MCTRL_RDTERM(read_len),
> +	       SVC_I3C_MCTRL_RDTERM(*read_len),
>  	       master->regs + SVC_I3C_MCTRL);
>  
>  	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> @@ -939,8 +946,10 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  		ret = svc_i3c_master_read(master, in, xfer_len);
>  	else
>  		ret = svc_i3c_master_write(master, out, xfer_len);
> -	if (ret)
> +	if (ret < 0)
>  		goto emit_stop;
> +	if (rnw)
> +		*read_len = ret;
>  
>  	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
>  				 SVC_I3C_MSTATUS_COMPLETE(reg), 0, 1000);
> @@ -1012,7 +1021,7 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
>  
>  		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
>  					  cmd->addr, cmd->in, cmd->out,
> -					  cmd->len, cmd->read_len,
> +					  cmd->len, &cmd->read_len,
>  					  cmd->continued);
>  		if (ret)
>  			break;
> @@ -1141,6 +1150,9 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
>  	if (!wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies(1000)))
>  		svc_i3c_master_dequeue_xfer(master, xfer);
>  
> +	if (cmd->read_len != xfer_len)
> +		ccc->dests[0].payload.len = cmd->read_len;
> +
>  	ret = xfer->ret;
>  	svc_i3c_master_free_xfer(xfer);
>  

Thanks,
Miquèl
