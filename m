Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7D730A9DF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhBAOfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhBAOeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:34:17 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2943FC06174A;
        Mon,  1 Feb 2021 06:33:37 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id CCF071F44612
Subject: Re: [PATCH 5/6] platform/chrome: cros_ec_typec: Set Partner PD
 revision from status
To:     Benson Leung <bleung@chromium.org>,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, bleung@google.com
References: <20210129061406.2680146-1-bleung@chromium.org>
 <20210129061406.2680146-6-bleung@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <6f33af27-2ede-462a-1683-f97137a40a0f@collabora.com>
Date:   Mon, 1 Feb 2021 15:33:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210129061406.2680146-6-bleung@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benson,

On 29/1/21 7:14, Benson Leung wrote:
> Status provides sop_revision. Process it, and set it using the new
> setter in the typec class.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

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
> 
