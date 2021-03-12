Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5206933860B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhCLGjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhCLGjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:39:33 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC57C061574;
        Thu, 11 Mar 2021 22:39:32 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id t83so15849455oih.12;
        Thu, 11 Mar 2021 22:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8XahDnVGHaB/78dul3sUbFzUy28ZenBQybUMz+VE5cQ=;
        b=ucoPKW6zFerWPdw8Bz0r7s+RhzbQAJqvZjQ7CiHpN5Rz9axeCocavipwTqGinq96Bq
         8wDoPcacC5KvKlBp1NbLDRNB4i3CeQMj2MpJ/NLUm2tPKls4FX0kFsz1LWE9IL2MaaaV
         lqhJIHsnGl7UHnBUqWnCQKO47ahFeKeFEBeQ+CbHR8GuTR0g8XlXDgJ2ALLhieFXftCM
         CAXN9rtSscwDHFKc/VYyvPNiLYiWyPB9enZuCkaP4pbUx9oxgzAK1HaNda8V5IMMqYSj
         LQwhHZPeEycmitrcPSv6ee6DzZsoBlo1DZpfT7MhY5zph5YsfdYbL+lqQIXW/UvQJAxv
         6WRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8XahDnVGHaB/78dul3sUbFzUy28ZenBQybUMz+VE5cQ=;
        b=Ylj3ENpOhFOBE3I3nocIIVWYOAETBVpH5KoHh8/6q5qZm7DB7cEqv3aNoHT80mIdxL
         ri3SBBFfL3sJkfFI9D75jjdNzZ0RZ73OZAEVFsddvB5dmVLhVYW1tbHToqi5PMqrLfpV
         9sF8fmbETYPwyd8OImQlIqz5gEkdbOUqWvce1fpWPZ03qIbIyN+N1it7ldjs8nSXkIIy
         6+OfGw59XjSYcFBnD+Y5P1SqZ5ir2+H3CO/qeXUbq6/syvFAPkpgvNoD8lvEapuXCPDm
         GNXOhzzX6hjlWThjeme/d0Co7NvWlbab31NnjHnAOMayh7aJIQZYBPblzhuKvGx5NVHe
         sy2g==
X-Gm-Message-State: AOAM532MhnSLoOFekCWGQGQi749ABKsE4OcsPNwiocZ6oZ1AE1mHE78D
        Ub4ruFcRMUIfBU6jz0Dp7FXO+T23e0M=
X-Google-Smtp-Source: ABdhPJwoIxuN82CSdQ9947ImRoini2UHZR7pQ9Vpa7Pkm+d6f5JKe8QIoM0WV14llY7O8SBfNhY3+g==
X-Received: by 2002:a05:6808:1450:: with SMTP id x16mr9062541oiv.6.1615531172061;
        Thu, 11 Mar 2021 22:39:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l26sm1203189otd.21.2021.03.11.22.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 22:39:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 2/2] usb: typec: tcpci_maxim: configure charging & data
 paths
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
References: <20210312052443.3797674-1-badhri@google.com>
 <20210312052443.3797674-2-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <dba54e90-17e7-ab42-bc82-4ca39ee5de30@roeck-us.net>
Date:   Thu, 11 Mar 2021 22:39:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210312052443.3797674-2-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/21 9:24 PM, Badhri Jagan Sridharan wrote:
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

Effectively this mandates extcon support to be able to use this driver/chip.
Does that make sense ? If this is indeed mandatory, how did it work so far ?

Also, what makes this code chip specific ?

Thanks,
Guenter

> +
> +	extcon_set_property_capability(chip->extcon, EXTCON_USB, EXTCON_PROP_USB_TYPEC_POLARITY);
> +	extcon_set_property_capability(chip->extcon, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_TYPEC_POLARITY);
> +
>  	device_init_wakeup(chip->dev, true);
>  	return 0;
>  
> 

