Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708B332C297
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhCDABP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:01:15 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51931 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387979AbhCCUJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614802152; x=1646338152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JHnXMYNTFxhiBChwfWalorTaFkKoXCCWgLzh9jJqTp0=;
  b=hjOTAswvfzPpGjdXdJc1Y3X7MhnXYajBAAxrVn2i6ff7Db2DqbPRR5V1
   lfvTDt3rgDNuzEOL0OJbCn9+fO51uKxuFhXeDO52j4dHWxrQ1c1STNV4G
   T3L0BqgEL2bSraImIxbp+bcodG/eiKrIQVcaw0oqYFDhZ2KP5yJaru9Om
   hBUuhEIz6yb4XQiISMAaFeOywXJEz5W8DfupQ9/up/RYGoczm6yMmFEC4
   /8eFHMboNrFa4OVYQ9Qo9n06HY7yk35CIacgEFGqAeO3vfAqKSM4zrjHV
   cFY+lQYbbOcoD8R7XRHMg7Ekr+GDE9jtvfPDO6eHp8WGzSbgbgOO9H1Dg
   A==;
IronPort-SDR: bVpfmYgwLq5xoXRVCIhrvTAt62L5XZW0tWfWZjazJraSo9RY2mJvaFxHl+57hg89lgEMCrqFQ5
 xRJTxvfupX6rQsBooomBqwx+Lhco7cnLMbk4Aj2QbL/Jw8LTgPbHYBasDU/2ZPT37DeWNKqdux
 FoGyfIuOmGLugecSFdTisYoQPvtzsdYQgtorg2k4W4dWmLAAWbiBxUPUJzrv5T2GgWiPWSdH2x
 ZGf6n3vNeKmtvhHcJ+tDobiQXK+ozFg//ruNHyLZmPR3Uv/v6iU5cyx12ERePeyHYiNhXseZ/2
 XB8=
X-IronPort-AV: E=Sophos;i="5.81,220,1610380800"; 
   d="scan'208";a="161271859"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2021 04:06:58 +0800
IronPort-SDR: GJlld9N3cW9X1ebZ+t1IrBaT2+SSkIKIBMFmw5UK+rTK2uVteBWbHZDyRpeZlhhvlEj4zo6NJv
 Gla1D1ajumkL0aEMiTKhkpABzKpfvWG4VUV81XNcyiiNL0DsytdGOM0lNK4kE0XmILlmv4iYO2
 7p0P48qTrnuJa3BKS+eS7YaGfSmTEJj1YYlzX5s0UQt8J+Zv/yeg2MVcTXgrz5yUhc1lwgNGtl
 8Y4Cxevx4xSF4Qm++NIFnfZ85PRWaxwNnFKVRUobtW1yVXMwE6Bdo8o11xZZicXAtY577cGRam
 3FMLGV3sCxCAO55VlVAj3Xtd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 11:50:03 -0800
IronPort-SDR: u45KEVZrHyl0adS8cedzPWtVHE3cvOMPLnWNooQAOIPvlOoOIbxgGieEBTZ2kHgaYiC8eQNU8a
 aC2NfI3/E+QeR/u6YhMKvW+Q0F0C2ME8F0ROuaovjtfzsuaOU9h05HsnM7DoKlesX0jsIfZ6Ej
 HvvX1XggDuDwoqMQHfCAnfmUsxx23lKZCINvyV3+DgTwPcvRpO2d4WH7gs/qXK+dhqvXqQZ+Rr
 7f57lIB9to9D080CgHk+OOEb2LPwWOuWqyUNIDQu75KouvDlGRW5iXalwGiE97Hg2OgcuGHOwf
 jeY=
WDCIronportException: Internal
Received: from ind002560.ad.shared (HELO jedi-01.hgst.com) ([10.86.48.105])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Mar 2021 12:06:58 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, Conor.Dooley@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Ivan.Griffin@microchip.com, Lewis.Hanly@microchip.com
Subject: [PATCH v4 2/5] dt-bindings: riscv: microchip: Add YAML documentation for the PolarFire SoC
Date:   Wed,  3 Mar 2021 12:02:50 -0800
Message-Id: <20210303200253.1827553-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303200253.1827553-1-atish.patra@wdc.com>
References: <20210303200253.1827553-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML DT binding documentation for the Microchip PolarFire SoC.
It is documented at:

https://www.microsemi.com/products/fpga-soc/polarfire-soc-icicle-quick-start-guide

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 .../devicetree/bindings/riscv/microchip.yaml  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/microchip.yaml

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
new file mode 100644
index 000000000000..3f981e897126
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/microchip.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PolarFire SoC-based boards device tree bindings
+
+maintainers:
+  - Cyril Jean <Cyril.Jean@microchip.com>
+  - Lewis Hanly <lewis.hanly@microchip.com>
+
+description:
+  Microchip PolarFire SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - microchip,mpfs-icicle-kit
+      - const: microchip,mpfs
+
+additionalProperties: true
+
+...
-- 
2.25.1

