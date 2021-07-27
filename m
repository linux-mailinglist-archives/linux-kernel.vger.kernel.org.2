Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC633D8366
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 00:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhG0WrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 18:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhG0Wq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:46:59 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91859C061757;
        Tue, 27 Jul 2021 15:46:58 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id k13so10759377qth.10;
        Tue, 27 Jul 2021 15:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L+/Bp26w3861l4NIDKUpFannir8uPje8Zb17lSzkieI=;
        b=HfKe60KqwmnB17RxqYzT3d7aQtISHqHOUy0GKJSHVicc3Cs06gcSVWAQfs8AsaSG1m
         DGdMYImnLdNH3nZIzumwkiJY/xczXpt2jqO3znu96K+AY+VeXYpouZDnGp+VtWfWOItQ
         LyvStU9yb7MZGm2U7vZuao4jX5VIbto2FZEnrmdnSztGRrTx/Jlyt1fFXkXwjZOtK9wN
         IjzUCMrJ7NPVspvVIprVw5DVWfermEyhcPQCCkjUlI/hIS3/ROtohTD9tliLCTmmQirh
         iLgsE2O8j1omc9855zSf10ugyypyerSSlypgfKD0HbIrKC16cg4C4UAcvhMrX6EifM41
         H4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L+/Bp26w3861l4NIDKUpFannir8uPje8Zb17lSzkieI=;
        b=e00Wwefswu+aREIFv1/GjNZnZ1HAaJQH/i9F0p04QdvDsQbGXrmYYdflh5kWY9NOap
         Z7ClxLvsAl9iCRh1UBeNgAls6V4WHxed7pgK+/p1NvMesDrsXobJQtPuh02AmbtFulvv
         MWzvlfy9m36DChTeeve/bw0oWcoKtPHOaxZJ6XGRa9ZfQpcyvNKDkMuHV1tcdUt8ijZ/
         R5DwkX+SwI5557X55x9LZeGKesT3jnvBaDe+sP0h86svtqTM4fj+8HIcZKKAfR1dDhfQ
         RVD8E2FDYnqKbxIrDbb92FHk++RH3SSa5Mnjl9frSD/fH93byjkGAbXiG8LrKCFANxYT
         BgGA==
X-Gm-Message-State: AOAM531VYX/qotYhUhMQx3YXfZ3mAILjh246ruV6tEwpvhjscPDepAjO
        tlOnTaQhQrRFUOUGQsMFnzPyGuRnmhw=
X-Google-Smtp-Source: ABdhPJz57SCAsmcI0TwWDh9QXZXK018xcBXQhfUHlbxSssVqbFyeD5QInUuyiN2/NnR+reVclopo8w==
X-Received: by 2002:ac8:124d:: with SMTP id g13mr21033612qtj.162.1627426017542;
        Tue, 27 Jul 2021 15:46:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z21sm2044750qti.73.2021.07.27.15.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 15:46:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210727151307.2178352-1-kyletso@google.com>
 <20210727151307.2178352-3-kyletso@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/2] usb: typec: tcpm: Support non-PD mode
Message-ID: <cbc4bdd6-de34-08a8-7968-9d3b0276e347@roeck-us.net>
Date:   Tue, 27 Jul 2021 15:46:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727151307.2178352-3-kyletso@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/21 8:13 AM, Kyle Tso wrote:
> Even if the Type-C controller supports PD, it is doable to disable PD
> capabilities with the current state machine in TCPM. Without enabling RX
> in low-level drivers and with skipping the power negotiation, the port
> is eligible to be a non-PD Type-C port. Use new flags whose values are
> populated from the device tree to decide the port PD capability. Adding
> "pd-supported" property in device tree indicates that the port supports
> PD. If "pd-supported" is not found, "typec-power-opmode" shall be added
> to specify the advertised Rp value if the port supports SRC role.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
> changes since v1:
> - Revised the patch to use dt properties
> - Added back the checks of callbacks set_pd_rx and pd_transmit
> - Added src_rp to indicate which Rp value should be used in SRC. This
>    variable is derived from dt property "typec-power-opmode"
> 
>   drivers/usb/typec/tcpm/tcpm.c | 108 +++++++++++++++++++++++++---------
>   1 file changed, 79 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5b22a1c931a9..4cf77c787f54 100644
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
> @@ -5932,22 +5964,36 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>   		return ret;
>   	port->typec_caps.type = ret;
>   	port->port_type = port->typec_caps.type;
> +	port->pd_supported = fwnode_property_read_bool(fwnode, "pd-supported");
>   

As mentioned in the other patch, I think this needs to be negated.
Not the variable itself, but the meaning of the property.

>   	port->slow_charger_loop = fwnode_property_read_bool(fwnode, "slow-charger-loop");

It might make sense to move the properties needed with !pd_supported to here
and return immediately after they are read. This would reduce the number of
required changes and avoid trying to read irrelevant properties.
Something like

	if (port->port_type != TYPEC_PORT_SRC)
		port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");

	if (!port->pd_supported)
		return 0;

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
> +			return -EINVAL;
> +	} else {
> +		port->nr_src_pdo = 0;
> +		ret = fwnode_property_read_string(fwnode, "typec-power-opmode", &opmode_str);
> +		if (ret == 0) {
> +			ret = typec_find_pwr_opmode(opmode_str);
> +			if (ret < 0)
> +				return ret;
> +			port->src_rp = tcpm_pwr_opmode_to_rp(ret);
> +		} else {
> +			return ret;
> +		}
> +	}
>   
>   	if (port->port_type == TYPEC_PORT_SRC)
>   		return 0;
> @@ -5962,25 +6008,29 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>   		return -EINVAL;
>   sink:
>   	/* Get sink pdos */
> -	ret = fwnode_property_count_u32(fwnode, "sink-pdos");
> -	if (ret <= 0)
> -		return -EINVAL;
> +	if (port->pd_supported) {
> +		ret = fwnode_property_count_u32(fwnode, "sink-pdos");
> +		if (ret <= 0)
> +			return -EINVAL;
>   
> -	port->nr_snk_pdo = min(ret, PDO_MAX_OBJECTS);
> -	ret = fwnode_property_read_u32_array(fwnode, "sink-pdos",
> -					     port->snk_pdo, port->nr_snk_pdo);
> -	if ((ret < 0) || tcpm_validate_caps(port, port->snk_pdo,
> -					    port->nr_snk_pdo))
> -		return -EINVAL;
> +		port->nr_snk_pdo = min(ret, PDO_MAX_OBJECTS);
> +		ret = fwnode_property_read_u32_array(fwnode, "sink-pdos",
> +						     port->snk_pdo, port->nr_snk_pdo);
> +		if ((ret < 0) || tcpm_validate_caps(port, port->snk_pdo,
> +						    port->nr_snk_pdo))
> +			return -EINVAL;
>   
> -	if (fwnode_property_read_u32(fwnode, "op-sink-microwatt", &mw) < 0)
> -		return -EINVAL;
> -	port->operating_snk_mw = mw / 1000;
> +		if (fwnode_property_read_u32(fwnode, "op-sink-microwatt", &mw) < 0)
> +			return -EINVAL;
> +		port->operating_snk_mw = mw / 1000;
> +	} else {
> +		port->nr_snk_pdo = 0;
> +	}
>   
>   	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
>   
> -	/* FRS can only be supported byb DRP ports */
> -	if (port->port_type == TYPEC_PORT_DRP) {
> +	/* FRS can only be supported by DRP ports */
> +	if (port->port_type == TYPEC_PORT_DRP && port->pd_supported) {
>   		ret = fwnode_property_read_u32(fwnode, "new-source-frs-typec-current",
>   					       &frs_current);
>   		if (ret >= 0 && frs_current <= FRS_5V_3A)
> 

