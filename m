Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0C936CEB6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 00:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbhD0Wmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 18:42:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:59672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236936AbhD0Wmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 18:42:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27BDDAEF5;
        Tue, 27 Apr 2021 22:42:08 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-binding: interrupt-controller: Add missing interrupts property
Date:   Wed, 28 Apr 2021 00:42:00 +0200
Message-Id: <20210427224201.32285-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupts property is required, so add it.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 .../bindings/interrupt-controller/idt,32434-pic.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/idt,32434-pic.yaml b/Documentation/devicetree/bindings/interrupt-controller/idt,32434-pic.yaml
index df5d8d1ead70..160ff4b07cac 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/idt,32434-pic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/idt,32434-pic.yaml
@@ -22,6 +22,9 @@ properties:
   reg:
     maxItems: 1
 
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
 
 required:
@@ -29,6 +32,7 @@ required:
   - compatible
   - reg
   - interrupt-controller
+  - interrupts
 
 additionalProperties: false
 
-- 
2.29.2

