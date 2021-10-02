Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75CB41FB26
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 13:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhJBLhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 07:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhJBLhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 07:37:51 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16BFC061570;
        Sat,  2 Oct 2021 04:36:05 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so14938980ota.6;
        Sat, 02 Oct 2021 04:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4VflFQEVnSnhiiOckKXj/qYhnyqZrOgYUIyRylTHW4Q=;
        b=YMImXyHnHGi6QcX1/SvvtfS79PNdWx9bMz794EYUzjym4rqtTDW3gAkO8DBRw3/56U
         KFW3SnXIIaKWHlNnW0pEQRbGsjQtYy05N/B/G+BW/Kakjs1woYZZYHa3S2U+9k7gzUb/
         VqxCS3+YcfEVW9j5eIf/vtjVWBM1KoPLyAZ7ZK/8kwPcgptYe91WmpVMZMEoJmf7lxDO
         TdF8PPKLB1WErqlfQSjCN32NYfZDr2VDkFVigmqLO5orsQx6Cm4OKnYXQube7zrh8nH8
         SrIP5aYsBeJuGNE3gvaaxXYWBr5l51H5Oy12H/7jR4HjOOkElpkFAPCqcjdJu6jLEPVG
         z2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4VflFQEVnSnhiiOckKXj/qYhnyqZrOgYUIyRylTHW4Q=;
        b=VUTuEfvneIDwAHiUhc4mi3yUZ2aUvShpw4s+KL9XAT+X+yIMggUN8yYXYcu+hSeoZi
         l4kbB14xIFpPBeyXfZhZdac4c/LKoCiTY/EjYSi8aT25fYF05k4AtRv9zWG6QXu+YbKz
         qp81svFAvoqVnKWFtXNzdevsjta93RoGG7sklhEPtVhdsXla/3qD/BOhJ1Gz92LbDyX7
         M+rvvcli/aKCCeX1pwJoFMpX18iEqH8AP7Zku3+YRA8Ydo40Z4kauVDEeAQAFnGyfp5Q
         gMu8q+JzYV0rA3EReQ1dTv9ZB1dGhOUwTy372pvBTZUz5qy0EN/uT64doqLuCP1YiE/m
         Pn4w==
X-Gm-Message-State: AOAM533/ExjMCbxd8G+O5mSTTy5FN2dsZBSURRUBpUR0VzkjG9aWadSv
        iHuGhAFWgvez+GJ+sW+Gjav/zyTEuX4=
X-Google-Smtp-Source: ABdhPJyeJ0H1Hq3Mw/ATJFUwgGVWEmapZgwSY7pOWzx4Y7IN+wWWvRwVKr3P+Gk6NW/sRh4/giIWPg==
X-Received: by 2002:a9d:7b4f:: with SMTP id f15mr2184378oto.158.1633174565062;
        Sat, 02 Oct 2021 04:36:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w184sm1641895oie.35.2021.10.02.04.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 04:36:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 2 Oct 2021 04:36:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (occ) Fix P10 VRM temp sensors
Message-ID: <20211002113602.GA894333@roeck-us.net>
References: <20210929153604.14968-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929153604.14968-1-eajames@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 10:36:04AM -0500, Eddie James wrote:
> The P10 (temp sensor version 0x10) doesn't do the same VRM status
> reporting that was used on P9. It just reports the temperature, so
> drop the check for VRM fru type in the sysfs show function, and don't
> set the name to "alarm".
> 
> Fixes: db4919ec86 ("hwmon: (occ) Add new temperature sensor type")
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/common.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index 0d68a78be980..ae664613289c 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -340,18 +340,11 @@ static ssize_t occ_show_temp_10(struct device *dev,
>  		if (val == OCC_TEMP_SENSOR_FAULT)
>  			return -EREMOTEIO;
>  
> -		/*
> -		 * VRM doesn't return temperature, only alarm bit. This
> -		 * attribute maps to tempX_alarm instead of tempX_input for
> -		 * VRM
> -		 */
> -		if (temp->fru_type != OCC_FRU_TYPE_VRM) {
> -			/* sensor not ready */
> -			if (val == 0)
> -				return -EAGAIN;
> +		/* sensor not ready */
> +		if (val == 0)
> +			return -EAGAIN;
>  
> -			val *= 1000;
> -		}
> +		val *= 1000;
>  		break;
>  	case 2:
>  		val = temp->fru_type;
> @@ -886,7 +879,7 @@ static int occ_setup_sensor_attrs(struct occ *occ)
>  					     0, i);
>  		attr++;
>  
> -		if (sensors->temp.version > 1 &&
> +		if (sensors->temp.version == 2 &&
>  		    temp->fru_type == OCC_FRU_TYPE_VRM) {
>  			snprintf(attr->name, sizeof(attr->name),
>  				 "temp%d_alarm", s);
