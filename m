Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D0E42E969
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhJOGxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 02:53:55 -0400
Received: from mail-eopbgr1310107.outbound.protection.outlook.com ([40.107.131.107]:65248
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235782AbhJOGxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:53:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+vVkX3/7+FGAPW4GrXJiZLbt1SRcX6GvV50bvTkHZkAQZfZtA9OtQsDoyyMydyWEOzDdkuH8xLR6rDj9NxnpVWGGjVat8MlTpdAa2R7gQpuJ7kscOeBkO2MFSsALWbO7eDozUW64D4dVTFJVK7bOcG3m50N7OpFBDZazA5kFAK5nPUjUhutcA7I67W3qKWEe6gIjBSaISsB/W2+p5RH2Ku3mT0dEmI6MHNRz4bC6l/vDvaJWh7a7J2txxGrvOi86ld4zpFyx1JH19UMq8sWGYXCRmQnWkKnKEpbLDdnNpOLU6M59e5I51VB8pVasj0JDUT+hnhGkqIXFLRwL7nwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1j7WgX5WBkvTQN8XfrmCMvI6GbysiK4+EmUpVndp/A=;
 b=mwuJOY/w9eRfVvJsCvMLwEjPp5YUAzPpPgdQzLtk1KGB55Inzl3K94U/CK1NKF4RS3yK/k8lwGDbyW5l2hHMjMDyOTLG0N0QiwmbKmYUn8ZORcPFzEwpYir0N7OHTNCqNhkt+sfglJ7nA7ZLHs4PO097LVYFKcoe37NxpAfQfG+LcuDGZST8d3OqlaSd8hnqjOMAMl2hW4e9YESsnxDMKeYCkdWZC7wNA15dP7PqWGNwla9lNret33Vmc4d+gH5365pA9L9P+3/LvRqjSfQAYtMtwbxcVn82ArKpknQnZ4Tue575kz6ETNnlCiDrsCz8A8bv8ZnY7BbdqtZ+5InJXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1j7WgX5WBkvTQN8XfrmCMvI6GbysiK4+EmUpVndp/A=;
 b=FHy9BwHfqHraI6uCuMFijn2tzq7qZnU7+toklwUlassQ/Xyj6jyaxH22nBoDHmsuqs69Re25KZpOKubIVxdhsg0FSRyQ7Edl2mD3OnP3knYafXjenvPrjNjykUFfMJCQAOlZzE/vumacjkwTd9Tr6mT7lD/lL4ELlzvhVgLAVlE=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3003.apcprd06.prod.outlook.com (2603:1096:100:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 15 Oct
 2021 06:51:44 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 06:51:43 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] tty: vt: replace snprintf in show functions with sysfs_emit
Date:   Thu, 14 Oct 2021 23:51:36 -0700
Message-Id: <1634280696-5056-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:203:b0::33) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK0PR03CA0117.apcprd03.prod.outlook.com (2603:1096:203:b0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 06:51:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 203106d9-d614-4b9e-ca26-08d98fa83fc0
X-MS-TrafficTypeDiagnostic: SL2PR06MB3003:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3003D29611BE7274BE54A874BDB99@SL2PR06MB3003.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:176;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8juEwFDo2pGPD187BIgz7m22d3gakBEcnJxJUmmRmqzIS7oF1EgqoD7j5u0u122tMujgx1I/llFOdbI1RM82i+Her/vptrofE6/mrvevTEBidaa08o5rpoLWMI1e8NaXknpolP6eNqJMlbTgHnND4wLGREtkcKVxgM4vGdwlmgodxGt/Nr4pAml8RiR34hcd6hZzgHopuTt1NSPqC9LcMYrIp8neypbliiL/+xWlNIx71+BjHIWDXh8jFOpfJp0Zi/lm4gFTUyp9YWxHdUMUhp6YNO48CebtJNoZg+vlyOpKjMPG1LMydohSatWlUUxgCzjLqve42Z+XYdxEWvAPeftlGuzeX8VvQLHsMdoIf0aou+z8k0bTPo+DDWt+03p21Vu9uYmShKessp46yvBq5/fIJ/BASKPYj2FJLsGYKyONtqOTE1b+kbBrCqfQHMfIfWMpc6adWi5C/xPqU+InUdfaUKFnx3m0d392GxiuSx46b5IJ3MIdEqBqAcZ/mw8RyZLIu1sYjr0H5OlGsmBDZs9ZPQpye8LpWUcq042g2hADlI0gQ4uG+9/rU9RQXhHkjZKtzWAgp1aAv7xiyTGfLtPB8AKXODjJAaPhe/2TuGkr9G5gFvq9Gp2E3nd7vxhRaVJ/l6akohCj1bgWAWzLo2ZS2kOmTreL0l2j5gjRCA+1zNUDzEpWGDV30cptmVm0D3Kl3GdhGU3YzQN71mxyAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(5660300002)(8936002)(66476007)(83380400001)(316002)(2906002)(4326008)(36756003)(110136005)(6666004)(66946007)(86362001)(186003)(956004)(2616005)(107886003)(26005)(6512007)(8676002)(508600001)(52116002)(38350700002)(6506007)(6486002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oWWAuK9Gr1I0/c9G6ITcEVJOnxGeMLLkgRvZl+PnQTxBOzsa4YtZeM2aCC7q?=
 =?us-ascii?Q?YyB0WHScyNusFsB3t0kuancJdClDKyy5S83/5TwD8MJjKGmvPGTP/a/7gcK7?=
 =?us-ascii?Q?PaLsgW5P7dhnuPACXK7WOkybcPehxiU+eWAh6Xl10AWIO7bdvYN5MbMzgmxt?=
 =?us-ascii?Q?Lba0KlFZ2PioOVUQjvW1k/MGyBHinb/q0I1pT3pgRjfx925Yyr0adE3CQvmm?=
 =?us-ascii?Q?4TiFMXwZQou3Y/tzOvKzaBNleQcw0zphtyZRz2vlLmUO3pweDjzRLr42lD4X?=
 =?us-ascii?Q?ElI3MkdqqaaNkI4h96vRHgmm3QnZKPSiFa/TmKcZo+co9oSXT7YW39d+MELe?=
 =?us-ascii?Q?oIZTETFV07E4VHMU4V+GcR2qT1uqpyEL/fipOep506cvtVG4wq54d3e9vgN4?=
 =?us-ascii?Q?YIdB6kgNBW+dKxHNWFFIhyHHqoiOBl8Un9XI2GLFnAKPw8n7EteZnZ8J2DfT?=
 =?us-ascii?Q?z6jkpypw+4DVLQe1BiNvJLLGUkf+BjR1XzC3n8ZGnx7sbcaXhl3aawrfEyq8?=
 =?us-ascii?Q?UJD3akDpCQY3OEXQlWkNHMiVpax0nUkhFSNjEjMs654dGiZEaRr0JABNzOOI?=
 =?us-ascii?Q?//xW9kQp0hRQi6rXHsHsuWQE1uXqKVytzh4GIgCsXT7frnATZQb5aM0knas9?=
 =?us-ascii?Q?IQs8et588xVREq5hybMwlS5lmVmLhNE1a8JLXBPrVVmXFKwVzYA+E8m/wXHS?=
 =?us-ascii?Q?+rmEvoz1sm5Fd146SBCdSwCXovcj25bEOyWvlDH/pk3r1MR1u2c7GpmPOPFN?=
 =?us-ascii?Q?8wcN2OwNHPw2Tju9qtKoKsDPyv9vFlcOsoIEenxcDHbOjqvpetRYzjnxB3oI?=
 =?us-ascii?Q?HvDSy60OcM+xTNPfZTDuHfq1GQLWVnujslhStQOFX9jJz9zXCNNc7kMhtoLi?=
 =?us-ascii?Q?ppqWCr9N3vzCxBuH+RRmaTJ6yOYJo8YoaLplKEyBTPVDlumrAzJtCq1VeL28?=
 =?us-ascii?Q?2m1RKTm19y9Oyp79o11iNPQLwii0J2kaP6TiZN67XVodBR5wreRrYIpgqPs+?=
 =?us-ascii?Q?v+3CdEpaTIa4uaWr5AO17dT6194O6Nl0WQYI/Bck2V+fo2VdO4kxf/DWovxK?=
 =?us-ascii?Q?Oz0enZEneaKJDX8UxCp1r7rBSntmwUSwtNtAsuEII+v9gjCGmiMCmy2/bnTF?=
 =?us-ascii?Q?8e5wIa/9gyp9v2tuDBessHmReO7BiyIx7efxeToUv26zfv6hZ6dol9sTo9aJ?=
 =?us-ascii?Q?qXEO79hmpWLmOv6vlOa0gDhHzO150TxK01L2o7rZMhyZ6E9ED0LfgmUO9y7s?=
 =?us-ascii?Q?H+tdLnRPM1goJprlJ9XQ4vgJS/ue3eUadD4XjFz8lCdG/E7Iay4DaHkaKA2b?=
 =?us-ascii?Q?cAMGccwuOVl2IuFQ0dFdCPMy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203106d9-d614-4b9e-ca26-08d98fa83fc0
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 06:51:43.8141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoHkJSit/C2UHyQOIu+1SmqIHD203dEqlOYgZ//6t+g3x8k4zkXUYAZS3B8kBC/xR0mg4t5GxD4LLTJM7A1U0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3003
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show() must not use snprintf() when formatting the value to be
returned to user space.

Fix the following coccicheck warning:
drivers/tty/vt/vt.c:3902: WARNING: use scnprintf or sprintf.
drivers/tty/vt/vt.c:3910: WARNING: use scnprintf or sprintf.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/tty/vt/vt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index ef981d3..ea44ea1 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3899,7 +3899,7 @@ static ssize_t show_bind(struct device *dev, struct device_attribute *attr,
 	bind = con_is_bound(con->con);
 	console_unlock();
 
-	return snprintf(buf, PAGE_SIZE, "%i\n", bind);
+	return sysfs_emit(buf, "%i\n", bind);
 }
 
 static ssize_t show_name(struct device *dev, struct device_attribute *attr,
@@ -3907,7 +3907,7 @@ static ssize_t show_name(struct device *dev, struct device_attribute *attr,
 {
 	struct con_driver *con = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s %s\n",
+	return sysfs_emit(buf, "%s %s\n",
 			(con->flag & CON_DRIVER_FLAG_MODULE) ? "(M)" : "(S)",
 			 con->desc);
 
-- 
2.7.4

