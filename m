Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697673198FB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhBLEJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhBLEJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:09:48 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC48C061574;
        Thu, 11 Feb 2021 20:09:08 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id f1so1816822oou.0;
        Thu, 11 Feb 2021 20:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7W3mRwT9grc4RGioubCtLHsQp5n6wdQDrRVup7k8z+A=;
        b=RoAB0/pnbw20TvgTsr/NWXsrlyf1wj2iLrjP1LDWjYfb0ulfgD2OYqtCLLVF6KWBGj
         IXVfkYqHOV2ctX0CWy5g6ZgDmPKiu4w4NMIC0ZX4v0PXJSgGQxfYznhs1vLLGS5tGSx+
         dmyMvRLisIqk/7LPo4+d1QeGspwVV6Ezo6klZM95T3zwskzVpYTqrJxnCHHtgttwh6Lp
         ayk0/6zxL2XxUw/TXRS4R4pYJpJPicerneDhK9xIntMX67ZkGQF6ocBKmHIVcIwWvrzF
         UddGEq1PnF8zPPuW/2XmZW+NXraROvVLFZ5yf+BLl8sg+TIM7s5rtqc+qVT/J8twWKcp
         aKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7W3mRwT9grc4RGioubCtLHsQp5n6wdQDrRVup7k8z+A=;
        b=b1D5H666JlwNT1vtBBG86MEBb7Lw7sl5wQ4NK7fVyKFPLteVJGqhFU46E8M1VY77Jj
         Z7AQ6KK+gIcDAT0ZjH+Z06Ipw702UIkcosYBvKNCfetbecGUsXPJODGQJYnbWTH/Yj/J
         OT5+m7pTZsEOZMOTh1BbTjvGnSgFw5XqrJzzr5kbkBmo2pV5DJKPEDQs1XAVuR0RtxNH
         dQgt/bBaZ5KduRyRDgHApRy4dtPo5iGXnyExSy3syx3ExAR02InNjvC0nqKH0ZdGrDju
         ie3Mtk0U7yl4SwM1cJEBo7OyDQkpoK4Dl1fktT7PMoVQuQoxjcSq6r870r1kupYL34OJ
         j66A==
X-Gm-Message-State: AOAM532NloXGsAetTEk0T6+I5MbDIqsed/gMezY65+hx67d/FUXz4hZV
        LBb2g5JpEXImBmVIXUmtIB8=
X-Google-Smtp-Source: ABdhPJwEEODRxUzSr9sTbfq+pfS8Cw9FUR1XCuSoEJV0NxDd7Q7Y+aZip70rzjdRmXqV85EVV/0Qjw==
X-Received: by 2002:a4a:de94:: with SMTP id v20mr719711oou.90.1613102946497;
        Thu, 11 Feb 2021 20:09:06 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g14sm1346481oon.23.2021.02.11.20.09.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Feb 2021 20:09:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Feb 2021 20:09:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, robh+dt@kernel.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCHi v6 1/7] usb: typec: Manage SVDM version
Message-ID: <20210212040904.GA103223@roeck-us.net>
References: <20210205033415.3320439-1-kyletso@google.com>
 <20210205033415.3320439-2-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205033415.3320439-2-kyletso@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 11:34:09AM +0800, Kyle Tso wrote:
> PD Spec Revision 3.0 Version 2.0 + ECNs 2020-12-10
>   6.4.4.2.3 Structured VDM Version
>   "The Structured VDM Version field of the Discover Identity Command
>   sent and received during VDM discovery Shall be used to determine the
>   lowest common Structured VDM Version supported by the Port Partners or
>   Cable Plug and Shall continue to operate using this Specification
>   Revision until they are Detached."
> 
> Add a variable in typec_capability to specify the highest SVDM version
> supported by the port and another variable in typec_partner to cache the
> negotiated SVDM version between the port and the partner.
> 
> Also add setter/getter functions for the negotiated SVDM version.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v5
> - !! most changes are from Heikki
> - location of the negotiated SVDM version is changed. Now the variable
>   resides in typec_partner
> - The setter and getter functions were modified according to the above
>   changes
> - the default SVDM version is stored upon calling to
>   typec_register_partner
> 
>  drivers/usb/typec/class.c         | 43 +++++++++++++++++++++++++++++++
>  include/linux/usb/typec.h         | 12 +++++++++
>  include/linux/usb/typec_altmode.h | 10 +++++++
>  3 files changed, 65 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index b4a5d9d4564f..45f0bf65e9ab 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -38,6 +38,7 @@ struct typec_partner {
>  	struct ida			mode_ids;
>  	int				num_altmodes;
>  	u16				pd_revision; /* 0300H = "3.0" */
> +	enum usb_pd_svdm_ver		svdm_version;
>  };
>  
>  struct typec_port {
> @@ -824,6 +825,20 @@ typec_partner_register_altmode(struct typec_partner *partner,
>  }
>  EXPORT_SYMBOL_GPL(typec_partner_register_altmode);
>  
> +/**
> + * typec_partner_set_svdm_version - Set negotiated Structured VDM (SVDM) Version
> + * @partner: USB Type-C Partner that supports SVDM
> + * @svdm_version: Negotiated SVDM Version
> + *
> + * This routine is used to save the negotiated SVDM Version.
> + */
> +void typec_partner_set_svdm_version(struct typec_partner *partner,
> +				   enum usb_pd_svdm_ver svdm_version)
> +{
> +	partner->svdm_version = svdm_version;
> +}
> +EXPORT_SYMBOL_GPL(typec_partner_set_svdm_version);
> +
>  /**
>   * typec_register_partner - Register a USB Type-C Partner
>   * @port: The USB Type-C Port the partner is connected to
> @@ -848,6 +863,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
>  	partner->accessory = desc->accessory;
>  	partner->num_altmodes = -1;
>  	partner->pd_revision = desc->pd_revision;
> +	partner->svdm_version = port->cap->svdm_version;
>  
>  	if (desc->identity) {
>  		/*
> @@ -1894,6 +1910,33 @@ EXPORT_SYMBOL_GPL(typec_set_mode);
>  
>  /* --------------------------------------- */
>  
> +/**
> + * typec_get_negotiated_svdm_version - Get negotiated SVDM Version
> + * @port: USB Type-C Port.
> + *
> + * Get the negotiated SVDM Version. The Version is set to the port default
> + * value stored in typec_capability on partner registration, and updated after
> + * a successful Discover Identity if the negotiated value is less than the
> + * default value.
> + *
> + * Returns usb_pd_svdm_ver if the partner has been registered otherwise -ENODEV.
> + */
> +int typec_get_negotiated_svdm_version(struct typec_port *port)
> +{
> +	enum usb_pd_svdm_ver svdm_version;
> +	struct device *partner_dev;
> +
> +	partner_dev = device_find_child(&port->dev, NULL, partner_match);
> +	if (!partner_dev)
> +		return -ENODEV;
> +
> +	svdm_version = to_typec_partner(partner_dev)->svdm_version;
> +	put_device(partner_dev);
> +
> +	return svdm_version;
> +}
> +EXPORT_SYMBOL_GPL(typec_get_negotiated_svdm_version);
> +
>  /**
>   * typec_get_drvdata - Return private driver data pointer
>   * @port: USB Type-C port
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index a94df82ab62f..91b4303ca305 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -217,12 +217,19 @@ struct typec_operations {
>  			     enum typec_port_type type);
>  };
>  
> +enum usb_pd_svdm_ver {
> +	SVDM_VER_1_0 = 0,
> +	SVDM_VER_2_0 = 1,
> +	SVDM_VER_MAX = SVDM_VER_2_0,
> +};
> +
>  /*
>   * struct typec_capability - USB Type-C Port Capabilities
>   * @type: Supported power role of the port
>   * @data: Supported data role of the port
>   * @revision: USB Type-C Specification release. Binary coded decimal
>   * @pd_revision: USB Power Delivery Specification revision if supported
> + * @svdm_version: USB PD Structured VDM version if supported
>   * @prefer_role: Initial role preference (DRP ports).
>   * @accessory: Supported Accessory Modes
>   * @fwnode: Optional fwnode of the port
> @@ -236,6 +243,7 @@ struct typec_capability {
>  	enum typec_port_data	data;
>  	u16			revision; /* 0120H = "1.2" */
>  	u16			pd_revision; /* 0300H = "3.0" */
> +	enum usb_pd_svdm_ver	svdm_version;
>  	int			prefer_role;
>  	enum typec_accessory	accessory[TYPEC_MAX_ACCESSORY];
>  	unsigned int		orientation_aware:1;
> @@ -286,4 +294,8 @@ int typec_find_orientation(const char *name);
>  int typec_find_port_power_role(const char *name);
>  int typec_find_power_role(const char *name);
>  int typec_find_port_data_role(const char *name);
> +
> +void typec_partner_set_svdm_version(struct typec_partner *partner,
> +				    enum usb_pd_svdm_ver svdm_version);
> +int typec_get_negotiated_svdm_version(struct typec_port *port);
>  #endif /* __LINUX_USB_TYPEC_H */
> diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
> index 5e0a7b7647c3..65933cbe9129 100644
> --- a/include/linux/usb/typec_altmode.h
> +++ b/include/linux/usb/typec_altmode.h
> @@ -132,6 +132,16 @@ typec_altmode_get_orientation(struct typec_altmode *altmode)
>  	return typec_get_orientation(typec_altmode2port(altmode));
>  }
>  
> +/**
> + * typec_altmode_get_svdm_version - Get negotiated SVDM version
> + * @altmode: Handle to the alternate mode
> + */
> +static inline int
> +typec_altmode_get_svdm_version(struct typec_altmode *altmode)
> +{
> +	return typec_get_negotiated_svdm_version(typec_altmode2port(altmode));
> +}
> +
>  /**
>   * struct typec_altmode_driver - USB Type-C alternate mode device driver
>   * @id_table: Null terminated array of SVIDs
> -- 
> 2.30.0.365.g02bc693789-goog
> 
