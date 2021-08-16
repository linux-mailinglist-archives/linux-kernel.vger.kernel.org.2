Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6153ECF2F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbhHPHPz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Aug 2021 03:15:55 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57807 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbhHPHPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:15:54 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 67F116000B;
        Mon, 16 Aug 2021 07:15:21 +0000 (UTC)
Date:   Mon, 16 Aug 2021 09:15:20 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH V4 4/8] i3c: master: svc: add support for slave to stop
 returning data
Message-ID: <20210816091520.349dac41@xps13>
In-Reply-To: <20210809063645.2289988-5-xiaoning.wang@nxp.com>
References: <20210809063645.2289988-1-xiaoning.wang@nxp.com>
        <20210809063645.2289988-5-xiaoning.wang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,

Just a few nitpicks.

Clark Wang <xiaoning.wang@nxp.com> wrote on Mon,  9 Aug 2021 14:36:41
+0800:

> When i3c controller reads data from slave device, slave device can stop
> returning data with an ACK after any byte.
> Add this support for svc i3c controller. Otherwise, it will go TIMEOUT

"it will timeout when the slave..."

> error path when the slave device ends the read operation early.
> 
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Reviewed-by: Jun Li <jun.li@nxp.com>
> ---
> V4 changes:
>  - Only use COMPLETE flag in the read function.
>  - Add a reset before each transfer.
> V2/V3: No change.
> ---
>  drivers/i3c/master/svc-i3c-master.c | 56 ++++++++++++++++++++---------
>  1 file changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 4e69c691253d..e767f307db2d 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -896,27 +896,35 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
>  static int svc_i3c_master_read(struct svc_i3c_master *master,
>  			       u8 *in, unsigned int len)
>  {
> -	int offset = 0, i, ret;
> -	u32 mdctrl;
> +	int offset = 0, i;
> +	u32 mdctrl, mstatus;
> +	bool completed = false;
> +	unsigned int count;
> +	unsigned long start = jiffies;
>  
> -	while (offset < len) {
> -		unsigned int count;
> +	while (!completed) {
> +		mstatus = readl(master->regs + SVC_I3C_MSTATUS);
> +		if (SVC_I3C_MSTATUS_COMPLETE(mstatus) != 0)
> +			completed = true;
>  
> -		ret = readl_poll_timeout(master->regs + SVC_I3C_MDATACTRL,
> -					 mdctrl,
> -					 !(mdctrl & SVC_I3C_MDATACTRL_RXEMPTY),
> -					 0, 1000);
> -		if (ret)
> -			return ret;
> +		if (time_after(jiffies, start + msecs_to_jiffies(1000))) {
> +			dev_dbg(master->dev, "<%s> timeout\n", __func__);

Can you get rid of this <%s>/__func__ parameter and just tell that we
got a read timeout?

> +			return -ETIMEDOUT;
> +		}
>  
> +		mdctrl = readl(master->regs + SVC_I3C_MDATACTRL);
>  		count = SVC_I3C_MDATACTRL_RXCOUNT(mdctrl);
> +		if (offset + count > len) {
> +			dev_err(master->dev, "<%s> recv len too long!\n",
> +				__func__);
> +			return -EINVAL;
> +		}

And is this something theoretical or a real error that can happen?

If you think this is really needed, please keep the same dev_err()
formatting as in the other places in this driver.

>  		for (i = 0; i < count; i++)
>  			in[offset + i] = readl(master->regs + SVC_I3C_MRDATAB);
> -

Please keep that space

>  		offset += count;
>  	}
>  
> -	return 0;
> +	return offset;
>  }
>  
>  static int svc_i3c_master_write(struct svc_i3c_master *master,
> @@ -949,7 +957,7 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
>  static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  			       bool rnw, unsigned int xfer_type, u8 addr,
>  			       u8 *in, const u8 *out, unsigned int xfer_len,
> -			       unsigned int read_len, bool continued)
> +			       unsigned int *read_len, bool continued)
>  {
>  	u32 reg;
>  	int ret;
> @@ -959,7 +967,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  	       SVC_I3C_MCTRL_IBIRESP_NACK |
>  	       SVC_I3C_MCTRL_DIR(rnw) |
>  	       SVC_I3C_MCTRL_ADDR(addr) |
> -	       SVC_I3C_MCTRL_RDTERM(read_len),
> +	       SVC_I3C_MCTRL_RDTERM(*read_len),
>  	       master->regs + SVC_I3C_MCTRL);
>  
>  	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> @@ -971,17 +979,25 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  		ret = svc_i3c_master_read(master, in, xfer_len);
>  	else
>  		ret = svc_i3c_master_write(master, out, xfer_len);
> -	if (ret)
> +	if (ret < 0)
>  		goto emit_stop;

Space?

> +	if (rnw)
> +		*read_len = ret;
>  
>  	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
>  				 SVC_I3C_MSTATUS_COMPLETE(reg), 0, 1000);
>  	if (ret)
>  		goto emit_stop;

Space?

> +	writel(SVC_I3C_MINT_COMPLETE, master->regs + SVC_I3C_MSTATUS);
>  
> -	if (!continued)
> +	if (!continued) {
>  		svc_i3c_master_emit_stop(master);
>  
> +		/* Wait idle if stop is sent. */
> +		readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> +				   !SVC_I3C_MSTATUS_STATE(reg), 0, 1000);

Please use _MSTATUS_STATE_IDLE() for more clarity.

If this wait loop is really needed, better adding it to
_master_emit_stop()? (in another patch)

> +	}
> +
>  	return 0;
>  
>  emit_stop:
> @@ -1039,12 +1055,15 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
>  	if (!xfer)
>  		return;
>  
> +	svc_i3c_master_clear_merrwarn(master);
> +	svc_i3c_master_flush_fifo(master);
> +
>  	for (i = 0; i < xfer->ncmds; i++) {
>  		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
>  
>  		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
>  					  cmd->addr, cmd->in, cmd->out,
> -					  cmd->len, cmd->read_len,
> +					  cmd->len, &cmd->read_len,
>  					  cmd->continued);
>  		if (ret)
>  			break;
> @@ -1173,6 +1192,9 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
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
