Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8602355639
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344958AbhDFOPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244364AbhDFOO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:14:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E84A61382;
        Tue,  6 Apr 2021 14:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617718489;
        bh=INz753g/rP6LpFipcHZBYmnDy3NFV9T5EzJWjxWQUkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ruMciBRyJxZwyxh8uc/3tSywGv/2V4c4b2rk1kxagDSHiad5LFNGJ9oqoS4jqlqZy
         TJSSLH1dob+YrSSlkITZk/sdzQDNYEBvmQi9aCE96Ee1HxJ0asYeOe2IBAcJkEsyvv
         TXVknqxlmYX51sx4I9EKshKoj93eShjsPV1l/dtk=
Date:   Tue, 6 Apr 2021 16:14:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v1 2/6] usb: typec: tcpm: Address incorrect values of
 tcpm psy for pps supply
Message-ID: <YGxs0uSQe46c7/mD@kroah.com>
References: <20210406013643.3280369-1-badhri@google.com>
 <20210406013643.3280369-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406013643.3280369-3-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 06:36:39PM -0700, Badhri Jagan Sridharan wrote:
> tcpm_pd_select_pps_apdo overwrites port->pps_data.min_volt,
> port->pps_data.max_volt, port->pps_data.max_curr even before
> port partner accepts the requests. This leaves incorrect values
> in current_limit and supply_voltage that get exported by
> "tcpm-source-psy-". Solving this problem by caching the request
> values in req_min_volt, req_max_volt, req_max_curr, req_out_volt,
> req_op_curr. min_volt, max_volt, max_curr gets updated once the
> partner accepts the request. current_limit, supply_voltage gets updated
> once local port's tcpm enters SNK_TRANSITION_SINK when the accepted
> current_limit and supply_voltage is enforced.
> 
> Fixes: f2a8aa053c176 ("typec: tcpm: Represent source supply through power_supply")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 84 ++++++++++++++++++++---------------
>  1 file changed, 49 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 03eca5061132..d43774cc2ccf 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -269,11 +269,22 @@ struct pd_mode_data {
>  };
>  
>  struct pd_pps_data {
> +	/* Actual min voltage at the local port */
>  	u32 min_volt;
> +	/* Requested min voltage to the port partner */
> +	u32 req_min_volt;
> +	/* Actual max voltage at the local port */
>  	u32 max_volt;
> +	/* Requested max voltage to the port partner */
> +	u32 req_max_volt;
> +	/* Actual max current at the local port */
>  	u32 max_curr;
> -	u32 out_volt;
> -	u32 op_curr;
> +	/* Requested max current of the port partner */
> +	u32 req_max_curr;
> +	/* Requested output voltage to the port partner */
> +	u32 req_out_volt;
> +	/* Requested operating current to the port partner */
> +	u32 req_op_curr;

Shouldn't you just document this all properly in a kerneldoc header
right above the structure?

thanks,

greg k-h
