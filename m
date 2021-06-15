Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA913A7F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhFONUd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Jun 2021 09:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhFONUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:20:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0506EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 06:18:25 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lt8xD-0007qa-D2; Tue, 15 Jun 2021 15:18:07 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lt8xB-0000Sh-75; Tue, 15 Jun 2021 15:18:05 +0200
Message-ID: <2e369015776577c6c32ec2f7d05e35f796edf713.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] ASoC: sunxi: Add Allwinner H6 Digital MIC driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Ban Tao <fengzheng923@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mripard@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, krzk@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Date:   Tue, 15 Jun 2021 15:18:05 +0200
In-Reply-To: <20210615130326.2044-1-fengzheng923@gmail.com>
References: <20210615130326.2044-1-fengzheng923@gmail.com>
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

Hi Ban,

On Tue, 2021-06-15 at 21:03 +0800, Ban Tao wrote:
> The Allwinner H6 and later SoCs have an DMIC block
> which is capable of capture.
> 
> Signed-off-by: Ban Tao <fengzheng923@gmail.com>
[...]
> diff --git a/sound/soc/sunxi/sun50i-dmic.c b/sound/soc/sunxi/sun50i-dmic.c
> new file mode 100644
> index 000000000000..78d512d93974
> --- /dev/null
> +++ b/sound/soc/sunxi/sun50i-dmic.c
> @@ -0,0 +1,408 @@
[...]
> +	host->rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(host->rst) && PTR_ERR(host->rst) == -EPROBE_DEFER) {
> +		ret = -EPROBE_DEFER;
> +		dev_err(&pdev->dev, "Failed to get reset: %d\n", ret);
> +		return ret;
> +	}

Please don't ignore errors. For example:

	if (IS_ERR(host->rst))
		return dev_err_probe(&pdev->dev, PTR_ERR(host->rst),
				     "Failed to  get reset\n");

devm_reset_control_get_optional_exclusive() will return NULL if no reset
is specified in the device tree.

> +	if (!IS_ERR(host->rst))
> +		reset_control_deassert(host->rst);

Then this is not necessary. Just use:

	reset_control_deassert(host->rst);

regards
Philipp
