Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E2242C07B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhJMMr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:47:56 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:62788 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232366AbhJMMry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1634129151; x=1665665151;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cm1gOmeq3xJAWm1Z9epWnIZ/SO37pF3g8ipm3SbWxWc=;
  b=JMeXKACwSEsj9ZNXTzSm5tDHrzUPk641PjKB7mnqT0E/S9CyMEIWReiJ
   IpdI13D4im0bMyYEgcmwoY6zeWWaMvZAmwpuOvyWhj83mzRTxQPQQUi5I
   4SJ57o+yiBntkB4GZVOF1Z3BKNhj+Y40NkCkJIhm5jqqI+0J8tKxnmJQU
   FglabwsDHyLkf3RfHEPNqJYBGJ9H29wEJIFi7g1EZx+mvneaNVP4lGNKn
   JLqFMU8XktUlf2YUxdkFrCKcAsACRkbcroqzpJ7nkk8A+QURv8lhBGiDs
   SfU0VsGFHsH5DWps1gYEV+G7LZ8URFloJz3oM4IqjxnsDZ7w2dz1ErhN7
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,370,1624312800"; 
   d="scan'208";a="20023669"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 13 Oct 2021 14:45:50 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 13 Oct 2021 14:45:50 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 13 Oct 2021 14:45:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1634129150; x=1665665150;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cm1gOmeq3xJAWm1Z9epWnIZ/SO37pF3g8ipm3SbWxWc=;
  b=PYM0J8QSd/H6boZGWYRbmnbXypA97XA7nTAzojYIdx9s1u6FZaOaTNIQ
   AOIDGf3HCeEI+9i9eVnKQ3LR4KzkMVpXhy4RDGIbYf/68iamZRPZxl/r0
   wiihDD4476O6KYBM8jmEQfC74m1Wm8kWwKyq9fSZmSRoZ+9v/O7CYoLJf
   rBRYd8/kBsslwskT1SJIhcsZvKRUsiLG/4lWUq95ZUqOeHsE7ENCxY4W4
   MHR0Zzl/xR2XELRBNe+ju6LaSswRTJphalm/IUMK7iKsyMSQeU9kRW7bu
   5ZRS16zANnyv2h1M/ayV50sSIu7RaLaI/i0oPNX+Rm2vLDKaFs8wA3NDy
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,370,1624312800"; 
   d="scan'208";a="20023668"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Oct 2021 14:45:50 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 2212B280065;
        Wed, 13 Oct 2021 14:45:50 +0200 (CEST)
Message-ID: <00afb7b8bc6f7ad41cd6770532294992a667f1af.camel@ew.tq-group.com>
Subject: Re: [PATCH v3 9/9] PCI: imx: add the imx8mm pcie support
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com, l.stach@pengutronix.de,
        tharvey@gateworks.com, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org
Date:   Wed, 13 Oct 2021 14:45:50 +0200
In-Reply-To: <1634028078-2387-10-git-send-email-hongxing.zhu@nxp.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
         <1634028078-2387-10-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-12 at 16:41 +0800, Richard Zhu wrote:
> i.MX8MM PCIe works mostly like the i.MX8MQ one, but has a different PHY
> and allows to output the internal PHY reference clock via the refclk pad.
> Add the i.MX8MM PCIe support based on the standalone PHY driver.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
> [...]
> @@ -1130,6 +1176,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  				 &imx6_pcie->tx_swing_low))
>  		imx6_pcie->tx_swing_low = 127;
>  
> +	/* get PHY refclk pad mode if there is PHY node */
> +	phy_node = of_parse_phandle(node, "phys", 0);
> +	if (phy_node) {
> +		of_property_read_u32(phy_node, "fsl,refclk-pad-mode",
> +				     &imx6_pcie->refclk_pad_mode);

It seems to me that the refclk_pad_mode is not actually used by this
driver anymore, because it is handled by the PHY driver now. Is there a
reason to read this property here at all?


