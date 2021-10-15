Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE39742E62F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 03:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhJOBiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 21:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhJOBiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 21:38:16 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C895C061570;
        Thu, 14 Oct 2021 18:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=gKuu7JZvsHEoZADOP2+vtptCtJ+NZ33CHev+SFDbdcg=; b=AFCmomsOpoHCnwCozFXKKDdfzk
        0X3z37dRzdiaUNx6brqJ+Gw4s1coMcBu5E91+K6CGvP17w+DWso6GdeHyKHAHDVFWNpN2yEd0EHmK
        hoILQd6lBuYe9gU/5QGSJDb9rDTM2S9NmpD9NY27ckH7GHRzsZnsvAOV90ailNemxryxVhVZ679Re
        QsGXHdcYLQHIMoeFvWnEFaKglbhMSzc9yxBb5MReuMAFE+IdseoJ6BHOVZyt1JZaDUCsPHN5deCUR
        gZsgp1Z08vRMicfmrftTeDt2YHGLtg6e8k+Ua68fT4lHpt/+v9GxmTDFs6ArDEXT2GfbuOFaZZqUY
        JSigX6fw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbC8o-004wtp-7F; Fri, 15 Oct 2021 01:36:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2] usb: typec: STUSB160X should select REGMAP_I2C
Date:   Thu, 14 Oct 2021 18:36:09 -0700
Message-Id: <20211015013609.7300-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

REGMAP_I2C is not a user visible kconfig symbol so driver configs
should not "depend on" it. They should depend on I2C and then
select REGMAP_I2C.

If this worked, it was only because some other driver had set/enabled
REGMAP_I2C.

Fixes: da0cb6310094 ("usb: typec: add support for STUSB160x Type-C controller family")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
v2: add Reviewed-by: tags
    rebase and resend
    add patch dependency (below)

This patch depends on this patch that is in usb-next:
  [PATCH] usb: musb: select GENERIC_PHY instead of depending on it
  lore.kernel.org/r/20211005235747.5588-1-rdunlap@infradead.org

 drivers/usb/typec/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20211013.orig/drivers/usb/typec/Kconfig
+++ linux-next-20211013/drivers/usb/typec/Kconfig
@@ -65,9 +65,9 @@ config TYPEC_HD3SS3220
 
 config TYPEC_STUSB160X
 	tristate "STMicroelectronics STUSB160x Type-C controller driver"
-	depends on I2C
-	depends on REGMAP_I2C
 	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
+	depends on I2C
+	select REGMAP_I2C
 	help
 	  Say Y or M here if your system has STMicroelectronics STUSB160x
 	  Type-C port controller.
