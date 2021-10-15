Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2616942E954
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhJOGwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 02:52:13 -0400
Received: from mail-eopbgr1300119.outbound.protection.outlook.com ([40.107.130.119]:31381
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230512AbhJOGwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:52:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9s8QBeb/YTPEr3vo7qWIVO82bojIvgrNnWZxbcORQmwHUpF0jHu309Y5w2eyV19qazs+YUdg4i6EnmY2Onj3Y135lN/OMtZljpGuiQM1CctCo3mQaLRmMrnE/5wz2Sz4VKT4gFCElAA8tbGIf33k/yLFqpbn1PoN3QiW1n3tiaohdbT2eiTByPvzGB3zWDsSukBwddYh59KA29WVOrthrG8rLMEXUaMXPF/3zrSOMZ1ezFcVXpK0t9tTPFWbMcmbSho1xyX7scLgQrFHVX6mFC51dW0Yzx6cAVlTeAfH079mdRbhobwWY8Q9ckqTTJO29bZoO1+E9EgLflh9iCDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bIjltf317jjWNYqz+cD72X0Pk7coRbtpAJ+I/Px4O4=;
 b=TZvui5TI59dwNfNmdoqceih9CGY6QP/ZVXdipxTxjUBuykZhnDvLEEQfY59AR+FEguopJCbibq9Y0ig8lE20y4O+rgH+mrvxqZNQAnbLQaQBC+JE4OaPRwti0pTTpmNSI9xZ/xPL15gNwXcWV35AbQY9CT4TOMQ5Tf43CuVd0/st6j/v1OHxI/8oksBNyXhHDHXm1kPTT2THa1QIh++cs7SB2v2u6xt/WZvDWgPOqsWXhJ8Pt6qSNMWMyzVcEzIXeMDeULVh6Jr8ABt7KmvI/pBbOMLLnahQL+2WEj7oSnlgGgWMO0OaMqYEI0bmpCYw+mRI+hAkdbQ3PMvZRo/RPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bIjltf317jjWNYqz+cD72X0Pk7coRbtpAJ+I/Px4O4=;
 b=QNqxHq6xp/ctvB391NXIkjI7sK2WYr8U3S5tR4Ol0gvnsrgu+++cp93wAyFeW8TPTeuZrgyQE4zdda/swmAZJG/4STjfm8wa7oFE7opzoIGASQasjmmVxycE5ym/cLRzQU17hEfHdBaX3XmcEHng1p6y73rgKe+9qaJYwllJfk8=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3147.apcprd06.prod.outlook.com (2603:1096:100:33::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 06:50:04 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 06:50:04 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] mfd: replace snprintf in show functions with sysfs_emit
Date:   Thu, 14 Oct 2021 23:49:52 -0700
Message-Id: <1634280592-4722-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:203:b0::19) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK0PR03CA0103.apcprd03.prod.outlook.com (2603:1096:203:b0::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.17 via Frontend Transport; Fri, 15 Oct 2021 06:50:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a618c03-2293-4479-03c7-08d98fa8046d
X-MS-TrafficTypeDiagnostic: SL2PR06MB3147:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3147EBDC47282ACF4A64FCD4BDB99@SL2PR06MB3147.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9LxPxcepdiVJnPW9P5a1pFVf2LElqUf4AFitlgNLCOoh2L7FQenxwr5U07/kO2HJUH9hRwszvnsW26pbEVC0AzzaVJ6MQ9vfsUB/XoCZ1CSyaWq2G+6zj01UNOL13EzpYltft+y+99ZGVDvmEHDR8I4ENXupCTzMnsylpsZZ7wJcDQie4xV3C3SA7B2Q8G3IiOk3FjoNIpMWIe+kmXg40jM8kjhoHTX7b0225XGug2nl+q9yfuQc5PrDo2JwNWnig2C873iwPxSuWbzbioAnJ2cxLLKdfMGcwd4MopKgOsz6Phtkerk8yxr1uwO4bBoNe6UflA0iL63K7hjalaBYLIA5/e2ubDQdCchCaxq8vObEUliG1hs8lm8VmzYAzsPkyiwHJ3gZqWLFsZrn0ad3sVsOaQxGRki9WNAwWFMBovpiIY+QTeg/w+vm21A+EYEVNcpyJf5Kptg340Zi9vpkPKQEkofvfVpYoziaeACO+wOk/+RULEDU4OWEex4TGdaYK6av84B9xGO/AJIPxN4AgZA+EO5z8HZF/bYMLQwuqO7pTTEUVN9W9PMSKtRClPhuj8r86Z9bekfy1tXuiJkG3qYg6KOVso+vwp2YPqNv9QhbNsgajhaz1yl1SFJejP/AKW+x8Sr6BM6aq7LIhjEoF5jHdLcMZcAqxdIEdWeqUAcbTib4Yeva4S7LnEzkrpcLEtz5WP7vpxW1g5a1PgWsdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(83380400001)(186003)(4744005)(107886003)(6666004)(4326008)(508600001)(52116002)(8676002)(26005)(36756003)(6506007)(2906002)(316002)(86362001)(66556008)(8936002)(5660300002)(956004)(2616005)(38350700002)(66946007)(6486002)(38100700002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m0qfvJdetZ2mdsVb+ZAYTkVGDMGH5ykQMZviYHBzeIsjP8gmy6l0Uu0hLoXN?=
 =?us-ascii?Q?45sx4UZri3jgy50ZiIwyxFy+3nQJVpc4s60WDuxY+Swk+QBYeqY2JsM8oHP6?=
 =?us-ascii?Q?lee7eaR4Q19T9MIAWr0yNrs8Junu1EHSXVPZX/ghplmEeUuL4uPQbVpW9EKP?=
 =?us-ascii?Q?pTZxeT/j0y0zlSdmYSCtMaFed4t33bS6tyMhPx81yeOQd1yAewASIPWAzLK7?=
 =?us-ascii?Q?CZ5b6oFfoxdOqbtwaVXWDsIlEp4FdrOGxMX9GOzgQrWjTFIvQ38HD7wrUczx?=
 =?us-ascii?Q?owf/7EcrtFfPcYUz6+OTcTaXU1AZQUtL6HOhKFS98H4NNiRzVgrZJLAhLsaS?=
 =?us-ascii?Q?zLNsm/iLY9IwxWDeU7jxgs3UHvYI986ddvJEaaN9gZEQPHfmwgkEz9fGEp0Y?=
 =?us-ascii?Q?3h8Jo5qqjcQwFpIsUcQzzUuwTO6kUVrqiB1sMETmpnV1eMtLktA2EBfCCLgw?=
 =?us-ascii?Q?edyxpbLH7K9lfAG244U0uA1If1TganTowA8JTVRBqO/dDmoFDsb0Gg9dazQs?=
 =?us-ascii?Q?37L6lGu8nQxdQ+EkyahkxluU43UkBCIHQ83VpYBiGsNaRuBtzgctHD5xUxfC?=
 =?us-ascii?Q?fucc+1tGg88vSEVr8oZEPz7WavkqTiOobCxYPiQMZ90+J1LkcfdSaEQfO8Qo?=
 =?us-ascii?Q?cqv7MEw5rdjYnqGjg6G3+INZ9tSFKv0n0I8be16Cyv8o+1gwwI3+y5osbGiQ?=
 =?us-ascii?Q?q3bqTa3rr5fBvToGfTEC5POxcJLlKQrl5AsfFr0zyQlCMZgyWJbWNo9N2p6r?=
 =?us-ascii?Q?ei9MJYDi3szIta6S7+TUa2Unqu/LbkY+KXo8hJjQE0joXcaYSCVdFkOVK+un?=
 =?us-ascii?Q?LgOGqGj8rmSQMEyoPlYytuNpxix37+ua7OrCfcYHsxusBY67fB9c5Onm7CLG?=
 =?us-ascii?Q?UiG8mNKT3yeroDGwtykDn4rZxSB5o7av2Lfq/SyRocPs2jtOVqX+GpbyzrYO?=
 =?us-ascii?Q?VjlQR3Kbx3Lz3W1UQpSG9W3YQHegP/3WGeA0OHT0I1CgOsDxwgEbWvs8BpCy?=
 =?us-ascii?Q?E5U74y17fUXi8Ift/ZQMqz54H6eGq4qyOIkcqVT9peIZgdKdkSzQ7tLafS4X?=
 =?us-ascii?Q?omfUEXBizC/oslBIr1xuFG0vv8A8EhjkVbL6LSfDylhsz8Wxg9Q258+CvS0O?=
 =?us-ascii?Q?Gq9w1oOjP7ylX0ji8uwKgsFSJAjvw22vZUkySCfLOCV7Z80Pv1wDZe5FrH1q?=
 =?us-ascii?Q?+IoGnreC4/kkG7Mc1eTrkgnZcV6HFgmJs2zfY/lSqkENrv4jpAL/IIIMPajR?=
 =?us-ascii?Q?jLLP/bUlKzs9HmCYipZXdDvicNhEV0u4zxnQGjWPHjLi8GsDOMEB1h+frD3S?=
 =?us-ascii?Q?Np79JCfNp8lYi58Z4tWbfJBc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a618c03-2293-4479-03c7-08d98fa8046d
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 06:50:04.2835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sw+U5gOtWRFjo6eYvsyUZwrCy9dbQzvEuXOQmSRS7KVTznxeo1sjn6uXLkVxIOV6HqXFmZJJzcqjFPaImgdMdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3147
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show() must not use snprintf() when formatting the value to be
returned to user space.

Fix the following coccicheck warning:
drivers/mfd/janz-cmodio.c:157: WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/mfd/janz-cmodio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/janz-cmodio.c b/drivers/mfd/janz-cmodio.c
index 70eba4c..add3bc0 100644
--- a/drivers/mfd/janz-cmodio.c
+++ b/drivers/mfd/janz-cmodio.c
@@ -154,7 +154,7 @@ static ssize_t modulbus_number_show(struct device *dev,
 {
 	struct cmodio_device *priv = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%x\n", priv->hex);
+	return sysfs_emit(buf, "%x\n", priv->hex);
 }
 
 static DEVICE_ATTR_RO(modulbus_number);
-- 
2.7.4

