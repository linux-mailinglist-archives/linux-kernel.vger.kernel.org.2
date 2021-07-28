Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE093D8FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbhG1Nyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:54:38 -0400
Received: from mail-mw2nam12on2132.outbound.protection.outlook.com ([40.107.244.132]:3328
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235420AbhG1NvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:51:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZunbmCSbZsr2VJNBDlMo3qlPV0mbM0irpx5PTAJ/oJ1VQ8H42N0mjF+1ykQQpb+W+2QypHqoZvVidkH5FEBEYfNe8q2ras5/D8f8gY5LV1/M0yqRSsVEN9xOty1ku1UgzAXmJtVo0k8BMTIBh3nQ168Os4oOVabCn/pbRit5zV/YIxAJpILVMgg8GnGBtfKPfJwGRdSH1gm/G/DpWL7bKkL5c26op6bOr6m2LRsjBcywILVvYN9hY07gNl1QzqxT/Egq9gq18fcx3gjrwTOk+QMeHdegOsOI1ZK3uG2QqyBc2YtWyzd7oMQ+7pDhawgMslaKHbX2ZQWQWXystBti7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3kgZxNES/6vSLkiK0z0uOzX8UHdS6sjrN+Z0u+3IeE=;
 b=YCKu1/siMWmNHsG6h+QtmU6Da2b4I1Z+xjuwSnLrDEmDV8jkQpNSya/HoiKgrjxJtvJaiD/frkc9iIIEnzDdJkgCo8VxvwQLm0Wfg6XXQ9+S32P55KLVHL4gKsNidmrIlAmr1fMXcKyAj16MOKX4diWFszaXLvFAqE39YAQOo4i1dOAZSj9CuvrNQZXWmdEiNc1IcAsWMdzys2VA1fG95oEuZdjNzs/JDBocn0r/oUSwMU6Vq+M+WwYx04jK2DLh8R9dMV/cMmAXk9DlQr5EkEDvrQ13VLFwelBPYGj/FCRzpze7bZTh7/KTI6kL6DiDa2dlKwMOoPv1zGjVgou+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3kgZxNES/6vSLkiK0z0uOzX8UHdS6sjrN+Z0u+3IeE=;
 b=YZ16g945E4RkMOm/UbF/xMOk7JRJv4+ebmacWkdhdAogxVsyTJ7jUN2I87uC4g9VInCJWG9L4HVZpemLrGtq1eL7bZHGYCcCdxXdk2pfng3S42VwBXTf3yQaXAHOxKJQbE/gejeqvXO3F+z7RktYkPOjtmB0mKyMaTgrUg5rXZY=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from CY4PR11MB2007.namprd11.prod.outlook.com (2603:10b6:903:30::7)
 by CY4PR11MB2037.namprd11.prod.outlook.com (2603:10b6:903:2f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.31; Wed, 28 Jul
 2021 13:51:18 +0000
Received: from CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::542c:7439:3edd:1a9b]) by CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::542c:7439:3edd:1a9b%3]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 13:51:18 +0000
Date:   Wed, 28 Jul 2021 09:51:14 -0400
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
Message-ID: <20210728135114.GA2453@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <20210719162418.GA28003@zipoli.concurrent-rt.com>
 <YPl8nfZBjgmSnE7N@kroah.com>
 <20210727221950.GA51120@zipoli.concurrent-rt.com>
 <YQD0BIYaD/y9VCEz@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQD0BIYaD/y9VCEz@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: SN4PR0201CA0028.namprd02.prod.outlook.com
 (2603:10b6:803:2e::14) To CY4PR11MB2007.namprd11.prod.outlook.com
 (2603:10b6:903:30::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zipoli.concurrent-rt.com (12.220.59.2) by SN4PR0201CA0028.namprd02.prod.outlook.com (2603:10b6:803:2e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 13:51:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 902c2c60-c50f-4a40-ea34-08d951cec603
X-MS-TrafficTypeDiagnostic: CY4PR11MB2037:
X-Microsoft-Antispam-PRVS: <CY4PR11MB2037A6915FA511856AB48F97A0EA9@CY4PR11MB2037.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNYEQGfWjrbHcFaJ2ObbG99BhuzN5T0Dq8bJH8kFJ9fc+IE2DOqii1iaSyu5Tgwo6P9pTN/RQ7+eVcxGjiMfohYveC2kJqjiG3rnfCatrorLsFVvILL2vjwXLGZ9UVLQWlRIGgkMqtEFNaRAzuES5EFrPlqT2x3VQYjxinL70NyLdhVDWJOa5qhRbnUAjqcnhfwtlujmMPmqUm/dfxxVCDoxwg1fA5C7mpuzwESfjKl3Fn0uu56dTGJhDu8hH6EfiRenM8jf/f56o2PGzkWGWdYRCHyqEWCAYBhcRlakMeoHU69pVpaDpPrX8vZDgSrL6zkUMzJgMM4KWWlWvAeMDCmUhK874z04T0+eHrQybQxTP2Rilrt7D6Rf3ie3zNm2S82oyAl3tJpgCMuJivYj3QeY6e7Ah2x4ZsTfyfeQapv6uSPC0x6gWNy9yNT5D2/G14GCE1m5Id/kAnMYc9TbL88ZNMuOfECz4rRDoqUyqk407k8ZMXks9I3I+LhiR78l2OpSdERJrPf8ER5c1xkfvnBH0cza3ESa+NLwFY2AaidmglFLvLwFQdlz5aExNIV/ETs1bnv4JvwV9b8cvDGIYh9Q4dlQf1Plez4TQhsnsxv7Hj1h0CQRleWtkFPP6F6UM66RCYuLwEIqnmA79hCapZ1ypWK9a86U4zJw+pjFGYieMCAsbKZmNM73/W4/zqTVHXnftN/YkGjzdDHeG5LMHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB2007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39840400004)(396003)(366004)(136003)(8676002)(55016002)(7416002)(54906003)(33656002)(86362001)(38350700002)(38100700002)(66946007)(44832011)(83380400001)(5660300002)(2906002)(66556008)(316002)(956004)(52116002)(186003)(6666004)(4326008)(7696005)(66476007)(8936002)(26005)(1076003)(508600001)(3450700001)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a5xFbWvx+BQ3nVkm70OAYAhpNP2+eARhC02CR9Hm4gNly2w8g6grtW/NXx3X?=
 =?us-ascii?Q?OT2QFvz3JcCgayZEygGvXgwrvlVVocZxpbmkVnv6TjotSLKlIIqx6+TTe0sT?=
 =?us-ascii?Q?OSQYvwv1P2IqLdC1qm1yUMuonuUlowoJS2tdXpTTRDS6dGQyFRvYLFcGnKKX?=
 =?us-ascii?Q?+imkR3lzudL5x1LBB5B+eM+PMLggm5z8xV3ZsEYPFjXSKq+1l8vI3er9AMEt?=
 =?us-ascii?Q?gSQYHLv5H+xRVWM/D+hykGmnV2G4bQVTkoDJFIVyrVE7BtZlhmfd6eWTEp1G?=
 =?us-ascii?Q?0mCLIdTvQsmb1hBH0YctILnA0hvAPrP1E3cW3jP+sKwyG2qYuWgU+1q5eJSM?=
 =?us-ascii?Q?elMl9IvzzEoYU9IfwShWAsN4N2garuCDRhCdPPAhEC6bDwp9VmcI7m7+vOjD?=
 =?us-ascii?Q?TIade5SXihwf5y3rsSGYxsO4NUtwDRb8WbB8wU1BSl1Jt98JW6AC6/YsrZUz?=
 =?us-ascii?Q?uIOqo/2za3jG13Bj+cazsjiT9pgUv2eu9K3ackYSs3maJtT08Jau3vP4iaZI?=
 =?us-ascii?Q?hAcRlmLwNu5EhJRztU2CPSS4avtQtTlnls40PCAg5DUTelJfsv++qquRJXbD?=
 =?us-ascii?Q?c3rGr7JHhUuqjETsW/ykX75h64ENP5ap2P4NXmqYekP5bUzEfv8vdHIfbJAx?=
 =?us-ascii?Q?IzSfad1k/A0MYvPF0BUFuCbmTeyxw4tA/Tf6BjkMxt7E2hJleHWSz/8jvo6+?=
 =?us-ascii?Q?n/jcFQ5lG/JFKpr1dUmTCCBfaluF862Wuf4giS6oeVlo1oJ5LhHh74wP7Zkd?=
 =?us-ascii?Q?Yf7nlkaq5G3sJJRB79K2qynlSAUsdx+EeFCSpWC/ChwOP+wDclmPBu9X5EvS?=
 =?us-ascii?Q?ZCnCQqnpmcbnSQs9eWeIP98VNW4DkE/fmHr4xcXuCfft7b2/yHWIIVk/tPaE?=
 =?us-ascii?Q?rN8+Re0ZAMH1NjQTdCxyRBLRNEuD33C60j998EdhehRvj+pxi5MGG76cfdMC?=
 =?us-ascii?Q?/ytoeHn6JqXLJoThdwSVwSOtw4YD/dHbpxyaV9VpgOT9wVBx3pTswuquG/Sn?=
 =?us-ascii?Q?uzjE6DUOynDwYKCepW+iUbcsQxATAegZ7GmJV2zA/zqYkLioLra6PbBo3sNs?=
 =?us-ascii?Q?p/wczpOGVaeVllAw16CI1b9pTREYj91qBB/wRGcjoGUa0grKdbmFJJRp+fjz?=
 =?us-ascii?Q?LZn4/WckpxIHI4fAW/23n/Kh0iwrbs4VJxu6p1ZhYbSaBGJ8pARsatAUdjNn?=
 =?us-ascii?Q?vdo5od+osz6ECiyB9MctZFB90mqV3XRQY0dN08f1dT4brBvqQc1EECKN4p9r?=
 =?us-ascii?Q?DMtm64cJbuTDB7O4FAX+XugYbQNSi6zmPdJGZQuAXIBZbInf6BZjEFIn6qWN?=
 =?us-ascii?Q?eTpGI+78BFJyl8JkPHb62o9F?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902c2c60-c50f-4a40-ea34-08d951cec603
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB2007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 13:51:17.8983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T36T0gkniDVUZ9p60re+suZcjJxmo89Y4i9S9B5b7JCvEX/kCFBbh9RbJt3X4oHnBpcacje1mmWZScp6+T7BZcJ+nUHVrU6E0hPY7va3DBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 08:07:00AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 27, 2021 at 06:19:50PM -0400, Joe Korty wrote:
> > 
> >  [ Added missing people to the cc: as listed in MAINTAINERS ]
> > 
> > On Thu, Jul 22, 2021 at 04:11:41PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Jul 19, 2021 at 12:24:18PM -0400, Joe Korty wrote:
> > > > [BUG] 4.4.262: infinite loop in futex_unlock_pi (EAGAIN loop)
> > > > 
> > > >    [ replicator, attached ]
> > > >    [ workaround patch that crudely clears the loop, attached ]
> > > >    [ 4.4.256 does _not_ have this problem, 4.4.262 is known to have it ]
> > > > 
> > > > When a certain, secure-site application is run on 4.4.262, it locks up and
> > > > is unkillable.  Crash(8) and sysrq backtraces show that the application
> > > > is looping in the kernel in futex_unlock_pi.
> > > > 
> > > > Between 4.4.256 and .257, 4.4 got this 4.12 patch backported into it:
> > > > 
> > > >    73d786b ("[PATCH] futex: Rework inconsistent rt_mutex/futex_q state")
> > > > 
> > > > This patch has the following comment:
> > > > 
> > > >    The only problem is that this breaks RT timeliness guarantees. That
> > > >    is, consider the following scenario:
> > > > 
> > > >       T1 and T2 are both pinned to CPU0. prio(T2) > prio(T1)
> > > > 
> > > >         CPU0
> > > > 
> > > >         T1
> > > >           lock_pi()
> > > >           queue_me()  <- Waiter is visible
> > > >    
> > > >         preemption
> > > > 
> > > >         T2
> > > >           unlock_pi()
> > > >             loops with -EAGAIN forever
> > > > 
> > > >     Which is undesirable for PI primitives. Future patches will rectify
> > > >     this.
> > > > 
> > > > This describes the situation exactly.  To prove, we developed a little
> > > > kernel patch that, on loop detection, puts a message into the kernel log for
> > > > just the first occurrence, keeps a count of the number of occurrences seen
> > > > since boot, and tries to break out of the loop via usleep_range(1000,1000).
> > > > Note that the patch is not really needed for replication.  It merely shows,
> > > > by 'fixing' the problem, that it really is the EAGAIN loop that triggers
> > > > the lockup.
> > > > 
> > > > Along with this patch, we submit a replicator.  Running this replicator
> > > > with this patch, it can be seen that 4.4.256 does not have the problem.
> > > > 4.4.267 and the latest 4.4, 4.4.275, do.  In addition, 4.9.274 (tested
> > > > w/o the patch) does not have the problem.
> > > > 
> > > > >From this pattern there may be some futex fixup patch that was ported
> > > > back into 4.9 but failed to make it to 4.4.
> > > 
> > > Odd, I can't seem to find anything that we missed.  Can you dig to see
> > > if there is something that we need to do here so we can resolve this?
> > > 
> > > thanks,
> > > greg k-h
> > 
> > 
> > Hi Greg,
> > 
> > 4.12 has these apparently-original patches:
> > 
> >   73d786b  futex: Rework inconsistent rt_mutex/futex_q state
> >   cfafcd1  futex: Rework futex_lock_pi() to use rt_mutex_*_proxy_lock()
> > 
> > I have verified that the first commit, 73d786b, introduces
> > the futex_unlock_pi infinite loop bug into 4.12.  I have
> > also verified that the last commit, cfafcd1, fixes the bug.
> > 
> > 4.9 has had both futex patches backported into it.
> > Verified that 4.9.276 does not suffer from the bug.
> > 
> > 4.4 has had the first patch backported, as 394fc49, but
> > not the last.  I have verified that building a kernel at
> > 394fc49 and at v4.4.276, the bug is seen, and at 394fc49^,
> > the bug is not present.
> > 
> > The missing commit, cfafcd1 in 4.12, is present in 4.9
> > as 13c98b0.  A visual spot-check of 13c98b0, as a patch,
> > with kernel/futex.c in 4.4.276 did not find any hunks of
> > 13c98b0 present in 4.4.276's kernel/futex.c.
> 
> Ok, so what do you recommend be done to resolve this?
> 
> thanks,
> greg k-h

I suppose we could either back out 394fc49 from 4.4, or
backport 13c98b0 from 4.9 to 4.4.  At the time I wrote
the above, I hadn't tried either approach yet.

Since then, I did a trial backport of 13c98b0 into 4.4.
All the changes to kernel/futex.c applied, none of the
changes to kernel/locking/rtmutex.c applied.  That implies
to me that we have at least one other patch that needs
finding-n-backporting before we can proceed.

I hope this doesn't turn into a Wack-a-Mole operation...

Joe
