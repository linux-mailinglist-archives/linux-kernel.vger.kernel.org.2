Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540AC372D4C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhEDPwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhEDPwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:52:32 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E6FC061761;
        Tue,  4 May 2021 08:51:36 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id i20-20020a4a8d940000b02901bc71746525so2110881ook.2;
        Tue, 04 May 2021 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CzWS2ajG+cat2efjjOS9a3uGpogg36np3g5VuBCIG5w=;
        b=FV+dQ1Yt7/3SW/D/ZMOtkzDMhwj4oO0MFhAKxwjvRP69qk6JBwkroA8UT9Lngl4x8j
         SA3A7sNz9uxY4b/sMKILl/VHaH8NGs9S+7oZbkUze9+RIWRjvLylhPg2vZNJlIxY7gaN
         yhrEkmF9Y7N3J4TO8adJhM09krNdVe/O3MBPuKxQ8erHiaF5lrX1WgVlF74BuVTBOtwf
         UUrFcfhkHOvZPxQfzxcTzYbdem4nr5iBz4x40U8afANRuF4LXH7+peRB5kPOp7SF3G9+
         gIQK/IThVPwzDGBcI8ZtgwDI+cW3+/7iYJORie+WEM13nXNJddXdgWH2Cscyrw8CIVlO
         PM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CzWS2ajG+cat2efjjOS9a3uGpogg36np3g5VuBCIG5w=;
        b=Vh7xnWqf2Ye4RMpUVQwWL2l01HqD+S3Nqpgt1NIPeXqrxiWf3djeR7WtxGAaEOv+jt
         9X/5bURCMRdnVYFcMZN1WB0suf1/Qty7aA83RJQA3d1hivPoQRJ17GRi1uYp+bHvB2yl
         yVE/c5HDw3lZswE3R6r2LDPteFmD9OQdbkEao/4qQ8iE0RU92J1iR9vQN0WQ8XoBvDGV
         sxc9uTta7N95I7xvqnRIqm+1cmnxNnHix6+QOBZqrynV51o2cizCdXwUoxQkPPmIJqSd
         4QnTMZDeqKrsQUdDmzMewnjvl4Wgp+j5VDJbeuKIeJOhx6RYvbzel5wdmsmXLh8p+5yH
         FINw==
X-Gm-Message-State: AOAM530vAMByOHBU/3i9dSSGKwOlEx9XsfLtmQ25JEzQt/lGrtL/3XMo
        H9aScbb9hzkKNmWqN43tpyY=
X-Google-Smtp-Source: ABdhPJzebRdGIz6Mnoxahnz4b46l516GjkdEG6jqilYs2xcY5uiAGGiU+sldzSb2odnFajApIlb7Zg==
X-Received: by 2002:a4a:9f45:: with SMTP id d5mr20295324ool.91.1620143495947;
        Tue, 04 May 2021 08:51:35 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x3sm927763otj.8.2021.05.04.08.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 08:51:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 4 May 2021 08:51:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Send DISCOVER_IDENTITY from dedicated
 work
Message-ID: <20210504155134.GC2117112@roeck-us.net>
References: <20210504135622.3965148-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504135622.3965148-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 09:56:22PM +0800, Kyle Tso wrote:
> In current design, DISCOVER_IDENTITY is queued to VDM state machine
> immediately in Ready states and never retries if it fails in the AMS.
> Move the process to a delayed work so that when it fails for some
> reasons (e.g. Sink Tx No Go), it can be retried by queueing the work
> again. Also fix a problem that the vdm_state is not set to a proper
> state if it is blocked by Collision Avoidance mechanism.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 85 ++++++++++++++++++++++++++++++-----
>  1 file changed, 75 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index c4fdc00a3bc8..07a449f0e8fa 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -259,6 +259,7 @@ enum frs_typec_current {
>  #define ALTMODE_DISCOVERY_MAX	(SVID_DISCOVERY_MAX * MODE_DISCOVERY_MAX)
>  
>  #define GET_SINK_CAP_RETRY_MS	100
> +#define SEND_DISCOVER_RETRY_MS	100
>  
>  struct pd_mode_data {
>  	int svid_index;		/* current SVID index		*/
> @@ -366,6 +367,8 @@ struct tcpm_port {
>  	struct kthread_work vdm_state_machine;
>  	struct hrtimer enable_frs_timer;
>  	struct kthread_work enable_frs;
> +	struct hrtimer send_discover_timer;
> +	struct kthread_work send_discover_work;
>  	bool state_machine_running;
>  	bool vdm_sm_running;
>  
> @@ -1178,6 +1181,16 @@ static void mod_enable_frs_delayed_work(struct tcpm_port *port, unsigned int del
>  	}
>  }
>  
> +static void mod_send_discover_delayed_work(struct tcpm_port *port, unsigned int delay_ms)
> +{
> +	if (delay_ms) {
> +		hrtimer_start(&port->send_discover_timer, ms_to_ktime(delay_ms), HRTIMER_MODE_REL);
> +	} else {
> +		hrtimer_cancel(&port->send_discover_timer);
> +		kthread_queue_work(port->wq, &port->send_discover_work);
> +	}
> +}
> +
>  static void tcpm_set_state(struct tcpm_port *port, enum tcpm_state state,
>  			   unsigned int delay_ms)
>  {
> @@ -1855,6 +1868,9 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>  				res = tcpm_ams_start(port, DISCOVER_IDENTITY);
>  				if (res == 0)
>  					port->send_discover = false;
> +				else if (res == -EAGAIN)
> +					mod_send_discover_delayed_work(port,
> +								       SEND_DISCOVER_RETRY_MS);
>  				break;
>  			case CMD_DISCOVER_SVID:
>  				res = tcpm_ams_start(port, DISCOVER_SVIDS);
> @@ -1880,6 +1896,7 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>  			}
>  
>  			if (res < 0) {
> +				port->vdm_state = VDM_STATE_ERR_BUSY;
>  				port->vdm_sm_running = false;
>  				return;
>  			}
> @@ -3682,14 +3699,6 @@ static inline enum tcpm_state unattached_state(struct tcpm_port *port)
>  	return SNK_UNATTACHED;
>  }
>  
> -static void tcpm_check_send_discover(struct tcpm_port *port)
> -{
> -	if ((port->data_role == TYPEC_HOST || port->negotiated_rev > PD_REV20) &&
> -	    port->send_discover && port->pd_capable)
> -		tcpm_send_vdm(port, USB_SID_PD, CMD_DISCOVER_IDENT, NULL, 0);
> -	port->send_discover = false;
> -}
> -
>  static void tcpm_swap_complete(struct tcpm_port *port, int result)
>  {
>  	if (port->swap_pending) {
> @@ -3926,7 +3935,18 @@ static void run_state_machine(struct tcpm_port *port)
>  			break;
>  		}
>  
> -		tcpm_check_send_discover(port);
> +		/*
> +		 * 6.4.4.3.1 Discover Identity
> +		 * "The Discover Identity Command Shall only be sent to SOP when there is an
> +		 * Explicit Contract."
> +		 * For now, this driver only supports SOP for DISCOVER_IDENTITY, thus using
> +		 * port->explicit_contract to decide whether to send the command.
> +		 */
> +		if (port->explicit_contract)
> +			mod_send_discover_delayed_work(port, 0);
> +		else
> +			port->send_discover = false;
> +
>  		/*
>  		 * 6.3.5
>  		 * Sending ping messages is not necessary if
> @@ -4194,7 +4214,18 @@ static void run_state_machine(struct tcpm_port *port)
>  			break;
>  		}
>  
> -		tcpm_check_send_discover(port);
> +		/*
> +		 * 6.4.4.3.1 Discover Identity
> +		 * "The Discover Identity Command Shall only be sent to SOP when there is an
> +		 * Explicit Contract."
> +		 * For now, this driver only supports SOP for DISCOVER_IDENTITY, thus using
> +		 * port->explicit_contract.
> +		 */
> +		if (port->explicit_contract)
> +			mod_send_discover_delayed_work(port, 0);
> +		else
> +			port->send_discover = false;
> +
>  		power_supply_changed(port->psy);
>  		break;
>  
> @@ -5288,6 +5319,29 @@ static void tcpm_enable_frs_work(struct kthread_work *work)
>  	mutex_unlock(&port->lock);
>  }
>  
> +static void tcpm_send_discover_work(struct kthread_work *work)
> +{
> +	struct tcpm_port *port = container_of(work, struct tcpm_port, send_discover_work);
> +
> +	mutex_lock(&port->lock);
> +	/* No need to send DISCOVER_IDENTITY anymore */
> +	if (!port->send_discover)
> +		goto unlock;
> +
> +	/* Retry if the port is not idle */
> +	if ((port->state != SRC_READY && port->state != SNK_READY) || port->vdm_sm_running) {
> +		mod_send_discover_delayed_work(port, SEND_DISCOVER_RETRY_MS);
> +		goto unlock;
> +	}
> +
> +	/* Only send the Message if the port is host for PD rev2.0 */
> +	if (port->data_role == TYPEC_HOST || port->negotiated_rev > PD_REV20)
> +		tcpm_send_vdm(port, USB_SID_PD, CMD_DISCOVER_IDENT, NULL, 0);
> +
> +unlock:
> +	mutex_unlock(&port->lock);
> +}
> +
>  static int tcpm_dr_set(struct typec_port *p, enum typec_data_role data)
>  {
>  	struct tcpm_port *port = typec_get_drvdata(p);
> @@ -6093,6 +6147,14 @@ static enum hrtimer_restart enable_frs_timer_handler(struct hrtimer *timer)
>  	return HRTIMER_NORESTART;
>  }
>  
> +static enum hrtimer_restart send_discover_timer_handler(struct hrtimer *timer)
> +{
> +	struct tcpm_port *port = container_of(timer, struct tcpm_port, send_discover_timer);
> +
> +	kthread_queue_work(port->wq, &port->send_discover_work);
> +	return HRTIMER_NORESTART;
> +}
> +
>  struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  {
>  	struct tcpm_port *port;
> @@ -6123,12 +6185,15 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	kthread_init_work(&port->vdm_state_machine, vdm_state_machine_work);
>  	kthread_init_work(&port->event_work, tcpm_pd_event_handler);
>  	kthread_init_work(&port->enable_frs, tcpm_enable_frs_work);
> +	kthread_init_work(&port->send_discover_work, tcpm_send_discover_work);
>  	hrtimer_init(&port->state_machine_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	port->state_machine_timer.function = state_machine_timer_handler;
>  	hrtimer_init(&port->vdm_state_machine_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	port->vdm_state_machine_timer.function = vdm_state_machine_timer_handler;
>  	hrtimer_init(&port->enable_frs_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	port->enable_frs_timer.function = enable_frs_timer_handler;
> +	hrtimer_init(&port->send_discover_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	port->send_discover_timer.function = send_discover_timer_handler;
>  
>  	spin_lock_init(&port->pd_event_lock);
>  
> -- 
> 2.31.1.527.g47e6f16901-goog
> 
