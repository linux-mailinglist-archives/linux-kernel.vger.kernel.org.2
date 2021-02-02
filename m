Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065EB30B40F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhBBAZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhBBAZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:25:39 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000CEC061573;
        Mon,  1 Feb 2021 16:24:58 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id q3so4733934oog.4;
        Mon, 01 Feb 2021 16:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hfIxrdFOJeBnjVBYWdy8JF+xIHAh9pPujDvVWdys060=;
        b=Ebn3FJwcMGwNWigpwl6Z/49KoPswpZkeec3vJ9E/r+voxzQ7qroJvUQnJcGEJQovSr
         K6fVxyC86SqQ0BKFGAZ3Evt1YmNZOvk1rqg6jIIr1AxtrLDhE/nMjs8Tw25oUBhfSO7w
         65wp1Mc2ZPfpIs2KH9rRykLZ5JQ7ivnX8PQssovDH7mJXEs/HUzhphfHyMEJDYx04Ehh
         eRyYcdywmucUNxh4OEH9DxIkbd0Zy6N7ZR2HAGfAm8xLkDtywNO8frX3e8RCm6Evv8Q8
         HsYBHTeZbsEfDJ8n4HdRsfPvVfCNPMKIX5NjqJAqZnFP0bRcL68pHydByGUjRT+leGOL
         jywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hfIxrdFOJeBnjVBYWdy8JF+xIHAh9pPujDvVWdys060=;
        b=D09XrvToYXgT/AoYftTGnv2iF4nG81CaZczz5+Eyd+pboYi3/XQQv+PFyEexC/jfmi
         bRIeq3Xoqc2ZVOyYz7WKjAvGcwyD3naMJM0NOOgzSxlDKNqL/n+uha3qBMkxuVw2/NqW
         eBWzvbdERKGSKIFBkSqOeXBNRfAcgiFM04HNZULAFnczLq6d9dqhSxoEYqP2HW+OA+nA
         guV9WTMOGCF/6Wr52x+SeQTaOi6gStWC/6n+AbYvU/fQGFC/OaqfD5IaVnMlnvdcsUFk
         eeK1j+zFqmWD1q+UIUuVGcDnhkiRPmA/VyMculYWq/UcNn8KIBV6jm9c0R/br1+sELVO
         Op8w==
X-Gm-Message-State: AOAM530bM4ugTaW7cj+IJWyUajNhfhM16qNFHiUsuEqGMt0yXZzud5hR
        BSqWrb16Vq/UlFfwU6Hc8seIbEhqDQk=
X-Google-Smtp-Source: ABdhPJxQnFBWQJWNV950YaurNGRrcUnJdcmgabit2HlAd5YrkARcxQ3Q8Y5DzFx+vFKfPF7F7wBhfg==
X-Received: by 2002:a4a:558e:: with SMTP id e136mr13745153oob.18.1612225498477;
        Mon, 01 Feb 2021 16:24:58 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g23sm4398330otk.72.2021.02.01.16.24.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Feb 2021 16:24:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 1 Feb 2021 16:24:56 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH 1/2] Clear sensor data after chip write
Message-ID: <20210202002456.GA117432@roeck-us.net>
References: <20210201195929.1200-1-erik.rosen@metormote.com>
 <20210201195929.1200-2-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201195929.1200-2-erik.rosen@metormote.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:59:28PM +0100, Erik Rosen wrote:
> Set the sensor->data field to -ENODATA to force a chip access next time
> the sensor value is read.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>

Applied. Please remember to add subsystem and driver to future patches.
In this case, I added:

hwmon: (pmbus) ...

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 192442b3b7a2..e27f23eee1e3 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -974,7 +974,7 @@ static ssize_t pmbus_set_sensor(struct device *dev,
>  	if (ret < 0)
>  		rv = ret;
>  	else
> -		sensor->data = regval;
> +		sensor->data = -ENODATA;
>  	mutex_unlock(&data->update_lock);
>  	return rv;
>  }
