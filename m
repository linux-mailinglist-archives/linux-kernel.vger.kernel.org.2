Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A0230BA56
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhBBIvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:51:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:5486 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232801AbhBBIvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:51:21 -0500
IronPort-SDR: tAJu8SgQpbzq8JHtAIN6yzjreALMk77p3gUDaq0nsmuHSoe5uZgL7W7frv5+DH5rySaTBkKdZc
 Zbzuf6HLDikw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="199735965"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="199735965"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 00:49:23 -0800
IronPort-SDR: pfqINw/Q+J3JXewrVLGqe2BcjsDTWrWVhpZmbZsZlNhMluxAbes6ocafUEcUC10npyBeFuAN3d
 GKREx4L5MQSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="479489030"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 02 Feb 2021 00:49:20 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Feb 2021 10:49:19 +0200
Date:   Tue, 2 Feb 2021 10:49:19 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: typec: tcpci: Add Callback to Usb
 Communication capable partner
Message-ID: <20210202084919.GF1433721@kuha.fi.intel.com>
References: <20210202003101.221145-1-badhri@google.com>
 <20210202003101.221145-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202003101.221145-2-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 04:31:00PM -0800, Badhri Jagan Sridharan wrote:
> The USB Communications Capable bit indicates if port
> partner is capable of communication over the USB data lines
> (e.g. D+/- or SS Tx/Rx). TCPM passes this information for chip specific
> operations.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci.c | 9 +++++++++
>  drivers/usb/typec/tcpm/tcpci.h | 6 ++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index f676abab044b..a27deb0b5f03 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -255,6 +255,14 @@ static int tcpci_set_polarity(struct tcpc_dev *tcpc,
>  			   TCPC_TCPC_CTRL_ORIENTATION : 0);
>  }
>  
> +static void tcpci_set_partner_usb_comm_capable(struct tcpc_dev *tcpc, bool capable)
> +{
> +	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> +
> +	if (tcpci->data->set_partner_usb_comm_capable)
> +		tcpci->data->set_partner_usb_comm_capable(tcpci, tcpci->data, capable);
> +}
> +
>  static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> @@ -720,6 +728,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>  	tcpci->tcpc.set_bist_data = tcpci_set_bist_data;
>  	tcpci->tcpc.enable_frs = tcpci_enable_frs;
>  	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
> +	tcpci->tcpc.set_partner_usb_comm_capable = tcpci_set_partner_usb_comm_capable;
>  
>  	if (tcpci->data->auto_discharge_disconnect) {
>  		tcpci->tcpc.enable_auto_vbus_discharge = tcpci_enable_auto_vbus_discharge;
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index c3c7d07d9b4e..57b6e24e0a0c 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -161,6 +161,10 @@ struct tcpci;
>   *		Optional; Enables TCPC to autonously discharge vbus on disconnect.
>   * @vbus_vsafe0v:
>   *		optional; Set when TCPC can detect whether vbus is at VSAFE0V.
> + * @set_partner_usb_comm_capable:
> + *		Optional; The USB Communications Capable bit indicates if port
> + *		partner is capable of communication over the USB data lines
> + *		(e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
>   */
>  struct tcpci_data {
>  	struct regmap *regmap;
> @@ -175,6 +179,8 @@ struct tcpci_data {
>  				  enum typec_cc_status cc);
>  	int (*set_vbus)(struct tcpci *tcpci, struct tcpci_data *data, bool source, bool sink);
>  	void (*frs_sourcing_vbus)(struct tcpci *tcpci, struct tcpci_data *data);
> +	void (*set_partner_usb_comm_capable)(struct tcpci *tcpci, struct tcpci_data *data,
> +					     bool capable);
>  };
>  
>  struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
> -- 
> 2.30.0.365.g02bc693789-goog

thanks,

-- 
heikki
