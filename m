Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8984225A5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhJELub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230500AbhJELu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:50:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D6C561244;
        Tue,  5 Oct 2021 11:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633434518;
        bh=xk7MxO9Fxnuns/+KM8Frjyu3gXpYqc1yrwJcw4nB31A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KswjUeyBfELdQTckIMtgk+Ct3HWF/tmFafOI9W6dDj2Iv+ofySK3NwRh2TieQ49jh
         CfgNFK2tINxx1+Ru9e6NlZinTb78fTJLF1Do3Ac8JxDWuynXE3klncf/hTPvBoywP9
         ccQyGn4PzIksLXIWUBIo8QK3Rixy28321yBC7FAg=
Date:   Tue, 5 Oct 2021 13:48:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: STUSB160X should select REGMAP_I2C
Message-ID: <YVw7lJ5TeFsYwAgC@kroah.com>
References: <20211004232103.23893-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004232103.23893-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 04:21:03PM -0700, Randy Dunlap wrote:
> REGMAP_I2C is not a user visible kconfig symbol so driver configs
> should not "depend on" it. They should depend on I2C and then
> select REGMAP_I2C.
> 
> If this worked, it was only because some other driver had set/enabled
> REGMAP_I2C.
> 
> Fixes: da0cb6310094 ("usb: typec: add support for STUSB160x Type-C controller family")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Amelie Delaunay <amelie.delaunay@st.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> ---
>  drivers/usb/typec/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

With this applied, I get the following build error:

drivers/of/Kconfig:69:error: recursive dependency detected!
drivers/of/Kconfig:69:	symbol OF_IRQ depends on IRQ_DOMAIN
kernel/irq/Kconfig:59:	symbol IRQ_DOMAIN is selected by REGMAP
drivers/base/regmap/Kconfig:7:	symbol REGMAP default is visible depending on REGMAP_I2C
drivers/base/regmap/Kconfig:20:symbol REGMAP_I2C is selected by TYPEC_STUSB160X
drivers/usb/typec/Kconfig:66:	symbol TYPEC_STUSB160X depends on USB_ROLE_SWITCH
drivers/usb/roles/Kconfig:3:	symbol USB_ROLE_SWITCH is selected by USB_MUSB_MEDIATEK
drivers/usb/musb/Kconfig:119:	symbol USB_MUSB_MEDIATEK depends on GENERIC_PHY
drivers/phy/Kconfig:8:	symbol GENERIC_PHY is selected by PHY_BCM_NS_USB3
drivers/phy/broadcom/Kconfig:49:	symbol PHY_BCM_NS_USB3 depends on MDIO_BUS
drivers/net/mdio/Kconfig:13:	symbol MDIO_BUS depends on MDIO_DEVICE
drivers/net/mdio/Kconfig:6:	symbol MDIO_DEVICE is selected by PHYLIB
drivers/net/phy/Kconfig:16:	symbol PHYLIB is selected by ARC_EMAC_CORE
drivers/net/ethernet/arc/Kconfig:19:	symbol ARC_EMAC_CORE is selected by ARC_EMAC
drivers/net/ethernet/arc/Kconfig:25:	symbol ARC_EMAC depends on OF_IRQ
For a resolution refer to Documentation/kbuild/kconfig-language.rst
subsection "Kconfig recursive dependency limitations"

So I can't take it as-is :(

thanks,

greg k-h
