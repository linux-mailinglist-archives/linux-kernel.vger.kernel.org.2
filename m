Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A875934CD87
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhC2KBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:01:19 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:53767 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhC2KBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617012061; x=1648548061;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NPEbe7QL1i+Cz7ANKxkJSqSzieTdku4UjfQnVlN+dWo=;
  b=dKcDe7INVxbKmCcea0EgecxyaZ2oeYW7bsl7HHKrkwEuh/m3TJdFt0e0
   Erl5IStEhZ5URAsqmDwPO/h2xfy5rXiqJCYeu7kl4Y7hsnu96rVS53JoJ
   bY/EVKjFAVZeAfYC5sPuqumAiNlubCbng777FhTLuzAUjhiguoiOK264t
   BJ6CXlpuDFEYmTQ7G5kRlgp7baAr9ecO1dgleZVcESAaVfZR+U3Ktm5SD
   Z6YfFKbVmKnCXNqpJRhdxcocVZ1FhACMsw/XNqHazSCFTGI1rgntvpWDX
   q3Ort9/1yyr58e3Amfgucu9jnLpTaU9ov9rA4vXhbZFJw0/yXqUQWkz5f
   g==;
IronPort-SDR: kpcxMRp5GIBnV+zYR+DpUjgGArnI8DbFp9FwGfDJ1kS3DHgNiHXbPEcCNcu5MahfZPI9lh9DAo
 fsskIxTJnJjZ3KgGbRKrwT+N5+LoAelmLEemNEWzU4Q/pTHZCdNip5S8J4NM54PzdA6omsSEwG
 GU/gfczNj9jXsWIzTXe1Ovw53Z9wWxvitP/Xo3e1zIFZjA+gtOSH/p2f3Ej8r+hiPiGPmC5EvZ
 ddKWVJjsQh4N61WeB5hFdDiNVoVJLHMFvfcLpNIwkiE3gJpnGSDdIbs8w9tEuG2MkBUlbTK2+P
 efU=
X-IronPort-AV: E=Sophos;i="5.81,287,1610434800"; 
   d="scan'208";a="111696104"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2021 03:01:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 03:01:00 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 29 Mar 2021 03:00:58 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        <emil.velikov@collabora.com>, <ezequiel@collabora.com>
Subject: [PATCH 0/7] ARM: configs: at91: updates to defconfigs
Date:   Mon, 29 Mar 2021 11:56:38 +0200
Message-ID: <cover.1617010856.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Hi,

I collected some of the defconfig modifications that we carry in our vendor
tree for some time. They are interesting for both users and validation process as
most are part of validation plans or CI.

Don't hesitate to indicate missing pieces to add to this serries.

The base of this serries are patches by Emil Velikov as part of "[PATCH v2
00/10] Microship SAMA5D4 VPU support et al" and not included here. They will be
part of pull-request to ARM-SOC.

Best regards,
  Nicolas


Codrin Ciubotariu (1):
  ARM: configs: at91: sama5: Add audio MIKROE PROTO board

Nicolas Ferre (4):
  ARM: configs: at91: sama5: MCP16502 regulator as built-in
  ARM: configs: at91: Add mtd tests as modules
  ARM: configs: at91: Add USB Video webcam class
  ARM: configs: at91: Modernize UBI defconfig part

Razvan Stefanescu (2):
  ARM: configs: at91: sama5: PIOBU as built-in
  ARM: configs: at91: sama5: Enable LAN78XX as module

 arch/arm/configs/at91_dt_defconfig |  5 ++++-
 arch/arm/configs/sama5_defconfig   | 11 ++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.31.1

