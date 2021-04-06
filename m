Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FA8354AA8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 03:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243238AbhDFB43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 21:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239052AbhDFB41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 21:56:27 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD43CC06174A;
        Mon,  5 Apr 2021 18:56:20 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id a8so13491742oic.11;
        Mon, 05 Apr 2021 18:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rxywtD09YKNAwOWK6u9Q9KUhLEwmPcN3XknB29aiJaY=;
        b=NKuZAA9godM6BGEfhyPL8nDaaaxcJcuCabLzIS0zjNq6j6AaadzuC5ERleDxsFWhCh
         1mn2aMjCQEgGSjcPV5/ZdlmoGUsnVH4dB0r9hBNkagbJh/7XxAIOC0BYU4DAu1nf1ZxZ
         BNUftLNx5bNUwACnORTU++A//y0khKPCfuxiqToJRDsynz146bHREfVP9d4boijHwxA/
         i5lPHFR7yF9FyKP32HhQ/PiLyRHG6vEJdb6nSFgv2Y4ylkuuForbhNo28dbnxt8nc/o9
         i1bRQ2yf0SQN7kY+4wzN/MUw7lmOOOUNnvprzhyF/BteGJisQuXPM9o0lzwF2/OSOA4J
         q98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rxywtD09YKNAwOWK6u9Q9KUhLEwmPcN3XknB29aiJaY=;
        b=qrcFgewm1rw5mGHePGEnnvLtPiudk8aphkHBqcw07gEHZiZ0r/opfoq812nap/S6hj
         0AYlFmJsudj5u5+1p0OGFJDjxELfQNn49Ti129AnssZbKccSwBbWCCit21N9l+1Hxen9
         HBUF0tfwTodalPvjhR4Td2CYSKB1E+GNBV6py9Dc84rXHqAePSimMljHjgycaHnHDcYP
         0JzPdL3f5gsAWvbsI1L3dNwhcGPjl75RpAUf+2bWh3rSr2pP7740LjZS76ZMzUiUja4l
         lG1tf85UFGVf4Qe5wHBF5BDglviO0Jbm+Qrw7VjDcCwoZG4sksFDU76g6GCWoqXWKyH+
         GmSQ==
X-Gm-Message-State: AOAM5326Xz9uoS/ig8Inf+8W3Gp5sP6lFmsPumhyzhGhojifFh76Ynbv
        UmxgJChpQQXRao62z6R3jJA=
X-Google-Smtp-Source: ABdhPJyNkyIhHXywkb7khI0p9HPKQVdcxkqfG8FuSS9nnrzrpviKfghA1Vqs0yk0BrHciHgXIdmTNg==
X-Received: by 2002:aca:2103:: with SMTP id 3mr1470620oiz.80.1617674180322;
        Mon, 05 Apr 2021 18:56:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o197sm3828666ooo.44.2021.04.05.18.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 18:56:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v1 1/6] usb: typec: tcpm: Address incorrect values of tcpm
 psy for fixed supply
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>
References: <20210406013643.3280369-1-badhri@google.com>
 <20210406013643.3280369-2-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <9ca3dbe9-af32-62cf-fa27-7da4e6967b85@roeck-us.net>
Date:   Mon, 5 Apr 2021 18:56:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210406013643.3280369-2-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/21 6:36 PM, Badhri Jagan Sridharan wrote:
> tcpm_pd_build_request overwrites current_limit and supply_voltage
> even before port partner accepts the requests. This leaves stale
> values in current_limit and supply_voltage that get exported by
> "tcpm-source-psy-". Solving this problem by caching the request
> values of current limit/supply voltage in req_current_limit
> and req_supply_voltage. current_limit/supply_voltage gets updated
> once the port partner accepts the request.
> 
> Fixes: f2a8aa053c176 ("typec: tcpm: Represent source supply through power_supply")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index ca1fc77697fc..03eca5061132 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -389,7 +389,10 @@ struct tcpm_port {
>  	unsigned int operating_snk_mw;
>  	bool update_sink_caps;
>  
> -	/* Requested current / voltage */
> +	/* Requested current / voltage to the port partner */
> +	u32 req_current_limit;
> +	u32 req_supply_voltage;
> +	/* Acutal current / voltage limit of the local port */

Actual

Otherwise makes sense.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>  	u32 current_limit;
>  	u32 supply_voltage;
>  
> @@ -2435,8 +2438,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  		case SNK_TRANSITION_SINK:
>  			if (port->vbus_present) {
>  				tcpm_set_current_limit(port,
> -						       port->current_limit,
> -						       port->supply_voltage);
> +						       port->req_current_limit,
> +						       port->req_supply_voltage);
>  				port->explicit_contract = true;
>  				tcpm_set_auto_vbus_discharge_threshold(port,
>  								       TYPEC_PWR_MODE_PD,
> @@ -2545,8 +2548,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  			break;
>  		case SNK_NEGOTIATE_PPS_CAPABILITIES:
>  			port->pps_data.active = true;
> -			port->supply_voltage = port->pps_data.out_volt;
> -			port->current_limit = port->pps_data.op_curr;
> +			port->req_supply_voltage = port->pps_data.out_volt;
> +			port->req_current_limit = port->pps_data.op_curr;
>  			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
>  			break;
>  		case SOFT_RESET_SEND:
> @@ -3195,8 +3198,8 @@ static int tcpm_pd_build_request(struct tcpm_port *port, u32 *rdo)
>  			 flags & RDO_CAP_MISMATCH ? " [mismatch]" : "");
>  	}
>  
> -	port->current_limit = ma;
> -	port->supply_voltage = mv;
> +	port->req_current_limit = ma;
> +	port->req_supply_voltage = mv;
>  
>  	return 0;
>  }
> 

