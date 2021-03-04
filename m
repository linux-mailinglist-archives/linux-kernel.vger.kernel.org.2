Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AE032DB9B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 22:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbhCDVM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 16:12:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46448 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239101AbhCDVMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 16:12:06 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 124LBB1j025021;
        Thu, 4 Mar 2021 15:11:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614892271;
        bh=ptcsnuvk3eLJtXwL4PyuA6X0wnI3Vs+wsEx/fEx5qGI=;
        h=From:To:CC:Subject:Date;
        b=qixeVfmjMnN0OK1jMeUSQloxvK7LgmgjXunE2ZYDkW7u0RMFfVRBlVcs3H1YcjhjL
         SidGSpPvt08vPwVvsqzYxbrx3H0C6fbVSwItlIMgmsX2GRIxYduOMoPAaMkXksZLMt
         cY52y4haDV1CLSilFq7eGWk7+Hg55OCAXKAxKuxM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 124LBBFN009585
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Mar 2021 15:11:11 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 4 Mar
 2021 15:11:10 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 4 Mar 2021 15:11:10 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 124LB9KY039907;
        Thu, 4 Mar 2021 15:11:10 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
CC:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 0/4] arm64: dts: ti: am642x: add CPSW3g DT nodes
Date:   Thu, 4 Mar 2021 23:10:34 +0200
Message-ID: <20210304211038.12511-1-grygorii.strashko@ti.com>
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

Changes in v2:
- minor comment fixed
- add Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

v1: https://lore.kernel.org/patchwork/cover/1389305/

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

