Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE5A45B855
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 11:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhKXK2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 05:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241269AbhKXK2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 05:28:44 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45696C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 02:25:35 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u17so1452745plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 02:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tHyc4vww6f6Wxw3/eQBdIL1Je73VlgA7JKdBmqCGaqQ=;
        b=VowkGQmdCxCl/a39pPTkWIbniAxWrdCHUsnAMenLISOVDapuFtot+ZCoAIEwY+DpO+
         NK/tnsSLBHrGigPWuscFnVh6tQZkOSgNYqvpsT2EZJt1Hx+iyTkg1YSBJeYFbRkfl36C
         uj+uL9HLk//ZN790gI6f6zcYkjVdMvHVXFu0s4He+PE6Ogh7ZfFHYQSm9034+1hd6Sr6
         PSH+E3CeS3mz4J6EuPObfwTOUcvU2hlHBO8XsElgtmA9kmOwDcO65PS+yaho+l2S4mD5
         qECsdYfGUEdUV3ZAZtssW5/2fp0oS2ynsO+UWRvZENTt8l7F/AB3S/y7naJqLsmq15ep
         QQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tHyc4vww6f6Wxw3/eQBdIL1Je73VlgA7JKdBmqCGaqQ=;
        b=ZsK/mT2UM2xNpQ5x1lQfF1TxExT0AkO3p5b4gzi36XcWl58zwesynfy9YXCCGEDngQ
         Fx7LGBWr2oSO223GzZuVmV7YlGhPWeANC71nDehBoIVixfoe07AnS5gKSLUNTKh3bWwq
         cqc0gxtHwtiZbyYDP+lTfoIpM+6I1pPxG5ZJ/fCzGwQtjTzeKmhQOMr1UVLO9KszEZu1
         ihNEDsVhxLmPvfl0kh6Gf4GpWp+ak+xXKKJ1CGNbx6ju7GJSVCXL1Bz/qEHPDTl/C3o/
         cvG0eItNrff6/NIfB3hxQJQqPLHHh5acv2zW6RxWLi5AiDBFed7g8o/vigVE9Ns99Teu
         8o0Q==
X-Gm-Message-State: AOAM533s5etrTru6yrq8EStik1NLR5RhWWpWtOvz1gnsH0F5ZAv0Qhrt
        iIvifH/azyt9MjtHhzyAUpTKSg==
X-Google-Smtp-Source: ABdhPJwLWZxBb9qwghOW25FeDDOjCEelQjT4dSKut4RYsVrgGIzla0FvveTn3livbxhFig7UgwmMkg==
X-Received: by 2002:a17:903:2449:b0:142:b3c:f9c6 with SMTP id l9-20020a170903244900b001420b3cf9c6mr16910209pls.77.1637749534624;
        Wed, 24 Nov 2021 02:25:34 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:104b:13b9:d53:e2aa])
        by smtp.gmail.com with ESMTPSA id q9sm11522330pfj.114.2021.11.24.02.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 02:25:34 -0800 (PST)
Date:   Wed, 24 Nov 2021 18:25:30 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        cujomalainey@google.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v3 3/3] firmware: mediatek: add adsp ipc protocol
 interface
Message-ID: <YZ4TGvtwO5ySCEkT@google.com>
References: <20211124084514.28002-1-allen-kh.cheng@mediatek.com>
 <20211124084514.28002-4-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124084514.28002-4-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 04:45:14PM +0800, allen-kh.cheng wrote:
>  drivers/firmware/Kconfig                      |   1 +
>  drivers/firmware/Makefile                     |   1 +
>  drivers/firmware/mediatek/Kconfig             |  10 ++
>  drivers/firmware/mediatek/Makefile            |   2 +
>  drivers/firmware/mediatek/mtk-adsp-ipc.c      | 130 ++++++++++++++++++
>  .../linux/firmware/mediatek/mtk-adsp-ipc.h    |  72 ++++++++++
>  6 files changed, 216 insertions(+)
>  create mode 100644 drivers/firmware/mediatek/Kconfig
>  create mode 100644 drivers/firmware/mediatek/Makefile
>  create mode 100644 drivers/firmware/mediatek/mtk-adsp-ipc.c
>  create mode 100644 include/linux/firmware/mediatek/mtk-adsp-ipc.h

The patch should move before the 2nd patch in the series as the 2nd patch uses mtk-adsp-ipc.h.

> diff --git a/drivers/firmware/mediatek/mtk-adsp-ipc.c b/drivers/firmware/mediatek/mtk-adsp-ipc.c
[...]
> +int adsp_ipc_send(struct mtk_adsp_ipc *ipc, unsigned int idx, uint32_t op)
> +{
> +	struct mtk_adsp_chan *dsp_chan = &ipc->chans[idx];
> +	struct adsp_mbox_ch_info *ch_info = dsp_chan->ch->con_priv;
> +	int ret;
> +
> +	if (idx >= MTK_ADSP_MBOX_NUM)
> +		return -EINVAL;

If idx >= MTK_ADSP_MBOX_NUM, the invalid memory access has occurred at beginning of the function.

> +static int mtk_adsp_ipc_probe(struct platform_device *pdev)
> +{
[...]
> +	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);

Why does it need to call device_set_of_node_from_dev()?

> +	for (i = 0; i < MTK_ADSP_MBOX_NUM; i++) {
> +		chan_name = kasprintf(GFP_KERNEL, "mbox%d", i);
> +		if (!chan_name)
> +			return -ENOMEM;
> +
> +		dsp_chan = &dsp_ipc->chans[i];
> +		cl = &dsp_chan->cl;
> +		cl->dev = dev->parent;
> +		cl->tx_block = false;
> +		cl->knows_txdone = false;
> +		cl->tx_prepare = NULL;
> +		cl->rx_callback = adsp_ipc_recv;
> +
> +		dsp_chan->ipc = dsp_ipc;
> +		dsp_chan->idx = i;
> +		dsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
> +		if (IS_ERR(dsp_chan->ch)) {
> +			ret = PTR_ERR(dsp_chan->ch);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "Failed to request mbox chan %d ret %d\n",
> +					i, ret);

If ret == -EPROBE_DEFER, wouldn't it need to return -EPROBE_DEFER?  It doesn't retry later if -EPROBE_DEFER.
