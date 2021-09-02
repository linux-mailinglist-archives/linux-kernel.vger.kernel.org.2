Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9C23FED99
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344276AbhIBMPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:15:11 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:63952 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344299AbhIBMPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630584850; x=1662120850;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MG3sKygk/maATxNJEqPcS3fl+Si0b2i4QKAdEI9EZ8M=;
  b=b4PUZM0GgO4S9tYU7PtWEZtOMnPA+0dsfFS56qt3fDYjjpi7zGLPQGpL
   uuTuYA2jW1Muugnz/L/nsK/p/XAKGkOUFrNoZuizZB7OSm9sCEq2f3gef
   PcDuDS3UYM2LqGS+2ecr1Ujh87j4PNjV4qqYNPtKhDzJbZl+KlQ0jXks3
   nWJrac9m2qNxrPT33c1TutYZiseXVG508SP5hDfxi4uerVzc/lYxCU9P4
   q3iKj4QfHdxP7+y1zWwlFFHVF+C8+ro4CmJMrBYvQPmWH6F+f09Sy9rgV
   xUsUico5AaT7HHBj9sF09vPTNKrPZkF1gKisM2A8mFqwQGBmgtRbBHuU1
   g==;
IronPort-SDR: xeysCxn2FRD7bughla++Hb2lLUvxz89uZXoDFm9deDFlQqxozbxUaX28ommepqiGW4iL3VvS7X
 ON7ozwvmTqqwRrW5aIP1di4h9ogNtldrLzuluROcUAlY5d5+fs4Xu9dqrFo1ahkMHylr7O4hpr
 6ZhVqFl0ZSIqrwYQOWRCO9OYpzYZO4f7z0WNgDVzc7pzQBrDkm7msRD2l039rK1s7/06AMdCcg
 VGqFP1b38/mTgSGLyrdIQuUsbU7DNb0dFhirBNxzmJ/EZv3w9jfA+PH5NIH6fCvlyRb9o72NEk
 RpoIKspcmGydk7u8Z5h93N/C
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; 
   d="scan'208";a="68014599"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2021 05:14:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 2 Sep 2021 05:14:08 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 2 Sep 2021 05:14:06 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <nicolas.ferre@microchip.com>
CC:     <robh+dt@kernel.org>, <ludovic.desroches@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d2_som1_ek: disable ISC node by default
Date:   Thu, 2 Sep 2021 15:13:58 +0300
Message-ID: <20210902121358.503589-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without a sensor node, the ISC will simply fail to probe, as the
corresponding port node is missing.
It is then logical to disable the node in the devicetree.
If we add a port with a connection to a sensor endpoint, ISC can be enabled.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index 614999dcb990..cd4672501add 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -71,7 +71,6 @@ apb {
 			isc: isc@f0008000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_isc_base &pinctrl_isc_data_8bit &pinctrl_isc_data_9_10 &pinctrl_isc_data_11_12>;
-				status = "okay";
 			};
 
 			qspi1: spi@f0024000 {
-- 
2.25.1

