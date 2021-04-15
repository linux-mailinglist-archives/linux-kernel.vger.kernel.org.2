Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A2536056D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhDOJQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:16:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:46106 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232045AbhDOJQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:16:22 -0400
IronPort-SDR: nmxAxwT0SUB9RB4NFRYHGZV0aRUQzvumiiu1EolkW5jPOSG7/HOq/6vAKrM/GRV1+6SXeWPE5N
 0M05fj59F74g==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="174926267"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="174926267"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 02:15:59 -0700
IronPort-SDR: oQzuUcMoI2vuuTWGgalGtjzFaNKicnORnfko2KcYGHKjpMVSgEiKGP4DuQNd43Ko1WctR9kX+z
 gtHcrgNmqpvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="461551520"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 15 Apr 2021 02:15:57 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] stm class: Use correct UUID APIs
Date:   Thu, 15 Apr 2021 12:15:55 +0300
Message-Id: <20210415091555.88085-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

It appears that the STM code didn't manage to accurately decypher the
delicate inner workings of an alternative thought process behind the
UUID API and directly called generate_random_uuid() that clearly needs
to be a static function in lib/uuid.c.

At the same time, said STM code is poking directly at the byte array
inside the uuid_t when it uses the UUID for its internal purposes.

Fix these two transgressions by using intended APIs instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
[ash: changed back to uuid_t and updated the commit message]
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/p_sys-t.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/stm/p_sys-t.c b/drivers/hwtracing/stm/p_sys-t.c
index 360b5c03df95..8254971c02e7 100644
--- a/drivers/hwtracing/stm/p_sys-t.c
+++ b/drivers/hwtracing/stm/p_sys-t.c
@@ -92,7 +92,7 @@ static void sys_t_policy_node_init(void *priv)
 {
 	struct sys_t_policy_node *pn = priv;
 
-	generate_random_uuid(pn->uuid.b);
+	uuid_gen(&pn->uuid);
 }
 
 static int sys_t_output_open(void *priv, struct stm_output *output)
@@ -292,6 +292,7 @@ static ssize_t sys_t_write(struct stm_data *data, struct stm_output *output,
 	unsigned int m = output->master;
 	const unsigned char nil = 0;
 	u32 header = DATA_HEADER;
+	u8 uuid[UUID_SIZE];
 	ssize_t sz;
 
 	/* We require an existing policy node to proceed */
@@ -322,7 +323,8 @@ static ssize_t sys_t_write(struct stm_data *data, struct stm_output *output,
 		return sz;
 
 	/* GUID */
-	sz = stm_data_write(data, m, c, false, op->node.uuid.b, UUID_SIZE);
+	export_uuid(uuid, &op->node.uuid);
+	sz = stm_data_write(data, m, c, false, uuid, sizeof(op->node.uuid));
 	if (sz <= 0)
 		return sz;
 
-- 
2.30.2

