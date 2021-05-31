Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802113957D4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhEaJHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:07:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:25563 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhEaJH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:07:28 -0400
IronPort-SDR: ruPedB5Zjir22i65fsklZX1NaMKqSM6PoyP30AxqLz2UIRvLUCfTJNgV4sSxL7RBdXBYYw9dSq
 p2uUcUbzZ0gg==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190441262"
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="190441262"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 02:05:35 -0700
IronPort-SDR: dim1OX9Fu4gShFDQxL7ys/75YTEcxTULyp4BWp+YAWjNavbLrOenvlKid5T1J9Sx8/XeAZc/VU
 Kh+RAR83vBLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="549357956"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 31 May 2021 02:05:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 May 2021 12:05:27 +0300
Date:   Mon, 31 May 2021 12:05:27 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: typec: tcpm: Introduce snk_vdo_v1 for SVDM
 version 1.0
Message-ID: <YLSm13rYy0GPfapW@kuha.fi.intel.com>
References: <20210527084419.4164369-1-kyletso@google.com>
 <20210527084419.4164369-4-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527084419.4164369-4-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 04:44:19PM +0800, Kyle Tso wrote:
> The ID Header VDO and Product VDOs defined in USB PD Spec rev 2.0 and
> rev 3.1 are quite different. Add an additional array snk_vdo_v1 and
> send it as the response to the port partner if it only supports SVDM
> version 1.0.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 40 +++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index a1bf0dc5babf..07d2bed0a63b 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -401,6 +401,8 @@ struct tcpm_port {
>  	unsigned int nr_src_pdo;
>  	u32 snk_pdo[PDO_MAX_OBJECTS];
>  	unsigned int nr_snk_pdo;
> +	u32 snk_vdo_v1[VDO_MAX_OBJECTS];
> +	unsigned int nr_snk_vdo_v1;
>  	u32 snk_vdo[VDO_MAX_OBJECTS];
>  	unsigned int nr_snk_vdo;
>  
> @@ -1561,18 +1563,18 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			 */
>  			if ((port->data_role == TYPEC_DEVICE || svdm_version >= SVDM_VER_2_0) &&
>  			    port->nr_snk_vdo) {
> -				/*
> -				 * Product Type DFP and Connector Type are not defined in SVDM
> -				 * version 1.0 and shall be set to zero.
> -				 */
> -				if (svdm_version < SVDM_VER_2_0)
> -					response[1] = port->snk_vdo[0] & ~IDH_DFP_MASK
> -						      & ~IDH_CONN_MASK;
> -				else
> +				if (svdm_version < SVDM_VER_2_0) {
> +					response[1] = port->snk_vdo_v1[0];
> +					for (i = 1; i < port->nr_snk_vdo_v1; i++)
> +						response[i + 1] = port->snk_vdo_v1[i];
> +					rlen = port->nr_snk_vdo_v1 + 1;
> +
> +				} else {
>  					response[1] = port->snk_vdo[0];
> -				for (i = 1; i <  port->nr_snk_vdo; i++)
> -					response[i + 1] = port->snk_vdo[i];
> -				rlen = port->nr_snk_vdo + 1;
> +					for (i = 1; i < port->nr_snk_vdo; i++)
> +						response[i + 1] = port->snk_vdo[i];
> +					rlen = port->nr_snk_vdo + 1;
> +				}
>  			}
>  			break;
>  		case CMD_DISCOVER_SVID:
> @@ -5953,6 +5955,22 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  			return ret;
>  	}
>  
> +	/* If sink-vdos is found, sink-vdos-v1 is expected for backward compatibility. */
> +	if (port->nr_snk_vdo) {
> +		ret = fwnode_property_count_u32(fwnode, "sink-vdos-v1");
> +		if (ret < 0)
> +			return ret;
> +		else if (ret == 0)
> +			return -ENODATA;
> +
> +		port->nr_snk_vdo_v1 = min(ret, VDO_MAX_OBJECTS);
> +		ret = fwnode_property_read_u32_array(fwnode, "sink-vdos-v1",
> +						     port->snk_vdo_v1,
> +						     port->nr_snk_vdo_v1);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.31.1.818.g46aad6cb9e-goog

-- 
heikki
