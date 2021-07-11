Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F003C39B1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 02:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhGKA7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 20:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229640AbhGKA7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 20:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625964990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FnNM7fXcs9SAtYFQNh27M2dM/fltJDgs7VIySGxQ9Mc=;
        b=dfwPXf1ZevsTTIa03m0FMtGDxCnDt3E8Z+Y3okvZ2C0V2F47mEW1a7gnHcJzC+hNbLcMDZ
        t1Sj2OuBZ3UhQyA7PzsBVYTSp34thccfADwW05UEygienwIF+4lveryQTRicOunAwQFTEK
        +v66A/54B5P6Chl9cUrn4IRMKEoWb80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-huAfS36YPYuoZsyPm1fmfg-1; Sat, 10 Jul 2021 20:56:29 -0400
X-MC-Unique: huAfS36YPYuoZsyPm1fmfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36FD4800D62;
        Sun, 11 Jul 2021 00:56:28 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-119.bne.redhat.com [10.64.54.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51B4460C0F;
        Sun, 11 Jul 2021 00:56:25 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rdunlap@infradead.org, drjones@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v6] Documentation, dt, numa: Add note to empty NUMA node
Date:   Sun, 11 Jul 2021 08:56:21 +0800
Message-Id: <20210711005621.292702-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
v6: Drop '0x' in 'unit-address' as Rob suggested
---
 Documentation/devicetree/bindings/numa.txt | 61 +++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
index 21b35053ca5a..7a7f281a401f 100644
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
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x80000000>;
+		numa-node-id = <1>;
+	};
+
+	/* Empty memory node */
+	memory@100000002 {
+		device_type = "memory";
+		reg = <0x1 0x2 0x0 0x0>;
+		numa-node-id = <2>;
+	};
+
+	/* Empty memory node */
+	memory@100000003 {
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

