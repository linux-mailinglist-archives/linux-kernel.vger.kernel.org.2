Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4A135213C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhDAVA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbhDAVAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:00:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A61C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=n1pVqEnDA94zWJ5OljAPLmIt0VPuoXxcB8fy86DJBH8=; b=OcXu3kEAH/PG5O6cHtmbMw59gt
        s0L5W8iGRTBWmb0s5Uemd1voj4dFxVr7GosasYRcUE4MurzMf5mGHKVXX3uEz92DVq8W0zne9BB6S
        jqP4+QnxOo+g6fcL6yravFNVQfPCsfa1Y1Y+wXF71p0pcSUyJiX9E4fw8m1TPOpKHIYW/LlRLmivg
        nETV+BeF+Thl+Eag63eSNotSuRFpMkzuwRwtW1B9U7UljOyvf7WicP2WmXOP4UYSaftcfi/HRxpOB
        RgMBK0S2l61dWvKjO1U/WY6mHJNxal5Pkro0rRzPqWWSrTu4pcQacXiMFxBkfpKDjA6BOjmagvvvF
        2JuMlkfA==;
Received: from [2601:1c0:6280:3f0::e0e1] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lS4Qs-00B0d6-TX; Thu, 01 Apr 2021 21:00:51 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Kostya Porotchkin <kostap@marvell.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org
Subject: [PATCH -next] phy: marvell: phy-mvebu-cp11i-utmi needs USB_COMMON
Date:   Thu,  1 Apr 2021 14:00:45 -0700
Message-Id: <20210401210045.23525-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When USB and USB_COMMON are not enabled, phy-mvebu-cp110-utmi
suffers a build error due to a missing interface that is provided
by CONFIG_USB_COMMON, so make the driver depend on USB_COMMON.

ld: drivers/phy/marvell/phy-mvebu-cp110-utmi.o: in function `mvebu_cp110_utmi_phy_probe':
phy-mvebu-cp110-utmi.c:(.text+0x152): undefined reference to `of_usb_get_dr_mode_by_phy'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kostya Porotchkin <kostap@marvell.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: linux-phy@lists.infradead.org
---
 drivers/phy/marvell/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210331.orig/drivers/phy/marvell/Kconfig
+++ linux-next-20210331/drivers/phy/marvell/Kconfig
@@ -70,7 +70,7 @@ config PHY_MVEBU_CP110_COMPHY
 config PHY_MVEBU_CP110_UTMI
 	tristate "Marvell CP110 UTMI driver"
 	depends on ARCH_MVEBU || COMPILE_TEST
-	depends on OF
+	depends on OF && USB_COMMON
 	select GENERIC_PHY
 	help
 	  Enable this to support Marvell CP110 UTMI PHY driver.
