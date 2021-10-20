Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4874345D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhJTHZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:25:52 -0400
Received: from mail-eopbgr1300135.outbound.protection.outlook.com ([40.107.130.135]:33568
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229976AbhJTHZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:25:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeFqpbM/vQcVZjh9R6P0hRjDIGqJdnvm3sB9d2W4KX9u0Zf3GwlXid1bP/QR8y//JFW6NcxcZJ7QSjOlpZ2MYWXNRDUKGqGtxOnZRpszUNlh420a49BEW2L3NEWTBzwZuFZqx12rJYQrUNTIQprUhJ/+0nBvn4jqn+eIZ6BPH7iN/gq3UUwtKr5Br76wQf9Z6mluQOqzYQbt2fQfTst/r7I3xCOf1TqeFiQ/Jyp7gd+7HYYq1IYo8vaXOkj2Q7UThnR2HXNvrOuq61uV+TwVk7JY1MGumkP1pK5HnUe93Zmsa+4ca/USzWTegrAXosN89582SJJedXTARzn4DITvbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RXegQTdvCjm2jHzNXVrXQYIVEXDErjRkrkjCE/oL/Q=;
 b=N2wui5Kj3z0Lq5VOQcnsxjQS6iorULaq52mOgacV8si6kFNvkx8W/JDCV5JEKFquiWhlrDEBQXEjTS/eeNrKdtGKcHGYjFp61cI0nEm0zNhfn7v4/tNLy1wK+ZKDWyLg6EGLt13zPv2E+szRrkF+4gnsTecZFi7VG8YMD6mWy9j8m9E5OL962gd7HOp0CuAfIZBPseAozlT6aOe1yKRuIkL+NXVPYx1xQyLyYFE53cUcaBHwZie/xpg4Dorf1hx4rJ23LkNXn7JrPwFL3FRs9ltWCY7uMJvQbE5UCMuVo9cDwTPq4ci1RX2J5P9utihAhx3cWs95JH6A8OzybGpZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RXegQTdvCjm2jHzNXVrXQYIVEXDErjRkrkjCE/oL/Q=;
 b=ikHG7GbEKOdlwCqY+yzUX6Pt42cEwRC+NX9/KPBOiYgdMvfbpMfqcVZieLSZPRKm9ri6bi+lc+macGG/5x1sDKD+P7guGv7EKKdma4pQIxs3UGmI3fSopZbXolVcjBpQGNZ1L0FJkKN4kOSmPOgyfMmCJlZBo/+JhIhc08s8zRE=
Authentication-Results: ioremap.net; dkim=none (message not signed)
 header.d=none;ioremap.net; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3114.apcprd06.prod.outlook.com (2603:1096:100:34::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 07:23:33 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 07:23:33 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] w1: use kfree_sensitive() instead of kfree()
Date:   Wed, 20 Oct 2021 00:23:21 -0700
Message-Id: <1634714604-58144-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0029.apcprd03.prod.outlook.com
 (2603:1096:203:c9::16) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HKAPR03CA0029.apcprd03.prod.outlook.com (2603:1096:203:c9::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 07:23:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce52d1e4-657b-491a-802b-08d9939a8628
X-MS-TrafficTypeDiagnostic: SL2PR06MB3114:
X-Microsoft-Antispam-PRVS: <SL2PR06MB31143D92D3D0AB062794641ABDBE9@SL2PR06MB3114.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:85;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xnqw25braI77RgYT90rKk5qXuTg465FT2iHVI2gJ0QGkxGyA/Vl7Ejuy5aWsqSYt5IFWHEly+HgvwW9huWdKmh3d3YSwk5j8ZmauVNLuRfQbwvkT8e5rrDRCBB5iDJic4Ux6Y9NFkm/LqClvBcNjbJGzggDoNfGs9cboNyzSCnvLcKeRtwqWy62QCDeJLNZQgY2Vgvwcqjkr58sSNu+q59FR/B5Ys1m4hBfW9VEq7gcKo9zKYMvk/p21InOdp/0xnkrHyo1i8imw3uofq3rSvT7ImmBKJz4kvW1JOPBzTqggUEpLCLTHZWjvbfzJjGvOjFOnyFmq6j5uJrbuiRZjsFR6gEVgfrJrEZj45Doli8p052cfx43EPzXOAxTSej2yamdtDM1FB6OR3EyEkuHYU7g9FPoaOJS2u/rQC6ewywj5uFFpeMqJ1Vo2F3g0CGBU2FXBrHoVrUCYANzNSslZQxp2iChkLd7vOzFQLdVM5gKBUvtPPzCRnZrLT778me2WMa5hXz7TberreZzPi/llseq+f+w/qGe5L1QOx0qVCigmZtc3so40AydWhXTKnc3GmmDyHKQxyyMMz14CuOUXe9prJBsbvnMMyyBrirlQL93N3DDKY3+/WEiqNxyxrvxZzONiK64BGbS38gT9MnDD6aPSIvfliAPVlsEY4qzpYCRjQcDaHXK37ARaoAXsq839vWkLbuJDYEW++VnTCYcX8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(4744005)(26005)(316002)(66476007)(52116002)(5660300002)(6506007)(66556008)(83380400001)(6666004)(38350700002)(6486002)(38100700002)(86362001)(6512007)(956004)(66946007)(36756003)(4326008)(8676002)(8936002)(2616005)(107886003)(2906002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?As2qdWUeH9g/wO0568PcOzX1b2NE8PS9pJs0NAEIBIhmhOqrN1YByDhCfOsd?=
 =?us-ascii?Q?fIwOgXJAC2kG6juHKugnqIhym15tyX6LKVpOUUfJcW9hoR0FnlnTDPuZ8tRm?=
 =?us-ascii?Q?EzQYMe7r1yQG9ZaeNERTuLfkCsTM72w+QteKh2HlVckiFY2pVU4kLD4eY8hE?=
 =?us-ascii?Q?Wym1ahgbEsGh6xPh0uZGPajxP5jkFkOMtcgRm/k4Z808ign1xTbU5jlc5Tdx?=
 =?us-ascii?Q?WQS35Gq9Uif7uI06NOknPkECC2HpCyzqQxnShITMLFErJhdMZQRj43nrm+37?=
 =?us-ascii?Q?f5o+/uR5iti3d4E4kIfrDdURMe2SV0jQyd6+QNgt/KvlFAILw0h+vqn+DinA?=
 =?us-ascii?Q?4tlktEku6EX1MQrpcj0vclk4dooEJoGEvu7Ff3HijH/d9xF8yZUZSQRHs50y?=
 =?us-ascii?Q?KHF5rNzO3TgLb9GIK1HtAzPsT8oD5MNJJh15TLv05XGjIAZoQzfcHMTbFjzC?=
 =?us-ascii?Q?pSQ9OG7LiLHswjf7D5R4303z1K1zSEPOn0WBK9aeXE5VXvQHWxownIhbqNu5?=
 =?us-ascii?Q?caxegZ6wtFjEy1cX2tqfm3rR5yo1FpkOPdu7cBiESB4HCOMfGiBF7OSCniSs?=
 =?us-ascii?Q?ejaLjvH5HHXmfwJBDEYPmtHm2yjqnHv6ecK59kpdY2AXjQcdLG/+jux/8WQG?=
 =?us-ascii?Q?2/Atwe+Y9ppTRoBwNKChSHP+sz7mnyc/WxzqEgO1Rm8bBSoq3XaSi/5ijYyI?=
 =?us-ascii?Q?i/iCtgPFgtPPx/tagoctWLQ52Cr44yWr1ar/rpFM8rd1PSywM3BL+mlHXi10?=
 =?us-ascii?Q?zMGvpUXKFqCmyKluyfWxJs5D7fK/4I9U3cirppX7SXcz7ttorjjJJeLLkO/+?=
 =?us-ascii?Q?RHaYtkAzxZRtH6k+0Ih1OLfYtT7pivUqqex8FTKTgomMf++7ewAXZN25ec0+?=
 =?us-ascii?Q?FwV9RfvghVFjxrWGTYayiVux3ZLUIDsEFiNXQgi5QOxrjoz3OG+24/i4xXmw?=
 =?us-ascii?Q?lCbww5cYlQgk7joS9EI0RrVX8VnzFeipQ1VMlRfnPJOiknKTcNmf86at1tb1?=
 =?us-ascii?Q?dVJB6O0ATJ+VZePYrOgwvp2Zr5FFzK+s3rXJi9rY3D+loiBThvJbLBnxThBr?=
 =?us-ascii?Q?+JNsPSa1XyLmj/mEWeq6eimMBqB3/dAYLfRGcuef0EJNVEbN49hIjOfq9/I0?=
 =?us-ascii?Q?WmG7302FLdDgn7j7ZxIbG7JsOnw2v66Q6oa41aNr9kW71rryI5Q9zpuAymZa?=
 =?us-ascii?Q?ah15Ey1pXdG05Xa97VOKTGx5kEcUfiIQ23A+Is0JdNB/rhszsXa8FuqMKNgx?=
 =?us-ascii?Q?f0EVQL+EZM6a6GPGmB09aJa0YAO9TNpT/iFnVb4vl19+ZRPfE7thlDABIG4W?=
 =?us-ascii?Q?lrwLaArwin/UOwCbMQ+m/pJxC1Swua62mt0LTI4+OQIu4Mg2G3JGuWLAg0o8?=
 =?us-ascii?Q?Gt1VFgv3QhcmkM8+JpnIMC36JSSKhHaw94xAUhlvCIgGa46OKgGm6b002N66?=
 =?us-ascii?Q?SPq9jTF54dsTCIh4Ug0GJ2qbgq423RDx0OYR+Tg7UOKJU2rwbgjqwtxj7ktk?=
 =?us-ascii?Q?pxCONWC9GeMg8szRRF5dsz92nt/K+8b1oblgRUS4UUR4c+yRk7iZr7OMicsI?=
 =?us-ascii?Q?16ewInsQtAENX1xdokWtlwCLrH/WaZIek7JQ0MO0rvbbYVCzertQ8nuFTutU?=
 =?us-ascii?Q?VoGGX7FNCn4PEycPHHfp6Zk=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce52d1e4-657b-491a-802b-08d9939a8628
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 07:23:33.6902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEOVwCF7TAFmnvMcz+eC98t+Ct4+7qLonNhrJnQVXDsg3tCE/NolN0fIdr3dEGrNriIDoc+Ut+lA9mUi2FfjEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

use kfree_sensitive() derictly instead of memset zero and kfree().

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/w1/w1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index f2ae2e5..a0a6c3c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -73,8 +73,7 @@ static void w1_master_release(struct device *dev)
 	struct w1_master *md = dev_to_w1_master(dev);
 
 	dev_dbg(dev, "%s: Releasing %s.\n", __func__, md->name);
-	memset(md, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
-	kfree(md);
+	kfree_sensitive(md);
 }
 
 static void w1_slave_release(struct device *dev)
-- 
2.7.4

