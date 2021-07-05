Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABBB3BBE76
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 16:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhGEOxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 10:53:44 -0400
Received: from foss.arm.com ([217.140.110.172]:48230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231787AbhGEOxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 10:53:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00D5E1FB;
        Mon,  5 Jul 2021 07:51:05 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0991A3F694;
        Mon,  5 Jul 2021 07:51:01 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com,
        igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com,
        alex.bennee@linaro.org, jean-philippe@linaro.org,
        mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com,
        Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: [PATCH v5 14/15] dt-bindings: arm: Add virtio transport for SCMI
Date:   Mon,  5 Jul 2021 15:49:13 +0100
Message-Id: <20210705144914.35094-15-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210705144914.35094-1-cristian.marussi@arm.com>
References: <20210705144914.35094-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Skalkin <igor.skalkin@opensynergy.com>

Document the properties for arm,scmi-virtio compatible nodes.
The backing virtio SCMI device is described in patch [1].

While doing that, make shmem property required only for pre-existing
mailbox and smc transports, since virtio-scmi does not need it.

[1] https://lists.oasis-open.org/archives/virtio-comment/202102/msg00018.html

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
[ Peter: Adapted patch for submission to upstream. ]
Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
[ Cristian: converted to yaml format, moved shmen required property. ]
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> V4
- convertd to YAML
- make shmem required only for pre-existing mailbox and smc transport
- updated VirtIO specification patch message reference
- dropped virtio-mmio SCMI device example since really not pertinent to
  virtio-scmi dt bindings transport: it is not even referenced in SCMI
  virtio DT node since they are enumerated by VirtIO subsystem and there
  could be PCI based SCMI devices anyway.
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index cebf6ffe70d5..5c4c6782e052 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -34,6 +34,10 @@ properties:
       - description: SCMI compliant firmware with ARM SMC/HVC transport
         items:
           - const: arm,scmi-smc
+      - description: SCMI compliant firmware with SCMI Virtio transport.
+                     The virtio transport only supports a single device.
+        items:
+          - const: arm,scmi-virtio
 
   interrupts:
     description:
@@ -172,6 +176,7 @@ patternProperties:
       Each sub-node represents a protocol supported. If the platform
       supports a dedicated communication channel for a particular protocol,
       then the corresponding transport properties must be present.
+      The virtio transport does not support a dedicated communication channel.
 
     properties:
       reg:
@@ -195,7 +200,6 @@ patternProperties:
 
 required:
   - compatible
-  - shmem
 
 if:
   properties:
@@ -209,6 +213,7 @@ then:
 
   required:
     - mboxes
+    - shmem
 
 else:
   if:
@@ -219,6 +224,7 @@ else:
   then:
     required:
       - arm,smc-id
+      - shmem
 
 examples:
   - |
-- 
2.17.1

