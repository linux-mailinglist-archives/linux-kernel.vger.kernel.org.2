Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A733D826E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 00:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhG0WUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 18:20:01 -0400
Received: from mail-co1nam11on2125.outbound.protection.outlook.com ([40.107.220.125]:24877
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231706AbhG0WT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:19:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhD+fjSeKTc6npatQyM/OH/i8PVvA8dauodrneIaN48YAO9ShW9GkJ71loGq73ex4bGfZJIBgt0OQj69FmE2P3raEfcrnJzdW2Eam+EMc2aD7CB8iTlJSfBDe7KAjJAKQi8d7bh3j4Us1hX+YNzl50oTPAN/yyfdO+vddQ/52lDbrcJVRImYcnzKq5zo4gqbwOmsSuUkgwXslZMh2NK6zkdrX7EMPOX4jCSBvt9KJHpHtw65BDYiewx98Hgk98NO/QGi6tQa7RpGNTukzcr+IKW4kukdhpO8vaP2qh0FZoyWRQACkn/O1t/6U2tfQNuAezAqVHIXP5TyJWjKyJ2XqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fl0smdfLWt0vHFHugzwHDoBaUn69F1Uy1LMER6VS7TM=;
 b=LQ+jRbCUGCGusGtzBqSAazXmAhznI/krWWlo99W2zxp5r4kWd/goc1B6jWlyqZLHGGwkdKCUiO9eFwkEuHIR2ZOgpca7rgkTeK8cjIPfVfBXS+FARIijtq5jeHePLEyfiRKANO3eYIOWyvg+J4jTTXVgy2SsttMbDsONcSoL0vTtzIrgbBQ54P3yG9geYNZ6ObEQfkYTVqMFgnWmHHKOK/C10XOZDGAJdSfX78oGFEu3ohJke73nXNe05yPB0TgmbFAqe1DaHV8IffnCOMYCzKeHkGxffRkE8c4dVpJzLksC6soif4g6AaJX939Yo5/MfVo1m7B6g5mCi6/Q90Vodw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fl0smdfLWt0vHFHugzwHDoBaUn69F1Uy1LMER6VS7TM=;
 b=4MOAyVLxywo6lCb5pQEiRomkGTAtgGDHM7seKLFkr3RqRrNkVDy9aNSRaAeoAOnczKLxHB/JsJVrJGVzJuc2VIRXXKj4xUJTMtQZ1EU3LxPqIOYyThVnoowDNhkUYr0G13dKZvUuCqo/ZOurTH+3DmULviqXZ6Xsf01JjP7tXMo=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from CY4PR11MB2007.namprd11.prod.outlook.com (2603:10b6:903:30::7)
 by CY4PR11MB1542.namprd11.prod.outlook.com (2603:10b6:910:5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 27 Jul
 2021 22:19:55 +0000
Received: from CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::542c:7439:3edd:1a9b]) by CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::542c:7439:3edd:1a9b%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 22:19:55 +0000
Date:   Tue, 27 Jul 2021 18:19:50 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [BUG] 4.4.262: infinite loop in futex_unlock_pi (EAGAIN loop)
Message-ID: <20210727221950.GA51120@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <20210719162418.GA28003@zipoli.concurrent-rt.com>
 <YPl8nfZBjgmSnE7N@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPl8nfZBjgmSnE7N@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN8PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:408:94::44) To CY4PR11MB2007.namprd11.prod.outlook.com
 (2603:10b6:903:30::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN8PR03CA0031.namprd03.prod.outlook.com (2603:10b6:408:94::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Tue, 27 Jul 2021 22:19:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daa8662c-e8d0-4165-bd09-08d9514ca92d
X-MS-TrafficTypeDiagnostic: CY4PR11MB1542:
X-Microsoft-Antispam-PRVS: <CY4PR11MB1542AE30713F17C1928C3E6EA0E99@CY4PR11MB1542.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qeMGTVAuk4/g43wiRj2lmupzhmJfwojFPgHUzxMnvVClgkB2w7U6gL5ppvCvqJzSPvRsWbeql2I52bCkXvrlA1wNlQ6JIb7ZOQUf30MoRzJHXc+YE8k8NKrKTDW3sKPSKjX9Q3lF+EdL/IeqYyN9PodSq+WVqU+i5wG8LG926WtfUE5GkCF6NXXzgTflSZ0xm4XZRuVYda316/kXGLza44iUxVRG4F6FzgQg6t3c9Y9UXEB97RvzmfZc3zKeX4PV/Tst7n3Jx3I55qLSDPW03whE+E8gibyexnsCivy6L5h15NfQ6iZhMDlycB0g/6RN3KrHDdCIDisBepabuj4tl7SHJ8FadujcQt6RAAksVcslD6pN0HQweTL/eTrqSquPFV+juHQHoiErBo1PUG2LRk99L2gzcIj7DZrrarmPmnP5Siogpvd04bkkh6/cbjcqTBitzXnaPdsaQRT1nQgRWKLyneo8Xe3gHNC9nox18Ke5uY69E1zmgEpfnVx5N2F7tMEaDTqi9nc43goxnip53vHAAkYyJo+8Cuu4pYPE5adCwrEvOwuLKKEvlqbdEjx73e2tOogQnomOB65Mej7gvWj6OA2f179hz24nMMUaoONm4XSeegsI9N/dRna9zRjs06KFUQPHzttKDQVK9V4GeNa8SWk1dE+wjGpaguRdfMBSbTa5Q01YbGdDQsm+voneQkUyWE3V6mTWuXwa9v+iUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB2007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(376002)(39840400004)(136003)(86362001)(1076003)(3450700001)(2906002)(55016002)(8936002)(4326008)(8676002)(7416002)(7696005)(26005)(956004)(5660300002)(52116002)(508600001)(66946007)(66556008)(38100700002)(38350700002)(316002)(33656002)(6916009)(186003)(83380400001)(66476007)(54906003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r1lRvhOFPE6WBHarwuZZGMh2GRtuesVV+2m+02Bp6xb/bdBolQnUIp3h+b7l?=
 =?us-ascii?Q?7n4WcahF1dsOj8ImBJ+PVdJbV8s5F/Y6LMA4cJJvXm6GHZpyX9n9VkNG8fMC?=
 =?us-ascii?Q?8htc/tbM36nQGzWhSi70+yzsmSNPaiSsFRwHiqfrXe0oMEhnv7zQv6mpZ3MI?=
 =?us-ascii?Q?JdaZddHnB3p2/0W+yqpTmX7YxonQHwfumu0rEGeA/jXfnQG75lNV48bBYSe1?=
 =?us-ascii?Q?jbTiU2rj8F6iL8EQK4bI30L1cmYuE3BcqcOMXZsE/nJaGBUiYcLScc0W+UQE?=
 =?us-ascii?Q?FbgpnTQJkBZTbGj0G43d/xkOO2JunksAaTHI3MVvimXk+C2hU5LTAjJhlbFT?=
 =?us-ascii?Q?k2pI0ahuTfkRWHutQy5WgKDUMWUTrtPww25MoXPRxQPgFLvMj5Fjm9vAaHjy?=
 =?us-ascii?Q?/Ef0V2+s71Mj928aJcV8nRkD5yJhWA+uBmrNkFRHPyudlcmXWGqQgE9X1rWW?=
 =?us-ascii?Q?D8lxNxDc2vytOsBc0e9oyM1ff8FtIIk1puOtJsRD0YUS1SI35sA8Uz5xJVSb?=
 =?us-ascii?Q?Ptql8w3j01V912MUuvYzvH7obxxdvCQIK57pJuwNWpk4h5VDiYVoL7LLlaLr?=
 =?us-ascii?Q?2l+wcpvl2mIFIoe/1YayGdaFH65NRxonSfVOzw6QCGogCRBF7lf4dmueuWXh?=
 =?us-ascii?Q?U2gH/6QB9YnqNhm15UA3HUv3jh+w2l4mRpAdEUKqsqb0h2MhhQ5ZG6yDFXvn?=
 =?us-ascii?Q?4BjlHK1WhmeBHBxb8piTKqklFHxo9EAVWj6BH3/8ZpyHHbQJ4NPt7llfqvvx?=
 =?us-ascii?Q?sGzeDw9hQkjsJv/qE/JNA6Zc3HsxnQpVyRtB22Cb26lf9X7pclhzaCQqwffT?=
 =?us-ascii?Q?eRLcbJg3Zl3iWwMtKr0qx9abODVztrSwxbMhiEYlqwg5tNqPcAwzirpRTmnU?=
 =?us-ascii?Q?k4zgwuCU/Qy/GluTgA7EDli4dU5rdaEJdBz+1FDpO5t2yKt1Uz7rychVVHQW?=
 =?us-ascii?Q?XQOpbGXgCgh6vhWrMq7+bBkLs9lOcppQN0Qc4jgnAEzs46gfj78mBKelQ7Hc?=
 =?us-ascii?Q?yqKs0bDLmPcuM+fD8WZB9sHFvsA8ib7RGI8UVQvMw+yhZlTbONPrEawM2ais?=
 =?us-ascii?Q?sVNvNw+H06A+8jMHFgqJKuMNaK178kjlAgBvD8A3JpqYS4bmUJsteebxKO1o?=
 =?us-ascii?Q?3VN7tMSHZ7aFVKa6Sqo0M/SJnKbMWjOBCIRI4pP7A4dJ+IYAy5JGH3Osi+iq?=
 =?us-ascii?Q?joiZEI9nLUl7qDL+v2XaCgnm3YahH0kFD9mZpXzfHOXTnZo/sMqQ1BkmN4jY?=
 =?us-ascii?Q?R5WG8y/HMqyfJ1nd0qd43FVHT4IanZ4msRVmH5m7G0jwDF53nS6dOGOlwXI7?=
 =?us-ascii?Q?V9rYebznGhReNGK6UAyL8Yxa?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa8662c-e8d0-4165-bd09-08d9514ca92d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB2007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:19:55.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geo0Mh+EOYeOLwxtpkRfVS0ZGrc2znESm8PwnhMRx935RAhF6tYXIuC0YpB/HfZnrvdWx0l9SzsfYPyglRXc7njwmd6JZjIQB6PMyoeDAHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1542
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


 [ Added missing people to the cc: as listed in MAINTAINERS ]

On Thu, Jul 22, 2021 at 04:11:41PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 19, 2021 at 12:24:18PM -0400, Joe Korty wrote:
> > [BUG] 4.4.262: infinite loop in futex_unlock_pi (EAGAIN loop)
> > 
> >    [ replicator, attached ]
> >    [ workaround patch that crudely clears the loop, attached ]
> >    [ 4.4.256 does _not_ have this problem, 4.4.262 is known to have it ]
> > 
> > When a certain, secure-site application is run on 4.4.262, it locks up and
> > is unkillable.  Crash(8) and sysrq backtraces show that the application
> > is looping in the kernel in futex_unlock_pi.
> > 
> > Between 4.4.256 and .257, 4.4 got this 4.12 patch backported into it:
> > 
> >    73d786b ("[PATCH] futex: Rework inconsistent rt_mutex/futex_q state")
> > 
> > This patch has the following comment:
> > 
> >    The only problem is that this breaks RT timeliness guarantees. That
> >    is, consider the following scenario:
> > 
> >       T1 and T2 are both pinned to CPU0. prio(T2) > prio(T1)
> > 
> >         CPU0
> > 
> >         T1
> >           lock_pi()
> >           queue_me()  <- Waiter is visible
> >    
> >         preemption
> > 
> >         T2
> >           unlock_pi()
> >             loops with -EAGAIN forever
> > 
> >     Which is undesirable for PI primitives. Future patches will rectify
> >     this.
> > 
> > This describes the situation exactly.  To prove, we developed a little
> > kernel patch that, on loop detection, puts a message into the kernel log for
> > just the first occurrence, keeps a count of the number of occurrences seen
> > since boot, and tries to break out of the loop via usleep_range(1000,1000).
> > Note that the patch is not really needed for replication.  It merely shows,
> > by 'fixing' the problem, that it really is the EAGAIN loop that triggers
> > the lockup.
> > 
> > Along with this patch, we submit a replicator.  Running this replicator
> > with this patch, it can be seen that 4.4.256 does not have the problem.
> > 4.4.267 and the latest 4.4, 4.4.275, do.  In addition, 4.9.274 (tested
> > w/o the patch) does not have the problem.
> > 
> > >From this pattern there may be some futex fixup patch that was ported
> > back into 4.9 but failed to make it to 4.4.
> 
> Odd, I can't seem to find anything that we missed.  Can you dig to see
> if there is something that we need to do here so we can resolve this?
> 
> thanks,
> greg k-h


Hi Greg,

4.12 has these apparently-original patches:

  73d786b  futex: Rework inconsistent rt_mutex/futex_q state
  cfafcd1  futex: Rework futex_lock_pi() to use rt_mutex_*_proxy_lock()

I have verified that the first commit, 73d786b, introduces
the futex_unlock_pi infinite loop bug into 4.12.  I have
also verified that the last commit, cfafcd1, fixes the bug.

4.9 has had both futex patches backported into it.
Verified that 4.9.276 does not suffer from the bug.

4.4 has had the first patch backported, as 394fc49, but
not the last.  I have verified that building a kernel at
394fc49 and at v4.4.276, the bug is seen, and at 394fc49^,
the bug is not present.

The missing commit, cfafcd1 in 4.12, is present in 4.9
as 13c98b0.  A visual spot-check of 13c98b0, as a patch,
with kernel/futex.c in 4.4.276 did not find any hunks of
13c98b0 present in 4.4.276's kernel/futex.c.

Regards,
Joe

