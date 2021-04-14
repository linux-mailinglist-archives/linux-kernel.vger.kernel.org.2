Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD7935F992
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343709AbhDNRNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:13:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:3013 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233433AbhDNRNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:13:04 -0400
IronPort-SDR: T72mCPwBChFuXngrAT7moXLzxgoIkIr355i0UKw+23nbRyw1f3fsb3C+/MkMzP3QC+Jx+DzYS+
 2cj/0Qov+69Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="181811912"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="181811912"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 10:12:43 -0700
IronPort-SDR: H6BS4xofiw/LO7ZHS1dCEkOJzKxnMrHMBFfxTlre7khZ5UigqmoQG0To3ZizgcOFOZcMVf0xsU
 xKkgMu6XzqZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="382427932"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 14 Apr 2021 10:12:40 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 2/7] stm class: Replace uuid_t with plain u8 uuid[16]
Date:   Wed, 14 Apr 2021 20:12:46 +0300
Message-Id: <20210414171251.14672-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
References: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

It appears that uuid_t use in STM code abuses UUID API. Moreover,
this type is only useful when we parse user input. Due to above
replace uuid_t with u8 uuid[16] and use uuid_t only when parse
user input.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/p_sys-t.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/stm/p_sys-t.c b/drivers/hwtracing/stm/p_sys-t.c
index 360b5c03df95..04d13b3785d3 100644
--- a/drivers/hwtracing/stm/p_sys-t.c
+++ b/drivers/hwtracing/stm/p_sys-t.c
@@ -76,7 +76,7 @@ enum sys_t_message_string_subtype {
 				 MIPI_SYST_SEVERITY(MAX))
 
 struct sys_t_policy_node {
-	uuid_t		uuid;
+	u8		uuid[UUID_SIZE];
 	bool		do_len;
 	unsigned long	ts_interval;
 	unsigned long	clocksync_interval;
@@ -92,7 +92,7 @@ static void sys_t_policy_node_init(void *priv)
 {
 	struct sys_t_policy_node *pn = priv;
 
-	generate_random_uuid(pn->uuid.b);
+	generate_random_uuid(pn->uuid);
 }
 
 static int sys_t_output_open(void *priv, struct stm_output *output)
@@ -120,7 +120,7 @@ static ssize_t sys_t_policy_uuid_show(struct config_item *item,
 {
 	struct sys_t_policy_node *pn = to_pdrv_policy_node(item);
 
-	return sprintf(page, "%pU\n", &pn->uuid);
+	return sprintf(page, "%pU\n", pn->uuid);
 }
 
 static ssize_t
@@ -129,13 +129,17 @@ sys_t_policy_uuid_store(struct config_item *item, const char *page,
 {
 	struct mutex *mutexp = &item->ci_group->cg_subsys->su_mutex;
 	struct sys_t_policy_node *pn = to_pdrv_policy_node(item);
+	uuid_t uuid;
 	int ret;
 
 	mutex_lock(mutexp);
-	ret = uuid_parse(page, &pn->uuid);
+	ret = uuid_parse(page, &uuid);
 	mutex_unlock(mutexp);
+	if (ret)
+		return ret;
 
-	return ret < 0 ? ret : count;
+	export_uuid(pn->uuid, &uuid);
+	return count;
 }
 
 CONFIGFS_ATTR(sys_t_policy_, uuid);
@@ -322,7 +326,7 @@ static ssize_t sys_t_write(struct stm_data *data, struct stm_output *output,
 		return sz;
 
 	/* GUID */
-	sz = stm_data_write(data, m, c, false, op->node.uuid.b, UUID_SIZE);
+	sz = stm_data_write(data, m, c, false, op->node.uuid, sizeof(op->node.uuid));
 	if (sz <= 0)
 		return sz;
 
-- 
2.30.2

