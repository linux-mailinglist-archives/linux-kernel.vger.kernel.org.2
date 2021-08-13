Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B85A3EAE32
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 03:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbhHMBjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 21:39:35 -0400
Received: from mail-eopbgr40058.outbound.protection.outlook.com ([40.107.4.58]:42985
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238130AbhHMBje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 21:39:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiV4o58qJQb49R4jnEz0wJJop1a+M3sxFC/5ZRlYL+I+Xpsz20cJMwQ16YucNSPloUGNfhbg+CI60loVmqQUXrx8kTkiGjx9E4oXfweoag6C4MCp0p32fb4Ym8NcL+TzND5aN18Bnl7OLwbNJSp3LAO9zZjRGcZrKMNaS32piXBx3pKo2Wm2KtKPLvvFdzq6gro46bJBX45gz/lTpHAXv1MqAxK3+3AIzCBg9utgUd0w7YuY3k5Nqw07sup3EdHfGrQ7D9lFX0duOJk7zNFeiwESmxVSS3SXroSFBmoXqnj4cTXN3yTDcePlgTvrX3ljQ6RLNgDGInWbiDwSwxJkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eadvbaYBejTHwngIjs9YD/kPIHidHV8Ut8CMMeRXGyM=;
 b=ZtIdd6PsQIrcbiXFLKecNQ+Ad/kdWsX7dXKBv6LyDKMLNEl12JDWAOS5J3NwYhnTDq5VStHDSXWs46KmsCz+tlRfVJcHE5P9M3vAKZ4hEVu1C+NLXyI6qm42W5AKIMtIc0CZx6dV8HNotFhzjWTZ0zZJC8WP7IuLZ89C+JPAKdLVVynO0N87xG/ggra3mlPhLr19mUs7sDJtqnvKXAi9q4NoifLI674spJNzCMcLoJsAZ38+tmVpfZyiiWMbBrU0ROwrWHkl/tb68/LRd6MQxXdXFjagVNbsVc4YfbGHrhwz5bA8guY20YaYEJoYiUU9ghqd2sU01hVrtu3qG4Ok+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eadvbaYBejTHwngIjs9YD/kPIHidHV8Ut8CMMeRXGyM=;
 b=Boz1UD2r8Sc+AVc2ADfBZyd9BmfNd28Xy2hFRYZqD9EOnx3owVcwH9bJGy/JKldiBNUgqRx0PaF4g9Gd5HRn6AzN2QyCNekcMoPZFzSxSZHApZiCAdtrFdOx2lsytTUJzT3RWMhbbjkoTYXUB6GoknFt0OHhLTeRd6TRXPpM7Sc=
Authentication-Results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=nxp.com;
Received: from AM0PR0402MB3380.eurprd04.prod.outlook.com
 (2603:10a6:208:19::32) by AM0PR04MB5666.eurprd04.prod.outlook.com
 (2603:10a6:208:128::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Fri, 13 Aug
 2021 01:39:07 +0000
Received: from AM0PR0402MB3380.eurprd04.prod.outlook.com
 ([fe80::f859:e4d4:1bdc:8e96]) by AM0PR0402MB3380.eurprd04.prod.outlook.com
 ([fe80::f859:e4d4:1bdc:8e96%3]) with mapi id 15.20.4415.017; Fri, 13 Aug 2021
 01:39:07 +0000
From:   Zhipeng Wang <zhipeng.wang_1@nxp.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: add sys node to disable unused clk
Date:   Fri, 13 Aug 2021 09:11:18 +0000
Message-Id: <20210813091118.17571-1-zhipeng.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To AM0PR0402MB3380.eurprd04.prod.outlook.com (2603:10a6:208:19::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aps001.ap.freescale.net (119.31.174.66) by SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4415.15 via Frontend Transport; Fri, 13 Aug 2021 01:39:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57d4b323-2e11-414d-dc3f-08d95dfb23ba
X-MS-TrafficTypeDiagnostic: AM0PR04MB5666:
X-Microsoft-Antispam-PRVS: <AM0PR04MB56660247136EDF309C1EC1CEEBFA9@AM0PR04MB5666.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:425;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7MHheeynZ0Rq07um3JS9bYt6eRsb4ShJxahYS/Syn5fL7JU+2I/zds8VTAmjLZHcq/a56hJbqlKifgShQFJmNyMbzJb7seroagUAJMTFSGNkkoII7kqKMaCSSWaybcYVJMe1S60MyyG5V+pxpkDY6u+RAPEPfwG8WZ28zEAcxUrDW4ghMBGkJ04NHSr7NU5YXMZ5uyN/QTcaIY4rDW2GRdxQXcGU53hVMDxQNLoqwXg9bo1BMd46lAySUrQvtbtbgxL/IacIo1at8dX5otfZJfBZp32KbM6kDwmmnxNoIok8VfZiCXD/O3Ob9lgigOr95dKYBG6nPbJSR+n/a3NvDqG44ugU4sf5KI8KOoJZVLctFRNNPLZK0XuMbcALPf/D+pyW/NRdohQ+sWNSJOP2pLgFxxz327ghVHdjUHKKorYBMeEGv1yKW/bQnwUX6t3EpelWGerKJRcM6r/xQUkvZOEq2EEUO7KkVSN07hpX1qDJ3pLJI8AxFFMqNZNRMpmnSyPQZBfyEm/EFkqDZ56gP3+OWi2AQz9sxEMhEpcrOylPRHrPFbRQHhWCXE8E0LRlKHuG1T3Wkr8wVmkfW/OOZqnSBODPIt04xYCmgvZ2Qfimrf3Gm1accBphBYHgHzlzbXifCYB8VNsFRQS7SPZmWTtTrzs7fc6b05vWhn3e+8QqVQY6eCUIg3YxmkGF/emPDTzDJpaXWfGmh3NQEATO7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3380.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(316002)(478600001)(83380400001)(5660300002)(6916009)(2616005)(4326008)(186003)(66476007)(38100700002)(38350700002)(956004)(6666004)(52116002)(66556008)(1076003)(36756003)(6506007)(8676002)(66946007)(6486002)(8936002)(6512007)(2906002)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LdGmtZl9ddj7/HOh7owJaMrZnBmeJOJBwbXyLFpSUi0YIFQWS0dTVtlyG/zq?=
 =?us-ascii?Q?G3UfgfndWZOT8k4NMAkkD2N1e7OLJWjMdfSw1BbazCRS86kAh9xmsb2Dy6nA?=
 =?us-ascii?Q?LUYr7yq/hxah0cEhHBK3HVOPKGZaCvtd8Ranm1nglIZhh6IqTThqitailDD1?=
 =?us-ascii?Q?eGLo0Xz4ilBrbWtCaaGDOuhYgz+WCtiPcJkT/ZMusPsJ7vttup57DBK/TK50?=
 =?us-ascii?Q?m0Vh31w1D4TVwl8naCH45SSMEsfcFqZEKuxm4YfDbvVJT6uVlwoVGO+VSRL1?=
 =?us-ascii?Q?V6Yx2beQZXDfpJs30qhg0EYVf5+3SmXQq93ItvBt9h/Dl3U3Ro/K0RSAh33k?=
 =?us-ascii?Q?LbnRAVSt1fN3n4UoiuhpihxxBeO+5AQToBsOE1jfF4zWpAcJljJNXgY8qcTd?=
 =?us-ascii?Q?wE6K0g2qoeMfOzptvefC5d3PqhXDXB5HO/h5ThTseS7T4jaljqLCpUVr5e2x?=
 =?us-ascii?Q?NiNiJMZtee2JM1d7zXkqm4GSUIvnfxMNnpcFMgNYC3BL8hy4f/dNWeb119KQ?=
 =?us-ascii?Q?lRD6hrsOzbN2/z4jBx+9iDt39vv6dCvxYSwu3jtRKnINzp94C3EdG63WdgA7?=
 =?us-ascii?Q?xpubVSYCe9TkVb56BAFv/zwXnUdwigVyIGdjDueMLZbPBPUGczXe7d40jRRI?=
 =?us-ascii?Q?ZGWb2y8GeR8tspB4ihrLOCBh4OtdUOM+ChsXj7LAO1c/IZ25T3w75QRVd04f?=
 =?us-ascii?Q?iuEa4QMcTtsok7iP8NsFmVxj/oB1OtP0KvzdQ8MheyQgdDxmLUyISv8XF9Xh?=
 =?us-ascii?Q?eV/EW9WGARBQHL241X9A2wZRCS+mc/T94Po6ZQJcd+md3qHINy8F2AJUMjjY?=
 =?us-ascii?Q?Bx+X9mbxXjeXtPcjgz6D47YdEixUcsY74QNd1INhj3z2/1koLkVTVDH0Oy3E?=
 =?us-ascii?Q?HSvDNMHF0ZDnpPtB8lS1qao+wph9htcHLZTcPYmrP72fA9DP0nwP7bGrxGdh?=
 =?us-ascii?Q?+ZxmQ15ohTzv5f8H90XeoOdPSRbHtsdhJop7ZLvGmsXB4UybPK8ibJjIfjm3?=
 =?us-ascii?Q?9hozMsfqiLUVB/mKbAOsR5q2ajB1xqerZjwrHKT8FDklmDToRxa2cutqCjNg?=
 =?us-ascii?Q?YxTOw9cjnv/sJbSZ6D7YILMSx+rajuFOaQnV7O0riOjmiiI9jwy7sTnrXZrp?=
 =?us-ascii?Q?fE8Booh9XErLoK9+uWE5ezd9RSK0Xt8UcKCioFrUGV6UCCSfVh4pYAsG2y0I?=
 =?us-ascii?Q?7LJ6WzSPZzvdvw0XDNHjDONLfnOrciHLWJqW3MVDp9/bQIi7H0/Z/wYDxHQO?=
 =?us-ascii?Q?Gnevl6qakB0pkEL1aJqkqzdIVYTvv7c3p10dpXimFB/F4TtC+Z0hr59HynIn?=
 =?us-ascii?Q?QUGmuXXiQKrznct1KxTU4LTj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d4b323-2e11-414d-dc3f-08d95dfb23ba
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 01:39:06.9127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByTpAAv/E3IIymtYCO78gL2k65neVP/LG5Up6ZvsvzUN5cGyGOe051mb8wHHMJZizNlEDP38Akzh4BCSy8flkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5666
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The normal sequence is that the clock provider registers clk to
the clock framework, and the clock framework manages the clock resources
of the system. Clk consumers obtain clk through the clock framework API,
enable and disable clk.

Not all clk registered through the clock provider will be used
by the clock consumer, so the clock framework has a function
late_initcall_sync(clk_disable_unused); disables the unused clk.

Now we modularize the clock provider and some consumers, which will
cause late_initcall_sync(clk_disable_unused); cannot work properly, so
increase the sys node.

Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
---
 drivers/clk/clk.c | 74 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 65508eb89ec9..2bd496c87f80 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -32,6 +32,7 @@ static struct task_struct *enable_owner;
 
 static int prepare_refcnt;
 static int enable_refcnt;
+static bool enable_clk_disable_unused;
 
 static HLIST_HEAD(clk_root_list);
 static HLIST_HEAD(clk_orphan_list);
@@ -1206,7 +1207,7 @@ static void clk_core_disable_unprepare(struct clk_core *core)
 	clk_core_unprepare_lock(core);
 }
 
-static void __init clk_unprepare_unused_subtree(struct clk_core *core)
+static void clk_unprepare_unused_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
 
@@ -1236,7 +1237,7 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
 	clk_pm_runtime_put(core);
 }
 
-static void __init clk_disable_unused_subtree(struct clk_core *core)
+static void clk_disable_unused_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
 	unsigned long flags;
@@ -1282,7 +1283,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 		clk_core_disable_unprepare(core->parent);
 }
 
-static bool clk_ignore_unused __initdata;
+static bool clk_ignore_unused;
 static int __init clk_ignore_unused_setup(char *__unused)
 {
 	clk_ignore_unused = true;
@@ -1290,7 +1291,7 @@ static int __init clk_ignore_unused_setup(char *__unused)
 }
 __setup("clk_ignore_unused", clk_ignore_unused_setup);
 
-static int __init clk_disable_unused(void)
+static int clk_disable_unused(void)
 {
 	struct clk_core *core;
 
@@ -1319,6 +1320,71 @@ static int __init clk_disable_unused(void)
 }
 late_initcall_sync(clk_disable_unused);
 
+static void clk_disable_unused_enable(bool enable)
+{
+	if (enable) {
+		clk_disable_unused();
+		enable_clk_disable_unused = true;
+		pr_info("clk_disable_unused: enabled\n");
+	} else {
+		enable_clk_disable_unused = false;
+		pr_info("clk_disable_unused: disabled\n");
+	}
+}
+
+static bool clk_disable_unused_status(void)
+{
+	return enable_clk_disable_unused;
+}
+
+static ssize_t clk_disable_unused_show(struct kobject *kobj, struct kobj_attribute *attr,
+					char *buf)
+{
+	return sprintf(buf, "%u\n", clk_disable_unused_status());
+}
+
+static ssize_t clk_disable_unused_store(struct kobject *kobj, struct kobj_attribute *attr,
+					const char *buf, size_t n)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+	if (val > 1)
+		return -EINVAL;
+
+	clk_disable_unused_enable(val);
+
+	return n;
+}
+
+static struct kobj_attribute  clk_ctrl_attr =
+	__ATTR(enable_clk_disable_unused, 0644, clk_disable_unused_show, clk_disable_unused_store);
+
+static struct attribute *clk_ctrl_attrbute[] = {
+	&clk_ctrl_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group clk_ctrl_attr_group = {
+	.attrs = clk_ctrl_attrbute,
+};
+
+static const struct attribute_group *clk_ctrl_attr_groups[] = {
+	&clk_ctrl_attr_group,
+	NULL,
+};
+
+static int __init creat_sys_clk_unused(void)
+{
+	struct kobject *clk_ctrl_kobj = kobject_create_and_add("clk_ctrl", NULL);
+
+	sysfs_create_groups(clk_ctrl_kobj, clk_ctrl_attr_groups);
+
+	return 0;
+}
+late_initcall_sync(creat_sys_clk_unused);
+
 static int clk_core_determine_round_nolock(struct clk_core *core,
 					   struct clk_rate_request *req)
 {
-- 
2.17.1

