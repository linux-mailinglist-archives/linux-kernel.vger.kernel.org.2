Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D990C37915D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239851AbhEJOwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:52:55 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38028 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbhEJOvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:51:42 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14AEoYhO061462;
        Mon, 10 May 2021 09:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620658234;
        bh=HT9wiHZD8KaX5otvkMOqsHaVxNQBceavAhDafqkcpK8=;
        h=From:To:CC:Subject:Date;
        b=otSDTREZCoyY73U2mxAHnohtcTfsLzZcMZ1tdNYJWP2ZV0BjyAkP4IOC2IGP5E2hx
         S+ZOyQPbhFocb6n9+xAL4qH08cdhTXgTLlXpM2aCjLS8lhHECu4L126rHhCJ+/a4mW
         J4FPR4s+bcmeZtmc+sDHeDLWvq+TFxzyE2t2DNaI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14AEoYKH062285
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 May 2021 09:50:34 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 10
 May 2021 09:50:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 10 May 2021 09:50:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14AEoYXq111324;
        Mon, 10 May 2021 09:50:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/4] arm64: dts: ti: k3-*: Fixup nodes to exposed to be non-compliant with yaml
Date:   Mon, 10 May 2021 09:50:29 -0500
Message-ID: <20210510145033.7426-1-nm@ti.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Series of minor fixups for v5.13-rc1 for compliance exposed by yaml
conversion in the series:
https://lore.kernel.org/linux-arm-kernel/20210503190824.GA2192378@robh.at.kernel.org/#t

Minimal testing performed on k3 platforms.

If possible, will be good to get in 5.13 window.

Nishanth Menon (4):
  arm64: dts: ti: k3-*: Rename the TI-SCI clocks node name
  arm64: dts: ti: k3-am65-wakeup: Add debug region to TI-SCI node
  arm64: dts: ti: k3-am65-wakeup: Drop un-necessary properties from dmsc
    node
  arm64: dts: ti: k3-*: Rename the TI-SCI node

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi        |  4 ++--
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi      | 10 +++++-----
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi |  4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi |  4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.31.0

