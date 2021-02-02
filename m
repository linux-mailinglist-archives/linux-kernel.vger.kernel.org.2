Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286F330B993
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhBBIXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:23:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:4860 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231324AbhBBIXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:23:22 -0500
IronPort-SDR: TjiajcQu8hiWbokg6NvcsRgCRx6oi9x9GDItJ8GtCMocRS04jbVY/rH6YAXORY8cbzOuZegX2b
 XMABRm7vjbuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="265649233"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="265649233"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 00:21:36 -0800
IronPort-SDR: WAnMADibO6TaXQ29FfB/fxgl6lF2DbEN/KLanN7lHaF/PIxH6zZ25JwiYMxZX4I1aInMm5UsN+
 y3mv8IKyRBig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="479481555"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 02 Feb 2021 00:21:34 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Feb 2021 10:21:33 +0200
Date:   Tue, 2 Feb 2021 10:21:33 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Handle vbus shutoff when in source
 mode
Message-ID: <20210202082133.GB1433721@kuha.fi.intel.com>
References: <20210201100212.49863-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201100212.49863-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 02:02:12AM -0800, Badhri Jagan Sridharan wrote:
> While in source mode, vbus could be shutoff by protections
> circuits. TCPM does not move back to toggling state to
> re-initiate connection. Fix this by moving to SRC_UNATTACHED
> state when vbus shuts off while in source mode.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 0afd8ef692e8..ff0732c12b8a 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4897,6 +4897,17 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
>  		/* Do nothing, waiting for sink detection */
>  		break;
>  
> +	case SRC_STARTUP:
> +	case SRC_SEND_CAPABILITIES:
> +	case SRC_SEND_CAPABILITIES_TIMEOUT:
> +	case SRC_NEGOTIATE_CAPABILITIES:
> +	case SRC_TRANSITION_SUPPLY:
> +	case SRC_READY:
> +	case SRC_WAIT_NEW_CAPABILITIES:
> +		/* Force to unattached state to re-initiate connection */
> +		tcpm_set_state(port, SRC_UNATTACHED, 0);
> +		break;
> +
>  	case PORT_RESET:
>  		/*
>  		 * State set back to default mode once the timer completes.
> -- 
> 2.30.0.365.g02bc693789-goog

thanks,

-- 
heikki
