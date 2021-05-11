Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A14B37A0BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhEKHV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:21:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:27863 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhEKHV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:21:56 -0400
IronPort-SDR: Cm6er4fitZVHvPeaboeT/nxBu3qDUn8dBos8RktEyi4pKK1o+fLdbjDd5P2l3rWxW4/pb0rjAZ
 aNtRGnRlf+Jw==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="179639943"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="179639943"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 00:20:50 -0700
IronPort-SDR: nZVmxloKpCeJWz6VllrIepWHZH3IFc5Se0cjV6eMWtBP2OVKyR+6lo7hN//4a0B6Mh8Dq21z1o
 xdq0rwBtCZow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="536873648"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 May 2021 00:20:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 11 May 2021 10:20:47 +0300
Date:   Tue, 11 May 2021 10:20:47 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix SINK_DISCOVERY current limit for
 Rp-default
Message-ID: <YJowT7Zhb0XwZOWf@kuha.fi.intel.com>
References: <20210510211756.3346954-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210510211756.3346954-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 02:17:56PM -0700, Badhri Jagan Sridharan wrote:
> This is a regression introduced by
> <1373fefc6243cc96b3565f0ffffadfac4ccfb977>
> "Allow slow charging loops to comply to pSnkStby".
> 
> When Source advertises Rp-default, tcpm would request 500mA when in
> SINK_DISCOVERY, Type-C spec advises the sink to follow BC1.2 current
> limits when Rp-default is advertised.
> [12750.503381] Requesting mux state 1, usb-role 2, orientation 1
> [12750.503837] state change SNK_ATTACHED -> SNK_STARTUP [rev3 NONE_AMS]
> [12751.003891] state change SNK_STARTUP -> SNK_DISCOVERY
> [12751.003900] Setting voltage/current limit 5000 mV 500 mA
> 
> This patch restores the behavior where the tcpm would request 0mA when
> Rp-default is advertised by the source.
> [   73.174252] Requesting mux state 1, usb-role 2, orientation 1
> [   73.174749] state change SNK_ATTACHED -> SNK_STARTUP [rev3 NONE_AMS]
> [   73.674800] state change SNK_STARTUP -> SNK_DISCOVERY
> [   73.674808] Setting voltage/current limit 5000 mV 0 mA
> 
> During SNK_DISCOVERY, Cap the current limit to PD_P_SNK_STDBY_MW / 5 only
> for slow_charger_loop case.
> 
> Fixes: 1373fefc6243 ("Allow slow charging loops to comply to pSnkStby")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index c4fdc00a3bc8..a73299a08ef7 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4055,7 +4055,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		if (port->vbus_present) {
>  			u32 current_lim = tcpm_get_current_limit(port);
>  
> -			if (port->slow_charger_loop || (current_lim > PD_P_SNK_STDBY_MW / 5))
> +			if (port->slow_charger_loop && (current_lim > PD_P_SNK_STDBY_MW / 5))
>  				current_lim = PD_P_SNK_STDBY_MW / 5;
>  			tcpm_set_current_limit(port, current_lim, 5000);
>  			tcpm_set_charge(port, true);
> -- 
> 2.31.1.607.g51e8a6a459-goog

-- 
heikki
