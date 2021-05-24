Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDFC38E3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhEXKXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:23:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:52856 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232565AbhEXKXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:23:50 -0400
IronPort-SDR: FdbMPI4LNB1w0Rk5hiaH925i9NvwDa+oAxne7ugxWvFNz08PxzMm8aMsav+QHhfT60Tu6O6tQ9
 D97YLRMX+5NA==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="263112925"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="263112925"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 03:22:13 -0700
IronPort-SDR: UlhpAMbijW2JrWMObLIMddhYaWQm+XHYxBxXIJcaNYrsae/t8iRgQ8LUybN2UpPU9G97/1m9Or
 TLgGRobuVRqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="545868696"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 24 May 2021 03:22:10 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 24 May 2021 13:22:10 +0300
Date:   Mon, 24 May 2021 13:22:10 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@intel.com
Subject: Re: [PATCH v2 1/2] usb: typec: tcpm: Properly interrupt VDM AMS
Message-ID: <YKt+UsvpDcNHXZfx@kuha.fi.intel.com>
References: <20210523015855.1785484-1-kyletso@google.com>
 <20210523015855.1785484-2-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523015855.1785484-2-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 09:58:54AM +0800, Kyle Tso wrote:
> When a VDM AMS is interrupted by Messages other than VDM, the AMS needs
> to be finished properly. Also start a VDM AMS if receiving SVDM Commands
> from the port partner to complement the functionality of tcpm_vdm_ams().
> 
> Fixes: 0908c5aca31e ("usb: typec: tcpm: AMS and Collision Avoidance")
> Signed-off-by: Kyle Tso <kyletso@google.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3feaf5d6419e..7db6ae3e9c0b 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1578,6 +1578,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			if (PD_VDO_SVDM_VER(p[0]) < svdm_version)
>  				typec_partner_set_svdm_version(port->partner,
>  							       PD_VDO_SVDM_VER(p[0]));
> +
> +			tcpm_ams_start(port, DISCOVER_IDENTITY);
>  			/* 6.4.4.3.1: Only respond as UFP (device) */
>  			if (port->data_role == TYPEC_DEVICE &&
>  			    port->nr_snk_vdo) {
> @@ -1596,14 +1598,19 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			}
>  			break;
>  		case CMD_DISCOVER_SVID:
> +			tcpm_ams_start(port, DISCOVER_SVIDS);
>  			break;
>  		case CMD_DISCOVER_MODES:
> +			tcpm_ams_start(port, DISCOVER_MODES);
>  			break;
>  		case CMD_ENTER_MODE:
> +			tcpm_ams_start(port, DFP_TO_UFP_ENTER_MODE);
>  			break;
>  		case CMD_EXIT_MODE:
> +			tcpm_ams_start(port, DFP_TO_UFP_EXIT_MODE);
>  			break;
>  		case CMD_ATTENTION:
> +			tcpm_ams_start(port, ATTENTION);
>  			/* Attention command does not have response */
>  			*adev_action = ADEV_ATTENTION;
>  			return 0;
> @@ -2315,6 +2322,12 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
>  	bool frs_enable;
>  	int ret;
>  
> +	if (tcpm_vdm_ams(port) && type != PD_DATA_VENDOR_DEF) {
> +		port->vdm_state = VDM_STATE_ERR_BUSY;
> +		tcpm_ams_finish(port);
> +		mod_vdm_delayed_work(port, 0);
> +	}
> +
>  	switch (type) {
>  	case PD_DATA_SOURCE_CAP:
>  		for (i = 0; i < cnt; i++)
> @@ -2487,6 +2500,16 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  	enum pd_ctrl_msg_type type = pd_header_type_le(msg->header);
>  	enum tcpm_state next_state;
>  
> +	/*
> +	 * Stop VDM state machine if interrupted by other Messages while NOT_SUPP is allowed in
> +	 * VDM AMS if waiting for VDM responses and will be handled later.
> +	 */
> +	if (tcpm_vdm_ams(port) && type != PD_CTRL_NOT_SUPP && type != PD_CTRL_GOOD_CRC) {
> +		port->vdm_state = VDM_STATE_ERR_BUSY;
> +		tcpm_ams_finish(port);
> +		mod_vdm_delayed_work(port, 0);
> +	}
> +
>  	switch (type) {
>  	case PD_CTRL_GOOD_CRC:
>  	case PD_CTRL_PING:
> @@ -2745,6 +2768,13 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
>  	enum pd_ext_msg_type type = pd_header_type_le(msg->header);
>  	unsigned int data_size = pd_ext_header_data_size_le(msg->ext_msg.header);
>  
> +	/* stopping VDM state machine if interrupted by other Messages */
> +	if (tcpm_vdm_ams(port)) {
> +		port->vdm_state = VDM_STATE_ERR_BUSY;
> +		tcpm_ams_finish(port);
> +		mod_vdm_delayed_work(port, 0);
> +	}
> +
>  	if (!(msg->ext_msg.header & PD_EXT_HDR_CHUNKED)) {
>  		tcpm_pd_handle_msg(port, PD_MSG_CTRL_NOT_SUPP, NONE_AMS);
>  		tcpm_log(port, "Unchunked extended messages unsupported");
> -- 
> 2.31.1.818.g46aad6cb9e-goog

-- 
heikki
