Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E177037A051
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhEKHID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:08:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:46811 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhEKHIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:08:01 -0400
IronPort-SDR: bUV9DEyqdeaDPe/I80/8vPDjCiXSr5ri8ADzlvUKetNzzCvoNmKafFmqrhltGiB7l0IhOXnwqo
 UjuOdzo3fXfQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="186509564"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="186509564"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 00:06:52 -0700
IronPort-SDR: l/DNnVZ1UyLOFlRAG2CLSSQJAU7n5Sp1GuZbQtCaWkzunBTtWncPMaLXi7Q34L0gue6QArcp8r
 VkJLFzp3FXcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="536849445"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 May 2021 00:06:49 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 11 May 2021 10:06:49 +0300
Date:   Tue, 11 May 2021 10:06:49 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: typec: tcpm: Fix wrong handling for
 Not_Supported in VDM AMS
Message-ID: <YJotCZU9TYg+EVrG@kuha.fi.intel.com>
References: <20210507062300.1945009-1-kyletso@google.com>
 <20210507062300.1945009-3-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507062300.1945009-3-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 02:23:00PM +0800, Kyle Tso wrote:
> Not_Supported Message is acceptable in VDM AMS. Redirect the VDM state
> machine to VDM_STATE_DONE when receiving Not_Supported and finish the
> VDM AMS.
> 
> Also, after the loop in vdm_state_machine_work, add more conditions of
> VDM states to clear the vdm_sm_running flag because those are all
> stopping states when leaving the loop.
> 
> In addition, finish the VDM AMS if the port partner responds BUSY.
> 
> Fixes: 8dea75e11380 ("usb: typec: tcpm: Protocol Error handling")
> Fixes: 8d3a0578ad1a ("usb: typec: tcpm: Respond Wait if VDM state machine is running")
> Signed-off-by: Kyle Tso <kyletso@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v2:
> - no changes
> 
>  drivers/usb/typec/tcpm/tcpm.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 07a449f0e8fa..bf97db232f09 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1897,7 +1897,6 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>  
>  			if (res < 0) {
>  				port->vdm_state = VDM_STATE_ERR_BUSY;
> -				port->vdm_sm_running = false;
>  				return;
>  			}
>  		}
> @@ -1913,6 +1912,7 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>  		port->vdo_data[0] = port->vdo_retry;
>  		port->vdo_count = 1;
>  		port->vdm_state = VDM_STATE_READY;
> +		tcpm_ams_finish(port);
>  		break;
>  	case VDM_STATE_BUSY:
>  		port->vdm_state = VDM_STATE_ERR_TMOUT;
> @@ -1978,7 +1978,7 @@ static void vdm_state_machine_work(struct kthread_work *work)
>  		 port->vdm_state != VDM_STATE_BUSY &&
>  		 port->vdm_state != VDM_STATE_SEND_MESSAGE);
>  
> -	if (port->vdm_state == VDM_STATE_ERR_TMOUT)
> +	if (port->vdm_state < VDM_STATE_READY)
>  		port->vdm_sm_running = false;
>  
>  	mutex_unlock(&port->lock);
> @@ -2569,6 +2569,16 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  			port->sink_cap_done = true;
>  			tcpm_set_state(port, ready_state(port), 0);
>  			break;
> +		case SRC_READY:
> +		case SNK_READY:
> +			if (port->vdm_state > VDM_STATE_READY) {
> +				port->vdm_state = VDM_STATE_DONE;
> +				if (tcpm_vdm_ams(port))
> +					tcpm_ams_finish(port);
> +				mod_vdm_delayed_work(port, 0);
> +				break;
> +			}
> +			fallthrough;
>  		default:
>  			tcpm_pd_handle_state(port,
>  					     port->pwr_role == TYPEC_SOURCE ?
> -- 
> 2.31.1.527.g47e6f16901-goog

-- 
heikki
