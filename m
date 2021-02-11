Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925CF31932D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhBKTe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:34:26 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:33189 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhBKTdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:33:55 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 11BJWw86008942
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 20:32:58 +0100
Received: from md1f2u6c.ad001.siemens.net ([139.22.42.110])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 11BJWuhf031206;
        Thu, 11 Feb 2021 20:32:58 +0100
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Le Jin <le.jin@siemens.com>,
        Bao Cheng Su <baocheng.su@siemens.com>
Subject: [PATCH v2 2/4] dt-bindings: arm: ti: Add bindings for Siemens IOT2050 boards
Date:   Thu, 11 Feb 2021 20:32:54 +0100
Message-Id: <68c2099e6b3a568fe43f522a042592b120f871a3.1613071976.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1613071976.git.jan.kiszka@siemens.com>
References: <cover.1613071976.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

These boards are based on AM6528 GP and AM6548 HS SOCs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index c6e1c1e63e43..b1ab0cf4a2d6 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -23,6 +23,8 @@ properties:
         items:
           - enum:
               - ti,am654-evm
+              - siemens,iot2050-basic
+              - siemens,iot2050-advanced
           - const: ti,am654
 
       - description: K3 J721E SoC
-- 
2.26.2

