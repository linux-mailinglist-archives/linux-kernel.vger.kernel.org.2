Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF14045ECB6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbhKZLhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:37:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48906 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241470AbhKZLfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:35:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3466B1F40F8F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637926312; bh=Z08lk0U3gE9idQY2UHOsHi2Y/LtVNVNvgUIc/pHVcm4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ktoDK0IEUdW9tfd4QC5pPS6iT2MeAAMe6pq0vgclQpa9QgKyiYI0FukT3AvYqzs9U
         BGL3HQZjQkGOYU82HTgGbq81INbNSPHKC04of48oiamvkL13OJlcWs45EpI2g0P2uW
         p+VGMG71eLgOPYULVhK/jW+mpA9dC2ieM0LA8KkGTHeyN/gwTtLYcLSm4RjAT2qbML
         fOiBT8uRltEZVF24fI3/lLfr3+nTmf8yZf49TDuV5LCuaxYrqCXA8N4aBkvbZZxm26
         HrPXTJUT658aHqZfi6IAVscleCWbhUgfZHKNUtV40rAhjRJ0HvUJ90hNAf255EAILn
         67/9oWpQQEUfQ==
Subject: Re: [PATCH v6 3/3] mailbox: mediatek: add support for adsp mailbox
 controller
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>, tzungbi@google.com,
        cujomalainey@google.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org
References: <20211126093021.25462-1-allen-kh.cheng@mediatek.com>
 <20211126093021.25462-4-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <87f7bcf7-303f-b88f-ff32-4d79fd2eaf3b@collabora.com>
Date:   Fri, 26 Nov 2021 12:31:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211126093021.25462-4-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/11/21 10:30, allen-kh.cheng ha scritto:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> This patch is to for MediaTek ADSP IPC mailbox controller driver
> It is used to send short messages between processors with adsp
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> ---
>   drivers/mailbox/Kconfig            |   7 ++
>   drivers/mailbox/Makefile           |   2 +
>   drivers/mailbox/mtk-adsp-mailbox.c | 178 +++++++++++++++++++++++++++++
>   3 files changed, 187 insertions(+)
>   create mode 100644 drivers/mailbox/mtk-adsp-mailbox.c
> 

Hello! Thanks for the patch!
However, there's something to improve...

> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index c9fc06c7e685..c44a0102585d 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -226,6 +226,13 @@ config STM32_IPCC
>   	  with hardware for Inter-Processor Communication Controller (IPCC)
>   	  between processors. Say Y here if you want to have this support.
>   
> +config MTK_ADSP_IPC_MBOX
> +	tristate "MediaTek ADSP Mailbox Controller"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	help
> +	  Say yes here to add support for MediaTek ADSP IPC mailbox controller
> +	  driver. It is used to send short messages between processors with dsp.
> +
>   config MTK_CMDQ_MBOX
>   	tristate "MediaTek CMDQ Mailbox Support"
>   	depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index c2089f04887e..13d5c81852ca 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -49,6 +49,8 @@ obj-$(CONFIG_TEGRA_HSP_MBOX)	+= tegra-hsp.o
>   
>   obj-$(CONFIG_STM32_IPCC) 	+= stm32-ipcc.o
>   
> +obj-$(CONFIG_MTK_ADSP_IPC_MBOX)	+= mtk-adsp-mailbox.o
> +
>   obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
>   
>   obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o
> diff --git a/drivers/mailbox/mtk-adsp-mailbox.c b/drivers/mailbox/mtk-adsp-mailbox.c
> new file mode 100644
> index 000000000000..8928bb3874c4
> --- /dev/null
> +++ b/drivers/mailbox/mtk-adsp-mailbox.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 MediaTek Corporation. All rights reserved.
> + * Author: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> + */
> +
> +#include <linux/firmware/mediatek/mtk-adsp-ipc.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/slab.h>
> +
> +/* adsp mbox register offset */
> +#define MTK_ADSP_MBOX_IN_CMD 0x00
> +#define MTK_ADSP_MBOX_IN_CMD_CLR 0x04
> +#define MTK_ADSP_MBOX_OUT_CMD 0x1c
> +#define MTK_ADSP_MBOX_OUT_CMD_CLR 0x20
> +#define MTK_ADSP_MBOX_IN_MSG0 0x08
> +#define MTK_ADSP_MBOX_IN_MSG1 0x0C
> +#define MTK_ADSP_MBOX_OUT_MSG0 0x24
> +#define MTK_ADSP_MBOX_OUT_MSG1 0x28
> +
> +struct mtk_adsp_mbox_priv {
> +	struct device *dev;
> +	struct mbox_controller mbox;
> +	void __iomem *va_mboxreg;
> +};
> +
> +static irqreturn_t mtk_adsp_ipc_irq_handler(int irq, void *data)
> +{
> +	struct mbox_chan *ch = data;
> +	struct adsp_mbox_ch_info *ch_info = ch->con_priv;
> +	void __iomem *reg = ch_info->va_reg;
> +	u32 op = readl(reg + MTK_ADSP_MBOX_OUT_CMD);
> +
> +	writel(op, reg + MTK_ADSP_MBOX_OUT_CMD_CLR);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t mtk_adsp_ipc_handler(int irq, void *data)
> +{
> +	struct mbox_chan *ch = data;
> +	struct adsp_mbox_ch_info *ch_info = ch->con_priv;
> +
> +	mbox_chan_received_data(ch, ch_info);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct mbox_chan *mtk_adsp_mbox_xlate(struct mbox_controller *mbox,
> +					     const struct of_phandle_args *sp)
> +{
> +	return &mbox->chans[sp->args[0]];
> +}
> +
> +static int mtk_adsp_mbox_startup(struct mbox_chan *chan)
> +{
> +	struct adsp_mbox_ch_info *ch_info = chan->con_priv;
> +	void __iomem *reg = ch_info->va_reg;
> +
> +	/* Clear DSP mbox command */
> +	writel(0xFFFFFFFF, reg + MTK_ADSP_MBOX_IN_CMD_CLR);
> +	writel(0xFFFFFFFF, reg + MTK_ADSP_MBOX_OUT_CMD_CLR);
> +
> +	return 0;
> +}
> +
> +static void mtk_adsp_mbox_shutdown(struct mbox_chan *chan)
> +{
> +	struct adsp_mbox_ch_info *ch_info = chan->con_priv;
> +	void __iomem *reg = ch_info->va_reg;
> +
> +	/* Clear DSP mbox command */
> +	writel(0xFFFFFFFF, reg + MTK_ADSP_MBOX_IN_CMD_CLR);
> +	writel(0xFFFFFFFF, reg + MTK_ADSP_MBOX_OUT_CMD_CLR);
> +	chan->con_priv = NULL;
> +}
> +
> +static int mtk_adsp_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct adsp_mbox_ch_info *ch_info = chan->con_priv;
> +	void __iomem *reg = ch_info->va_reg;
> +
> +	writel(ch_info->ipc_op_val, reg + MTK_ADSP_MBOX_IN_CMD);
> +
> +	return 0;
> +}
> +
> +static bool mtk_adsp_mbox_last_tx_done(struct mbox_chan *chan)
> +{
> +	struct adsp_mbox_ch_info *ch_info = chan->con_priv;
> +	void __iomem *reg = ch_info->va_reg;
> +
> +	return readl(reg + MTK_ADSP_MBOX_IN_CMD) == 0;
> +}
> +
> +static const struct mbox_chan_ops adsp_mbox_chan_ops = {
> +	.send_data	= mtk_adsp_mbox_send_data,
> +	.startup	= mtk_adsp_mbox_startup,
> +	.shutdown	= mtk_adsp_mbox_shutdown,
> +	.last_tx_done	= mtk_adsp_mbox_last_tx_done,
> +};
> +
> +static int mtk_adsp_mbox_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mbox_controller *mbox;
> +	struct mtk_adsp_mbox_priv *priv;
> +	struct resource *res;

drivers/mailbox/mtk-adsp-mailbox.c: In function ‘mtk_adsp_mbox_probe’:

drivers/mailbox/mtk-adsp-mailbox.c:114:19: warning: unused variable ‘res’ 
[-Wunused-variable]

   114 |  struct resource *res;


Please remove this unused variable

> +	struct adsp_mbox_ch_info *ch_info;
> +	int ret;
> +	int irq;

What about `int irq, ret;` ?

> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	mbox = &priv->mbox;
> +	mbox->dev = dev;
> +	mbox->ops = &adsp_mbox_chan_ops;
> +	mbox->txdone_irq = false;
> +	mbox->txdone_poll = true;
> +	mbox->of_xlate = mtk_adsp_mbox_xlate;
> +	mbox->num_chans = 1;
> +	mbox->chans = devm_kzalloc(mbox->dev, sizeof(*mbox->chans), GFP_KERNEL);
> +	if (!mbox->chans)
> +		return -ENOMEM;
> +
> +	priv->va_mboxreg = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->va_mboxreg))
> +		return PTR_ERR(priv->va_mboxreg);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_threaded_irq(dev, irq,
> +					mtk_adsp_ipc_irq_handler, mtk_adsp_ipc_handler,
> +					IRQF_TRIGGER_NONE, dev_name(dev),
> +					mbox->chans);

Please don't break this line, 88 columns is still ok.


After addressing these issues,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Regards,
- Angelo

> +	if (ret < 0)
> +		return ret;
> +
> +	/* set adsp mbox channel info */
> +	ch_info = devm_kzalloc(dev, sizeof(*ch_info), GFP_KERNEL);
> +	if (!ch_info)
> +		return -ENOMEM;
> +
> +	ch_info->va_reg = priv->va_mboxreg;
> +	mbox->chans->con_priv = ch_info;
> +	platform_set_drvdata(pdev, priv);
> +
> +	return devm_mbox_controller_register(dev, &priv->mbox);
> +}
> +
> +static const struct of_device_id mtk_adsp_mbox_of_match[] = {
> +	{ .compatible = "mediatek,mt8195-adsp-mbox", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_adsp_mbox_of_match);
> +
> +static struct platform_driver mtk_adsp_ipc_mbox_driver = {
> +	.probe		= mtk_adsp_mbox_probe,
> +	.driver = {
> +		.name	= "mtk_adsp_mbox",
> +		.of_match_table = mtk_adsp_mbox_of_match,
> +	},
> +};
> +module_platform_driver(mtk_adsp_ipc_mbox_driver);
> +
> +MODULE_AUTHOR("Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>");
> +MODULE_DESCRIPTION("MTK ADSP mailbox IPC driver");
> +MODULE_LICENSE("GPL v2");
> 
