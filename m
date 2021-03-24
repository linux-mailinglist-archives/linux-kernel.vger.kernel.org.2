Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4045B347DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbhCXQln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:41:43 -0400
Received: from gloria.sntech.de ([185.11.138.130]:35622 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233671AbhCXQl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:41:27 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lP6ZO-0001QD-TS; Wed, 24 Mar 2021 17:41:22 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>, gregkh@linuxfoundation.org,
        balbi@kernel.org
Cc:     robh+dt@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/8] usb: dwc3: of-simple: bail probe if no dwc3 child node
Date:   Wed, 24 Mar 2021 17:41:22 +0100
Message-ID: <1861638.PYKUYFuaPT@diego>
In-Reply-To: <20210209192350.7130-2-jbx6244@gmail.com>
References: <20210209192350.7130-1-jbx6244@gmail.com> <20210209192350.7130-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Felipe,

Am Dienstag, 9. Februar 2021, 20:23:44 CET schrieb Johan Jonker:
> For some of the dwc3-of-simple compatible SoCs we
> don't want to bind this driver to a dwc3 node,
> but bind that node to the 'snps,dwc3' driver instead.
> The kernel has no logic to decide which driver to bind
> to if there are 2 matching drivers, so bail probe if no
> dwc3 child node.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

It looks like this patch fell through the cracks?

I.e. I can see patches 1+6 adding the devicetree bindings
in 5.12-rc but haven't found this patch there.

And looking at
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/log/drivers/usb/dwc3/dwc3-of-simple.c?h=usb-next
I also didn't find it.

From what I gathered that was somehow mandated from the Devicetree side
as the dwc3-subnode system merely is some Linux-specific thingy
and should not be enforced if not explicitly needed.

I guess Johan can provide pointers to the previous discussion.

So could you look at applying this patch to some usb-tree?


Thanks
Heiko


> ---
>  drivers/usb/dwc3/dwc3-of-simple.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> index e62ecd22b..347b4d384 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -38,6 +38,10 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>  
>  	int			ret;
>  
> +	/* Bail probe if no dwc3 child node. */
> +	if (!of_get_compatible_child(dev->of_node, "snps,dwc3"))
> +		return -ENODEV;
> +
>  	simple = devm_kzalloc(dev, sizeof(*simple), GFP_KERNEL);
>  	if (!simple)
>  		return -ENOMEM;
> 




