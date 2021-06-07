Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B36439D889
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhFGJVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:21:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:43396 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhFGJVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:21:22 -0400
IronPort-SDR: khPzT3tuV3/Yv/91MYRl5+PI4RkxVxtEXzVdLQg2VTvvh/Nm45N9CZM6HfvkzAUlqtugkw8GAN
 3JpdQ4bRGarA==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="265743711"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="265743711"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 02:19:31 -0700
IronPort-SDR: D+TGh23U+FT9mUuSbPOMyIJcYIgbZrdRiQdCzlaWOigvRHKUm99Jb1DgoATUgo0+2f6UiYA6/9
 2skc/Ujq0NNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="551815937"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Jun 2021 02:19:28 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 07 Jun 2021 12:19:27 +0300
Date:   Mon, 7 Jun 2021 12:19:27 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/4] usb: typec: tcpm: Fix misuses of AMS invocation
Message-ID: <YL3kn3C0/3bdNPwi@kuha.fi.intel.com>
References: <20210601123151.3441914-1-kyletso@google.com>
 <20210601123151.3441914-5-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601123151.3441914-5-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 08:31:51PM +0800, Kyle Tso wrote:
> tcpm_ams_start is used to initiate an AMS as well as checking Collision
> Avoidance conditions but not for flagging passive AMS (initiated by the
> port partner). Fix the misuses of tcpm_ams_start in tcpm_pd_svdm.
> 
> ATTENTION doesn't need responses so the AMS flag is not needed here.
> 
> Fixes: 0bc3ee92880d ("usb: typec: tcpm: Properly interrupt VDM AMS")
> Signed-off-by: Kyle Tso <kyletso@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index ebe490949fa0..c4b02a6ca3d7 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1583,7 +1583,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  				svdm_version = PD_VDO_SVDM_VER(p[0]);
>  			}
>  
> -			tcpm_ams_start(port, DISCOVER_IDENTITY);
> +			port->ams = DISCOVER_IDENTITY;
>  			/*
>  			 * PD2.0 Spec 6.10.3: respond with NAK as DFP (data host)
>  			 * PD3.1 Spec 6.4.4.2.5.1: respond with NAK if "invalid field" or
> @@ -1604,19 +1604,18 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			}
>  			break;
>  		case CMD_DISCOVER_SVID:
> -			tcpm_ams_start(port, DISCOVER_SVIDS);
> +			port->ams = DISCOVER_SVIDS;
>  			break;
>  		case CMD_DISCOVER_MODES:
> -			tcpm_ams_start(port, DISCOVER_MODES);
> +			port->ams = DISCOVER_MODES;
>  			break;
>  		case CMD_ENTER_MODE:
> -			tcpm_ams_start(port, DFP_TO_UFP_ENTER_MODE);
> +			port->ams = DFP_TO_UFP_ENTER_MODE;
>  			break;
>  		case CMD_EXIT_MODE:
> -			tcpm_ams_start(port, DFP_TO_UFP_EXIT_MODE);
> +			port->ams = DFP_TO_UFP_EXIT_MODE;
>  			break;
>  		case CMD_ATTENTION:
> -			tcpm_ams_start(port, ATTENTION);
>  			/* Attention command does not have response */
>  			*adev_action = ADEV_ATTENTION;
>  			return 0;
> -- 
> 2.32.0.rc0.204.g9fa02ecfa5-goog

-- 
heikki
