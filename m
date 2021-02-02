Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347A130C5A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbhBBQ2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbhBBQ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:26:06 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DC0C061786;
        Tue,  2 Feb 2021 08:25:25 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id k8so20362942otr.8;
        Tue, 02 Feb 2021 08:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8qpjCVpfsHX2AIFNw0saiuCmrgZLB2nZof3OkZsMUIY=;
        b=MtjQLpqDg//C4cmpaGz1rR6AjkA8JnaS8KEv9+oN/fIOja7Yf8iqWD/vp6xuvINFUL
         6fHThocMr9aFGiFaFliksB8f/LPsoWYtOxQaon7CGwIvT6K6oSbh0qm4PiqcFOoYp6pT
         nJRr70SIyca3J3yyEqdfbKbiHLPXMGdAq7WYAOd8LDsjhKrNx5CqVb4nSzmqw35Px6K1
         f3nJBUAV1GsNY3vEhtrERGW+Ip/9Gu1P+zstBg+deHan+f5MK8t+fvX8fqS+j84B30Yw
         HNtQO4OA/6KOL7XZ646AvOPH4N4glsOU3wi3+yAkbCjF5uejReVeW1hQetSVJeQmn2gA
         Lidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8qpjCVpfsHX2AIFNw0saiuCmrgZLB2nZof3OkZsMUIY=;
        b=GevoANV9AEH/kobB7o+jk40u+zsTrd3MOUMRQzg3AOxi2DqPKzJ3bZzweG2EJo9tyh
         XPnvOGXMNjB+2eKvIaS6BMDDZ6ALT0OZXuTV1JMt/zxXrx5zRQQO4PbYcHbCjDMVvke8
         BCmSVr6CGApHwoc9NHx1SZ/MR4ms/LYfwYe7CDt+xBw0lYMOIBSEC4t/us+7zYwbLzFm
         tR4zc3rpAZ769q7o6iV/pmoogfnLy/ln1Uuhcg2789cuVOS9awqFfEGt44B41sGFjrC2
         sZlbHMpfiqv2uwAeikn1msffjcngmJEEgV2aTX672tAqr7taxTe5nsZ2UA/xDMUpzQd9
         FM1Q==
X-Gm-Message-State: AOAM531VEz6JNSeFaKAf50hEA0PpwVBT0PGc+fZqoy3KDol/opUjl8uA
        SGY4FmCTV+yxN5YCeg9JfIQ=
X-Google-Smtp-Source: ABdhPJwV38TS/t9OQuN2ujZdvcAJZboQB6ox/icmMdcFbUXTO+CxYZnHPJGagJYPDbxlUiJx4ftr7Q==
X-Received: by 2002:a05:6830:1db8:: with SMTP id z24mr16146305oti.50.1612283124685;
        Tue, 02 Feb 2021 08:25:24 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r1sm4882811ooq.16.2021.02.02.08.25.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Feb 2021 08:25:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 2 Feb 2021 08:25:22 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: typec: tcpci: Add Callback to Usb
 Communication capable partner
Message-ID: <20210202162522.GB159455@roeck-us.net>
References: <20210202003101.221145-1-badhri@google.com>
 <20210202003101.221145-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202003101.221145-2-badhri@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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
> 
