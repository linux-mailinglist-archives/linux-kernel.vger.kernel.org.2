Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48BB3D90AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbhG1Obh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237768AbhG1ObS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:31:18 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EFEC061757;
        Wed, 28 Jul 2021 07:31:17 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id t66so2430258qkb.0;
        Wed, 28 Jul 2021 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OIT9wiYfRoogamrg1PzE3Z+TJ72/Ixxk1vDz3bswdc8=;
        b=YQQm3KH19/yI/CDLfvuWq71i1fb5qvnbxEKehPBdMHl/lnVV2IF+h6g43oF536gR3/
         pX1VaVd8klpVHXC7CZEd+x4DkJONkJULeXIF7grcjic0mU4qpK+2Qg7OpRuJT58zzBFH
         ue8+NbDZjJxyzNNGp1qf4nVEQWX/QYSNwsO/8i0Z3ERn+jWpEAsH16B4Jc+jPHX1BDzt
         et9/39zaLUJJLtW2oT6yvmEO1XtF882p8rn+Ep6Q7MLR3b1LjfJf8V29nnH053/DxeY4
         dDqW08RmVyH1c34jqMdKMH4tor5v6cWz1XmuAOT1QgHZtsT9WPHrmhsmkln0ZYTNBaRQ
         Ybbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OIT9wiYfRoogamrg1PzE3Z+TJ72/Ixxk1vDz3bswdc8=;
        b=SpW+0Bgl1m84TiouAVk4gjoZVxujG+k76oyAqivAwL6B2Ub3fLSjWpR03/LsvgYm82
         hu0dRI9MY1YIJBvILn7HvxG33jWHpDJ6Vewmc8TF2v/9k2ic5hxiiFLvR4WUgVwO/NsV
         N/WKsS3qCmRcGClPuZ/6JfezkZoJdgWhsoWQjZDHudT20hWdYeczDavjUnLXw33sMxe/
         SrkwgYH52zgDLEK87wgEkPkMEzHD1+0CVGN2oco1YGswLj2xe/Ctju+PS52J7c+3hqfQ
         mMiC40ja0mUVBuUU1eIFK08sGGENQ8gxKLqBdGIs5AU6H7IwNqUv0jezEfsdVXHdxLnl
         JWqg==
X-Gm-Message-State: AOAM532otmzh6+czJLNCBo0VEgJAFgQs21ZfCxEXYXrvRc2bGo+lMIS7
        CyPflwJFmYHAtXi7Du6gFLilt/0tIYQ=
X-Google-Smtp-Source: ABdhPJywG2WGGNIe2WrX++bXEMak6Y98dS1qxsE3PTtQKrjyNx8e9TS4ehSvsYp1l8AwO1sihsfBeg==
X-Received: by 2002:a37:9401:: with SMTP id w1mr27266623qkd.166.1627482676011;
        Wed, 28 Jul 2021 07:31:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k10sm5903qtp.76.2021.07.28.07.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 07:31:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210728092930.2552619-1-kyletso@google.com>
 <20210728092930.2552619-3-kyletso@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/2] usb: typec: tcpm: Support non-PD mode
Message-ID: <346bf811-52d1-cd27-649b-7cd1b9b2fbc6@roeck-us.net>
Date:   Wed, 28 Jul 2021 07:31:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728092930.2552619-3-kyletso@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/21 2:29 AM, Kyle Tso wrote:
> Even if the Type-C controller supports PD, it is doable to disable PD
> capabilities with the current state machine in TCPM. Without enabling RX
> in low-level drivers and with skipping the power negotiation, the port
> is eligible to be a non-PD Type-C port. Use new flags whose values are
> populated from the device tree to decide the port PD capability. Adding
> "pd-unsupported" property in device tree indicates that the port does
> not support PD. If "pd-unsupported" is not found, "typec-power-opmode"

"is not found" -> "is found" (based on previous revision)

I think "If PD is not supported, ..." might be a better wording and
avoid the use of a property name here.

> shall be added to specify the advertised Rp value if the port supports
> SRC role.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
> changes since v2:
> - Changed the control flow if the port is SNK or DRP. Return directly if
>    the flag is false (PD not supported). Read "self-powered" before that.
> 
>   drivers/usb/typec/tcpm/tcpm.c | 88 ++++++++++++++++++++++++++++-------
>   1 file changed, 70 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5b22a1c931a9..d8d6ef8c6282 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -316,6 +316,7 @@ struct tcpm_port {
>   	struct typec_partner *partner;
>   
>   	enum typec_cc_status cc_req;
> +	enum typec_cc_status src_rp;	/* work only if pd_supported == false */
>   
>   	enum typec_cc_status cc1;
>   	enum typec_cc_status cc2;
> @@ -323,6 +324,7 @@ struct tcpm_port {
>   
>   	bool attached;
>   	bool connected;
> +	bool pd_supported;
>   	enum typec_port_type port_type;
>   
>   	/*
> @@ -804,6 +806,7 @@ static void tcpm_apply_rc(struct tcpm_port *port)
>   	}
>   }
>   
> +

stray empty line

>   /*
>    * Determine RP value to set based on maximum current supported
>    * by a port if configured as source.
> @@ -815,6 +818,9 @@ static enum typec_cc_status tcpm_rp_cc(struct tcpm_port *port)
>   	int nr_pdo = port->nr_src_pdo;
>   	int i;
>   
> +	if (!port->pd_supported)
> +		return port->src_rp;
> +
>   	/*
>   	 * Search for first entry with matching voltage.
>   	 * It should report the maximum supported current.
> @@ -3568,9 +3574,11 @@ static int tcpm_src_attach(struct tcpm_port *port)
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = port->tcpc->set_pd_rx(port->tcpc, true);
> -	if (ret < 0)
> -		goto out_disable_mux;
> +	if (port->pd_supported) {
> +		ret = port->tcpc->set_pd_rx(port->tcpc, true);
> +		if (ret < 0)
> +			goto out_disable_mux;
> +	}
>   
>   	/*
>   	 * USB Type-C specification, version 1.2,
> @@ -3600,7 +3608,8 @@ static int tcpm_src_attach(struct tcpm_port *port)
>   out_disable_vconn:
>   	tcpm_set_vconn(port, false);
>   out_disable_pd:
> -	port->tcpc->set_pd_rx(port->tcpc, false);
> +	if (port->pd_supported)
> +		port->tcpc->set_pd_rx(port->tcpc, false);
>   out_disable_mux:
>   	tcpm_mux_set(port, TYPEC_STATE_SAFE, USB_ROLE_NONE,
>   		     TYPEC_ORIENTATION_NONE);
> @@ -3804,6 +3813,20 @@ static enum typec_pwr_opmode tcpm_get_pwr_opmode(enum typec_cc_status cc)
>   	}
>   }
>   
> +static enum typec_cc_status tcpm_pwr_opmode_to_rp(enum typec_pwr_opmode opmode)
> +{
> +	switch (opmode) {
> +	case TYPEC_PWR_MODE_USB:
> +		return TYPEC_CC_RP_DEF;
> +	case TYPEC_PWR_MODE_1_5A:
> +		return TYPEC_CC_RP_1_5;
> +	case TYPEC_PWR_MODE_3_0A:
> +	case TYPEC_PWR_MODE_PD:
> +	default:
> +		return TYPEC_CC_RP_3_0;
> +	}
> +}
> +
>   static void run_state_machine(struct tcpm_port *port)
>   {
>   	int ret;
> @@ -3914,6 +3937,10 @@ static void run_state_machine(struct tcpm_port *port)
>   		if (port->ams == POWER_ROLE_SWAP ||
>   		    port->ams == FAST_ROLE_SWAP)
>   			tcpm_ams_finish(port);
> +		if (!port->pd_supported) {
> +			tcpm_set_state(port, SRC_READY, 0);
> +			break;
> +		}
>   		port->upcoming_state = SRC_SEND_CAPABILITIES;
>   		tcpm_ams_start(port, POWER_NEGOTIATION);
>   		break;
> @@ -4161,7 +4188,10 @@ static void run_state_machine(struct tcpm_port *port)
>   				current_lim = PD_P_SNK_STDBY_MW / 5;
>   			tcpm_set_current_limit(port, current_lim, 5000);
>   			tcpm_set_charge(port, true);
> -			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
> +			if (!port->pd_supported)
> +				tcpm_set_state(port, SNK_READY, 0);
> +			else
> +				tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
>   			break;
>   		}
>   		/*
> @@ -4389,7 +4419,8 @@ static void run_state_machine(struct tcpm_port *port)
>   		tcpm_set_vbus(port, true);
>   		if (port->ams == HARD_RESET)
>   			tcpm_ams_finish(port);
> -		port->tcpc->set_pd_rx(port->tcpc, true);
> +		if (port->pd_supported)
> +			port->tcpc->set_pd_rx(port->tcpc, true);
>   		tcpm_set_attached_state(port, true);
>   		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
>   		break;
> @@ -5898,6 +5929,7 @@ EXPORT_SYMBOL_GPL(tcpm_tcpc_reset);
>   static int tcpm_fw_get_caps(struct tcpm_port *port,
>   			    struct fwnode_handle *fwnode)
>   {
> +	const char *opmode_str;
>   	const char *cap_str;
>   	int ret;
>   	u32 mw, frs_current;
> @@ -5932,22 +5964,37 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>   		return ret;
>   	port->typec_caps.type = ret;
>   	port->port_type = port->typec_caps.type;
> +	port->pd_supported = !fwnode_property_read_bool(fwnode, "pd-unsupported");
>   
>   	port->slow_charger_loop = fwnode_property_read_bool(fwnode, "slow-charger-loop");
> +

Unnecessary whitespace change

>   	if (port->port_type == TYPEC_PORT_SNK)
>   		goto sink;
>   
>   	/* Get source pdos */
> -	ret = fwnode_property_count_u32(fwnode, "source-pdos");
> -	if (ret <= 0)
> -		return -EINVAL;
> +	if (port->pd_supported) {
> +		ret = fwnode_property_count_u32(fwnode, "source-pdos");
> +		if (ret <= 0)
> +			return -EINVAL;
>   
> -	port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
> -	ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
> -					     port->src_pdo, port->nr_src_pdo);
> -	if ((ret < 0) || tcpm_validate_caps(port, port->src_pdo,
> -					    port->nr_src_pdo))
> -		return -EINVAL;
> +		port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
> +		ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
> +						     port->src_pdo, port->nr_src_pdo);
> +		if ((ret < 0) || tcpm_validate_caps(port, port->src_pdo,
> +						    port->nr_src_pdo))

Since we are changing this code, might as well get rid of the unnecessary ()
around 'ret < 0'. Or, even better,

		if (ret)
			return ret;
		ret = tcpm_validate_caps(port, port->src_pdo, port->nr_src_pdo);
		if (ret)
			return ret;

because that avoids overwriting the error return code from
fwnode_property_read_u32_array().

> +			return -EINVAL;
> +	} else {
> +		port->nr_src_pdo = 0;

That should be unnecessary.

> +		ret = fwnode_property_read_string(fwnode, "typec-power-opmode", &opmode_str);
> +		if (ret == 0) {
> +			ret = typec_find_pwr_opmode(opmode_str);
> +			if (ret < 0)
> +				return ret;
> +			port->src_rp = tcpm_pwr_opmode_to_rp(ret);
> +		} else {
> +			return ret;
> +		}

I prefer 'normal' error handling.
		if (ret)
			return ret;
		ret = typec_find_pwr_opmode(opmode_str);
		...

> +	}
>   
>   	if (port->port_type == TYPEC_PORT_SRC)
>   		return 0;
> @@ -5961,6 +6008,13 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>   	if (port->typec_caps.prefer_role < 0)
>   		return -EINVAL;
>   sink:
> +	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
> +
> +	if (!port->pd_supported) {
> +		port->nr_snk_pdo = 0;

Should be unnecessary.

> +		return 0;
> +	}
> +
>   	/* Get sink pdos */
>   	ret = fwnode_property_count_u32(fwnode, "sink-pdos");
>   	if (ret <= 0)
> @@ -5977,9 +6031,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>   		return -EINVAL;
>   	port->operating_snk_mw = mw / 1000;
>   
> -	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
> -
> -	/* FRS can only be supported byb DRP ports */
> +	/* FRS can only be supported by DRP ports */
>   	if (port->port_type == TYPEC_PORT_DRP) {
>   		ret = fwnode_property_read_u32(fwnode, "new-source-frs-typec-current",
>   					       &frs_current);
> 

