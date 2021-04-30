Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B5836FAD6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 14:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhD3Mqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 08:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbhD3Mqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 08:46:42 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F19C06123E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 05:43:36 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout1.routing.net (Postfix) with ESMTP id 7C9764009A;
        Fri, 30 Apr 2021 12:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1619786614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Icrc7EFL5BUHi1eYahCvzZ+YzD3iOur+Sxb89HRIcns=;
        b=dSw6qOZOcuuy0Y16DK9t3T5tJDiGkH9DdNysT8eVGLodCZoYpJf5qnSjJ/8YB1XnebO720
        +DuUAJ8cCqo7G3eYgEf443jhKFkv/mDD5gIlnM0R6VdTIkQ8U7WSDt9MH5TjCzwjcfF6Vx
        P3/+ts9c3RX8y92JqgIIQYjSuB/1dVw=
Received: from localhost.localdomain (fttx-pool-157.180.225.50.bambit.de [157.180.225.50])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 7F99F360499;
        Fri, 30 Apr 2021 12:43:33 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        David Miller <davem@davemloft.net>,
        DENG Qingfang <dqfext@gmail.com>
Subject: [PATCH] musb: mediatek: rename driver
Date:   Fri, 30 Apr 2021 14:43:17 +0200
Message-Id: <20210430124317.97376-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 90a10fd3-9eba-4320-aec9-e63f16763ee2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

currently unspecific mediatek.ko is built,
change this by adding subsystem

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/usb/musb/Makefile                   | 2 +-
 drivers/usb/musb/{mediatek.c => musb_mtk.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/usb/musb/{mediatek.c => musb_mtk.c} (100%)

diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
index 932247360a9f..82928d4fd42a 100644
--- a/drivers/usb/musb/Makefile
+++ b/drivers/usb/musb/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_USB_MUSB_DA8XX)			+= da8xx.o
 obj-$(CONFIG_USB_MUSB_UX500)			+= ux500.o
 obj-$(CONFIG_USB_MUSB_JZ4740)			+= jz4740.o
 obj-$(CONFIG_USB_MUSB_SUNXI)			+= sunxi.o
-obj-$(CONFIG_USB_MUSB_MEDIATEK)      		+= mediatek.o
+obj-$(CONFIG_USB_MUSB_MEDIATEK)      		+= musb_mtk.o
 
 # the kconfig must guarantee that only one of the
 # possible I/O schemes will be enabled at a time ...
diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/musb_mtk.c
similarity index 100%
rename from drivers/usb/musb/mediatek.c
rename to drivers/usb/musb/musb_mtk.c
-- 
2.25.1

