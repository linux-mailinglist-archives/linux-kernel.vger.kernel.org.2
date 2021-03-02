Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3213C32AD74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837712AbhCBV62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581626AbhCBTA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 14:00:56 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3D0C061793;
        Tue,  2 Mar 2021 10:45:40 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id x10so5062872oor.3;
        Tue, 02 Mar 2021 10:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JROuMfkU4HoYF8TuTQubXoXyR+EkQYdRR0aqOWhdHKs=;
        b=ROz1Penyv0ajcRobd93LinxoVsKE0D6qZ/d1UqW380ESXOvZDq0QkCRYWC0MuGkeDj
         xwZPatTgh0F45cX5LuYiyo++JzpRwZzpH0c6eeUhRTXAY+Fpro2glHKXBcaTT0OO/ztE
         GdVKK6FUh/dznmBDoRdmR7yHSkSO2iupRzWBA8XBtt79T8j9/03rPd93+vEbyylAbY3L
         HHEx0SxhIWIuDUe2OgwPkvHAzdJNlGkN6tS1tulYwKyGvm428p2U6jOZT0/OahY4rBAh
         U5QK0AjPL1Hncfd+tBulEUdJaR1NiWoa5l744sY2xlSvBGPmeTdHAWTM4EmmKA+EwaOv
         230g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JROuMfkU4HoYF8TuTQubXoXyR+EkQYdRR0aqOWhdHKs=;
        b=fYA8IrupAjYF+oWbg8VibxX7eky8lEqL5Z1JUh02QvMah1OETjBGndnZovyxXqNhet
         0vVaSxl7iXAxv24SRagEkYlE+rlSY2P762r/NZzXdvRey10rNmilOTicoa36ODwaNmJ0
         X8wi+xwVlQi2gY5W7n7Q42vy/Adbaax8DBBCsI1Bt1PTIhFgccTcvzJE0fak13k+JbZy
         8o2+wzeKtNJVGmX/gJBv7s3GzoThjKA/WhBjOynL/e7/xTVlnJD2A4Qr8M9U+qjGibGJ
         j2CvpVS/5ejfF+7mTBnHKp0sQ2MKaFNskRoRcI4WQkvWdkOEwTvP4K0ss56r/HP4oxTG
         L+ZA==
X-Gm-Message-State: AOAM531C9fBMuyN1cwKFSnknUSqnkD77W9yauwRs3MY1oEKkpNKDB88S
        FoU4BCbdOd/6Ic4v60isjKE=
X-Google-Smtp-Source: ABdhPJxYlakeDpRKlBKg201vIg7DETrPV4l+oSFPdMsRpDAPOhjXui4YX8+5VQZ7QwzkOO7QN5C4/w==
X-Received: by 2002:a4a:bd97:: with SMTP id k23mr14070837oop.13.1614710739679;
        Tue, 02 Mar 2021 10:45:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r26sm3207072otq.61.2021.03.02.10.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 10:45:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBod21vbjogKG5jdDY4ODMpIFN1cHBv?=
 =?UTF-8?Q?rt_NCT6886d?=
To:     Jiqi JQ9 Li <lijq9@lenovo.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Mark RH Pearson <markpearson@lenovo.com>
References: <lijq9@lenovo.com> <20210302061205.1825664-1-lijq9@lenovo.com>
 <HK0PR03MB370088B1CE476C57A14D439783999@HK0PR03MB3700.apcprd03.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <5e09ae3c-f4c0-796c-345c-ec70a24c0644@roeck-us.net>
Date:   Tue, 2 Mar 2021 10:45:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <HK0PR03MB370088B1CE476C57A14D439783999@HK0PR03MB3700.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 10:21 PM, Jiqi JQ9 Li wrote:
> Sorry, Please ignore this email as some typos. 
> 

No problem. I seem to be missing the typos, though.

Thanks,
Guenter

> -----邮件原件-----
> 发件人: Jiqi JQ9 Li <lijq9@lenovo.com> 
> 发送时间: 2021年3月2日 14:12
> 收件人: jdelvare@suse.com; linux@roeck-us.net; linux-hwmon@vger.kernel.org; linux-kernel@vger.kernel.org
> 抄送: Mark RH Pearson <markpearson@lenovo.com>; Jiqi JQ9 Li <lijq9@lenovo.com>
> 主题: [PATCH] hwmon: (nct6883) Support NCT6886d
> 
> Add support for NCT6886d chip used in the Lenovo P620.
> 
> Signed-off-by: Jiqi Li <lijq9@lenovo.com>
> Reviewed-by: Mark Pearson <markpearson@lenovo.com>
> ---
>  drivers/hwmon/nct6683.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c index a23047a3bfe2..3de7bd146965 100644
> --- a/drivers/hwmon/nct6683.c
> +++ b/drivers/hwmon/nct6683.c
> @@ -12,6 +12,7 @@
>   *
>   * Chip        #vin    #fan    #pwm    #temp  chip ID
>   * nct6683d     21(1)   16      8       32(1) 0xc730
> + * nct6686d     21(1)   16      8       32(1) 0xd440
>   * nct6687d     21(1)   16      8       32(1) 0xd590
>   *
>   * Notes:
> @@ -33,7 +34,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> -enum kinds { nct6683, nct6687 };
> +enum kinds { nct6683, nct6686, nct6687 };
>  
>  static bool force;
>  module_param(force, bool, 0);
> @@ -41,11 +42,13 @@ MODULE_PARM_DESC(force, "Set to one to enable support for unknown vendors");
>  
>  static const char * const nct6683_device_names[] = {
>  	"nct6683",
> +	"nct6686",
>  	"nct6687",
>  };
>  
>  static const char * const nct6683_chip_names[] = {
>  	"NCT6683D",
> +	"NCT6686D",
>  	"NCT6687D",
>  };
>  
> @@ -66,6 +69,7 @@ static const char * const nct6683_chip_names[] = {
>  
>  #define SIO_NCT6681_ID		0xb270	/* for later */
>  #define SIO_NCT6683_ID		0xc730
> +#define SIO_NCT6686_ID		0xd440
>  #define SIO_NCT6687_ID		0xd590
>  #define SIO_ID_MASK		0xFFF0
>  
> @@ -1362,6 +1366,9 @@ static int __init nct6683_find(int sioaddr, struct nct6683_sio_data *sio_data)
>  	case SIO_NCT6683_ID:
>  		sio_data->kind = nct6683;
>  		break;
> +	case SIO_NCT6686_ID:
> +		sio_data->kind = nct6686;
> +		break;
>  	case SIO_NCT6687_ID:
>  		sio_data->kind = nct6687;
>  		break;
> --
> 2.18.2
> 

