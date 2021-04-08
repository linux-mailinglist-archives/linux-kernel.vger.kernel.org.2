Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DCC35881D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhDHPV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:21:27 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:46719 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhDHPVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:21:25 -0400
Received: by mail-ot1-f53.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso725599otb.13;
        Thu, 08 Apr 2021 08:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6KZFzK+nzEQ00+8KcSgL3f5DvNG68xJ2rg8Oh+jD2PI=;
        b=Nt1EqAU4hIt0eQnsQGyENwmZvZCK54MSaNjunRxLJtzHATn9YiVCOkwRLNKaidxu8e
         np75hrqwYb4WcF7GpizF7Xib5w+U/cFmaiWSxzJ+RgxKUcOsKyhm4s4t7t1F9fh/Ts78
         LtYQSkihdNsebXAZ7RCfDCi/6IVy5v/DNJRQiOCSXVpWGtcynlkn+Fnjvpflv9316sQf
         sk8MTTKzS1hVYsxwo1/4HLd/SoCXtdUClxpdTJaCyMIz3XKQ/DEDn2mPwGQA1qUstBNG
         G9Lq4BaobCybwvImJzxVBHXK/C5y73kONkFmcbq339bY147QhHVg2Pl2ZwwO88YJ1GPB
         4Lmw==
X-Gm-Message-State: AOAM53093E4mvjuHLYd1sjwBYmAWcBIevzF65BAEKZU4szDNJ7qCeWpi
        PObYp/e9Z9/1RSS6yrsaEw==
X-Google-Smtp-Source: ABdhPJz9PartmCiNrmBrMQc5KCgZmaZf7Btn88a34YZU/sCcvkFscfqZv9VYHP7BRhcvMv0yW2J5pQ==
X-Received: by 2002:a9d:5a8d:: with SMTP id w13mr8142482oth.145.1617895274012;
        Thu, 08 Apr 2021 08:21:14 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 68sm212184otc.54.2021.04.08.08.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:21:13 -0700 (PDT)
Received: (nullmailer pid 1506966 invoked by uid 1000);
        Thu, 08 Apr 2021 15:21:12 -0000
Date:   Thu, 8 Apr 2021 10:21:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v6 3/5] of/platform: Add stubs for
 of_platform_device_create/destroy()
Message-ID: <20210408152112.GA1493009@robh.at.kernel.org>
References: <20210405201817.3977893-1-mka@chromium.org>
 <20210405124900.v6.3.I08fd2e1c775af04f663730e9fb4d00e6bbb38541@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405124900.v6.3.I08fd2e1c775af04f663730e9fb4d00e6bbb38541@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 01:18:15PM -0700, Matthias Kaehlcke wrote:
> Code for platform_device_create() and of_platform_device_create() is

platform_device_create()?

> only generated if CONFIG_OF_ADDRESS=y. Add stubs to avoid unresolved
> symbols when CONFIG_OF_ADDRESS is not set.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v7:
> - none
> 
> Changes in v6:
> - patch added to the series
> 
>  include/linux/of_platform.h | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
> index 84a966623e78..d15b6cd5e1c3 100644
> --- a/include/linux/of_platform.h
> +++ b/include/linux/of_platform.h
> @@ -61,16 +61,18 @@ static inline struct platform_device *of_find_device_by_node(struct device_node
>  }
>  #endif
>  
> +extern int of_platform_bus_probe(struct device_node *root,
> +				 const struct of_device_id *matches,
> +				 struct device *parent);

This is also only built for CONFIG_OF_ADDRESS. But there's no need for 
an empty function as it is powerpc only and should never have a new 
user.

> +
> +#ifdef CONFIG_OF_ADDRESS
>  /* Platform devices and busses creation */
>  extern struct platform_device *of_platform_device_create(struct device_node *np,
>  						   const char *bus_id,
>  						   struct device *parent);
>  
>  extern int of_platform_device_destroy(struct device *dev, void *data);
> -extern int of_platform_bus_probe(struct device_node *root,
> -				 const struct of_device_id *matches,
> -				 struct device *parent);
> -#ifdef CONFIG_OF_ADDRESS
> +
>  extern int of_platform_populate(struct device_node *root,
>  				const struct of_device_id *matches,
>  				const struct of_dev_auxdata *lookup,
> @@ -84,6 +86,18 @@ extern int devm_of_platform_populate(struct device *dev);
>  
>  extern void devm_of_platform_depopulate(struct device *dev);
>  #else
> +/* Platform devices and busses creation */
> +static inline struct platform_device *of_platform_device_create(struct device_node *np,
> +								const char *bus_id,
> +								struct device *parent)
> +{
> +	return NULL;
> +}
> +static inline int of_platform_device_destroy(struct device *dev, void *data)
> +{
> +	return -ENODEV;
> +}
> +
>  static inline int of_platform_populate(struct device_node *root,
>  					const struct of_device_id *matches,
>  					const struct of_dev_auxdata *lookup,
> -- 
> 2.31.0.208.g409f899ff0-goog
> 
