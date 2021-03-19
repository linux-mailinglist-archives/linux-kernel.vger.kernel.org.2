Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07DF341705
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbhCSIBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:01:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58414 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhCSIA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:00:56 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12J80i9j075567;
        Fri, 19 Mar 2021 03:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616140844;
        bh=wxS4b5SJ637ktgyDBv3k77p855NrdR/OrZKKTdUAfmQ=;
        h=From:To:CC:Subject:Date;
        b=xPrJ/jqAeyBHFeuhKzY2XQ7F1o1VCxkTTPgFzHna+qcfND7dZpTYcPvV33FPUOOWE
         jnKsW6PCV3kwqMQnbFnju/jsdbSAxr4xNHIUlaFK6salXXwlZWLn+xEwDxEw5362mQ
         78mixCcPLsZi3UC3vDuVoxEMSnBsSFhj/weIX6Bo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12J80iKj002947
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Mar 2021 03:00:44 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 19
 Mar 2021 03:00:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 19 Mar 2021 03:00:44 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12J80eJq086082;
        Fri, 19 Mar 2021 03:00:41 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] AM642-sk: Add support for USB
Date:   Fri, 19 Mar 2021 13:30:36 +0530
Message-ID: <20210319080038.10521-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches add support for,
- single one lane SERDES present in AM64
- USB super-speed port on AM642-sk

USB test logs,
https://pastebin.ubuntu.com/p/4RT9Y94fPv/

The following patches depend on,
1) - https://lore.kernel.org/linux-devicetree/20210310112745.3445-1-kishon@ti.com/
     binding additions and given below is an immutable tag  provided by
     Vinod Koul <vkoul@kernel.org> (one of the Maintainers of GENERIC PHY
     FRAMEWORK) after applying them,

     git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
     tags/ti-serdes-for-5.13

2) - https://patchwork.kernel.org/project/linux-phy/list/?series=445371
     Serdes driver changes required for USB super-speed functionality.

Kishon Vijay Abraham I (2):
  arm64: dts: ti: k3-am64: Add SERDES DT node
  arm64: dts: ti: k3-am642-sk: Enable USB Super-Speed HOST port

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 52 ++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 39 ++++++++++++++++++
 2 files changed, 91 insertions(+)

-- 
2.17.1

