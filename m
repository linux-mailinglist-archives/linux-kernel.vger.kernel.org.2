Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC95339B40
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 03:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhCMCb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 21:31:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34268 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCMCbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 21:31:24 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12D2ONZa018923;
        Sat, 13 Mar 2021 02:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=OzxTyp/SU6wjchjy8o2by8C+eTJubUd5LRg7PqLwx2A=;
 b=LafKc73qh2UCBUbnPfdMYf70cJlpHmnJR/v18aVCu5cpYLQjvFHboTiPDAO3ZUH/LvI1
 guW7WsPW/ApT2dlGIFgj9NKNKHaoCrxHqCROT/zZsozrnzyZfYPSUFwT6vLKjzrQ6HjQ
 ARdPi8lB9tSWokacljY5jBsqr/DicdX+RVy+wbe1mFHBtO/xx7zL4T15MiwSPtFJ9fCZ
 P9M0qkG4bIkGxR2FD0Slyj0cVQysIT/FAQawalkJ9wzOB5ClGd2/nqGj/oi7PIs9HP1T
 8rMpcZUY9FO5BiVySXSArR4ic51G2mVPGlDNzrKepmrafuRC4pkE12UQ+o6nHzS2X/fh Dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37415rkqru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Mar 2021 02:31:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12D2U74Q100353;
        Sat, 13 Mar 2021 02:31:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3030.oracle.com with ESMTP id 378keabn86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Mar 2021 02:31:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jq/iz/SkZlHoxM4TP47ILcScoW+DWkgPk1/bhHbWDKWlnuZnfF9sX4dCrVpJGwEGOsX8c3rVFihgFahQnpk33tmNfTUu66EiOPKn67JBO4eED/MF3YSJm+5wFoHnM0gJXAo8lEEjKGF+Ss/z6ggV9rpgvWtAN5Fs3LqtryY+6H1SfLDGQXX0RvZk+bhAvkfy65/74aLexaOEIPNjIxRnn09z7KyBfum1A83od2xQsfEA5CFfGAIQI0bTpT4VtHASlTl1TasxRqdJVJyLF79TNGxyuMAxj5wupfrcTy7leiANGHEIBrsTCZPE9DSZ5tmjfIGNpgqfkfZz/mE4rGSVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzxTyp/SU6wjchjy8o2by8C+eTJubUd5LRg7PqLwx2A=;
 b=h2moQAcn4n11k89snCnOWZIWO3wl8ZEJVJndttNcWvNXtCkC1C4BQLRi2NNnTEhFtxlOIIiS39ldxylmnILC0cs+etRkF255J1WvBp9LYEZ/fyKG3LlcT7BcjfDHMt79t1VTgs4M/RiOQ/bbOFcDjApeBDYunFAl0HM1n0ZbeNYc+vntPZ7fMCeuVvbthPS2Bwi153qT0AgigFSQ6ptoQwrBhMsyU3AvjU6FeDOSetciiJ8kZnDHZhgP5x050SFeihE6E9ys1cydjmZVrefGqgsVb5gdDaqffROUZcSctKhjdPlWHqvy7pK3YGSYvmO+Tk4MWa6F/a7bvU8Tr+hXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzxTyp/SU6wjchjy8o2by8C+eTJubUd5LRg7PqLwx2A=;
 b=EXbz6WbFUsUk/eGsOSGngerzugVh2lHWmwirtESx3wspvroWj8zpiAhmh9klAG8taq2KxNGvakimjaTWKHbAFyK9u980tM8R9ebhbyrWeU3jh9Yzb0go+wAe/FuAyoQhj8ehz07q8OGxzsYH08qVPSofB84bOGsFE9r8taZQmGM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by SJ0PR10MB4477.namprd10.prod.outlook.com (2603:10b6:a03:2df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Sat, 13 Mar
 2021 02:31:17 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902%7]) with mapi id 15.20.3912.031; Sat, 13 Mar 2021
 02:31:17 +0000
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Tom Saeger <tom.saeger@oracle.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, trivial@kernel.org
Subject: [PATCH] mailbox: fix various typos in comments
Date:   Fri, 12 Mar 2021 19:31:10 -0700
Message-Id: <bf837fae33814695e4dbe80e88529518061a0dd4.1615601744.git.tom.saeger@oracle.com>
X-Mailer: git-send-email 2.30.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2606:b400:8014:1041::15]
X-ClientProxiedBy: CH2PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:610:53::29) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2606:b400:8014:1041::15) by CH2PR17CA0019.namprd17.prod.outlook.com (2603:10b6:610:53::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Sat, 13 Mar 2021 02:31:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bba297ce-6bda-4b95-c60f-08d8e5c81493
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44777C315BC8C125804837D2FC6E9@SJ0PR10MB4477.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HiMWY3gdnCRAHndOL2fcRKfG0dHJLCupk9CPbfnRy5fRzxpAoWAbgOWf6vGatqRFlLnFinRBNHF+xXiBzQ51Ik56q/HutSH5hKPjWYa8wL5ze+QxpdACYlaB078KaovEZDFy9HR2aX6gjLlxOvy0y8bZx7leNADVaOI8aeZFq0cbPCod26kg4rGXy622m2hZHj9W+e5/Q69YVvPjFglWMkm8xalstqJ+Mul8Y0w2gdHcRsue7hOmpuCzuamQs6U08W/28MQS8SzhiKcNONhUHIe50OLcUjYF6sVy7PDeMRRXX1i/5ms3O99+rRwlnfVc3bBEUAcL9Rkux2JhXNCAINH2VNzNugc1/aL5DcsokqNDYAW2ZDqL9SRaclOJH5xjk4+CLGRxzhpshSSXPM57SWGwAuGWXhMdSTk0A37H0huOepg0E99jtnLqK4+nLCgbHIo2GdKmDIQbyc/LdqYMWqH4rDeSOFI0eww26+Yuu4po7h5x1nWYR5Wv/K7tm+pK/lUquWpQC3LQGGcvcJVtdSega+6t7pcvd03ORVBvEgAd3HHMtm7+I2IW1BKEDQsaCnMexZtfYDP+FYf5k1Q3orKPbD6RhLK9NqjRbWqvTByZHIX7fOwlMV0UKgx5wgXDN4p1kkZbOshOzqlD9G5K8znWydKZRtLLVpzIE1c7qOdiLd0iVffGXKYMPHL8Kvknn5CbIWJ2mPr+nUEaUuQkEeL13oHASKWjrJ/n3WbCnxMyQ+xefELQ2NoHeTk4pi6YoxvQ1PWE8CeF7pZziNgao4yBZxisHwypEWoaJwDruZQImQdC7UxvOMhx6gskqQ0PmmKPGyRDXmFYfgrLupNdsKlRidG8pRxD1AqsKQEGFSzbOlcCIhXLCueJKhh7/qTLCb61SVrHD+bBSZVVyMi9uWob9JoVxOHACWLaeCGCVlk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(346002)(136003)(39860400002)(366004)(376002)(396003)(36756003)(83380400001)(52116002)(2616005)(2906002)(86362001)(6486002)(8936002)(478600001)(15650500001)(66946007)(66476007)(16526019)(5660300002)(54906003)(8676002)(186003)(66556008)(44832011)(6496006)(6666004)(316002)(4326008)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?s2mrmdBVegP5ph/xbDTe+FiOgmC4J2fqCBCbjYY6ZIk+td8gyPkj37Go9Spk?=
 =?us-ascii?Q?zfuQNlfIyO6Kn4QrfB9oDG47KESsHkJLbBfbTfHWlFzSZlgjTtpbTTlnSxxD?=
 =?us-ascii?Q?94z7DS5uGvco+tGbAD350uuo6zVaBRqi8VwaQF5Rm6VtibXCI3DIBUTAgZ3e?=
 =?us-ascii?Q?8WCAmTmwIziwQTEGHqWHszojGlNiCWkABPyzWm5/15zpBfsmAa/r2oK163lZ?=
 =?us-ascii?Q?CtyU7xpBmggNbpBW3t+dSBwAtSk/OwUY8+vzY+uiRl2cFpzTyn3bobfIVGs5?=
 =?us-ascii?Q?b3mjk6tJD6kVcKHEjjLDIp1XAMjhdvRU1/HqTpDtA8OzpFZNp6sprk1S2mDT?=
 =?us-ascii?Q?L2qYAarpdntgWYr5rLMBrcgem2rRn2tP02hN1GaJNfHB1+32ZcckzWP/26EC?=
 =?us-ascii?Q?hfBNoqqsJW/X3fIG1GO9DgNOGP8lYgMjBuWRzhyIh5oq4a7oyNghf3XaH/p0?=
 =?us-ascii?Q?eSmWIBbc1WhEsSp112aU/dFQRGHhqeQExfNy3BrpxDK1BSZ/d4Vd0Tv7tVyq?=
 =?us-ascii?Q?rhNI/n0rP7rKml/HDWaQ3jaVNHqIRvZI0qnb1DuD6RI24VlqnzysbS8duIH4?=
 =?us-ascii?Q?3aq3htmT/yvkBkpcu282R5fM99SwfRLgqhPIiXbe0AB8/gT88VbKtagMEiJ+?=
 =?us-ascii?Q?dSBb4jNsXVaMkLK8V8o5y4wHj8rjRrgyk9j8QFg7r2ZRy1XHr6l1MluudTcw?=
 =?us-ascii?Q?WQpfiFb23r1j3B/YAzAQsFoanWT6G1WM7sYpwToVBO1n1tGKaW+BPsC/l1Cx?=
 =?us-ascii?Q?ch6XBgolclTyuUAA4wB7Bzo6qOzn+GR74XMDpjnjqJQIdi3uxZRu3MrKvr2u?=
 =?us-ascii?Q?/2cLCzYo31cwWs9uV9N8zvKQDU0zEuQuXgXg9Y5je8lRnlfrbB07gL3+dB9C?=
 =?us-ascii?Q?n4HYZU/HwrbjxC7mw6dQ6k2bRhZJDuEFz410H0TLAELvjFB6W/2qkuduKqhJ?=
 =?us-ascii?Q?L3EEp3T6v2KXYOVtV7QxP2m6z27kpu1kxNQVlPtT1xOPGqzEI5gt/sKsRPly?=
 =?us-ascii?Q?lW6pUfCBiL14u5ZXwEL8ODm3QJwFzSdmGDUQNRxnVXeQvZGHDcpLE40bcDzx?=
 =?us-ascii?Q?AkygSWIr5R4Sd5iBR4u0Z8LTx3T1xMqKgKUeXgVERngxDjpr5Ra5kjY/X1X0?=
 =?us-ascii?Q?zN8UFfbgJrUWbNR4ZD32KgTAHAoP9h3Nw3caDELNrQ0NQjp3nsxvwYS21RfK?=
 =?us-ascii?Q?Ov3lCHfxwahFi8tGNZEzwDYNbNbX04oFjTNIQ4TG7rLnAieAvVwxb+bjZvlJ?=
 =?us-ascii?Q?MIy0RSguY8IZVYvZVR5jrrQHEp9mvd2YJlbztLjdmkmyqr1nEiVczVNN6/GN?=
 =?us-ascii?Q?adx2JUXh3pE+KgI350+4+mGGIe5BkchQzlASWLJMNwr2EQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba297ce-6bda-4b95-c60f-08d8e5c81493
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2021 02:31:17.5843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0NY5GDglApu6wz0wVz7PD4m0XvCia+yU31vR/FuH9bGoIvduE2POL6MLi7p1P1oo4W9b37nRMclATJMxnfpJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4477
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103130015
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103130014
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fix trivial typos in mailbox driver comments.

s/Intergrated/Integrated/
s/extenstion/extension/
s/atleast/at least/
s/commnunication/communication/
s/assgined/assigned/
s/commnunication/communication/
s/recevied/received/
s/succeded/succeeded/
s/implmentation/implementation/
s/definiation/definition/
s/traget/target/
s/wont/won't/

Cc: trivial@kernel.org
Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
---
 drivers/mailbox/Kconfig                 |  2 +-
 drivers/mailbox/bcm-flexrm-mailbox.c    |  4 ++--
 drivers/mailbox/mailbox-xgene-slimpro.c |  6 +++---
 drivers/mailbox/mailbox.h               |  2 +-
 drivers/mailbox/pcc.c                   |  2 +-
 drivers/mailbox/pl320-ipc.c             |  2 +-
 drivers/mailbox/sprd-mailbox.c          | 12 ++++++------
 drivers/mailbox/ti-msgmgr.c             |  2 +-
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index f4abe3529acd..68de2c6af727 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -78,7 +78,7 @@ config OMAP_MBOX_KFIFO_SIZE
 	  module parameter).
 
 config ROCKCHIP_MBOX
-	bool "Rockchip Soc Intergrated Mailbox Support"
+	bool "Rockchip Soc Integrated Mailbox Support"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	help
 	  This driver provides support for inter-processor communication
diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index bee33abb5308..b4f33dc399a0 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -423,7 +423,7 @@ static void flexrm_enqueue_desc(u32 nhpos, u32 nhcnt, u32 reqid,
 	 *
 	 * In general use, number of non-HEADER descriptors can easily go
 	 * beyond 31. To tackle this situation, we have packet (or request)
-	 * extenstion bits (STARTPKT and ENDPKT) in the HEADER descriptor.
+	 * extension bits (STARTPKT and ENDPKT) in the HEADER descriptor.
 	 *
 	 * To use packet extension, the first HEADER descriptor of request
 	 * (or packet) will have STARTPKT=1 and ENDPKT=0. The intermediate
@@ -1095,7 +1095,7 @@ static int flexrm_process_completions(struct flexrm_ring *ring)
 	/*
 	 * Get current completion read and write offset
 	 *
-	 * Note: We should read completion write pointer atleast once
+	 * Note: We should read completion write pointer at least once
 	 * after we get a MSI interrupt because HW maintains internal
 	 * MSI status which will allow next MSI interrupt only after
 	 * completion write pointer is read.
diff --git a/drivers/mailbox/mailbox-xgene-slimpro.c b/drivers/mailbox/mailbox-xgene-slimpro.c
index de260799f1b9..5b3a2dcd5955 100644
--- a/drivers/mailbox/mailbox-xgene-slimpro.c
+++ b/drivers/mailbox/mailbox-xgene-slimpro.c
@@ -51,10 +51,10 @@ struct slimpro_mbox_chan {
 /**
  * X-Gene SlimPRO Mailbox controller data
  *
- * X-Gene SlimPRO Mailbox controller has 8 commnunication channels.
- * Each channel has a separate IRQ number assgined to it.
+ * X-Gene SlimPRO Mailbox controller has 8 communication channels.
+ * Each channel has a separate IRQ number assigned to it.
  *
- * @mb_ctrl:	Representation of the commnunication channel controller
+ * @mb_ctrl:	Representation of the communication channel controller
  * @mc:		Array of SlimPRO mailbox channels of the controller
  * @chans:	Array of mailbox communication channels
  *
diff --git a/drivers/mailbox/mailbox.h b/drivers/mailbox/mailbox.h
index 4e3cc4426513..046d6d258b32 100644
--- a/drivers/mailbox/mailbox.h
+++ b/drivers/mailbox/mailbox.h
@@ -5,6 +5,6 @@
 
 #define TXDONE_BY_IRQ	BIT(0) /* controller has remote RTR irq */
 #define TXDONE_BY_POLL	BIT(1) /* controller can read status of last TX */
-#define TXDONE_BY_ACK	BIT(2) /* S/W ACK recevied by Client ticks the TX */
+#define TXDONE_BY_ACK	BIT(2) /* S/W ACK received by Client ticks the TX */
 
 #endif /* __MAILBOX_H */
diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index ef9ecd1f5958..9cb1dcf47661 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -32,7 +32,7 @@
  *  * Client writes WRITE cmd in communication region cmd address.
  *  * Client issues mbox_send_message() which rings the PCC doorbell
  *		for its PCC channel.
- *  * If command completes, then writes have succeded and it can release
+ *  * If command completes, then writes have succeeded and it can release
  *		the channel lock.
  *
  *  There is a Nominal latency defined for each channel which indicates
diff --git a/drivers/mailbox/pl320-ipc.c b/drivers/mailbox/pl320-ipc.c
index 25e0b6f7a10f..fbcf07930390 100644
--- a/drivers/mailbox/pl320-ipc.c
+++ b/drivers/mailbox/pl320-ipc.c
@@ -73,7 +73,7 @@ static u32 __ipc_rcv(int mbox, u32 *data)
 	return data[1];
 }
 
-/* blocking implmentation from the A9 side, not usuable in interrupts! */
+/* blocking implementation from the A9 side, not usable in interrupts! */
 int pl320_ipc_transmit(u32 *data)
 {
 	int ret;
diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
index 4c325301a2fe..56b34a67ff1a 100644
--- a/drivers/mailbox/sprd-mailbox.c
+++ b/drivers/mailbox/sprd-mailbox.c
@@ -25,28 +25,28 @@
 #define SPRD_MBOX_LOCK		0x20
 #define SPRD_MBOX_FIFO_DEPTH	0x24
 
-/* Bit and mask definiation for inbox's SPRD_MBOX_FIFO_STS register */
+/* Bit and mask definition for inbox's SPRD_MBOX_FIFO_STS register */
 #define SPRD_INBOX_FIFO_DELIVER_MASK		GENMASK(23, 16)
 #define SPRD_INBOX_FIFO_OVERLOW_MASK		GENMASK(15, 8)
 #define SPRD_INBOX_FIFO_DELIVER_SHIFT		16
 #define SPRD_INBOX_FIFO_BUSY_MASK		GENMASK(7, 0)
 
-/* Bit and mask definiation for SPRD_MBOX_IRQ_STS register */
+/* Bit and mask definition for SPRD_MBOX_IRQ_STS register */
 #define SPRD_MBOX_IRQ_CLR			BIT(0)
 
-/* Bit and mask definiation for outbox's SPRD_MBOX_FIFO_STS register */
+/* Bit and mask definition for outbox's SPRD_MBOX_FIFO_STS register */
 #define SPRD_OUTBOX_FIFO_FULL			BIT(2)
 #define SPRD_OUTBOX_FIFO_WR_SHIFT		16
 #define SPRD_OUTBOX_FIFO_RD_SHIFT		24
 #define SPRD_OUTBOX_FIFO_POS_MASK		GENMASK(7, 0)
 
-/* Bit and mask definiation for inbox's SPRD_MBOX_IRQ_MSK register */
+/* Bit and mask definition for inbox's SPRD_MBOX_IRQ_MSK register */
 #define SPRD_INBOX_FIFO_BLOCK_IRQ		BIT(0)
 #define SPRD_INBOX_FIFO_OVERFLOW_IRQ		BIT(1)
 #define SPRD_INBOX_FIFO_DELIVER_IRQ		BIT(2)
 #define SPRD_INBOX_FIFO_IRQ_MASK		GENMASK(2, 0)
 
-/* Bit and mask definiation for outbox's SPRD_MBOX_IRQ_MSK register */
+/* Bit and mask definition for outbox's SPRD_MBOX_IRQ_MSK register */
 #define SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ		BIT(0)
 #define SPRD_OUTBOX_FIFO_IRQ_MASK		GENMASK(4, 0)
 
@@ -150,7 +150,7 @@ static irqreturn_t sprd_mbox_inbox_isr(int irq, void *data)
 		chan = &priv->chan[id];
 
 		/*
-		 * Check if the message was fetched by remote traget, if yes,
+		 * Check if the message was fetched by remote target, if yes,
 		 * that means the transmission has been completed.
 		 */
 		busy = fifo_sts & SPRD_INBOX_FIFO_BUSY_MASK;
diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 0130628f4d9d..efb43b038596 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -239,7 +239,7 @@ static irqreturn_t ti_msgmgr_queue_rx_interrupt(int irq, void *p)
 
 	/*
 	 * I have no idea about the protocol being used to communicate with the
-	 * remote producer - 0 could be valid data, so I wont make a judgement
+	 * remote producer - 0 could be valid data, so I won't make a judgement
 	 * of how many bytes I should be reading. Let the client figure this
 	 * out.. I just read the full message and pass it on..
 	 */
-- 
2.30.1

