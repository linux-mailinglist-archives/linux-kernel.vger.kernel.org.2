Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF4C330A3B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCHJYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:24:03 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:57290 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhCHJXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615195419; x=1646731419;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t+UOUkwcg7Donuf4Ef3A+lHrx7xJY3uSrfPoIMoZwaQ=;
  b=ngCIXF5UkEFOijos0UUBXQODDXHgknD5xmj7YF3tyDSGgZxl2xAvMWaz
   cTL1EAQ8FQfirXXZOnWrAeyH6hskPE7jbMtVu2Pzua/bTrqsY5+4bmTGn
   qtAI3hSABMjIFtPBFGL7zBOa/8c06qOIIMS/H+erGJLyRo8wDp/BpTN0v
   qmGnmz0Q4U59j5VtDrFkjdZi6YMOH2zD5bv9pjSxURZjGtR9buE9IqdbE
   Z0ePwzjCVotyiwGIS+bqL7hUStCDuFcGYKwdV26IM4Hv0CsEwYELAd/63
   lbDCZ3A5hLWhiRZ72r9q4CcOm+mqC5Csvid7z/8oeHM3/JDWnfJJoLTVp
   Q==;
IronPort-SDR: iDm6+PrulpIULTybzJquytWn522T0EuLG6vcyQeNs7PgUgh8dcuanwXwQkU11e8/pqemX9Cljv
 Dm2T8xK0UcNZTT8uGCQCFAwgNQBJyKxzupBdUt18F8+QMi6d3qjHP8A0RJjXqfuRGi0wMubjIZ
 yXg0mUHYasG9kqWjJXpE9xqMNs/3TMQpIUj98flNPo8/CpbQNboJUcy/nw0bTor7XlDLQpR0GI
 qICJfZXdAPfZLnTz7GAgVQqg1iBzHpOxWOtK6ve70ca8Ikg53x6xB1xFIFPA8/vBxwCk7J1yve
 WNY=
X-IronPort-AV: E=Sophos;i="5.81,232,1610434800"; 
   d="scan'208";a="109122180"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2021 02:23:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 8 Mar 2021 02:23:37 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 8 Mar 2021 02:23:35 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH] MAINTAINERS: Add Michael and Pratyush as designated reviewers for SPI NOR
Date:   Mon, 8 Mar 2021 11:23:32 +0200
Message-ID: <20210308092333.80521-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
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

