Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E4D42E95D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbhJOGw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 02:52:59 -0400
Received: from mail-eopbgr1310112.outbound.protection.outlook.com ([40.107.131.112]:13952
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230032AbhJOGw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:52:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjkJAhIxF4QSeH2UnJe0gLXwW9z0n6vAig0VSX+LrY7R0o8alwGjgIUzBFhexhwztfO8G1B1fJ2PgaehvPAkTrP6a5feByb/cZi+cVKYXNjzc1AaID1HFQrkQGyBv4GuPkhL0r7d0om/etycAPeTaeiJxI8AOGpJTjiftahxK7bdO3jHD1roI7ZtGFjVQHXyXkAdJ9LbzuF4JrVfcMINxmV7AemXPbKb2QJGqeM31sE8xhNqQ/YPwT8tE8HPGXLcLb5gr1stjwFZVtcekUXDc8o9eeBCpoAo+hA3ksTGsdFlSSBreMrJZoPbnVFVIGpR1rMI/c9ekGh4YCCFQsd3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoZXRMgjK2qes3v+KfnstBwfAnZ9rlUPO8w8h/YPdUs=;
 b=OLrOBeL1uDw7Zx8lrvrZu2amaTeDbLyrJQQS8GzCzf5SE6u08sSerV6OdR3pR1wlDbIHLdHBt4T1Xi27NztM2EkbengKBtgdxq9HFkiEdVjARb2gB048H1sJb+OxaIj1p3bCLg6I+LDwIiMuuq8tK/ikG9GreeW2YChpOzzvFsT9zdsO9lTPCFuNd1kgZXD+bssx7PXp4xgSWZHwz31T2MTaw+OQZjHAaYdCMkiHaKrdzTbGLxaMFx1eaB8uo0smgdeRlmjS11ynq6NrzlTYBFjUIVC3mF70+877JsUNoBcaDRSBIWgh4LUNWRSu7T5tvDP/B+t4h8GT0C7c5TZKfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoZXRMgjK2qes3v+KfnstBwfAnZ9rlUPO8w8h/YPdUs=;
 b=CfGoQt3NzYiK54R5CuTYsPZN3fSwFLBhCCSb+0xgEy32pCfRzU+hiBzxIz8CNXBII+N4haFCp8/iX+Qg38DgnEWJrv0yFULTJCp2N+B5j8r9eevo0JaEYjCFjLQmVyKsLttweqAFEx6F0I91hzT/3sezNg+FvKuqsZyTfk6/IxY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3003.apcprd06.prod.outlook.com (2603:1096:100:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 15 Oct
 2021 06:50:49 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 06:50:49 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Kenneth Chan <kenneth.t.chan@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] x86: replace snprintf in show functions with sysfs_emit
Date:   Thu, 14 Oct 2021 23:50:40 -0700
Message-Id: <1634280641-4862-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0172.apcprd02.prod.outlook.com (2603:1096:201:1f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 06:50:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3cd34ba-f81d-492b-530a-08d98fa81f61
X-MS-TrafficTypeDiagnostic: SL2PR06MB3003:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3003EEC0176135638048990CBDB99@SL2PR06MB3003.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUzeD4lMsqsSZmrPCxFQv0UDaW7W5DQhN3VyF71n/EyF04RL+0Nc01cIDMKE392EpXFDFgWDYBHXDiMJ+T7U2nMqbG8KBetoiBkZGmZnZu4LqTLVO4W6LKRLP9mswoHYjEgl5UC9h/ZBBpylOSR7TJlmInJP0AHpU7gGaqt/azVV8qNby5FotORr9pEwXCx3eERJVGIxRpFWo4qw92MGV7Pul0qT+DWTS0UQqK0LkeVvTFNWgId132KqVJUidWkRFxQ1ebVL0NsQQVrfIK9HT3K7yWGizJXklkd68QYaEctPaQLNHCEPmwBccYtN7TuEhiNhVYGeyHdpdlGYRhBA1edj2MxoVecYqg7hRTzAh+r6QW5NgE3Td3gBinjE8GA+/EzvdegEfotzZQN0N20pwiRDm2I6qQsTQ2R2HQaeGgCDzEatf5i/zd3dWZcavEZtvRw0qzOwVK6W8WRCeVjw1TX3XXh7Bkaqm14RZCbN59PQbk7Gb74xYCMAmzBxuUXdheepmVv3tL0BRfDgM8XaC/5xxldqaYiqld/m3tU1RLcznyZ+ZtYxG5q+zTJzlw++Wo0dEJW6Yt5u/pMzzYSFXk0BiArEn0FPLgeVBKqU2xV2wFi8lJjYlzZXdr/O8zi9mEeo6lD+gadG7yScK8ng3JZrQzNzdxbajMBkBxlq/H2UvtXlswL/pDfcshQrrHS/AE1HMdQqctDhb/GyRnsxcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(5660300002)(8936002)(66476007)(83380400001)(316002)(2906002)(4326008)(36756003)(110136005)(6666004)(66946007)(86362001)(186003)(956004)(2616005)(107886003)(26005)(6512007)(8676002)(508600001)(52116002)(38350700002)(6506007)(6486002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G27mQ7JcKGdZOpxKBnz7Kq+t/qow5yOecNUqT8kHySzpD0/x1JOGQqfxLA47?=
 =?us-ascii?Q?1es+ZZIECCGR/iWOsO/HtyV4xsr4kzTtaIwDmj1Doh38+D2GSCW+vnNWXjoJ?=
 =?us-ascii?Q?Dwm/krX6bYVkjLtNoBOCy+6Wgm9pQL+5oq7NFZAq/od7GH6qePoiJBg8CQz+?=
 =?us-ascii?Q?ymZ0kjqjFAv3g99DvbwRKeLQfliRKnlI5uxCfsPwrk9VyDw26YLpioxpon/G?=
 =?us-ascii?Q?zYSRBBkftUxJWjworNbGecyljkjjDQZPMKf7p2EV1x8onV8NdODLAROe0TI5?=
 =?us-ascii?Q?g0rzGjjwy28GGjTLQMYwVhzNZjOVl6nq4n63yHZFz+a/Hqj4UV1TDXFNUcwP?=
 =?us-ascii?Q?ZvtaXp1TJTbkFID2lzP4aSU1OffiqlryoX3LN96kHUcL4apmbM0k1iFKEBOS?=
 =?us-ascii?Q?GtfpPN0THk8IPSrM4384MRZceo0YRWzzRuHfTyIgnvAI3cj12uPKe/vqVASg?=
 =?us-ascii?Q?MhxpMCNY1qGqKHECKg+GU2jB2meKUK676S1haOe1Upnzr2XVnq8UTQYPv4lp?=
 =?us-ascii?Q?tzHI7oxe8jn+XJ0vPWYFrY9X2qsqRHHLGwBPSAE+J1kQ1Gz7xncUZr2XRjdt?=
 =?us-ascii?Q?mxs4ZE0Krnkxt0CYuwMaFTOjZRwoI99YsmptfcTtNdN4/lJqVTZkKe05c1yA?=
 =?us-ascii?Q?/AuBcngnitW6aNmJ/Rohyht01MltzBA/uuSmwxKbL+uU+ikwq8LM+9ZHpfg9?=
 =?us-ascii?Q?4BdbB0VyPQ6R0Mjad9qXcePCmKfWje1gAOIeClK4j+pQBloEjwNQHcCQp/kO?=
 =?us-ascii?Q?dOloCO4dyZBXwrcgb8ve2EUpaOL+YtDK07ah3twTeG2pj+TnXrvV87R3xRTi?=
 =?us-ascii?Q?PDF4gtiY6QKfFUVlkiPl9iiegBNyfR6pWOLAB95A3FspN6CKmA7DIDrCP4hy?=
 =?us-ascii?Q?6oAlLOHHKKw4lQ9MO8JD2WEB2p2YB4vrS4bRjznvFzOv2jqAk2QxH7QZXIu9?=
 =?us-ascii?Q?IG8aWa0hapizzvFpHs6gKAgZEh3XFS4QdRyp3qV5bNcXhKiuTn94KSrjwcwl?=
 =?us-ascii?Q?osVizR+deSyLMPzSS7/xIKhwAYa2RiOCBSQkSRJxRNMhVK1BLhGVCAvw7Lqd?=
 =?us-ascii?Q?3uTEKKRA4NNus4imzMH0YF9FbjczSb4AV9PM+4B107eC3mT7PkRAZgArKtDb?=
 =?us-ascii?Q?fjMeDXsr8QLoUS5uAhnCxaBzs8z/Lou+/Nb5U6ht2gARyQlCGkRmVEy9j0p2?=
 =?us-ascii?Q?911E2NNL/OzGBb+NkIAiyKE5xjMH8W5bwiwdvRWSLZw0P1JWL2UwS/MrvGw2?=
 =?us-ascii?Q?GXuHOl0x2Sq0lp83lM89cvQSU0FHotOU55DQdYWsTiDAyzsPpZY+mOpW8hwM?=
 =?us-ascii?Q?5KDFDKsI0ZuIQXmbR3y3sGa3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cd34ba-f81d-492b-530a-08d98fa81f61
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 06:50:49.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUdbJAJz77fwzM1Fk6a3gOWk1Ntjb30BIXhjBo597IZkQwnQ8JXGwnQeWnPQ/TS2U3Wy1VBfVuD8+1m7xepXnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3003
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
 drivers/platform/x86/panasonic-laptop.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index d4f4444..37850d0 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -470,7 +470,7 @@ static ssize_t numbatt_show(struct device *dev, struct device_attribute *attr,
 	if (!acpi_pcc_retrieve_biosdata(pcc))
 		return -EIO;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_NUM_BATTERIES]);
+	return sysfs_emit(buf, "%u\n", pcc->sinf[SINF_NUM_BATTERIES]);
 }
 
 static ssize_t lcdtype_show(struct device *dev, struct device_attribute *attr,
@@ -482,7 +482,7 @@ static ssize_t lcdtype_show(struct device *dev, struct device_attribute *attr,
 	if (!acpi_pcc_retrieve_biosdata(pcc))
 		return -EIO;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_LCD_TYPE]);
+	return sysfs_emit(buf, "%u\n", pcc->sinf[SINF_LCD_TYPE]);
 }
 
 static ssize_t mute_show(struct device *dev, struct device_attribute *attr,
@@ -494,7 +494,7 @@ static ssize_t mute_show(struct device *dev, struct device_attribute *attr,
 	if (!acpi_pcc_retrieve_biosdata(pcc))
 		return -EIO;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_MUTE]);
+	return sysfs_emit(buf, "%u\n", pcc->sinf[SINF_MUTE]);
 }
 
 static ssize_t mute_store(struct device *dev, struct device_attribute *attr,
@@ -524,7 +524,7 @@ static ssize_t sticky_key_show(struct device *dev, struct device_attribute *attr
 	if (!acpi_pcc_retrieve_biosdata(pcc))
 		return -EIO;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sticky_key);
+	return sysfs_emit(buf, "%u\n", pcc->sticky_key);
 }
 
 static ssize_t sticky_key_store(struct device *dev, struct device_attribute *attr,
@@ -566,7 +566,7 @@ static ssize_t eco_mode_show(struct device *dev, struct device_attribute *attr,
 		result = -EIO;
 		break;
 	}
-	return snprintf(buf, PAGE_SIZE, "%u\n", result);
+	return sysfs_emit(buf, "%u\n", result);
 }
 
 static ssize_t eco_mode_store(struct device *dev, struct device_attribute *attr,
@@ -625,7 +625,7 @@ static ssize_t ac_brightness_show(struct device *dev, struct device_attribute *a
 	if (!acpi_pcc_retrieve_biosdata(pcc))
 		return -EIO;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_AC_CUR_BRIGHT]);
+	return sysfs_emit(buf, "%u\n", pcc->sinf[SINF_AC_CUR_BRIGHT]);
 }
 
 static ssize_t ac_brightness_store(struct device *dev, struct device_attribute *attr,
@@ -655,7 +655,7 @@ static ssize_t dc_brightness_show(struct device *dev, struct device_attribute *a
 	if (!acpi_pcc_retrieve_biosdata(pcc))
 		return -EIO;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_DC_CUR_BRIGHT]);
+	return sysfs_emit(buf, "%u\n", pcc->sinf[SINF_DC_CUR_BRIGHT]);
 }
 
 static ssize_t dc_brightness_store(struct device *dev, struct device_attribute *attr,
@@ -685,7 +685,7 @@ static ssize_t current_brightness_show(struct device *dev, struct device_attribu
 	if (!acpi_pcc_retrieve_biosdata(pcc))
 		return -EIO;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_CUR_BRIGHT]);
+	return sysfs_emit(buf, "%u\n", pcc->sinf[SINF_CUR_BRIGHT]);
 }
 
 static ssize_t current_brightness_store(struct device *dev, struct device_attribute *attr,
@@ -710,7 +710,7 @@ static ssize_t current_brightness_store(struct device *dev, struct device_attrib
 static ssize_t cdpower_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", get_optd_power_state());
+	return sysfs_emit(buf, "%d\n", get_optd_power_state());
 }
 
 static ssize_t cdpower_store(struct device *dev, struct device_attribute *attr,
-- 
2.7.4

