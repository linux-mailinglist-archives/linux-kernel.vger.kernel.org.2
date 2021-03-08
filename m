Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD4C330A3D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCHJYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:24:04 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:57290 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhCHJXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615195421; x=1646731421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t+UOUkwcg7Donuf4Ef3A+lHrx7xJY3uSrfPoIMoZwaQ=;
  b=VpvmaF8HnVmyzn5P1OJYP6mRZo/DQDWE5/EtkHA4e2757LqT5OGErm47
   F1W09sauB0wbF9X2Z1pECWc5ZOUAopKN6rQkAAtM/SmgA29qigJNjaLrV
   u8H5Up6FRLahI8ARIiEk1UK0SOW1Gl/fD/FLvTIiHkpuZSwO2zrC0tOoo
   z/SsxyaAdPbM4TebtljPGTxnF3TrpwiqzLYaAjYsCUIzqaiYSSQLvkpus
   Gc9IVc7f0/tdmT9OySjsB91wB2Xg/Y4oiyYGmND3dk2EOYYcc5z+kMo4O
   3jcCgWzX1uOyj3+uXt5YH9sIQAvcbk8SB3NOhaWpnYMexKCJUBo4ijlMa
   g==;
IronPort-SDR: UrzNhQXqwUrSeh5cVcum0lAsY7vylUPTnrXGpb1gu4K2nAYjReFp0eQCTJVHdufSI8/9L74h8G
 1tTAJdiL8icI1i2OX5T8OKVoun3DTDckbb3aKjf2u6eSMtRYAOrkCR2qHaLBHMQpTzUgwEGz1v
 /berCgpXhh1b2CZgcO+1AJdbxP2tp16hPeYx4V3byyzvJO/fTC+5ZzTf3fyzsZdjvFDH4hgkNJ
 57UKyM91iCw/eSHChOzuWTcJ7yz7o+PVmQbMooUy0qcXaZ8c1tzw7j7lUEbujGtvoCh3IlAc1B
 CwQ=
X-IronPort-AV: E=Sophos;i="5.81,232,1610434800"; 
   d="scan'208";a="109122192"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2021 02:23:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 8 Mar 2021 02:23:40 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 8 Mar 2021 02:23:38 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH] MAINTAINERS: Add Michael and Pratyush as designated reviewers for SPI NOR
Date:   Mon, 8 Mar 2021 11:23:33 +0200
Message-ID: <20210308092333.80521-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308092333.80521-1-tudor.ambarus@microchip.com>
References: <20210308092333.80521-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's already been the case for some time that Michael and Pratyush
are reviewing SPI NOR patches. Update MAINTAINERS to reflect reality.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
Michael, Pratyush, please send your Acked-by tags if you agree.

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..ba561e5bc6f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16862,6 +16862,8 @@ F:	arch/arm/mach-spear/
 
 SPI NOR SUBSYSTEM
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
+R:	Michael Walle <michael@walle.cc>
+R:	Pratyush Yadav <p.yadav@ti.com>
 L:	linux-mtd@lists.infradead.org
 S:	Maintained
 W:	http://www.linux-mtd.infradead.org/
-- 
2.25.1

