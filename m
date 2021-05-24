Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F8C38E65B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhEXMNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:13:22 -0400
Received: from mx4.securetransport.de ([178.254.6.145]:37938 "EHLO
        mx4.securetransport.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbhEXMNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:13:19 -0400
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 May 2021 08:13:19 EDT
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id 9EB63720B0C;
        Mon, 24 May 2021 14:02:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1621857768;
        bh=hCvDzoYPXt/Y1dg/Wu3nLGu1tCwbnZIscplSYWo0+5w=;
        h=From:To:CC:Subject:Date:From;
        b=XDXgENTp98qDpL3kP17o42550eHD75qwD4Rhw4TfXaBbN5irumFPCU2hpKe6FEYK7
         9NiVBaEW+3lxlHLOCQO31AOg6ufpd5iIM5PmfcIwVdXxV1iYhHjYxH53bIZTxmwZL5
         YKkWyA4YvRPuVbsO6FpX9XAHdXsQSoIbzohINchX15nKVUKB1dpBFhRuTez0OPVnbZ
         FWpocIiEiygPI5XhtFPgC0WwrZzsZUD8nlpauPCDDZFdqKsIcDavUtKvXOJ+LnqNa8
         UiBcxTqVpQ0ysDnQPdPYmaDYRADSZzPsmyHa7PwQL5gp82Mdy4fTaFmIU/bxMt96Av
         9ma9nlml+BoKg==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) by
 DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.12; Mon, 24 May 2021 14:02:34 +0200
Received: from localhost.localdomain (172.16.51.17) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.12
 via Frontend Transport; Mon, 24 May 2021 14:02:34 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@dh-electronics.com>
Subject: [PATCH] MAINTAINERS: Add maintainers for DHCOM i.MX6 and DHCOM/DHCOR STM32MP1
Date:   Mon, 24 May 2021 13:58:53 +0200
Message-ID: <20210524115853.6413-1-cniedermaier@dh-electronics.com>
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
To: linux-kernel@vger.kernel.org
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 07f0414bc2a5..c3836d34e844 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5320,6 +5320,19 @@ F:	include/net/devlink.h
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

