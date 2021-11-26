Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7924E45E6F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 05:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351904AbhKZEsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 23:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242843AbhKZEqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 23:46:21 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA3DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 20:43:09 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso7201393pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 20:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2LgS2eMeGMdnukM8cUoBve3IMu8b+A022tBUdPAN3OI=;
        b=OMrr+Nwu0J1jMehGE7uVSNYBlFIZq8YEo1TshuWAuOw8rXnVxBWCnOTWjX0tJ8xk/B
         p/Y59W0vsB2Wi3nvclkhheA1yJPtWLGCQz5/4tkKL1gPMOU2yaJCZLPkduIJmevR+iY3
         vswhEHp1va64ULvN+IMrCNIV1d2YA61/uy2GPkHqP2FTr1PXJiPtEZ0UPZJBgLuBmyBf
         y8cGvCCOLzRmUZVK5fD4B7khJLpGmSqs27GzUwOIZBA8TW1UWIdSWXg5lNS+PXZKiJBG
         i8E2GgHrlX/vOX7yqdeWm+uof9bMapyGZc8cAcILcgUrEmOl0V9Ycq6yjJMMtFtCKdRx
         JRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2LgS2eMeGMdnukM8cUoBve3IMu8b+A022tBUdPAN3OI=;
        b=ZaHPqIwbtKPLeCP2jKWCnLqIH/LP7/vPgKcOsolEDSLw8+GmfVlBfy00+HRcMyFiR/
         B7p2DLF8cLX+RNdYcEQNhgfL+F7MAJtU0FFm9O6JoR809M+gUxJ9YFkJjHxZ6A+dqfGe
         rzdu3PMnm7VbZUMWMEahILA6b1zY1AygY2KPhSnQfxITOy7YwV+aXB5cA68sziabuadO
         EQFLdJF2HNPpGbBgLG6yIMmfzXdA+cLlEx8q8GSNo5F4WiKV3eydRv6JERYyM3qYDldy
         RNN0kM4cMx7YCfGByn3aNrjMkL35JZYwnNZEzytAZNxIv1orPEPWZyeeVFzUYonb1/Xm
         gq2A==
X-Gm-Message-State: AOAM532Kf5R5UTrQ9V27BnmNEfna51LbADyD7gnNrqlyW36vWlKPsWSL
        /GIzQWITvRhejhamQtoflFHrag==
X-Google-Smtp-Source: ABdhPJzHNlb6Iu4GBBMDy3fHylI190Sir9kysQUFJV6XRqGjoRO7VKp/xNJdJgj00ozyg+MXwQzm1g==
X-Received: by 2002:a17:902:7890:b0:143:c4f7:59e6 with SMTP id q16-20020a170902789000b00143c4f759e6mr36149485pll.87.1637901788687;
        Thu, 25 Nov 2021 20:43:08 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:5eda:d984:1426:91ca])
        by smtp.gmail.com with ESMTPSA id o23sm4843770pfp.209.2021.11.25.20.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 20:43:08 -0800 (PST)
Date:   Fri, 26 Nov 2021 12:43:04 +0800
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
Subject: Re: [PATCH v4 2/3] firmware: mediatek: add adsp ipc protocol
 interface
Message-ID: <YaBl2PMPHnOMGKY+@google.com>
References: <20211125122925.1303-1-allen-kh.cheng@mediatek.com>
 <20211125122925.1303-3-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125122925.1303-3-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 08:29:24PM +0800, allen-kh.cheng wrote:
> diff --git a/drivers/firmware/mediatek/mtk-adsp-ipc.c b/drivers/firmware/mediatek/mtk-adsp-ipc.c
[...]
> +static void adsp_ipc_recv(struct mbox_client *c, void *msg)
> +{
> +	struct mtk_adsp_chan *chan = container_of(c, struct mtk_adsp_chan, cl);
> +
> +	if (chan->idx == MTK_ADSP_MBOX_REPLY)
> +		chan->ipc->ops->handle_reply(chan->ipc);
> +	else
> +		chan->ipc->ops->handle_request(chan->ipc);

Using switch ... case ... makes the intention more clear.

> +static int mtk_adsp_ipc_probe(struct platform_device *pdev)
> +{
[...]
> +	for (i = 0; i < MTK_ADSP_MBOX_NUM; i++) {
> +		chan_name = kasprintf(GFP_KERNEL, "mbox%d", i);
> +		if (!chan_name)
> +			return -ENOMEM;

It needs to go error handling path.

> +static int mtk_adsp_remove(struct platform_device *pdev)
> +{
> +	struct mtk_adsp_chan *dsp_chan;
> +	struct mtk_adsp_ipc *dsp_ipc;
> +	int i;
> +
> +	dsp_ipc = dev_get_drvdata(&pdev->dev);

To be concise, I would prefer dev_get_drvdata() inline to the line where the variable is declared.
