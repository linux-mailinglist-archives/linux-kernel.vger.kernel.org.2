Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3964234B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 01:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbhJEX7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 19:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhJEX7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 19:59:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA50BC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=LIWAbP1laTaOkfp/thplM30iLlRoESrtPM9d9L3fdYA=; b=WFQW1FLCLGCZx0qVRwhz8XENMy
        iR0vqd/hWVuepbMproZb0KA+EyjyYCIZci72eFfBJ3Vo0eUY4TPVDPx3vTxHmmSNo0BqDsJ3lwDSu
        +kYs4gXV0UVTw3C486DMuZyjEi1s16Hs0gbElEqBLHOnNtWoKADhnOMGI6nEyTBKmp7/JsM6+vaZu
        67OxApghoY0HDc742RcdxLAjZtOEB16C1wEb2YEZPL4LNmXChG5X0dpjloKod7NEBRr5z+VC7mj1U
        NW0e+8fOjWf0tEUDM+xec1Xe8hbvoRO+Q9yS9h21doDORe0JHjRFpu6UCXJxYiHGa8zGykvjrHVAl
        BWOPkkNg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXuJg-00CIJ3-Lv; Tue, 05 Oct 2021 23:57:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Bin Liu <b-liu@ti.com>,
        Min Guo <min.guo@mediatek.com>,
        Yonglong Wu <yonglong.wu@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] usb: musb: select GENERIC_PHY instead of depending on it
Date:   Tue,  5 Oct 2021 16:57:47 -0700
Message-Id: <20211005235747.5588-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kconfig symbol GENERIC_PHY says:
  All the users of this framework should select this config.
and around 136 out of 138 drivers do so, so change USB_MUSB_MEDIATEK
to do so also.

This (also) fixes a long circular dependency problem for an upcoming
patch.

Fixes: 0990366bab3c ("usb: musb: Add support for MediaTek musb controller")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bin Liu <b-liu@ti.com>
Cc: Min Guo <min.guo@mediatek.com>
Cc: Yonglong Wu <yonglong.wu@mediatek.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mediatek@lists.infradead.org
---
Applies to mainline.

 drivers/usb/musb/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211005.orig/drivers/usb/musb/Kconfig
+++ linux-next-20211005/drivers/usb/musb/Kconfig
@@ -120,7 +120,7 @@ config USB_MUSB_MEDIATEK
 	tristate "MediaTek platforms"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on NOP_USB_XCEIV
-	depends on GENERIC_PHY
+	select GENERIC_PHY
 	select USB_ROLE_SWITCH
 
 comment "MUSB DMA mode"
