Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C9A36F378
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 03:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhD3BYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 21:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD3BYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 21:24:15 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F94FC06138B;
        Thu, 29 Apr 2021 18:23:26 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t24so11061308oic.10;
        Thu, 29 Apr 2021 18:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1SYSV1ST5CmyKauB1cfHt/lTjzM1JtgTjndM7qycV2o=;
        b=Y1xm6h0jsXhEjU0x8/UPm/ebG9B1+44LoKVQV9r5rnnas+5rYWJObWCn8SZo6tSMZ1
         cGtznuA8KXtzD+a3KJgBiRpw5l3cTwIHQUxNZT8zUqp07Rhx4BMZFAn8vMSLJSirEz6c
         fiv0HTIG8Th+seaIerFKPHoWMlf7O6xyzsrT6nZdccuUgfexudsLEMyCbX8t1aF8TiDg
         +1qJcvWbSL45Ld3V/7iTZvnJS6dmb35psqoGcvGT1hfIWKayXTipB1/SvfAx6c04P9wN
         1KH3PflvzzZ+ZjbpJEncNHyBCDeM3jwz9pYUfaTJwWh7sqGe2Wz+Qlw2G3mJ0YMWevob
         106g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1SYSV1ST5CmyKauB1cfHt/lTjzM1JtgTjndM7qycV2o=;
        b=VrBOG3eojB9s5R83OahWGvBceVlV+lCtjAm43I7yV/3+7+7tBNkO/+pePzjNgmThfg
         nR8gbJcqjaSwvNWjKVL07lctio9bu+HeI/jdvCDCkkamsyQZw8AyccyAgm6vQtN0IuCc
         1I59BT2cVoXEcaxn28uDeh6ayz0px/7j3KmA6N9yEaSjRYYUR1no+l9IzRqhXsz+4Uey
         eBIcEzizoZ5yeYxecIn6DHveFJXvx4kIEla/fEbALI1PWu9Ph+SKkOVIOWS3TTVCiunS
         dgkx+/kca2mhPI3WCaqXLYsOkQTFjm4D6E/phOiN4GExAJHdoNOV2b7BWvo6HsIbhDiA
         jxYw==
X-Gm-Message-State: AOAM530TBwjTMJbt6DN+mU3fnhuftslcmYA/1w5r0RjBfl9TgVIa1rzT
        X0y+tzfs3Jddk8ogag3KdcOrmg+h4lQ=
X-Google-Smtp-Source: ABdhPJzhRt2piz5wYQRbzUjle3i0pXTPwyn8+KVGHk8JUisg/wusbUU9Dm6Mk1x9240e2ds0mb6WGg==
X-Received: by 2002:a05:6808:2d0:: with SMTP id a16mr2127647oid.116.1619745805896;
        Thu, 29 Apr 2021 18:23:25 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k16sm397760ooa.36.2021.04.29.18.23.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Apr 2021 18:23:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 29 Apr 2021 18:23:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com
Subject: Re: [PATCH] hwmon: (occ) Fix poll rate limiting
Message-ID: <20210430012323.GA186319@roeck-us.net>
References: <20210429151336.18980-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429151336.18980-1-eajames@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 10:13:36AM -0500, Eddie James wrote:
> The poll rate limiter time was initialized at zero. This breaks the
> comparison in time_after if jiffies is large. Switch to storing the
> next update time rather than the previous time, and initialize the
> time when the device is probed.
> 
> Fixes: c10e753d43eb ("hwmon (occ): Add sensor types and versions")
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/common.c | 5 +++--
>  drivers/hwmon/occ/common.h | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index f1ac153d0b56..967532afb1c0 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -217,9 +217,9 @@ int occ_update_response(struct occ *occ)
>  		return rc;
>  
>  	/* limit the maximum rate of polling the OCC */
> -	if (time_after(jiffies, occ->last_update + OCC_UPDATE_FREQUENCY)) {
> +	if (time_after(jiffies, occ->next_update)) {
>  		rc = occ_poll(occ);
> -		occ->last_update = jiffies;
> +		occ->next_update = jiffies + OCC_UPDATE_FREQUENCY;
>  	} else {
>  		rc = occ->last_error;
>  	}
> @@ -1165,6 +1165,7 @@ int occ_setup(struct occ *occ, const char *name)
>  		return rc;
>  	}
>  
> +	occ->next_update = jiffies + OCC_UPDATE_FREQUENCY;
>  	occ_parse_poll_response(occ);
>  
>  	rc = occ_setup_sensor_attrs(occ);
> diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
> index 67e6968b8978..e6df719770e8 100644
> --- a/drivers/hwmon/occ/common.h
> +++ b/drivers/hwmon/occ/common.h
> @@ -99,7 +99,7 @@ struct occ {
>  	u8 poll_cmd_data;		/* to perform OCC poll command */
>  	int (*send_cmd)(struct occ *occ, u8 *cmd);
>  
> -	unsigned long last_update;
> +	unsigned long next_update;
>  	struct mutex lock;		/* lock OCC access */
>  
>  	struct device *hwmon;
