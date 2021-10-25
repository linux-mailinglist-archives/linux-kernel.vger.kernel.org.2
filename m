Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2B143974A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhJYNPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:15:42 -0400
Received: from mail-eopbgr1410112.outbound.protection.outlook.com ([40.107.141.112]:27280
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233470AbhJYNPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:15:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gacxbeI92yH3SWeHoZubF+aeCn9FhrAwKXCwJ97stmhMvuBifQpSw8HU7E4gpg3oQ7cmwGDocAQSg56t86vCgto3sKBUYEDW9qHgnqaZ27lzWNv/6nySUjMp/EtGnVFGSRdVWOcBSx6ORyACBRSLdf1EcYMafzUpiX9/m0mMMzRXFFTj+zxzJ29c/OITfttCgYUJ5xOP+1t7z+rMHKiZmBAyWFUH9KuK/xWor1XZPd/nALb/mit6q0ZE2n0JF7p8xOuQA4p2lZJfe/dISMm3Idi9yJ8FVZz1YCpXlfoRkd7oVvTNqdyjC/XtFarReQMhnPR8icBm69Bmwz2u5hdFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dd4yYtuhBt2EXZjoE6QQGgOX60RAmE1oaFDgeC059/8=;
 b=mKqu2+hIop9nTQN5+VwOQKfIr9uKPaZ7B5MTn4zeBYQ0MaDcNM4e9sl5rTEIfW4jvBoj9sgsImx1ot5aEcaitFpQjYK0PxftgDaC82J5exHVSAGkqP+zjKbU4CMWnq0Un0RHaXhFsmxcdMpyYYf/4KbbIuHC5+WxJ3aOoJbppdsYZnTRxDb6NTjVCz4McYzxb4BJJPLjWSC2XuvVzFaP96Xx8FPqvHHOIAV8JOMeuymGzeHOy0ovDTKzzXEptUbV3KsR43Qo35HUhLKbp9wXxc4w5dWJIJcrmAO3CZAXT8giGWMgrsqvUeNDSbreD0ZZPi/t1SWrWA7g/GjcjGaD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dd4yYtuhBt2EXZjoE6QQGgOX60RAmE1oaFDgeC059/8=;
 b=QQcGQkeUfijrbdSx+pqqXvIizKXBxR5XEFCwH90diag688aTNhCLMGQEMcl8Lj0ZiQgyENjzg9cwaDR5HOAMH2v7YCvyvb00MV1+suHd9P0aVcmkv1FBnB5N9BwrksJQebV58+ylMVRgW/3C0HSthk1gIMXB8a2UC6lSOcEXYD4=
Authentication-Results: opensource.wdc.com; dkim=none (message not signed)
 header.d=none;opensource.wdc.com; dmarc=none action=none
 header.from=connect.ust.hk;
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYBP286MB0016.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:802c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15; Mon, 25 Oct 2021 13:13:13 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%7]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 13:13:13 +0000
From:   Chengfeng Ye <cyeaa@connect.ust.hk>
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-kernel@vger.kernel.org, Chengfeng Ye <cyeaa@connect.ust.hk>
Subject: [PATCH] driver/ata: fix potential null pointer dereference on pointer last_sge
Date:   Mon, 25 Oct 2021 06:13:04 -0700
Message-Id: <20211025131304.17226-1-cyeaa@connect.ust.hk>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:b7::8)
MIME-Version: 1.0
Received: from ubuntu.localdomain (175.159.124.155) by HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.2 via Frontend Transport; Mon, 25 Oct 2021 13:13:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c8b7409-6204-4405-d248-08d997b93310
X-MS-TrafficTypeDiagnostic: TYBP286MB0016:
X-Microsoft-Antispam-PRVS: <TYBP286MB00168B80DE26616F99FB495A8A839@TYBP286MB0016.JPNP286.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VBXXsz5oxPjfteigc5v7avKgQtSgNFBQ31caN4Ys44EQTAqADcXPCb75ZNgwjuqtGPmXBhv9AHCK6lpsPZDNa/Ib0791OKDNpA0h440W9Ok0J3iliFLBl4ivH4agmtxlC0bNKOGky6/ySr9uLoM/xS7fmobPKL9Ct82zmROo9qr4TtNC2EcaMmC1dLmyxghRtemAskuYXexHvc8ccZUWUZRACWU78BBcv+mdl1OgzMr9eL0b46Fr2U4dFlZ6WxUp7nOjx7812YS4AQCyPg/uMJgCS5Y94M63nVcj3YdoStRUDeij4zqMH5FArMxKiIEqVVcEDpxfH+ZVWStrwjwHmhxhr4XAHgpYTCljK/oTvVS1ONrKAosTpnw9LssHuh4Es7b5fFntGqfFfRsOK8UDLi7uyEZQqSSa6EH5+lnG3pKyXaO4bqa98P8HIs1gOHKGCTJxw6zcpm7qF+gADFbIJfTXyFzQRPVFJMNemPLojJ2+foItUgwcCIcxfpd5WkDrsLots4naPmBNs+vczgarPzI6ksKzWHeGDnN3tuweKkOiaQiknHpYE+rgwdbHAQbZa/bspCETbMmKALZ35pTzkV8cRJOalQ0ovJ6ju6BALuKE29CNVWSjubJvMy5V397fZu4THHEsqkHPdkFDqMxLazRJwjiBR1GxaZat4+YuDNxgQhg9RApm+GjQ9zvqGFjU78zZfa2ScBNM1eFP8TlT6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(1076003)(6666004)(4744005)(36756003)(107886003)(66946007)(66476007)(66556008)(4326008)(8676002)(38350700002)(38100700002)(6486002)(508600001)(26005)(186003)(6512007)(86362001)(2616005)(956004)(316002)(8936002)(52116002)(786003)(6506007)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HbAZS3sCK9PsMW/zwHeXxOcAOPDqnh6toZbVoyc3ORxQSCUTXM86QQf9CiwC?=
 =?us-ascii?Q?7aFh2z6T3GDi1v8p/BQvkASglUgDFPiEZx+B/INLWMvu3qBglJiNXwXKPikl?=
 =?us-ascii?Q?X/6bCn0nsfrCwJscgcWAirrcG7wbOP2tinKdosagXXrHgnd/smQdU/kp0c/F?=
 =?us-ascii?Q?8RcH95fa5kk78xXQeWxChfOHnpuEvDbsbjXfaar98NQ/FvqLIEEgkLXiYA2Q?=
 =?us-ascii?Q?xLbk7/6b1YYvsiFMsKY150xQWkzIRne3Q8kL7YsKebXpvDaJpWokXPuf9eA5?=
 =?us-ascii?Q?pEPSwxiM4GqyGVxcc+wlyG+zE4sCmS6DOCLbd/OtpqzlbNCK7Mzy4yYpwnUg?=
 =?us-ascii?Q?51yCo6VYajsRtV2Eng5HU14q7I+yGspdhMmIKlDfMzQ+cguBfoD2MmbuuMIw?=
 =?us-ascii?Q?NGmjj1mwOYG5bYl8oOcUE63TQYM3/8RdSFqLklirrD/pDbNmZs0TDqfOoImr?=
 =?us-ascii?Q?njSpzlqGUxrjiCSwovGl/hmThvgQdOPWCx+yoN8YNTtl3H28hF+ahPH+Uudj?=
 =?us-ascii?Q?2jEVF7sdNd4MWXFpm/z9tSRNFzkHpsQrvprZZJlXZ1CJ32o56Lqd5uKsfWeg?=
 =?us-ascii?Q?5XNcASa5mrmVLr+T04KCyr7s3pv5Xk4GC16MKJdH1LWKu1kB/Jk3sde4eelZ?=
 =?us-ascii?Q?vs7cJL8UnBp5ez57LCHIbtdU6z2Kr8HJao30GYFQdgVqe+shKogcGv4OfFOO?=
 =?us-ascii?Q?9BelHMeKrzumR5Vgc+evhbAfoJhHbTAkodRbjMcm+Ghez+XM6yTGUhugEJsY?=
 =?us-ascii?Q?NpNtuIqPnD7w8dlZhZpykO3g3/NUeINmOMjqTB9I7v/UHFae4soEoO3qRfmH?=
 =?us-ascii?Q?0ZjYuISqCZUDVMprXVj2gPVRKVGbajeU3nRcgo+iAyAJdP4iUGHaXXfKHU7o?=
 =?us-ascii?Q?3lwdtpDxT2+PDIxjWtTK+XMFDCCXUtr9OE1FWPBX0D4Y5ZJzu/Gcmu7U2Hc3?=
 =?us-ascii?Q?+9nISfYR114SSZcJOFFMoOo6bzSMnPqoDkDElXIdldvRKMccnEVSTwvfMWRX?=
 =?us-ascii?Q?CrwuSlgs0XFHS0jrlGe5Rrn/TyLR8X5vkfQI82t6Zoz3QezywA7oZLlwYaOe?=
 =?us-ascii?Q?7Eg34Hh9g67tFWudRFOvRJqbJWFom7YXfwXekY3rgW4EM24v7fUo+S+rRI+c?=
 =?us-ascii?Q?iUwevSlbiiiBjB8AFhBKkp9+0rh1+ESwYAEGsds4D52iiLgOZ0BgF+D0tTI3?=
 =?us-ascii?Q?COt4EBT0O4UCdmbNDDRbPc6gIdxzwG9N/J0bBVdYh/WpLdTpiClljLRQXR6d?=
 =?us-ascii?Q?9icod36tv4Xm/oyS4nOUCwgdw9UJz0dJscwDPyTSreIVz2yF9zEsx9CC5fSh?=
 =?us-ascii?Q?htyUsgLbgPXfaTATcfLNBA7wTtVurwzPlYd9dMAoMtUSI4tfJIM/U0P4Kjnl?=
 =?us-ascii?Q?QWbo/0mkIzpdDCn982wP3qfGn1+XysPTGRBiJ5DP4urekr3QlGu+h1z0+P5J?=
 =?us-ascii?Q?dVx7ZJcjcBhFhlrob1K5TG8k7g++RUSgKVi1GXhcSFZso3BT5QeYDSjElKAZ?=
 =?us-ascii?Q?oCIIjnCw38j6tPt74YWHnorP8FIQAmG8qZZchOTMfVoeKwxfZJJjf5RZHjA0?=
 =?us-ascii?Q?e5/FjddcWwP1jYwQkvqqAM6ZLW6OtBwsOUegxJwqRFeMBSURqS4evCui0Y4S?=
 =?us-ascii?Q?HRL2UlML+jphi5yW6XN8r+g=3D?=
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8b7409-6204-4405-d248-08d997b93310
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 13:13:13.3937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xED4h8ahNAhWowSgvotbZrSvhjWcL1Ni8O6YMTSKZ2+TzdYh8/CZMYnwVktdUM/Lq19k654LuZjk0sgX2ZWoKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBP286MB0016
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer cs_desc could be null if the loop is not
executed, so there is a potential NULL-PTR dereference
issue. Fix this by adding a null check before dereference.

Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
---
 drivers/ata/sata_sil24.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 06a1e27c4f84..2bd595da799f 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -785,6 +785,8 @@ static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
 		sge++;
 	}
 
+	if (!last_sge)
+		return;
 	last_sge->flags = cpu_to_le32(SGE_TRM);
 }
 
-- 
2.17.1

