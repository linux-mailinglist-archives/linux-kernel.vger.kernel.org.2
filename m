Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664C73E993A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhHKTx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhHKTxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:53:54 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC08AC061765;
        Wed, 11 Aug 2021 12:53:30 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c130so3724597qkg.7;
        Wed, 11 Aug 2021 12:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rPrtdKt/YZtNr2ThmWGK7gfA2fUSCmrI1clnEEe6Psw=;
        b=aSPAhMzaxlaK8LEP+kjYmQk1IyRoCctEUbTKWsVfaEBq+bANgW3RxUVj2gnS4tc0e6
         IuwKDdiEAo4YV8KuWqQkN0fK/AAlM+EsazBbMZNOedjcmRrIMNm8YE3Mgsm9ideDTHZ7
         gjhfVMatfZID+c7cUUWX9HrouAeJRi8ZOg0Fbth92s4OwmxvvyRW040wPGCHvashxt2D
         ORopYJDdsKY5IVKzj0V+8peCsNmyWtvQ0ddZekGJ0m9Q2lv1STIzLS6CKNoZNAOdcuJ1
         74pWWvnGGzbjFd25RVcck6JOAZZTs5CJAeOt6g7se5WARhTT+f2AIimLcatG/bWh8EjG
         HvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rPrtdKt/YZtNr2ThmWGK7gfA2fUSCmrI1clnEEe6Psw=;
        b=def57elIExlU3jQkzeJcnm/E69Vbrvcy5sQMPtBWyJBscZJedSJ9+vtHD9tBt+Fokp
         u3hrGacR+jOV3KZioNZuye9as4Olr2onO6lElQ8u76qp8nxHSniEYLQPbI+qZrhnBbiX
         9FaRozukpOMG3mZ5xtFyz0mTqFRf3keJJs5m1f+D7lffM4zaDNTU9f4uu4miwlppqMWa
         PO/6/U5R39hZfBnBSFhcuBqxYFazQzg0N08yvlMoUBdEberirU0J+87nKuSM7VVnqa6z
         rjUXY9RYyWiaX0ja2Trhg8e+KBqPVA1b010+6/xwS/Pss6kVP2A0MG3nU5+BlaPvpb4u
         ID6g==
X-Gm-Message-State: AOAM530IhO8q0hYlhV14cX6Trv/dNKQFEUrqhUzEHPuqYntHXVK7ZiJl
        8q/86qPtfwV+4z+3brpGyGc=
X-Google-Smtp-Source: ABdhPJzY/+m1tC4cFv+1/93F6gqrCJpGfAdnnqL8XrHuyFp0bNsV4mCQm4s/MxBaas5AzOHUjgroJw==
X-Received: by 2002:a37:7d8:: with SMTP id 207mr710387qkh.291.1628711609763;
        Wed, 11 Aug 2021 12:53:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v22sm115079qtw.18.2021.08.11.12.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:53:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Aug 2021 12:53:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (pmbus/bpa-rs600) Add workaround for
 incorrect Pin max
Message-ID: <20210811195327.GA966160@roeck-us.net>
References: <20210811041738.15061-1-chris.packham@alliedtelesis.co.nz>
 <20210811041738.15061-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811041738.15061-3-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 04:17:38PM +1200, Chris Packham wrote:
> BPD-RS600 modules running firmware v5.70 misreport the MFR_PIN_MAX.
> The indicate a maximum of 1640W instead of 700W. Detect the invalid
> reading and return a sensible value instead.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  drivers/hwmon/pmbus/bpa-rs600.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/bpa-rs600.c b/drivers/hwmon/pmbus/bpa-rs600.c
> index d495faa89799..f4baed9ce8a4 100644
> --- a/drivers/hwmon/pmbus/bpa-rs600.c
> +++ b/drivers/hwmon/pmbus/bpa-rs600.c
> @@ -65,6 +65,24 @@ static int bpa_rs600_read_vin(struct i2c_client *client)
>  	return ret;
>  }
>  
> +/*
> + * The firmware on some BPD-RS600 models incorrectly reports 1640W
> + * for MFR_PIN_MAX. Deal with this by returning a sensible value.
> + */
> +static int bpa_rs600_read_pin_max(struct i2c_client *client)
> +{
> +	int ret;
> +
> +	ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_PIN_MAX);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret == 0x0b34)
> +		return 0x095e;

The comments from the descriotion need to be here.

Thanks,
Guenter

> +
> +	return ret;
> +}
> +
>  static int bpa_rs600_read_word_data(struct i2c_client *client, int page, int phase, int reg)
>  {
>  	int ret;
> @@ -92,7 +110,8 @@ static int bpa_rs600_read_word_data(struct i2c_client *client, int page, int pha
>  		ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_IOUT_MAX);
>  		break;
>  	case PMBUS_PIN_OP_WARN_LIMIT:
> -		ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_PIN_MAX);
> +	case PMBUS_MFR_PIN_MAX:
> +		ret = bpa_rs600_read_pin_max(client);

So the idea is to return the same value for PMBUS_PIN_OP_WARN_LIMIT
(max_alarm) and PMBUS_MFR_PIN_MAX (rated_max) ? That doesn't really
make sense. The meaning of those limits is distinctly different.

Guenter

>  		break;
>  	case PMBUS_POUT_OP_WARN_LIMIT:
>  		ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_POUT_MAX);
> -- 
> 2.32.0
> 
