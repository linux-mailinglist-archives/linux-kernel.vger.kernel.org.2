Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE69C379297
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbhEJPZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239050AbhEJPYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:24:45 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB0AC07E5DC;
        Mon, 10 May 2021 08:02:30 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so10692838oto.0;
        Mon, 10 May 2021 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BJBAKc3PQ9AHpThbEJS50zFIUwVJp1qU6xGIki8dg58=;
        b=CsiMDWwUq9272G9cotZI3nZ5EnvRLzF599akRxkhVtpv8fLQo55fuZXw0h51/M6mcs
         x+b3nlcynyVBLKvo4BpGM47/sg1JoJS+ZJAnwfGH44EjRZQmKnUknAlIPkKlgA7B4Cat
         iYx61KpD5LlrYioDMeidgcqEmnkYfiQT3Jju6Vayr8YnIfRH78DQH/43Uah8ImMF4zjK
         5k/Dab31oMtzF+MiHUaO1aL2+D/fV1rVEhQvDJH4Bb7vb7rB09mguyJzBUNSFC0zThJs
         /cZftPo5jQzwW1tmtULCSfk1+hWwNRNSw+On79I9JU86JB2QdaDHGf6X6qbLpG6+8/Fu
         IH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BJBAKc3PQ9AHpThbEJS50zFIUwVJp1qU6xGIki8dg58=;
        b=mvtw1gjucq1ybsLg4C2CUw2ddp6EQLyHXMTp/mRMT8Cowux3MKkVtwX4MmI6wWN+9j
         hrdDlclDfGpZLUIuLD0VXD4ibrMrkNXhQajmyOPCU9trYPsDs9AnxjQa0wVBXziKFDnf
         vzVC4z78gYQtPG/k+odxVeIQTTrY1mkuLubfb9jubTw2z8BJ7hFL/MHyNhCsDj+iMVHM
         DXrw+GHzk29csqM0YKRQubLkChjZdnsN00TabFslkmHxRTtPBUS3BdyshKKoHTDlJKMX
         K4e6+JRmbn6GMTtFcD4wq9lZM56bjUZNW+pZd/WGnntfP4QApX2GQCguVn58mShzA2Op
         +KXw==
X-Gm-Message-State: AOAM530KOBGRv9pwT6KM9bS4Gl/ZT7qqQTISNFsQ+lt5CGDc6cleUwTi
        Hy0N5pfOaMsXSooiup85YEk=
X-Google-Smtp-Source: ABdhPJyYbzqATX7KJRRHJu4DNrk4N0sbPVcXyEG4Uw54J9gfIRD/M4fRW/+hcpTfnkkkbsqjvT//bw==
X-Received: by 2002:a9d:449:: with SMTP id 67mr21185911otc.333.1620658949920;
        Mon, 10 May 2021 08:02:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a12sm3159302oti.12.2021.05.10.08.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:02:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 10 May 2021 08:02:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandru Tachici <alexandru.tachici@analog.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 1/1] hwmon: (ltc2992) Put fwnode in error case during
 ->probe()
Message-ID: <20210510150228.GA1997561@roeck-us.net>
References: <20210510100136.3303142-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510100136.3303142-1-andy.shevchenko@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 01:01:36PM +0300, Andy Shevchenko wrote:
> In each iteration fwnode_for_each_available_child_node() bumps a reference
> counting of a loop variable followed by dropping in on a next iteration,
> 
> Since in error case the loop is broken, we have to drop a reference count
> by ourselves. Do it for port_fwnode in error case during ->probe().
> 
> Fixes: b0bd407e94b0 ("hwmon: (ltc2992) Add support")
> Cc: Alexandru Tachici <alexandru.tachici@analog.com>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/ltc2992.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
> index 4382105bf142..2a4bed0ab226 100644
> --- a/drivers/hwmon/ltc2992.c
> +++ b/drivers/hwmon/ltc2992.c
> @@ -900,11 +900,15 @@ static int ltc2992_parse_dt(struct ltc2992_state *st)
>  
>  	fwnode_for_each_available_child_node(fwnode, child) {
>  		ret = fwnode_property_read_u32(child, "reg", &addr);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			fwnode_handle_put(child);
>  			return ret;
> +		}
>  
> -		if (addr > 1)
> +		if (addr > 1) {
> +			fwnode_handle_put(child);
>  			return -EINVAL;
> +		}
>  
>  		ret = fwnode_property_read_u32(child, "shunt-resistor-micro-ohms", &val);
>  		if (!ret)
