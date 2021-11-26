Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC0A45E6F7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 05:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358493AbhKZEtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 23:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358601AbhKZEq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 23:46:59 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5D0C0613E1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 20:43:28 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 200so7090610pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 20:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gwJIiwnisD6cF408GW4bOCdNiOevm+kN2DCfktfQz/4=;
        b=p/HPnND/JDqjAz5osN2fiqxWxjwlxeukWlCnWFYdia3ksPcLdj2T2/w7EYHHk2wHzh
         8NoOKsyeh7nIRO3jA2Qp5+Zzr44CZP9J0vSuGvhzzd5Ul9T7StHo8IKBzGd2fG7GtWDY
         nTuYDnPwWGPJ6wmjXG3VlLZeKT3MdPKSc62rgr6+X422bqTD4m2MyX/LeNEwCfWWPAmJ
         WL1g3/QQ9L7Sk4aUC+UtrkapDFWHLz0QFTssZtHaZhFkEONtoJXKH8XKz0xoFpLLMfX9
         T9eYriy9fff/4MdXaIi3AukGZ6kvEwLf0KIs6V+L97ucwyXzlqO5xkmijlGi/tylQq5u
         qsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gwJIiwnisD6cF408GW4bOCdNiOevm+kN2DCfktfQz/4=;
        b=FKJ3yX/gZOIx5midKkQZh6oqIlGcJX3/DmEB0T43n1wyIeFptgf8J3DWcT8ruXPPgl
         hbSspDvg0M1I3hRxxMHAHBxzCzJDaAUpXm1pZJgWptr7TNXEqEKwWceDDfFUDDayYf8j
         uxucnPqSJoAr+j6d1SFeoXGR4XYbjqcNza23n2BFsWRqQ9K8JqWINLJsAvmgs2koFF4B
         02SgCRdEPeRFiKiOFW2spK/pMr9VAMC+554ExASAwjGEKpVNCoe41m5ij08PEnL/3BqQ
         PFo41loD1Ah9Nir1VX9rppSugq9IfGCbs+cxv0D91Pzdv09AXGfauQRchcO5huTsBsg+
         f7Ow==
X-Gm-Message-State: AOAM532peMZlFl3Px8scMEqa9Ve4bbVuaWmdbTuY1D+o8xumPKtSkyOr
        3xBNyPbLGOEKdeE81HvTNsBiTw==
X-Google-Smtp-Source: ABdhPJx0FjXR51YfULBYoNlN6azVm4pmsK/QdHHWCakrLIU0+ikdrQc99GBXkyRgdyNDpZyG+Rly5Q==
X-Received: by 2002:a63:150c:: with SMTP id v12mr19528275pgl.442.1637901808160;
        Thu, 25 Nov 2021 20:43:28 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:5eda:d984:1426:91ca])
        by smtp.gmail.com with ESMTPSA id g9sm5600382pfj.160.2021.11.25.20.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 20:43:27 -0800 (PST)
Date:   Fri, 26 Nov 2021 12:43:23 +0800
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
Subject: Re: [PATCH v4 3/3] mailbox: mediatek: add support for adsp mailbox
 controller
Message-ID: <YaBl66b7VFJK84F4@google.com>
References: <20211125122925.1303-1-allen-kh.cheng@mediatek.com>
 <20211125122925.1303-4-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125122925.1303-4-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 08:29:25PM +0800, allen-kh.cheng wrote:
> diff --git a/drivers/mailbox/mtk-adsp-mailbox.c b/drivers/mailbox/mtk-adsp-mailbox.c
[...]
> +static bool mtk_adsp_mbox_last_tx_done(struct mbox_chan *chan)
> +{
> +	struct adsp_mbox_ch_info *ch_info = chan->con_priv;
> +	void __iomem *reg = ch_info->va_reg;
> +
> +	return (readl(reg + MTK_ADSP_MBOX_IN_CMD) == 0) ? true : false;

To be concise, readl(reg + MTK_ADSP_MBOX_IN_CMD) == 0.

> +static int mtk_adsp_mbox_probe(struct platform_device *pdev)
> +{
[...]
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "no adsp mbox register resource\n");
> +		return -ENXIO;
> +	}
> +
> +	priv->va_mboxreg = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->va_mboxreg))
> +		return PTR_ERR(priv->va_mboxreg);

If using devm_platform_ioremap_resource(), it doesn't need to call platform_get_resource().  res is unused.
