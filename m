Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B549542E93D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbhJOGsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 02:48:46 -0400
Received: from mail-eopbgr1300129.outbound.protection.outlook.com ([40.107.130.129]:27811
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235644AbhJOGsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:48:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCB2Lrv8waPS6gy7iknXEe6eT6XQf6t16hs+6bLfSMO4QPfzHMB3OFjySj3tZtJQHqdzWn9xaAqvSBQH6WVJfYx8nmmo/ZwxjFTaM/gjCccZj16DO7Wb6hoNfVOPU80By5BYL71UZvwyLtrU4DAnn6HaFe0rVDxYkPS2p7NNg0ulE/BHaBPWZmHhj9mB7luOy+7Du0hZ6phOgC6/3UURfN6EKV/NgSNHhSDvRhmi2Op/1100CSwncKwdEx3Rm+FD9wAUjaZwabOVJBACAHWeL/SStCL+Qfu3iyq2aCTRtl2AX6wHt6QmLKDoC+rl27vrsOfvxu17H8Fzg09UcIbzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJhOtf761MKRfT1rnz9yQoH0Z/Et2OjkQT0Z0Ze9ODw=;
 b=MJqyW6OvqiJks+8B8qvXtyU0DYMKZvYBhbWOqV3JIorFFflADVINdCWQPT2z1wJQnr89UwzeBN06z/7GvtJAS+zxzYKJ3aPNhzz3Ig826mmjMbjuXa3FpunQWTaEWkrrMW5jCpzcaPN/mjRCzx1bTFCNozh11oxhzsLVz56+kzoIu4C1ZbJg0cxyPuA+aRBg38/6ryBtWM4/I1zngz6pVKscsZ4iGau7w021i3qqf3wvxqtenCrn85B+BJsSZ/TGsuXP+YH6Q0UzSyIU/VN0ISIr+1aVa9P5BcWY3k5C/oQ2Ybdus1YH4giaypQMxRQDvXhpBqewB4oS6/XDn2TnPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJhOtf761MKRfT1rnz9yQoH0Z/Et2OjkQT0Z0Ze9ODw=;
 b=BLqGFp9m2l6YXpUVQZ3wp38sjMlDRE8mVKLxXC/7kAG0jTO0uSM0do8eestlhG0GI1dXahmHByIOQNcmWKjl8lcxLKZGSQFUAegbmhs6iSw+MvXdqsshUytM+L6aFKf5n2pKn7R5bb17as1DkzFRX+pos3/ghSERRrHTDLO+wYI=
Authentication-Results: s5r6.in-berlin.de; dkim=none (message not signed)
 header.d=none;s5r6.in-berlin.de; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3147.apcprd06.prod.outlook.com (2603:1096:100:33::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 06:46:29 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 06:46:29 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] firewire: replace snprintf in show functions with sysfs_emit
Date:   Thu, 14 Oct 2021 23:46:14 -0700
Message-Id: <1634280374-4200-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0084.apcprd04.prod.outlook.com
 (2603:1096:202:15::28) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR04CA0084.apcprd04.prod.outlook.com (2603:1096:202:15::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 06:46:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17bd74f9-072b-4334-ee75-08d98fa78473
X-MS-TrafficTypeDiagnostic: SL2PR06MB3147:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB31472539035B588D13F183B5BDB99@SL2PR06MB3147.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45PHAcDSYTpy9E1Hd4EnA4QIrelgwYPExcmZQc+Ks3zyC1PR1AJTYn/C5sTXZtST0PEolS1dVR/FN8pkqIFtU0Zw2qWZxbYXu9j4GYmE+jih9/17OGAVIHNZBH6Pe1PLQGD4lXevWqtkXMV7Js9aw11+nu0pE6kstSoEvZIMZrPqQsmNCacLpFeG7eoyWrZdlV04R14R9XFxa1fyfZ24ftJcdkCFBaDN/ohttPZVNCyUpL+UQzS7WM7Tq20A9D5HuifcagOlHRhtpM5wxN0B6XA/Y4qYbJvzK3Bfvs9mb4PC86/Wh8yWbcjE4wXHlUkzTwGNKbUDgSBe43TLhTQbBHATnZi4oEfhf0PNhP5Z4TWpmvx9drEoVrZlwKXuftsHaMPrFPFCcMZgUSVWFGEMuEix/zc7+/y6+/psKDw5vyi3oVy6POjaFyDY2jLbXnxSRA9RevqnQwTaizg1CG68xAOXh5LkwKZcqy6x+pRLTPnp/quY38CoF+jxKdS9R4wqy6/Wd4ym/wO58KDKiMywzOVdtZPcHu5KB+WP550QrbkSgkyT0qOyBpsAJEM8Bc2NIwCUB9NT/rPujUPBA6dQIkebOfYIDOD68eTDvmyJqYTniLWLsXopnefD9l3ANngSxXV9v8okHbZAsK4M4VANH0FJISlC1BGR9P65ikZHSKIqVJhEdcOJzk7conCjIDkeonmlbkoJjj3icXK95zTq7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(83380400001)(186003)(107886003)(6666004)(4326008)(508600001)(52116002)(8676002)(26005)(36756003)(6506007)(2906002)(316002)(86362001)(66556008)(8936002)(5660300002)(956004)(2616005)(38350700002)(66946007)(6486002)(38100700002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PfEyKM2HRtwoh07ZGyt57XeVtY8LHpNmiWEHJfXUtMttvlcLod5lmPOZ2Zag?=
 =?us-ascii?Q?2tS4j/xosjUDiMOSwWFy/3AvwLaYzZ9dGfBxG4FUEZKNhYjZt356M8nsFTDg?=
 =?us-ascii?Q?cXdyqKBiENTBlFC7C8ipFqBkGGK4VSvqoBsAu7YDY00BuzonGA14eQYQBml6?=
 =?us-ascii?Q?ihikzNHEeLMI5+imTnJyYnPO0VCzxi2sTBWPscwg7F/Xe6hzygHaiGHf0OaM?=
 =?us-ascii?Q?aWIEHB2fXkxN3IHYIf4Ths6KfI06ih7xs1e7cSUvl1Tq2wsn0/Nu7TXkZc5I?=
 =?us-ascii?Q?GAPQUjt/saSQnUGYuByVBKg1S01HFYmMUy/h3GfZaQJwoZZIH+RfY0G/bWxe?=
 =?us-ascii?Q?nyOJweYyPiUFwTY8FNGkUpJImmcjVzg4/AjKpZojGs1lnnQzTXYLL1IyOnes?=
 =?us-ascii?Q?B0S0XEFb+UMHRtTSA66981Q5guJjqE9XXPW3tRCFVkwoHrTpQE79i7U+g9RX?=
 =?us-ascii?Q?LugfoUyAmKhmZQnBPBTZx6B8mflV/S8R6emY53OqN78XTUlS0Gx6aZgJvn8T?=
 =?us-ascii?Q?zTUOYjz810t0msTLBliSicw4EvxCrq46CGMwQvUjgpOv5tq5SjhNzdqZfsFk?=
 =?us-ascii?Q?JNWGnz0q2qRd78/QMLz3h/opZDSeXUjZvlGCVKLDmzkEe+oMy0a+jvK5tSz8?=
 =?us-ascii?Q?wkDewVGGvYVrxPypz3Rpzsp79HcFayUhQ8Ue+BZCsOM1n/kNMTPxASlZROpg?=
 =?us-ascii?Q?tjSKOjVzYNaFDfUwNc4LUs+mqM66qNqe94lWC4hZj+yv63kKFEympMb7stWO?=
 =?us-ascii?Q?z67CEoK4sAR7tmWnRKvqgCD2rFaIDBzkQgoqddbxZ9fvV4L/GLPqo0f7KB1y?=
 =?us-ascii?Q?GW30CI76HGPiR4E6jNxZsBzRbd5eI4xIR7m7varwGq2vVVfrZGzqgYDrID+Y?=
 =?us-ascii?Q?Bti84Ht45AyLGRoIjS6pdG5efZnh1DYz72JAHziyypsLFseDp3Hm51mFxWAl?=
 =?us-ascii?Q?bLF8SrPUeq8LThY6sGqr8X4o+yZ3Q3s0/OmKE6GJmKnuj6aZOOXc1FTNW3IB?=
 =?us-ascii?Q?3nQ0WZPavB2Cx53PKmS18oML9ioXNcsa0y4i1h4WzYgVV8TEgQXxkhvgO3gn?=
 =?us-ascii?Q?Ct+770z7CCMWJ+oipkFOmh/nWwl3Y8i8mYf2uZPOowBbbFKcgM3K/1fpzobB?=
 =?us-ascii?Q?PNU7sO7OwaypUonhtokR8nNlitG+RMPGQq9i06TqnXE+A1B3+p3ZRlMawsMN?=
 =?us-ascii?Q?Of29HA2QaKN1IjIyqkZc7+JPTOuDuA6DcSB2DDV0Bf84jNw+IUxmOMpJSDp+?=
 =?us-ascii?Q?Qjx9pAEBhhEDVsm+jpL7IpHR94EJnmkA5BaTux9glbuxZTLcSS56GXFeKAq/?=
 =?us-ascii?Q?9CAGsOfjQvN+nf4Y9fJrIGN0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17bd74f9-072b-4334-ee75-08d98fa78473
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 06:46:29.5765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/hMm/C9PwtsRN2D4W4Cns/hgLtysMxFdDUcupn8B8iLWWKbZ7ttrZl20o9xaLEVsO/HDU8YPwcF/FStMfkfzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3147
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show() must not use snprintf() when formatting the value to be
returned to user space.

Fix the following coccicheck warning:
drivers/firewire/core-device.c:377: WARNING: use scnprintf or sprintf.
drivers/firewire/core-device.c:408: WARNING: use scnprintf or sprintf.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/firewire/core-device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 6821698..31b9e50 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -374,7 +374,7 @@ static ssize_t rom_index_show(struct device *dev,
 	struct fw_device *device = fw_device(dev->parent);
 	struct fw_unit *unit = fw_unit(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			(int)(unit->directory - device->config_rom));
 }
 
@@ -405,7 +405,7 @@ static ssize_t guid_show(struct device *dev,
 	int ret;
 
 	down_read(&fw_device_rwsem);
-	ret = snprintf(buf, PAGE_SIZE, "0x%08x%08x\n",
+	ret = sysfs_emit(buf, "0x%08x%08x\n",
 		       device->config_rom[3], device->config_rom[4]);
 	up_read(&fw_device_rwsem);
 
-- 
2.7.4

