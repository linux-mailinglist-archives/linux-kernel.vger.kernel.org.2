Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE14F3619EF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbhDPGiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 02:38:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43990 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbhDPGh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:37:59 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13G6bNkG128095;
        Fri, 16 Apr 2021 01:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618555043;
        bh=eMXIcMV1dcJQMxLIXqgNOpRjQIMxiNUYLUUJRJREsFM=;
        h=From:To:CC:Subject:Date;
        b=TWPTSEoU515VBPmF/S2d/0c6qqHu6zVxgD8y9ATezF5qNoeKxcfbT1Bay4fvqw4HN
         fWSmu0hPCYD8EJ74fGJG9vg64bcn2gcjSeC4vlx0EfIKL4/gNa2L3DAl0APiTdqJyY
         PBul4bh3tk3lgqER8T3rRKsYazdWAHWdOUB63rHA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13G6bNvC073126
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Apr 2021 01:37:23 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Apr 2021 01:37:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 16 Apr 2021 01:37:23 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13G6bN5M090507;
        Fri, 16 Apr 2021 01:37:23 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/4] dt-bindings: soc/arm: Convert pending ti,sci* bindings to json format
Date:   Fri, 16 Apr 2021 01:37:17 -0500
Message-ID: <20210416063721.20538-1-nm@ti.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I understand that the following series belong to various maintainers,
but, it is a bit better reviewed as a single series for
cohesiveness.

There are also dts fixups that this series exposes, which is good, but
I chose to hold them back for now pending binding review at least. The
complete series is available in [1] if folks are curious.

Nishanth Menon (4):
  dt-bindings: reset: Convert ti,sci-reset to json schema
  dt-bindings: clock: Convert ti,sci-clk to json schema
  dt-bindings: soc: ti: Convert ti,sci-pm-domain to json schema
  dt-bindings: arm: keystone: Convert ti,sci to json schema

 .../bindings/arm/keystone/ti,sci.txt          |  86 ------------
 .../bindings/arm/keystone/ti,sci.yaml         | 129 ++++++++++++++++++
 .../devicetree/bindings/clock/ti,sci-clk.txt  |  36 -----
 .../devicetree/bindings/clock/ti,sci-clk.yaml |  52 +++++++
 .../bindings/reset/ti,sci-reset.txt           |  62 ---------
 .../bindings/reset/ti,sci-reset.yaml          |  51 +++++++
 .../bindings/soc/ti/sci-pm-domain.txt         |  65 ---------
 .../bindings/soc/ti/sci-pm-domain.yaml        |  59 ++++++++
 8 files changed, 291 insertions(+), 249 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
 create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
 delete mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml

[1] https://github.com/nmenon/linux-2.6-playground/commits/yaml/tisci

Regards,
Nishanth Menon
-- 
2.31.0

