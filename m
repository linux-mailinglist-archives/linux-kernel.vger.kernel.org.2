Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B72F30A9DA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhBAOeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:34:19 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33770 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhBAOeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:34:02 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 142191F445F9
Subject: Re: [PATCH 4/6] platform/chrome: cros_ec_typec: Report SOP' PD
 revision from status
To:     Benson Leung <bleung@chromium.org>,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, bleung@google.com
References: <20210129061406.2680146-1-bleung@chromium.org>
 <20210129061406.2680146-5-bleung@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <5459ad99-ce1b-5ce5-baba-a9658f7a6dd6@collabora.com>
Date:   Mon, 1 Feb 2021 15:33:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210129061406.2680146-5-bleung@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benson,

On 29/1/21 7:14, Benson Leung wrote:
> cros_typec_handle_sop_prime_disc now takes the PD revision provided
> by the EC_CMD_TYPEC_STATUS command response for the SOP'.
> 
> Attach the properly formatted pd_revision to the cable desc before
> registering the cable.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

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
> 
