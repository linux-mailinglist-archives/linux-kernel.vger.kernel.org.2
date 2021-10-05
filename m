Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACC6423083
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 21:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbhJETGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 15:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhJETGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 15:06:43 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB19C061749;
        Tue,  5 Oct 2021 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=eButU39qcaN9Nd+LF5xEgZScv1EWqZ53vsIQuSaMqUM=; b=ZQJhIN/qGwB2lK+lYkZEqwjtSY
        Oe5LHSaKCLMkhgx3ovjc9i416LeBvhK//kdWgo8zGFHz1AyLEm+oIbozntbmisMOS9gMIF1SrwwO3
        mfVQHSWUTVTj0UL7tG90IXYVRfNxoy8XF0xj3R/RXrvp6KSojDbMn0QKRRDaBSEHonTdSrxm+87DX
        6MGj2QGDiPDdhJuFPjHfqtrrgYukP+v5qJMcHsPAzyDXiAx6muzjYmHEYoFnRwPC3kKD+t7BeRIgQ
        DzfMr/5JfojzbVUKoyyUGbrcuMYtfi5YrwqA5AzFrGUYfEsYKTKu+DnxwnJzRP/ptZSDQ39XpUAVz
        vJx+NQlQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXpkB-00BdBC-O7; Tue, 05 Oct 2021 19:04:51 +0000
Subject: Re: [PATCH] usb: typec: STUSB160X should select REGMAP_I2C
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        linux-usb@vger.kernel.org
References: <20211004232103.23893-1-rdunlap@infradead.org>
 <YVw7lJ5TeFsYwAgC@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7c405d70-5001-e4d4-57d1-fbdee5a7a464@infradead.org>
Date:   Tue, 5 Oct 2021 12:04:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVw7lJ5TeFsYwAgC@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 4:48 AM, Greg Kroah-Hartman wrote:
> On Mon, Oct 04, 2021 at 04:21:03PM -0700, Randy Dunlap wrote:
>> REGMAP_I2C is not a user visible kconfig symbol so driver configs
>> should not "depend on" it. They should depend on I2C and then
>> select REGMAP_I2C.
>>
>> If this worked, it was only because some other driver had set/enabled
>> REGMAP_I2C.
>>
>> Fixes: da0cb6310094 ("usb: typec: add support for STUSB160x Type-C controller family")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Cc: Amelie Delaunay <amelie.delaunay@st.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-usb@vger.kernel.org
>> ---
>>   drivers/usb/typec/Kconfig |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> With this applied, I get the following build error:
> 
> drivers/of/Kconfig:69:error: recursive dependency detected!
> drivers/of/Kconfig:69:	symbol OF_IRQ depends on IRQ_DOMAIN
> kernel/irq/Kconfig:59:	symbol IRQ_DOMAIN is selected by REGMAP
> drivers/base/regmap/Kconfig:7:	symbol REGMAP default is visible depending on REGMAP_I2C
> drivers/base/regmap/Kconfig:20:symbol REGMAP_I2C is selected by TYPEC_STUSB160X
> drivers/usb/typec/Kconfig:66:	symbol TYPEC_STUSB160X depends on USB_ROLE_SWITCH
> drivers/usb/roles/Kconfig:3:	symbol USB_ROLE_SWITCH is selected by USB_MUSB_MEDIATEK
> drivers/usb/musb/Kconfig:119:	symbol USB_MUSB_MEDIATEK depends on GENERIC_PHY
> drivers/phy/Kconfig:8:	symbol GENERIC_PHY is selected by PHY_BCM_NS_USB3
> drivers/phy/broadcom/Kconfig:49:	symbol PHY_BCM_NS_USB3 depends on MDIO_BUS
> drivers/net/mdio/Kconfig:13:	symbol MDIO_BUS depends on MDIO_DEVICE
> drivers/net/mdio/Kconfig:6:	symbol MDIO_DEVICE is selected by PHYLIB
> drivers/net/phy/Kconfig:16:	symbol PHYLIB is selected by ARC_EMAC_CORE
> drivers/net/ethernet/arc/Kconfig:19:	symbol ARC_EMAC_CORE is selected by ARC_EMAC
> drivers/net/ethernet/arc/Kconfig:25:	symbol ARC_EMAC depends on OF_IRQ
> For a resolution refer to Documentation/kbuild/kconfig-language.rst
> subsection "Kconfig recursive dependency limitations"
> 
> So I can't take it as-is :(

Darn, I never saw that, but I'll look into it.

thanks.

-- 
~Randy
