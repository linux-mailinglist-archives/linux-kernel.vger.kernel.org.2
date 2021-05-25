Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52CE38F6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 02:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhEYAIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 20:08:54 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:33538 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229540AbhEYAIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 20:08:52 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 5A1E9100E7B44;
        Tue, 25 May 2021 00:07:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 62630D1514;
        Tue, 25 May 2021 00:07:18 +0000 (UTC)
Message-ID: <9f21272719a3983bda647147e8460615159875b1.camel@perches.com>
Subject: Re: [PATCH] ASoC: meson: use dev_err_probe
From:   Joe Perches <joe@perches.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Date:   Mon, 24 May 2021 17:07:17 -0700
In-Reply-To: <20210524165136.400702-1-jbrunet@baylibre.com>
References: <20210524165136.400702-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.90
X-Stat-Signature: k7h5guxk81qrouyfdntbrc3x63gk54mj
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 62630D1514
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19pOUzXC5Hogvmi/j0xkmzd9aHSBMxFLPU=
X-HE-Tag: 1621901238-781495
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-05-24 at 18:51 +0200, Jerome Brunet wrote:
> Use dev_err_probe() helper function to handle probe deferral.
> It removes the open coded test for -EPROBE_DEFER but more importantly, it
> sets the deferral reason in debugfs which is great for debugging.

trivia:

It seems that the use of %ld, PTR_ERR(<foo>) isn't particularly
useful now as dev_err_probe already uses %pe to emit descriptive
error messages.


> diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
[]
> @@ -352,17 +352,16 @@ int axg_fifo_probe(struct platform_device *pdev)
>  
> 
>  	fifo->pclk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(fifo->pclk)) {
> -		if (PTR_ERR(fifo->pclk) != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get pclk: %ld\n",
> -				PTR_ERR(fifo->pclk));
> +		dev_err_probe(dev, PTR_ERR(fifo->pclk),
> +			      "failed to get pclk: %ld\n", PTR_ERR(fifo->pclk));

here.

>  		return PTR_ERR(fifo->pclk);
>  	}
>  
> 
>  	fifo->arb = devm_reset_control_get_exclusive(dev, NULL);
>  	if (IS_ERR(fifo->arb)) {
> -		if (PTR_ERR(fifo->arb) != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get arb reset: %ld\n",
> -				PTR_ERR(fifo->arb));
> +		dev_err_probe(dev, PTR_ERR(fifo->arb),
> +			      "failed to get arb reset: %ld\n",
> +			      PTR_ERR(fifo->arb));

etc...


