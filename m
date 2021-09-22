Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782274147EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 13:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbhIVLi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 07:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbhIVLiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:38:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5ABC061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 04:37:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mT0Yy-0006Ov-Dq; Wed, 22 Sep 2021 13:37:20 +0200
Subject: Re: [PATCH 3/6] nvmem: core: add nvmem cell post processing callback
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
 <20210908100257.17833-4-qiangqing.zhang@nxp.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <c76b326d-fbef-8c4c-bda8-cef25cac0266@pengutronix.de>
Date:   Wed, 22 Sep 2021 13:37:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908100257.17833-4-qiangqing.zhang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.09.21 12:02, Joakim Zhang wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Some NVMEM providers have certain nvmem cells encoded, which requires
> post processing before actually using it.
> 
> For example mac-address is stored in either in ascii or delimited or reverse-order.
> 
> Having a post-process callback hook to provider drivers would enable them to
> do this vendor specific post processing before nvmem consumers see it.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/nvmem/core.c           | 9 +++++++++
>  include/linux/nvmem-provider.h | 5 +++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 23c08dbaf45e..4f81a3adf081 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -38,6 +38,7 @@ struct nvmem_device {
>  	unsigned int		nkeepout;
>  	nvmem_reg_read_t	reg_read;
>  	nvmem_reg_write_t	reg_write;
> +	nvmem_cell_post_process_t cell_post_process;
>  	struct gpio_desc	*wp_gpio;
>  	void *priv;
>  };
> @@ -797,6 +798,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  	nvmem->type = config->type;
>  	nvmem->reg_read = config->reg_read;
>  	nvmem->reg_write = config->reg_write;
> +	nvmem->cell_post_process = config->cell_post_process;
>  	nvmem->keepout = config->keepout;
>  	nvmem->nkeepout = config->nkeepout;
>  	if (config->of_node)
> @@ -1404,6 +1406,13 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
>  	if (cell->bit_offset || cell->nbits)
>  		nvmem_shift_read_buffer_in_place(cell, buf);
>  
> +	if (nvmem->cell_post_process) {
> +		rc = nvmem->cell_post_process(nvmem->priv, cell->type,
> +					      cell->offset, buf, cell->bytes);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	if (len)
>  		*len = cell->bytes;
>  
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> index 104505e9028f..d980c79f9605 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -19,6 +19,9 @@ typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
>  				void *val, size_t bytes);
>  typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
>  				 void *val, size_t bytes);
> +/* used for vendor specific post processing of cell data */
> +typedef int (*nvmem_cell_post_process_t)(void *priv, int type, unsigned int offset,
> +					  void *buf, size_t bytes);
>  
>  enum nvmem_type {
>  	NVMEM_TYPE_UNKNOWN = 0,
> @@ -62,6 +65,7 @@ struct nvmem_keepout {
>   * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
>   * @reg_read:	Callback to read data.
>   * @reg_write:	Callback to write data.
> + * @cell_read_callback: Callback for vendor specific post processing of cell data

The member below is called cell_post_process

>   * @size:	Device size.
>   * @word_size:	Minimum read/write access granularity.
>   * @stride:	Minimum read/write access stride.
> @@ -92,6 +96,7 @@ struct nvmem_config {
>  	bool			no_of_node;
>  	nvmem_reg_read_t	reg_read;
>  	nvmem_reg_write_t	reg_write;
> +	nvmem_cell_post_process_t cell_post_process;
>  	int	size;
>  	int	word_size;
>  	int	stride;
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
