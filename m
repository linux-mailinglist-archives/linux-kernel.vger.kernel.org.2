Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB133621F1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244445AbhDPOPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241568AbhDPOO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:14:57 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474F1C061574;
        Fri, 16 Apr 2021 07:14:30 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id n140so27957624oig.9;
        Fri, 16 Apr 2021 07:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=65N9Kp4PBxpTjuyc3/ie9bOroIFouunysfM8BBC1uiw=;
        b=kx/FVz7KepDYI1He13TsnPCAXrQaObs7LYZ2YLr3zHhWmDndh5Ozw3RDyKkMrqIh+z
         MznFB//oSZKeb7bHbkeenTZJ8qXRe33H1JVEc9TFh5Re35fP4/HlCixHGWiXPhAoNcTo
         QKrMvpdSkHuL+i1d+AkhJbmKpVIndwHXPloQHbxXaMipkKWSgshH8R/PhOBVc6JBjwW2
         v4ZQnFFb++kMAI9n9MAf7poKyGCmr0nxQdRzSS6IGNPW2KQR+Ebc3n8cIgGhrNHwrWCO
         vLc3gVLEfjJ8oWUYJuPWNN4O3gDICo1xxuoTjabzxvl4cGvEflx3m3ss/wLuPgZxN0S7
         1Vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=65N9Kp4PBxpTjuyc3/ie9bOroIFouunysfM8BBC1uiw=;
        b=dWJAYt9BOuZY7pmcvf0P/xTddPAZSlpNfT2+eR0BhyfCEScDI1NP4NsQE5CVIp5nXI
         dY1luPbrmCVz21RR52FoALmMc+XUghzdf0gc7Iig/8MA0TB6FbO7OngR5ouacAVm5CEL
         a0DLPg16EUVQdtJVI6XkRug3k9+E6Xh59EXz4xCqf3MK5NyFLBWBai0uNIDlhW8RChn/
         /WV9UO/D9KsNGYj0Yg+xeRYbgIz8uy4nP5szYnv95IS8XGL5ywejBjH5TL5twb7IXyNP
         HFq2Re4A7vYZjgFRclah/o08if6ex36BLt26/A/26I0b8NAIoWGFp1ksOSKswXQN0ykH
         5pzQ==
X-Gm-Message-State: AOAM533DCL14H3m9fRfYW9LiO4L3hnUZjzyUPUbLR7Nvxt2pndpFLqdR
        EWn0naRM8e44Ebn+g2s8Zpyc/memG9c=
X-Google-Smtp-Source: ABdhPJxduZF26xTaWjBNA3LmCFt4T7aCOvcnUsHiJtq6OPNlvPIicbmHp1R109ZiW3Tt4IB250cRNA==
X-Received: by 2002:aca:5909:: with SMTP id n9mr3471769oib.66.1618582468319;
        Fri, 16 Apr 2021 07:14:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u139sm1415117oia.52.2021.04.16.07.14.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Apr 2021 07:14:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 16 Apr 2021 07:14:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Fertser <fercerpav@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: pmbus: pxe1610: don't bail out when not all
 pages are active
Message-ID: <20210416141425.GA254358@roeck-us.net>
References: <3612b78a-8e43-289b-ff0f-6c995995eeb0@roeck-us.net>
 <20210416102926.13614-1-fercerpav@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416102926.13614-1-fercerpav@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 01:29:04PM +0300, Paul Fertser wrote:
> Certain VRs might be configured to use only the first output channel and
> so the mode for the second will be 0. Handle this gracefully.
> 
> Fixes: b9fa0a3acfd8 ("hwmon: (pmbus/core) Add support for vid mode detection per page bases")
> Signed-off-by: Paul Fertser <fercerpav@gmail.com>

Applied.

Thanks,
Guenter

> ---
> 
> Notes:
>     Changes for v2:
>       - Use more imperative style
> 
>  drivers/hwmon/pmbus/pxe1610.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pxe1610.c b/drivers/hwmon/pmbus/pxe1610.c
> index da27ce34ee3f..eb4a06003b7f 100644
> --- a/drivers/hwmon/pmbus/pxe1610.c
> +++ b/drivers/hwmon/pmbus/pxe1610.c
> @@ -41,6 +41,15 @@ static int pxe1610_identify(struct i2c_client *client,
>  				info->vrm_version[i] = vr13;
>  				break;
>  			default:
> +				/*
> +				 * If prior pages are available limit operation
> +				 * to them
> +				 */
> +				if (i != 0) {
> +					info->pages = i;
> +					return 0;
> +				}
> +
>  				return -ENODEV;
>  			}
>  		}
> -- 
> 2.20.1
> 
