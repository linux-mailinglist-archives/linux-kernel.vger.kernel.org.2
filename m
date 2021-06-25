Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE68F3B39E8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhFYAEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbhFYAEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624579342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+wKoPdALbaD3tVp79gM2GE/9YWWpDDpYQ8N7Jn+BlQ0=;
        b=hAs5znLjMsw19NZJJDSOqOW+yJ83ZM+JL/r3cdrVQWugM1cxU2fwNMav/uKEEtXWXxeCcg
        PSzQQS2eTVQJ9S7/GejGr/mxDUAXm4RawNGP9ffsLIlkJ5mqOKjWdVtxgnomiGqx7H+POO
        RIKfayVNMunhqCXzQ+6yzqDx+IsTXiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-JtbEfKoLMXWBo6I1IAN1Zg-1; Thu, 24 Jun 2021 20:02:21 -0400
X-MC-Unique: JtbEfKoLMXWBo6I1IAN1Zg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3A8519067E3;
        Fri, 25 Jun 2021 00:02:19 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-70.bne.redhat.com [10.64.54.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2237F6090F;
        Fri, 25 Jun 2021 00:02:17 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        robh+dt@kernel.org, drjones@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v2] Documentation, dt, numa: Add note to empty NUMA node
Date:   Fri, 25 Jun 2021 10:03:22 +0800
Message-Id: <20210625020322.43825-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
v2: Update to address Randy's comments
---
 Documentation/devicetree/bindings/numa.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
index 21b35053ca5a..08e361f9954c 100644
--- a/Documentation/devicetree/bindings/numa.txt
+++ b/Documentation/devicetree/bindings/numa.txt
@@ -109,6 +109,10 @@ Example:
 Dual socket system consists of 2 boards connected through ccn bus and
 each board having one socket/soc of 8 cpus, memory and pci bus.
 
+Note that the empty NUMA nodes, which no memory resides in period, are
+allowed. Their NUMA node IDs are still valid so that memory can be added
+into these NUMA nodes through hotplug afterwards.
+
 	memory@c00000 {
 		device_type = "memory";
 		reg = <0x0 0xc00000 0x0 0x80000000>;
-- 
2.23.0

