Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FA6327740
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 06:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhCAFxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 00:53:08 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58288 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbhCAFxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 00:53:01 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1215pKbr036747;
        Sun, 28 Feb 2021 23:51:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614577880;
        bh=zanABnCcdYpSsd+wDgXsLLBA8XK5GasqyOMnr/TKm+g=;
        h=From:To:CC:Subject:Date;
        b=H7aoR7Q1wDUI2wHR4clvKhKMyVycW5c6YPqK7ufXmBZ7l0nuIGUjIBAt4zeZ2ynzN
         mXBfmBd7wnL1TUKfJ1Krq0hnP7W33T7NzfdJjh0SV5DOrofdjaFOD3Bve3sP3ZXdrk
         R5er0EK/UdRf68L9cwgQPPEOJJm4DkXPWsvt9SwQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1215pK2a027587
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 28 Feb 2021 23:51:20 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 28
 Feb 2021 23:51:20 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 28 Feb 2021 23:51:20 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1215pCDM115264;
        Sun, 28 Feb 2021 23:51:13 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] AM64:  Add USB support
Date:   Mon, 1 Mar 2021 11:21:07 +0530
Message-ID: <20210301055109.17626-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches, add USB support for AM64.

This series of patches depends on,
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=439039

Aswath Govindraju (2):
  arm64: dts: ti: k3-am64-main: Add DT node for USB subsystem
  arm64: dts: ti: k3-am642-evm: Add USB support

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 30 ++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 18 ++++++++++++++
 2 files changed, 48 insertions(+)

-- 
2.17.1

