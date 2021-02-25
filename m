Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CEF325706
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbhBYTqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:46:34 -0500
Received: from foss.arm.com ([217.140.110.172]:48426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234864AbhBYTje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:39:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E6351474;
        Thu, 25 Feb 2021 11:36:15 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C2F83F70D;
        Thu, 25 Feb 2021 11:36:14 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 11/19] coresight: Do not scan for graph if none is present
Date:   Thu, 25 Feb 2021 19:35:35 +0000
Message-Id: <20210225193543.2920532-12-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210225193543.2920532-1-suzuki.poulose@arm.com>
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a graph node is not found for a given node, of_get_next_endpoint()
will emit the following error message :

 OF: graph: no port node found in /<node_name>

If the given component doesn't have any explicit connections (e.g,
ETE) we could simply ignore the graph parsing. As for any legacy
component where this is mandatory, the device will not be usable
as before this patch. Updating the DT bindings to Yaml and enabling
the schema checks can detect such issues with the DT.

Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-platform.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 3629b7885aca..c594f45319fc 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -90,6 +90,12 @@ static void of_coresight_get_ports_legacy(const struct device_node *node,
 	struct of_endpoint endpoint;
 	int in = 0, out = 0;
 
+	/*
+	 * Avoid warnings in of_graph_get_next_endpoint()
+	 * if the device doesn't have any graph connections
+	 */
+	if (!of_graph_is_present(node))
+		return;
 	do {
 		ep = of_graph_get_next_endpoint(node, ep);
 		if (!ep)
-- 
2.24.1

