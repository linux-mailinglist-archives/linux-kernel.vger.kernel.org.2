Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C43D35AA38
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 04:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhDJCKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 22:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDJCKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 22:10:21 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D79C061762;
        Fri,  9 Apr 2021 19:10:07 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so7523028otk.5;
        Fri, 09 Apr 2021 19:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n0PeL3oxq1U6pqMn4hBWtwVfWbZfrZhGsRYee6larQE=;
        b=Y90TOsXAvuLRqPXNyUeVkzBDAjHALucU5Z4+cyzLDWMyQNWe5UaOhAMzyjyqxVMDBo
         Q0lUz7upOpsOT3E/nNsO7C/m6H1nmwC+agK6XsKRW2ilz5Uy+lC+YsjEHtDZtF2PWaK+
         j9X9D6ac2BxYBKk8R3LHNeIIefBR5wfQx4zTYhS4n6eP/UYytfJhrA83Z07oeFsBktUc
         9vJBxd+K4y/+UeyQIyAKGP1EVXW46GgBxHj7aEsC25qNMZq5BM+shqDCgwQ+Ge2hpILZ
         ue5W2dpoWzu5ivS2Nkozn2hL1rRQKk78Hie/A/mLhDW38Q1cvGrLjO3Z1bBLXo/RlfTf
         k2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=n0PeL3oxq1U6pqMn4hBWtwVfWbZfrZhGsRYee6larQE=;
        b=sbgbfL3hDwGA9cXBHjb7AJWJ6s5iFibkZgv/UHQvAv6CfA/GVoekpQWl8w5p8dq56l
         F3Wv3TOFxqSM5CAgBRo3kTGmTXLkmbSyGUeiGNtsTIVvpi6HlDUjpKJCL4JUAFbySAeh
         Ib5ovPlybnQ5Po+VtKhO7PCEzHedV5djbomSvdhxmbqDoh5Edpl1B65lS6s1EV0KnNea
         /1kVL3P1HJxhn0EsqjYl1Dxo4KApxn6t6BEMY3dwkWiM7l6HP4/ZCW+n1RPjg+CmQ93V
         MSFmbf0SLfsoULiagc3avJ2xYMYm4844/brY7y1nRG9I5fAgEPMJRwcuQUoyQOplf7Qy
         MZzw==
X-Gm-Message-State: AOAM5333tMV2AZE/EyS1Oc2yqwWrk2sidBC5o93big9hXAObOSw1yx46
        wgmpqiESVT7KbeTRi1O1CrlDVuSKZjA=
X-Google-Smtp-Source: ABdhPJyBpO89qR6CEStGq/A4kch8QEvMCjSScep/lRSDYzU0vd+Ldq/RmDItbwdViMxrveXsq98grw==
X-Received: by 2002:a9d:75c9:: with SMTP id c9mr1708219otl.235.1618020606623;
        Fri, 09 Apr 2021 19:10:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l81sm893412oif.31.2021.04.09.19.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 19:10:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 2/6] usb: typec: tcpm: Address incorrect values of tcpm
 psy for pps supply
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>
References: <20210407200723.1914388-1-badhri@google.com>
 <20210407200723.1914388-2-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <18399115-5897-2c53-f8e5-6cdbd63a9658@roeck-us.net>
Date:   Fri, 9 Apr 2021 19:10:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210407200723.1914388-2-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/21 1:07 PM, Badhri Jagan Sridharan wrote:
> tcpm_pd_select_pps_apdo overwrites port->pps_data.min_volt,
> port->pps_data.max_volt, port->pps_data.max_curr even before
> port partner accepts the requests. This leaves incorrect values
> in current_limit and supply_voltage that get exported by
> "tcpm-source-psy-". Solving this problem by caching the request
> values in req_min_volt, req_max_volt, req_max_curr, req_out_volt,
> req_op_curr. min_volt, max_volt, max_curr gets updated once the
> partner accepts the request. current_limit, supply_voltage gets updated
> once local port's tcpm enters SNK_TRANSITION_SINK when the accepted
> current_limit and supply_voltage is enforced.
> 
> Fixes: f2a8aa053c176 ("typec: tcpm: Represent source supply through power_supply")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since V1:
> * Moved to kerneldoc header as suggested by Greg KH.
> * Added reviewed by tags.
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 88 +++++++++++++++++++++--------------
>  1 file changed, 53 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 4ea4b30ae885..b4a40099d7e9 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -268,12 +268,27 @@ struct pd_mode_data {
>  	struct typec_altmode_desc altmode_desc[ALTMODE_DISCOVERY_MAX];
>  };
>  
> +/*
> + * @min_volt: Actual min voltage at the local port
> + * @req_min_volt: Requested min voltage to the port partner
> + * @max_volt: Actual max voltage at the local port
> + * @req_max_volt: Requested max voltage to the port partner
> + * @max_curr: Actual max current at the local port
> + * @req_max_curr: Requested max current of the port partner
> + * @req_out_volt: Requested output voltage to the port partner
> + * @req_op_curr: Requested operating current to the port partner
> + * @supported: Parter has atleast one APDO hence supports PPS
> + * @active: PPS mode is active
> + */
>  struct pd_pps_data {
>  	u32 min_volt;
> +	u32 req_min_volt;
>  	u32 max_volt;
> +	u32 req_max_volt;
>  	u32 max_curr;
> -	u32 out_volt;
> -	u32 op_curr;
> +	u32 req_max_curr;
> +	u32 req_out_volt;
> +	u32 req_op_curr;
>  	bool supported;
>  	bool active;
>  };
> @@ -2498,8 +2513,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  			break;
>  		case SNK_NEGOTIATE_PPS_CAPABILITIES:
>  			/* Revert data back from any requested PPS updates */
> -			port->pps_data.out_volt = port->supply_voltage;
> -			port->pps_data.op_curr = port->current_limit;
> +			port->pps_data.req_out_volt = port->supply_voltage;
> +			port->pps_data.req_op_curr = port->current_limit;
>  			port->pps_status = (type == PD_CTRL_WAIT ?
>  					    -EAGAIN : -EOPNOTSUPP);
>  
> @@ -2548,8 +2563,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  			break;
>  		case SNK_NEGOTIATE_PPS_CAPABILITIES:
>  			port->pps_data.active = true;
> -			port->req_supply_voltage = port->pps_data.out_volt;
> -			port->req_current_limit = port->pps_data.op_curr;
> +			port->pps_data.min_volt = port->pps_data.req_min_volt;
> +			port->pps_data.max_volt = port->pps_data.req_max_volt;
> +			port->pps_data.max_curr = port->pps_data.req_max_curr;
> +			port->req_supply_voltage = port->pps_data.req_out_volt;
> +			port->req_current_limit = port->pps_data.req_op_curr;
>  			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
>  			break;
>  		case SOFT_RESET_SEND:
> @@ -3108,16 +3126,16 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  		src = port->source_caps[src_pdo];
>  		snk = port->snk_pdo[snk_pdo];
>  
> -		port->pps_data.min_volt = max(pdo_pps_apdo_min_voltage(src),
> -					      pdo_pps_apdo_min_voltage(snk));
> -		port->pps_data.max_volt = min(pdo_pps_apdo_max_voltage(src),
> -					      pdo_pps_apdo_max_voltage(snk));
> -		port->pps_data.max_curr = min_pps_apdo_current(src, snk);
> -		port->pps_data.out_volt = min(port->pps_data.max_volt,
> -					      max(port->pps_data.min_volt,
> -						  port->pps_data.out_volt));
> -		port->pps_data.op_curr = min(port->pps_data.max_curr,
> -					     port->pps_data.op_curr);
> +		port->pps_data.req_min_volt = max(pdo_pps_apdo_min_voltage(src),
> +						  pdo_pps_apdo_min_voltage(snk));
> +		port->pps_data.req_max_volt = min(pdo_pps_apdo_max_voltage(src),
> +						  pdo_pps_apdo_max_voltage(snk));
> +		port->pps_data.req_max_curr = min_pps_apdo_current(src, snk);
> +		port->pps_data.req_out_volt = min(port->pps_data.max_volt,
> +						  max(port->pps_data.min_volt,
> +						      port->pps_data.req_out_volt));
> +		port->pps_data.req_op_curr = min(port->pps_data.max_curr,
> +						 port->pps_data.req_op_curr);
>  		power_supply_changed(port->psy);
>  	}
>  
> @@ -3245,10 +3263,10 @@ static int tcpm_pd_build_pps_request(struct tcpm_port *port, u32 *rdo)
>  			tcpm_log(port, "Invalid APDO selected!");
>  			return -EINVAL;
>  		}
> -		max_mv = port->pps_data.max_volt;
> -		max_ma = port->pps_data.max_curr;
> -		out_mv = port->pps_data.out_volt;
> -		op_ma = port->pps_data.op_curr;
> +		max_mv = port->pps_data.req_max_volt;
> +		max_ma = port->pps_data.req_max_curr;
> +		out_mv = port->pps_data.req_out_volt;
> +		op_ma = port->pps_data.req_op_curr;
>  		break;
>  	default:
>  		tcpm_log(port, "Invalid PDO selected!");
> @@ -3295,8 +3313,8 @@ static int tcpm_pd_build_pps_request(struct tcpm_port *port, u32 *rdo)
>  	tcpm_log(port, "Requesting APDO %d: %u mV, %u mA",
>  		 src_pdo_index, out_mv, op_ma);
>  
> -	port->pps_data.op_curr = op_ma;
> -	port->pps_data.out_volt = out_mv;
> +	port->pps_data.req_op_curr = op_ma;
> +	port->pps_data.req_out_volt = out_mv;
>  
>  	return 0;
>  }
> @@ -5429,7 +5447,7 @@ static int tcpm_try_role(struct typec_port *p, int role)
>  	return ret;
>  }
>  
> -static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
> +static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 req_op_curr)
>  {
>  	unsigned int target_mw;
>  	int ret;
> @@ -5447,12 +5465,12 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
>  		goto port_unlock;
>  	}
>  
> -	if (op_curr > port->pps_data.max_curr) {
> +	if (req_op_curr > port->pps_data.max_curr) {
>  		ret = -EINVAL;
>  		goto port_unlock;
>  	}
>  
> -	target_mw = (op_curr * port->pps_data.out_volt) / 1000;
> +	target_mw = (req_op_curr * port->supply_voltage) / 1000;
>  	if (target_mw < port->operating_snk_mw) {
>  		ret = -EINVAL;
>  		goto port_unlock;
> @@ -5466,10 +5484,10 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
>  	}
>  
>  	/* Round down operating current to align with PPS valid steps */
> -	op_curr = op_curr - (op_curr % RDO_PROG_CURR_MA_STEP);
> +	req_op_curr = req_op_curr - (req_op_curr % RDO_PROG_CURR_MA_STEP);
>  
>  	reinit_completion(&port->pps_complete);
> -	port->pps_data.op_curr = op_curr;
> +	port->pps_data.req_op_curr = req_op_curr;
>  	port->pps_status = 0;
>  	port->pps_pending = true;
>  	mutex_unlock(&port->lock);
> @@ -5490,7 +5508,7 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
>  	return ret;
>  }
>  
> -static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
> +static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 req_out_volt)
>  {
>  	unsigned int target_mw;
>  	int ret;
> @@ -5508,13 +5526,13 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
>  		goto port_unlock;
>  	}
>  
> -	if (out_volt < port->pps_data.min_volt ||
> -	    out_volt > port->pps_data.max_volt) {
> +	if (req_out_volt < port->pps_data.min_volt ||
> +	    req_out_volt > port->pps_data.max_volt) {
>  		ret = -EINVAL;
>  		goto port_unlock;
>  	}
>  
> -	target_mw = (port->pps_data.op_curr * out_volt) / 1000;
> +	target_mw = (port->current_limit * req_out_volt) / 1000;
>  	if (target_mw < port->operating_snk_mw) {
>  		ret = -EINVAL;
>  		goto port_unlock;
> @@ -5528,10 +5546,10 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
>  	}
>  
>  	/* Round down output voltage to align with PPS valid steps */
> -	out_volt = out_volt - (out_volt % RDO_PROG_VOLT_MV_STEP);
> +	req_out_volt = req_out_volt - (req_out_volt % RDO_PROG_VOLT_MV_STEP);
>  
>  	reinit_completion(&port->pps_complete);
> -	port->pps_data.out_volt = out_volt;
> +	port->pps_data.req_out_volt = req_out_volt;
>  	port->pps_status = 0;
>  	port->pps_pending = true;
>  	mutex_unlock(&port->lock);
> @@ -5589,8 +5607,8 @@ static int tcpm_pps_activate(struct tcpm_port *port, bool activate)
>  
>  	/* Trigger PPS request or move back to standard PDO contract */
>  	if (activate) {
> -		port->pps_data.out_volt = port->supply_voltage;
> -		port->pps_data.op_curr = port->current_limit;
> +		port->pps_data.req_out_volt = port->supply_voltage;
> +		port->pps_data.req_op_curr = port->current_limit;
>  	}
>  	mutex_unlock(&port->lock);
>  
> 

