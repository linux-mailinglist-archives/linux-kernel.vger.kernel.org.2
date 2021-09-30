Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8578E41D81E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350170AbhI3KyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:54:23 -0400
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:47969
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350161AbhI3KyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:54:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLPUReZeIFgVld4zUFLcPzQkSmc9C5uhQZmDUm4TMx954zKy0ED6D9tQpn3gvttGW3Uv75DMIwEsjuXA/r1ltqwM3GDffKPTw3XUS114zzZub9b1bNK1U5QiUNUDsvlbv4LFxh8OPNJ3idlH4f+LE7WEY4a/cGrh+y4XIL8dCVdE38+B55/yt4SapZDt5DZiDeLdTt30YeFCeNfXc0wdZqrSDhDh1SPuGI32DFozPjOANW0aPsMbDK3c6U8TyHc2Rv/ZL3tSH2UW3+twbsPVjVK8DTKtemR+v315egKfi9nPqBuU6OsAEYQUHC6lYMmKJ+YCRqxdEOzw+g2RGtK5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Bw9As1pVhFEH4N2f+7EK1Tt1kfDGkCb/nth9qS+zFH8=;
 b=iaJ7sO6AgI4p8KDiBjidiDHlh3TIo5lvZgtp07zfujJ2UbmYkB5GkxfO1vdWY8uXFXrIcdgzI6Icld4nk/8L+kZxI70e7R8t9FvHGNfdzwBM1GQo0FN6RWqchEoiVSTCDAzHDmVpWWOjh0kK6lHEi6m2r9EFZ3sIhYlim6z4mcyxZ5EoaPeW0R1G+kFPEvFj3/y8r6vyYnui/ilp0NCfvqc2L8iFjO6ahKmydbRcaGziA1EoxONilBc2r3vZh7ndZZ8CNuX7Rxr0PeB6Xl/Gdw99zbRH5ZDETn4am8lbfqAG2XekQ3g91iPLK0GJpsRjwnfPDxtwIZl8izQ3/VG98A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bw9As1pVhFEH4N2f+7EK1Tt1kfDGkCb/nth9qS+zFH8=;
 b=WHloOcpzJXui6h1SjkxKHyHKLbAN5+SYliijSp4FULI0rgz/bm8gQvHzmLs3Zc+GMoWTA+oAiGMr0Hlhifqe+0fXroL+PoWVLqYPLnnuBF1ie6WhLbeRSHz5ofgAvbn+B8A0yR7tvaLqqLsiAbBw0t5/Yjf75qcOtRPOaThOq6A=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN3PR03MB2195.namprd03.prod.outlook.com (2a01:111:e400:7bb9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 10:52:38 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::19a1:1a10:ff3b:be65]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::19a1:1a10:ff3b:be65%7]) with mapi id 15.20.4544.021; Thu, 30 Sep 2021
 10:52:38 +0000
Date:   Thu, 30 Sep 2021 18:52:29 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] x86/process: directly use try_get_task_stack()
 return value in get_wchan
Message-ID: <20210930185229.09d463ab@xhacker.debian>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::17) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
Received: from xhacker.debian (192.147.44.204) by BYAPR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:c0::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.8 via Frontend Transport; Thu, 30 Sep 2021 10:52:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4ef40d9-79d6-47a9-5750-08d984006adf
X-MS-TrafficTypeDiagnostic: BN3PR03MB2195:
X-Microsoft-Antispam-PRVS: <BN3PR03MB219530639B4F12B587FDDF21EDAA9@BN3PR03MB2195.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V3t4MroGzKjcJz93HRAxZEnImDOXR11iNvdKb+Ou3qEVan7FX/U2v//u6kZFGfH1GKBGgmJwuhXN1lc6XBM4rw91/py/Eq5+r6EgL0jSmuFeJComkibect7yz70G91F/eF1mWdl6dI88qH67RYGIWq7djhNCBd+jRShV1TBi0yM2wApG/Gs3oKCF6pHzHujbQ9qgeTPhiTqrY3exs4RW6D5ylM9HSV1XLezL5c8n3MRk2kiReH0QVBqYjklEHkKbMMxLQY+8XDx37wpt/54XsnoTg3FPypnT+tUOC6+SXjHEqthxg/UBf+tOTcGC58DajT4R4ocGP24I/oI7eTAwf0zY9nML4VZsAYVitRkm/9MKPQNsv8ZoSpAY4AzfFVTj3MlQFXNRN/+TJKIS+vZU/SScK6AnGNIxGy9qNaKQNjqiKjWBoTruadroW9DSFuZDHqQkshX4hI8sFu1Wzzux6QeF/VuDJ7qsSPHAP7HmZ3BJBnbMgAD7gdsYAe1jkS7MwenQzEpaNVgmNVI0iom6nk/6m4E6CiagIB1FZR6doiq7hH9uBaiAxqVgua9zRyC2yI2UOhe+tr09p8nO4jB4KUfjXX8fV4MsQqGnw962xVdbrji1f0n0N2fY25908PJUc2WU8KF/taPxk/+jo9+bQzPGcsK0LTZ1od5fDt06NYdSYPLaWjFXy8D43nPJ/KFEdSoLlOOpAXlqvfW50B1L1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(38350700002)(1076003)(8936002)(4744005)(6506007)(7696005)(52116002)(8676002)(110136005)(6666004)(508600001)(316002)(83380400001)(38100700002)(86362001)(66946007)(2906002)(26005)(9686003)(66476007)(4326008)(66556008)(55016002)(186003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tI+oFHzYkuKktvTMY1bCidK5WVXLl/1C/7NGErYr870XLnbqKc2Ji7Bpnuam?=
 =?us-ascii?Q?6riYvS9sz1l2TBGk5BoLUzfEVCTBiyXsvkLSD61g8CQgoaI5VzsRUJ9pvURK?=
 =?us-ascii?Q?XD0G6qvXtfP5wYnO9dVAPpUStir4jREj4OOUbwhz7ORTpgtRHul2fZD0Rxhf?=
 =?us-ascii?Q?rJ6GmjUspowloxfgiNU7sYGO9YTqyT5F3+REDtqg7U9mE2p3KieKNTq5Njva?=
 =?us-ascii?Q?zs+Y1U4l/YNIgZm9mhPiRfesqwaV3R7SjpisEyHmk6GMhgWGyTzDaj16lpZw?=
 =?us-ascii?Q?vU2BQPe2lqdoimZmvFdzW3WVb+SGk3P+CjUOvOYqC6C3zrKAc3EgHOluFtJ1?=
 =?us-ascii?Q?SYIi66F3L2/kteS1qnfsPIJwkCGVnRORHp1JVnGX6U7Sntgi6p5CfptLGgR5?=
 =?us-ascii?Q?r+NotOhDLYBnbA/V2W42JP0/HDo4V9JDymSojqnSP9MsVEH1scZ3c3/cPgD4?=
 =?us-ascii?Q?u6PehF08gjIK0sal0CUVKPKULMtzYxIuo3PjFZAuA4i0GVM9FxiWVOMrwHaV?=
 =?us-ascii?Q?dSmbBipWHzqtmO1RUI0KbJBY782tHzANux84Pcl92qH04z3lemfRcgrhxHpL?=
 =?us-ascii?Q?6h4o+i9ovQG5L7zs5N9nTS6PmFCJ2TYj8Le4qCFJR7WXgpV0tkmjLkcaULpv?=
 =?us-ascii?Q?cYfscF/vJKfHror+r9AN2C0BCjCB7g18NJ+cRPMNec/2ww9BlMQwhD89wTf1?=
 =?us-ascii?Q?tKzIrQijuq7unnmOeUwP4HWUx+hMDT8rBguAZ5weveupkTe4yOJVz+sBIbrc?=
 =?us-ascii?Q?HY71I9zJh6kZsVGLWJXIkG+1yLorVJzN8L+3wvE2T8pLRAl9uAaXk4ylMN76?=
 =?us-ascii?Q?3QIYSqpgnf+hnRHbSJRpixe95TJJs47nJ9+eCJPUTL5mHgsSRxkhIv12HhGF?=
 =?us-ascii?Q?dQOx3Npyx0dZiPj5eEnNTx3U616rCN6DV4cgSLmbB1hAQ3qhnGGYvDGFeLfX?=
 =?us-ascii?Q?2EzlUU6cxLMgermwBvzaK1eTGpXxdVuGoNQ424OKIP0vybSF89AcgxLeAe8y?=
 =?us-ascii?Q?5HTPwHRinS3fxYCNBrWvX8m57cw+QO/peTic2tk61/58T+s1DUefxXiLR1aY?=
 =?us-ascii?Q?bNptR/KHuqVo8t87RUfPC+4DTRYU9mkeTi5MXpYwI0GNmDpd4BojcRAbH4R0?=
 =?us-ascii?Q?yPpo25RAKV8ihe3qHQ4OuD6XK1ASRH+W15RwGsg4t2GPxJawH9L0Czpnkizx?=
 =?us-ascii?Q?sciERRAZov1v9LBKDw72KUapsNEi9hgt+7PVov6ClC9J1nvMv1IdO0ABu3L9?=
 =?us-ascii?Q?sK65lx7lfvTNrJAYX0XVKLR5WjFRJ9RMnf3uPvwGLCI/sa3qGNfXpaWSAMu8?=
 =?us-ascii?Q?8oyvQOwmi8wilGfms4OlbJ2M?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ef40d9-79d6-47a9-5750-08d984006adf
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 10:52:37.8479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3joCC2qPARdWUKCxeW66rl5eNVFPsK0nyU2db6dcxitl6xcKQL0L8w5tEgsDOc3ic5HHnWv53LjalbJDA5k0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2195
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

try_get_task_stack() has already properly gets target task's stack,
no need to call task_stack_page() again.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/x86/kernel/process.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e3096b..d4a6503b3878 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -950,12 +950,9 @@ unsigned long get_wchan(struct task_struct *p)
 	if (p == current || task_is_running(p))
 		return 0;
 
-	if (!try_get_task_stack(p))
-		return 0;
-
-	start = (unsigned long)task_stack_page(p);
+	start = (unsigned long)try_get_task_stack(p);
 	if (!start)
-		goto out;
+		return 0;
 
 	/*
 	 * Layout of the stack page:
-- 
2.32.0

