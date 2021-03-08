Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11453331A43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 23:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhCHWdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 17:33:13 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:34199 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCHWcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 17:32:55 -0500
Received: by mail-io1-f49.google.com with SMTP id o11so11811681iob.1;
        Mon, 08 Mar 2021 14:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zMpKwqq7yFBnF4iE9g3YrHJF3RPeBFvOFzDyEl6CFUQ=;
        b=S0FHmy270z9yh8pfFBUre8qx6Wb3U4HvwM7Ym7LqCx+b0u/D4VUNr3NpSGp/zm1vTl
         1TWrmS3B6eRGc5K+/oj+E1z6ABDIGbsmydT+/qB57qY06uupiA1vIQDJq2hmICQ2fIVw
         tvP9ys7U+eKt9lio0tqQycyKTJjz4ktcO8KbHcd1zJZxhbjNbNSyzqDeBAIFLsYYepEN
         peFebu86n9uaxPcOAvsEJzcxIxPT+XsojH1mxHcb1XZGlJT63DLnBZZnETX6an01b3u9
         04sWWbruVkhVY7uHHzwKWSyYG5yY7l02z/v8M/aYwWW7SLrZvYG5FybQj96xgZ5j2QQ7
         dNLw==
X-Gm-Message-State: AOAM5317hd6YNwnspLtvL9+NagnVRbigEtldCHYYl0x6lHqzoHATFKiF
        XjsxT1EOGfzKPQPp68Cz+Q==
X-Google-Smtp-Source: ABdhPJxbV+jsVNMMeyQvNqlwzT5npZHMsQW/CNyz9wtp4S1VgLEkFCtQ3k3DBERRS6Kq4JlrrIRtNg==
X-Received: by 2002:a02:7691:: with SMTP id z139mr25831234jab.130.1615242775271;
        Mon, 08 Mar 2021 14:32:55 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s18sm6877160ilt.9.2021.03.08.14.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 14:32:54 -0800 (PST)
Received: (nullmailer pid 3071678 invoked by uid 1000);
        Mon, 08 Mar 2021 22:32:51 -0000
Date:   Mon, 8 Mar 2021 15:32:51 -0700
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        linux-usb@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v6 3/5] of/platform: Add stubs for
 of_platform_device_create/destroy()
Message-ID: <20210308223251.GA3067045@robh.at.kernel.org>
References: <20210305193853.2040456-1-mka@chromium.org>
 <20210305113832.v6.3.I08fd2e1c775af04f663730e9fb4d00e6bbb38541@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305113832.v6.3.I08fd2e1c775af04f663730e9fb4d00e6bbb38541@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 11:38:51AM -0800, Matthias Kaehlcke wrote:
> Code for platform_device_create() and of_platform_device_create() is

You mean of_platform_device_create and of_platform_device_destroy?

Does of_platform_populate not work in your usecase?

> only generated if CONFIG_OF_ADDRESS=y. Add stubs to avoid unresolved
> symbols when CONFIG_OF_ADDRESS is not set.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
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
> 2.30.1.766.gb4fecdf3b7-goog
> 
