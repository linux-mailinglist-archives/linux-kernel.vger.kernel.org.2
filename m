Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3A0379B88
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhEKAaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:30:14 -0400
Received: from mx1.opensynergy.com ([217.66.60.4]:17517 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhEKA3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:29:49 -0400
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id A8397A1A35;
        Tue, 11 May 2021 02:22:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=cmoyI+jbzFuH
        zPs836GwRHzqAHaRxQ0315002Fo94F8=; b=oaeVrtyElQDSd7Y5fDQV9QkAHjE5
        RxDo5U3vQ0FHhgk3TBIDiR6iJ9FJAYAlOlRp9zOtISbitCeOkqi6SjF49mIrABcd
        L99Fj6YBx19pHUGR+dQoicUwo+ADIWRs+mz1aTVtx27sB0BCVV1tGY2ENzp36hIN
        P7WTwWuHSvMVIdRBHR19sTV2CNq2YNzrtJ1LoI9PjBQ2nBLI45tVRnSR2IvC/70Q
        5quP1qI0fmHiILFHkWuEImcWLpU90Cw/wGXti61OrrdDJxE9QioTFbvr82Hyfhg4
        WFtn6o+P0YUIY9J1PrPOgKZ21VXtIxwRzJq9agh8KAS4o4fiBmnnqpfhhw==
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <virtio-dev@lists.oasis-open.org>
CC:     Igor Skalkin <igor.skalkin@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>,
        <souvik.chakravarty@arm.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>,
        Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [RFC PATCH v3 10/12] dt-bindings: arm: Add virtio transport for SCMI
Date:   Tue, 11 May 2021 02:20:38 +0200
Message-ID: <20210511002040.802226-11-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511002040.802226-1-peter.hilber@opensynergy.com>
References: <20210511002040.802226-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Skalkin <igor.skalkin@opensynergy.com>

Document the properties for arm,scmi-virtio compatible nodes. The
backing virtio SCMI device is described in patch [1].

[1] https://lists.oasis-open.org/archives/virtio-comment/202005/msg00096.html

Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
[ Peter: Adapted patch for submission to upstream. ]
Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 .../devicetree/bindings/arm/arm,scmi.txt      | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
index 667d58e0a659..5d209ba666f6 100644
--- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -13,6 +13,9 @@ the device tree.
 Required properties:
 
 The scmi node with the following properties shall be under the /firmware/ node.
+Some properties are specific to a transport type.
+
+shmem-based transports (mailbox, smc/hvc):
 
 - compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports
 - mboxes: List of phandle and mailbox channel specifiers. It should contain
@@ -21,6 +24,15 @@ The scmi node with the following properties shall be under the /firmware/ node.
 	  supported.
 - shmem : List of phandle pointing to the shared memory(SHM) area as per
 	  generic mailbox client binding.
+
+Virtio transport:
+
+- compatible : shall be "arm,scmi-virtio".
+
+The virtio transport only supports a single device.
+
+Additional required properties:
+
 - #address-cells : should be '1' if the device has sub-nodes, maps to
 	  protocol identifier for a given sub-node.
 - #size-cells : should be '0' as 'reg' property doesn't have any size
@@ -50,7 +62,8 @@ Each protocol supported shall have a sub-node with corresponding compatible
 as described in the following sections. If the platform supports dedicated
 communication channel for a particular protocol, the 3 properties namely:
 mboxes, mbox-names and shmem shall be present in the sub-node corresponding
-to that protocol.
+to that protocol. The virtio transport does not support dedicated communication
+channels.
 
 Clock/Performance bindings for the clocks/OPPs based on SCMI Message Protocol
 ------------------------------------------------------------
@@ -129,7 +142,8 @@ Required sub-node properties:
 [5] Documentation/devicetree/bindings/reset/reset.txt
 [6] Documentation/devicetree/bindings/regulator/regulator.yaml
 
-Example:
+Example (mailbox transport):
+----------------------------
 
 sram@50000000 {
 	compatible = "mmio-sram";
@@ -237,3 +251,20 @@ thermal-zones {
 		...
 	};
 };
+
+Example (virtio transport):
+---------------------------
+
+virtio_mmio@4b001000 {
+	compatible = "virtio,mmio";
+	...
+};
+
+firmware {
+	...
+	scmi {
+		compatible = "arm,scmi-virtio";
+		...
+
+The rest is similar to the mailbox transport example, when omitting the
+mailbox/shmem-specific properties.
-- 
2.25.1


