Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A2D3F4826
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbhHWKEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:04:46 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:30109 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbhHWKEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629713042; x=1661249042;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HqPO8wjcoNmq4jL8PwF7txcPpvbaLkK3slXz2O5yzq8=;
  b=qR+bZBA5RKnbhCjO7GUaBBCuPRgcRBGrZv8/wvL2rgM2zAaQjpqo9w4B
   EIeyQ7CbZzZeZkQDHVOKZX/Yr3/IJKyjKnJ6ASqnNYU3N/0BX7Q8EfDpI
   RA6K0QJ7MB4/3ZiLPPzHlzIsokOfP9d5chr1AW7mHkqV0JFhkB3QxF+S5
   i2BChl149/OPEQlW994GQYHiyqZ2pKHqAL3jXUl9KREQW5wgBCabaccYp
   O+84a4Snyb1j++ZnvxQYb7QWzOamY4AbrxWbYh9LuT6/jJSabc2ZJ02eL
   c/vQRgkMOIipP9TOG+ICQLv0V4aUYTn4+f4KaVdhN5nvVatCDxcFx37QL
   A==;
IronPort-SDR: gxE3cf1I8yUd6r7utAEovKlgBWEQwD8sZ3pY3DVfT2jVEXVgAOnAO/8ohsyn8pOe9vxniWocNe
 qopwt1iBxBK9o4S/HxSl2UVr2vxSP4/fUHUyuKgfZFrHDNvvwp6Jk9u6yPbSDRpuGbQNu7XnZ7
 uXYmyf6z2SgJKSPsaMLp9NY37XV4lzQs02OROY/4SKtuACr+sDlOyY+19OGutc9iaV83gERHbC
 fBTcNqsplArGgFKPtKbZigIRQ9CHZMAwSJSPwvC/NQsQggKDbqRwz7stLRN3wIgqQJNcmNo4E8
 KOkhhJlDWiAvdJL2rg4fvqL1
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="141175750"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2021 03:04:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 23 Aug 2021 03:04:01 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 23 Aug 2021 03:03:59 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/3] ARM: dts: at91: enable ips for sama7g5
Date:   Mon, 23 Aug 2021 13:03:53 +0300
Message-ID: <20210823100356.22206-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches enable UDDRC, DDR3 PHY, SECURAM and SHDWC IPs
on SAMA7G5.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  ARM: dts: at91: add ram bindings
  ARM: dts: at91: add bindins for securam
  ARM: dts: at91: add bindings for shdwc

 arch/arm/boot/dts/at91-sama7g5ek.dts |  9 ++++++++
 arch/arm/boot/dts/sama7g5.dtsi       | 34 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

-- 
2.25.1

