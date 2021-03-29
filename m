Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C0934D9E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhC2WIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhC2WHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:07:51 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9D3C061574;
        Mon, 29 Mar 2021 15:07:51 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id w70so14607957oie.0;
        Mon, 29 Mar 2021 15:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6jfK0XRjhIFBjEMtAAevTK/NhIqcQ4npO55mjZStFwA=;
        b=lCljFIHlMcrNwuHqwxd0FXSSVspV34rKowyC/UkATFbN6CG7TXWuov16Wriaem/khb
         Tx5BBJKhc9hSH1do9hIUwlWJ2SVB/bgKKlPincw0ze686pcaMs0ZijFNotSqZ8WHkmvk
         5DpWEvxycptLEmrbm/KFRbzwYJAcLpaLc38DHerS5dYDlmQqstrK3rbcdDeDXX1ipmb/
         7fbcPVopZF12dgnkFQiT/G9QwVNRT1kTwVWmjIe7djZ9ihc3ajHM0d0aKR5RE3fmavGo
         dllNdfAjbIz5054WocjEmueZl63whr5ZcYXr7NFRLHqHkpnR3EE7LUwq9XuTRSTykA4U
         9/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6jfK0XRjhIFBjEMtAAevTK/NhIqcQ4npO55mjZStFwA=;
        b=ScWtAFGDZ5vM/yt+X6+aOUaem/LGOspjDMxBVpwJjRKjjjudrjsr6pUolhfj/hnZSp
         fMubFMPl03OVSJ0yI6jtEmKrRanasRmwCj/Rui+jYzMMoaA4Wvp3ZxGjLRDJAZJPiCkt
         VthCndct/iwN2P4/3CBrQDiRu7md43K6E4NMBq+9OAocD17itAaDMlONzXX5G7qTLNt2
         dVnRoo2jA/k2PPjJbSahwu7ly49HeqI8HGlKrBEcYB3tIQMwxt1g24Ka4lE2VuHwgBfJ
         fEKPweDdtI7U0i3couF/Bz+N7QjPyO7MSuV43HLMxRtos56v2ZYXGMNR9XwSJOO/xLzi
         xJPA==
X-Gm-Message-State: AOAM5324kRwka47k3Ir092e93iZ88DB/OLBoADwwBR2emHBJLAqkor32
        G2se/AJJ2VALk3exKswp82Q=
X-Google-Smtp-Source: ABdhPJwoptbXzquVw/Era9tlXb4amfxhW/w5Nh/HmMk1jaz3UgKRXqmlk//2ayAG1toTJeawMaR9pw==
X-Received: by 2002:aca:ebd3:: with SMTP id j202mr941354oih.14.1617055670428;
        Mon, 29 Mar 2021 15:07:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n6sm3732141oop.48.2021.03.29.15.07.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Mar 2021 15:07:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Mar 2021 15:07:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] hwmon: (ftsteutates): Rudimentary typo fixes
Message-ID: <20210329220748.GA222771@roeck-us.net>
References: <20210323043438.1321903-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323043438.1321903-1-unixbhaskar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 10:04:38AM +0530, Bhaskar Chowdhury wrote:
> s/Temprature/Temperature/
> s/revsion/revision/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Partially applied; a patch fixing the revsion typo was already queued.

Thanks,
Guenter

> ---
>  drivers/hwmon/ftsteutates.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --
> 2.31.0
> 
> diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
> index ef88a156efc2..ceffc76a0c51 100644
> --- a/drivers/hwmon/ftsteutates.c
> +++ b/drivers/hwmon/ftsteutates.c
> @@ -509,7 +509,7 @@ fan_alarm_store(struct device *dev, struct device_attribute *devattr,
>  /* SysFS structs							     */
>  /*****************************************************************************/
> 
> -/* Temprature sensors */
> +/* Temperature sensors */
>  static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_value, 0);
>  static SENSOR_DEVICE_ATTR_RO(temp2_input, temp_value, 1);
>  static SENSOR_DEVICE_ATTR_RO(temp3_input, temp_value, 2);
> @@ -713,7 +713,7 @@ static int fts_detect(struct i2c_client *client,
>  {
>  	int val;
> 
> -	/* detection works with revsion greater or equal to 0x2b */
> +	/* detection works with revision greater or equal to 0x2b */
>  	val = i2c_smbus_read_byte_data(client, FTS_DEVICE_REVISION_REG);
>  	if (val < 0x2b)
>  		return -ENODEV;
