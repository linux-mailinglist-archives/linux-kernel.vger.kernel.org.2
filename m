Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C941E30AAC7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhBAPO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:14:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:34708 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231352AbhBAPOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:14:24 -0500
IronPort-SDR: 5OB1Fo6nzCIco4h+WZJHiky4fniavJSErHtoFoLx1yLjdr+Gt2fi+ItPGJQXOparRmetKfwzDc
 cqRH31nlFKIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242216663"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="242216663"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 07:12:57 -0800
IronPort-SDR: D8Eo3K9uxGsdx7eRPyVaS59lfnItmzj9PJFRof3MD+QghKIFhc3DNFD4WYDPepGd4gq6d2qtE0
 0VoPYxIVV80w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="479113880"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 01 Feb 2021 07:12:54 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 01 Feb 2021 17:12:53 +0200
Date:   Mon, 1 Feb 2021 17:12:53 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] usb: typec: tcpm: Add Callback to Usb
 Communication capable partner
Message-ID: <20210201151253.GG2465@kuha.fi.intel.com>
References: <20210201095309.39486-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201095309.39486-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 01:53:07AM -0800, Badhri Jagan Sridharan wrote:
> The USB Communications Capable bit indicates if port
> partner is capable of communication over the USB data lines
> (e.g. D+/- or SS Tx/Rx). Notify the status of the bit to low
> level drivers to perform chip specific operation.
> For instance, low level driver enables USB switches on D+/D-
> lines to set up data path when the bit is set.
> 
> Refactored from patch initially authored by
> Kyle Tso <kyletso@google.com>
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 16 ++++++++++++++++
>  include/linux/usb/tcpm.h      |  5 +++++
>  2 files changed, 21 insertions(+)

...

> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index 3af99f85e8b9..42fcfbe10590 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -108,6 +108,10 @@ enum tcpm_transmit_type {
>   *		is supported by TCPC, set this callback for TCPM to query
>   *		whether vbus is at VSAFE0V when needed.
>   *		Returns true when vbus is at VSAFE0V, false otherwise.
> + * @set_partner_usb_comm_capable:
> + *              Optional; The USB Communications Capable bit indicates if port
> + *              partner is capable of communication over the USB data lines
> + *              (e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
>   */
>  struct tcpc_dev {
>  	struct fwnode_handle *fwnode;
> @@ -139,6 +143,7 @@ struct tcpc_dev {
>  	int (*set_auto_vbus_discharge_threshold)(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
>  						 bool pps_active, u32 requested_vbus_voltage);
>  	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
> +	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
>  };
>  
>  struct tcpm_port;

There start to be a lot of callback there, separate for each function.
And I guess flags too... Would it be possible to have a single
notification callback instead, that would take the type of the
notification as a parameter (we could have an enum for those), and
then the specific object(s) for each type as another paramter (RDO I
guess in this case)?

It would then be up to the TCPC driver to extract the detail it needs
from that object. That would somehow feel more cleaner to me, but what
do you guys think?

thanks,

-- 
heikki
