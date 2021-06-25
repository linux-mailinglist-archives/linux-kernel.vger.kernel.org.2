Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1E3B3C33
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhFYF0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 01:26:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44750 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230172AbhFYF0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 01:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624598631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JEzA3/KcHqjV1NTgdCCaV4I2K2xF2kBaxzJKUrI7KNU=;
        b=YY9H2maviywsYbXtPGTiTgJyfmyTWscx08YR2RGDkKt89EaQBOLIisW49GKtPcfvjORH6Q
        Qx83G8FXaOBA8iULU1oyNsXiOHz72kgPaxieZGgUFwhv8r49R7K0tE0K824QqS4+ry3HmL
        r4Un2Ukha+GETEaMOPk9emGB0HfQRA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-gp0CA3GcNw-ynVpkfZy3kA-1; Fri, 25 Jun 2021 01:23:49 -0400
X-MC-Unique: gp0CA3GcNw-ynVpkfZy3kA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79FC3802C89;
        Fri, 25 Jun 2021 05:23:48 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-233.bne.redhat.com [10.64.54.233])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3503760C05;
        Fri, 25 Jun 2021 05:23:45 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        robh+dt@kernel.org, drjones@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v4] Documentation, dt, numa: Add note to empty NUMA node
Date:   Fri, 25 Jun 2021 13:23:38 +0800
Message-Id: <20210625052338.4875-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The empty memory nodes, where no memory resides in, are allowed.
For these empty memory nodes, the 'len' of 'reg' property is zero.
The NUMA node IDs are still valid and parsed, but memory can be
added to them through hotplug afterwards. I finds difficulty to
get where it's properly documented.

So lets add note to empty memory nodes in the NUMA binding doc.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 Documentation/devicetree/bindings/numa.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
index 21b35053ca5a..0fc882e44270 100644
--- a/Documentation/devicetree/bindings/numa.txt
+++ b/Documentation/devicetree/bindings/numa.txt
@@ -109,6 +109,10 @@ Example:
 Dual socket system consists of 2 boards connected through ccn bus and
 each board having one socket/soc of 8 cpus, memory and pci bus.
 
+Note that empty memory nodes, which no memory resides in, are allowed.
+The NUMA node IDs in these empty memory nodes are still valid, but
+memory can be added into them through hotplug afterwards.
+
 	memory@c00000 {
 		device_type = "memory";
 		reg = <0x0 0xc00000 0x0 0x80000000>;
-- 
2.23.0

