Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41B6364228
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 15:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbhDSNAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 09:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbhDSNAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:00:53 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6DFC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 06:00:23 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a12so7117077uak.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 06:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNMcn4oglu2NGwzmq9WcTEHn8YHQehABTWuPmJET8B4=;
        b=yndd6T37Aw2eLhE+JRuDr5ab72qnJVSgo9GhZkoptwXoz9S85Hw7A4Nbjrw+DhvLVa
         j5v8psvt9yNWE+yWB8I5Icf/q3ezqDfo35XtPYG3EgCaM5HvZF27sRd7qQsI6oXZvXA7
         dEMwIo84dMSrs8/4UbAQXC/acqXqo/vUvPZQxj3C84OIs2OkP4w/2Nt5kGMN1NY9XI4i
         aebovg1gxswYtHIRzHbH4cJqex29vham5WVGSNyXQWwBsfKuDmmM397vGhOGoWuIh7hW
         vBz+vgWlUEfaUfVB9Q1CF8snTafMMppiRNwpSSyeypv+IzH8r0cufTqSltFeVBwiLxJr
         wAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNMcn4oglu2NGwzmq9WcTEHn8YHQehABTWuPmJET8B4=;
        b=DIefCs8hgQPmZVVhKWcrflybeLVgO9QCTW2fIuswK8tIvQLFeDo1cmC22j5ya43R3d
         C7uolrWZmBpliGv41EzsEhZE1hGJH9reGOXjQSs5waR6SpiqF42nFHEpVEP2FnjiNSxl
         ocpYQnoke8RFP2P7Si6yD+lyKr2Zmfkp+FjJ1/hfz19XSDfJX7uuoruDIdi4qohCx5Xz
         nXpb7+To8KTslEDKWLkQPNFMw20ZFxRU6MduS8Ebpnf4uT6GFVR04+WyiQLG2ipFWILj
         NAvvMdf9dNy7kchhYWIhm36civ2Vz4QbsELWl0U8eRAsfXlTg+5dJxIkO4xZOVdAtG8m
         8d3A==
X-Gm-Message-State: AOAM532LPvLyv9eTKV8fSl0wKdrewAp6aXaWVlPo2ScDBrdiqbT0CTUx
        k7pUluwYNO38kAb84VfBott/IazYM7c/+1oNve+3FQ==
X-Google-Smtp-Source: ABdhPJwJvm4R5NxbjLn2MQj05V10FldWtWWpurPZb2rGihrkJUsFuWlmgNAc1rZuP45HV0CTYbYQXmAENNYFQN7x70I=
X-Received: by 2002:ab0:12a:: with SMTP id 39mr6601930uak.19.1618837222948;
 Mon, 19 Apr 2021 06:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210419112459.25241-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210419112459.25241-1-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 19 Apr 2021 14:59:45 +0200
Message-ID: <CAPDyKFoizAhKxfzMzTBdQe6J5rYPLTbBTbn5nM4WAB1QGn9VUw@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] mmc: core: Correct descriptions in mmc_of_parse()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Haibo Chen <haibo.chen@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 at 13:24, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Since it has been converted to use device property API, the function
> and field descriptions become outdated. Correct them.
>
> Fixes: 73a47a9bb3e2 ("mmc: core: Use device_property_read instead of of_property_read")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Series applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/host.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 9b89a91b6b47..ce030c5aa53c 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -209,8 +209,8 @@ mmc_of_parse_clk_phase(struct mmc_host *host, struct mmc_clk_phase_map *map)
>  EXPORT_SYMBOL(mmc_of_parse_clk_phase);
>
>  /**
> - *     mmc_of_parse() - parse host's device-tree node
> - *     @host: host whose node should be parsed.
> + * mmc_of_parse() - parse host's device properties
> + * @host: host whose properties should be parsed.
>   *
>   * To keep the rest of the MMC subsystem unaware of whether DT has been
>   * used to to instantiate and configure this host instance or not, we
> --
> 2.30.2
>
