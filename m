Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9DC3955AA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 08:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhEaHBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:01:05 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:48599
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230107AbhEaHBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:01:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I47ril6O32sw09JTcdgZLFj6Bra7ViWGcbXA31iJLjheTsW+pbc7xOV+Yv9pjO6povzdP9Yr8Kb1cufHC0b1CsC/m9KHyTZlRd+tejy5NH0o6vmqifnPImgDdoX1unOwgdP6l7FG2C7OrlOrSZ46RteJPAUT/6xwBuSmC4bvUFmPfeoVbvMIiYQYs00pKSKyhAN2WlZEVuwrNIso6Z/r3vGsJkxSv4gGCmG40+PXfp+R5Mzt1IXeRecmo37CjOXxxSq75yjJLe3FP+ndP7M3cxjsE87PImtTIiK+tQwp8rvKmT55AwietwJcPS63SADoLbHev+xw0DPcv5xs68Wubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXZZVxqj2pIF7SuXyvxTA17zI1LZ7DFlHOcTAt1Wui8=;
 b=UfrC5Ex6LaWYGeAcTAYSwF6ksn+xWgv8fdx71wcsRii5QGy9eTqMWTPN5jebKRKf9u5PzPXiGAHlHRtfwnCM6Hpi+nxQ669AU/QoGNKFc9nqS6kY9pkjsIvb1ACoUEmpLzsDHNGboyzSAJ/oUSZWb75dTZAGPnokYGA7FGQCjQCTE7ni+klaH0zp3X81zihlaYqVBseGInDoWPb9S5uSq5KkNpoGh0zm8v9XNctVo2hwCT1dGm4rn7xr0Kx5ssrGv3NdpK/j9PMFte3NY9GWbHnLo1gPCP41FA/aiGgsqOtQEuVcPXN3jj8bFuykK60tPb+jRteFtfGqes6ZWzZVlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXZZVxqj2pIF7SuXyvxTA17zI1LZ7DFlHOcTAt1Wui8=;
 b=khKFT54uFLMeV5I2H18xbROXRDdyVhkBQ/C22wErykn9qA11eBBzE38atX/lFJQiLQT3hbH8V/RLOGWf9nlm5Y75AvQWbKsZ3jHsjbYsBsz//hxaDBquSLBDOwnOs/nrU9jmUPVSW1NJQmUfHlTRkK5RXaM3WX4cxfAvyFqf9Zw=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by VI1PR03MB4848.eurprd03.prod.outlook.com (2603:10a6:803:b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Mon, 31 May
 2021 06:59:21 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8596:b59c:6627:8de5]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8596:b59c:6627:8de5%2]) with mapi id 15.20.4173.029; Mon, 31 May 2021
 06:59:21 +0000
Date:   Mon, 31 May 2021 08:59:14 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     changhuaixin <changhuaixin@linux.alibaba.com>,
        Benjamin Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dtcccc@linux.alibaba.com, Juri Lelli <juri.lelli@redhat.com>,
        khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Odin Ugedal <odin@uged.al>, Odin Ugedal <odin@ugedal.com>,
        pauld@redhead.com, Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com, tommaso.cucinotta@santannapisa.it,
        baruah@wustl.edu, anderson@cs.unc.edu
Subject: Re: [PATCH v5 1/3] sched/fair: Introduce the burstable CFS
 controller
Message-ID: <20210531085914.3abd806b@sweethome>
In-Reply-To: <YKzVnH/OTFvIP0dP@hirez.programming.kicks-ass.net>
References: <20210520123419.8039-1-changhuaixin@linux.alibaba.com>
        <20210520123419.8039-2-changhuaixin@linux.alibaba.com>
        <YKe89Uda+uJdx4X0@hirez.programming.kicks-ass.net>
        <C759D4F2-FA5F-4EB2-8441-C9ECD79AFD55@linux.alibaba.com>
        <YKzVnH/OTFvIP0dP@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [151.41.57.114]
X-ClientProxiedBy: ZR0P278CA0123.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::20) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sweethome (151.41.57.114) by ZR0P278CA0123.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 06:59:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8339ab99-126e-40b5-ddca-08d924019dc6
X-MS-TrafficTypeDiagnostic: VI1PR03MB4848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB484894196115BAC7AB5BF09F9E3F9@VI1PR03MB4848.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b8z6e+s7fRvm9Fc8Bixbfbn4WgrilL0LLRuKo6jnNjt0bIL2t+KHdEs56QyCKjQyW/1qY2t7orMAZhb/+nleYxF05eIpMaZXNgqme0LATky/+B+qedCmsW31u49406TFscqa/KY6GCdpDGDgZyDCaiXr/3SRZIi0hiqPEWcXR86Ch7nthQRgBeigBX56PuFQnQXRgQLIAksegjc3rTBwSitoj68ljJ1kqVvSKe+e1blkTpDYdgHnIha4D0NRiXSiqZhnAWgmw80rFD2ALes1ErWgF6n9zXjsdj6u1Kn/+fq6ttPUsy2zj0S0d02TnY71UirNZW5DdK4U49xEP2sOHo9HAzcmH0+yqfDRJdHs74iilbI991/A4qdNipIzVqzKdK+xw7eU/AmUoPkfl9u3J3IB0kPRKNLxyc1a/zKkbWgv2hXueeY0BfLLGkXmxzzOGnuzpywjX5PPVxtFErtmdvnFYADVejCix2SxCelqvO/z/D2q4TGlmqkNEgu2oNUdjK0KW9Fkt58iO22np/oWO9fgc+qrozyll/exMJxu0VbdrEbaHdvfBXmYYpDB9YZg7XBkiEckBr3qYvURpEskAlf7mnwmlflIG3lf+I5YRWCx68R+pIXQmMQ44gfagQjWsRBbCg5v4PoNKgrawR95xv6f5/o9TNAStoOJfNpmc1xCR12wBgw5fUYYuG2H+8oT3nJf7nbKszEvs0lCuuBkX9VuxwittYWPGUQp8O04udaONSKlEZVXOmDW9fwBcAZRQkLdwYboGKdOo0yRiSAyyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39850400004)(346002)(136003)(376002)(396003)(5660300002)(66946007)(38100700002)(7416002)(38350700002)(6916009)(26005)(478600001)(956004)(6496006)(52116002)(66476007)(86362001)(66556008)(16526019)(1076003)(186003)(316002)(786003)(54906003)(83380400001)(33716001)(9686003)(4326008)(8676002)(966005)(55016002)(9576002)(2906002)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mQokZE67arsIlJ/Vlm+LKFcFsxH/bQDHL2XXeuPlS36XbFndjK7JDrdUabkv?=
 =?us-ascii?Q?QE7ssmp38qjDN+8IpfmtoTSe5sdIToyHHmzjegYJ+OYOgjgeVPpDsPSZ/+I7?=
 =?us-ascii?Q?nrwPgF6aOFedIMZ762fCYAHZh1BugVFkvTfUBdOgctgqRCxWfjouuMijC+g7?=
 =?us-ascii?Q?jHogLv9dQSnIurllM6mPVo0t1gW2lsOuwb6lM2X9cAbnBbyyYZXku0WwRj5b?=
 =?us-ascii?Q?QEloP7DKWiKQvM8TXd0TjmEUSr5jGLIxjYSPKc+OnBaAkK3aBEI3Z/UpRxdI?=
 =?us-ascii?Q?rSVCGScShcBjMino7SxxwDj+S7lgjbpno+ewAffCT8YLY9GLfOHB5NYC6xRY?=
 =?us-ascii?Q?EkVL+VbZS4g5/92XOCzPykqQMgvdx/M//1i5Z8dQ3PE+DMIcX0dR2hZqMtRB?=
 =?us-ascii?Q?rHFmqVceHLB0wS/zbwB/igrCJq8rc1MJcTJRKRBDwkWwOHfB2pBP0eV/TkdN?=
 =?us-ascii?Q?d/d15cOaaz+F0pAFUC4PDShanEY6ItaPzYxR3r8TIRqtcV654P0XL+Cx1avo?=
 =?us-ascii?Q?9L0LwZxLopsSQhsDI/LiX0korRDtyUwOmWXhPYBUXr67suDsz7Bf6AE2ob0b?=
 =?us-ascii?Q?CxN1gvj9jjZj1pfllbC54XprjdXwvtoUXAqwocwKSu/65vHl8+ln1ls2ZyqA?=
 =?us-ascii?Q?/0U1OXHh/6TzBSgz1Q6xLEtYPhL+W8pfy1znzCnRV8TgrF6nsKS73tFDiPYt?=
 =?us-ascii?Q?Sz0U4aT31HeRjfGMWIvjuRa9aelzGPXrCKE2tXtRj0HnStjZOk2yregqyLxb?=
 =?us-ascii?Q?6PRC29GGEc6Eb72SX5w76awYthdsOZBGKdxmQimF7AorJiHcOKfFXgVov21b?=
 =?us-ascii?Q?EoU23wuJBW7xpMV9+DBg6VAbyzHkAmuK/0OJ8Y1kjKvXdxcAnqUoROFn1+pI?=
 =?us-ascii?Q?ndwRXyQRhgtwsiLyZc5QDGe4PfmZZlzaCyaUyP0pjUrAcLV/PleyYQLRVtiQ?=
 =?us-ascii?Q?KDREqIASFUs/hkkrYpbgsJdoeGEegRtYxNjP26K92z4Rm+Ij8slg39t9xsyw?=
 =?us-ascii?Q?GQf546lgyKWeUZd/58wbXxguZC9slueDeI0K0XZsw34ec5QXkVM1Zm9Rx43m?=
 =?us-ascii?Q?dyEe2lrSBHc+cwQxeam0XcRUfBNu8ImpVgFPaWc5k9oGwfbbsAFs5FHNw5bc?=
 =?us-ascii?Q?CGp9lsL5JlaSIB1XiGs1I5gFJmc5mI0n9Qi4kMzdR4UE2H9IZANbzkYGaE0j?=
 =?us-ascii?Q?5HSm1dLRhIv8RfxS8WfPLJRsIJvdE/OuFrmHx9ZQKt2hyr+cmj2GkC7uzszO?=
 =?us-ascii?Q?a1bZBeCRbt7wbKK6fDLrVfDSYawH4kb7+S1swSGY4EC2OdxUeEPblaFZVwc9?=
 =?us-ascii?Q?gNLHl6gz7+H3kuVGtFMpxPb/?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 8339ab99-126e-40b5-ddca-08d924019dc6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 06:59:21.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPVPRHZtnbMjHi7JmE3NRMTu+gH16AkEYgX8Swb60JMe6Sc5wqSQCd0+xCmpmO1Srf9aFV7tHCKj4mVZAhQErh0ifyZajCEXLzgJjX4psmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4848
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, 25 May 2021 12:46:52 +0200
Peter Zijlstra <peterz@infradead.org> wrote:
[...]
> > We did some compute on the probability that deadline is missed, and the expected
> > boundary. These values are calculated with different number of control groups and
> > variable CPU utilization when runtime is under exponential distribution, poisson
> > distribution or pareto distribution.
> > 
> > The more control groups there are, the more likely deadline is made and the smaller average
> > WCET to expect. Because many equal control groups means small chance of U > 1.
> > 
> > And the more under utilized the whole system is, the more likely deadline is made and the smaller
> > average WCET to expect.
> > 
> > More details are posted in
> > https://lore.kernel.org/lkml/5371BD36-55AE-4F71-B9D7-B86DC32E3D2B@linux.alibaba.com/.  
> 
> Indeed you did; I'm a bit sad it's so hard to find papers that cover
> this. When one Googles for 'Probabilistic WCET' there's a fair number of
> papers about using Extreme Value Theory to estimate the traditional WCET
> given measurement based input. Many from the excellent WCET track at
> ECRTS.

If I understand well the context, you do not need probabilistic WCET
here...
If you assume to know the probability distribution of the inter-arrival
times and execution times (this is what is assumed at
https://lore.kernel.org/lkml/5371BD36-55AE-4F71-B9D7-B86DC32E3D2B@linux.alibaba.com/,
right?), then you can use "standard" queuing theory to compute the
response time distribution.

If I understand well, in the link mentioned above the response times are
measured by simulating a model of the scheduler. Queuing theory can be
used instead, as shown (for example) in these papers:
http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.22.7683&rep=rep1&type=pdf
http://retis.sssup.it/~giorgio/paps/2001/wpdrts01.pdf
(these papers consider a scheduler similar to SCHED_DEADLINE, but the
approach can be easily applied to every scheduler that guarantees a
runtime in a period --- I think the CFS controller falls in this
category, right?)
I think the burst mentioned above can be added to this queuing model;
I'll have a look at this in the next days.


The problem with this approach is that the execution times of different
activation of a task are considered to be independent and identically
distributed (this is the infamous "IID assumption"). And this
assumption is often unrealistic...
The probabilistic WCET approach mentioned above allows you to analyze
the behaviour of a scheduler without assuming that the execution (and/or
inter-activation) times are IID.



			Luca


> The thing is, the last time I attended that conference (which appears to
> be almost 4 years ago :/), I'm sure I spoke to people about exactly the
> thing explored here. Albeit, at the time we discussed this as a
> SCHED_DEADLINE task model extension.
> 
> Let me Cc a bunch of people that might know more..,

