Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EEC30A810
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhBAMxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:53:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:43417 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231656AbhBAMxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:53:42 -0500
IronPort-SDR: SWGnUxQEV3XtR+NiaJmz5wnjz/O0H7zVTjXMF7OcrUVZfqjHwC4yarKyD/8AH9EHSUn6hYlG1B
 irXi9mmjW9Ww==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="244760469"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="244760469"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 04:51:50 -0800
IronPort-SDR: 32zuoe+UTyFBjNX3hD8Fb2ug69U9XzLp0Mih2ehyfqFVfmq330uS8ES85mAF3BpoR7MyoPOzj7
 VEhiPsqeX2gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="478948999"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 01 Feb 2021 04:51:47 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 01 Feb 2021 14:51:46 +0200
Date:   Mon, 1 Feb 2021 14:51:46 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benson Leung <bleung@chromium.org>
Cc:     enric.balletbo@collabora.com, pmalani@chromium.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        bleung@google.com
Subject: Re: [PATCH 4/6] platform/chrome: cros_ec_typec: Report SOP' PD
 revision from status
Message-ID: <20210201125146.GD2465@kuha.fi.intel.com>
References: <20210129061406.2680146-1-bleung@chromium.org>
 <20210129061406.2680146-5-bleung@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129061406.2680146-5-bleung@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:14:04PM -0800, Benson Leung wrote:
> cros_typec_handle_sop_prime_disc now takes the PD revision provided
> by the EC_CMD_TYPEC_STATUS command response for the SOP'.
> 
> Attach the properly formatted pd_revision to the cable desc before
> registering the cable.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index e724a5eaef1c..30600e9454e1 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -748,7 +748,7 @@ static void cros_typec_parse_pd_identity(struct usb_pd_identity *id,
>  		id->vdo[i - 3] = disc->discovery_vdo[i];
>  }
>  
> -static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int port_num)
> +static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int port_num, u16 pd_revision)
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
>  	struct ec_response_typec_discovery *disc = port->disc_data;
> @@ -794,6 +794,7 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
>  	}
>  
>  	c_desc.identity = &port->c_identity;
> +	c_desc.pd_revision = pd_revision;
>  
>  	port->cable = typec_register_cable(port->port, &c_desc);
>  	if (IS_ERR(port->cable)) {
> @@ -893,7 +894,11 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
>  
>  	if (resp.events & PD_STATUS_EVENT_SOP_PRIME_DISC_DONE &&
>  	    !typec->ports[port_num]->sop_prime_disc_done) {
> -		ret = cros_typec_handle_sop_prime_disc(typec, port_num);
> +		u16 sop_prime_revision;
> +
> +		/* Convert BCD to the format preferred by the TypeC framework */
> +		sop_prime_revision = (le16_to_cpu(resp.sop_prime_revision) & 0xff00) >> 4;
> +		ret = cros_typec_handle_sop_prime_disc(typec, port_num, sop_prime_revision);
>  		if (ret < 0)
>  			dev_err(typec->dev, "Couldn't parse SOP' Disc data, port: %d\n", port_num);
>  		else
> -- 
> 2.30.0.365.g02bc693789-goog

thanks,

-- 
heikki
