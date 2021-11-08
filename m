Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8187E447C3B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 09:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbhKHIvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 03:51:03 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:23202 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238146AbhKHIvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 03:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636361298; x=1667897298;
  h=from:to:cc:subject:date:message-id;
  bh=dA0HAvdE9FeKiFecBhs2bqLE/d/A6Iscj2L+97uaEmQ=;
  b=O2gAhSQEs673eFHISNhg/pGyPuysxsaMGnE2bCeutnWZc+yqupH/fMmu
   8WKQ1RGXK6aiVazYuciIC5y0x1LWo3VEnhMMEARdORSASgKR0tmuE7Ml8
   SYbHhTUh9+yvLR7iVIR69jzw+4xl73gljQK01EYzJ/AaJHJGypXoleYbi
   AhqMc/Gt5aRygITXBYXHW2VQDKYKs9EyErniiI0oUHEFzZWF+vAX2E3zU
   6Nua8TiD+uNaNPyaHfHIm2vp+6HwhWaswOyy9mdF2XKTBE4hZur4NL88V
   QazAdxFCo9DL6vizNXoXs8PlOD1prdDzUD0Dz/OFBaiKfdgSKzeILvZw7
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="20370682"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Nov 2021 09:48:17 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 08 Nov 2021 09:48:17 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 08 Nov 2021 09:48:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636361297; x=1667897297;
  h=from:to:cc:subject:date:message-id;
  bh=dA0HAvdE9FeKiFecBhs2bqLE/d/A6Iscj2L+97uaEmQ=;
  b=JMinAEZ+JVQNGzwIMQ7rJShJUGTnx+uyVT5nc0c6fcE08lrjN/Qpa26I
   7v2dxCTDpm+RdsDRGG6v8MpbyBpdykexEPYUT6sD3MwuoaGuwSMdhXnL+
   /I6iQa0Oll0fe/q2aytQA8fQ4Kz00WdfuFAPXw7F9f+9xztBdpXjAtKyQ
   PHbVm5BjLXdGpWxlUZah+QDVKcznub1E9ezUQW14cwSdBjELet1WJwFXO
   aLoq9koNJHtn7L3y5nPx/JfEflij3FwEZqN2Wk3PhPp0ZrjCnvc/Yu3Cy
   HyQQIk2i2w0jA+pL5+dIg85UdqBBSOUQKVJ/8sU10o/s/F5ZNnCo4VLVW
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="20370680"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Nov 2021 09:48:16 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id B2463280065;
        Mon,  8 Nov 2021 09:48:16 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] of: base: Skip CPU nodes with non-"okay"/"disabled" status
Date:   Mon,  8 Nov 2021 09:48:04 +0100
Message-Id: <20211108084804.13474-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow fully disabling CPU nodes using status = "fail". Having no status
property at all is still interpreted as "okay" as usual.

This allows a bootloader to change the number of available CPUs (for
example when a common DTS is used for SoC variants with different numbers
of cores) without deleting the nodes altogether, which could require
additional fixups to avoid dangling phandle references.

References:
- https://www.lkml.org/lkml/2020/8/26/1237
- https://www.spinics.net/lists/devicetree-spec/msg01007.html
- https://github.com/devicetree-org/dt-schema/pull/61

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/of/base.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 61de453b885c..4e9973627c8d 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -650,6 +650,32 @@ bool of_device_is_available(const struct device_node *device)
 }
 EXPORT_SYMBOL(of_device_is_available);
 
+/**
+ *  __of_device_is_disabled - check if a device has status "disabled"
+ *
+ *  @device: Node to check status for, with locks already held
+ *
+ *  Return: True if the status property is set to "disabled",
+ *  false otherwise
+ *
+ *  Most callers should use __of_device_is_available() instead, this function
+ *  only exists due to the special interpretation of the "disabled" status for
+ *  CPU nodes.
+ */
+static bool __of_device_is_disabled(const struct device_node *device)
+{
+	const char *status;
+
+	if (!device)
+		return false;
+
+	status = __of_get_property(device, "status", NULL);
+	if (status == NULL)
+		return false;
+
+	return !strcmp(status, "disabled");
+}
+
 /**
  *  of_device_is_big_endian - check if a device has BE registers
  *
@@ -817,6 +843,9 @@ struct device_node *of_get_next_cpu_node(struct device_node *prev)
 		of_node_put(node);
 	}
 	for (; next; next = next->sibling) {
+		if (!__of_device_is_available(next) &&
+		    !__of_device_is_disabled(next))
+			continue;
 		if (!(of_node_name_eq(next, "cpu") ||
 		      __of_node_is_type(next, "cpu")))
 			continue;
-- 
2.17.1

