Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84803951F3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 18:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhE3Q1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 12:27:20 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:49274 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229599AbhE3Q1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 12:27:19 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14UGPEmC026430;
        Sun, 30 May 2021 16:25:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-0064b401.pphosted.com with ESMTP id 38v7a6g549-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 May 2021 16:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxT739fLAG2EAIW+V5PDLIc1oZCst6wEpkWH69M9a/mTE9RAmUx1/KPelsBc/Yy891+6XLpqaQTq3cLczNjjpBgC7Bx4DvAvoDB9LN6tvQJ3xRKX/kfbOanpTIma/HiC+h560dM4IQB34syrHy3NfegDyaFRxXebozbgR6cBsg0kgvjOjEDcTYywXEEA0ufq9DBwrdqFpfDpgqQMICJ3bOljJTZbd5f2zsuVDE17c6bYKQxBV01XcFK0iF0PSxab5Xk24y7kH2peiLiJgORNYfBCM42ysXjtlKZHmHeIwsSRea47pkDD1S5Ew/9CUX84+ZSB5Kl77T+7EXUqLd7UDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYUUQZyF1XgCpAylebZ7/nupGWzi0M7QD2RMJOC9+7s=;
 b=AoRxFXvqy+HbifqJKMWEBKh+I7YxRzv+eeGeIch5jwmMOvNYevl/2PxOnik2d+87RfU4SdDsFMd/NaRcVLlTCQki3A77hecWxYTGwMzIs5QWdR2QVXJzXi0BcAWx8r+YkYJRzvVn0aN572JuROpTVCKh7xW/OwPlcRDVFU1OG5yxomZCWJ+JSLBPSza7i8pSUA0m8Qtjl8ndKwHWCIaKQf7vCY8TugVZooDMIBF1IVzuIZsfQhvo9XaYKr/Gw8KZMF/5SLml+BAOLRkn0saMFDIXKkcvtrxtsbHbiSgqV1D46UAhCoKy5TqLa5lGVcNDWyTTs/oXUis0RtqzhdlJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYUUQZyF1XgCpAylebZ7/nupGWzi0M7QD2RMJOC9+7s=;
 b=khkLDMUI8l8wavaGsTYJTu0B9q0W4xmvX00D42QLD+3Dv1YkBHQytRakEEqLF5PPpdWOYus1mudVHkIPu869+i7QQB4YvNyGEYvN1vOTxO0sBgTDehYRPVnvnOqe7HL+239dIL1cHcJemQZS5nLnDLrxvq05Fmp4RQrqXX+JWh8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2633.namprd11.prod.outlook.com (2603:10b6:5:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Sun, 30 May
 2021 16:25:13 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea%4]) with mapi id 15.20.4173.030; Sun, 30 May 2021
 16:25:13 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Garrett <mjg@redhat.com>,
        Michael D Labriola <michael.d.labriola@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Renninger <trenn@suse.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/3] x86/reboot: document how to override DMI platform quirks
Date:   Sun, 30 May 2021 12:24:46 -0400
Message-Id: <20210530162447.996461-3-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210530162447.996461-1-paul.gortmaker@windriver.com>
References: <20210530162447.996461-1-paul.gortmaker@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24)
 To DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-cube1.wrs.com (128.224.252.2) by YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.26 via Frontend Transport; Sun, 30 May 2021 16:25:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80594f75-a9a2-4bcc-9a20-08d9238780a5
X-MS-TrafficTypeDiagnostic: DM6PR11MB2633:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB2633B0BE895A8D3DD2808A6983209@DM6PR11MB2633.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BF5kHE9NdxUlJv+uMMYmvlY6dge13peIvr+2xQAFiiPgQmozTTF8/mNLR+wdFYRsMdUH71777+0Me6fYomYOoBm9cCF9OlJKNAxqhLeLwoCpkaajqehhnkGcqq9Ql3eIWmRSObyNrHu33d+JClcw2U7ymDGCqrYRe2g9bYLkbYkF83xBIj7csci5TjfygPBKNIavHUcApOhcHiYmZhDoWHZ61e6XIByUKdl1BSmvZZsrZqfyk8PfD47y2d/sMqzJL9QyGnCbk5C4RXw8wAQOaZk96MhBNsQJrWcVOUs9LIcmNG3+qys3uNpYc72XH5OoA1R6YRCV04KjN7sgOzvi0PTh9XAVzXVyZxVdGk0asTtXk28mgmv1waqntDUm2oSLKiFnBDUR4neRfqGvQC9D4CH+OOprtqnXyt/VyWiHJSUVRox0FUbnOr/XT7XqWvFPe3F+Ap6Lh8ueZHG3LBvsqMPgHTEqIY8HKcLuw2gWKKXc0+1ueURWbjXdbmdKGMFiGYqYFe+ZG1Izxw4rDuf7SA9/ni3/DMDovSFTanoyuUObGdXoByhMh6XCK9kjOhWWPgmFm4vXi367BfpYwV7gaV2QCmNZBXLOIxDH/yzKWpi3hRKImg2QcyIVxnXnO0cK3yAfMI5y2G/4iHkG5HUVhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(39830400003)(396003)(4326008)(8936002)(107886003)(7416002)(8676002)(6486002)(6666004)(478600001)(83380400001)(956004)(44832011)(2906002)(2616005)(1076003)(66946007)(66556008)(66476007)(16526019)(38350700002)(38100700002)(5660300002)(316002)(36756003)(54906003)(186003)(86362001)(6512007)(52116002)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sPkgH7qMjb8PzzyaVj+XMYXQxa/47Doj0moe8fvtjnY9hLzl/9fCo6X8gqIa?=
 =?us-ascii?Q?luRgUrHcGQGgCUw7ISYcSj+7R99uJrhAef+xeMW7bbKkFmwAddEsxPAf/WWq?=
 =?us-ascii?Q?cpjquDAzML3UhE4/hEUMUqZ+xPrJ3zdrxtGC3a9Ls/Kx23+RL0th9Vy2D+cY?=
 =?us-ascii?Q?oMj1AWXNOB3FQHarcjPmeO4+GYXXdUOe1EWuheKPT4lKJAXGeMuDOH4Rl0cm?=
 =?us-ascii?Q?4VZeqdlanaZ+EcR77j1Dh/CZv0qz8aH2g5YGthAONSoMlUq8rLav3/2+lRUr?=
 =?us-ascii?Q?E1VVmCAWYtMqAZs8gsntzW/8CiPijrkCWunsSBReLQfTe/QVmrVG+oe6Ep5H?=
 =?us-ascii?Q?n3wGTZUAI86TUU9NxoQKwjOmNigVlMpsV72Pbq1ob1dHv2NC9L174fEuk/rk?=
 =?us-ascii?Q?cYEp5tC8GWZ1i+Ded/WODVSgNGkFVD0k2x9sKxk40/JInEPn4WTqawO1LYRe?=
 =?us-ascii?Q?gedsJ1LXDHmbp2+SIsXKJQjs9/Dq/lc6dK5GLepiEokUNFF/aAHDy2+qobMt?=
 =?us-ascii?Q?8A9fQUSS68guAS9MjR6Kzh8Ae1+fq9nj7TtkQ5xGPBymoZDS/nd2ExBO9DGl?=
 =?us-ascii?Q?G0S9XQwhw9/fydu6dlKXbVv5dD+XEc0Vkact2kaIQHGiW0jcdOUPcA+fBqBo?=
 =?us-ascii?Q?MJnnxyX8GWH5gh8/A7ZRct/uHhVN7Xf0NrmgWLxXR3shnrBMXKfAww5fRNjs?=
 =?us-ascii?Q?6UEH9IU8MAmzcfab9gFBwdEjflqusm+EF3/9EpeLzSjk1b2SwDEsPyIMNOLn?=
 =?us-ascii?Q?+zRFF9qijOuEvYJE99gzQOVG08mkkAIC1GaJY4CeAqHr8c0jfmDXymBt91z8?=
 =?us-ascii?Q?JS/e7GqK8CYoopuHyGxxJ6SIwbJ0k7qB+L/WSjgIA2PQ+jB1Jc/G3VW9UsHn?=
 =?us-ascii?Q?WwoWozuEcFcZvrKXg7tSELbPRUQXaTsTVW4WOjHHfCVy/n93ktLYpnce3oR9?=
 =?us-ascii?Q?WijtTk+RASADxysdx1cO4luKA/g77T8WeqTmf+Zkgaz6OekT68BptFZB9dZL?=
 =?us-ascii?Q?AVoroZxQEAf3ofy79Y8/u1ymiq5xWGjOuokxWTMJUhM7u/zEvXLggW8XGyWO?=
 =?us-ascii?Q?wIWHHjz2ARrUznV6Y7kXSVNN6F4k9Bbgu1hmFhE0du2iRIPtyWmjQjNWzBnd?=
 =?us-ascii?Q?zHIr6t/YfVKnQSn4XmpoiNRHyapsxDs8IsHLeqTHDCuFVkhkrPjWYxqCuNYY?=
 =?us-ascii?Q?9bYezxWonYyfHRJQRP7NiKylZRjCpBKmjixSfpIxvE0MAqLmHGe+5+KMtUIz?=
 =?us-ascii?Q?8ORq6z/3EupLFwBsUisiYamY5O1wyC5orZx3cehypwpsVvr9e/Rzb2Cpee7q?=
 =?us-ascii?Q?+0ai6xHMBLSXtCm98A5iwBBs?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80594f75-a9a2-4bcc-9a20-08d9238780a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 16:25:13.7699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSQoeQyCJ8e7JFTz1rRpZTair/66lf2R0ShhlApl9MSjoI5jwoxbQ1zMBNb3pcA0HLVdpDChiYEpVYHFZ19KKXYuKQrYAixk8i8ds8Pxz/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2633
X-Proofpoint-ORIG-GUID: guDns05NoacEo-YLE3qF3yXMVCJSV202
X-Proofpoint-GUID: guDns05NoacEo-YLE3qF3yXMVCJSV202
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-30_09:2021-05-27,2021-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105300128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 5955633e91bf ("x86/reboot: Skip DMI checks if reboot set
by user") we made it so that you didn't have to recompile the
kernel in order to bypass broken reboot quirks compiled into
an image:

 * This variable is used privately to keep track of whether or not
 * reboot_type is still set to its default value (i.e., reboot= hasn't
 * been set on the command line).  This is needed so that we can
 * suppress DMI scanning for reboot quirks.  Without it, it's
 * impossible to override a faulty reboot quirk without recompiling.

However, at the time we didn't really document it outside the source
code, and so this information isn't really available to the average
user out there.

Here we tell a little white lie and invent "reboot=default" since
it is easy to remember, and documents well.  The truth is that any
random string that is *not* a currently accepted string will work.

Since that doesn't document well for non-coders, and since we don't
know what the future additions might be, we lay claim on "default"
since that is exactly what it achieves.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael D Labriola <michael.d.labriola@gmail.com>
Cc: x86@kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/x86/x86_64/boot-options.rst       | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 29a116b590bd..63e391d7045c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4703,7 +4703,7 @@
 
 	reboot=		[KNL]
 			Format (x86 or x86_64):
-				[w[arm] | c[old] | h[ard] | s[oft] | g[pio]] \
+				[w[arm] | c[old] | h[ard] | s[oft] | g[pio]] | d[efault] \
 				[[,]s[mp]#### \
 				[[,]b[ios] | a[cpi] | k[bd] | t[riple] | e[fi] | p[ci]] \
 				[[,]f[orce]
diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
index 2d2810409cc8..8593d4f87cf9 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -157,6 +157,13 @@ Rebooting
      Don't stop other CPUs on reboot. This can make reboot more reliable
      in some cases.
 
+   reboot=default
+     There are some built-in platform specific "quirks" - you may see:
+     "reboot: <name> series board detected. Selecting <type> for reboots."
+     In the case where you think the quirk is in error (e.g. you have
+     newer BIOS, or newer board) using this option will ignore the built-in
+     quirk table, and use the generic default reboot actions.
+
 Non Executable Mappings
 =======================
 
-- 
2.25.1

