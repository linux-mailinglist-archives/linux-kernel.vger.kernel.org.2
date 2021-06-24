Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECA23B2A69
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 10:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFXIey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 04:34:54 -0400
Received: from mail-dm6nam08on2068.outbound.protection.outlook.com ([40.107.102.68]:6740
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229796AbhFXIew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 04:34:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvM/08PwOqCnbOMZw7NGUKh+UF3R39/4BIImw1Y1VxtJXy6b2WLpjBP2X4CyHt9yJwyaPAtKafQZGVtn0HMNAWXVjiLJ3dGhJKXpyyuxKQ9PhMNlepRTGCFyh7m8f6/uOyC8rIG9HjWJwtEYZRFrzVcg+LmftKsL9Igj7iZ6I5vel8nrNDCqm6Zzx91REFrCv+UvloOd46SjrVn5G+R5/Za/wt+5zxBKpINOB7g7xRHOH+76/BnbgU2pMegXsMP7Fo9OzYG+V9kqpc6hY1eg8SepSScpi35aBnpUp8qYXxuIk2U7+CbUHJ1xI9OsX3tZRrrBPRYxT2fpSAX/LOy1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFxKpExJIfcjzNI/kgJ0LkTogjyOL90CANBIktkDEKc=;
 b=Of6pZr7vevr02EpwCpPKIIFwVjYae1C4Vv6J8fIc6Neq/dsril8VKddV9sT9qigQaogi1ng1HFqNO1m1BQJuYy7oNjdPcgTMPDP7QTUWILzYbhFqBowzVLI1FdGH2BSoUKjf/Jr6AJOH+XefFk9lpbIN0rJ/pP9uvux6ZHbmGMbNeEA/69YZ0ablgdY1rdlVBhjL4GU33dl5sVFaP5sc1XXqQRDDcDfHpQ5ax6GqIGnLsydjGa7N69/bAnZObCq1vPxH7YonLI7/5W5SUyVvUXhv7y186y+YvujL84EtZpJAh2cL4BhfkCLZc+G5QPGfc5nPqjeWoDXmO5IlAuQT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFxKpExJIfcjzNI/kgJ0LkTogjyOL90CANBIktkDEKc=;
 b=W+MjueStPSq6YDO92OHxAnIHoKv5fD+9fDleB8wFe3zzRAFOujHKjUy3IVfI5FCCQ6nrK/Lu9L1Y0CzEfN9fTJ40Px5SMSYhx2YyH5PUK2KRcpDxWiyMr2o++72c7FAyCO47cPefJ/4cwlpNS3TW7qAR6grRmQCZbCNQX3Shp1I=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN6PR03MB2817.namprd03.prod.outlook.com (2603:10b6:404:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 24 Jun
 2021 08:32:31 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c%3]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 08:32:30 +0000
Date:   Thu, 24 Jun 2021 16:32:18 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] timer: Use static_branch_likely() for timers_nohz_active
Message-ID: <20210624163218.39ae3ec6@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::19) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0374.namprd03.prod.outlook.com (2603:10b6:a03:3a1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 08:32:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9958d55e-d626-43a3-c38a-08d936ea9b59
X-MS-TrafficTypeDiagnostic: BN6PR03MB2817:
X-Microsoft-Antispam-PRVS: <BN6PR03MB2817CE56D0EBB0F53CEAE5B1ED079@BN6PR03MB2817.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2ZMrDbQHT0PjdQh/JDTnZiGrEM+J1IdGEd1cty2nkhci9tFbOqFB3OdtD25sGjmb9Xc7TZXKEADbFwgHbNJarx0PfonTdiPAAnH7cvwrAmqEpesKrDvGwk18Cx2UUUhxaXubESgwtg6TyDh+K5qkHcy1Ilwt2BS51qiCc219mDpvy/YLMGsSf3zms5lzzr7BqtzdqK6y8g5i2PrxnYx+8E9BAcjSboUDxu6XAfyfSYrVpuS5k7WnhfNdyToFrd4/wQGafwDeRSaR32CWFo6/Jq2a870lEGueHma7d5RC4to+/Q0apH4Hlg1LkU0Wr9RVoUTwKc+HMAF4ikZCSqQvmNNfzd4YWJ9A4iYnr0SmX41oXAPkFaqOAWDm+AEGEw2aOjQgFtgjNtNoQgaL1dlPe+ZoTnvQwpcw2KzWTOWm8pLMIVcoub1qRsp5d92mtup/hLkO0VK/7fMBYJ+/egYLjwOZi7u8/PFVD5+QBDDSlqOKs14zxq2QgtVrv4NktrLlo6aP5Q52AdTXC8Fx5aeAFN9fTtjg+UJiXpUnHEJzGi6LUsr5TOyYeED6LQPXrSEwSmYgFtow1gXREi/SP2Ro63aoyvCJMAd35D5KeAJfxYzQ3nexiJiLeqVCjMggQUQ8dYdBwgksMiNd+nyd4cx8tvqq1ux7v2qbmi8FLNsBQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(39850400004)(396003)(376002)(478600001)(4326008)(2906002)(7696005)(186003)(16526019)(86362001)(52116002)(55016002)(9686003)(8676002)(26005)(6506007)(6666004)(316002)(1076003)(110136005)(66946007)(5660300002)(956004)(66556008)(66476007)(38100700002)(38350700002)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bp31ixpXxBr1IBEIa8I00sD5tyBrE3c2C131sdQH6XRF9E4r+gcilD19RBcV?=
 =?us-ascii?Q?JH5OVE9IlGuzSxeXQx+nlTTVezLr9XqMsYgfZdbRWvU9jrJm/eFSRQBIhBLx?=
 =?us-ascii?Q?b/HQQx7C7aRQU6OxzZLpoIigFhRPDPhQRrBwpg2kUkU7+VrMBkVQ4hhCDgMa?=
 =?us-ascii?Q?DbKEZfIyYpupDQ8ejA+cTT5msqhA2bFnD03EfhPqfSgkufL55MMZZ9Gkrhiz?=
 =?us-ascii?Q?pddfX/VAKAM5PcSgB22wYqmmMayOew6l7NkvNoalDUtFO8QK0grOV1gE9/xs?=
 =?us-ascii?Q?f7Dua1+5NbiGP9pS0A30inOzfaGOdC3gPF0I8h/SC9BuV8nrgTsjfOMa+hFN?=
 =?us-ascii?Q?sS8OIppMq4Z7jS6j1REGM0Mw9pOuzQyk3YRBTjFReU77bITXWoHPqzNP2v1T?=
 =?us-ascii?Q?vMNcocjwa0613KIGF8xLHL7hKXGM0YjTPLeBtMzxTGulia0iAn2C38Vwv0JG?=
 =?us-ascii?Q?x1WvcNhdLJ4PSU6bwOGhmbLDQSXO1ARZKj5D4PalVDtJJgqvoqD152IZrMGo?=
 =?us-ascii?Q?7ImcfiaSasFMObMIsG8MwzrqGdyY4QzbtpZNlB7mcH18grFV5hi0dMIeOtWE?=
 =?us-ascii?Q?QBy6/gwGNZOhLsvPsNSlx/qKDlf4P3kwY+1LlgffQLV9gj5Po3ZjbCrydXMp?=
 =?us-ascii?Q?djMTzQTtckGUmxLCG/nHTqXiTrKw4jnuJMt9bsP7fqcSL9nihhECC22q4JfH?=
 =?us-ascii?Q?7MTJfJCgBli7PqVnG4d0AXfCxYubfqltq6jK2mXxOpEsSpEIeRJg4PJYaWsC?=
 =?us-ascii?Q?IGtI2LtikN/8RxuP547C1R5DXBoGQ5kxLmMGylrY5cypVEIkmLyBr5EWT9wo?=
 =?us-ascii?Q?p8mPvhA1cLn8JsObUwYt35/j6JMJnr6UJNE2D0bHZSbX2/cgO3pHGKmnzqGW?=
 =?us-ascii?Q?kisqcgmQwJ+LiHH84eWll8yekP1wvx8fUBArw5ePm/axqyYnuXVvABS6HDNY?=
 =?us-ascii?Q?yn6Qfb11bpHQeRZzpt442yi8yyWldLDFKHX9iOaZQPCAL63Pj/LswsJh4z4g?=
 =?us-ascii?Q?GvbelVk+7rJ599+agkhXhEinQtNZYPeqkiuJxOyLu4fZGxhgxu9om0FevRsb?=
 =?us-ascii?Q?kmGC2rkM93VHsQh9ak9gzDhCXKMRhyu6HQCWqlLAYufOcJUGkTwC57CVQJUL?=
 =?us-ascii?Q?o2oPZgi7YEfmwuCF8J2nGHpOl4gLt0VUoHCJrNgxMR7zxY8G5S4Ofd2cvjBZ?=
 =?us-ascii?Q?waduk02+I3MnfiT9nOTL94bjJZOaPD5jPa3ShW4ryTOkGDkBIY4Ly4xfs50I?=
 =?us-ascii?Q?HVbVNz3nE/nTCXSJbK5H+SzKJnVZxYk4F/6nsEXmfVsk8cmXqs0aDzb8sVkP?=
 =?us-ascii?Q?AVmTfqA0m70S8iyAKaqbq1hh?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9958d55e-d626-43a3-c38a-08d936ea9b59
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 08:32:30.7727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1Gioub6ml9lg0taO/19GnlFFZ+2pOPhV3KAZNzzAj1A5MQN5k4TIyZJNEkjJkUp5RF9zy3oIEVVtBl1znIL7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2817
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static key timers_nohz_active is likely to be true, so use
static_branch_likely() to reflect this fact.

Per include/linux/jump_label.h:

 * type\branch|	likely (1)	      |	unlikely (0)
 * -----------+-----------------------+------------------
 *            |                       |
 *  true (1)  |	   ...		      |	   ...
 *            |    NOP		      |	   JMP L
 *            |    <br-stmts>	      |	1: ...
 *            |	L: ...		      |
 *            |			      |
 *            |			      |	L: <br-stmts>
 *            |			      |	   jmp 1b
 *            |                       |
 * -----------+-----------------------+------------------

This could improve the finally generated code a bit for the most likely
scenario, I.E save two "jmp" instructions.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
Since v1:
 - update the commit msg to avoid confusing and add some descriptions about
   where's the improvement from.

 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index d111adf4a0cb..40d4fe7fa207 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -265,7 +265,7 @@ int timer_migration_handler(struct ctl_table *table, int write,
 
 static inline bool is_timers_nohz_active(void)
 {
-	return static_branch_unlikely(&timers_nohz_active);
+	return static_branch_likely(&timers_nohz_active);
 }
 #else
 static inline bool is_timers_nohz_active(void) { return false; }
-- 
2.31.0

