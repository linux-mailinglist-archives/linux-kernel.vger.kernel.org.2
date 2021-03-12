Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26CE33882A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhCLJBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:01:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:29858 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232540AbhCLJBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:01:36 -0500
IronPort-SDR: c87Vc3zRg0CP0jXoyELJet6Tj3uGVOmt39jF5pKgqdQW9vALN9FKYN4VWh5uLtK4z5TqzEkJmI
 nn3p6vQ7bQdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="185451234"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="185451234"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 01:01:36 -0800
IronPort-SDR: 71ORMrExkGQpw8AnNT3v33woVnAfuFuzzuoC8hT1hZg82U4aLcyJnDmQAUvIRdt5iyYEgv0bgP
 qCnDiCAhxfmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="510277867"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 12 Mar 2021 01:01:32 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 12 Mar 2021 11:01:31 +0200
Date:   Fri, 12 Mar 2021 11:01:31 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v2 2/2] usb: typec: tcpci_maxim: configure charging &
 data paths
Message-ID: <YEst66MdaYFzaIUT@kuha.fi.intel.com>
References: <20210312052443.3797674-1-badhri@google.com>
 <20210312052443.3797674-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312052443.3797674-2-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Mar 11, 2021 at 09:24:43PM -0800, Badhri Jagan Sridharan kirjoitti:
> The change exposes the data_role and the orientation as a extcon
> interface for configuring the USB data controller.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since V1:
> - Dropped changes related to get_/set_current_limit and pd_capable
>   callback. Will send them in as separate patches.
> ---
>  drivers/usb/typec/tcpm/tcpci_maxim.c | 56 ++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> index 041a1c393594..1210445713ee 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> @@ -7,6 +7,8 @@
>  
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
> +#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> @@ -46,6 +48,8 @@ struct max_tcpci_chip {
>  	struct device *dev;
>  	struct i2c_client *client;
>  	struct tcpm_port *port;
> +	bool attached;
> +	struct extcon_dev *extcon;
>  };
>  
>  static const struct regmap_range max_tcpci_tcpci_range[] = {
> @@ -439,6 +443,39 @@ static int tcpci_init(struct tcpci *tcpci, struct tcpci_data *data)
>  	return -1;
>  }
>  
> +static void max_tcpci_set_roles(struct tcpci *tcpci, struct tcpci_data *data, bool attached,
> +				enum typec_role role, enum typec_data_role data_role)
> +{
> +	struct max_tcpci_chip *chip = tdata_to_max_tcpci(data);
> +
> +	chip->attached = attached;
> +
> +	if (!attached) {
> +		extcon_set_state_sync(chip->extcon, EXTCON_USB_HOST, 0);
> +		extcon_set_state_sync(chip->extcon, EXTCON_USB, 0);
> +		return;
> +	}
> +
> +	extcon_set_state_sync(chip->extcon, data_role == TYPEC_HOST ? EXTCON_USB_HOST : EXTCON_USB,
> +			      1);
> +}
> +
> +static void max_tcpci_set_cc_polarity(struct tcpci *tcpci, struct tcpci_data *data,
> +				      enum typec_cc_polarity polarity)
> +{
> +	struct max_tcpci_chip *chip = tdata_to_max_tcpci(data);
> +
> +	extcon_set_property(chip->extcon, EXTCON_USB, EXTCON_PROP_USB_TYPEC_POLARITY,
> +			    (union extcon_property_value)(int)polarity);
> +	extcon_set_property(chip->extcon, EXTCON_USB_HOST, EXTCON_PROP_USB_TYPEC_POLARITY,
> +			    (union extcon_property_value)(int)polarity);
> +}
> +
> +static const unsigned int usbpd_extcon[] = {
> +	EXTCON_USB,
> +	EXTCON_USB_HOST,
> +};
> +
>  static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id *i2c_id)
>  {
>  	int ret;
> @@ -472,6 +509,8 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
>  	chip->data.auto_discharge_disconnect = true;
>  	chip->data.vbus_vsafe0v = true;
>  	chip->data.set_partner_usb_comm_capable = max_tcpci_set_partner_usb_comm_capable;
> +	chip->data.set_roles = max_tcpci_set_roles;
> +	chip->data.set_cc_polarity = max_tcpci_set_cc_polarity;
>  
>  	max_tcpci_init_regs(chip);
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
> @@ -484,6 +523,23 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
>  	if (ret < 0)
>  		goto unreg_port;
>  
> +	chip->extcon = devm_extcon_dev_allocate(&client->dev, usbpd_extcon);
> +	if (IS_ERR(chip->extcon)) {
> +		dev_err(&client->dev, "Error allocating extcon: %ld\n", PTR_ERR(chip->extcon));
> +		ret = PTR_ERR(chip->extcon);
> +		goto unreg_port;
> +	}
> +
> +	ret = devm_extcon_dev_register(&client->dev, chip->extcon);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to register extcon device");
> +		goto unreg_port;
> +	}

Why do you need this? We have the dedicated USB role class because
extcon could not handle every type of system. Things are simple enough
when you have a single dual-role capable USB controller, but when you
start having more bits and pieces like muxes in between, the
consumer/supplier extcon roles get twisted.

So in case you did not know this, our goal was originally to use
extcon for handling the data role (and orientation too), but some of
drivers were refused by the extcon maintainers because of the above
reason.

Most USB controller drivers for dual-role capable USB controllers
already register a role switch, and tcpm.c always requests a handle to
one that it uses to inform the current data role, so this part should
not require any new code.


> +	extcon_set_property_capability(chip->extcon, EXTCON_USB, EXTCON_PROP_USB_TYPEC_POLARITY);
> +	extcon_set_property_capability(chip->extcon, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_TYPEC_POLARITY);
> +
>  	device_init_wakeup(chip->dev, true);
>  	return 0;
>  
> -- 
> 2.31.0.rc2.261.g7f71774620-goog

thanks,

-- 
heikki
