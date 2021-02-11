Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A5131933B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhBKTiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:38:51 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:34019 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229731AbhBKTis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:38:48 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 11BJbwY9015068
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 20:37:58 +0100
Received: from md1f2u6c.ad001.siemens.net ([139.22.42.110])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 11BJWuhe031206;
        Thu, 11 Feb 2021 20:32:57 +0100
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Le Jin <le.jin@siemens.com>,
        Bao Cheng Su <baocheng.su@siemens.com>
Subject: [PATCH v2 1/4] dt-bindings: Add Siemens vendor prefix
Date:   Thu, 11 Feb 2021 20:32:53 +0100
Message-Id: <4726d7ad39d40916a02b5e79fc17e15934e97f5d.1613071976.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1613071976.git.jan.kiszka@siemens.com>
References: <cover.1613071976.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Add prefix for Siemens AG.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 041ae90b0d8f..ff4e8f1b1557 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1014,6 +1014,8 @@ patternProperties:
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

