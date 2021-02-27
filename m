Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C716326CF5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 13:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhB0MEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 07:04:32 -0500
Received: from mail-eopbgr1320085.outbound.protection.outlook.com ([40.107.132.85]:60950
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229863AbhB0ME2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 07:04:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEdLq0HcL6JmGK2ks1NjcLRi8BP8jgFfJ2wcDpRluIm4d6tCGXeMKsVC4aU/GLCx2sNiofeHECjUxuh6UC8w/G48T+qdPvG2MKFCt76Sn6TYCSkc+PTFo+MTnfvBeepWQUAHZ5vRoB8B9ij4gTSBUdTPEVNfYx19zPIyEP0/PuAhTLOT78HKCzbAwyjeDWJmitELOK4pbx8fBpSg46VOHoBYbmAxk1ImVZbKZQYCM08ZFajc1J0p5d4ak0UI9ccxlj03xQTNvRjE0x2lkmxtyUpX/6WC02iscBjGcg1gsKsQEgPMhG3FW4ERPjo9oXhBzfKw0YCPgTZHMBsZDVBSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5gyyA9UafUZZn3rgNOlISM4lxMDJTYMBtDQLr5wPRE=;
 b=TvfUqqOjJhL7qa9sdpK8JoDP2fcOE9ED5Lb5Uq7iqHwD1r3U3hpKZY7CIft0S2Ll0wqesx4CWQNS5wLDme7uL5+0UgHRXEAweG3mtJTMYlDJ8T+NRtKERRWsQXyRq+7hg1gcxUekJO48yGy4mKDhYEPqjkiCfxFBfalODAi/x8KhbCiN3SMBGKlTnSv9lBCJituC6fSU4ZElV+t8Bqb0qfmTsbbCb6aFacNrfzELkXfTST0aMbmnGgiSgNPwPCTzCDNhdi1XXC6El8tOT9SmVLdxR7gT4H3uqVnlPo4w2xGaJiD3sVE47An1iEF9F/yEGdVgPI21hd++kj4cm8waew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5gyyA9UafUZZn3rgNOlISM4lxMDJTYMBtDQLr5wPRE=;
 b=RaInpQFvVBKwLhdfAooNZDzKUDR9yrCZzdPy+Y4Obi7Df6Oxf1EBEmp5+h19cutBlt6/cFvKNX/Yt/TUyhESCCOC4lRszKlHdsS/wxwMKoz8lBqiy8YPN/AgeJf4UWVi60xHl9Lsp1hzxmogAODcw1ld8zAwx3ojP5PUPdrSylU=
Authentication-Results: lists.sourceforge.net; dkim=none (message not signed)
 header.d=none;lists.sourceforge.net; dmarc=none action=none
 header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3369.apcprd02.prod.outlook.com (2603:1096:4:43::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Sat, 27 Feb 2021 12:02:47 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3890.023; Sat, 27 Feb 2021
 12:02:47 +0000
From:   Huang Jianan <huangjianan@oppo.com>
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     huangjianan@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] f2fs: remove unnecessary IS_SWAPFILE check
Date:   Sat, 27 Feb 2021 20:02:29 +0800
Message-Id: <20210227120231.136559-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK0PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::14) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by HK0PR01CA0050.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Sat, 27 Feb 2021 12:02:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f78c9e84-9818-4621-7033-08d8db179938
X-MS-TrafficTypeDiagnostic: SG2PR02MB3369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB33699BCA5114498961F0F5F8C39C9@SG2PR02MB3369.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUeVD6gH6mmta5lAKZuQ7SD4hnHbaR7e8VYOUIPEM1YfscGAOXm1T6ZhUmixGBoztUZGinzK7FgUVnLj4ItIzyWIQcFdiF64wTet/RUs8r/153u8TFMOGXHKcmuBxKW5GCup6W5XAiy5GcUiG5XaNiJF35ecOx0/UQQqR72JtvkyZ4joEGt7K1PpKxVhhKSln9HrrOTNRAZm17pTg3biz/N6uh/Fp7aX98mfrozMDZBfWzdPaYx2RD5Y+eyApzLVaBn2a0mV3lfaSy/SSiAl42YXYLedP6Evsg+CBFMbwMaV5g13oxJJe0/KhUBgE1ok2wPRW4QFFY68NcCY2FOMgPOoGdf6EfjohQeftwerHnWECwMrZOMHPX8T5p/pe7H26sdkuz83qYjpro+VPkjHPQMfynISy/BORJvbOvx5jxc9APWHwDqt0cv8YsXIDkSyR18dXzNxKFokmJwpn7CYQrLmY0drEvjrM8nv8cYTnsD+/hjOmxhyPElIrFApIAbbY1N6ALbE77lou47NA433+FMVFErl8hoiqm6tqEUZqUrhb283IrZss0k9KY95d9gpDsiEtBdXQkIBBbJHCkC54GuQHi1aatUtLfQPzCTC6CI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB4108.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(396003)(366004)(376002)(66946007)(83380400001)(2616005)(86362001)(956004)(66556008)(316002)(4326008)(66476007)(52116002)(2906002)(8676002)(6512007)(16526019)(186003)(26005)(8936002)(69590400012)(36756003)(6666004)(478600001)(6916009)(6506007)(6486002)(1076003)(5660300002)(11606007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZZgpgqGNqcIPXG+OpmIOq+KO/9NWZtEkmDrX8erwMxyMaBHitDdw6YLVKG2v?=
 =?us-ascii?Q?VOnMxIkQjmuDdt5K/vDT3M10BVMqA8Ye8V1xOvEf7QZzg4qqUYMMdliK0Xng?=
 =?us-ascii?Q?eEV2R6vXxYA97dHJZTw1EWtRyZ8xU3ZrKL96sbPRa9oFNpCsEcvV8QJhou1t?=
 =?us-ascii?Q?V5+crmi5SRBZbNvMsGcLmWRXAzwLR244dkErARo/IuIglqube4vrllL45yuR?=
 =?us-ascii?Q?L4nEIP4CMkGzeJgGaX7cqLkRghDjaJ5097yTjiksHWLVmQZlyD4pAic4Kn9J?=
 =?us-ascii?Q?bpZC0gWk1Q71tGVKT3ETL9LMT5eqjay1CxYEi9QCI/+4AFoMN0Fq7do/dt3E?=
 =?us-ascii?Q?NgrfG5Oow+1bbdWrKe619FwKcktw/Qh3/jQzBtcFJx/QiJhe/5mJAqKesA/X?=
 =?us-ascii?Q?EfAhwamirOIT25YY1IUPDBCzqfGM0I3vDYwDn3xt1f/6F3OyTDhxFawB/zZI?=
 =?us-ascii?Q?TWFmptqaWvCxGbqywBtiSr9oX/9vfx7WiDUQjDTsaP07ca7Yn1WSJCsN8HPH?=
 =?us-ascii?Q?OzsLdkFlosZyiEtIlL+3M8EfoxkFChMQKnbn6grDwvrbZ2bvHRwzkFB3LGn3?=
 =?us-ascii?Q?HTIe0+vjufxxDSj9GQD7oP824ypWtRyBgGLywE3HKxX48V6PUlKM+fJlZJlm?=
 =?us-ascii?Q?iAVVryDJRuIOoFjbP/k0DbVCBYVXmP2qjqrtUPuv3jV31Ro0wDOp14wSZIlF?=
 =?us-ascii?Q?iMi/gEZD6QzRbWOL/IehGiCmZMQKo7zg1GiAXORrlRryKZXxoPtsMK31n86N?=
 =?us-ascii?Q?E84xCH7xOkREw8KNhTY0+dAlLmt2/tlT//3f9hrDgrFnnqcPIzrRE+iN2Hqv?=
 =?us-ascii?Q?1vH4RRZljJ1myQEROVYxDlaFU51xbYg4miCOf2QSXERuSLZOYG1iN7HEXqvT?=
 =?us-ascii?Q?sRgJ4D6lvn71DSGUol0N6gAy/uUNKeC5ZzAQ9I9Jtk0Q8lMZI9Dpsw78EyEL?=
 =?us-ascii?Q?GCmIiiE3iZI469K56ZNHmSJNmWTlXo5+7WbXBbZnQwF6qsC3Wb0SzPytIHd5?=
 =?us-ascii?Q?o5zfSB+fDaudrr6NqJRcP2DpwKvN57Zo6hjvtks22Xj8/Attdq9hsVVqtdpa?=
 =?us-ascii?Q?yjOnPN9Eos4aEX2CfIiOctI7XH3zqgFoWHybftTzLHFSIgLNCeGoe/VGjzYI?=
 =?us-ascii?Q?Dlve8UhesJbJMGj/xkIBrTG1ofpvnEICcip5vqP7vrU0C2gd6rR4HK6rErD6?=
 =?us-ascii?Q?GzjLN13x/069ycGWKxvranVAhZvvs3pvHDasir+yROgQMW+ipYtRHqssWdfz?=
 =?us-ascii?Q?QzjHRU6lp52DswN3Z7PkoDWxIokZLbRISvZM9UvRKJohychXWfvTscdNzbOq?=
 =?us-ascii?Q?hHwxCWGCnrOCCpde99NCgqxH?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f78c9e84-9818-4621-7033-08d8db179938
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2021 12:02:47.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkYjEcPPMJzbyfJ38/tzKn5PCmNtv6v/FhGLw6j6VdhicAq/6wnregYgs9mCMEZChThhkdSrDh9QnNzEzTa5IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3369
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now swapfile in f2fs directly submit IO to blockdev according to
swapfile extents reported by f2fs when swapon, therefore there is
no need to check IS_SWAPFILE when exec filesystem operation.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fs/f2fs/data.c | 2 +-
 fs/f2fs/f2fs.h | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b9721c8f116c..a1498a1a345c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1723,7 +1723,7 @@ static int get_data_block_dio_write(struct inode *inode, sector_t iblock,
 	return __get_data_block(inode, iblock, bh_result, create,
 				F2FS_GET_BLOCK_DIO, NULL,
 				f2fs_rw_hint_to_seg_type(inode->i_write_hint),
-				IS_SWAPFILE(inode) ? false : true);
+				true);
 }
 
 static int get_data_block_dio(struct inode *inode, sector_t iblock,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cccdfb1a40ab..3f65cfe11a0f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4176,8 +4176,7 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 		if (F2FS_IO_ALIGNED(sbi))
 			return true;
 	}
-	if (is_sbi_flag_set(F2FS_I_SB(inode), SBI_CP_DISABLED) &&
-					!IS_SWAPFILE(inode))
+	if (is_sbi_flag_set(F2FS_I_SB(inode), SBI_CP_DISABLED))
 		return true;
 
 	return false;
-- 
2.25.1

