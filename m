Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C23730FF0C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhBDVD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:03:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbhBDVDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612472529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r8LJOJOCQ58un32theY/EJTbJf0j1q2uCcdggM463dA=;
        b=jKMXhisQvZVOdb1xHc7og/UJTaO6+2tocpLIK+H0uewBeDIcfehbZ0niSF9ZU388JiVC+J
        C7sC+57yTwuO8COTXanBYPKSFNAYrPrjP8kjArfDDh0qDyf30tWyal43OzGrFO8FbkRKuV
        3RKH+8OomjVKHLnSv8rNs5NGVDa4LpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-Z142Y3p_NmK3McYaol_iuw-1; Thu, 04 Feb 2021 16:02:08 -0500
X-MC-Unique: Z142Y3p_NmK3McYaol_iuw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06A04801962;
        Thu,  4 Feb 2021 21:02:07 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-68.ams2.redhat.com [10.36.112.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D462B1A38C;
        Thu,  4 Feb 2021 21:02:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/1] genirq: Fix [devm_]irq_alloc_desc returning irq 0
Date:   Thu,  4 Feb 2021 22:02:03 +0100
Message-Id: <20210204210203.105934-2-hdegoede@redhat.com>
In-Reply-To: <20210204210203.105934-1-hdegoede@redhat.com>
References: <20210204210203.105934-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0
is invalid"), having a linux-irq with number 0 will trigger a WARN
when calling platform_get_irq*() to retrieve that linux-irq.

Since [devm_]irq_alloc_desc allocs 1 single irq and since irq 0 is
normally not used, it would return 0 before this commit, triggering
that WARN. This happens e.g. on Intel Bay Trail and Cherry Trail
devices using the LPE audio engine for HDMI audio:

[   22.761392] ------------[ cut here ]------------
[   22.761405] 0 is an invalid IRQ number
[   22.761462] WARNING: CPU: 3 PID: 472 at drivers/base/platform.c:238 platform_get_irq_optional+0x108/0x180
[   22.761470] Modules linked in: snd_hdmi_lpe_audio(+) ...
...
[   22.762133] Call Trace:
[   22.762158]  platform_get_irq+0x17/0x30
[   22.762182]  hdmi_lpe_audio_probe+0x4a/0x6c0 [snd_hdmi_lpe_audio]
...
[   22.762726] ---[ end trace ceece38854223a0b ]---

Change the 'from' parameter passed to __[devm_]irq_alloc_descs() by the
[devm_]irq_alloc_desc macros from 0 to 1, so that these macros
will no longer return 0.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
A quick grep for 'irq_alloc_desc\(' shows only 2 users of irq_alloc_desc():
1. drivers/gpu/drm/i915/display/intel_lpe_audio.c
2. drivers/sh/intc/virq.c
But that might very well be an incomplete list.
---
 include/linux/irq.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 4aeb1c4c7e07..2efde6a79b7e 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -928,7 +928,7 @@ int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
 	__irq_alloc_descs(irq, from, cnt, node, THIS_MODULE, NULL)
 
 #define irq_alloc_desc(node)			\
-	irq_alloc_descs(-1, 0, 1, node)
+	irq_alloc_descs(-1, 1, 1, node)
 
 #define irq_alloc_desc_at(at, node)		\
 	irq_alloc_descs(at, at, 1, node)
@@ -943,7 +943,7 @@ int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
 	__devm_irq_alloc_descs(dev, irq, from, cnt, node, THIS_MODULE, NULL)
 
 #define devm_irq_alloc_desc(dev, node)				\
-	devm_irq_alloc_descs(dev, -1, 0, 1, node)
+	devm_irq_alloc_descs(dev, -1, 1, 1, node)
 
 #define devm_irq_alloc_desc_at(dev, at, node)			\
 	devm_irq_alloc_descs(dev, at, at, 1, node)
-- 
2.29.2

