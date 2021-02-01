Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7140430AA61
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhBAPCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhBAPB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:01:29 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF08C06174A;
        Mon,  1 Feb 2021 06:59:41 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id k8so16516816otr.8;
        Mon, 01 Feb 2021 06:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iivnHI7jVD3pMUiylEz5rdmL/vMZC1gYa5lHcQpzHfU=;
        b=emBsOEoo65k8VpuYrZ9+hU6ZQ+/lolQRXrF6vQXo2ti8aZWNQosfQEwILeJyf6zRWz
         NQzwew24rX5OUXaDe2655FXNfsa4xgYrkvEya0qaLGuROZcR22DHVzaJJQESBSpv3lpH
         rWK23EZIXO6qLVlO+g3jjrUeAAXbFfJWHX6fiY17aadmLY2SlbcliqLQpuyjgH0mg7fk
         7jSKr/+al1YpjvlrTxD2aodLeYlMneudu5AKzRUUj44wlTO2GWK/G8wfhxl4nYkm22ZY
         2YZUihNnk7fgNRPaqk5h/40mxxU5pvDay9JrjSQcMacNOtMe+TjeayNBJipQU6RjXzUq
         U30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iivnHI7jVD3pMUiylEz5rdmL/vMZC1gYa5lHcQpzHfU=;
        b=itY8wZqfhSQIX/mb+sO77Te6gS0hIRoq5wBERLmGHsKbjuoOPY6HoCC6EZK7OknfUz
         MwSeL5yqf7TbuuHcKGW3piRGM37rWiOX7QNb79B4CyVF28L0UBv/RvDXcYQWsUd3pSsf
         71PSX18MiAethGaNLOF8GsEZdREZr6cuISzrt2DwtAJcP1yHRFo3OuYonIShupSGMnea
         j85FfZNQVjqO3vejKpu9/lWwUJ3vOaf0yxIiv9MJiMhoWax9YD6MV5aVCV3QgE3F/xPE
         6K5Gi3bKNs+0GHtQz78Apr91U+qAK0lMODNCKtZR1MAHwf3VmmzVqTrLiJ0puK+xyJhm
         Q90w==
X-Gm-Message-State: AOAM533yethiGqOka4nQeQkGQcLZjfjreJJTM7RDefTy12ABdR+3Iqdn
        fsUeW2q0ZPlC+qthLCMRtSzzZMfclFk=
X-Google-Smtp-Source: ABdhPJxwDqwDzH9B8FkCA3WExgb4S8fv8XUtNELvU7SXTsP1ITHuIzYSENxxh0Bk0IdgzgKhDqOifQ==
X-Received: by 2002:a9d:6a07:: with SMTP id g7mr11662636otn.285.1612191579779;
        Mon, 01 Feb 2021 06:59:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l11sm3947040otf.59.2021.02.01.06.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 06:59:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v1 1/3] usb: typec: tcpm: Add Callback to Usb
 Communication capable partner
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210201095309.39486-1-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <ce97202a-5e94-6abe-d7f2-0e8c50b18eef@roeck-us.net>
Date:   Mon, 1 Feb 2021 06:59:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201095309.39486-1-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 1:53 AM, Badhri Jagan Sridharan wrote:
> The USB Communications Capable bit indicates if port
> partner is capable of communication over the USB data lines
> (e.g. D+/- or SS Tx/Rx). Notify the status of the bit to low
> level drivers to perform chip specific operation.
> For instance, low level driver enables USB switches on D+/D-
> lines to set up data path when the bit is set.
> 
> Refactored from patch initially authored by
> Kyle Tso <kyletso@google.com>
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 16 ++++++++++++++++
>  include/linux/usb/tcpm.h      |  5 +++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 0afd8ef692e8..96190b4d46a7 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -298,6 +298,7 @@ struct tcpm_port {
>  	struct usb_pd_identity partner_ident;
>  	struct typec_partner_desc partner_desc;
>  	struct typec_partner *partner;
> +	bool partner_usb_comm_capable;
>  
>  	enum typec_cc_status cc_req;
>  
> @@ -3429,6 +3430,16 @@ static void tcpm_unregister_altmodes(struct tcpm_port *port)
>  	memset(modep, 0, sizeof(*modep));
>  }
>  
> +static void tcpm_set_partner_usb_comm_capable(struct tcpm_port *port, bool capable)
> +{
> +	tcpm_log(port, "Setting usb_comm capable %s", capable ? "true" : "false");
> +
> +	if (port->tcpc->set_partner_usb_comm_capable)
> +		port->tcpc->set_partner_usb_comm_capable(port->tcpc, capable);
> +
> +	port->partner_usb_comm_capable = capable;
> +}
> +
>  static void tcpm_reset_port(struct tcpm_port *port)
>  {
>  	int ret;
> @@ -3445,6 +3456,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
>  	port->attached = false;
>  	port->pd_capable = false;
>  	port->pps_data.supported = false;
> +	tcpm_set_partner_usb_comm_capable(port, false);
>  
>  	/*
>  	 * First Rx ID should be 0; set this to a sentinel of -1 so that
> @@ -3785,6 +3797,8 @@ static void run_state_machine(struct tcpm_port *port)
>  			}
>  		} else {
>  			tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
> +			port->partner_usb_comm_capable = port->sink_request & RDO_USB_COMM;

That seems to be redundant since tcpm_set_partner_usb_comm_capable() is setting it again.

> +			tcpm_set_partner_usb_comm_capable(port, port->partner_usb_comm_capable);
>  			tcpm_set_state(port, SRC_TRANSITION_SUPPLY,
>  				       PD_T_SRC_TRANSITION);
>  		}
> @@ -4004,6 +4018,8 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case SNK_NEGOTIATE_CAPABILITIES:
>  		port->pd_capable = true;
> +		port->partner_usb_comm_capable = port->sink_request & RDO_USB_COMM;

Same here. But then I don't really see where this variable is actually used.
Am I missing something ?

Thanks,
Guenter

> +		tcpm_set_partner_usb_comm_capable(port, port->partner_usb_comm_capable);
>  		port->hard_reset_count = 0;
>  		ret = tcpm_pd_send_request(port);
>  		if (ret < 0) {
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index 3af99f85e8b9..42fcfbe10590 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -108,6 +108,10 @@ enum tcpm_transmit_type {
>   *		is supported by TCPC, set this callback for TCPM to query
>   *		whether vbus is at VSAFE0V when needed.
>   *		Returns true when vbus is at VSAFE0V, false otherwise.
> + * @set_partner_usb_comm_capable:
> + *              Optional; The USB Communications Capable bit indicates if port
> + *              partner is capable of communication over the USB data lines
> + *              (e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
>   */
>  struct tcpc_dev {
>  	struct fwnode_handle *fwnode;
> @@ -139,6 +143,7 @@ struct tcpc_dev {
>  	int (*set_auto_vbus_discharge_threshold)(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
>  						 bool pps_active, u32 requested_vbus_voltage);
>  	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
> +	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
>  };
>  
>  struct tcpm_port;
> 

