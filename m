Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48057369076
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242146AbhDWKgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:36:40 -0400
Received: from mail-bn8nam12on2060.outbound.protection.outlook.com ([40.107.237.60]:20832
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242131AbhDWKgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:36:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUZf7vXy5Z0gML+2uT7PUpQpmKRtg9xGT3RPiKs+7xsJQ5lnMZEdqsiqM97On+PaX2yI+5eIZ9ezX20wsr6hpeychf8S++TZHWG4HCBEEQJ/oSRgvkqAS0eUKvBQbnPO8gcnNqxfr9tw5lNu2HiSRABPLmfleKri7HyZfbrkInsezgIy86TA8ktvn1E/MBRgy5gaMnDRJ52ZAyYn8luEy/javpmzS0hAjgzxY40QC5d69TtKVCo03rVKP6ygFcoGGN2gPmsRZYnClG98zT31V3ny4HIPX/qHBtcQhlVNHo4UFAB31jQ2DtnVN6TNvstHtiVMv52LcUu2g0tvAhJjLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVXb/jfniKHAVt8fXpI4qKsIk++ZFmOxGm4V/kx+xmc=;
 b=i3DykTmsCFAvRMz5s/4t0VxsOgNsMxSPlDwlozx4VxAQweSQGjBfwmjGaH4NsQ5G/XxW7/E5iGVQbYcQdQbh/JiX6Q/gp821r8uQoqwnRAUA8+hpP1IUjvQYYogt3lsRX4ef4KKoHMqyBb+L1M5Pc9EnY0yMnF1EdooyjnjXbPuIaXNsrmna9BMWJq3LuVFyqkevSQwMGv4PtXv9GaFPAllFas7CWnxqK8bI9a8kIazSWjn29tHbIHwrACR2QB1W5m7RG+bMqe4uwWcVCG750vFUxuYb4vwrL5j7KatqZuGMEwEFQXfKUB2YxELFCjBRTOAP387H7cEeFs40Rr/lOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVXb/jfniKHAVt8fXpI4qKsIk++ZFmOxGm4V/kx+xmc=;
 b=UB2Yn/jiUA56ZrdOblsN8P5F3R+Im9aM0JxyRfVCIr6TJRRkVkcFPPsDXYYPKbc/cSa89oT7IRgX+dhFPYeWE0QYRtRXgfoTEdlTO/Dd3SH9J+AuhYXI/nHY1eUr6QHKozboB+9UWvOigY+HFLPkqBp1vD1LftsATDs0G87Ju00=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MWHPR1101MB2192.namprd11.prod.outlook.com
 (2603:10b6:301:59::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 23 Apr
 2021 10:36:01 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 10:36:01 +0000
From:   He Zhe <zhe.he@windriver.com>
To:     oleg@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH v2 3/3] audit: Use syscall_get_return_value to get syscall return code in audit_syscall_exit
Date:   Fri, 23 Apr 2021 18:35:33 +0800
Message-Id: <20210423103533.30121-3-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423103533.30121-1-zhe.he@windriver.com>
References: <20210423103533.30121-1-zhe.he@windriver.com>
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: CY4PR19CA0041.namprd19.prod.outlook.com
 (2603:10b6:903:103::27) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core2.corp.ad.wrs.com (60.247.85.82) by CY4PR19CA0041.namprd19.prod.outlook.com (2603:10b6:903:103::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 10:35:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 921bf59d-fabe-4092-ba5c-08d9064396bf
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1101MB21922B537D86D7D849E18E358F459@MWHPR1101MB2192.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Is8jUvCqnbR3C9XWtNccKw6oF0RlgPFOn28/74fbuAaEtvBE4e+igvMMebr4MF5wb+GxTf/Nkz/nLvieNImGPye+hzfFz0oyKZhmCYJsWzx1lKqHukMfeZLtm2BSva0pL5F1zfrUD0kqah4iH6VLd2a334L40NT39++6hJtPbNn0Up7xrSKHkkKHHrbDuFW7ZiPnWfjiO+kOehvn1MhnMsQXnLoc5/v5UoyycqKMjb7+C4s36BHmeERvgqL6dOXXzJ62/Gh1uV7Ax61JqKz+l1Oi1tfjAKLqNvQlcsO+3wvBW3NTJq9JbC4SxLjYBPZN5f8tjgUwrwkbO1XwzMw0+idYriXPTr+BkeFtn6JsPEHNYNNNLjfjgPehWRIHaZONH3hJkXoyxe+Dmqbhy3TtSJrSbYwzueq+lrQ8TZRtgIH1GlsqcglxbHWpUW1EZk7J/j7EGUjit/f4xyunW2BkNuBsbVEbz+BlsbC9x7jfGED0STk2VqtSYZ/Ccetn3i8RPyBQeQHlt/kVTMJNmMi85/PrO5X+gAECJf34Ax2gPcWmRVAwl/dlIiiuY1EGOvNY213rdXDIghCyvETtquoISzVBu9M+OjWoTXuD0UpG9TpLOgnvEVVA6lLAmg2LubQZQghosT8yeQmTsJ9jMKOVWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39850400004)(396003)(136003)(366004)(52116002)(38100700002)(86362001)(38350700002)(8676002)(6486002)(8936002)(6512007)(26005)(186003)(16526019)(316002)(6666004)(1076003)(6506007)(478600001)(2906002)(5660300002)(66946007)(2616005)(83380400001)(956004)(66476007)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?07XBfvUSdKahtoPPECYmjAYmn9mBZ3ptoxBx0YSoMXAygONKBKjxutZyjH1Q?=
 =?us-ascii?Q?eQKOgfGz49vQ6aLW1fJGPPS5e41WlCpXYBezFj8wYEQbb4bDdNHjVJj4VKnU?=
 =?us-ascii?Q?IweIM+i9ucdmZ41wFe88ec/o3CieI5oY2exZ2zwmx/nqmZO5e8fg7CUAUW9b?=
 =?us-ascii?Q?QK0gOxTS7no0GHE06qq/mr113+V87t4ngu2ddwXWEkZKrO0c7k+zJJyCWWRK?=
 =?us-ascii?Q?JXVRfYjq62u2bYDypaCFpI2zRFbsnENSp+XQp1RjzXSM0ZpM5d/BxdEZPtcT?=
 =?us-ascii?Q?JPAMTUwgOdr/QnOcF8Y9TlBAr3STU2rqwG9fHl5MD1aI1Ew5Lc0nK/dper7/?=
 =?us-ascii?Q?mtCzkwRqZTgKc+ijxiFU/WSfoOdZkrsRaghJYdXZSTmWIq08v3n0mMHDR4Gw?=
 =?us-ascii?Q?6Dl6p0HvTQTK4aoAN3xTlyr+pLR9+7vQn8vWd6HUUuXDN0RI33NeXl6FHOj0?=
 =?us-ascii?Q?jlaQqKoUmXkiXbJ2/ZZ8bH/P/A0nwT/4Ik38PAQFdlVncmanu1ZGbkBlemiD?=
 =?us-ascii?Q?qoeD7r8e7hloeJHb1jHw22Y5BfN0TIMCCAna2qpIsmH3svc1rrOhPUuz3O2P?=
 =?us-ascii?Q?Y5lyuyxs7VnSv/I9A+Mv6Qra2XwrUN30YRmmLj3uGk9w9+mRjoYOlwPi/0j3?=
 =?us-ascii?Q?wsPdAdf/VOaUvNsCv9nxSy6qIirvHO4yYmCJsgoMzuwSJkYVBql27B8K0lmO?=
 =?us-ascii?Q?qv6jIxj1J3Up5z5w2PJRSQ2ocG117SOHEJG5fZGefW3h06JC9+zDSpzIK9Ll?=
 =?us-ascii?Q?SlJF3qHmdg+ZCTUeIA4UiGtSmlQCaMKO5YdN5W1wxYeFwzXbOT2iaSzfLLE2?=
 =?us-ascii?Q?uZU3qzyyUZk7feDSjbN89GCR94lz9eI1pXfpTWlSF+2m6mtNYG0UQkeSgBTx?=
 =?us-ascii?Q?uRLAkrpjxPb2SqlnB8DFAqJIAkIUwtjl7wlTOgM7f2pXSomDxg7oANJg6Pc0?=
 =?us-ascii?Q?6NrxBRrcEOYlSqSxG6ULd04mQstdHJmyRp4ELxg/i4HzVkUd2Y+c7aF2a+O2?=
 =?us-ascii?Q?t6BX60qhU6D+cLkuC2b5S/LGR/GlL7BYS9E+JxSFn3gq+s8hfVy28bdILcwE?=
 =?us-ascii?Q?qBQ7b6znlNl1Ws/EhHApuSMBqs+3JAkIqnOrqQ0EmGUAqACObJFOplzIHhGR?=
 =?us-ascii?Q?B40dZ5wyur9z1pE4u7g3mQ6j9+PHZjqJfimrwLqDO4Y9e6cbvKsXSeaNBmE+?=
 =?us-ascii?Q?yOpZqDmf3rxepb3s9swbTg9z/E49i04OafxsP5T7yA1Sirfqa8RUVerwhED2?=
 =?us-ascii?Q?8wnjf3OErUVzF4CV71p9qQ1jEyem0HaWD81TaCA07gYq1TrkcCSTwy7+NUmU?=
 =?us-ascii?Q?+cyltcJNlH+Z7xNcgmPOezWk?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921bf59d-fabe-4092-ba5c-08d9064396bf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 10:36:01.5486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqazgfDpZ+/85GbbQb2VFIU6kn2bvhD+EcvwMIHT/8uEB4eh9ADupV8uGBMmNSpzZFoDmb06pFOZI6AeHMYgtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2192
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regs_return_value for some architectures like arm64 simply retrieve
register value from pt_regs without sign extension in 32-bit compatible
case and cause audit to have false syscall return code. For example,
32-bit -13 would be treated as 4294967283 below.

type=SYSCALL msg=audit(1611110715.887:582): arch=40000028 syscall=322
success=yes exit=4294967283

We just added proper sign extension in syscall_get_return_value which
should be used instead.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
v1 to v2: No change

 include/linux/audit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 82b7c1116a85..135adbe22c19 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -334,7 +334,7 @@ static inline void audit_syscall_exit(void *pt_regs)
 {
 	if (unlikely(audit_context())) {
 		int success = is_syscall_success(pt_regs);
-		long return_code = regs_return_value(pt_regs);
+		long return_code = syscall_get_return_value(current, pt_regs);
 
 		__audit_syscall_exit(success, return_code);
 	}
-- 
2.17.1

