Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704BF361AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239269AbhDPH4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:56:31 -0400
Received: from mail-bn8nam08on2073.outbound.protection.outlook.com ([40.107.100.73]:60522
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238743AbhDPH4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:56:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTvVbusU5XhaqrA7/2lPlUTZuJN/7nKdg+esHhzqd9+f05jDM6nydDtv0Yacphe1Nd0EOktexyzWCtmohTEwaeTqyFcqgeCSSWfWm9s5jakcuVU64E0thkBEGfPRPBLX4KR0xuHPhxGO20DLej+er4p8hxZuiDrd7oDC/uJttlBx34A2cmiqcY6XzKrVdw0UV2ktnvY8PB0+cxk7ESLCQMKGoW1WY4RsxhcV/GvVjnvfqBlH/d9c0LAf9qjpOhuxw7CH1f85Z8jhjBv+zcddATf7H7ubHCqlGC2hPGM1k8t5RA5XQprGEVQU33ZKuNGVaUzer6aJCxf13IJxTRMiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5Q7H4W4tToocGKvccHW72K3qZfYpxccSAhc2wz2uKE=;
 b=JQyMfAUHnTkpZr3aCSpIs0UoDCxE8c1h3l0dxaVPKQLj8/g3xFyVfjKa34qYxgUmTiDJDIdzb+Eap02U6a5WNbUpej5qmYr+QOjCo+d8O4VUPykC0vXFP/I3kWsTM6j0mF0Ny44VleafcnMzT6A5dppngySFjDSsI6iyL5U641OKfD8kVnUR65kCfme+kgJWRzZ5MtMZBoErVGTcClW+mfaAFOpD0aFExtwD5Mv7NBEaQcIbp27+BFqszocCYA3iLNRtoXsCHnIjfSE08A6RKes8XZhnCaZws0mRsDunHvIdSGZSziZEamzyvdg9PNKwMOqaHynFi9m07x7xkDDFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5Q7H4W4tToocGKvccHW72K3qZfYpxccSAhc2wz2uKE=;
 b=iKI8VGoBhfYGxfbblbieedEbMoG9/7aNBnjNlyI7hmNQAJql0ZUZFANtDno+FboMqiJhkN4freI0xixhXFjrVdou2Wq36ekux9KZdIWTqv60wiVRKmhN6zzx8Qw83XM4KEqLQIZy4ditFOloyi8qJkLq0q1FFEmMyw8qnezjU6M=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MW3PR11MB4763.namprd11.prod.outlook.com
 (2603:10b6:303:2c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 16 Apr
 2021 07:55:57 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 07:55:57 +0000
From:   He Zhe <zhe.he@windriver.com>
To:     oleg@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH 2/3] arm64: syscall.h: Add sign extension handling in syscall_get_return_value for compat
Date:   Fri, 16 Apr 2021 15:55:32 +0800
Message-Id: <20210416075533.7720-2-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416075533.7720-1-zhe.he@windriver.com>
References: <20210416075533.7720-1-zhe.he@windriver.com>
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0064.apcprd04.prod.outlook.com
 (2603:1096:202:14::32) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core2.corp.ad.wrs.com (60.247.85.82) by HK2PR04CA0064.apcprd04.prod.outlook.com (2603:1096:202:14::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 07:55:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9c2a640-e921-414a-7bf5-08d900ad1128
X-MS-TrafficTypeDiagnostic: MW3PR11MB4763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR11MB4763E2FDBDDC1720C150F8918F4C9@MW3PR11MB4763.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AG/CnU3+8juEWV6lQCKsNEnlDrVBNTjFXB+6rhN1EkJqgRWXTncGGAEPBbEfhe7Z5AX9CQCU8cyScESAzt0eqFogFiAGj1qxypXUGQl5+Z9iW2Q13Bm1dXGnR4YQkkVTvchPndKW+5gFy26LIDI88w+EprjIyDi/K1Dxp93VpJUpsGE/+i8lPvaZbmYMIGBeysYlK+9FdBXGDUFXr3EBRp6lZ5dPVijlEZP6hKDi/49ckSnfn4WyhuFd9Ken6WgUadwyKla1dpJrEx1CRPN9VM+lpuQFwRdpt3zCY2gxH/o+usqBeim7inhag2irqJVEYIPlJc8YxHVNrp1vZlA0kHQwJnQPvTXpTLh4m13CKL8kLvqOtOYlp8FjQCwYYmTnJhPhBWXGlGLYstfnqdmK7PpolVHYbkV4JYX62khTWBV4SwDHDxX3Oj2vYXRZ/TWKtKYBiRpJmZHUluioR5U+fy0tUB8bchP1VVFemyGdf9LhvY+OBeWULStw1JVmVW0PBYRhXJXsyN9Pq8rfFApRl6SiJbqzkjomu4W1/myfn514KsJ11xpL/M2oB2IGoAZ8pvl2YhfIJaAOQaaTrNWwfVNtJAtSieu92znuwOK77tRLhhic5VK2XGXMpdP3+XFu8jFk63U3QGNYk7STkv9xyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(39850400004)(376002)(16526019)(8936002)(38100700002)(316002)(186003)(6512007)(6486002)(8676002)(66556008)(38350700002)(5660300002)(956004)(4744005)(2616005)(26005)(1076003)(2906002)(6506007)(66946007)(66476007)(36756003)(478600001)(83380400001)(52116002)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tOiPgk4zDxCwDQKgdtw+xrZ5TaGWRro1ojrXqpcnXdx7R5M9JWmMdfr4d++T?=
 =?us-ascii?Q?BrI7OjKvbyuSdL364moc9CQ58wYeF0uyEVZRChgecXSHHzDbQyVUFzSqM74l?=
 =?us-ascii?Q?+xSarRE+ygMlUA/VntWYAVRnEhhFU7pG9qWoLYknUE8N9bv+PX9quWrLxp65?=
 =?us-ascii?Q?kWVeDOVUDMpRBKHA2ITRJnsCYudJPQ2T6V323S5zlSBRyULGd9j7+M4mC1Q6?=
 =?us-ascii?Q?kpciISviiiF7Trdu89V+Nt7/6TA80pKeOEi83JxqIqpVmAavyhkzOggKdkfz?=
 =?us-ascii?Q?tY2Lc3amgSW+4yRzzkTwGRd0iXnK+s55L8jCc15NsocSaGpM7o++n/Ea33o4?=
 =?us-ascii?Q?8tf2N4e7qT7ZW+NBSGzXjcupyNbzyQ4G/kOUN/Wgj1+L76xkioHM3zvPOmyC?=
 =?us-ascii?Q?XbRQcpwbjogjKQdSDVE+zg/OaZsengQPWz5u+bAJv91ObjCrdSitrVxAlBDV?=
 =?us-ascii?Q?cgjRr29v7No4aFLQoYEp3V50smJN7uoZRZC184KglzRQNasiSbZD4tmpHo2g?=
 =?us-ascii?Q?0eapXywctb97k7qn/p0alDF574xoVN6sWBKwiu7MmjNHyjfokGts02IVJsfb?=
 =?us-ascii?Q?cv4FWD80UWHuK40KMfGuV2uYF/hGPMOMcytjPte0O20cdKvc0TRuJ6eALI+c?=
 =?us-ascii?Q?L+DUDyO0Nkl+mYTuL3VMiH95cNY/VjAQNtYzR63s73Jm2YEtsdCUsAFShFhH?=
 =?us-ascii?Q?OPFNrd2e9xLf3tFXhmxp8dM+JamNC2H0cAGPV/xocncSWkaZCwkC+s8mn2Zw?=
 =?us-ascii?Q?6Ue6H71WeM8D3jMht3mwwA1ubZ9qq/VRlvTfePQrQ38TZskjEl4lnNC9OYwM?=
 =?us-ascii?Q?aadr5lg2MBL987eghWaJP4dG/nn7InrdjGfT6TNC9qtcz2zDjAGCUAmRpE5C?=
 =?us-ascii?Q?+wYJxo/4bwJjBnzX2jpiYogNbDR7tqY+VClutKzeCpExAKw9fgaOK7MI0fiM?=
 =?us-ascii?Q?srbYhvPwGz9QBiJc9iEEPvMAEFQf1l6Znvee+xDEo7ZuGuuUQOgpYwtPk5dO?=
 =?us-ascii?Q?aT8yGfGcsZFFBN7MrWKTfmvR73d/iXYkKY0jfa4sk+PxkmLniKmYQGPMpLbH?=
 =?us-ascii?Q?p386vfMajoAkYvZA9h8hI+OUmtq8NMCpLDjccZS8Nwj920xu21mMRXHCs8h+?=
 =?us-ascii?Q?uaSOSQlDct4KhGT9vhKoP9V7qocvOmIqe569iCZ6TUwQ4h7egDaQT3Pr5ozQ?=
 =?us-ascii?Q?RfqYwRg1fY9pSLh8bQ/46Gukrbnt7XbG6zqr9LE1bRamzT4T9acWsC/59PKj?=
 =?us-ascii?Q?BTeJpAHhVCsomOML2UzbwQRZ9rGKx00Pby4hlJBBV3+ySWkV0LfiO4WVWNnM?=
 =?us-ascii?Q?Xmn+TVVQuooFLDYFdLbnINmA?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c2a640-e921-414a-7bf5-08d900ad1128
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 07:55:57.2421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dupci3xkHR8tZtYMnVoIZLDgQxZT9rbLhz3bkYxXxMndrgEewpdqbIis5c7a0nMDquTF6ogaNPZtUTMowl+JCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sign extension handling in syscall_get_return_value so that it can
handle 32-bit compatible case and can be used by for example audit, just
like what syscall_get_error does.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 arch/arm64/include/asm/syscall.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index cfc0672013f6..cd7a22787aeb 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -44,7 +44,12 @@ static inline long syscall_get_error(struct task_struct *task,
 static inline long syscall_get_return_value(struct task_struct *task,
 					    struct pt_regs *regs)
 {
-	return regs->regs[0];
+	long val = regs->regs[0];
+
+	if (is_compat_thread(task_thread_info(task)))
+		val = sign_extend64(val, 31);
+
+	return val;
 }
 
 static inline void syscall_set_return_value(struct task_struct *task,
-- 
2.17.1

