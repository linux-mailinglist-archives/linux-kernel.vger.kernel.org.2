Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FE63A1C58
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 19:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhFIRtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 13:49:47 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:41631 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhFIRtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 13:49:46 -0400
Received: by mail-ot1-f52.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so24762804oth.8;
        Wed, 09 Jun 2021 10:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MJx1/dfNXbGRaJ8PHBLkra+Bf+gLpR423d7oxSKFHWI=;
        b=rLRw5nOAcHi8Ou/ivgTVHOHU1KpkjfURvkKNSxl2MwR4kFM0a8ub6t+Wrp9hSB6Ylv
         b/wfBTLH/xDEekTFTX9Ci1+LKKaERbaXZ4jBXTlAzYrxgSfCjnw4y34vSjE5RhBwoJSQ
         WURIrEnmaDqPDg4atIT7nuk7U9/hBz5HKHWH+A+zTAIQUWt+4Q3LYBNqyklZO7hppS46
         vzR6fD+ltJD9bvMgJP8DTcRwXhUOa3EYMpNfujhnPyHMNynbWJUx/FuzGGpkf4BQt0Ht
         1O9wl5Gwzv3bZzDkHw43lMm+0jcTOUdFrOkxUT1pat66HSYKc34jOL5D/4UJLuV3a5vp
         umpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MJx1/dfNXbGRaJ8PHBLkra+Bf+gLpR423d7oxSKFHWI=;
        b=AdgVpsCPwRfrrPRH8XRqblY3ll87ZTT+eQf9Reb38ICByXcrlFkYt6OaolgkEyLMW9
         WniKhCfaMd4BXGh9dUxN7Fz5H2bDvIDqv1VhQLGXe6o6YO+NGNiZ9jt1njbL0idwBXm9
         Go5wqawZ2aYwn6aUG2saaBJrjwj/mpvRBHmWGq14E6EH3yArN78+qlT5gio5KwWbqxa0
         lMxfhLlKomUkm1ilGw74q/943wu3fyS3HB/WsP6XNGJv4OYj6H40kPtVKGEdo36fajCu
         Pfogw1USjD1e07troOoE4Hv/3SW1d5hW8zlyOGUBmG8ShbtV99WUCxeon9jaeqQFDsVk
         qayw==
X-Gm-Message-State: AOAM533IOpM/cOkIMZM5mqjq4hiZrh3ajV7ul476SzW4lNhEiEk0zlbd
        o69/0ayIljQJ0kdLY0jZ8t4=
X-Google-Smtp-Source: ABdhPJwQM+GrejQblCOV8nRwDSyUXbuSAzB0GI1sn9AhJRhgEDGjl/3IIx6yEYe2yWdctyhfWLJ/Ew==
X-Received: by 2002:a9d:22a3:: with SMTP id y32mr504032ota.274.1623260811222;
        Wed, 09 Jun 2021 10:46:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i26sm100433oig.13.2021.06.09.10.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 10:46:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 9 Jun 2021 10:46:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/1] usb: typec: wcove: Use LE to CPU conversion when
 accessing msg->header
Message-ID: <20210609174648.GA2172861@roeck-us.net>
References: <20210609172202.83377-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609172202.83377-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 08:22:02PM +0300, Andy Shevchenko wrote:
> As LKP noticed the Sparse is not happy about strict type handling:
>    .../typec/tcpm/wcove.c:380:50: sparse:     expected unsigned short [usertype] header
>    .../typec/tcpm/wcove.c:380:50: sparse:     got restricted __le16 const [usertype] header
> 
> Fix this by switching to use pd_header_cnt_le() instead of pd_header_cnt()
> in the affected code.
> 
> Fixes: ae8a2ca8a221 ("usb: typec: Group all TCPCI/TCPM code together")
> Fixes: 3c4fb9f16921 ("usb: typec: wcove: start using tcpm for USB PD support")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2: added Rb tag (Heikki), amend Fixes tags (Greg)
>  drivers/usb/typec/tcpm/wcove.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
> index 8072e222eb99..20917d85d6f4 100644
> --- a/drivers/usb/typec/tcpm/wcove.c
> +++ b/drivers/usb/typec/tcpm/wcove.c
> @@ -378,7 +378,7 @@ static int wcove_pd_transmit(struct tcpc_dev *tcpc,
>  		const u8 *data = (void *)msg;
>  		int i;
>  
> -		for (i = 0; i < pd_header_cnt(msg->header) * 4 + 2; i++) {
> +		for (i = 0; i < pd_header_cnt_le(msg->header) * 4 + 2; i++) {
>  			ret = regmap_write(wcove->regmap, USBC_TX_DATA + i,
>  					   data[i]);
>  			if (ret)
> -- 
> 2.30.2
> 
