Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D1838E3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhEXKYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:24:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:53371 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232426AbhEXKYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:24:09 -0400
IronPort-SDR: PZRI2nmDo1DBBRit1hxJzneIkdP12uJlTshRZoO+cRBpnO3cEYeOQXD9SbdAgpOOHc++jA+4Q5
 eq+7i8eGFx/g==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="189024787"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="189024787"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 03:22:41 -0700
IronPort-SDR: PAlFE+eBV1czTpL3dYCMs0cg8ir77MGPpUfgo3YTNGmc7n1C7bKJ3hoTe4Xj2mnN0wT0RrKo1N
 DT9PYQ0NGp4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="545868829"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 24 May 2021 03:22:38 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 24 May 2021 13:22:37 +0300
Date:   Mon, 24 May 2021 13:22:37 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@intel.com
Subject: Re: [PATCH v2 2/2] usb: typec: tcpm: Respond Not_Supported if no
 snk_vdo
Message-ID: <YKt+bbgOVi/3RCpQ@kuha.fi.intel.com>
References: <20210523015855.1785484-1-kyletso@google.com>
 <20210523015855.1785484-3-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523015855.1785484-3-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 09:58:55AM +0800, Kyle Tso wrote:
> If snk_vdo is not populated from fwnode, it implies the port does not
> support responding to SVDM commands. Not_Supported Message shall be sent
> if the contract is in PD3. And for PD2, the port shall ignore the
> commands.
> 
> Fixes: 193a68011fdc ("staging: typec: tcpm: Respond to Discover Identity commands")
> Signed-off-by: Kyle Tso <kyletso@google.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 7db6ae3e9c0b..a56bc71f4eb5 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2458,7 +2458,10 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
>  					   NONE_AMS);
>  		break;
>  	case PD_DATA_VENDOR_DEF:
> -		tcpm_handle_vdm_request(port, msg->payload, cnt);
> +		if (tcpm_vdm_ams(port) || port->nr_snk_vdo)
> +			tcpm_handle_vdm_request(port, msg->payload, cnt);
> +		else if (port->negotiated_rev > PD_REV20)
> +			tcpm_pd_handle_msg(port, PD_MSG_CTRL_NOT_SUPP, NONE_AMS);
>  		break;
>  	case PD_DATA_BIST:
>  		port->bist_request = le32_to_cpu(msg->payload[0]);
> -- 
> 2.31.1.818.g46aad6cb9e-goog

-- 
heikki
