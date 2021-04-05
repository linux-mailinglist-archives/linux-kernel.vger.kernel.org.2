Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC4D35457F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 18:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242606AbhDEQnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 12:43:55 -0400
Received: from foss.arm.com ([217.140.110.172]:56010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242557AbhDEQnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:43:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A78351042;
        Mon,  5 Apr 2021 09:43:45 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 071623F694;
        Mon,  5 Apr 2021 09:43:43 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     maz@kernel.org, mathieu.poirier@linaro.org
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        mike.leach@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, leo.yan@linaro.org, robh@kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v6 10/20] coresight: Do not scan for graph if none is present
Date:   Mon,  5 Apr 2021 17:42:57 +0100
Message-Id: <20210405164307.1720226-11-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210405164307.1720226-1-suzuki.poulose@arm.com>
References: <20210405164307.1720226-1-suzuki.poulose@arm.com>
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

