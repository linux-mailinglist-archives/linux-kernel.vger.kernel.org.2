Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8F330C5A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbhBBQ2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbhBBQ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:26:15 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BD1C061788;
        Tue,  2 Feb 2021 08:25:34 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id x71so23307964oia.9;
        Tue, 02 Feb 2021 08:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CT/F6WABXrxDgwV5W6Oavn37EbmFXivRPDSuygeRcYo=;
        b=Jqr3TyehlYeYFOH638c81n13OpL/1Z4W04SInHnw0pBrZZSOUsme+UqsLkoqBHQf4O
         jMVSkQ3DePWozCD24BNp/HNtuB5fw7h1EhCZJ8FMXhK7arEtwOJFKWNKOMkRar5MEecw
         VGYeqzgXxkGgQu4k9sHmoBKViMCg7EPdkiUAng3ONNlaQFiZ3Hl7LWyNPjZX9TqzvE5I
         KuocjQ4um1efOU/naDd03+Sb5nH5A1O9ZxjU8Q112k+6mwj98Vld5wGtR82NcedMUX5j
         vUyGSPxpo4hAChMUy9SuP3uFZSuCyl+u7aEPHKea92u4v07yhF8W5aIthaMBq6PguikF
         paVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CT/F6WABXrxDgwV5W6Oavn37EbmFXivRPDSuygeRcYo=;
        b=fpCwAsL8U/JE3yboaKEoQ0LNcWebqlzJppSxAZi6lfWbG5qcX5kaYViZNRZAXYUn3U
         nzoClFWtHx/tIc+v5RwmyI6u3OCRWO4pjPgH9Epn4h5yhloQmA4EAp7jCF39ReEQJWDH
         QAQiXcXTgtS3iDpzTq7OZ8F5fmXqpclOGWen3hr/P6JH69QwzEwVhlysUKX3zGInhHYx
         PDvRkl9QSZg8Dl7eB0l4bhI5/69ZnUNYxagsyrFneDr/YgfFM9H3d15wwBlLNz9Mt4yJ
         5l6o2RT2QA3VGrsosF2q8NOsVIN7y7Jt+yZ7SQ2vgYt5Nau34iILmSnyAbHZAz7fxX4m
         G54A==
X-Gm-Message-State: AOAM533FuIseEa3a7D+Jk8yb5umZG7fGORbEAF/kSPX93Nubrl2dlNDB
        LwK2POvpEMW9qnzuL3G8kwA=
X-Google-Smtp-Source: ABdhPJyTm78cy3YvRJOVyuMiDcQWmv0tSjq27cB4Cf9ajdEfwieJqkLVgIZ/nriPBI59K00YhtvOxQ==
X-Received: by 2002:aca:4a15:: with SMTP id x21mr3280962oia.116.1612283134386;
        Tue, 02 Feb 2021 08:25:34 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p22sm4629012oth.38.2021.02.02.08.25.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Feb 2021 08:25:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 2 Feb 2021 08:25:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: typec: tcpci_maxim: Enable data path when
 partner is USB Comm capable
Message-ID: <20210202162532.GC159455@roeck-us.net>
References: <20210202003101.221145-1-badhri@google.com>
 <20210202003101.221145-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202003101.221145-3-badhri@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 04:31:01PM -0800, Badhri Jagan Sridharan wrote:
> Configure USB switches when partner is USB Communication capable.
> The is enabled USB data communication over D+/D- pins.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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
> 
