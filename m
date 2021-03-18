Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E25034006C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 08:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhCRHs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 03:48:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:12929 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhCRHsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 03:48:08 -0400
IronPort-SDR: KYaEThI1hpFF5N0OS5No2h36GGSk6/QDyCN+S1VGTtqpjl+P4RCLIn/SrrkMXZc6q/hWx7qPwZ
 c59ZUehM+Q7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="169545502"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="169545502"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 00:48:08 -0700
IronPort-SDR: 0DV7MTEJwdl7a16FZabxjpgqu8Guupv/VWk+KKLr4Y09jl3NNOF51fF/I9dWt41DCnnp/q8MdI
 sBCifOOWK+7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="512019214"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 18 Mar 2021 00:48:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 18 Mar 2021 09:48:05 +0200
Date:   Thu, 18 Mar 2021 09:48:05 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: PD3.0 sinks can send Discover
 Identity even in device mode
Message-ID: <YFMFtScTKPS/9CO+@kuha.fi.intel.com>
References: <20210318065604.3757307-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210318065604.3757307-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 11:56:04PM -0700, Badhri Jagan Sridharan wrote:
> >From 6.4.4.2 Structured VDM:
> • Either Port May be an Initiator of Structured VDMs except for the Enter
> Mode and Exit Mode Commands which Shall only be initiated by the DFP."
> 
> The above implies that when PD3.0 link is established PD3.0 sinks
> can send out discover identity command/AMS once PD negotiation is done.
> This allows discovering identity for PD3.0 UFP ports as well.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 11d0c40bc47d..410856ec1702 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3653,8 +3653,8 @@ static inline enum tcpm_state unattached_state(struct tcpm_port *port)
>  
>  static void tcpm_check_send_discover(struct tcpm_port *port)
>  {
> -	if (port->data_role == TYPEC_HOST && port->send_discover &&
> -	    port->pd_capable)
> +	if ((port->data_role == TYPEC_HOST || port->negotiated_rev > PD_REV20) &&
> +	    port->send_discover && port->pd_capable)
>  		tcpm_send_vdm(port, USB_SID_PD, CMD_DISCOVER_IDENT, NULL, 0);
>  	port->send_discover = false;
>  }
> -- 
> 2.31.0.rc2.261.g7f71774620-goog

thanks,

-- 
heikki
