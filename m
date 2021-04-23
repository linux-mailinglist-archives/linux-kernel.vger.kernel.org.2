Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE65C369074
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242059AbhDWKgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:36:33 -0400
Received: from mail-bn8nam12on2044.outbound.protection.outlook.com ([40.107.237.44]:54080
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229772AbhDWKgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:36:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNYgWSOcmDeDcsSaTqStZjAYiqfloG0iP4CVJ8Re0CJYlfO4ZUfzGWZBIOV8sBL+uRoKIPuOQX7clVaejgGmDHEGbABoL+RxRRXNIQsdr74qcfAr5nWp42WjF9cD+YnlbHm0dMtXUDvr0JEbojrmsW1w162TZIuMF9lnmQhEvBSY9mtqUgmlpRM1L3/Mdeudu2JgK0dBj6s4hrg0Y58yMBAoZo9hVHLS+nVOx/Qnor6OkDhsq1hK3OUIpFt36JlfSoaESRjl4aLGq6b/364vVN6HjsBGZwWA9MvDtWGqUDSnyPr+FRB+8Jba3e4KoqA7JDdknHle2eO3N7Ff5exuhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5ULuJNq832Bw0rukmRVELOKgATbQUbAU5kBZW8Vc2o=;
 b=cLAvaqp7PAfdYBorgmUV6qBKNdkDWtDAauF7HKIkGlU7IpxEY1JnA2RV9hsk0wWqyg7VuloSXnKR1foLm4d3HmgjfPXZAnEfcV8loQwH315CiHxMVVlTVib1OsfQvAqS7fkR3vVe/z183DHdkuqfmflII3Idymadl3/KqVIZe87SB1m1HfzQdrichaIGeC+KEgXpWnf9NKnGJ9eGsYlqCxGyi9CV818feHIli17rRrRJi5rUdF0sDdwbSwEPG+vW6oNw6fHtvZ6s94Ut53LIs+Dj9Ws7X0jiNXAEG83Y7nXs1EBVi/ux6niCiRI9akF3EI88Ol5D7sf12A7SCwYbkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5ULuJNq832Bw0rukmRVELOKgATbQUbAU5kBZW8Vc2o=;
 b=a4dQddrb08DYngSrdW0lVfI9lvsciLcggc/UaTkgiMoGFbKaaMxP1IaCe0gXkBq+6Fz8kmJfTXFqra8ozz6OkPnPO4qSwGNGll/IwESg0lZfaReFBquR8atkgWVP/w5dQvZKZDTAOEL4A1Lu92u1lq0gBia2z6W+ntmvRtzyi4k=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MWHPR1101MB2192.namprd11.prod.outlook.com
 (2603:10b6:301:59::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 23 Apr
 2021 10:35:53 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 10:35:52 +0000
From:   He Zhe <zhe.he@windriver.com>
To:     oleg@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH v2 1/3] arm64: ptrace: Add is_syscall_success to handle compat
Date:   Fri, 23 Apr 2021 18:35:31 +0800
Message-Id: <20210423103533.30121-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: CY4PR19CA0041.namprd19.prod.outlook.com
 (2603:10b6:903:103::27) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core2.corp.ad.wrs.com (60.247.85.82) by CY4PR19CA0041.namprd19.prod.outlook.com (2603:10b6:903:103::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 10:35:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db8ceb0e-bd69-48f7-481b-08d906439150
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1101MB21925D19C2A6702BA7161CFA8F459@MWHPR1101MB2192.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vL5iQSq4zXJcl10VQTbg1Bz/swL4hIKeFSiTGgTEmQvnjTVrHHXINbDpW/zfXI5NCWblVi9AnahfpcN/ElwMfc/Ct92q8ENZveUFNLufcZbCHk774ZTDVldJHtUAbk4gXdUr3oXdgypBiBkxJaeU0WrQW9VTZI7JwUQZXbg55KI94iLNe6Ht74+IkemW+fTdpeLuxlGE0eX1U5eXhWYvGd72aLd14Q63ZNpJ7SgHcOY25mCbGoiQzxwlyRtOgyrgHi7Sbi07qCVIzSAL6CkUnnZ2IG2caAUb49iZrUr5uqlpDV/IiAMkwa11OOn/lWBE/pGEp/8nWV0MvG8VeMINZ/GJ+j2LbfR6lySFXU8cKpiAwsuNo2Ufbza8f8/7A6a62UKZfXFrwKuNLNVBTVx0ULNxpAS9rY2MyIz6tAqR7vHf/pYI+K1iX5n3efE92+66mZ8rdOwX1QdsaUANHzmmwRUan/lfG9eNKAOFiGNur07hvwejroAisTnj762EVvirkxug0DcNxRAYQMtAoaJVI8jQUgZAJKiL7zg+e7HkbcYJAAPLBOnP71E7WDOiGlZlkrN6h5cn5lnQF//7Q0P/c78ub2qS4gfUzPyPxH1i00dayfTwz2fe0YQ5JqR4V/QXhWxhrVL+a2F3Pr2WFRHKMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39850400004)(396003)(136003)(366004)(52116002)(38100700002)(86362001)(38350700002)(8676002)(6486002)(8936002)(6512007)(26005)(186003)(16526019)(316002)(6666004)(1076003)(6506007)(478600001)(2906002)(5660300002)(66946007)(2616005)(83380400001)(956004)(66476007)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Nz3qcKZm6CymuGWcTXKruAd/4IralKfsbddB8KiiWzQ8hhWL8I7X+odAeDuz?=
 =?us-ascii?Q?7u6kDr64ptM4+fMsucoAQYroe4qRtWAsnWxCjhFiUn52pHLUGn4aY/wfbDQH?=
 =?us-ascii?Q?5KEWlfsDauFSiN4YVqRSR2tTgpbZJ24ftIDVnQo2rM3c2tOij/ZGX/9TCUta?=
 =?us-ascii?Q?LbFqVbLHKLeAedcH7iEMWskA++Z4Sn7NJtvSABIoxCSAAFOkaOHEmyiLx7VT?=
 =?us-ascii?Q?Hb0QYbEnRDCTQ+XS/ozJOTH5+2IPDLnetDGsSIDX1OE7wlB9mHpBlE9InE4u?=
 =?us-ascii?Q?VsHsZ3bLOcllMgRcsFpVR0FtSBOxmvBiU/7o8p2FI5FOOMhoF1i8xv0wlXP+?=
 =?us-ascii?Q?C1sMXnv6i4OyPy3z0IQcK9T4/U1dNB+MVh80plXx7n4qcX8+JHP1Df93LmMA?=
 =?us-ascii?Q?4f1yFvtqCJsWTWOj/9GtuKo2sxTawiOSaz5IS24I9bDXOke/k6k+fvliOJ6v?=
 =?us-ascii?Q?dWnBNVmbt/oTs0yTkSxKMsle2dzoZksHcIfHzOGXu27U5cA47T685+akswHy?=
 =?us-ascii?Q?UO75juFMJ0EYu1391lachnnyLOJdg3DPbX6s50EqrbfRr9/s7lsZFVADEYMQ?=
 =?us-ascii?Q?Iwxa/tH3Rt92c+1UrTHmdiDq1/a3Wp18f1OXsV4NL630O41P8vuI42QkJCuw?=
 =?us-ascii?Q?pdsQVxrfhbf86pi1hSqOwdx7LCzpJcGw/HbZoT/V1kkUClzvM6hPVAtuh+u5?=
 =?us-ascii?Q?LxsS0jxO/dQRc1QNTRYgyFR16P60dE1JhmT0P99Q+TsC72TlP0QT4Zj6Ox8/?=
 =?us-ascii?Q?pJ08Jexs/eVa8F+ft3OrWtRVmIOSwKl7QCtuQ/uIUGnwRg3cKJZeWr2qInWz?=
 =?us-ascii?Q?2ccRMN9XFYgkFbjBxJgP1bWEgimoDqOiAO7QPXpMCql9W01N2u01Jg9iwbk0?=
 =?us-ascii?Q?PW99upG8eZtWC/6PqhWpx70zSAc840a2igJq7vONJ3yfF/cWWH6zWfby2YRX?=
 =?us-ascii?Q?SMTbqJU8PIf1AGQeoC+KdZO3dMXN1FtuXC5rwC7RWGxEvYq1/BgZGYQhfaj9?=
 =?us-ascii?Q?nyu4JDLsFuRJS/xxuj4AI07tv7epd4SrJCIBXsRspF/LnnEz8erB00pWZLCK?=
 =?us-ascii?Q?VsrnsgVtXL3VsHCV32Fn+xN+1PkKdCDpqYpIlhvYfVHxIShclV480x12lhvn?=
 =?us-ascii?Q?dfD23d1PX3PL+VVK/wYEfOyA4tRY54mWpqZzlL6AlVtmhubDNea0QJRATDcT?=
 =?us-ascii?Q?syjSKoeSMo/YeNbgVVAASdWWUOrcxzckoSbPa8ujHtNydKSy8mNhDsy5c70+?=
 =?us-ascii?Q?pVgNpH95BbhinYz+OJlKYkwC+h1sffB8/M35tRIvASpJJGyFnc5g6NSDhiwr?=
 =?us-ascii?Q?nHuXoYc8jEKIEWrNO0DCMzS4?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8ceb0e-bd69-48f7-481b-08d906439150
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 10:35:52.5616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyrUejYoTuSFnQ4qned/MChnyBE5mnwsvqPH4/UFgVxcZ3+LWaEKCRmjj3N8AT2e2FrsTneM1GkYlOUJCct1+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2192
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The general version of is_syscall_success does not handle 32-bit
compatible case, which would cause 32-bit negative return code to be
recoganized as a positive number later and seen as a "success".

Since syscall_get_return_value is defined in syscall.h, implementing
is_syscall_success in ptrace.h would introduce build failure due to
recursive inclusion of some basic headers like mutex.h. Let's put the
implementation to ptrace.c

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
v1 to v2: Call syscall_get_return_value to reduce code duplication

 arch/arm64/include/asm/ptrace.h | 3 +++
 arch/arm64/kernel/ptrace.c      | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index e58bca832dff..3c415e9e5d85 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -328,6 +328,9 @@ static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
 	regs->regs[0] = rc;
 }
 
+extern inline int is_syscall_success(struct pt_regs *regs);
+#define is_syscall_success(regs) is_syscall_success(regs)
+
 /**
  * regs_get_kernel_argument() - get Nth function argument in kernel
  * @regs:	pt_regs of that context
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 170f42fd6101..2c84255e1e41 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1909,3 +1909,8 @@ int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task)
 	else
 		return valid_native_regs(regs);
 }
+
+inline int is_syscall_success(struct pt_regs *regs)
+{
+	return !IS_ERR_VALUE(syscall_get_return_value(current, regs));
+}
-- 
2.17.1

