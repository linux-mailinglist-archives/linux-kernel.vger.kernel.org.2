Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4904242E957
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbhJOGwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 02:52:30 -0400
Received: from mail-eopbgr1300119.outbound.protection.outlook.com ([40.107.130.119]:23712
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230512AbhJOGw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:52:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8Sthsww8ZwFhxFv8yW9olNA1QY/IDRnJkU6itIIA6/Hh5bNYdKTlAwFZO8UFj5ZWguuEYwxqe+3raNowSm+/P9+lyBfvg2Jwa27ISvOO3G1kiH4ICaI/AY9Zzi8iAZSJNBSv2oPBehhMhXwlRinxZYj7r9Zj5JaMUJOhJtoZ5dldhDWfnQPzutBBX/o1iqw9+Qy/RWenBtHwGnR0CVfLy4hgcUkjrditxmZrvqSoK/eBGQLWFVFqFzdkexw369Can79Eaa1qTbR79taKI7oUyxUJDLzjGMV6P8fW0P4mM/xqcE5CwfefmlGnoFK7m+xjH7x3L2iRqM8unUhaDNBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjU/Brlt4y/6SU8qHU7CarNqesDzUx1yHS5X+zbUYiE=;
 b=fc/7R6UVZDE3UJ488Kvmaa5Za8NvxFTNRqiTj6ycmSE7RVlR304cwWVeIFqcsSxu3EJLWMdMFE4AwkC+rakW7ds+LlpQdkmryS5QXuyXvxF3HuNW/m8/Dl1AOpRJ3Ho5Np/sM29/vS5aLjlrkHRPrZ/kbQ2YLDJNopNW2rSrbXOTngaxTus0i3+PHKJE18m7E5eVopHpv2K+b+K9gaeGKO74jxkv6mYM/tdxvWak4/ZrS3arql/DQ7b3zxCabhlFr1iMzH9mx6ryE1ptoWyYHISyM2zosDWQXGRH3wID0A34PkQht9IX5mqy47fy/QKIEDMy8m8kwPJ1eSSaR8+89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjU/Brlt4y/6SU8qHU7CarNqesDzUx1yHS5X+zbUYiE=;
 b=hAoBS6vtLmJfRvnZZOCiSU7o8fP95XQrsoggZhX/E94e4nI/29Azsv7u0a7Lg4kA3Qf224BlaP1TfwZ/WAhBrc2HW19pW/4BktiA8drfr/NI9h6JU36BQKwpeEiWQc7KhM1FklG+1xVbjTZprrrQw98FQbZnfgu+zU+O0de09Kc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3388.apcprd06.prod.outlook.com (2603:1096:100:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 06:50:18 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 06:50:18 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] most: replace snprintf in show functions with sysfs_emit
Date:   Thu, 14 Oct 2021 23:50:10 -0700
Message-Id: <1634280610-4768-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:202:2e::30) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK2PR06CA0018.apcprd06.prod.outlook.com (2603:1096:202:2e::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 06:50:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0443427f-a91d-468e-905d-08d98fa80c93
X-MS-TrafficTypeDiagnostic: SL2PR06MB3388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB338846FC334168A952C13254BDB99@SL2PR06MB3388.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:187;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7u7xQhRQ0gJvVmr9yJpIc8Pk7aEzw196tlwPf1hHWlF2VwifoDf2HbcUeT6HnhM6wDohTroDnPO89ioz1lxXjvk7MdWBisyWIF0UgeLWdxBp3lXyPOsx056zTi5QIfmOKBj35/xjhHxwTlnuMGUCnPuFFwoSAVVjVOMmlmsvTEK5Z0zw+oq5iroP/VKERq0z86aiEKz01e2LVcw1399A8hyam5Tmabn8vAQFfyGUvhNXL+bKUXwmVZ0XXyOiHpureIA3opHreq6hfwXTT+Up4ItoM8anGt3QKD3jBoPc06ZSekyMgLLxx03DQS9qLDKvWp9rVaVOpdn39zaMobF9R6IP56rV/D83kgc83H54opg5kX0Wv1hnYMX/PB6cyNu/ZbMy/EwrRtFTiVO0j4S56HDvCKZMLLxPHG+rdVIJfYx60XCxbJv+LAevaKcIFZmrjmbyUmlpcsmv86PMP0WoTMxGv9T3AGYlbrI4TE38fn/4I1ysJe8MP0F8QnckS9s3RJj9ft7mIuCsO9Vu+7Yz3cogl1sq4s0jhHVMdni8jVRFXuXYghP95+MQryRsopiNM/OCgWHyK3sn/z91i/P7hr7dXwxP9cCYDaNll06GrQT3SWKFQtLolLgl5j5c1TgkijZJIxOyJtM9eXJho2LOeIzRpLg7vRZtmVTYerqTcdVfox5K9rxAtp9o4wqv4PnsI19zZ7dq99wJknN5y0kwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(2616005)(316002)(2906002)(26005)(107886003)(8676002)(6916009)(66556008)(83380400001)(186003)(66946007)(6486002)(956004)(508600001)(36756003)(4326008)(66476007)(6666004)(6506007)(8936002)(5660300002)(86362001)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UxEY6ho/jG7uhDuWKSfUSfKfiAegLXo2R+ZfS2J7TKKalBQYbxIRstO+3DS3?=
 =?us-ascii?Q?9Ul+gQ4MSQju5/Gvqyqtqt3q4Q+59tyewJfR6dEL5DHO7DZjs3qUTRmlfP9l?=
 =?us-ascii?Q?nAFNGpfFtuAzMSttwfn6rPlXEt1ZMCV9CUjhMyzaM1Wkf3KyTywBwQhISFn3?=
 =?us-ascii?Q?buYbEyOOGUxQtq2sFPOZ1KrQxqDUatPVT0VyL4SoCjoPsIXh1KvbJWAMDC1w?=
 =?us-ascii?Q?9RivuzldY7YqQUG11HlX4knwtgiPiBvxmAeyiePLL11cqI6UiI7pXgUI+kEc?=
 =?us-ascii?Q?e2dS2boWKJrmdarX0isGStSfZ2zqLPq/HcaNGSuIuvmlN6DCIPjbgde7efgj?=
 =?us-ascii?Q?04K0i86SdVhdRgXiDRe4JM7gnW1FD8dfcCp0H4ms0+N/nfmqrWrRY8aazDQt?=
 =?us-ascii?Q?4At6SxJC5v/J8YSX1uGPSrxivyfUFm0xQXROjSyCrxaIZhZtXCAL9Tfukdmn?=
 =?us-ascii?Q?9RmhRehtS1UhlMc6gy8QgcTblkrXvpyBF9iXXrGKs1NeR5ymUCCc9WD2SK9s?=
 =?us-ascii?Q?ba/6JVoyQqcPGB7UgqisSgOTrRe4MjB22qfPoOaINOLbopIbPxS7SC90H+ZE?=
 =?us-ascii?Q?LJKeCY4W6aFdK2h/iwkSnuB6NftuKxCtUSE5sHcwWcYzGrdrqdrLG7huY+bq?=
 =?us-ascii?Q?Cb3+HdlMMrd6jQSDmTaec1EsXBmc2aAPbrfFxYjThsdOlqE++SRd16+tuKeE?=
 =?us-ascii?Q?vMh1jvzLwL3aXisA6fxm+Vc5nKOIg67NEhqGC0OVV74YQkhipQFv5igUWjjW?=
 =?us-ascii?Q?byBnyt74j2wLInZV7EC/lLPrNo+5MJXVMtRCQ9hkyN2pogVhTZZ68g4XJpfg?=
 =?us-ascii?Q?98LUI3Bjdkxd/9J9hN56/+9cKaeE16M/CGHciIKS5tnViI7+ZEqTe405xZ2d?=
 =?us-ascii?Q?Pdg2gdX0nitmv+1iwgrSY7RcH046w6UJPM6GtbUyZHn6aHdCirNqH52YhnbB?=
 =?us-ascii?Q?sEoeua6pUYzkUiOLgPtO9xCHeQFNjsatqTCq97l9fqv/ALIzp3/k92calE1r?=
 =?us-ascii?Q?jX3hwSBIGpCwMiMqCgjxKtT2n4oYDyfj5f/DvI5+aYMMSDTHbIBjy8GtF9iX?=
 =?us-ascii?Q?EhdM9Hw8FlT5jV1OMm47E1QX+z7HjUwIa1lRDKVHJuprteAp9RcpR6BzIot8?=
 =?us-ascii?Q?3eFzhOeV9J7ZpCH4lkBJGgtkSr9b2Ie9vTxTSz+FGQAF5CXxqAEln56ZPigN?=
 =?us-ascii?Q?/fnYUztY8gl7t0GgafpYJ1sfPb143+IxCbMY1JaJe081fDS7/PuLjVEX18vD?=
 =?us-ascii?Q?8Fg2wD/0jqCfc8SL1kjAjfkgxLSih7eLqPCK83frZuRTuCVZAZqjhdQc9JnJ?=
 =?us-ascii?Q?Gg8y2Ho72pc96ONtkzobKWkX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0443427f-a91d-468e-905d-08d98fa80c93
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 06:50:17.9509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hALHOoZheHyeDl/YfSakEDZnfPQ3tT9DKznJHvqpKh+V9twOUxiqpJlMn+mNdc7zBlq95tf9l69tJ1Q/QHuJ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3388
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show() must not use snprintf() when formatting the value to be
returned to user space.

Fix the coccicheck warnings:
WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/most/core.c     | 52 ++++++++++++++++++++++++-------------------------
 drivers/most/most_usb.c |  4 ++--
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/most/core.c b/drivers/most/core.c
index e4412c7..ba12154 100644
--- a/drivers/most/core.c
+++ b/drivers/most/core.c
@@ -208,7 +208,7 @@ static ssize_t number_of_packet_buffers_show(struct device *dev,
 	struct most_channel *c = to_channel(dev);
 	unsigned int i = c->channel_id;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			c->iface->channel_vector[i].num_buffers_packet);
 }
 
@@ -219,7 +219,7 @@ static ssize_t number_of_stream_buffers_show(struct device *dev,
 	struct most_channel *c = to_channel(dev);
 	unsigned int i = c->channel_id;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			c->iface->channel_vector[i].num_buffers_streaming);
 }
 
@@ -230,7 +230,7 @@ static ssize_t size_of_packet_buffer_show(struct device *dev,
 	struct most_channel *c = to_channel(dev);
 	unsigned int i = c->channel_id;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			c->iface->channel_vector[i].buffer_size_packet);
 }
 
@@ -241,7 +241,7 @@ static ssize_t size_of_stream_buffer_show(struct device *dev,
 	struct most_channel *c = to_channel(dev);
 	unsigned int i = c->channel_id;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			c->iface->channel_vector[i].buffer_size_streaming);
 }
 
@@ -251,7 +251,7 @@ static ssize_t channel_starving_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", c->is_starving);
+	return sysfs_emit(buf, "%d\n", c->is_starving);
 }
 
 static ssize_t set_number_of_buffers_show(struct device *dev,
@@ -260,7 +260,7 @@ static ssize_t set_number_of_buffers_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.num_buffers);
+	return sysfs_emit(buf, "%d\n", c->cfg.num_buffers);
 }
 
 static ssize_t set_buffer_size_show(struct device *dev,
@@ -269,7 +269,7 @@ static ssize_t set_buffer_size_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.buffer_size);
+	return sysfs_emit(buf, "%d\n", c->cfg.buffer_size);
 }
 
 static ssize_t set_direction_show(struct device *dev,
@@ -279,10 +279,10 @@ static ssize_t set_direction_show(struct device *dev,
 	struct most_channel *c = to_channel(dev);
 
 	if (c->cfg.direction & MOST_CH_TX)
-		return snprintf(buf, PAGE_SIZE, "tx\n");
+		return sysfs_emit(buf, "tx\n");
 	else if (c->cfg.direction & MOST_CH_RX)
-		return snprintf(buf, PAGE_SIZE, "rx\n");
-	return snprintf(buf, PAGE_SIZE, "unconfigured\n");
+		return sysfs_emit(buf, "rx\n");
+	return sysfs_emit(buf, "unconfigured\n");
 }
 
 static ssize_t set_datatype_show(struct device *dev,
@@ -294,10 +294,10 @@ static ssize_t set_datatype_show(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(ch_data_type); i++) {
 		if (c->cfg.data_type & ch_data_type[i].most_ch_data_type)
-			return snprintf(buf, PAGE_SIZE, "%s",
+			return sysfs_emit(buf, "%s",
 					ch_data_type[i].name);
 	}
-	return snprintf(buf, PAGE_SIZE, "unconfigured\n");
+	return sysfs_emit(buf, "unconfigured\n");
 }
 
 static ssize_t set_subbuffer_size_show(struct device *dev,
@@ -306,7 +306,7 @@ static ssize_t set_subbuffer_size_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.subbuffer_size);
+	return sysfs_emit(buf, "%d\n", c->cfg.subbuffer_size);
 }
 
 static ssize_t set_packets_per_xact_show(struct device *dev,
@@ -315,7 +315,7 @@ static ssize_t set_packets_per_xact_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.packets_per_xact);
+	return sysfs_emit(buf, "%d\n", c->cfg.packets_per_xact);
 }
 
 static ssize_t set_dbr_size_show(struct device *dev,
@@ -323,7 +323,7 @@ static ssize_t set_dbr_size_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.dbr_size);
+	return sysfs_emit(buf, "%d\n", c->cfg.dbr_size);
 }
 
 #define to_dev_attr(a) container_of(a, struct device_attribute, attr)
@@ -395,7 +395,7 @@ static ssize_t description_show(struct device *dev,
 {
 	struct most_interface *iface = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", iface->description);
+	return sysfs_emit(buf, "%s\n", iface->description);
 }
 
 static ssize_t interface_show(struct device *dev,
@@ -406,25 +406,25 @@ static ssize_t interface_show(struct device *dev,
 
 	switch (iface->interface) {
 	case ITYPE_LOOPBACK:
-		return snprintf(buf, PAGE_SIZE, "loopback\n");
+		return sysfs_emit(buf, "loopback\n");
 	case ITYPE_I2C:
-		return snprintf(buf, PAGE_SIZE, "i2c\n");
+		return sysfs_emit(buf, "i2c\n");
 	case ITYPE_I2S:
-		return snprintf(buf, PAGE_SIZE, "i2s\n");
+		return sysfs_emit(buf, "i2s\n");
 	case ITYPE_TSI:
-		return snprintf(buf, PAGE_SIZE, "tsi\n");
+		return sysfs_emit(buf, "tsi\n");
 	case ITYPE_HBI:
-		return snprintf(buf, PAGE_SIZE, "hbi\n");
+		return sysfs_emit(buf, "hbi\n");
 	case ITYPE_MEDIALB_DIM:
-		return snprintf(buf, PAGE_SIZE, "mlb_dim\n");
+		return sysfs_emit(buf, "mlb_dim\n");
 	case ITYPE_MEDIALB_DIM2:
-		return snprintf(buf, PAGE_SIZE, "mlb_dim2\n");
+		return sysfs_emit(buf, "mlb_dim2\n");
 	case ITYPE_USB:
-		return snprintf(buf, PAGE_SIZE, "usb\n");
+		return sysfs_emit(buf, "usb\n");
 	case ITYPE_PCIE:
-		return snprintf(buf, PAGE_SIZE, "pcie\n");
+		return sysfs_emit(buf, "pcie\n");
 	}
-	return snprintf(buf, PAGE_SIZE, "unknown\n");
+	return sysfs_emit(buf, "unknown\n");
 }
 
 static DEVICE_ATTR_RO(description);
diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index 2640c5b..d3790bd9f 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -830,7 +830,7 @@ static ssize_t value_show(struct device *dev, struct device_attribute *attr,
 	int err;
 
 	if (sysfs_streq(name, "arb_address"))
-		return snprintf(buf, PAGE_SIZE, "%04x\n", dci_obj->reg_addr);
+		return sysfs_emit(buf, "%04x\n", dci_obj->reg_addr);
 
 	if (sysfs_streq(name, "arb_value"))
 		reg_addr = dci_obj->reg_addr;
@@ -842,7 +842,7 @@ static ssize_t value_show(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	return snprintf(buf, PAGE_SIZE, "%04x\n", val);
+	return sysfs_emit(buf, "%04x\n", val);
 }
 
 static ssize_t value_store(struct device *dev, struct device_attribute *attr,
-- 
2.7.4

