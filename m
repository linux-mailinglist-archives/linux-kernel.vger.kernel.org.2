Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFCE31864B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 09:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhBKIZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 03:25:39 -0500
Received: from mail-co1nam11on2062.outbound.protection.outlook.com ([40.107.220.62]:26848
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229679AbhBKIYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 03:24:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRwqFP5z4Wj4mgnABTPNdZ79LYcjlgVfByYUc7ZYgG8G6rIqsIcjVcrjxmm6IqhWIADV0BRrt18uK9jSrVb23m4FfFj8zeXonxzWCADzggcM2frLkkt5hXA2oWTFq35qFqo9zjnV7D3N0zbmeWgyNMI1Ku5aEkdOeGbpi8zeqjrMhNFYNukvDr6NacOT7ZD74IYj4SvjqUoEa+Bto1Vajpa608h1VFy1lpfWFxEPatc+i8QIrWEofm6YeC7IrHoOInR8At0hg1ZqpVjcZ8ita0cFg3HnnqUeLWQCycCNvdncpU8PXzOQ1aN79GKO4gVukzG7nJAQIFA2S+d/rmSmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrEGsnh/Kx3kpihV3zHjmvx/0tB+yInI5DORp4OC9Uw=;
 b=nCkHl0L+7S/fOBPCov4dGfDtB5RZEnXtQ6CObElnEQHgLYhIRfigLSU+/1JGcF2G2UiynogOADy+IGkFjJSNjzr4D+Z25r8WpXyKcI+wv7OPejsEwogoqmyyNwhAp2lJe6MgbQV4Jwxz9Tla7Rv47/AQA/636haGU6AUZxK3ECqrRgemV1QgfUOidGByK2goAdc0K+PvLgUA6a3GnvqeK3rQ6umuAc2HCj6znUjWoHMod0I8Uh1pe0H4vCsQhBqH8tKMRtLoUPczywwlVBxtCKc3hhBO7rXHCna0s//bOChvt3TJVgPYDsVhu22PYlJiOuMCFDh5/8PwbBEzJEv+fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrEGsnh/Kx3kpihV3zHjmvx/0tB+yInI5DORp4OC9Uw=;
 b=lx6AaO+v/lr7B5/dgrF8mFGueUoD/lwLrwHCKxjLaljk4sCS8T+7xGgv91pQF3+1f4PkJIYkzcGMhqEsE44zDDthvqME891EptMqm3OUGmXWy4E4NkjZi5g6onxi7aJgFkaQpTLZcH+bCkDPHjjBYHPZc/Z+x/V5cazFCsrQKL0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3110.namprd11.prod.outlook.com (2603:10b6:a03:8a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27; Thu, 11 Feb
 2021 08:24:05 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.026; Thu, 11 Feb 2021
 08:24:05 +0000
From:   qiang.zhang@windriver.com
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: Move the position of debug_work_activate() in __queue_work()
Date:   Thu, 11 Feb 2021 16:23:51 +0800
Message-Id: <20210211082351.178536-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2409:8a02:b422:31c0:98c4:8a81:334d:be19]
X-ClientProxiedBy: HK2P15301CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::16) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-l1.corp.ad.wrs.com (2409:8a02:b422:31c0:98c4:8a81:334d:be19) by HK2P15301CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.0 via Frontend Transport; Thu, 11 Feb 2021 08:24:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b339816-14be-469f-c87e-08d8ce666511
X-MS-TrafficTypeDiagnostic: BYAPR11MB3110:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3110949CE86C14CE1563677DFF8C9@BYAPR11MB3110.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaElr8SwgRzKILhHY6Uz2wXWFX4ZUIZrhBTyjSu+5m43wnsyRkDV/B5VeaSgvuZR706/jsmuiZDE1LzInXtLFFN2rywFaFdCxO1YzcJBtROR2W7zOo6H95LCbTAYhyWk+1NGBZ5Vxeg1srBgQwaLBxmN26Ws9/KBgq5/Mwx2gx8MdjhNwROtJQYsI9b5R4dUmw5PIF3lo7kPCgKEH2EFbjHf/q8IltSnmUw7buXdc8ktHEGIZWnnSdmXibd2JRZbVXDMSignwPZd6ggUPH6F5w9iyl5B4aijcG/RFbIWr7526VH5ZpQXFbNWwXvUmpf3Yh8xmMZTcYXz9IRi5Of2ehq+J3bzLQdx5nTtdUZsWHE2YGbAPOElXY3xCcT6Wf744CyNlMOVLIGwbrvBiyBGF8bTjLxMJ4OawV5mGCnK3ncwr+63E8Van+5nOPULTDijeZgIQjI0/WBFya+sWIB86HitqDSfNQhtZkhFf5+A7wuX2Wrs7/Cb3zGiidgTY1kBjvOyJrYBLt/SdS8KdWD7cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39850400004)(136003)(346002)(376002)(6486002)(2616005)(478600001)(8936002)(16526019)(186003)(5660300002)(66946007)(8676002)(316002)(1076003)(83380400001)(6666004)(9686003)(6506007)(36756003)(6512007)(86362001)(66476007)(66556008)(4744005)(52116002)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ot6X0VhfIOaCV84N7LajsTQ/Tq7/jFlrypBL7SbGYQOizLwMu/PwP+wJ/geB?=
 =?us-ascii?Q?hSjSxyAgCX8kiwKZQtmxUl8Q3slPq41++8mugJQNdyUgUEwfWWq0QmlSgRzy?=
 =?us-ascii?Q?erVjVSvyCQ2kbb5/VeNeOFIazo1OohcG7AAWL5H3b4e9842P0PHSq3ZNsz36?=
 =?us-ascii?Q?xNyG1iVsyv01dSu4e8eSyjYusrF74JJaPtxefeLKpcnF0nN9nps20VGIyHBt?=
 =?us-ascii?Q?9ure0POvBgUHzBVd6D0+penXeob2Jc9zWFzdqGReC46hJTxpkiOrkJk2CRFV?=
 =?us-ascii?Q?l0/xCC1yoboHJsq4ArTFZPW6lzNMAQVcgoboSsV037HaXatsWiDLWtwy7G6e?=
 =?us-ascii?Q?VyWMb4U13Hh0ZnBNgyN3hAMWIreZPC0wMNIL1hNunhP4vMgv93R/DyXyeo6X?=
 =?us-ascii?Q?aCe6ieiJE9HZaGEX6xT/WEAgNlOJEw3LY0WPIX41Q4POh+MdMNl1XP0HM0Dt?=
 =?us-ascii?Q?1WZ4kcyGrKeL/WsRJkyCmDnRuNiwFKIeE9LZGwgYTPnuvtsOv2AsoEroZrIe?=
 =?us-ascii?Q?/EYSHuBH/5VnnBtye6AdsXpApniCotmjWxb7QsPMg/9+kCG7XEsoKtzvm79G?=
 =?us-ascii?Q?OMOdd89+6iDtWYNaltH4NH4Ug+U+ZkhQ97qzRisVgxut7dtHWADPJ3eHs9Py?=
 =?us-ascii?Q?Jh+h8afMMVMD1X2a6mh+k/DTBB7OUBcliLkMVa2II4kqtPfoHyjmCCg3BOHq?=
 =?us-ascii?Q?C+yvW/azfAkgRpv/gtbchN6Nzu1qzNOEunk54bRpHlKMjP+bDcUaGalgG4w3?=
 =?us-ascii?Q?fxaGn5Lv8SSlSi+MY2jLLfho9MH5PB1iiLO3sRXOJrUa48jZxuAcAWj3xPwD?=
 =?us-ascii?Q?MF70r6tAe8GYqsKd2ZeKET0V0N6ff7DKn+71pNJiiGrLxLqBC9NfZ1TtyiJs?=
 =?us-ascii?Q?SWH95rrMADR38qXH23EB2t8MQQ3EQ3vj8E4oBkHbpiO/CyvNjlixLZNgCXbT?=
 =?us-ascii?Q?zYBLSVhQAblcr11LQHZlK4LAWxqUaYwczenC1x7xpG4yt+XsTIcP1enqBG+m?=
 =?us-ascii?Q?By7lZCSx02Fm+s2pX+DlTSy5H69k2yTJ4+DP7jAGS2+I9F2gxB83hlTeiQ9o?=
 =?us-ascii?Q?mmUk315USQvRFYTnYcTo8l0X6vUFSlBqVULHn9opl5zHoW8pp0n1Ep1FtSGk?=
 =?us-ascii?Q?SzTGisgQax6mOo4vIDOwEcHZ+IdJygzLj5lTZqFyq/QzkqXSx/oKcaehnW2w?=
 =?us-ascii?Q?NGiE3hC+rYNdHLFYgDXdqhzSqzsqZUsXdhib5rsMf6kkDYPIdbhQ1RvHEfQK?=
 =?us-ascii?Q?basxEG6oenVVgyRbxzVcOX4WArD3LQLmze4Src15BbiP+QHsGvTJCKRHOpGw?=
 =?us-ascii?Q?k7rq8aZ47/Rf34Z2ErOeJfwDhgNiiBt8winsZYYuv7TdHL3BxLxvkt9x7rdp?=
 =?us-ascii?Q?x+8/GAnF+JQtBH3QFE+06JYdSavV?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b339816-14be-469f-c87e-08d8ce666511
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 08:24:05.4403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDU/WgiXB3rxdM7688t+TarQL/TC4bAbotV9Pkz1BrlMqFmNiza4DV35xeiHlE+7024V5q+ciPrdmnwIvNhl+CHPJmO2e/B6spZ44MWAXps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

The debug_work_activate() is called on the premise that
the work can be inserted, because if wq be in WQ_DRAINING
status, insert work may be failed.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0d150da252e8..21fb00b52def 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1412,7 +1412,6 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	 */
 	lockdep_assert_irqs_disabled();
 
-	debug_work_activate(work);
 
 	/* if draining, only works from the same workqueue are allowed */
 	if (unlikely(wq->flags & __WQ_DRAINING) &&
@@ -1494,6 +1493,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 		worklist = &pwq->delayed_works;
 	}
 
+	debug_work_activate(work);
 	insert_work(pwq, work, worklist, work_flags);
 
 out:
-- 
2.25.1

