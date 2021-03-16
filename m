Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9B333E1BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 23:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhCPWwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 18:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhCPWwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 18:52:38 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8F4C06174A;
        Tue, 16 Mar 2021 15:52:37 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id w125so11276062oib.13;
        Tue, 16 Mar 2021 15:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DsZA7M2L6ElXBpjZUXtVLrRd/T9BA8yOoed8azovsvw=;
        b=cqa452dQ0OMw5O1M9HQNaOhhHYxkRg9ubwuTkMzn9Boie5napRdXJIF3B6CVHl/Qe0
         tbPo+QG1R1wJaMR26XtoZ2LOuHvvhNH6YMGf326x9UJ1QkB8B/NvaN5da3abo3+eWRSr
         g94hube0EustyXEzawO8DLC3qJutptP4rjBF9Y/bJhuJxIVkkdzW4xYYsRrjEYeIB6St
         m6+CMNpvdAdYC3PHQZR7Os0MpXSmcSPCaeicOmGixKL42rMFi5nQidx+U5tqKb2XlzLu
         BxGx/mCLvxbPJcjx6tYfQ6MJUoheTu2e3gZaT/wGf9aphtYT87FMWyUOumeTx30q8ZXN
         3TGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DsZA7M2L6ElXBpjZUXtVLrRd/T9BA8yOoed8azovsvw=;
        b=EifLy8aJUxJtw7AiAVH3yT78eN2ApFW/X8hwCmczeECeBph3fAL8Z6nP1n4FEBFpdK
         ZyiPgbyjjdm6oBzIiKORfbcJ4H8TT0Z9GV9rskMY2Vu5EDXqodrNVWILgqPA0YlAzE0a
         FvL3uaS+4mTmSj+tT0LUor6Aa59uxZAhPW+kslwlXO5VGwt2yFkMrVJ7Ny6CM6SkcAJk
         sxbE5l7cLS45RU9LUqagHOrltHNi00WkZEovvPV2dI9ZbbpKzsw7lCszpgn+UASOEEIH
         oaJWTIaNjRqcKrDs/aTF/gfAnWyQKLjiB8+pVCY+P+vLuKwRNhvaeNQ9eeG4ETolgH2b
         Gm+Q==
X-Gm-Message-State: AOAM53079jVvCr2w3JNm+KoTISZ3OaKHX6bxkYRYSbV+Rzqrznp9tK7R
        O0SEPKVAGWRVNcbUYQaS9eU=
X-Google-Smtp-Source: ABdhPJwbzKF19M/vUu6d3JPZe/7WFHD/GCPtrsOgMWig+R5SIHByrNLbe/PA2FnnBvzY4kDv/BwqwQ==
X-Received: by 2002:aca:1a01:: with SMTP id a1mr695812oia.33.1615935156424;
        Tue, 16 Mar 2021 15:52:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b9sm8214394ooa.47.2021.03.16.15.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 15:52:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Invoke power_supply_changed for
 tcpm-source-psy-
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
References: <20210316215657.387357-1-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <2175cb45-5fdc-eb57-150c-9d7adee73184@roeck-us.net>
Date:   Tue, 16 Mar 2021 15:52:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210316215657.387357-1-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 2:56 PM, Badhri Jagan Sridharan wrote:
> tcpm-source-psy- does not invoke power_supply_changed API when
> one of the published power supply property is changed.

properties

> power_supply_changed needs to be called to notify
> userspace clients(uevents) and kernel clients.
> 
> Fixes: f2a8aa053c176("typec: tcpm: Represent source supply through
> power_supply")

Is that supposed to be split ?

> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Otherwise

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 11d0c40bc47d..e8936ea17f80 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -945,6 +945,7 @@ static int tcpm_set_current_limit(struct tcpm_port *port, u32 max_ma, u32 mv)
>  
>  	port->supply_voltage = mv;
>  	port->current_limit = max_ma;
> +	power_supply_changed(port->psy);
>  
>  	if (port->tcpc->set_current_limit)
>  		ret = port->tcpc->set_current_limit(port->tcpc, max_ma, mv);
> @@ -2931,6 +2932,7 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
>  
>  	port->pps_data.supported = false;
>  	port->usb_type = POWER_SUPPLY_USB_TYPE_PD;
> +	power_supply_changed(port->psy);
>  
>  	/*
>  	 * Select the source PDO providing the most power which has a
> @@ -2955,6 +2957,7 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
>  				port->pps_data.supported = true;
>  				port->usb_type =
>  					POWER_SUPPLY_USB_TYPE_PD_PPS;
> +				power_supply_changed(port->psy);
>  			}
>  			continue;
>  		default:
> @@ -3112,6 +3115,7 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  						  port->pps_data.out_volt));
>  		port->pps_data.op_curr = min(port->pps_data.max_curr,
>  					     port->pps_data.op_curr);
> +		power_supply_changed(port->psy);
>  	}
>  
>  	return src_pdo;
> @@ -3347,6 +3351,7 @@ static int tcpm_set_charge(struct tcpm_port *port, bool charge)
>  			return ret;
>  	}
>  	port->vbus_charge = charge;
> +	power_supply_changed(port->psy);
>  	return 0;
>  }
>  
> @@ -3530,6 +3535,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
>  	port->try_src_count = 0;
>  	port->try_snk_count = 0;
>  	port->usb_type = POWER_SUPPLY_USB_TYPE_C;
> +	power_supply_changed(port->psy);
>  	port->nr_sink_caps = 0;
>  	port->sink_cap_done = false;
>  	if (port->tcpc->enable_frs)
> @@ -5957,7 +5963,7 @@ static int tcpm_psy_set_prop(struct power_supply *psy,
>  		ret = -EINVAL;
>  		break;
>  	}
> -
> +	power_supply_changed(port->psy);
>  	return ret;
>  }
>  
> @@ -6110,6 +6116,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	err = devm_tcpm_psy_register(port);
>  	if (err)
>  		goto out_role_sw_put;
> +	power_supply_changed(port->psy);
>  
>  	port->typec_port = typec_register_port(port->dev, &port->typec_caps);
>  	if (IS_ERR(port->typec_port)) {
> 

