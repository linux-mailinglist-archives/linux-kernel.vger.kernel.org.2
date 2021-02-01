Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEAE30A7D5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhBAMmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:42:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:4714 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231480AbhBAMmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:42:06 -0500
IronPort-SDR: IUJfjfOO3sv3q+uutdmYQevqJZtc2wy/59PbQaeqn37RZYzILljNOqjbtgqbTBZJ5wlLweLmBJ
 qaL0zgf/wSfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="177170095"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="177170095"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 04:40:27 -0800
IronPort-SDR: dmN0GqUn+elnQjqFw856sYaJiux4/C/y44qKf6VMhJinE5AXNK8QhMe/Xhb2G9BDEoP8ahoE2x
 xtmGAEybinFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="478942516"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 01 Feb 2021 04:40:24 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 01 Feb 2021 14:40:24 +0200
Date:   Mon, 1 Feb 2021 14:40:24 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benson Leung <bleung@chromium.org>
Cc:     enric.balletbo@collabora.com, pmalani@chromium.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        bleung@google.com
Subject: Re: [PATCH 2/6] usb: typec: Provide PD Specification Revision for
 cable and partner
Message-ID: <20210201124024.GB2465@kuha.fi.intel.com>
References: <20210129061406.2680146-1-bleung@chromium.org>
 <20210129061406.2680146-3-bleung@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129061406.2680146-3-bleung@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:14:02PM -0800, Benson Leung wrote:
> The USB Power Delivery specification Section 6.2.1.1.5 outlines
> revision backward compatibility requirements starting from Revision 3.0.
> 
> The Port, the Cable Plug, and the Port Partner may support either
> revision 2 or revision 3 independently, and communication between ports,
> partners, and cables of different revisions are allowed under rules
> that the parties agree to communicate between each other using the
> lowest common operating revision.
> 
> This may mean that Port-to-Partner operating revision comms may be
> different than Port-to-CablePlug operating revision comms. For example,
> it is possible for a R3.0 port to communicate with a R3.0 partner
> using R3.0 messages, while the R3.0 port (in the same session) must
> communicate with the R2.0 cable using R2.0 messages only.
> 
> Introduce individual revision number properties for cable
> and port partner so that the port can track them independently.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  Documentation/ABI/testing/sysfs-class-typec | 13 +++++++++
>  drivers/usb/typec/class.c                   | 30 ++++++++++++++++++---
>  include/linux/usb/typec.h                   | 10 +++++++
>  3 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index b61480535fdc..40122d915ae1 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -112,6 +112,19 @@ Description:
>  		- "3.0": USB Power Delivery Release 3.0
>  		- "3.1": USB Power Delivery Release 3.1
>  
> +What:		/sys/class/typec/<port>-{partner|cable}/usb_power_delivery_revision
> +Date:		January 2021
> +Contact:	Benson Leung <bleung@chromium.org>
> +Description:
> +		Revision number of the supported USB Power Delivery
> +		specification of the port partner or cable, or 0.0 when USB
> +		Power Delivery is not supported.
> +
> +		Example values:
> +		- "2.0": USB Power Delivery Release 2.0
> +		- "3.0": USB Power Delivery Release 3.0
> +		- "3.1": USB Power Delivery Release 3.1
> +
>  What:		/sys/class/typec/<port>/usb_typec_revision
>  Date:		April 2017
>  Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 4f60ee7ba76a..b5241f4756c2 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -27,6 +27,7 @@ struct typec_cable {
>  	enum typec_plug_type		type;
>  	struct usb_pd_identity		*identity;
>  	unsigned int			active:1;
> +	u16				pd_revision; /* 0300H = "3.0" */
>  };
>  
>  struct typec_partner {
> @@ -36,6 +37,7 @@ struct typec_partner {
>  	enum typec_accessory		accessory;
>  	struct ida			mode_ids;
>  	int				num_altmodes;
> +	u16				pd_revision; /* 0300H = "3.0" */
>  };
>  
>  struct typec_port {
> @@ -264,6 +266,11 @@ type_show(struct device *dev, struct device_attribute *attr, char *buf)
>  }
>  static DEVICE_ATTR_RO(type);
>  
> +static ssize_t usb_power_delivery_revision_show(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf);
> +static DEVICE_ATTR_RO(usb_power_delivery_revision);
> +
>  /* ------------------------------------------------------------------------- */
>  /* Alternate Modes */
>  
> @@ -680,6 +687,7 @@ static struct attribute *typec_partner_attrs[] = {
>  	&dev_attr_supports_usb_power_delivery.attr,
>  	&dev_attr_number_of_alternate_modes.attr,
>  	&dev_attr_type.attr,
> +	&dev_attr_usb_power_delivery_revision.attr,
>  	NULL
>  };
>  
> @@ -815,6 +823,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
>  	partner->usb_pd = desc->usb_pd;
>  	partner->accessory = desc->accessory;
>  	partner->num_altmodes = -1;
> +	partner->pd_revision = desc->pd_revision;
>  
>  	if (desc->identity) {
>  		/*
> @@ -1028,6 +1037,7 @@ static DEVICE_ATTR_RO(plug_type);
>  static struct attribute *typec_cable_attrs[] = {
>  	&dev_attr_type.attr,
>  	&dev_attr_plug_type.attr,
> +	&dev_attr_usb_power_delivery_revision.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(typec_cable);
> @@ -1130,6 +1140,7 @@ struct typec_cable *typec_register_cable(struct typec_port *port,
>  
>  	cable->type = desc->type;
>  	cable->active = desc->active;
> +	cable->pd_revision = desc->pd_revision;
>  
>  	if (desc->identity) {
>  		/*
> @@ -1499,12 +1510,23 @@ static ssize_t usb_power_delivery_revision_show(struct device *dev,
>  						struct device_attribute *attr,
>  						char *buf)
>  {
> -	struct typec_port *p = to_typec_port(dev);
> -	u16 rev = p->cap->pd_revision;
> +	u16 rev = 0;
>  
> -	return sprintf(buf, "%d.%d\n", (rev >> 8) & 0xff, (rev >> 4) & 0xf);
> +	if (is_typec_partner(dev)) {
> +		struct typec_partner *partner = to_typec_partner(dev);
> +
> +		rev = partner->pd_revision;
> +	} else if (is_typec_cable(dev)) {
> +		struct typec_cable *cable = to_typec_cable(dev);
> +
> +		rev = cable->pd_revision;
> +	} else if (is_typec_port(dev)) {
> +		struct typec_port *p = to_typec_port(dev);
> +
> +		rev = p->cap->pd_revision;
> +	}
> +	return sysfs_emit(buf, "%d.%d\n", (rev >> 8) & 0xff, (rev >> 4) & 0xf);
>  }
> -static DEVICE_ATTR_RO(usb_power_delivery_revision);
>  
>  static ssize_t orientation_show(struct device *dev,
>  				   struct device_attribute *attr,
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 54475323f83b..42c6b7c07a99 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -164,6 +164,7 @@ struct typec_plug_desc {
>   * @type: The plug type from USB PD Cable VDO
>   * @active: Is the cable active or passive
>   * @identity: Result of Discover Identity command
> + * @pd_revision: USB Power Delivery Specification revision if supported
>   *
>   * Represents USB Type-C Cable attached to USB Type-C port.
>   */
> @@ -171,6 +172,8 @@ struct typec_cable_desc {
>  	enum typec_plug_type	type;
>  	unsigned int		active:1;
>  	struct usb_pd_identity	*identity;
> +	u16			pd_revision; /* 0300H = "3.0" */
> +
>  };
>  
>  /*
> @@ -178,15 +181,22 @@ struct typec_cable_desc {
>   * @usb_pd: USB Power Delivery support
>   * @accessory: Audio, Debug or none.
>   * @identity: Discover Identity command data
> + * @pd_revision: USB Power Delivery Specification Revision if supported
>   *
>   * Details about a partner that is attached to USB Type-C port. If @identity
>   * member exists when partner is registered, a directory named "identity" is
>   * created to sysfs for the partner device.
> + *
> + * @pd_revision is based on the setting of the "Specification Revision" field
> + * in the message header on the initial "Source Capabilities" message received
> + * from the partner, or a "Request" message received from the partner, depending
> + * on whether our port is a Sink or a Source.
>   */
>  struct typec_partner_desc {
>  	unsigned int		usb_pd:1;
>  	enum typec_accessory	accessory;
>  	struct usb_pd_identity	*identity;
> +	u16			pd_revision; /* 0300H = "3.0" */
>  };
>  
>  /**
> -- 
> 2.30.0.365.g02bc693789-goog

thanks,

-- 
heikki
