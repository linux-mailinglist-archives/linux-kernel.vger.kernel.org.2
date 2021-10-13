Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6A742B372
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbhJMD2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:28:51 -0400
Received: from mail-eopbgr1300117.outbound.protection.outlook.com ([40.107.130.117]:31513
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237537AbhJMD2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:28:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDpVMEUMBJbVK7eOz8Buijqk0YWfaCK3oUpwzBZUch43hXbfih9cwksMuU/9hzncR9MQ8Jry8UFHBroO38A/EKUyVWmhdl5R2ocdco9YKd8DdS4vrd39tWoe8vB1+tZBW9bS1TwqplynNgNU8IkZwBSlwqFMFUpI5ekSPv2897Flx/0XDuVRnpyaeEYDZXX4tN6dDUvOPLtk86iA5gf9gofj6YmRMVvaMhfAtUDXl7vSNCwrpRXL/7Pv0GbVvfxln3uuhuYukAD2hHVHv7Nkk5DmuajhVHoQXO2g+Jr3rFgUE6gjsc/7xul7zP+TGsM9OWbo3C+5XO4KtrJQwtrUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyFocW7K05rzLv+LrtiAwb+zh2GBVBINPKyZeNmvNj4=;
 b=k0IyaUsQxYGtXu1cy1qftksqOxAMri2AR5Hd2v/WSakgVH29rl+zkx0KZIzZ0P2kj589Kya/eDrlbG6CUvoD+9P8B+K7StYQdNT8j8Rl1rYYUUwyrH9vIrTd0SwNPG47J5kaljK8DxgJYWpi15HZko4be2Im3if1ZikqMpbiihrWxFhU0i3YR3wq9vjTgwueeMErhyfOxEP8fNysiShNQyLCvO6qnShfUdh37/tI8BNiq3qBKxnqwA9Hr+ACCKmP0Wn8kMScGB0a2U5fRpolujoTUmCkJSzCHce0CbdzljQwASKnDy7hLijrVbtyT18BUtaksnE/78lzgwQ5x+3pLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyFocW7K05rzLv+LrtiAwb+zh2GBVBINPKyZeNmvNj4=;
 b=TdwLTdZ/koP40LJCBWco5jxOEXZcmO6t8QT9kbTPur5wsVaCD74WSJmKpxwKPGdG+R0scExq+B2AZMrvIrr9YFklQoluVLRPV3xl/d5bsEAKZyfj0jAMArjjO3yuqTdN3949ETGNEwq9PL/tnKxLly1WUsJTTudG30D2IOHm4Ck=
Authentication-Results: mev.co.uk; dkim=none (message not signed)
 header.d=none;mev.co.uk; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3243.apcprd06.prod.outlook.com (2603:1096:100:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 03:26:40 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.024; Wed, 13 Oct 2021
 03:26:40 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] comedi: replace snprintf in show functions with sysfs_emit
Date:   Tue, 12 Oct 2021 20:26:27 -0700
Message-Id: <1634095587-4122-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0023.apcprd03.prod.outlook.com
 (2603:1096:203:c9::10) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HKAPR03CA0023.apcprd03.prod.outlook.com (2603:1096:203:c9::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.5 via Frontend Transport; Wed, 13 Oct 2021 03:26:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc57885a-e774-4af3-6832-08d98df945c0
X-MS-TrafficTypeDiagnostic: SL2PR06MB3243:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB32430DAE2A3C57C0EEE6A73EBDB79@SL2PR06MB3243.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yI5IGhU+R7IpR36gsPBlvPrlEXRkhHmX3IUALivyMQVeAXui94XoB2/uxqVHTVrzz9RjQlGJ7lLvnXoFp4jexskgRUx3HDNJTP82l9Cg9OmIIBUIH3ixMFdjslch8NrdYka8zqXac+pa8Et/+2A0Cu8oBe/3ty6d3Jmtk+lWZaO9OuoaKtMoHAFgbU4ldxwsqQEvXO2IGaecEskt/1nc8d1LhJmNpkm1KH40PThZaqTy7wxYKxg3V9dIRfN/2fsK3O8bQvZxhDd9cuajPyQfhlXSTAm6Jdq/TF7Y6/nPaS+Y0XOy0zfJOfxSZJG//6/4A3p3bCp6HPwygGdQU9SDUqU6wTSRbjWccbPksAmTjCMC/u3wbRGeXEMfl1CDc1s6jncubp4ZXBhpDg9xQsQ+wfZdbt8hQPPougQ7GxS+i2P7RW2VG8y5jJRczh/K/Vc7U9giXqoVs/dYSK5z/4bfWKW3i3FZdqjDbT4ie1lzInQHANROovzEmHCadyO7GH/z85oGyY3hZfc4DTUb0nMhbrd41PAUyMUR0i+wQ4mHfrq/T+eQAor/7g4DyCRC+fzv082VhcWACmvp+bZSsnjv3HHqrPj49PWBJt5LFpnfmNNVrs8xJ3cB7q42CbrVMgxbjSjodyTWzLSyuhv6+cOzQNCHT8ZXP/+lz6OB49cHbKwSWn3ZxFQ6siqJOrW5Q3q6JYkJPf/E8fFnzEjt3/TFWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(2906002)(26005)(6512007)(4326008)(66946007)(8676002)(36756003)(66476007)(83380400001)(38100700002)(6666004)(66556008)(38350700002)(107886003)(316002)(52116002)(186003)(8936002)(6486002)(5660300002)(6506007)(110136005)(956004)(2616005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8scOZUs9y6b1dUZ/L9h02+EqmA2GbUpql/6umSfjifw+1qzxABplzYF94LGN?=
 =?us-ascii?Q?FK8v6fGvoJkr9ZG3lo4YAeWIInW62dVIuX4+1U6y7jPO1f1Ve/85cvPVsLnE?=
 =?us-ascii?Q?Vaq81pFec2ISDTG9KDtMvCXBNToq6u0COkzGjD/UTMQ+k5jJQmriZaSnUieU?=
 =?us-ascii?Q?Z93JCSzArh/1caKkrVEUs99w8XCLpZgxRucJoCu8X2XGoK4yZkJ78dxsoDzq?=
 =?us-ascii?Q?Lv+TDlgWoUDbnUaR3hLCb3PTQo/WNM0Xr5XiJzblt1N+gGTar7Dw25Cislln?=
 =?us-ascii?Q?xLkXvH2vhXA+FwYYLkwmrSHWA6NNZRerFIHVFK6V5Nb06gwwVL2gRWCEl2Ts?=
 =?us-ascii?Q?G6moNJkhMmCaf87OPB/OpFt4cTj+V1mFFYg5MxuIeIeZF8So5Lhx+3FqvSoB?=
 =?us-ascii?Q?vT1Y0uwvhJeatdlVHxmUbFYMmmNIvaEwt4VglSiHzSi0V7+mJAI6Lq3/1S94?=
 =?us-ascii?Q?UqmGK3lBKm8IldIWtgeSbT9xbuDxt9PCC5qirCqaTXMQ5saS3/RAAnU9Xrho?=
 =?us-ascii?Q?bzjICdq08ENhPucDqS6KtOl+Egm1O7/4tIovcAkMBW9t3hAmK0zxdT1IYk3h?=
 =?us-ascii?Q?9oCI+x+jqGdlfUFZnuxlGjvLrBEowyeexUqZYQYmBMI5PYNyuWR3exzHgHLx?=
 =?us-ascii?Q?Vf+g5v0nfe7ynSgpLvLPQpMQwDfWPeHWR/ODaVS1FbDXzE7I9raO9fpSVPnc?=
 =?us-ascii?Q?LA7x/jjv8mQhPoFPJmzXW36QZB7z/062QZvlD6SMzOt6K1z4VhPEqdUJvzOh?=
 =?us-ascii?Q?3+PyLdrkQeJo1/fmvOoUM0y3g4oMMTlEvhyQ+sDZ7GHkfAk6jqVhmqaWNACJ?=
 =?us-ascii?Q?UXqms82xb4ldVeN0Pn+c6khAJIYVxwY82Uol8PjcDLJU+X0SpngwThVfc6zp?=
 =?us-ascii?Q?lhI8Pkka6hQKzr26ngLiRw0kHpXPu8WgReh1x92S98PChrf+7uEpWntHkT9I?=
 =?us-ascii?Q?+xGF62hjRP4jfiaV38KP8UJyjMl06He88ohdWNWVIzu9zUa50/bqXhZngX1Z?=
 =?us-ascii?Q?2U2v+DLhZg1bknssGjD4kywh5e1ZbUVGC5D0+WDZLkfrhIxd0ZKTQcibmCsh?=
 =?us-ascii?Q?bmx3zq8kaAzlbQU17GGkgkf8PMyElGBLsGeB7kIfvQCBUZBsxd4iyuF1p5lH?=
 =?us-ascii?Q?1mcFz1upvxRr1Irrf630P7UxdNEeb/dKrLEubVe5Tq9TIOsZtJ7Ob79R296/?=
 =?us-ascii?Q?jcabw0iQC/hyVl6KPvBhTvjNGRzZxbSAqm6Ze+tFtesVauDuzs2S6TluzOb9?=
 =?us-ascii?Q?0jtUuOSoR0ZeJnhRgG9VTvkBE241DtMrkTTiIm/Cusi5WmIU79Ltzp/r/SNS?=
 =?us-ascii?Q?KgVQEQDY7Fo4kI9DPoYPhVT+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc57885a-e774-4af3-6832-08d98df945c0
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:26:40.7605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPDS1Q0oTm2D9k6/1Eoj4oew+eL9jea3cD7Vm3NK2zZQKMyasqEJlde8eS1ko7NOFdUA4D5+euYoG23veHJsrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3243
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coccicheck complains about the use of snprintf() in sysfs show functions.

Fix the following coccicheck warning:
drivers/comedi/comedi_fops.c:399:8-16: WARNING: use scnprintf or sprintf.
drivers/comedi/comedi_fops.c:455:8-16: WARNING: use scnprintf or sprintf.
drivers/comedi/comedi_fops.c:512:8-16: WARNING: use scnprintf or sprintf.
drivers/comedi/comedi_fops.c:568:8-16: WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/comedi/comedi_fops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index df77b6b..3d90029 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -396,7 +396,7 @@ static ssize_t max_read_buffer_kb_show(struct device *csdev,
 	mutex_unlock(&dev->mutex);
 
 	comedi_dev_put(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return sysfs_emit(buf, "%u\n", size);
 }
 
 static ssize_t max_read_buffer_kb_store(struct device *csdev,
@@ -452,7 +452,7 @@ static ssize_t read_buffer_kb_show(struct device *csdev,
 	mutex_unlock(&dev->mutex);
 
 	comedi_dev_put(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return sysfs_emit(buf, "%u\n", size);
 }
 
 static ssize_t read_buffer_kb_store(struct device *csdev,
@@ -509,7 +509,7 @@ static ssize_t max_write_buffer_kb_show(struct device *csdev,
 	mutex_unlock(&dev->mutex);
 
 	comedi_dev_put(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return sysfs_emit(buf, "%u\n", size);
 }
 
 static ssize_t max_write_buffer_kb_store(struct device *csdev,
@@ -565,7 +565,7 @@ static ssize_t write_buffer_kb_show(struct device *csdev,
 	mutex_unlock(&dev->mutex);
 
 	comedi_dev_put(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return sysfs_emit(buf, "%u\n", size);
 }
 
 static ssize_t write_buffer_kb_store(struct device *csdev,
-- 
2.7.4

