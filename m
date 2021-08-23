Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2634A3F4A46
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbhHWMEW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Aug 2021 08:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbhHWMEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:04:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69071C061760
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:03:33 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mI8fm-0002zi-Gm; Mon, 23 Aug 2021 14:03:26 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mI8fl-0007z7-8e; Mon, 23 Aug 2021 14:03:25 +0200
Message-ID: <6bc6330215980f10853a2dac69f0bdfd9c8fb303.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/4] ASoC: rockchip: add support for i2s-tdm
 controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Date:   Mon, 23 Aug 2021 14:03:25 +0200
In-Reply-To: <20210820182731.29370-2-frattaroli.nicolas@gmail.com>
References: <20210820182731.29370-1-frattaroli.nicolas@gmail.com>
         <20210820182731.29370-2-frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Fri, 2021-08-20 at 20:27 +0200, Nicolas Frattaroli wrote:
[...]
> diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
> new file mode 100644
> index 000000000000..c02b66f3c913
> --- /dev/null
> +++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
> @@ -0,0 +1,1737 @@
[...]
> +static void rockchip_snd_xfer_reset_assert(struct rk_i2s_tdm_dev *i2s_tdm,
> +					   int tx_bank, int tx_offset,
> +					   int rx_bank, int rx_offset)
> +{
> +	void __iomem *cru_reset;
> +	unsigned long flags;
> +
> +	cru_reset = i2s_tdm->cru_base + i2s_tdm->soc_data->softrst_offset;
> +
> +	if (tx_bank == rx_bank) {
> +		writel(BIT(tx_offset) | BIT(rx_offset) |
> +		       (BIT(tx_offset) << 16) | (BIT(rx_offset) << 16),
> +		       cru_reset + (tx_bank * 4));
> +	} else {
> +		local_irq_save(flags);
> +		writel(BIT(tx_offset) | (BIT(tx_offset) << 16),
> +		       cru_reset + (tx_bank * 4));
> +		writel(BIT(rx_offset) | (BIT(rx_offset) << 16),
> +		       cru_reset + (rx_bank * 4));
> +		local_irq_restore(flags);
> +	}
> +}
> +
> +static void rockchip_snd_xfer_reset_deassert(struct rk_i2s_tdm_dev *i2s_tdm,
> +					     int tx_bank, int tx_offset,
> +					     int rx_bank, int rx_offset)
> +{
> +	void __iomem *cru_reset;
> +	unsigned long flags;
> +
> +	cru_reset = i2s_tdm->cru_base + i2s_tdm->soc_data->softrst_offset;
> +
> +	if (tx_bank == rx_bank) {
> +		writel((BIT(tx_offset) << 16) | (BIT(rx_offset) << 16),
> +		       cru_reset + (tx_bank * 4));
> +	} else {
> +		local_irq_save(flags);
> +		writel((BIT(tx_offset) << 16),
> +		       cru_reset + (tx_bank * 4));
> +		writel((BIT(rx_offset) << 16),
> +		       cru_reset + (rx_bank * 4));
> +		local_irq_restore(flags);
> +	}
> +}
> +
> +/*
> + * Makes sure that both tx and rx are reset at the same time to sync lrck
> + * when clk_trcm > 0.
> + */
> +static void rockchip_snd_xfer_sync_reset(struct rk_i2s_tdm_dev *i2s_tdm)
> +{
> +	int tx_id, rx_id;
> +	int tx_bank, rx_bank, tx_offset, rx_offset;
> +
> +	if (!i2s_tdm->cru_base || !i2s_tdm->soc_data)
> +		return;
> +
> +	tx_id = i2s_tdm->tx_reset_id;
> +	rx_id = i2s_tdm->rx_reset_id;
> +	if (tx_id < 0 || rx_id < 0)
> +		return;
> +
> +	tx_bank = tx_id / 16;
> +	tx_offset = tx_id % 16;
> +	rx_bank = rx_id / 16;
> +	rx_offset = rx_id % 16;
> +	dev_dbg(i2s_tdm->dev,
> +		"tx_bank: %d, rx_bank: %d, tx_offset: %d, rx_offset: %d\n",
> +		tx_bank, rx_bank, tx_offset, rx_offset);
> +
> +	rockchip_snd_xfer_reset_assert(i2s_tdm, tx_bank, tx_offset,
> +				       rx_bank, rx_offset);
> +
> +	udelay(150);
> +
> +	rockchip_snd_xfer_reset_deassert(i2s_tdm, tx_bank, tx_offset,
> +					 rx_bank, rx_offset);
> +}

I'm not too fond of reimplementing half a reset controller in here.
The reset framework does not support synchronized (de)assertion of
multiple reset controls, I wonder if this would be useful to add.
Without having thought about this too hard, I could imagine this as an
extension to the bulk API, or possibly a call to join multiple reset
controls into a reset control array.

> +static void rockchip_snd_reset(struct reset_control *rc)
> +{
> +	if (IS_ERR(rc))
> +		return;

This shouldn't be called with an error code, see the comment about
optional reset controls below.

> +
> +	reset_control_assert(rc);
> +	udelay(1);

What is the reason for the different delays in
rockchip_snd_xfer_sync_reset() and rockchip_snd_reset()?

> +	reset_control_deassert(rc);
> +}
[...]
> +static int rockchip_i2s_tdm_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct device_node *cru_node;
> +	const struct of_device_id *of_id;
> +	struct rk_i2s_tdm_dev *i2s_tdm;
> +	struct resource *res;
> +	void __iomem *regs;
> +	int ret;
> +	int val;
> +
> +	i2s_tdm = devm_kzalloc(&pdev->dev, sizeof(*i2s_tdm), GFP_KERNEL);
> +	if (!i2s_tdm)
> +		return -ENOMEM;
> +
> +	i2s_tdm->dev = &pdev->dev;
> +
> +	of_id = of_match_device(rockchip_i2s_tdm_match, &pdev->dev);
> +	if (!of_id || !of_id->data)
> +		return -EINVAL;
> +
> +	spin_lock_init(&i2s_tdm->lock);
> +	i2s_tdm->soc_data = (struct rk_i2s_soc_data *)of_id->data;
> +
> +	i2s_tdm->frame_width = 64;
> +	if (!of_property_read_u32(node, "rockchip,frame-width", &val)) {
> +		if (val >= 32 && (val % 2 == 0) && val <= 512) {
> +			i2s_tdm->frame_width = val;
> +		} else {
> +			dev_err(i2s_tdm->dev, "unsupported frame width: '%d'\n",
> +				val);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	i2s_tdm->clk_trcm = TRCM_TXRX;
> +	if (of_property_read_bool(node, "rockchip,trcm-sync-tx-only"))
> +		i2s_tdm->clk_trcm = TRCM_TX;
> +	if (of_property_read_bool(node, "rockchip,trcm-sync-rx-only")) {
> +		if (i2s_tdm->clk_trcm) {
> +			dev_err(i2s_tdm->dev, "invalid trcm-sync configuration\n");
> +			return -EINVAL;
> +		}
> +		i2s_tdm->clk_trcm = TRCM_RX;
> +	}
> +	if (i2s_tdm->clk_trcm != TRCM_TXRX)
> +		i2s_tdm_dai.symmetric_rate = 1;
> +
> +	i2s_tdm->tdm_fsync_half_frame =
> +		of_property_read_bool(node, "rockchip,tdm-fsync-half-frame");
> +
> +	i2s_tdm->grf = syscon_regmap_lookup_by_phandle(node, "rockchip,grf");
> +	if (IS_ERR(i2s_tdm->grf))
> +		return dev_err_probe(i2s_tdm->dev, PTR_ERR(i2s_tdm->grf),
> +				     "Error in rockchip,grf\n");
> +
> +	if (i2s_tdm->clk_trcm != TRCM_TXRX) {
> +		cru_node = of_parse_phandle(node, "rockchip,cru", 0);
> +		i2s_tdm->cru_base = of_iomap(cru_node, 0);

This is a bit ugly if there is another driver sitting on the
rockchip,cru compatible node. Which reset controller driver is backing
the reset controls below?

> +		of_node_put(cru_node);
> +		if (!i2s_tdm->cru_base) {
> +			dev_err(i2s_tdm->dev,
> +				"Missing or unsupported rockchip,cru node\n");
> +			return -ENOENT;
> +		}
> +
> +		i2s_tdm->tx_reset_id = of_i2s_resetid_get(node, "tx-m");
> +		i2s_tdm->rx_reset_id = of_i2s_resetid_get(node, "rx-m");
> +	}
> +
> +	i2s_tdm->tx_reset = devm_reset_control_get(&pdev->dev, "tx-m");

Please use devm_reset_control_get_exclusive() instead.

> +	if (IS_ERR(i2s_tdm->tx_reset)) {
> +		ret = PTR_ERR(i2s_tdm->tx_reset);
> +		if (ret != -ENOENT)
> +			return dev_err_probe(i2s_tdm->dev, ret,
> +					     "Error in tx-m reset control\n");
> +	}
> +
> +	i2s_tdm->rx_reset = devm_reset_control_get(&pdev->dev, "rx-m");
> +	if (IS_ERR(i2s_tdm->rx_reset)) {
> +		ret = PTR_ERR(i2s_tdm->rx_reset);
> +		if (ret != -ENOENT)

Why is -ENOENT acceptable? If you want these to be optional, use
devm_reset_control_get_optional_exclusive() [1] instead. That will
return NULL if the reset is not specified in the device tree, which will
be ignored by reset_control_(de)assert().

[1] https://www.kernel.org/doc/html/latest/driver-api/reset.html#c.devm_reset_control_get_optional_exclusive

> +			return dev_err_probe(i2s_tdm->dev, ret,
> +					     "Error in rx-m reset control\n");
> +	}
> +
> +	i2s_tdm->hclk = devm_clk_get(&pdev->dev, "hclk");
> +	if (IS_ERR(i2s_tdm->hclk)) {
> +		return dev_err_probe(i2s_tdm->dev, PTR_ERR(i2s_tdm->hclk),
> +				     "Failed to get clock hclk\n");
> +	}
> +
> +	ret = clk_prepare_enable(i2s_tdm->hclk);
> +	if (ret) {
> +		return dev_err_probe(i2s_tdm->dev, ret,
> +				     "Failed to enable clock hclk\n");
> +	}

This clock is left enabled in all the error paths below. You could
install a cleanup action with devm_add_action_or_reset(), or better
start enabling the hardware only after acquisition of all required
resources has succeeded.

[...]
> +static int rockchip_i2s_tdm_remove(struct platform_device *pdev)
> +{
> +	struct rk_i2s_tdm_dev *i2s_tdm = dev_get_drvdata(&pdev->dev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	if (!pm_runtime_status_suspended(&pdev->dev))
> +		i2s_tdm_runtime_suspend(&pdev->dev);
> +
> +	if (!IS_ERR(i2s_tdm->mclk_tx))
> +		clk_prepare_enable(i2s_tdm->mclk_tx);
> +	if (!IS_ERR(i2s_tdm->mclk_rx))
> +		clk_prepare_enable(i2s_tdm->mclk_rx);

Why are we enabling these clocks now?

> +	if (!IS_ERR(i2s_tdm->hclk))
> +		clk_disable_unprepare(i2s_tdm->hclk);
> +
> +	return 0;
> +}

regards
Philipp
