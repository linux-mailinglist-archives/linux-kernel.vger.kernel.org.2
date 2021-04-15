Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F94F3607AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhDOKwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:52:19 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:49683 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbhDOKwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618483915; x=1650019915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4BQZ/iTmn3jDQYiKb3oiGkOU5qXJu63VT3CwhT9FgTM=;
  b=xDI+qVGVkOvjai/TYG/frxC7i3MgYtJaJnT3f9EQuTUijje7895JpfiX
   x0G6waV0AfZAjYko0jdw7zo6mtxhjz9OAfSy4EPjNhlnHzKpMqXbJ7b4s
   3Ui8XtZVi9NMEbsE/xLk93EHD49F6EbIltS3v1O1e+1lsqGtIjmiPwuhz
   vK48RsZqe6B8hulXaVB5IXaaCRgl2TKdJLb+V1T+RB3Xz/Shtn1OJuKPs
   SKEJtRcKGxDB3wYKkaYfDEFo5DjY4C3qePtD6KvTw9sfUXOzovu/dc0qT
   /lsn6i32JhW1/rqBko8e6NXjnohEhXV+8AIKkZL97C3SrDy8cI0cW+rmm
   g==;
IronPort-SDR: s5AC5j6B3JNz2YhE4jIjdcCOy7+Civ7Jxx0JGuTan9EQyBYarskLhfsLXnU3u0bqRjq+VzxLuH
 0TlgcHJG3bvbAmJ+lfbSTV0m9baFwsi+SAmY58xiiJsht+hwkmAjFLlPWOIaZ/PuoHFlEr+SWi
 DRlcwh+Zi8wABXmWPs7o212v5uU4iTGa46HJgEuV3D2sb/12njx4TJ5Wen55ydFiFmwkHzeK23
 mb41w4NwDvWHSWJnYNk0bzbrNfbyXFqNB1qjmukHn2tAoQJmWJnUT8o7PeKGW0cDl5Y+8J4IWs
 7hU=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="116551742"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 03:51:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 03:51:53 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 15 Apr 2021 03:51:46 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 15/24] ARM: at91: pm: wait for ddr power mode off
Date:   Thu, 15 Apr 2021 13:50:01 +0300
Message-ID: <20210415105010.569620-16-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415105010.569620-1-claudiu.beznea@microchip.com>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wait for DDR power mode off before shutting down the core.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 9c9e08fd8300..7396e18dd7e5 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -980,6 +980,11 @@ ulp_exit:
 	mov	tmp1, #0x1
 	str	tmp1, [r0, #0x10]
 
+	/* Wait for it. */
+1:	ldr	tmp1, [r0, #0x10]
+	tst	tmp1, #0x1
+	beq	1b
+
 	/* Shutdown */
 	ldr	r0, .shdwc
 	mov	tmp1, #0xA5000000
-- 
2.25.1

