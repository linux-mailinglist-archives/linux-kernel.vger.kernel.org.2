Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34F532C2BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350736AbhCDACF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:02:05 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51931 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387984AbhCCUJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614802195; x=1646338195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+UrM9fC93iQVxQpcgDIaNlP1BOkdXLEl/GRtnbtfNrk=;
  b=AH7swVkJgEWvrnxFRn4wHR7zJJnWsq83LSsX/3ikrchevbpjGdkH/Ejd
   K60OYph/vvg05W0N/vBcfXFD4rxrbJ9uHbuPJE6hVr5AFAoilnEqzo49r
   /LUyEPTfU/+tgKXo50krSe53z9YUSk6hIuJX6D3iv9r6TjUI/HEtp4My0
   ffSnCKqwEbsyUCBNJO5j+ODOVV+0XOdR7ksFuJHxUbIlDYkr64gAgSN7D
   rzGUBz1DxdJ91YyKaFCEjJyeTnwfjEUbE5f54sSl3N4wgt0yE20VUkYY5
   TSrCnznxhYmJl5IHQsxGvnaPxH2w+39lV+Nm2ugaAnqdON7151LoVBOwC
   Q==;
IronPort-SDR: +WNarCRA46FkAUMjySLzjyPa1Df43eloRPHizpgIhI91TQOcJkuMz0WtQu+wMLOmXbOoHRmGt4
 IQC085F/EIR3KewPbJhGYTa9xMQ9CQj/Uw2WTArKjNOREKkC91ldmLk873GICY83Ytv2F7f+tG
 szcaO6gsqg4Z+VSLwz/el/35fixQfLtIqouA326fx7TKrYjem8SBidGiof3UDJlDN/6lrpWmty
 NazZs/x8gmsOJwMPaMobNTX0ftohtiyTap+HhQlF+68DpGnnHyCoM4+eiAGOW39Iry67PrT0ue
 nJM=
X-IronPort-AV: E=Sophos;i="5.81,220,1610380800"; 
   d="scan'208";a="161271867"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2021 04:07:00 +0800
IronPort-SDR: ikE85AkTtvCGCf6/f3TjT4NTbc9Drq817cc3RvwZOnGM90fMtdfqMioCFJJYfB8ZTbnLSovDK7
 pxkqfmokZ0T+FOQAUoCKqFfzhlt0H0clsdLdJmUCykaWub9j0iUJp803gbIfOLv8hDTmhbtTBq
 d8FTuD2WDvuLATCZG2peluAS8qoTVUgoH76oS+pGDelJ9qZEOHI7I2acKJZNggIvRiKPxio9WA
 eEZcn2Sjj50bJFDB6Sd/Xu01qv/VacWLBQQ27BWg6Z5/xs8SqL9wUoCif3Aneihi4sI4hZlP54
 DhG/YKkKJhwLnFTOkwaE/IsR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 11:50:04 -0800
IronPort-SDR: BYOop5Fz7HcrNpwPe2cfxOPaLm7gHPFDwZbo3yLFZjvVPoECDk9AtmXSn1UI/wpgq7vXazFt5q
 mzIvyGlgA9CQv9ouTfsmnUj9xKKKBy+1N2EtZx/CFnv7hW5m1ooz88dTNoRGJ2Ygy+GwsuwqcC
 Dt8yOtK9is61UNnhqm2gZ1E7FxceHp8O/jhwmWCeOG49iPxpTacpQnfgovGc9u1kufmOkT50Px
 NC3nVx3GzHNzq/jq5xp+ZWBWyxs2sf7XMvMYYOGWup3vYGlBuchegI59GR5yLaVZTedHkuQ2G5
 4Ec=
WDCIronportException: Internal
Received: from ind002560.ad.shared (HELO jedi-01.hgst.com) ([10.86.48.105])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Mar 2021 12:07:00 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, Conor.Dooley@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Ivan.Griffin@microchip.com, Lewis.Hanly@microchip.com
Subject: [PATCH v4 5/5] MAINTAINERS: add microchip polarfire soc support
Date:   Wed,  3 Mar 2021 12:02:53 -0800
Message-Id: <20210303200253.1827553-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303200253.1827553-1-atish.patra@wdc.com>
References: <20210303200253.1827553-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Add Cyril Jean and Lewis Hanly as maintainers for the Microchip SoC
directory

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..cf186eca1784 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15358,6 +15358,14 @@ F:	arch/riscv/
 N:	riscv
 K:	riscv
 
+RISC-V/MICROCHIP POLARFIRE SOC SUPPORT
+M:	Lewis Hanly <lewis.hanly@microchip.com>
+M:	Cyril Jean <cyril.jean@microchip.com>
+L:	linux-riscv@lists.infradead.org
+S:	Supported
+F:	drivers/soc/microchip/
+F:	include/soc/microchip/mpfs.h
+
 RNBD BLOCK DRIVERS
 M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
 M:	Jack Wang <jinpu.wang@cloud.ionos.com>
-- 
2.25.1

