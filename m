Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF1133E874
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 05:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCQEaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 00:30:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45096 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhCQEaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 00:30:24 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12H4UCK0052948;
        Tue, 16 Mar 2021 23:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615955412;
        bh=Imi18cHPGZvLArm9Lm57axsl3/ZMPV5Vn6JNm9gVjPM=;
        h=From:To:CC:Subject:Date;
        b=WGQAOOsd3AKutZjxj89MiFJ8LtqyB26pPZXLbJxat1Y/zha1hK3OHAWOXGg15MWXO
         Wo2PTEhLy6dA91YFn/ziOF7QKY6VnlxJWoCAmIxvEnLWnJk1YKtL8/7+U3s1D3b1MW
         spA1cTIm0HnBC5jFeBkHeOEIixZo1CBM22D80w3g=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12H4UC9d028378
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Mar 2021 23:30:12 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 16
 Mar 2021 23:30:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 16 Mar 2021 23:30:12 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12H4U8bt072628;
        Tue, 16 Mar 2021 23:30:09 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] AM64: Add USB support
Date:   Wed, 17 Mar 2021 10:00:04 +0530
Message-ID: <20210317043007.18272-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches, add USB support for AM642 evm.

USB test logs,
https://pastebin.ubuntu.com/p/YSQRBWGmzd/

Changes since v2:
- dropped compatible string "ti,j721e-usb" leading to DT schema errors
- Reran test logs
- Couldn't pick up reviewed-by from kishon as a change was made in the
  patch

Changes since v1:
- Rebased the patches on top of ti-k3-dts-next
- Added test logs

Aswath Govindraju (2):
  arm64: dts: ti: k3-am64-main: Add DT node for USB subsystem
  arm64: dts: ti: k3-am642-evm: Add USB support

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 30 ++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 18 ++++++++++++++
 2 files changed, 48 insertions(+)

-- 
2.17.1

