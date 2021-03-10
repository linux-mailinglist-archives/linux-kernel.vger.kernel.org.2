Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D294B33392B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCJJtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:49:07 -0500
Received: from gecko.sbs.de ([194.138.37.40]:54996 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231489AbhCJJsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:48:05 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 12A9looM023867
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 10:47:50 +0100
Received: from md1f2u6c.ad001.siemens.net ([167.87.35.81])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 12A9bmN5017567;
        Wed, 10 Mar 2021 10:37:49 +0100
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Le Jin <le.jin@siemens.com>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: Add Siemens vendor prefix
Date:   Wed, 10 Mar 2021 10:37:46 +0100
Message-Id: <e087e267b2aeb384ed9a1a70557d82c8e0493403.1615369068.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615369068.git.jan.kiszka@siemens.com>
References: <cover.1615369068.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Add prefix for Siemens AG.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f6064d84a424..91f99130a933 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1024,6 +1024,8 @@ patternProperties:
     description: Silex Insight
   "^siliconmitus,.*":
     description: Silicon Mitus, Inc.
+  "^siemens,.*":
+    description: Siemens AG
   "^simtek,.*":
     description: Cypress Semiconductor Corporation (Simtek Corporation)
   "^sinlinx,.*":
-- 
2.26.2

