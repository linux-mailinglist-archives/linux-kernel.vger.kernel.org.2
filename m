Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B646434833
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhJTJt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:49:26 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:15634 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhJTJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634723230; x=1666259230;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UZJtUpcflAYlIAyWg4bRIWtgTkd7D0B2b/MpATP2RCQ=;
  b=mIi6qzGvGjhhe6ulE4L4ZBZJs1y7poGl88hB/+91MSM1CZVuGDju64lY
   27n0d3Y5/3CN6Y/h2s0XyPxtBiFKvjK/6t3QZUYyy5ws39rcByRjKCP29
   4xusX99S9hwunsUqSQziSGOpqCiYzHb4z3bI4pTAfGN4c8QD9H4Lp+3bP
   lXTgz8Kx5BIEqkWCqRHZljPOL6jVPTGDnz/M4NNJxaYDLHXMobZfFX6or
   l5wRwI7vuPCUfGSb3vD7U9Ck5O+3EvAWWYR/au4Q9xw5CRLmGu3sEhIax
   CYmg/3zzmZpd0BgBYQoRTI9FHhGk2UYkOU8w6QC+ZzX/VbaqUT6PUilCO
   A==;
IronPort-SDR: U4wLerv3trfTSY5CxVFpWgo8fOT6C+SZ3boQJl/w5IVozImUUUuUUyjgtefIA5teNWwigtZa7e
 cSgDZtllWD/nC508ded2IDTxQ6MKVgTLp1GFrnapnP1YQlrhvQd7Izu86nVWUsdEQ5L7s7cEE0
 yW/+nY0ldLLS7dZKr9dbTe82NrpwBbOXiq3qztotsBs4QbdnzLXNXZB3jGhwSlzmJM3cdUfeJR
 63ot+o3n77+7jFfpbOeVYim9wptJXNyOoQyAsjiTOlgCG2DKB6Ge3frxWlTsEm+UWY+OvIvXzQ
 JLIVbVgsNNPmuYv5E4/12WpC
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="73662304"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Oct 2021 02:47:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Oct 2021 02:47:07 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Oct 2021 02:47:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/3] ARM: dts: at91: enable leftover IPs
Date:   Wed, 20 Oct 2021 12:46:53 +0300
Message-ID: <20211020094656.3343242-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series add DT nodes for TCB and RTC blocks on SAMA7G5.

Thank you,
Claudiu Beznea

Claudiu Beznea (2):
  ARM: dts: at91: sama7g5: add tcb nodes
  ARM: dts: at91: sama7g5-ek: use blocks 0 and 1 of TCB0 as cs and ce

Eugen Hristev (1):
  ARM: dts: at91: sama7g5: add rtc node

 arch/arm/boot/dts/at91-sama7g5ek.dts | 12 ++++++++++++
 arch/arm/boot/dts/sama7g5.dtsi       | 27 +++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

-- 
2.25.1

