Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C3435EF08
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhDNIEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:04:14 -0400
Received: from mail-eopbgr750079.outbound.protection.outlook.com ([40.107.75.79]:30945
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349882AbhDNIDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwAuFWK66/VWoJurqGVM6p/jGf3+Nm23+ut0M8/D6S8MkOIAG1VnpU7ouRXih+SOFr3iher5zeicVWF0sQFeqdb75FUqQGi3+sZidaN5eCPIQCVzSOPZzrIVEUwUTJDPlQMkjXyAY5E0WQn0yx8NCatvxgiY/khYt5wvzIwAgM9nvIHLj6kG9hM6XZdyT8kY6LAz5rtZpL5vV2QQdzuWBmKRxe6BHBDsCLoEqDdsVGZIhYLFFTHM7/69pFHG8gEzwnxEYahEiiboPG2pA1pAE5Np+2qJL9NdLtrY3wsbhr2PH8krg315ZskLes60ij6u2RJftAuUEiN+d9zL0Kfq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75/XDdBI0HNklyfCCmXKmKqUVAaNbrNL8ACmTdKwjqA=;
 b=IjDHPKJ/ahhMwXbzMSoo9aZiqJrnz4jnwyKsqFOyazg/n0zYvcTSgs4ITyP0iyktFGjKQvjV9eDYmkkbpywW/5S51fCV/Cr3CcaIAGzGteu0iIPVE7ufvmHmqkZLtF4fu535mEcf8IdnWMU3ByMngJFgccAWgxn9SreB9dMNLEnEcboRFEI1BCdP2XTu17bDMmnB54GSqx4GwE2KQfmHKrOVu/r6FVOjKWbHhykpg1IUMWqwXLKQQvtl+Z5ILgK9UTlXr2CniwxwPxa3dUZH+ErsWZcXdCB1as1Q129laLZ1Xvvv1gwMjmAN6Yfnop15ZMrpCBueRCTgTrQgmy1iZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75/XDdBI0HNklyfCCmXKmKqUVAaNbrNL8ACmTdKwjqA=;
 b=pXydYmLlUW2X1RvTynh6QqsJwgylhuiE3hPoHZmq6jEdX2IMNS3i/iExLg7mSU8p9C1C6Gk68j+Y3yQ295KZbymnpeeaNPOEM5x+nTGOcYSWRHofTOHlG5WDHiHaj8+D7WF5jRiAZkumlJOA6Ar98ls2r7Z4U8yNZyRSOv6JzVQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MWHPR1101MB2320.namprd11.prod.outlook.com
 (2603:10b6:301:53::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 08:03:02 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 08:03:02 +0000
From:   He Zhe <zhe.he@windriver.com>
To:     oleg@redhat.com, linux-kernel@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH 2/2] ptrace: is_syscall_success: Add syscall return code handling for compat task
Date:   Wed, 14 Apr 2021 16:02:45 +0800
Message-Id: <20210414080245.25476-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR05CA0208.namprd05.prod.outlook.com
 (2603:10b6:a03:330::33) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core2.corp.ad.wrs.com (60.247.85.82) by SJ0PR05CA0208.namprd05.prod.outlook.com (2603:10b6:a03:330::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.8 via Frontend Transport; Wed, 14 Apr 2021 08:03:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7a71e06-a2a4-40a5-280e-08d8ff1bb9c1
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1101MB2320A273DB43EF15B6ADC7A48F4E9@MWHPR1101MB2320.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJzfWi/cp2o+fjdV1Y9cZNO42UPuj0HODoxdsH/8n18IKrh5RF9HRTe3rDq6coF7fV9WNN6RxHctEWWBpWaYwgRESUv/1vvLvDQFhf+MKDS1bRhFv6w1JTstR+A6+7MjjcM91fGczgp/3STnanSFz49atDfa+nBXev8Gt7Rp6og/XoiLJMFXaC6rCnMfOrlmkUfnlQgYP2FrlvO+Evolo355P0dgjPfCsp8CqPkwKF0mkWhoZ2MVzsU9hVv9+wcopgHHxdO5LOa0d+RIgqxLQ+EtxpYpCtxg0/C+R8v6/vu72E5J3UYExQCfaeDcWWKFkNi+6idfgCVE+huN0qDcckAZrVkZ9qVpZ6ejzeXyQqNcEGbuUaz0V3nccu6WZIJUf4caU6HwEpu1kMIMlsr+fVey8aw+P4JZBKJ9MvmrlragvWD2niSdKsmc8lhfRD7fKc9g0TLuQV0p9H43iXycA51ZmqdAHX4/uxr70iL9a75Wh7OLNTz+oHKozPBHsZYPqxHyaMjAxLCgWyniEl8xpm8W5BjJmpV9hlOXNcR9lmRipgKbjY4qnsd8/Z/QK4wjzmjs//OGsjLJQUlNvoDhm5+sh3CfSqwaQTmabg2pxePTJFqOpNmagnt1WjIOs6i7EAM9FNzLpaZiMK/OKe4+oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39840400004)(136003)(376002)(346002)(52116002)(16526019)(66946007)(26005)(66556008)(186003)(478600001)(66476007)(5660300002)(86362001)(6486002)(2616005)(1076003)(956004)(6506007)(6666004)(83380400001)(2906002)(8936002)(38100700002)(36756003)(6512007)(38350700002)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hqkZHxaj1y9s/ClFVavRs2qes3C4Mn38XCiTXRCT4JS0smzYSWu9QJLv4hMG?=
 =?us-ascii?Q?Ij5zQz0+i4/j21JJvHYwqlQ01OFsgZcYretmQhb2kuuKo0ij677ztCaTDFjX?=
 =?us-ascii?Q?TRSpf5zBc16ptehcDp6dm1APMSa8+hQuMP7LBGNLIjOwObUi7eRMQ7njW5rv?=
 =?us-ascii?Q?7E9ztGvJX6iU6iSgVD1gHyCsJHN/9lIPKX/4xcMzGRsg49OOB9ObBunaISvZ?=
 =?us-ascii?Q?Y5wQMK9q7zzWpYoYyzLx1Hl9WcEqd0BC0pqL3s8ioWTHxawIaxBT7f0luSjg?=
 =?us-ascii?Q?QXrlmvGGoARUQGzbyOTb94tV3fu0/ofdEl20AK4xYCSKugjJy7FV5D/sYoJe?=
 =?us-ascii?Q?L07meJ6oOcsC+59E/dLOyI6/QhucRJ4EfDJR5DFaiGPEE5ruU6bEQA8uf1tb?=
 =?us-ascii?Q?N/1aqm1lZHCNomL9dsKEfnf9BOJOi9rxhiDnribTO6HnKm0o+PDIEjJ9Di/H?=
 =?us-ascii?Q?cSoX+P2XLC2kRepqH8+X19aespj6DPbCdiadQPC+XovPSye7sd9kGmWU/S7g?=
 =?us-ascii?Q?AgET7kztSdHgwod9WPg4ImuVvV9FiwYZ2DMvNsxR/P+4gblnU8OvW+lKEG0b?=
 =?us-ascii?Q?JMkDFgvkdbAe4QsfDwl4syRgh4LfEuH2ZNwhQIpmQU6sA0DT6pCg3FPXKsiF?=
 =?us-ascii?Q?yf01BWyaKhNuVjBtUC0HcNTRcbHR13gzADLBGMbLUK0YYrNDjqCoBJAf47Mr?=
 =?us-ascii?Q?ozgitTCDVYdnbO7IKNau/q3RwZKotPFIlgGJEK2XCiwxUuNqsemX90mILk0j?=
 =?us-ascii?Q?y+iLSklwqV2VVLUOEXzLa7BBhlb3JC+t5v7SEDU7HI6l1VeToAC/3duJBpl9?=
 =?us-ascii?Q?AAyDs6j5cZo+mnhIGpQ0MZSrkZAEljaXT68eExujlVKfKuI7nKhmP0BSY/an?=
 =?us-ascii?Q?yA4VasoV4A8K+SF/EMf1z6W2nN4MrnNTxZo5zyI6QHZXYaXSihqXzv65wGA2?=
 =?us-ascii?Q?8hpvNfSaspZV2colj9P7rrFjISJp5kjSkGaD+8nCWJtYfcQA2ez3e7w0CrUd?=
 =?us-ascii?Q?f7Ut1Ps4d5kBHjBxKBuWFK9tLQ21ErYzBoqNSbPADLvS9j0ElGHyM/nl9Wlu?=
 =?us-ascii?Q?Lw9alkhR0O28Rn5jPYMo21M3p5s4pJ248UZpGBEkdWkAATVbRb0hdqlRLmY5?=
 =?us-ascii?Q?PyfxWVj2eusnQeO7+xUTUmoj46pHQALcpO0hggEQHJMJK4+q13DzJw4thfq7?=
 =?us-ascii?Q?K4qyoIVZ2OIlS4loHHiXXtsT0huCzdzhpgfbbhloueIrbO8JL7xg0z5wWfDh?=
 =?us-ascii?Q?N6NOdWpj+HDM4ybNwaFoNHf/WW2DPrBJBgk65QN5st588RgHvs8GV7sBEIOv?=
 =?us-ascii?Q?oXgf8YBO8gvUpmSqs3k+nrgz?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a71e06-a2a4-40a5-280e-08d8ff1bb9c1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 08:03:02.7314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkvVbkrdAuME0XzWk/kWou+vytWy+VB6M5Kzej8IQxUzTjb1SGmM3/tmjMPn0OIiFvltqycsHmusXhBqK0DFYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2320
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 32-bit userspace application is running on 64-bit kernel, the 32-bit
syscall return code would be changed from u32 to u64 in regs_return_value
and then changed to s64. Hence the negative return code would be treated
as a positive number and results in a non-error in, for example, audit
like below.

type=SYSCALL msg=audit(1611110715.887:582): arch=40000028 syscall=322
success=yes exit=4294967283

This patch forces the u32->s32->s64 for compat tasks.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 include/linux/ptrace.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index b5ebf6c01292..bc3056fff8a6 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -260,7 +260,9 @@ static inline void ptrace_release_task(struct task_struct *task)
  * is an error value.  On some systems like ia64 and powerpc they have different
  * indicators of success/failure and must define their own.
  */
-#define is_syscall_success(regs) (!IS_ERR_VALUE((unsigned long)(regs_return_value(regs))))
+#define is_syscall_success(regs) (!IS_ERR_VALUE(is_compat_task() ? \
+	(unsigned long)(s64)(s32)(regs_return_value(regs)) : \
+	(unsigned long)(regs_return_value(regs))))
 #endif
 
 /*
-- 
2.17.1

