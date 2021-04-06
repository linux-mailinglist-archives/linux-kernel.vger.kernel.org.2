Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72666354AAF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 03:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbhDFB5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 21:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239052AbhDFB5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 21:57:44 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE55C06174A;
        Mon,  5 Apr 2021 18:57:37 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id w70so13570804oie.0;
        Mon, 05 Apr 2021 18:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5gF1a1cG6Op/lwM7Ar4iDeyyidc83Iz+z9lAh5NIhS4=;
        b=IN/eMeAx6YnyULzRpWOIRlmIN5YgzkMV7B0N/ohw0XMXCsopQQFnAhw3z61uOYIQhb
         q9vK9dIuZR5dM99GrLIKKhakZJiibPUlIC7X7zvvRKdm9kZRzZSkYt7R712Yvi74z59F
         Mm8PyQJqXC86zpKYkDlnjxDlXon0qWWoXbIL5OkTM+opZof5EKzJXVgI7toY9IjHToPU
         CUhfQLs3/E9Hjd/0lEr2pHrycvzSh6Ze0+p+k7dVgn6RPMAAVGyufAurY7uZW2ElCSzd
         nw6N7UY1UUHvioAiPiuPb7X/5JSwT5za1c4/sYAeyakXFuxYCbzz+P4LlkvIyM1UkhZ4
         b0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5gF1a1cG6Op/lwM7Ar4iDeyyidc83Iz+z9lAh5NIhS4=;
        b=bksZ094yLi9l8jfgxT+DREeUL3KhMyph1MWIzeCVle1EYktqrWALfJNfLfBiHPg6B0
         F7/FlyZkkzVrx9H+3MyN74pOa4T54lIQ8oZ9eOeTZ9X8xG4O9u+7eS1Wnmw9ylrq7S+4
         szBLYmnO4IpIHmX4/BlF5KZnmEeYD9Wy/+75ayGS763SzTQvbO6TdqOsAJtVWMOWxtLh
         xEEJpkOzuCTmy2Slj6G7BDsVLbQyN0qdQAww9whAQf+ex31ePptI4L2ICemjO3koLeRX
         sN7TfKsjxirYBvvEYKGmqZuJMX7YEHVj88H8D5vpspFG5T74bRkdjky4jKCczcxa3YRG
         ObGw==
X-Gm-Message-State: AOAM5332uey7kqbTi+Ottwej9KITW6S1LwrmS1KqZEVdqp+1SvPGDtFn
        mE+yAhwdx3QLRK3Xxu+nLk0=
X-Google-Smtp-Source: ABdhPJwj/nzYPnq8StP6Ra7snIYkMU1ZqmMwnD1IolpoTGkMtSusSSmkF3t1UHCoNycFbQRHvjzsOg==
X-Received: by 2002:aca:5dd4:: with SMTP id r203mr1543280oib.6.1617674256652;
        Mon, 05 Apr 2021 18:57:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o64sm3411671oif.50.2021.04.05.18.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 18:57:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v1 3/6] usb: typec: tcpm: update power supply once partner
 accepts
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>
References: <20210406013643.3280369-1-badhri@google.com>
 <20210406013643.3280369-4-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <83eeff38-c990-2797-e950-b3466cdd2ff6@roeck-us.net>
Date:   Mon, 5 Apr 2021 18:57:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210406013643.3280369-4-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/21 6:36 PM, Badhri Jagan Sridharan wrote:
> power_supply_changed needs to be called to notify clients
> after the partner accepts the requested values for the pps
> case.
> 
> Fixes: f2a8aa053c176 ("typec: tcpm: Represent source supply through power_supply")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index d43774cc2ccf..7708b01009cb 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2564,6 +2564,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  			port->pps_data.max_curr = port->pps_data.req_max_curr;
>  			port->req_supply_voltage = port->pps_data.req_out_volt;
>  			port->req_current_limit = port->pps_data.req_op_curr;
> +			power_supply_changed(port->psy);
>  			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
>  			break;
>  		case SOFT_RESET_SEND:
> @@ -3132,7 +3133,6 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  						      port->pps_data.req_out_volt));
>  		port->pps_data.req_op_curr = min(port->pps_data.max_curr,
>  						 port->pps_data.req_op_curr);
> -		power_supply_changed(port->psy);
>  	}
>  
>  	return src_pdo;
> @@ -3557,8 +3557,6 @@ static void tcpm_reset_port(struct tcpm_port *port)
>  	port->sink_cap_done = false;
>  	if (port->tcpc->enable_frs)
>  		port->tcpc->enable_frs(port->tcpc, false);
> -
> -	power_supply_changed(port->psy);

The reason for this change is missing in the patch description,
or am I missing something ?

Thanks,
Guenter

>  }
>  
>  static void tcpm_detach(struct tcpm_port *port)
> 

