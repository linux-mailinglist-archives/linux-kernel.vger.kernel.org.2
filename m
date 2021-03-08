Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3D7330BE7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhCHLDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:03:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:64817 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhCHLDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:03:33 -0500
IronPort-SDR: SyVzqETPbb74sJTkkiyxuR4UWEfqrnXeIf9hcWufKUT9Dm5akhH4doBqR5Tahb8/gnGUsug00A
 dV9Uxf8hJb2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="252034593"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="252034593"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 03:03:31 -0800
IronPort-SDR: 8qnIpvCzxLlGKtqfgGNsGex/GaOwnLG/jmxhee2H32k5ugSmVQmpS0P3tKgvPwjoDHLqh4hJjX
 1qhifclxNi8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="508891474"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 Mar 2021 03:03:29 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 08 Mar 2021 13:03:28 +0200
Date:   Mon, 8 Mar 2021 13:03:28 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tcpm: turn tcpm_ams_finish into void
 function
Message-ID: <YEYEgIzE3RstWoV4@kuha.fi.intel.com>
References: <1615185330-118246-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615185330-118246-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 02:35:30PM +0800, Yang Li wrote:
> This function always return '0' and no callers use the return value.
> So make it a void function.
> 
> This eliminates the following coccicheck warning:
> ./drivers/usb/typec/tcpm/tcpm.c:778:5-8: Unneeded variable: "ret".
> Return "0" on line 794
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Change in v2:
> -remove the unnecessary return statement
> 
>  drivers/usb/typec/tcpm/tcpm.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index be0b646..8159229 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -773,10 +773,8 @@ static enum typec_cc_status tcpm_rp_cc(struct tcpm_port *port)
>  	return TYPEC_CC_RP_DEF;
>  }
>  
> -static int tcpm_ams_finish(struct tcpm_port *port)
> +static void tcpm_ams_finish(struct tcpm_port *port)
>  {
> -	int ret = 0;
> -
>  	tcpm_log(port, "AMS %s finished", tcpm_ams_str[port->ams]);
>  
>  	if (port->pd_capable && port->pwr_role == TYPEC_SOURCE) {
> @@ -790,8 +788,6 @@ static int tcpm_ams_finish(struct tcpm_port *port)
>  
>  	port->in_ams = false;
>  	port->ams = NONE_AMS;
> -
> -	return ret;
>  }
>  
>  static int tcpm_pd_transmit(struct tcpm_port *port,
> -- 
> 1.8.3.1

-- 
heikki
