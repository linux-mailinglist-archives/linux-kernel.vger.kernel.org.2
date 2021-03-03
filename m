Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7FB32C249
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581011AbhCCTfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:35:31 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54704 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351028AbhCCTXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:23:20 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 123JLW73100362;
        Wed, 3 Mar 2021 13:21:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614799292;
        bh=K1fhUbqiDoTfBCZD4unThjgkoxvlhQ5mooQAHaOou68=;
        h=From:To:CC:Subject:Date;
        b=vi75RRJ7SvVR/F3iXMpRCa2tVW66lZpkfqixPWRT29jzLzn60Tzeg3thCbfpzf3Dz
         n5L5ZFaoTSZztECPzVwLJc4VwRy6LoG/6fXdTXW4OOw+7a87i4hJ5M5aXlubVPUthi
         RVeupguu32EHFk4acCR3LlsyqWLaGMMFYYJkPT1s=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 123JLWM3086894
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Mar 2021 13:21:32 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 3 Mar
 2021 13:21:31 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 3 Mar 2021 13:21:31 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 123JLUF1012912;
        Wed, 3 Mar 2021 13:21:31 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
CC:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/4] arm64: dts: ti: am642x: add CPSW3g DT nodes
Date:   Wed, 3 Mar 2021 21:21:10 +0200
Message-ID: <20210303192114.12292-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This series adds corresponding AM642x CPSW3g nodes required to enable networking
on TI am642-evm/sk platforms and adds required pinmux/PHY nodes in corresponding
board files.

Kernel Boot Log: 
EVM: https://pastebin.ubuntu.com/p/6Qkbw35Jg3/
SK: https://pastebin.ubuntu.com/p/Pd3xxP9J9K/


Grygorii Strashko (1):
  arm64: dts: ti: k3-am64-main: add main CPTS entry

Vignesh Raghavendra (3):
  arm64: dts: ti: am64-main: Add CPSW DT node
  arm64: dts: ti: k3-am642-evm: add CPSW3g DT nodes
  arm64: dts: ti: k3-am642-sk: Add CPSW DT nodes

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 89 +++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am64.dtsi      |  2 +
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 93 ++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 73 +++++++++++++++++++
 4 files changed, 257 insertions(+)

-- 
2.17.1

