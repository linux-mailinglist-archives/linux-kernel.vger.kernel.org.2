Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28969395763
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhEaIv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:51:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:50519 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230107AbhEaIvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:51:24 -0400
IronPort-SDR: cDv+ARt0tgNV/Bb0P8JMemg8Qv7NnmM8SLYM2qmMl1yaYkc7FavzEavadPYBc3i1zqSTEBXt5T
 TvwRHQXwz7Vg==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190686041"
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="190686041"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 01:49:44 -0700
IronPort-SDR: Ge5fQOsDibYVgBPzEQW8PDC7z10sMVYxxTJSgayoFfvc3JePxRdwnjKxKLY2P0IEhTC7TGwkmW
 2GXxzpK7y5IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="549351536"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 31 May 2021 01:49:41 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 May 2021 11:49:40 +0300
Date:   Mon, 31 May 2021 11:49:40 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: typec: tcpm: Correct the responses in SVDM
 Version 2.0 DFP
Message-ID: <YLSjJFAkm92VKoJh@kuha.fi.intel.com>
References: <20210527084419.4164369-1-kyletso@google.com>
 <20210527084419.4164369-2-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527084419.4164369-2-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 04:44:17PM +0800, Kyle Tso wrote:
> In USB PD Spec Rev 3.1 Ver 1.0, section "6.12.5 Applicability of
> Structured VDM Commands", DFP is allowed and recommended to respond to
> Discovery Identity with ACK. And in section "6.4.4.2.5.1 Commands other
> than Attention", NAK should be returned only when receiving Messages
> with invalid fields, Messages in wrong situation, or unrecognize
> Messages.
> 
> Still keep the original design for SVDM Version 1.0 for backward
> compatibilities.
> 
> Fixes: 193a68011fdc ("staging: typec: tcpm: Respond to Discover Identity commands")
> Signed-off-by: Kyle Tso <kyletso@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 9ce8c9af4da5..a1bf0dc5babf 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1547,19 +1547,25 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			if (PD_VDO_VID(p[0]) != USB_SID_PD)
>  				break;
>  
> -			if (PD_VDO_SVDM_VER(p[0]) < svdm_version)
> +			if (PD_VDO_SVDM_VER(p[0]) < svdm_version) {
>  				typec_partner_set_svdm_version(port->partner,
>  							       PD_VDO_SVDM_VER(p[0]));
> +				svdm_version = PD_VDO_SVDM_VER(p[0]);
> +			}
>  
>  			tcpm_ams_start(port, DISCOVER_IDENTITY);
> -			/* 6.4.4.3.1: Only respond as UFP (device) */
> -			if (port->data_role == TYPEC_DEVICE &&
> +			/*
> +			 * PD2.0 Spec 6.10.3: respond with NAK as DFP (data host)
> +			 * PD3.1 Spec 6.4.4.2.5.1: respond with NAK if "invalid field" or
> +			 * "wrong configuation" or "Unrecognized"
> +			 */
> +			if ((port->data_role == TYPEC_DEVICE || svdm_version >= SVDM_VER_2_0) &&
>  			    port->nr_snk_vdo) {
>  				/*
>  				 * Product Type DFP and Connector Type are not defined in SVDM
>  				 * version 1.0 and shall be set to zero.
>  				 */
> -				if (typec_get_negotiated_svdm_version(typec) < SVDM_VER_2_0)
> +				if (svdm_version < SVDM_VER_2_0)
>  					response[1] = port->snk_vdo[0] & ~IDH_DFP_MASK
>  						      & ~IDH_CONN_MASK;
>  				else
> -- 
> 2.31.1.818.g46aad6cb9e-goog

-- 
heikki
