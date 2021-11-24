Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0283F45B853
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 11:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhKXK2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 05:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhKXK22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 05:28:28 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EBCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 02:25:19 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id g28so1727982pgg.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 02:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RWDbxw0O+Eb2MTODPtyb5giEnnTJJaqwqAJtlwbLKPM=;
        b=TUOz5MfgG5JMzyZ6iwNq72F59avCAePjCoi5R5mYzgjxOabfcPIkv/bF2Tc1L1gGE/
         dXLcUIr5YGb2GMc38BMHvZFi8xLHBdoicirIxGj8Q8Fi3qy8Ty+rivQNOn6eNWpXjUeg
         Ka4IJxZZZyXSDcU342PW0GfzGYlVWPhL4ViLLwvmfTs4rPnjeKv+IqD9ac0NpcZGOnzp
         ldUTjhKiI7o+vzFrUwyanPTB1KN+3PggPEJWt895E6pucNJ5Hn5rNAvruC2i82QWgyO+
         v8fC1QGAyrRZX90+bJFZvUM3DgXMVM4cK9QmtNEc3ZY8zwK9ykP+OvQY7Uy7H2tu06jh
         Jefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RWDbxw0O+Eb2MTODPtyb5giEnnTJJaqwqAJtlwbLKPM=;
        b=d5LvvKmLFEUyp+mMe1Qa84Z5xqFb8u4mFYbD+heO3/gqU3sJH5wdt5P+MEh79aHoLD
         w6k6ZSKrBKxB0BGkZgwNKUNJZaMM0PTS49jwMQUJ3Be2C3zBH0l5zpyU+hwpHFixebDu
         niPW5HQF1Ng6Akai4ZTHesrnES1MOFg3+xfsUw2RTv5Qf9waxzbFCTDq/SAfDuQd92nG
         s86VvptaIwo3zXyL5dy4d3I4BXj4aJd5+7N482nhYrcUy01zTZAYkP8Xaso6iYLkRCr1
         LSI/XiQDX4H/z61bNrniueMx/HjEJsvDeU/lZGXiBad9KRfY0KTccv8mcQeTfTb8z7St
         Moug==
X-Gm-Message-State: AOAM533MdRbvQWpuIrDJydebJzLN3WeVV4rkWvLsW+g9wcF/uMARCU6S
        QfiMh8bgdfYP4hR3KbIRwdnGVg==
X-Google-Smtp-Source: ABdhPJy4yGk5G/wT8MjPGEmXFxJwr4sD+MfMiZ+bTpsvRjJhdnwJCzHW6W0Mc4xMDUEALiJGPp8oIg==
X-Received: by 2002:a63:90c1:: with SMTP id a184mr7144545pge.222.1637749518381;
        Wed, 24 Nov 2021 02:25:18 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:104b:13b9:d53:e2aa])
        by smtp.gmail.com with ESMTPSA id f4sm15333725pfg.34.2021.11.24.02.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 02:25:18 -0800 (PST)
Date:   Wed, 24 Nov 2021 18:25:13 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>, cujomalainey@google.com,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Mark Brown <broonie@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v3 2/3] mailbox: mediatek: add support for adsp mailbox
 controller
Message-ID: <YZ4TCYmvegnC/kR0@google.com>
References: <20211124084514.28002-1-allen-kh.cheng@mediatek.com>
 <20211124084514.28002-3-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124084514.28002-3-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 04:45:13PM +0800, allen-kh.cheng wrote:
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index c9fc06c7e685..fc99d9fc80af 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -236,6 +236,13 @@ config MTK_CMDQ_MBOX
>  	  critical time limitation, such as updating display configuration
>  	  during the vblank.
>  
> +config MTK_ADSP_IPC_MBOX
> +	tristate "MediaTek ADSP Mailbox Controller"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	help
> +	  Say yes here to add support for MediaTek ADSP IPC mailbox controller
> +	  driver. It is used to send short messages between processors with dsp.

Although the file didn't maintain alphabetical order, to be neat, moving MTK_ADSP_IPC_MBOX before MTK_CMDQ_MBOX makes more sense.

> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index c2089f04887e..479a9ae56d5e 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -51,6 +51,8 @@ obj-$(CONFIG_STM32_IPCC) 	+= stm32-ipcc.o
>  
>  obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
>  
> +obj-$(CONFIG_MTK_ADSP_IPC_MBOX)	+= mtk-adsp-mailbox.o
> +

Ditto.  Move CONFIG_MTK_ADSP_IPC_MBOX before CONFIG_MTK_CMDQ_MBOX without blank line separation.

> diff --git a/drivers/mailbox/mtk-adsp-mailbox.c b/drivers/mailbox/mtk-adsp-mailbox.c
[...]
> +static irqreturn_t mtk_adsp_ipc_irq_handler(int irq, void *data)
> +{
> +	struct mbox_chan *ch = (struct mbox_chan *)data;

The cast should be able to remove.

> +static irqreturn_t mtk_adsp_ipc_handler(int irq, void *data)
> +{
> +	struct mbox_chan *ch = (struct mbox_chan *)data;

The cast should be able to remove.

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
> +	chan->con_priv = NULL;
> +}

Shall mtk_adsp_mbox_shutdown() also clear DSP mbox?  I.e.:
writel(0xFFFFFFFF, reg + MTK_ADSP_MBOX_IN_CMD_CLR);
writel(0xFFFFFFFF, reg + MTK_ADSP_MBOX_OUT_CMD_CLR);

> +static int mtk_adsp_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct adsp_mbox_ch_info *ch_info = chan->con_priv;
> +	void __iomem *reg = ch_info->va_reg;
> +
> +	spin_lock(&ch_info->lock);
> +	writel(ch_info->ipc_op_val, reg + MTK_ADSP_MBOX_IN_CMD);
> +	spin_unlock(&ch_info->lock);

Why does it need the lock?

Is the write to MTK_ADSP_MBOX_IN_CMD a synchronous operation?
- If yes, I failed to understand why does it need the lock.  Every calls to mtk_adsp_mbox_send_data() should wait for the data transfer completion.
- If no, I also failed to understand why.  mtk_adsp_mbox_send_data() has no way to be aware of the transfer completion.  Would expect a loop for checking the completion for the case.

> +static bool mtk_adsp_mbox_last_tx_done(struct mbox_chan *chan)
> +{
> +	struct adsp_mbox_ch_info *ch_info = chan->con_priv;
> +	void __iomem *reg = ch_info->va_reg;
> +	u32 op = readl(reg + MTK_ADSP_MBOX_IN_CMD);
> +
> +	return (op == 0) ? true : false;

To be concise, return readl(...) == 0;

> +static int mtk_adsp_mbox_probe(struct platform_device *pdev)
> +{
[...]
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "no adsp mbox register resource\n");
> +		return -ENXIO;
> +	}
> +
> +	size = resource_size(res);
> +	priv->va_mboxreg = devm_ioremap(dev, (phys_addr_t)res->start, size);
> +	if (IS_ERR(priv->va_mboxreg))
> +		return PTR_ERR(priv->va_mboxreg);

Use devm_platform_ioremap_resource(), it should be equivalent.

> +	/* set adsp mbox channel info */
> +	ch_info = devm_kzalloc(mbox->dev, sizeof(*ch_info), GFP_KERNEL);

To be neat, use dev instead of mbox->dev.

> +	ret = devm_mbox_controller_register(dev, &priv->mbox);
> +	if (ret < 0)
> +		dev_err(dev, "error: failed to register mailbox:%d\n", ret);
> +
> +	return ret;

To be concise, return devm_mbox_controller_register(...);
