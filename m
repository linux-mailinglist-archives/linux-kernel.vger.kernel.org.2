Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A4E30C5BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbhBBQ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbhBBQZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:25:44 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACBCC061573;
        Tue,  2 Feb 2021 08:25:03 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id f6so20326864ots.9;
        Tue, 02 Feb 2021 08:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2mfiyle2/q/MwjfOmnbyM806qE9V2e89I7MJjXat1m8=;
        b=n26PWLAf0nXVvTCrWvIYxTeDC8/n7JX5qrwFUJ7Y3LL1gtRB75+RxKhXsFhlH+ez2j
         n8xHgnAmCBtY6vPmJCPUD+BEZfAclAMhCLNPmLGkOqRjWuWqJBNKYAb/UR7QyT9D53vy
         tuznzPxST71V7+U5EBxOnOw5cy45SPIE9H5ihpGPxQmADyZXItWT/G6IISKjQa+9vx34
         XqjzrWLD6MmDH6iBF7CQ8TyPvr/WZb0enOZmUIKtjqvuJAMP8eeXpJkeP5e4v2O16Q6j
         aNMGuKXWAawC1e6t9BetZu7Kfw1h7zT/PJj7W5DVLvHvzRbeao492tCINrXMURGy/XCY
         MlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2mfiyle2/q/MwjfOmnbyM806qE9V2e89I7MJjXat1m8=;
        b=WBm+hXx+CK/oCvYb6dIcWreZp1PhMnh1Ohi7pj7x9Pe03qriqXg99dh5OpR9Yef5Yr
         3ySPD79JC194GvboPR+59HEB6swvg1RByFujPT5jIKXR+aJE6/0hWXYgq8edQzaTUvPj
         RFCbIPbWQrSsnJmXf1WzUJ2E3021WUnuBs4iU9ddhZttCHhBl/E2Ed7wwSP1V1/TsnQC
         q7BTAba8S08Ff9uYY9Xj8FITpyX98FCSe5BBQS6QwpPXWm/Sb2Apuq1+ZvyBpEsD+tvw
         YjlbfsciM508N+JmOhGiSbgOnkap6hzVx4JPeJfuQg5q7jjn3bowt4zpDjBHAfAd7TJX
         f1BA==
X-Gm-Message-State: AOAM532PJ4BIqqQ/cRntSh2qo4AVsCtqJ3gKVGPnggqcd2Bn/bh7uMuL
        HoOvzZG0JCJ8PzVuMoeEOkCI6+U51PI=
X-Google-Smtp-Source: ABdhPJyJF1LQ/97vcyZnA9beG2oyQZJfcPF2D6J0PFv7pbsaXsNwQUe2UYW33uI6zKqJXJuwFYjL/w==
X-Received: by 2002:a9d:2da2:: with SMTP id g31mr15784508otb.222.1612283103016;
        Tue, 02 Feb 2021 08:25:03 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t62sm4837414oif.2.2021.02.02.08.25.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Feb 2021 08:25:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 2 Feb 2021 08:25:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: typec: tcpm: Add Callback to Usb
 Communication capable partner
Message-ID: <20210202162500.GA159455@roeck-us.net>
References: <20210202003101.221145-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202003101.221145-1-badhri@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 04:30:59PM -0800, Badhri Jagan Sridharan wrote:
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since V1:
> - Removed partner_usb_comm_capable flag.
> - Fixed capable flag for SNK_NEGOTIATE_CAPABILITIES.
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 13 +++++++++++++
>  include/linux/usb/tcpm.h      |  5 +++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 0afd8ef692e8..997a1a56c161 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3429,6 +3429,14 @@ static void tcpm_unregister_altmodes(struct tcpm_port *port)
>  	memset(modep, 0, sizeof(*modep));
>  }
>  
> +static void tcpm_set_partner_usb_comm_capable(struct tcpm_port *port, bool capable)
> +{
> +	tcpm_log(port, "Setting usb_comm capable %s", capable ? "true" : "false");
> +
> +	if (port->tcpc->set_partner_usb_comm_capable)
> +		port->tcpc->set_partner_usb_comm_capable(port->tcpc, capable);
> +}
> +
>  static void tcpm_reset_port(struct tcpm_port *port)
>  {
>  	int ret;
> @@ -3445,6 +3453,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
>  	port->attached = false;
>  	port->pd_capable = false;
>  	port->pps_data.supported = false;
> +	tcpm_set_partner_usb_comm_capable(port, false);
>  
>  	/*
>  	 * First Rx ID should be 0; set this to a sentinel of -1 so that
> @@ -3785,6 +3794,8 @@ static void run_state_machine(struct tcpm_port *port)
>  			}
>  		} else {
>  			tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
> +			tcpm_set_partner_usb_comm_capable(port,
> +							  !!(port->sink_request & RDO_USB_COMM));
>  			tcpm_set_state(port, SRC_TRANSITION_SUPPLY,
>  				       PD_T_SRC_TRANSITION);
>  		}
> @@ -4004,6 +4015,8 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case SNK_NEGOTIATE_CAPABILITIES:
>  		port->pd_capable = true;
> +		tcpm_set_partner_usb_comm_capable(port,
> +						  !!(port->source_caps[0] & PDO_FIXED_USB_COMM));
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
> -- 
> 2.30.0.365.g02bc693789-goog
> 
