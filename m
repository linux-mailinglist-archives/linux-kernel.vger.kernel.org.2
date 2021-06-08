Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB96539F789
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhFHNTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:19:51 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:45855 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbhFHNTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:19:48 -0400
Received: by mail-ua1-f53.google.com with SMTP id z13so6600046uai.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55gewmxEVl3ZVcwS6O9solrcdE7rmPK2jzo+kIX4FD0=;
        b=neZDyHARxr5BeNCs1zq64t5POX25ZtuJhEptT293O/1LdcMw2/r7jM3W4KZ29UAvDe
         3lOuwMyvZbLu+jLD5aJOeD/Ffh3UZnANgVPgJuSxNl3nqfi/UBIBneEougweUCAFb15s
         Q3ZtswmAZXSRj9OvAPLVcobj6RJyCpKdc8s/DXQwCzVfQIAoo419SBDgeIIDLMCDdvRa
         qBhyEgolrH0WTYWGZcUJMst65cdj5fTxYUiON1/pinvoQzQt1D02YO31Ds34NTh5cL+2
         v1UEokE6axgWPhiaNeHzbDpEqa+yuBQss1TIqei9rVbMaSW71CAdP349r4bL9aPVZIUA
         TDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55gewmxEVl3ZVcwS6O9solrcdE7rmPK2jzo+kIX4FD0=;
        b=YYkemSfanPQkxcLUxAUrlMlt12dN+ts+a2RLXshiH0eaoaCAxfsUFAsuOooWyOyFd3
         sumUMP0IGsKuRHV4H8Q73B9HIj/WeIMgZp3nxx2ZZ+gnyCwRLUwqCNMrO02dhR9m76ME
         O2dNuFcyPvxjf836vZosx/BllssRxPOy1IXAlBZ1uqrZh7v5+2zveMO+cIfkonP6blKS
         KzOHja9GnnLMuMncOrh3pJfKd+EZydg7G6A8vvKVlo1QIua5yosqSdGrJjWLQmD/Cb2Q
         ZDM9lopVIkpxMwt7gkxcGlILSINGOML6foebNIazGVznC7Worx9bvsGlT4QQSlJgD1h8
         /VkQ==
X-Gm-Message-State: AOAM5328tO//513L6DGBciYpN8zt0ttrvnouOqsbR7V4dUS/IzQOIa/m
        qxVatbX2NC9+wAf0992nHfT0Q1XhYTK+6EajcS6PPA==
X-Google-Smtp-Source: ABdhPJy6odpm9e0WdZi5O6ao3QWO6eK4K6fn+yzP4auEjAWP5zDPJ0u6N2tJXgGh8Q6s/WG/tNXLav/XYUY+CJHagq8=
X-Received: by 2002:ab0:12a:: with SMTP id 39mr12673740uak.19.1623158206210;
 Tue, 08 Jun 2021 06:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210601095403.236007-1-krzysztof.kozlowski@canonical.com> <20210601095403.236007-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210601095403.236007-2-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 15:16:09 +0200
Message-ID: <CAPDyKFoSsLxg-6cFXc+Lapbz5bGCJ0xzpE5H8VrLfFSMfrn8zw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-sprd: use sdhci_sprd_writew
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 at 11:54, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The sdhci_sprd_writew() was defined by never used in sdhci_ops:
>
>     drivers/mmc/host/sdhci-sprd.c:134:20: warning: unused function 'sdhci_sprd_writew'
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-sprd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 5dc36efff47f..11e375579cfb 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -393,6 +393,7 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
>  static struct sdhci_ops sdhci_sprd_ops = {
>         .read_l = sdhci_sprd_readl,
>         .write_l = sdhci_sprd_writel,
> +       .write_w = sdhci_sprd_writew,
>         .write_b = sdhci_sprd_writeb,
>         .set_clock = sdhci_sprd_set_clock,
>         .get_max_clock = sdhci_sprd_get_max_clock,
> --
> 2.27.0
>
