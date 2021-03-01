Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B684329E1A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 13:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444700AbhCBCoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 21:44:05 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44482 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242206AbhCAUA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:00:59 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 121Jx065110913;
        Mon, 1 Mar 2021 13:59:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614628740;
        bh=4VqLc5zgbv9TLXDVEPmT5AeVg4W9iO7/U0gZ9x+z7QA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=aw6EXp0vnBJTmHsv2AxfYwoLKV1fc/YRmZWioBiBYVxA3EwpGlrkmskKACipmSq4G
         oWO8Dic5FkUPgzyNI148DbxFXJ2ZZ/FvG+hUoLafjlQsYIYdaxGH+u7gzsqUYA+r6l
         GJUVSN2efNY7QsEzTxmUY7GmL3EHNfy46tSEV23U=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 121Jx0CS038478
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Mar 2021 13:59:00 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 1 Mar
 2021 13:58:59 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 1 Mar 2021 13:58:59 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 121JwpIL058503;
        Mon, 1 Mar 2021 13:58:57 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: am654-base-board: Enable 8D-8D-8D mode on OSPI
Date:   Tue, 2 Mar 2021 01:28:49 +0530
Message-ID: <20210301195850.31868-3-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210301195850.31868-1-p.yadav@ti.com>
References: <20210301195850.31868-1-p.yadav@ti.com>
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
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index fe3043943906..9e87fb313a54 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -483,9 +483,9 @@ &ospi0 {
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

