Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92163EE9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 11:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbhHQJhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 05:37:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:57488 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234593AbhHQJhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:37:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="216030318"
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="216030318"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 02:36:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="593293551"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Aug 2021 02:36:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Aug 2021 12:36:27 +0300
Date:   Tue, 17 Aug 2021 12:36:27 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: always rediscover when swapping DR
Message-ID: <YRuDG78N2mB5w37p@kuha.fi.intel.com>
References: <20210813043131.833006-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813043131.833006-1-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 12:31:31PM +0800, Icenowy Zheng wrote:
> Currently, TCPM code omits discover when swapping to gadget, and assume
> that no altmodes are available when swapping from gadget. However, we do
> send discover when we get attached as gadget -- this leads to modes to be
> discovered twice when attached as gadget and then swap to host.
> 
> Always re-send discover when swapping DR, regardless of what change is
> being made; and because of this, the assumption that no altmodes are
> registered with gadget role is broken, and altmodes de-registeration is
> always needed now.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index b9bb63d749ec..ab6d0d51ee1c 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4495,15 +4495,14 @@ static void run_state_machine(struct tcpm_port *port)
>  		tcpm_set_state(port, ready_state(port), 0);
>  		break;
>  	case DR_SWAP_CHANGE_DR:
> -		if (port->data_role == TYPEC_HOST) {
> -			tcpm_unregister_altmodes(port);
> +		tcpm_unregister_altmodes(port);
> +		if (port->data_role == TYPEC_HOST)
>  			tcpm_set_roles(port, true, port->pwr_role,
>  				       TYPEC_DEVICE);
> -		} else {
> +		else
>  			tcpm_set_roles(port, true, port->pwr_role,
>  				       TYPEC_HOST);
> -			port->send_discover = true;
> -		}
> +		port->send_discover = true;
>  		tcpm_ams_finish(port);
>  		tcpm_set_state(port, ready_state(port), 0);
>  		break;

Why is it necessary to do discovery with data role swap in general?

thanks,

-- 
heikki
