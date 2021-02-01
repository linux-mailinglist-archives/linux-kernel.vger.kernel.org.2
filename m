Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB9430A817
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhBAMyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:54:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:24370 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231901AbhBAMyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:54:18 -0500
IronPort-SDR: GfZzRF3QUb7QnGZZjSktHBRDjW6nFwyYaIZr01OJu+oi1guEZ5VD3Y/NFAuIqjsSrDswU2QagD
 ZISaCy7+Fk+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="199572366"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="199572366"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 04:52:27 -0800
IronPort-SDR: jIERZjibtZDM6svr3/4L0o6yNcA4+F6evPcHgbC2bsRiqTHiccRu1BYcFVrkt1dWPN/C+BnDSt
 ImcJW0yjrQEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="478949506"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 01 Feb 2021 04:52:24 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 01 Feb 2021 14:52:23 +0200
Date:   Mon, 1 Feb 2021 14:52:23 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benson Leung <bleung@chromium.org>
Cc:     enric.balletbo@collabora.com, pmalani@chromium.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        bleung@google.com
Subject: Re: [PATCH 5/6] platform/chrome: cros_ec_typec: Set Partner PD
 revision from status
Message-ID: <20210201125223.GE2465@kuha.fi.intel.com>
References: <20210129061406.2680146-1-bleung@chromium.org>
 <20210129061406.2680146-6-bleung@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129061406.2680146-6-bleung@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:14:05PM -0800, Benson Leung wrote:
> Status provides sop_revision. Process it, and set it using the new
> setter in the typec class.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 30600e9454e1..6bc6fafd54a4 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -824,7 +824,7 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
>  	return ret;
>  }
>  
> -static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_num)
> +static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_num, u16 pd_revision)
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
>  	struct ec_response_typec_discovery *sop_disc = port->disc_data;
> @@ -842,6 +842,12 @@ static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_nu
>  		goto disc_exit;
>  	}
>  
> +	ret = typec_partner_set_pd_revision(port->partner, pd_revision);
> +	if (ret < 0) {
> +		dev_err(typec->dev, "Failed to update partner PD revision, port: %d\n", port_num);
> +		goto disc_exit;
> +	}
> +
>  	memset(sop_disc, 0, EC_PROTO2_MAX_RESPONSE_SIZE);
>  	ret = cros_typec_ec_command(typec, 0, EC_CMD_TYPEC_DISCOVERY, &req, sizeof(req),
>  				    sop_disc, EC_PROTO2_MAX_RESPONSE_SIZE);
> @@ -885,7 +891,11 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
>  
>  	/* Handle any events appropriately. */
>  	if (resp.events & PD_STATUS_EVENT_SOP_DISC_DONE && !typec->ports[port_num]->sop_disc_done) {
> -		ret = cros_typec_handle_sop_disc(typec, port_num);
> +		u16 sop_revision;
> +
> +		/* Convert BCD to the format preferred by the TypeC framework */
> +		sop_revision = (le16_to_cpu(resp.sop_revision) & 0xff00) >> 4;
> +		ret = cros_typec_handle_sop_disc(typec, port_num, sop_revision);
>  		if (ret < 0)
>  			dev_err(typec->dev, "Couldn't parse SOP Disc data, port: %d\n", port_num);
>  		else
> -- 
> 2.30.0.365.g02bc693789-goog

thanks,

-- 
heikki
