Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D6732EF25
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhCEPkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:40:07 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41298 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhCEPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:39:39 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 125FdW8m097210;
        Fri, 5 Mar 2021 09:39:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614958772;
        bh=Xfr9QmFmVdaAPeZKpbc0xw9xbaWHjMlzBBqzoazBpQs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=O5nct4/CULQa2cVehleDGFen8NbHREpFaUqs1fpXMtdrGsqELuytpY0vgStlHIf8A
         Sjeh54ZIIkIj0mkizMsMxzaANZMLGKt6IW8gEnhRLvvYml9KoJDHq5UUrcNC9YhcNd
         +p8HVJ9BwNr4G9eF9A6K4awqoHTPFIXsNAhO59Fo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 125FdW0o103629
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Mar 2021 09:39:32 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 5 Mar
 2021 09:39:32 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 5 Mar 2021 09:39:32 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 125FdQBX081046;
        Fri, 5 Mar 2021 09:39:30 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 1/3] arm64: dts: ti: k3-j721e-som-p0: Enable 8D-8D-8D mode on OSPI
Date:   Fri, 5 Mar 2021 21:09:24 +0530
Message-ID: <20210305153926.3479-2-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210305153926.3479-1-p.yadav@ti.com>
References: <20210305153926.3479-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the Tx bus width to 8 so 8D-8D-8D mode can be selected. Change the
frequency to 25 MHz. This is the frequency that the flash has been
successfully tested with in Octal DTR mode. The total performance should
still increase since 8D-8D-8D mode should be at least twice as fast as
1S-1S-8S mode.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---

Notes:
    No changes in v2.

 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index 57720e6a04c5..2fee2906183d 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -174,9 +174,9 @@ &ospi0 {
 	flash@0{
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
-		spi-tx-bus-width = <1>;
+		spi-tx-bus-width = <8>;
 		spi-rx-bus-width = <8>;
-		spi-max-frequency = <40000000>;
+		spi-max-frequency = <25000000>;
 		cdns,tshsl-ns = <60>;
 		cdns,tsd2d-ns = <60>;
 		cdns,tchsh-ns = <60>;
-- 
2.30.0

