Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEA930BA60
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhBBIx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:53:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:7656 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229975AbhBBIxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:53:53 -0500
IronPort-SDR: yoEb/BDw6S5i2WY3kg5rvk5sFMQbg+hruwTKdg2HtSNYXu66eSwzGV2Igq0lB37QrbG5jNYWCC
 iPRdkIcilFAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="265653130"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="265653130"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 00:52:06 -0800
IronPort-SDR: +22FgflFJPsyFYdAlwZDDYTdCn+5fgEnwlPtNMH/+p0/XiUCDpYw3jE8itXqjD9el5dXBkCG6l
 SpeBKsdJj8LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="479489771"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 02 Feb 2021 00:52:04 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Feb 2021 10:52:03 +0200
Date:   Tue, 2 Feb 2021 10:52:03 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: typec: tcpci_maxim: Enable data path when
 partner is USB Comm capable
Message-ID: <20210202085203.GG1433721@kuha.fi.intel.com>
References: <20210202003101.221145-1-badhri@google.com>
 <20210202003101.221145-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202003101.221145-3-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 04:31:01PM -0800, Badhri Jagan Sridharan wrote:
> Configure USB switches when partner is USB Communication capable.
> The is enabled USB data communication over D+/D- pins.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_maxim.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> index f1674a611033..041a1c393594 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> @@ -19,6 +19,9 @@
>  #define PD_ACTIVITY_TIMEOUT_MS				10000
>  
>  #define TCPC_VENDOR_ALERT				0x80
> +#define TCPC_VENDOR_USBSW_CTRL				0x93
> +#define TCPC_VENDOR_USBSW_CTRL_ENABLE_USB_DATA		0x9
> +#define TCPC_VENDOR_USBSW_CTRL_DISABLE_USB_DATA		0
>  
>  #define TCPC_RECEIVE_BUFFER_COUNT_OFFSET		0
>  #define TCPC_RECEIVE_BUFFER_FRAME_TYPE_OFFSET		1
> @@ -274,6 +277,21 @@ static void process_tx(struct max_tcpci_chip *chip, u16 status)
>  		max_tcpci_init_regs(chip);
>  }
>  
> +/* Enable USB switches when partner is USB communications capable */
> +static void max_tcpci_set_partner_usb_comm_capable(struct tcpci *tcpci, struct tcpci_data *data,
> +						   bool capable)
> +{
> +	struct max_tcpci_chip *chip = tdata_to_max_tcpci(data);
> +	int ret;
> +
> +	ret = max_tcpci_write8(chip, TCPC_VENDOR_USBSW_CTRL, capable ?
> +			       TCPC_VENDOR_USBSW_CTRL_ENABLE_USB_DATA :
> +			       TCPC_VENDOR_USBSW_CTRL_DISABLE_USB_DATA);
> +
> +	if (ret < 0)
> +		dev_err(chip->dev, "Failed to enable USB switches");
> +}
> +
>  static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
>  {
>  	u16 mask;
> @@ -453,6 +471,7 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
>  	chip->data.frs_sourcing_vbus = max_tcpci_frs_sourcing_vbus;
>  	chip->data.auto_discharge_disconnect = true;
>  	chip->data.vbus_vsafe0v = true;
> +	chip->data.set_partner_usb_comm_capable = max_tcpci_set_partner_usb_comm_capable;
>  
>  	max_tcpci_init_regs(chip);
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
> -- 
> 2.30.0.365.g02bc693789-goog

thanks,

-- 
heikki
