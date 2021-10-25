Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706DD438CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 03:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhJYB0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 21:26:08 -0400
Received: from mail-eopbgr1300104.outbound.protection.outlook.com ([40.107.130.104]:21725
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229668AbhJYB0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 21:26:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZPntdoFI5gc3CuCp1MAdCeMOsNiPbmJGgHFAwMwl6Huu9BLONzvJd11gXuCrAtrhi9vealD6vFBvxv1TqgluWJ6HftKjxXljAAXfnW9xSUymuOQ9gHy6zUkiO5BuE392Vf3V8v1RBeFnYvPpFt7Gh2jTZ5R0XydOx4JCpTZy/rNzkxelkS+vuGZutv3QQLnsYN1mR/m6k0SduqrevS7CDSQnBTVX5C7V7XQGWDydt7M6vgY/OjNhg6VJj2LCZsX2KX7dOVhSYZ3QjJd9GhqVnhEVo7/XeJKxtOwmFLh4YtgVh43LAVuHhYmANzyBtvig7HVzBQkshKRxC1TuBtMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AI4/PMnlEd+XRtNaGHp3+o338r2HdGSOXEpwWCY08U=;
 b=bwSPhCluaS84IU80a7LtjA4EV5RM7wBXTLaluXVvWmnTtqAnUe2+5g5/HLdZfL4HBiGxTxa46SxJSfeFwB5AfU9QC8lh3soUt7R+Uvf2cN3aEnwgxyUpirZRgFRF7lb8FUYOyj1ACSTlu9WQP7S0DuhzzACNj+BonEFPkLbE0gKMMrmrPFCm+FWM0jccQFrpnxlVded7TUC5uGJqQGoZxoMMDAR/2tuhYULiabUd4KwXS7mpAcYlWYsTYN8KcDs6lXuE54C2vp1T3Sshi+z30V8dqR8OjFJEv6BVMIC9sW7DzV3DN8LgS0bvox5cNh6+alNvVS3qWF8VUoqVpGpM0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AI4/PMnlEd+XRtNaGHp3+o338r2HdGSOXEpwWCY08U=;
 b=O5YJmpEY9YhoXJGzx8hRvlMy1Sn0w9WW0Cf7E+lPF/9E5QZwnujfqyF4Ds/524hMvoGbNkYZvyCGJIYm0aTOOfu9LoI+r8eQXv0ILc137B/Y4gvp8XeuaV1SafrSbs3LfXOGyO6Ny5IGVZR6+AchvviIXld4y+9Z6q3wrTXWZgk=
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3725.apcprd06.prod.outlook.com (2603:1096:4:d6::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Mon, 25 Oct 2021 01:23:39 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 01:23:38 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] ipmi: simplify duplicated if condition
Date:   Sun, 24 Oct 2021 21:22:06 -0400
Message-Id: <20211025012206.21189-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:d0::16) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by HKAPR04CA0006.apcprd04.prod.outlook.com (2603:1096:203:d0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 01:23:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02aaa601-ec2b-44b8-3e57-08d99756123e
X-MS-TrafficTypeDiagnostic: SG2PR06MB3725:
X-Microsoft-Antispam-PRVS: <SG2PR06MB3725CA1AC6E901E2F85C1C0AAB839@SG2PR06MB3725.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHJrRT8qIBTW13ox+SPzQsPzF0610pKMg38WvfIKxaOAT+LorYNvKnr4Zgc3885+fztHAW+uEApEJ/tHWFsN9ZLwrwx3lHAueh/EI1F5QfM9hPtb77kbWs2cg889Zm7j5zflduFe6SwZZkk+iWbgo33Z4Nhfr3FVzS295VNJ5D4x7/iQOB19t/UIRiGUiVOxtQuwUkqj9WTLVs7ESbaxlo/WzjYT/epB9g8pzGmYiE0y+XbxsQ5hVqf9QFlq4wXYlRGg6GeZaDzcXp71QwyNiXj0ZqbEZwta377TW5mP/Y12KRGt2lOBWpL8tzKWmd9M2aMKAFatkjZ2zQvYQh8E+gbGUqItVfs676q3ojapsqjs1jsowfBlXWx7M7VT/90UFgog4U7f86TrLXtGZo9fSnnTW+f0kfjgV9C24I8I3Oled4T+vhLY5OJhZn1K/cfrUmdaEYwgvESRJVNXJFk4J4byQqI/LOHN7W3mbUqv1JmgZ9q0ZpRzmlj4kogadCCuL5Tj9JheEp0koQa/DvvaDYhti5V/3skhwsu0IdWK9YdwVTEMdpkUDL8CCCZqFap/GUhqQv4czSjrbbFSUhSPAJ+/FWh5iX4KthsBE6Vopb+N/FWhSQ7v+T+w/QR7w8qa/hsAEup4yFpc8sBbnZN2gsZ/j3AUAIrKWz6TFl45e1bB4rEtW58NaPcX6unKjCXO2QNXDN0P2oHQIGBRYV4Dww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66946007)(66476007)(1076003)(5660300002)(2906002)(6486002)(508600001)(86362001)(107886003)(6512007)(26005)(38350700002)(36756003)(6506007)(38100700002)(2616005)(956004)(52116002)(8676002)(8936002)(186003)(4326008)(6666004)(83380400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kaNoTLZaQ2VY5Vy2P2WFaPH6JsvO1RuWFLBSMaNCCWjJ0o4HyIlYpvTTNWVx?=
 =?us-ascii?Q?Dn/ZSuG4n3EyiwTDIq27wjuqD4vyeEXzVd5c77ZT4lJhMiZYOUSzblgxyYSA?=
 =?us-ascii?Q?estYR23EnRzY6LYjqE4f7OkHR9F0HNsHFMrc/86NxgXa44i4a1nM+sdw+i+Z?=
 =?us-ascii?Q?KbRm2+HUxbZol1A7dmfDu/xeZkM8TJO7q1abWsjcDHU+Y1SvMQX4oYqwNAEo?=
 =?us-ascii?Q?lDX39Tip5QAHbhq8w6Xnq3Gqqg/TP0sjuflanNVR3HU7CCpHZ0KRlaKY1XXt?=
 =?us-ascii?Q?KvlqxZ9ZWv1vpxSQ4XevPbsi/e+j+XbvGO622HcIFN5MrXIv5F0E3fiNpkvn?=
 =?us-ascii?Q?UuKwLaHY1GycLuOr5SPj6lppaYxgEHxN605FU5v2TYkhCKIxwZRMn6MZgGWM?=
 =?us-ascii?Q?UOpTiTgj9Fdbeppd3kuktYbbZBdmzkYdXxY0u8XNn6eEGYIwhkms9E0gcXe9?=
 =?us-ascii?Q?nOYr21rfrED8KjZ8zbwk/AbCFgJpYF2g4KGK7JOUOORaY1wqgLwKRpDOpecF?=
 =?us-ascii?Q?sFp4NocC/mWfYeOEnUQnM1lVaGfcCnqyJXdB/l6yJZ3r7VoK4sWQCx8MqTLk?=
 =?us-ascii?Q?A9soCVWejTRu7FB9tjEyon7ov3V50YyOrrpmLkD/HsuuYM3PQXkdtrLAOQQg?=
 =?us-ascii?Q?5jMwbyRFBYVF0zi779KbaxMn36N41eK82WhfBiEw2VIFQsknJK01M3kLzf/a?=
 =?us-ascii?Q?ZmsVhGicD+rnlNJLyL84GwmN74F9LDT2sg2FM24oY1EBBEpXo5FUB8BTOFfh?=
 =?us-ascii?Q?wVaYOhLZkYN244k5Os4qqOhlsRV3kQH9hOqIFUvU8iiSdXLA2pRCF54DAVpw?=
 =?us-ascii?Q?4osZbTboFWGLx9MFoZLe8boRH9nBTx8OckDTC+OdPL0ggUHKlgtnh++IRC7M?=
 =?us-ascii?Q?V6KgyZM1v2WmhOb/r1WXFYX2PL8+o/8ObiuG+SiwngWn+z5ZkojbgVCTzDII?=
 =?us-ascii?Q?wEh0WvakprUYG1y1jd0DekP60t7dQRaxF2SJxPixELpCaXQNk1kZ7b66NN2F?=
 =?us-ascii?Q?prk0tS462SBaC+MgrEdegTkM7EK4RjKOGsurtJ2tphtvnDNn7Zs8Wndx+YjT?=
 =?us-ascii?Q?d/qH1qMDA9EQjFZvmIxhk/VGS7RBHUuBOOMRjKZd3M2VIw2QQgSa6ChR7fQ2?=
 =?us-ascii?Q?RyRZIb8TzkTTAozfdkw283qqwxtNQi8jG2cQWQhjo5p6IfE7zpS/HnkcyWzJ?=
 =?us-ascii?Q?wYZ9KhMtGsmLscDVQbbShcjyHt4OzIkSygg9TLLRyjPqS6oHFA8KrT1M4BLj?=
 =?us-ascii?Q?HsnxEjm6KkP0KMc4BPyKojyk8iIA49DhC8JI8DdWRM4QMeZNSGu+mywNDUdS?=
 =?us-ascii?Q?7yJeRdQxwD/2kGeLhORE2HS4ndQCOeKdhX9NrLUtQuC7AbzI11GM1RP4gPsd?=
 =?us-ascii?Q?KpyjBiHsazuuquIMhsLm8Kwu6yrf5TauySvIC6teHp14dECedZ+Aq/b9DSn9?=
 =?us-ascii?Q?IDUypYge/EHQbnQCyMhg9vheKj1hEJe5h03skLS8n34TaHeVUNZ3mzit+lnK?=
 =?us-ascii?Q?ozbSkb+J/7p/H/MJIr43lp6cwu8Lb/4C6+AUP+G92pBaykmSG9DnYgy9P9Zd?=
 =?us-ascii?Q?CHBsBPv0rstQYqIVxqN9t7ry6rqBRExXXgBMjtlgN/UeI6MbFjZ4Oue5hyP5?=
 =?us-ascii?Q?ZKcWRzoXnjLqUl6GZcGZUYU=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02aaa601-ec2b-44b8-3e57-08d99756123e
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 01:23:38.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vPPzMqw6KdX3bJbLKOYk6+6HjIwOm3XBBaScSDIB2u9iDROOGQ432LNcio2YkLisF5Nkg4Mw+Y5ZWYK0QHriw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3725
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 5 duplicated 'if' conditions to judge the 'run_to_completion',
which looks redundant. And there is no function to modify this variable.

Reduce the 'if' conditions from 5 times to 1 time can make code easy to
understand and fix following coccicheck warning:

./drivers/char/ipmi/ipmi_msghandler.c :4771:2-19: ERROR: nested
lock+irqsave that reuses flags from line 4764.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 38 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index a60201d3f735..072da25124cf 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4756,32 +4756,30 @@ void ipmi_smi_msg_received(struct ipmi_smi *intf,
 	unsigned long flags = 0; /* keep us warning-free. */
 	int run_to_completion = intf->run_to_completion;
 
-	/*
-	 * To preserve message order, we keep a queue and deliver from
-	 * a tasklet.
-	 */
-	if (!run_to_completion)
+	if (!run_to_completion) {
+		/*
+		 * To preserve message order, we keep a queue and deliver from
+		 * a tasklet.
+		 */
 		spin_lock_irqsave(&intf->waiting_rcv_msgs_lock, flags);
-	list_add_tail(&msg->link, &intf->waiting_rcv_msgs);
-	if (!run_to_completion)
+		list_add_tail(&msg->link, &intf->waiting_rcv_msgs);
 		spin_unlock_irqrestore(&intf->waiting_rcv_msgs_lock,
 				       flags);
-
-	if (!run_to_completion)
 		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
-	/*
-	 * We can get an asynchronous event or receive message in addition
-	 * to commands we send.
-	 */
-	if (msg == intf->curr_msg)
-		intf->curr_msg = NULL;
-	if (!run_to_completion)
+		/*
+		 * We can get an asynchronous event or receive message in addition
+		 * to commands we send.
+		 */
+		if (msg == intf->curr_msg)
+			intf->curr_msg = NULL;
 		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
-
-	if (run_to_completion)
-		smi_recv_tasklet(&intf->recv_tasklet);
-	else
 		tasklet_schedule(&intf->recv_tasklet);
+	} else {
+		list_add_tail(&msg->link, &intf->waiting_rcv_msgs);
+		if (msg == intf->curr_msg)
+			intf->curr_msg = NULL;
+		smi_recv_tasklet(&intf->recv_tasklet);
+	}
 }
 EXPORT_SYMBOL(ipmi_smi_msg_received);
 
-- 
2.20.1

