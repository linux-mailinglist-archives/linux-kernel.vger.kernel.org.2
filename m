Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454633B5B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhF1Jgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 05:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35741 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232348AbhF1Jgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624872865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OH+jVVr1lvBtZ9CWlaipwKLG10KB8Y6CJCSIOW1M3BE=;
        b=C1DUbap4RrCaGNcg1YPdrpWbk0j530e1Nw9WSrF+6i9rLlHkvIFOWbnglUwmtbsH+EXGI1
        yutRYYLeGBpf5Aj7Kuwc6CB8kzfdsMc3ctSDtzrtn7+Idq8RZDul1gQn3G4PlQtmeMYAmS
        z/vvlzqZ/uYInCPBJHUCCrGdP4QTq+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-SPwY-9xXNaWRvF0Vc_Vq1Q-1; Mon, 28 Jun 2021 05:34:22 -0400
X-MC-Unique: SPwY-9xXNaWRvF0Vc_Vq1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A17E8800C78;
        Mon, 28 Jun 2021 09:34:21 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-204.bne.redhat.com [10.64.54.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 319D819C87;
        Mon, 28 Jun 2021 09:34:18 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        drjones@redhat.com, robh+dt@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v5] Documentation, dt, numa: Add note to empty NUMA node
Date:   Mon, 28 Jun 2021 17:34:11 +0800
Message-Id: <20210628093411.88805-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The empty memory nodes, where no memory resides in, are allowed.
For these empty memory nodes, the 'len' of 'reg' property is zero.
The NUMA node IDs are still valid and parsed, but memory may be
added to them through hotplug afterwards. I finds difficulty to
get where it's properly documented.

So lets add a section for empty memory nodes in NUMA binding
document. Also, the 'unit-address', equivalent to 'base-address'
in the 'reg' property of these empty memory nodes is suggested to
be the summation of highest memory address plus the NUMA node ID.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
v5: Separate section for empty memory node
---
 Documentation/devicetree/bindings/numa.txt | 61 +++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
index 21b35053ca5a..230c734af948 100644
--- a/Documentation/devicetree/bindings/numa.txt
+++ b/Documentation/devicetree/bindings/numa.txt
@@ -103,7 +103,66 @@ Example:
 		};
 
 ==============================================================================
-4 - Example dts
+4 - Empty memory nodes
+==============================================================================
+
+Empty memory nodes, which no memory resides in, are allowed. The 'length'
+field of the 'reg' property is zero, but the 'base-address' is a dummy
+address and invalid. The 'base-address' could be the summation of highest
+memory address plus the NUMA node ID. However, the NUMA node IDs and
+distance maps are still valid and memory may be added into them through
+hotplug afterwards.
+
+Example:
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+		numa-node-id = <0>;
+	};
+
+	memory@0x80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x80000000>;
+		numa-node-id = <1>;
+	};
+
+	/* Empty memory node */
+	memory@0x100000002 {
+		device_type = "memory";
+		reg = <0x1 0x2 0x0 0x0>;
+		numa-node-id = <2>;
+	};
+
+	/* Empty memory node */
+	memory@0x100000003 {
+		device_type = "memory";
+		reg = <0x1 0x3 0x0 0x0>;
+		numa-node-id = <3>;
+	};
+
+	distance-map {
+		compatible = "numa-distance-map-v1";
+		distance-matrix = <0 0  10>,
+				  <0 1  20>,
+				  <0 2  40>,
+				  <0 3  20>,
+				  <1 0  20>,
+				  <1 1  10>,
+				  <1 2  20>,
+				  <1 3  40>,
+				  <2 0  40>,
+				  <2 1  20>,
+				  <2 2  10>,
+				  <2 3  20>,
+				  <3 0  20>,
+				  <3 1  40>,
+				  <3 2  20>,
+				  <3 3  10>;
+	};
+
+==============================================================================
+5 - Example dts
 ==============================================================================
 
 Dual socket system consists of 2 boards connected through ccn bus and
-- 
2.23.0

