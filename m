Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CC1337FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCKVof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCKVoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:44:08 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FD9C061574;
        Thu, 11 Mar 2021 13:44:08 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id m1so2457455ote.10;
        Thu, 11 Mar 2021 13:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pP/ToFMswoVlEeoCP+bOzIcth5EBOOJrEJydORseAGU=;
        b=Och4VYveXdzpV0hFo14Tqy95TYzIj8LSBOcc6IpNTApWeW4CHck594V6jnYqRVQIvc
         A3UWif/dL8kzDo0EHAZQ4qTnZOvSLl31hXs5HBf2aBk+LZcEzFmVmzPsink6Z2WgimQA
         aWKJrEsnvifnv14mNLHcqly3Mi8YjTLITd3ejKHeA7VZuD5NT70X9xqrpZOCV9olt+ZM
         aQzPjajOFxv3glOpj/vJjZVtIl5LF0+yc83eF7uWRTNi802aTnr6WEkyQllBqbRrs+0X
         XwFddtwlLgVbG8kZWvVYJGX9hWxgEroZ7iqFG8ObTC3BGEt2u+8DkhjHQZwOuzF9ui20
         R33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pP/ToFMswoVlEeoCP+bOzIcth5EBOOJrEJydORseAGU=;
        b=WpCBUhKE6i0qEPhYqqu7pGZouj63EHsvkxGq9Spsv2G/UCe/ps21r7zbEvasyM0doi
         XhpT6N5fpws7cv2QdmitFMSI8ehZDwX+fzhThXSpXgpWhKUPRQG+3eI7KzBrUtScf0UJ
         pFyc3Yia6isEU5zsqQBY6iMamGIBlJCk+q7ynxoeYWiLyU5EIt6GrMrRp9Pon1A0+sWt
         ZZcJnlVz71SrT+1yiD/FOnO9CbenvEGMu3FZGnl7Sz46niuM3LHHmDwV68cREmGQRZTR
         p8C3NUkr0jTZOP/bslJrW4uDyfmfEzqCWTx/YhwzTaHqSOCC9sK6tx0Ok0b45RD86QjT
         cQHA==
X-Gm-Message-State: AOAM531o1YZKtkCdfS4LgoRsS6YYqTLtHhaxw8UqhCkH8bRcGTHLKa92
        cZQht8wR51yPmGOUrRUMRGY=
X-Google-Smtp-Source: ABdhPJzFLYpb6Ol8+hJg/hjMCCzSCtDJuMWhEjrO5pHz2pNgNentxt5KSlz4LmjERSC/vd0YizSLig==
X-Received: by 2002:a9d:3a34:: with SMTP id j49mr772342otc.153.1615499047814;
        Thu, 11 Mar 2021 13:44:07 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k9sm915536ots.24.2021.03.11.13.44.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Mar 2021 13:44:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Mar 2021 13:44:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v2 5/9] hwmon/drivers/mr75203: Use HZ macros
Message-ID: <20210311214405.GA35866@roeck-us.net>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
 <20210224144222.23762-5-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224144222.23762-5-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 03:42:15PM +0100, Daniel Lezcano wrote:
> HZ unit conversion macros are available in units.h, use them and
> remove the duplicate definition.

I assume the idea is to submit the series together, so

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Christian Eggers <ceggers@arri.de>
> ---
>  drivers/hwmon/mr75203.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index 18da5a25e89a..868243dba1ee 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -17,6 +17,7 @@
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> +#include <linux/units.h>
>  
>  /* PVT Common register */
>  #define PVT_IP_CONFIG	0x04
> @@ -37,7 +38,6 @@
>  #define CLK_SYNTH_EN		BIT(24)
>  #define CLK_SYS_CYCLES_MAX	514
>  #define CLK_SYS_CYCLES_MIN	2
> -#define HZ_PER_MHZ		1000000L
>  
>  #define SDIF_DISABLE	0x04
>  
