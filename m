Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D67D3B248F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 03:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhFXBik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 21:38:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229850AbhFXBih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 21:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624498578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MWyyy9NSRWYF/IIOd9RfJwjKp0KmO/I0ymT6gR07HiY=;
        b=VZYa00ddQ1OjZUlWIwpD5PNLITk5Z+I+BHTK9yS3kLFiA4hLiXb4RJ+A5V3gHFco+9lxid
        33l8PQYXe9HKcH1y5XBEOO0HYfDT9ZSwVxcjlnhSGWQLANGaWCR+gpr3aad0OSwxrZJAMR
        FdI1s53un77Zv9cLY2d/8Mm+DhSCHEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-O8Z27GltM5Wg0YAVBsHl6w-1; Wed, 23 Jun 2021 21:36:17 -0400
X-MC-Unique: O8Z27GltM5Wg0YAVBsHl6w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BA741084F53;
        Thu, 24 Jun 2021 01:36:16 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-70.bne.redhat.com [10.64.54.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4EA85D9C6;
        Thu, 24 Jun 2021 01:36:14 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        drjones@redhat.com, shan.gavin@gmail.com
Subject: [PATCH] Documentation, dt, numa: Add note to empty NUMA node
Date:   Thu, 24 Jun 2021 11:37:40 +0800
Message-Id: <20210624033740.20862-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The empty NUMA nodes, where no memory resides in, are allowed. For
these empty NUMA nodes, the 'len' of 'reg' property is zero. These
empty NUMA node IDs are still valid and parsed. I finds difficulty
to get where it's properly documented.

So lets add note to empty NUMA nodes in the NUMA binding doc.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 Documentation/devicetree/bindings/numa.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
index 21b35053ca5a..c564705c0eac 100644
--- a/Documentation/devicetree/bindings/numa.txt
+++ b/Documentation/devicetree/bindings/numa.txt
@@ -109,6 +109,10 @@ Example:
 Dual socket system consists of 2 boards connected through ccn bus and
 each board having one socket/soc of 8 cpus, memory and pci bus.
 
+Note that the empty NUMA nodes, which no memory resides in, are allowed
+Their NUMA node IDs are still valid so that memory can be added into these
+NUMA nodes through hotplug afterwards.
+
 	memory@c00000 {
 		device_type = "memory";
 		reg = <0x0 0xc00000 0x0 0x80000000>;
-- 
2.23.0

