Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8C435EF00
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349863AbhDNICo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:02:44 -0400
Received: from mail-bn7nam10on2054.outbound.protection.outlook.com ([40.107.92.54]:56480
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230351AbhDNIC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:02:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAEZ8UTwdcHyDd4y/MUUFKehsV8DLCnKnf/gPKw9nxaTXxqTG+TGIArLg9K+a/8W/MnOsCgV2DzcaA32DNWDG+63Lrlckq6n6pYxD21gbFIYlpSCsf/BMT/8r+1nCetxjrxhG4FhCKD7m0vqEvgZkJNNFPjUMHIY55eMET9NJB/4mEX0BU0UfjQYVcO0JxO6E3WrAbovDz9QBMcblZOIT5zYxACq3vb6tLaWFgpeM+Pt/oyB53HJafX8ex09q5jgsCvFyiue5eP3wk6iGqtyuae9mpldPL09JCnw/6EGQ0IEtxnXOpjezFYb/2esPmJgccNfTB8RB/Hijd86ExznAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAM+mB2ztfGkoX8y0oan9eqlaf7gvL2zVedo56cMuS0=;
 b=CHSfPRQoQfztd0aEI8lv1VVAzLITkxZvR5J7T66PYXLFNTxSzmAjLXEZK5e6NsyS625ZfwaqDR7awWDlfK3NhziTrHDpHpShR56a3oN3Pv40npKVAH3yocR+HfiLhr6VSVow1lhr5RmtYtCrEP/0Ylle3RBg6Cz/XdjLjJNLaGD6SRkhCW4z9cC/0lKhKFpFFmqewl7AXyzxs7LAtvxoB/vwixaJ6n2myd2yItqYnBKD5d3gzAEhff4kSbU1PYFmVT/+6AZiMr6zScc/jbggKWIjP0RtUciD0G5nUmr3ZbBNcyZiFGZmNZX1LREekucSjoRnMcYlYOWDamRhl9U9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAM+mB2ztfGkoX8y0oan9eqlaf7gvL2zVedo56cMuS0=;
 b=HW/H0QytZAdsX2WBlVNUfwFYJoINF7FvuL+g1WYEtmPGgw82RgtI3FnHl09INCHAv0aIPhigWz11oJtesBtMaVp2vtyEI5LZfTChZK57vO08Aw67NHU71IzLwehMusKf7iUzfcqsQKq311bYkTv1lAVtbkKMyAeGN/xbB1R2oy8=
Authentication-Results: paul-moore.com; dkim=none (message not signed)
 header.d=none;paul-moore.com; dmarc=none action=none
 header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MWHPR1101MB2320.namprd11.prod.outlook.com
 (2603:10b6:301:53::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 08:02:04 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 08:02:03 +0000
From:   He Zhe <zhe.he@windriver.com>
To:     paul@paul-moore.com, eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH 1/2] audit: Add syscall return code handling for compat task
Date:   Wed, 14 Apr 2021 16:01:45 +0800
Message-Id: <20210414080145.17378-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0025.apcprd03.prod.outlook.com
 (2603:1096:203:c9::12) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core2.corp.ad.wrs.com (60.247.85.82) by HKAPR03CA0025.apcprd03.prod.outlook.com (2603:1096:203:c9::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Wed, 14 Apr 2021 08:02:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf164977-f910-4b1a-f9b5-08d8ff1b96f6
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1101MB2320898D48538C894B7DCE728F4E9@MWHPR1101MB2320.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XTg0hNqC65ZFgwijFtCfQGsAJ8arsKvByhyBTkZxUsvjxRrGnewdH9Mzbvu2AsZLcuY0bQ7dWFG9Rl4tZW+DeM9otkMW77JOk/faVfZHg0HyGE1eb0nOS7spIp57JHx0Uni7BuPIAauIFRI+Q53Q66FHgoDjKfoKL8/E1fUCgrflXi2ub0Soco03WMOQaKQPNbrDwEmlclZLvMvvh5MuR9LsIUb9YEjdO42I1d0WprEe17GRTGOI6PVsDS0rKQNEYbQmYyYpaELXWlJGlOJOBRR1lDuSVd832vbAeYoFrq1x5aU2m+fIhj9ED+/86y+QXhibqEprUIzMxCMuj44xmkf56HhNESa5SEVRz1Oww48eYd2c/f34QvsqWwXHTBPmsVNXuJeXiDk8cYCTWPT9dhF+bhKBeVf/JRBuklG4qBxJ4nF9mnvw1GrifpvDfMkBuD+T5Pd9UnsSvZrmwflydlnlXzkCfVpNzptBr5dMJWWv8DmkwFZQcyQzCz72cZspIKRq6BHVHaAFCa5i6E+HjxJnwraNuz/9Bj5i5kH0AU9oQYdN/jKY53P9ncXP3VtLgenr0k9istJgpgHrEmhUD909c7PL7qkOaptBg3L6G6+cZh8fdnBPg6PPsS/hiQVY7QpCXEvD0GESTRqQ5g5P1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39840400004)(136003)(376002)(346002)(52116002)(16526019)(66946007)(26005)(66556008)(186003)(478600001)(66476007)(5660300002)(86362001)(6486002)(2616005)(1076003)(956004)(6506007)(6666004)(83380400001)(2906002)(8936002)(38100700002)(36756003)(6512007)(38350700002)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?V67gk+diib3m53OacAxWkucAaJSqZ6mk05sCRGmrWnnfZx+P+A/LGgdRt0fK?=
 =?us-ascii?Q?KmONn1BF68zDFplQ8PaWXwF+APgUMzn+39SsA1AnGGa8buIpAG9F/2yS8Yuq?=
 =?us-ascii?Q?qfEEXH6S4Ji8i7HtGBRL3YRcqR0wycpTQ0aq7DCK64Ailxz0R+VqhH82bAyV?=
 =?us-ascii?Q?+dXpHVU/ax5uga6KY3W6f1HmwM4/luBDPS+q716f1Pi5jj5Pae0Ow11tB+Qd?=
 =?us-ascii?Q?XUNoNdIZQNJvozhD4Uby+NLfAMTFSV3DT1fD5BlWuDKSc9j7oDTsidCoh4JK?=
 =?us-ascii?Q?PJXZpwCUYLhAxCjUZWoBNTTDqwSEn4s5rTjJCUmuLIIqnXLtdNHAQMbIDRUl?=
 =?us-ascii?Q?3PJeMM5Lts3vTyX8KxmMcXmz0fLSfXP2Myo/o44xv+BLvzVilwa26NYPURRu?=
 =?us-ascii?Q?kB1FqlQ6H6jPZIlZn/ES4XzysVLToOWErNsHap3mBKuC/YNERTOZbkjpYGIK?=
 =?us-ascii?Q?n4/ckrp2sm0YCg9lNw4YkcvGcq50OkFMX4cF0g1wNhD/mjvCMpJ5gSXuGscr?=
 =?us-ascii?Q?uFhbt/M7LnKo8+ZRIuVxhmBWU/J9/5ZLCIyK5sBy6Zv5hl4aidvSCrvn+RFm?=
 =?us-ascii?Q?7zZ+WnCht3gZ23855DMbEVNBRIp6AlqAywyT6feUsydtfEzQsNxMlhbNlVce?=
 =?us-ascii?Q?mgQNPspM5ywcS5PUu4zlh6LfAY03FWCXELDgBbWYVxtCR3ArJZx1Z9vmOZCc?=
 =?us-ascii?Q?9lmhkYliw/zktnmt/mFXFjUINKlBBIrl/T+1gmJguGIH99zgvC+UOcCujgHy?=
 =?us-ascii?Q?iCFFRNm6mRBDKOky3JQ4HaYWflJvyF75ZveEAJ0fMfnhLi+1MZGvZWIU0tWj?=
 =?us-ascii?Q?392wqgEYqhLbMjZMPE3YYeQQyZ1yrwJHb2d5fT+b+MZ/jrzgCNAwZRGVwe5N?=
 =?us-ascii?Q?JLxumyPfdC0yLsABva/Ucf1fyTZQjfzgOuxuqSK0mnd4mU/Fdrd4eVV+klTW?=
 =?us-ascii?Q?uOdC9AhO0ZD5h3EYdzER1CkxW7t25fK9ZwuXcO4ej1080NCGPwFe/piBDneh?=
 =?us-ascii?Q?eg8YyaqNW9xee7gcccak/i5MslWfEtKzN8XAG01OHRQdazT2lq/VbPTY+xfT?=
 =?us-ascii?Q?GEQWTvWjcwxgRvH0X7OAgfyGiGU684zqV2Q77ki2BifSElrRbS5H8WQDXBiJ?=
 =?us-ascii?Q?WqHDacT8Z+kRFHu5aYepbFNcWyp6nc8nSx6cZxk2dQmxwVhHBuc5OyOYiW9k?=
 =?us-ascii?Q?O+fO58dJ70Ad2wwlt6iJXxMhKWNxHx5ULt9daRgWxMjRbhjBpFWX4mE3lGMA?=
 =?us-ascii?Q?m4Jv49OmTPIwqYNmFKFmCWj3L96Tm5W+4uM8w9ZB/SwqgB98E3gA77yT9A6+?=
 =?us-ascii?Q?Rv+ftpHYpwv/0qWDR519w6nj?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf164977-f910-4b1a-f9b5-08d8ff1b96f6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 08:02:03.9251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMXGHtkitw0XCFynIyqMmuppmXim0vz17FOVCq07b06RWoBtqgOrMulJ41iK9T1G1p5TBspUIemf6tzQJ7q1iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2320
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 32-bit userspace application is running on 64-bit kernel, the 32-bit
syscall return code would be changed from u32 to u64 in regs_return_value
and then changed to s64. Hence the negative return code recorded by audit
would end up being a big positive number like below.

type=SYSCALL msg=audit(1611110715.887:582): arch=40000028 syscall=322
success=yes exit=4294967283

This patch forces the u32->s32->s64 for compat tasks.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 include/linux/audit.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 82b7c1116a85..32cb853f3029 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -334,7 +334,9 @@ static inline void audit_syscall_exit(void *pt_regs)
 {
 	if (unlikely(audit_context())) {
 		int success = is_syscall_success(pt_regs);
-		long return_code = regs_return_value(pt_regs);
+		long return_code = is_compat_task() ?
+			(s64)(s32)regs_return_value(pt_regs) :
+			regs_return_value(pt_regs);
 
 		__audit_syscall_exit(success, return_code);
 	}
-- 
2.17.1

