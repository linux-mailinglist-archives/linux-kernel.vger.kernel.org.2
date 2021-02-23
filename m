Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAA8322F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhBWQ4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:56:18 -0500
Received: from netrider.rowland.org ([192.131.102.5]:60701 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233635AbhBWQ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:56:04 -0500
Received: (qmail 1267268 invoked by uid 1000); 23 Feb 2021 11:55:21 -0500
Date:   Tue, 23 Feb 2021 11:55:21 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     f.fainelli@gmail.com, jonas.gorski@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] usb: host: ehci-platform: add ignore_oc DT support
Message-ID: <20210223165521.GE1261797@rowland.harvard.edu>
References: <20210223155005.21712-1-noltari@gmail.com>
 <20210223161644.6095-1-noltari@gmail.com>
 <20210223161644.6095-3-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210223161644.6095-3-noltari@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 05:16:44PM +0100, Álvaro Fernández Rojas wrote:
> Over-current reporting isn't supported on some platforms such as bcm63xx.
> These devices will incorrectly report over-current if this flag isn't properly
> activated.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  v2: change flag name and improve documentation as suggested by Alan Stern.
> 
>  drivers/usb/host/ehci-platform.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index a48dd3fac153..2c587e31d010 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -286,6 +286,9 @@ static int ehci_platform_probe(struct platform_device *dev)
>  		if (of_property_read_bool(dev->dev.of_node, "big-endian"))
>  			ehci->big_endian_mmio = ehci->big_endian_desc = 1;
>  
> +		if (of_property_read_bool(dev->dev.of_node, "spurious-oc"))
> +			ehci->ignore_oc = 1;
> +
>  		if (of_property_read_bool(dev->dev.of_node,
>  					  "needs-reset-on-resume"))
>  			priv->reset_on_resume = true;

Acked-by: Alan Stern <stern@rowland.harvard.edu>
