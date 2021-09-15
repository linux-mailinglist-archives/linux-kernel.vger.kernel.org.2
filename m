Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1157440C53E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbhIOM2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:28:49 -0400
Received: from thoth.sbs.de ([192.35.17.2]:35181 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234393AbhIOM2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:28:45 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 18FCREbJ005863
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 14:27:14 +0200
Received: from md1f2u6c.ad001.siemens.net ([167.87.79.72])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 18FCRAr6006124;
        Wed, 15 Sep 2021 14:27:14 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH v4 4/6] dt-bindings: arm: ti: Add bindings for Siemens IOT2050 PG2 boards
Date:   Wed, 15 Sep 2021 14:27:08 +0200
Message-Id: <336ade4715b3d2f5f83c3ed8f3fa2989f5699578.1631708830.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631708830.git.jan.kiszka@siemens.com>
References: <cover.1631708830.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Product Generation 2 (PG2) boards are based on SR2.x SoCs and will be
released soon.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index c5aa362e4026..ccde4a0d7b46 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -24,7 +24,9 @@ properties:
           - enum:
               - ti,am654-evm
               - siemens,iot2050-basic
+              - siemens,iot2050-basic-pg2
               - siemens,iot2050-advanced
+              - siemens,iot2050-advanced-pg2
           - const: ti,am654
 
       - description: K3 J721E SoC
-- 
2.31.1

