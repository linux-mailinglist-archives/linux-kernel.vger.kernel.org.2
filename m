Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8ECD338493
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 05:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhCLENV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 23:13:21 -0500
Received: from mail-bn8nam11on2042.outbound.protection.outlook.com ([40.107.236.42]:40833
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231278AbhCLENH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 23:13:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSGdtfu5IwyPAMFd4UPaN7SvNCZmIeIpPVTbdYly7hkg3AB2FyBqKgdBTfiPLW0EC7UMojXIN1cFmA3LgE7VAd6K+WtuM3npG6l/870JHRvZ1gX03YLFVfaq/JpHPEBwthBmzsjVbCDXtPLE+VRHXkOfDSr7BFQh1vlgyAQYK1mUhgy9iD47C5fWgF2d6J+MvmIGbWEY19hO4JAusJZAQ0hcG9HIrEGgS7VXpbuKxaNrTremsCdTYCLWmJBMqvpLexfL7YlU3BszB/x57ZGZUi35JPThL9YFXSHdb24C5bCqaBC5qMwEnjnYGKZod0UliZGUCX2auSrVvvOugcc9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tepJHrf0Utw0WtVRLn7jPt2B3Hq3Z/71hptoRDttx5U=;
 b=DGCP3NqXMiRC1DFj+HBH9nsiUK4G7auiIcF4BBUrnS/GdmZRVnOP6Ys+iE9pHCZ2wgt9cumhxQvjmuJ8TKaNo7gs2BV9kfebXeQTF+ifCxD4UsBb5ylKURmzkBdYuW3X41fvsPl2598XJ1brmQEE1d6zHvntWurI9tbVUr6gK9s24t95NMC/A9eO7GacOIhqJ0IpvNO4UlJKixDElhz8PMfTK19GEzR5SsR5sjb4Ms3Pormc3mz0gEm/jz/OxdFNaqmy+ELdfHMNzN+hAORArJ3tYty5AV+/JdeqTrxMScGxVi8DB7fRNiAAL66BkH/JYhzEkNeRDdb6QJX6A9yTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tepJHrf0Utw0WtVRLn7jPt2B3Hq3Z/71hptoRDttx5U=;
 b=cbHEqcTW3KFh+g6SsbSegkH1LD7TIGada2JZZXI/bdM5qCPjLPuqLVXkZctgN/aMVWQSKerEHENICLuWukABDIxRdKuqf8RuNRz6aBRpHCJ7UZurPzUqUqoUB9B1IdAxZqW9qOFrefOwFyZ4is9vKmvUpy993BZEGF8ldaRKCQ0=
Authentication-Results: armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=none action=none
 header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2534.namprd11.prod.outlook.com (2603:10b6:a02:c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Fri, 12 Mar
 2021 04:13:03 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3890.042; Fri, 12 Mar 2021
 04:13:02 +0000
From:   qiang.zhang@windriver.com
To:     linux@armlinux.org.uk
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] ARM: Fix incorrect use of smp_processor_id() by syzbot report
Date:   Fri, 12 Mar 2021 12:12:46 +0800
Message-Id: <20210312041246.15113-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0401CA0007.apcprd04.prod.outlook.com
 (2603:1096:202:2::17) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HK2PR0401CA0007.apcprd04.prod.outlook.com (2603:1096:202:2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 04:13:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38b6ad68-5cd3-4706-5138-08d8e50d20d6
X-MS-TrafficTypeDiagnostic: BYAPR11MB2534:
X-Microsoft-Antispam-PRVS: <BYAPR11MB2534331A71AFAED8E4D929BAFF6F9@BYAPR11MB2534.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2orxo2X6PSug6aIJo12WlpfWxGNtWhzOp/yQIyazxR62MbHqyIU+rQ2EqR+QWMC69ma3MiEPqLBrABCvq0H9ujA8hC6KKZzN4OB/UZewuM0E9AXlCTitcUc9Rei+K2kDs42RnS5at1fK85rcnAuHwyjJTdsMQLruy5g02Fu0qrAvcnTDsyo+sGCUbTvSn5JG/tnuoFNz+aDMnBQQdE8eewp5zG8z3qTJvS26qMiBND/mwrV5QU2UC6yENYCXwRKifHv49RpdAIApHIH1LlhLdCNWCnlFLnldFak3Vqx0YPMt4FKgMGQb2MzwRZ4CAyXaFI68SfgSeWX+JbwjUnFP5whY13mUr9DsPsUCIJF9KKin35jhzoZP7ge24bA49gCP/4Ri2fKAKJO1r4W2G8aUFT67Ls1Me7tkzUoNDmuGppUQoKXyGDZTTCuaApf5kmmcIa6358l6mmMnLxhtXDZuRcwnAr/TGA8u1p3FTFbXqbOetMCzaOoNSWZXh00YUi2n8rjtXJkj8l0l+S6q4hteRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39850400004)(396003)(136003)(376002)(83380400001)(1076003)(4326008)(9686003)(956004)(8936002)(66946007)(36756003)(186003)(66556008)(52116002)(6512007)(16526019)(2906002)(66476007)(6666004)(86362001)(478600001)(6506007)(6916009)(316002)(6486002)(26005)(5660300002)(2616005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4T52FLxAwcUIuUQXdCGp3r80V2mYj6HP/Kleu7h8FMdAOqt4wSKJj1uil8zJ?=
 =?us-ascii?Q?7NAou+hY6J1pcC5EXsRZZLRIj7o1V3/laRj1f9XVxCzazaO14Qffuyz/vsvZ?=
 =?us-ascii?Q?lCHPAj3Kzupxhh4S/s/3t3Qyok1Ab+bB/DbInZRI45NMY4vPzFWIcRjbioWt?=
 =?us-ascii?Q?Px/RnXoCoiKkvknEHL3oxWWseKlTdovPzrCpSrL8wop4WUtV2YhRpOmNuB+j?=
 =?us-ascii?Q?FBLXvYpNQx8hM+iEfJ8DLl8jdSQ9RwLoJCAgheboMxsoQ23Pw5iVFCGfDslj?=
 =?us-ascii?Q?P/fb32NvkFvxKw2q4SvHkH6vzdsL9fOAsen3qogUzzp9kFP8JgRZ1uv87cze?=
 =?us-ascii?Q?eL/7kvzwzZAqyFdqAaQQ1M6aRIl0NKf+bIg+iKMRzPFA7lbtPnh4XqLlVyB7?=
 =?us-ascii?Q?ckZ4YBHIJKKStoQya4ulQD8Ot1yU9EbgFPrKmeUAdA/Z7Z+Jy3Hu87ZIzyYJ?=
 =?us-ascii?Q?z+PqpJuXlfWsZpeeREONmBuDLPVWPO33U/VtUGqHnLe38+dsU8olB0zG88Dn?=
 =?us-ascii?Q?SUxvMglIynC3b6yaq+p7H2qJJNtZV1KM7gqPFDerIUeSOWUObzUMALeWqUOb?=
 =?us-ascii?Q?rd8KJAWElkfGJJgFBPVdZcD5nGQB7/FKCDevoZMt5yZN8TdLRB6PS2Z5y5Wb?=
 =?us-ascii?Q?AvbhfgHt4RgIfD7f0mWi1lXMMdjeMJDxFPTULSJyxI3YdLazogtrxTEtehSP?=
 =?us-ascii?Q?1lu+2chANk2A0+T1aCws8uIEBtVVl6UfX/dq6WNmCPQNHYlP1asS91AWHJyf?=
 =?us-ascii?Q?k1zDqsCPaXzvCJxeV3gnZmkdordExGrfcM5CJCsjreAiFhak2eXgf3R+LlAZ?=
 =?us-ascii?Q?YApOHWvG3wTGpu/589NMAtZQ7ZMvGYi7xRe5/jW5qr9xEi7akjHNGKZggTcQ?=
 =?us-ascii?Q?QrctTJbSFfUrc+0lUtgK0JBi8j43Wq8A3kmRvu146OisSoq9aurIkHrZMATC?=
 =?us-ascii?Q?0u7qHHDD2DwFex8hXoYIJSUGMNwCtjEbj4bGxmcMxCX4O5RzTW30z0395LOv?=
 =?us-ascii?Q?d1A32AZS5UNgnJrD1sYuttFfkyBUdMsHAtQdZPv4BpQ2/LLVOjrHL9B0Tzd7?=
 =?us-ascii?Q?PHCH80VCcsxVyn9EbNeXRTJbNHrlnnU3/QzNEyKx52aBEFh9rucs3UNJneED?=
 =?us-ascii?Q?H+nNILuaqJi8lA0J1qyqFCVjJ5SJeAwpPDn8ZysWf5x9PumXJJKrl/yvCMBQ?=
 =?us-ascii?Q?+sHvrGiB70JHXhISDSvft0lN2H/x1+KbRNpPwVJYD9FsWcjUuBJa68sQ0Qn7?=
 =?us-ascii?Q?FMqQ0nuZfHb6CueQW4exMElmc3MkoKM8iLtIV3Lr5dqLEFqyJbh03ejjmQxJ?=
 =?us-ascii?Q?rnMnuyMp4UgBzX52HkBLsZcA?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b6ad68-5cd3-4706-5138-08d8e50d20d6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 04:13:02.5244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/QPN4E58ieVfpTIsHdGtCVMVZdgMjwy/70EnmVZ1Yz8FT/MOra1MO3Bhn0PxpHNslTb4hcoOLgzQ/h4Xe4+P7y7eQnUpRbEKq0kkGmqdsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2534
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

BUG: using smp_processor_id() in preemptible [00000000] code:
syz-executor.0/15841
caller is debug_smp_processor_id+0x20/0x24
lib/smp_processor_id.c:64

The smp_processor_id() is used in a code segment when
preemption has been disabled, otherwise, when preemption
is enabled this pointer is usually no longer useful
since it may no longer point to per cpu data of the
current processor.

Reported-by: syzbot <syzbot+a7ee43e564223f195c84@syzkaller.appspotmail.com>
Fixes: f5fe12b1eaee ("ARM: spectre-v2: harden user aborts in kernel space")
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 arch/arm/include/asm/system_misc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
index 66f6a3ae68d2..61916dc7d361 100644
--- a/arch/arm/include/asm/system_misc.h
+++ b/arch/arm/include/asm/system_misc.h
@@ -21,8 +21,10 @@ typedef void (*harden_branch_predictor_fn_t)(void);
 DECLARE_PER_CPU(harden_branch_predictor_fn_t, harden_branch_predictor_fn);
 static inline void harden_branch_predictor(void)
 {
+	preempt_disable();
 	harden_branch_predictor_fn_t fn = per_cpu(harden_branch_predictor_fn,
 						  smp_processor_id());
+	preempt_enable();
 	if (fn)
 		fn();
 }
-- 
2.29.2

