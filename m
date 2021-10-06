Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62470424290
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbhJFQ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhJFQ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:27:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AA8C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 09:25:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k23so2644374pji.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SlLouinstJtGqDeYDZkm/0tMv8ZDoxiEw4xjkE7JI2s=;
        b=R5pjvXeXyk/KJO47HkUp057DRmixyU5/EgBE5S9GKMmgHFu9NFqplRRTKtmA1Cm2JS
         x/AgJgCy+iuRIL6TLykzGU/25hcpiDm98GdsfyvYNwncStkhtC0QPNc3FqBJ7Y8mKSQ7
         vMbDPLCo8eTTtq59dCj7qB+n/eY2MAxsaxyW6Mh/MpO1qwxEmnHHsxAyZcO36r74BRK/
         YzEmVIeuS0TWuRt4wkRNEY1rqnmW0GJV0l0Qc8hfSfh1ssFHg+95Kl86CxGBdCABI4+l
         JwASRHoFPOHK5TRjUeSiRRj7Wrs2sO5rL7dvknotqy4nQWEWwpnU8PSK3Ah1/B6mv+Te
         PUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SlLouinstJtGqDeYDZkm/0tMv8ZDoxiEw4xjkE7JI2s=;
        b=Ow+xo+qA+HEmuERseuYiIB0ZR7DNfI/SVS1CAIHJAO6bx/MWFEidfWB2NTlH92eWas
         jVqHTk21vZmuB1DV+EbBF8Ji4LJVIe+Uhf+uWpEDn2owJpDQJeyt0LYw8GXR4vaRpx40
         Teyeq6o2FVJBp81lP7DA7NQi+lISBsKwg8uC99Ayco3xqc7KwRl50pynJSUu+bnE9IkF
         zgN4bUFP8NPoV576U5Dx9LP5zz/eo0Sby8euzi0z5IUoDasf0go1jcUC9rGeq0E+MGS5
         KOTMDIomJG0q4wECS4H0uUDCzz+tJENm3EEPVT+EJmZzI6m8QJ+tLwmfHl9YLMVlazEL
         SUAQ==
X-Gm-Message-State: AOAM531rjXgZ/KMnuZ1l610Aif/DaSuPcna8SYAXrIg7nbzXe1DilSBJ
        cqgV580tfh1MXhkyw25bzEMvcg==
X-Google-Smtp-Source: ABdhPJxJ1grTO/Z89FUCLSNbgkb//8zelQNvy1ipaZp0ZX+jHiHCxT1TqVhdiKp4rmVocz5WV+VALA==
X-Received: by 2002:a17:902:a385:b0:13e:99e9:17f3 with SMTP id x5-20020a170902a38500b0013e99e917f3mr11790324pla.65.1633537514785;
        Wed, 06 Oct 2021 09:25:14 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q6sm5880167pjd.26.2021.10.06.09.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:25:13 -0700 (PDT)
Date:   Wed, 6 Oct 2021 10:25:11 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com
Subject: Re: [PATCH v5 3/4] remoteproc: imx_dsp_rproc: Add remoteproc driver
 for DSP on i.MX
Message-ID: <20211006162511.GA3370862@p14s>
References: <1632625630-784-1-git-send-email-shengjiu.wang@nxp.com>
 <1632625630-784-4-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632625630-784-4-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

This pachset doesn't apply to rproc-next, which is now located here[1].  The
change is in linux-next but not in mainline yet.

https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/log/?h=rproc-next

On Sun, Sep 26, 2021 at 11:07:09AM +0800, Shengjiu Wang wrote:
> Provide a basic driver to control DSP processor found on NXP i.MX8QM,
> i.MX8QXP, i.MX8MP and i.MX8ULP.
> 
> Currently it is able to resolve addresses between DSP and main CPU,
> start and stop the processor, suspend and resume.
> 
> The communication between DSP and main CPU is based on mailbox, there
> are three mailbox channels (tx, rx, rxdb).
> 
> This driver was tested on NXP i.MX8QM, i.MX8QXP, i.MX8MP and i.MX8ULP.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/remoteproc/Kconfig         |   11 +
>  drivers/remoteproc/Makefile        |    1 +
>  drivers/remoteproc/imx_dsp_rproc.c | 1206 ++++++++++++++++++++++++++++
>  3 files changed, 1218 insertions(+)
>  create mode 100644 drivers/remoteproc/imx_dsp_rproc.c
>

[...]

> +
> +/**
> + * imx_dsp_attach_pm_domains() - attach the power domains
> + * @priv: private data pointer
> + *
> + * On i.MX8QM and i.MX8QXP there is multiple power domains
> + * required, so need to link them.
> + */
> +static int imx_dsp_attach_pm_domains(struct imx_dsp_rproc *priv)
> +{
> +	struct device *dev = priv->rproc->dev.parent;
> +	int ret, i;
> +
> +	priv->num_domains = of_count_phandle_with_args(dev->of_node,
> +						       "power-domains",
> +						       "#power-domain-cells");
> +
> +	/* If only one domain, then no need to link the device */
> +	if (priv->num_domains <= 1)
> +		return 0;
> +
> +	priv->pd_dev = devm_kmalloc_array(dev, priv->num_domains,
> +					  sizeof(*priv->pd_dev),
> +					  GFP_KERNEL);
> +	if (!priv->pd_dev)
> +		return -ENOMEM;
> +
> +	priv->pd_dev_link = devm_kmalloc_array(dev, priv->num_domains,
> +					       sizeof(*priv->pd_dev_link),
> +					       GFP_KERNEL);
> +	if (!priv->pd_dev_link)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < priv->num_domains; i++) {
> +		priv->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
> +		if (IS_ERR(priv->pd_dev[i])) {
> +			ret = PTR_ERR(priv->pd_dev[i]);
> +			goto detach_pm;
> +		}

I have pointed a problem with the error handling in the above during the
previous review and it was not addressed.

> +
> +		/*
> +		 * device_link_add will check priv->pd_dev[i], if it is
> +		 * NULL, then will break.
> +		 */
> +		priv->pd_dev_link[i] = device_link_add(dev,
> +						       priv->pd_dev[i],
> +						       DL_FLAG_STATELESS |
> +						       DL_FLAG_PM_RUNTIME);
> +		if (!priv->pd_dev_link[i]) {
> +			dev_pm_domain_detach(priv->pd_dev[i], false);
> +			ret = -EINVAL;
> +			goto detach_pm;
> +		}
> +	}
> +
> +	return 0;
> +
> +detach_pm:
> +	while (--i >= 0) {
> +		device_link_del(priv->pd_dev_link[i]);
> +		dev_pm_domain_detach(priv->pd_dev[i], false);
> +	}
> +
> +	return ret;
> +}
> +
