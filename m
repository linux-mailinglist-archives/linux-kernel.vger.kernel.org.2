Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7BC43908D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhJYHro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:47:44 -0400
Received: from mx2.securetransport.de ([188.68.39.254]:35786 "EHLO
        mx2.securetransport.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbhJYHrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:47:42 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Oct 2021 03:47:42 EDT
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id 649E35E8AB;
        Mon, 25 Oct 2021 09:38:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1635147515;
        bh=kx1P8W4qyfT/TfaLi3bO415+yY1pKjzYldhhNRTAwpA=;
        h=From:To:CC:Subject:Date:From;
        b=r0ekW7zxhHfQTmzKE/8BFng4nCfwkD90GbkckK5i8IlFyhzV2aHAncyCIVCQ8Bh4a
         T/2bYE6xBC5ITIBED1i3mAsZ7W10JhQKk1gcGqqo0xgY4ywEKo3kdbuBVxUfLTtwhU
         XRXzDsU6dW5YvhFeOoIW7lzcdOEcMpYfb7bYHNFElAopX+Ro3lv+fQyD252IbJPJTk
         X0QbO4Lgx1fST581ud64kMwExa/8iPPWfgd1TK0B40313hhivU+eXXLdccsEQx20lO
         aHo1o/rlHZJ/kbBcV4mVJEewVPStqDvhG+xGuE9qPbeCiUyP7yuxARRdr18qnCkTnp
         HtuMuoEDJ4/wA==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) by
 DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Mon, 25 Oct 2021 09:38:31 +0200
Received: from localhost.localdomain (172.16.51.18) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9
 via Frontend Transport; Mon, 25 Oct 2021 09:38:31 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <soc@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel@dh-electronics.com>, <arnd@arndb.de>
Subject: [PATCH V2] MAINTAINERS: Add maintainers for DHCOM i.MX6 and DHCOM/DHCOR STM32MP1
Date:   Mon, 25 Oct 2021 09:37:06 +0200
Message-ID: <20211025073706.2794-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers for DH electronics DHCOM i.MX6
and DHCOM/DHCOR STM32MP1 boards.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kernel@dh-electronics.com
Cc: arnd@arndb.de
To: soc@kernel.org
To: linux-kernel@vger.kernel.org
---
V2: - Rebase on next-20211022
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 88fcc4e7ff37..affedd5585f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5506,6 +5506,19 @@ F:	include/net/devlink.h
 F:	include/uapi/linux/devlink.h
 F:	net/core/devlink.c
 
+DH ELECTRONICS IMX6 DHCOM BOARD SUPPORT
+M:	Christoph Niedermaier <cniedermaier@dh-electronics.com>
+L:	kernel@dh-electronics.com
+S:	Maintained
+F:	arch/arm/boot/dts/imx6*-dhcom-*
+
+DH ELECTRONICS STM32MP1 DHCOM/DHCOR BOARD SUPPORT
+M:	Marek Vasut <marex@denx.de>
+L:	kernel@dh-electronics.com
+S:	Maintained
+F:	arch/arm/boot/dts/stm32mp1*-dhcom-*
+F:	arch/arm/boot/dts/stm32mp1*-dhcor-*
+
 DIALOG SEMICONDUCTOR DRIVERS
 M:	Support Opensource <support.opensource@diasemi.com>
 S:	Supported
-- 
2.11.0

