Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4079458DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbhKVLtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:49:01 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:64615 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233849AbhKVLtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1637581554; x=1669117554;
  h=from:to:cc:subject:date:message-id;
  bh=3JJZDUu1j9baszZ4dgxQHmWH6Y7rD/2UOc8z4zphYxg=;
  b=hx/ump2QVi+DOtYGw3U6dSrJmK0VUil4Iriv5JPRryKXEwFmxcJpPKfd
   28Ouf3N88Wpvfx73HAzyAJZnJyRjsuysmGKQVcpz2p0XmFH5UuuBvldmD
   UOFM/tEjrsJIcFyJY4k3fASLvjNDux4ENmJ/13bGQDfpBqznKPlI3rHpO
   KnDm9O/CurgLtyWbF5gLOFirtSoMkVdP0S25C+beItiLfLMMRTxgnOn0d
   XXsRWfzB0z1aFSfVkwgIppxEKozYHjOpNrquM88u+Rhw96qx6eyaYRZuS
   NSdoTNtoZmnB7mtRyh2RxTqSTAfbZTDP7UD8QDk92EmZYrIuzqmqULNPm
   w==;
X-IronPort-AV: E=Sophos;i="5.87,254,1631570400"; 
   d="scan'208";a="20594175"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 22 Nov 2021 12:45:52 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 22 Nov 2021 12:45:52 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 22 Nov 2021 12:45:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1637581552; x=1669117552;
  h=from:to:cc:subject:date:message-id;
  bh=3JJZDUu1j9baszZ4dgxQHmWH6Y7rD/2UOc8z4zphYxg=;
  b=Iq0BZkl4eYPaUoUIUm0sqMbhvbI76MMjqb/D1AhznWhQJtyiFxbA4cJG
   RxlVkqfvD815NmBW+GOpltMJTfSOs9KGUwYsEximANzecsNoDfw2S3M2X
   R+NEpXLtjzicqRVG/giBPUyVWvdNOOvrwte8HyqmZTgiHMDgWzZ8TcPFK
   0WcbCUHZca8eXLvyTwkDcYBwnSQHWyTk7FT9qq5Ynl7tKiIiVe2LR8n63
   usPsvB0aam70DQ3UfUt0gTES7w17zpQPWwH/fsm8H3sGrYrqLTMDPfzKQ
   w9rIcOxC6yBBXsEe9uGtJWY3PtHlMYIGZUYx8/2ewY8aibBDVSHPanMS0
   g==;
X-IronPort-AV: E=Sophos;i="5.87,254,1631570400"; 
   d="scan'208";a="20594174"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 22 Nov 2021 12:45:52 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id AF12C280065;
        Mon, 22 Nov 2021 12:45:52 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2] of: base: Skip CPU nodes with "fail"/"fail-..." status
Date:   Mon, 22 Nov 2021 12:45:36 +0100
Message-Id: <20211122114536.2981-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow fully disabling CPU nodes using status = "fail".

This allows a bootloader to change the number of available CPUs (for
example when a common DTS is used for SoC variants with different numbers
of cores) without deleting the nodes altogether, which could require
additional fixups to avoid dangling phandle references.

Unknown status values (everything that is not "okay"/"ok", "disabled" or
"fail"/"fail-...") will continue to be interpreted like "disabled",
meaning that the CPU can be enabled during boot.

References:
- https://www.lkml.org/lkml/2020/8/26/1237
- https://www.spinics.net/lists/devicetree-spec/msg01007.html
- https://github.com/devicetree-org/dt-schema/pull/61

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: Treat unknown status values like "disabled", not like "fail"


 drivers/of/base.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 61de453b885c..5b907600f5b0 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -650,6 +650,28 @@ bool of_device_is_available(const struct device_node *device)
 }
 EXPORT_SYMBOL(of_device_is_available);
 
+/**
+ *  __of_device_is_fail - check if a device has status "fail" or "fail-..."
+ *
+ *  @device: Node to check status for, with locks already held
+ *
+ *  Return: True if the status property is set to "fail" or "fail-..." (for any
+ *  error code suffix), false otherwise
+ */
+static bool __of_device_is_fail(const struct device_node *device)
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
+	return !strcmp(status, "fail") || !strncmp(status, "fail-", 5);
+}
+
 /**
  *  of_device_is_big_endian - check if a device has BE registers
  *
@@ -796,6 +818,9 @@ EXPORT_SYMBOL(of_get_next_available_child);
  * of_get_next_cpu_node - Iterate on cpu nodes
  * @prev:	previous child of the /cpus node, or NULL to get first
  *
+ * Unusable CPUs (those with the status property set to "fail" or "fail-...")
+ * will be skipped.
+ *
  * Return: A cpu node pointer with refcount incremented, use of_node_put()
  * on it when done. Returns NULL when prev is the last child. Decrements
  * the refcount of prev.
@@ -817,6 +842,8 @@ struct device_node *of_get_next_cpu_node(struct device_node *prev)
 		of_node_put(node);
 	}
 	for (; next; next = next->sibling) {
+		if (__of_device_is_fail(next))
+			continue;
 		if (!(of_node_name_eq(next, "cpu") ||
 		      __of_node_is_type(next, "cpu")))
 			continue;
-- 
2.17.1

