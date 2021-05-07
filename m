Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25ED376674
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 15:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbhEGN4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 09:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbhEGN4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 09:56:33 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813FAC061574;
        Fri,  7 May 2021 06:55:33 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso7934975otb.13;
        Fri, 07 May 2021 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XT21upDZji9LhSYRJTIVSeDu/233THjF0dPxwam1G2g=;
        b=eNfNVPwDfnWwpfz0CnPV0woX6+pUwKXKWCcsTE9SRT+mdVgpWxJhnIsHkyA8Gv/ujJ
         1AwX5Ote0o2MBHmHYNNnbDyv3+HxB1qc41E/FepvYXaxtJ9NYhEBP4KTLLmE9tt14XgS
         +zL3/2bmxLvIGkh/rVEozJh9326+3cLMOo6o3YeuXl3IJUt8UDnTp1/j3ZWo2r0+21g9
         brqujEKMWqHmvU0kXbJ2yyVLpCBfbOTmaQaOhgGsufQD8jQIhKo4CaJPOOFSt3dHeHP1
         oDXQcXnyrJKVMM4BlAL6NyOMeAq/pZPO+bZjMj3nVG3mk+NH5qlmhy8XGzfVuwykel3J
         02Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XT21upDZji9LhSYRJTIVSeDu/233THjF0dPxwam1G2g=;
        b=uNZuxxgBtXdKPhSCf5hBWYtUXu0FYRRgJQNqJfcb8C1i8Sl6rmOPsK/jKQ5FkX5jj2
         LnmPeVesXKjp6DdmQK33Q7wEBHMdVGjTWX2tk3aRvzHqdL+qc1yfAl3UDevwYHW7Ykbk
         XQln5gs1Bol+h7seoLPGd2ZJbED0s9Z2+pGOGOLwC73aIH5nma+WTPStj0UNGIniwwcd
         m1fpTS/iVYCJ1wKL4Nxk26W+gfGG2X/PlI7VIqDQSu1NzoarY9RfjNvI0jXO4831BxjK
         yYjLeVMjFAgOQFVbxaVJTCVxQd50JipFZcO4WTO1uWUjGHgM75xaBN0f8+7m0tYnSSRJ
         NZtQ==
X-Gm-Message-State: AOAM533PGfrhlCgUkrwKphQ3dSBK7yuLIvevPGflWfFKqNxooXYd4GtE
        XU4KiMzBj8McGqEbgWLSLCY=
X-Google-Smtp-Source: ABdhPJzM0C6biYW4Nsodlh0zfEkGWfCwGKlnubHG5AS4ZFoN0kjuaBGpe8CQ5WWuJ79Y4v8MGQyDwA==
X-Received: by 2002:a9d:5a10:: with SMTP id v16mr8275144oth.187.1620395732816;
        Fri, 07 May 2021 06:55:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 16sm1197586otu.79.2021.05.07.06.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 06:55:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 7 May 2021 06:55:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: typec: tcpm: Fix wrong handling for
 Not_Supported in VDM AMS
Message-ID: <20210507135530.GA1458134@roeck-us.net>
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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
> 
