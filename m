Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E54D36B63A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhDZP4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:56:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53078 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbhDZPz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:55:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13QFt6mh122076;
        Mon, 26 Apr 2021 10:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619452506;
        bh=J4jxh7+jB7x/KGB+qTcnBnMfZHCBkbpPdUuOvHr6Hnc=;
        h=From:To:CC:Subject:Date;
        b=gk6aphIaK9pOSsztWoJBKH074sVA6V85v++/6lXaqUzrvsmydsu8OGiqtWGhnh0mv
         Z/VPwIViGdUdf9wNn7pwT/GY+OiezMeIJ0WIYIIjjv6PaLKuC36moPtAVpAQsjIjt5
         /yA8dMkcmw+xE2kT4rpKOKjdtYwWgIFt/pQjiYn8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13QFt5em117314
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Apr 2021 10:55:06 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 26
 Apr 2021 10:55:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 26 Apr 2021 10:55:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13QFt5CO089440;
        Mon, 26 Apr 2021 10:55:05 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/4] dt-bindings: soc/arm: Convert pending ti, sci* bindings to json format
Date:   Mon, 26 Apr 2021 10:54:53 -0500
Message-ID: <20210426155457.21221-1-nm@ti.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

V2 of the series posted in [1] to convert the remaining ti,sci bindings
to json schema format. V2 is mostly review comments being incorporated -
details in each of the patches and in applicable patches, I have picked
up Rob's and Tero's reviewed bys.

There are also dts fixups that this series exposes, which is good, but
I chose to hold them back for now pending binding review at least. The
complete series is available in [2] if folks are curious - to be posted
once v5.13-rc1 is available for fixes.

[1] https://lore.kernel.org/linux-arm-kernel/20210416063721.20538-1-nm@ti.com/
[2] https://github.com/nmenon/linux-2.6-playground/commits/yaml/tisci

Nishanth Menon (4):
  dt-bindings: reset: Convert ti,sci-reset to json schema
  dt-bindings: clock: Convert ti,sci-clk to json schema
  dt-bindings: soc: ti: Convert ti,sci-pm-domain to json schema
  dt-bindings: arm: keystone: Convert ti,sci to json schema

 .../bindings/arm/keystone/ti,sci.txt          |  86 ------------
 .../bindings/arm/keystone/ti,sci.yaml         | 129 ++++++++++++++++++
 .../devicetree/bindings/clock/ti,sci-clk.txt  |  36 -----
 .../devicetree/bindings/clock/ti,sci-clk.yaml |  49 +++++++
 .../bindings/reset/ti,sci-reset.txt           |  62 ---------
 .../bindings/reset/ti,sci-reset.yaml          |  51 +++++++
 .../bindings/soc/ti/sci-pm-domain.txt         |  65 ---------
 .../bindings/soc/ti/sci-pm-domain.yaml        |  59 ++++++++
 8 files changed, 288 insertions(+), 249 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
 create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
 delete mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml

Regards,
Nishanth Menon
-- 
2.31.0

