Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7CC40B229
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbhINOyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:54:55 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60430 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233883AbhINOys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:54:48 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E9q9bR028980;
        Tue, 14 Sep 2021 16:53:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=0kyulV/QAQFe1BM1vxrQ6332HG6oh1bSHie4c4xuKWA=;
 b=l77sdX1m8XbfsGMZ5OP0qUJ3TEwIc0qZWSmBxbemcZa9q15X5WHj6W5G5XP1VJkvsIZB
 NfSJZZdhPvKZDoKOkdZfkyQnKI6+ha8QBF34SLkVMY2SaB9IMR+2idzInIozbyYV4nbi
 DSSZtdtDWfDR2Tr4Dg4qaplRiqBkPVagWuS1uJjhfvL5zX2VSlhvBaxIM/Va8R4g7Y3e
 nuJMulC7KNWryQJopGyFmMOk0Teq2up66Jf8zFIVX82ZdG+JkKwoaUiOrcqFxlQkGfVg
 iiQdHTHjMKjr2hX3mOTlFcXYyJMhVLJHYEPzYzoNQDQ0aNRPRuxHbg+xGykjshNl7S7Q Tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3b2sg19mpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 16:53:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1BC5210002A;
        Tue, 14 Sep 2021 16:53:15 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0F27421A229;
        Tue, 14 Sep 2021 16:53:15 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 14 Sep 2021 16:53:15
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 2/3] dt-bindings: phy: phy-stm32-usbphyc: add st,phy-tuning optional property
Date:   Tue, 14 Sep 2021 16:52:55 +0200
Message-ID: <20210914145256.243869-3-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914145256.243869-1-amelie.delaunay@foss.st.com>
References: <20210914145256.243869-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_03,2021-09-14_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the description of a new optional property for usbphyc phy
sub nodes. st,phy-tuning contains all phy tuning parameters to apply on the
phy.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 .../bindings/phy/phy-stm32-usbphyc.yaml       | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
index 3329f1d33a4f..0fa184ea54db 100644
--- a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
@@ -81,6 +81,60 @@ patternProperties:
         properties:
           vbus-supply: true
 
+      st,phy-tuning:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description:
+          It can be necessary to adjust the PHY settings to compensate parasitics, which can be due
+          to USB connector/receptacle, routing, ESD protection component,... Here is the list of
+          all optional parameters to tune the interface of the PHY (HS for High-Speed, FS for Full-
+          Speed, LS for Low-Speed)
+            * st,current-boost, <1> current boosting of 1mA
+                                <2> current boosting of 2mA
+            * st,no-lsfs-fb-cap, disables the LS/FS feedback capacitor
+            * st,hs-slew-ctrl, slows the HS driver slew rate by 10%
+            * st,hs-dc-level, <0> = decreases the HS driver DC level by 5 to 7mV
+                              <1> = increases the HS driver DC level by 5 to 7mV
+                              <2> = increases the HS driver DC level by 10 to 14mV
+            * st,fs-rftime-tuning, enables the FS rise/fall tuning option
+            * st,hs-rftime-reduction, enables the HS rise/fall reduction feature
+            * st,hs-current-trim, controls HS driver current trimming for choke
+                                  <0> = 18.87 mA target current / nominal + 0%
+                                  <1> = 19.165 mA target current / nominal + 1.56%
+                                  <2> = 19.46 mA target current / nominal + 3.12%
+                                  <3> = 19.755 mA target current / nominal + 4.68%
+                                  <4> = 20.05 mA target current / nominal + 6.24%
+                                  <5> = 20.345 mA target current / nominal + 7.8%
+                                  <6> = 20.64 mA target current / nominal + 9.36%
+                                  <7> = 20.935 mA target current / nominal + 10.92%
+                                  <8> = 21.23 mA target current / nominal + 12.48%
+                                  <9> = 21.525 mA target current / nominal + 14.04%
+                                  <10> = 21.82 mA target current / nominal + 15.6%
+                                  <11> = 22.115 mA target current / nominal + 17.16%
+                                  <12> = 22.458 mA target current / nominal + 19.01%
+                                  <13> = 22.755 mA target current / nominal + 20.58%
+                                  <14> = 23.052 mA target current / nominal + 22.16%
+                                  <15> = 23.348 mA target current / nominal + 23.73%
+            * st,hs-impedance-trim, controls HS driver impedance tuning for choke
+                                    <0> = no impedance offset
+                                    <1> = reduces the impedance by 2 ohms
+                                    <2> = reduces the impedance by 4 ohms
+                                    <3> = reduces the impedance by 6 ohms
+            * st,squelch-level, adjusts the squelch DC threshold value
+                                <0> = no shift in threshold
+                                <1> = threshold shift by +7 mV
+                                <2> = threshold shift by -5 mV
+                                <3> = threshold shift by +14 mV
+            * st,hs-rx-gain-eq, enables the HS Rx gain equalizer
+            * st,hs-rx-offset, adjusts the HS Rx offset
+                               <0> = no offset
+                               <1> = offset of +5 mV
+                               <2> = offset of +10 mV
+                               <3> = offset of -5 mV
+            * st,no-hs-ftime-ctrl, disables the HS fall time control of single ended signals
+                                   during pre-emphasis
+            * st,no-lsfs-sc, disables the short circuit protection in LS/FS driver
+            * st,hs-tx-staggering, enables the basic staggering in HS Tx mode
+
     allOf:
       - if:
           properties:
@@ -122,6 +176,18 @@ examples:
   - |
     #include <dt-bindings/clock/stm32mp1-clks.h>
     #include <dt-bindings/reset/stm32mp1-resets.h>
+
+    usb_phy_tuning: usb-phy-tuning {
+        st,hs-dc-level = <2>;
+        st,fs-rftime-tuning;
+        st,hs-rftime-reduction;
+        st,hs-current-trim = <15>;
+        st,hs-impedance-trim = <1>;
+        st,squelch-level = <3>;
+        st,hs-rx-offset = <2>;
+        st,no-lsfs-sc;
+    };
+
     usbphyc: usbphyc@5a006000 {
         compatible = "st,stm32mp1-usbphyc";
         reg = <0x5a006000 0x1000>;
@@ -137,6 +203,7 @@ examples:
             reg = <0>;
             phy-supply = <&vdd_usb>;
             #phy-cells = <0>;
+            st,phy-tuning = <&usb_phy_tuning>;
             connector {
                 compatible = "usb-a-connector";
                 vbus-supply = <&vbus_sw>;
@@ -147,6 +214,7 @@ examples:
             reg = <1>;
             phy-supply = <&vdd_usb>;
             #phy-cells = <1>;
+            st,phy-tuning = <&usb_phy_tuning>;
         };
     };
 ...
-- 
2.25.1

