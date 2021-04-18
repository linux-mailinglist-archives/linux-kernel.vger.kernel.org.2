Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699293637F2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 23:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhDRVzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 17:55:14 -0400
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com ([40.107.94.76]:4385
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232491AbhDRVzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 17:55:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeSZCq5Qdo7mQZXK6vxNpkPlqkOWnCmUAs54cG0xaaLVHTR4wtCDw6+Qmuqnw3ffJkPvITRyhS0XH6lXknpIkOv+Xfs+zjQbEsqzwy+UW2XQL/fUOnuHT1DPrfOUtz+T5PB7ZR5kuc72QmaBYGxltYl4HXSU+LTdqvO4Em3WgTabBPpTi7OWWwF7HDHanDRaaj+IPqXOjhACfq8BdKaiUySBHnFyQMDJBwf+zprRzcS/nnb9ZMTdyOsTxHzKwL3zkpYRl2iirBfL4WTWBW9uFn3JKyOdkSryrjvy4DWU3uj/nZYalDVkA5VXPs3YVvnJd6AB8P/cdkVDVzYXvTkvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEqawFLHWyWnxa6mCs38iyDcL/PzZEHGkt/XLJoO41c=;
 b=fXEklJnC3/0TkN2GcvGmlCXSOhNvGYqDhyCyhT0I4y1llq58ybjLJu4XUHLBWeb3oGuTbOGasy6lOxWc4mHUpCO8iZ04B5ojkIu5w59vHLJwEdRw4OwpsqKb7IpUDqAM5XWxOojoIzyDhI024prCZFNyfOVj5ccDRUMajj1hNH9+PH6PGuotxfXT6g1+fgv/tQbS7FxIK7vbb4LbPcqKlgrL7NWIsAY4Ykn7hpnX7KiPPqojrmRavMDuaWB/42O5ZTA5hxRdkpVYQoqaFYPWfE2FCTRpif209gkY4ouqFnWInxXmKuKOHlYqYne8N07lSWiIecmkhawEy3YIfROWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEqawFLHWyWnxa6mCs38iyDcL/PzZEHGkt/XLJoO41c=;
 b=ZXbnZbQDKVLr1RtpPdZHnBLLUY1znAQ6GTCDzxfaKR3g0Yjvqmkfe7Da97L/r6+d/BddfkN1DdB05Dhi8oad0uqGrw7NhYP4T/bJA4TKN35Z1JiOYTwc0FSodOxwy1oou7RMIqX0rPwln5FDQTXLbB7rnuOtlQCU2N+1OizizXs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR1101MB2331.namprd11.prod.outlook.com (2603:10b6:3:a2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.23; Sun, 18 Apr
 2021 21:54:42 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%6]) with mapi id 15.20.4042.024; Sun, 18 Apr 2021
 21:54:42 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] sched/isolation: don't do unbounded chomp on bootarg string
Date:   Sun, 18 Apr 2021 17:54:26 -0400
Message-Id: <20210418215426.1086941-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: MN2PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:23a::32) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:23a::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend Transport; Sun, 18 Apr 2021 21:54:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 779c8db8-7902-4f6e-3cdd-08d902b4924b
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2331:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1101MB23311F502C0D4944CAC173A4834A9@DM5PR1101MB2331.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9QsS+5T9AmI0aiclt8kgIqNj3SUeKavqoBGeLyHCmn1ONavx8R/tVQgzvCM2N1teAskspLzHfJwH6q8gWTa0tKZz+LCF7UraK+yxrHmA5zKrf9W+KM5w1KihajXR6WOnUKrpVIneubtza/oyyH0fcfRMPM0klXopZ0G0P6Hl9KWMSY1YL/pW/ANuX5bAg//Jbm0PJIXKNjSGJ2QrV1XCVuGb0VaVjujZ3q35kKnZKfmv2KC5zXR5pYw6rAlLISWwFPF+yilsBNwcp02m1dEpCRtSiFry1NZPbIRNML+7KDTCuJiQ78A3VXjfSHxv/92ye3qBERvSSqBEiezNZY7qMUpxA5CmPEB4qJKaiEGObVukUypteP14wD08Uej9ZF0znTlg1mphS6UWR1+PJNxpjLmu1ZVEa51NGn4B0UU8LOV46oYI8tjwWAOE/kt5rzMVN7gGXskgBFi7fkBB5Ceg3aFVTq8eKDOztTg+aqUVObg5DmioNUVcxy0mkLDyH9fKRiuXxbXRMBVie1oFhLyxSptWw+NgNE7T0sMHfggB6QxcEvQNeiSjqTGV8/rRsbJHnoNP47nsgdctVO+roZO2mQ4S6aVM+KQYS3fiiCH+yDTqLfLJ5oJuQDUEo+Q4f1xl4tGEDTUVQPTdiUMiykdiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(39830400003)(346002)(44832011)(66476007)(66556008)(2906002)(86362001)(1076003)(6512007)(83380400001)(4326008)(54906003)(6916009)(8676002)(956004)(5660300002)(6506007)(2616005)(8936002)(478600001)(6666004)(66946007)(52116002)(316002)(38100700002)(38350700002)(6486002)(36756003)(16526019)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8IfF5fLSOEnhfapYEleBxPInESTnO/kLluXJgDLni0sQ8lp8bAd6O2BY2lHu?=
 =?us-ascii?Q?oSPmax0JresdNMkZX2Z2Ee7n6BXNfarOlIzmNpAJE1wRNVl5YS1Nq6IIThpr?=
 =?us-ascii?Q?Wrml6yJZ4K7BE6dlSwk+WsfymcE/Q1TEUmYtQogezlwgkXJab5zP4S3IYdz1?=
 =?us-ascii?Q?lK+fkNnjzy+rm+brV/l0dsaJGBmbQnwVSV9G1sPvlKw+myjELlQajNYW7n+v?=
 =?us-ascii?Q?dcFpEL9WBN73bbLrmlYxdNoJNBgihU96p9c8m1qycjazQTpbC4KeFr4hKooP?=
 =?us-ascii?Q?u0Mi6457MwA1cVe27aGCbIb/7EZZH9yjCvoEEkDNyOvlgmdGsJdUQquXK2lY?=
 =?us-ascii?Q?Z4xyiy4JRr2pPjbJYzClOq1LS4TWcu56CAmGaXt6IBnIa2VaWPHMh6hyI3X4?=
 =?us-ascii?Q?l0pWx42oQSf/4Gqtma/z0svoeWzmb46FyPoDhavjRG64QsXzilQSuT+a9pUi?=
 =?us-ascii?Q?eNsvCRKiot7MXzYbwmZg1inz0KJh612GxgQHKHTOGOrEMgRFCDRmsqTsn/2g?=
 =?us-ascii?Q?X4qYo4zOR13IO3Ryk3gO+jVS4CbyN8SwlMKpZQvuoCsvDIpNBRsPP7S4DmGj?=
 =?us-ascii?Q?W6Q/sLp8X7+x8sjJLn0/RmlqAQWQhqotX7KSqyEDbPj0h+gjG3fgm0tAyWOq?=
 =?us-ascii?Q?cOiZKwnXVgPfMfou7TKfT6w21o5cstQgs1Av3rO3adWycfcEsFQAJaYL1DSo?=
 =?us-ascii?Q?TGjLLCvbe/naHwNqZ4SIfAZ7SB0xsmpboEi1oTqE22N1udVLDalmolEglHLi?=
 =?us-ascii?Q?bWqBcJMgi7iNhXJOeyOhD273DcKDfdVl1clioRe85ksw+h/boHk0icShLsbZ?=
 =?us-ascii?Q?lBKBGyEJwkrYmv0x5BNkS/vqJROWe60eY3e5p7FlAICn9wRaMb3us/aJBwFZ?=
 =?us-ascii?Q?Ci5rQUmbdVFM0PkipjCuozkKYl77W4sI6Z88kbx2zH7jUqAcK/TbLm2S+AFl?=
 =?us-ascii?Q?QREnvqBWrf969aY8jMeT08dl8jXCOXkv7GJYB0lWa1TG6Ize2M425QRRNzDD?=
 =?us-ascii?Q?flwjLNtml51Q7mti3xexZYA4XYZqVOOW7qowjGkzI6KzmhnuTdk51XPX9YXG?=
 =?us-ascii?Q?0hUsY/w1snToxKnt5iYE/6A6XUMAVF0AFH5sVVnDRwpFCS0O3ZGIoF96QMN9?=
 =?us-ascii?Q?nnx2L/RB1k5wUlk4OKyV6OAaA0DJhguTbXUcGa2u+Q4v3x8KZ2dFgidmAGtA?=
 =?us-ascii?Q?/QTmp5/MAm0sYbHotWVy4VSscDmvQRfgJ2IOeCDLrGDVdjOsRWMu/Egri4Is?=
 =?us-ascii?Q?zpdMY8uTD0f6tm5aV8ygXV/4Bbuc7jRQrKUgVyOH2/CaMDaMXmOYoVUDW5g4?=
 =?us-ascii?Q?rmw3FOiGJR4Izy+ZvL9vOezn?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779c8db8-7902-4f6e-3cdd-08d902b4924b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2021 21:54:42.3798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qx7cQdn9pECrppenEWdqrRLLRR9li6tdDJ6VUPkhbk/OMefXfh0hdqlzawIrAD4r6qLB6H9d/q4LbuNRe3FXTd+DztbpvhX1nXy8dbhHtCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2331
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 3662daf02350 ("sched/isolation: Allow "isolcpus=" to skip
unknown sub-parameters") the isolcpus= string is walked to skip over what
might be any future flag comma separated additions.

However, there is a logic error, and so as can clearly be seen below, it
will ignore its own arg len and search to the end of the bootarg string.

 $ dmesg|grep isol
 Command line: BOOT_IMAGE=/boot/bzImage isolcpus=xyz pleasedontparseme=1 root=/dev/sda1 ro
 isolcpus: Skipped unknown flag xyz
 isolcpus: Invalid flag pleasedontparseme=1 root=/dev/sda1 ro

This happens because the flag "skip" code does an unconditional
increment, which skips over the '\0' check the loop body looks for. If
the isolcpus= happens to be the last bootarg, then you'd never notice?

So we only increment if the skipped flag is followed by a comma, as per
what the existing "continue" flag matching code does.

Note that isolcpus= was declared deprecated as of v4.15 (b0d40d2b22fe),
so we might want to revisit that if we are trying to future-proof it
as recently as a year ago for as yet unseen new flags.

Cc: Peter Xu <peterx@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Fixes: 3662daf02350 ("sched/isolation: Allow "isolcpus=" to skip unknown sub-parameters")
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5a6ea03f9882..9652dba7e938 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -188,7 +188,8 @@ static int __init housekeeping_isolcpus_setup(char *str)
 		}
 
 		pr_info("isolcpus: Skipped unknown flag %.*s\n", len, par);
-		str++;
+		if (str[1] == ',')	/* above continue; match on "flag," */
+			str++;
 	}
 
 	/* Default behaviour for isolcpus without flags */
-- 
2.25.1

