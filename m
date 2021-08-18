Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBA63F0818
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbhHRPfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:35:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31792 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233849AbhHRPfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:35:13 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17IFV1r8007683;
        Wed, 18 Aug 2021 15:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=cA2d3vfNPly2MDiSww+nBEDfzQuwyWhUZ6Tt4CbRCOk=;
 b=ylD+y6RJS0IJKeQMnJulPGwgucMGjq4eRLlcVFzgQgQDivCoPtZK+AM7VYBpJuZKmjbe
 zgYNfBN14bYHkvLh1TeCX319Nf+gOuWWErXzllU5C9He2hvwmVMRlsEfVqphymx+WCZ1
 xIWybUpvR1fn/gmLy3Mn4odQzx912GxeVuXqeuNUqN4WIKkzDc/4iWj35wsaW/YuwhzQ
 6webx7pv0+4n/IYB/n0G4wEuvxxEqj+KmCkdaOkOHaKqkRDDjVnA921dxT2XItrS7Ysg
 kap3OngwYQvDY1DvoRgRgIofg8Dcln8BDtKgRINvi6GdIA24mNa/mn58fULdHROvRheo yA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=cA2d3vfNPly2MDiSww+nBEDfzQuwyWhUZ6Tt4CbRCOk=;
 b=a9n3ESgRBATLTItfVGjZKKPARqqNMFVp+F3Ux8O2g5Dpjq6ET0YCgPjDw6uyeBafCbOf
 p8sdisgFQ18+yRP5298C7wgsBrqNHnXC8g3k2JouTgryp6tl2g6HcLucsNhI/8wTNKJk
 KoyiRtCoSG4KietgEf/vcSV0YQA/FxvdbUR9AKqxeZ5quKF9U73x/ZQ/FbuJv4lzanif
 mImiXR6CDGNsre0Sei7VZfflFakxqT38UWisQOa+rOjukJvy9vfh64vbkENV3L0VlrXJ
 vGQrbkIISStXQ2FhhO3w/sfzPJvJrTBbSrXFfWlf1msMBXWNRkaD0hLvQjS9Xp6eE3vI 4g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf3b59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 15:33:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17IFV4eM073935;
        Wed, 18 Aug 2021 15:33:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3020.oracle.com with ESMTP id 3aeqkwg0dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 15:33:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZ/PNv6sFjdrBgtCWTgynRZTg1tjuu3hUgH1pNYKFmQg3LLTLG+R/7O2n6/8RA5bYYVc05z4in1An8nvGRAAYkGucxk3ZKis36NxAUHL3tYQkZRndhBpz5em3h9PcXMKR+iD+/PX3RkNUh4rFKpA0QrBv8v1CPCr5IxJBrO9aNJZ7XiTK/9ykW3A7//uGape8Z2VKikb8FV4XmPiuhN6qCxz5wRyntCG/AQ1YJNuTNGWaExiNxKKfrn5jkd+RJ5ZKNXvBMoIeQX2L+EWO33mrM6Vw5RC/2anDYPJfbi5fo9nYyuVIJYfisRkj5Hd1I9AOOSoT4TzSeJEsiiozLyXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA2d3vfNPly2MDiSww+nBEDfzQuwyWhUZ6Tt4CbRCOk=;
 b=KkN4VTiFdrGQyJQ5+TlQIlYHe1L4BFOHq/UVXm5KshzczIUNmY8gdHglWPiRHQdM0kwZjpx6pgHcAt7cVh+QGnR+bmZxjsJm3Hx9woPp0JWk75HO+6ApNLB4vIPXHWCyKmLDrFppGLC4/4SLESZiCh65oZvzA6t3NDr3TroV6esAE3/wctK7P+E9iOjxftdRg8U9donO+IJL/Y1Kj6r0ziX57ef9MG3PCrPvhzRbUqOe9qcNsyC53dWVnCSO5Jf24/k6KTfMVjiz+DqKHaE5QRfH2gmsEY3HHxxYVgRCwtiKLjcMHJQArUwoxc2uS8qOB4veaeHnfK02kAvuTTpPvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA2d3vfNPly2MDiSww+nBEDfzQuwyWhUZ6Tt4CbRCOk=;
 b=OobEaK1NffFso7DIpAPu5mGD7Tjq7g3bcyQTWmkvjYDO+b3KMYa1YPkzmou+EmL7ThU8+2DHDw2PjYRCkchEhAIKd9LGyjM9jhUob2DRgD3qoOSv+Td/brWznUTpmCKMZvJUHyiPdg1izNgpHy9zza1w5Tz/YnIoZD6jEAuxkF0=
Authentication-Results: baidu.com; dkim=none (message not signed)
 header.d=none;baidu.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by SJ0PR10MB5485.namprd10.prod.outlook.com (2603:10b6:a03:3ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Wed, 18 Aug
 2021 15:33:44 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::203c:7f44:c562:b991]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::203c:7f44:c562:b991%3]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 15:33:44 +0000
Date:   Wed, 18 Aug 2021 11:33:39 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI0=?= =?utf-8?Q?=3A?= [PATCH][RFC]
 sched/cpuacct: Fix cpuacct charge
Message-ID: <20210818153339.a7kz4irqbzk32pyi@oracle.com>
References: <20210720060441.22550-1-lirongqing@baidu.com>
 <YQKAzWT/bdwgepbU@hirez.programming.kicks-ass.net>
 <4bf6cd58adb5411e989530e1443f9698@baidu.com>
 <20210816162103.dup2hbho24wtmsgs@oracle.com>
 <06265d4d0df7410786d0ddb9bdbc4e4c@baidu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06265d4d0df7410786d0ddb9bdbc4e4c@baidu.com>
X-ClientProxiedBy: BL1PR13CA0344.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::19) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oracle.com (98.229.125.203) by BL1PR13CA0344.namprd13.prod.outlook.com (2603:10b6:208:2c6::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Wed, 18 Aug 2021 15:33:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49385cbb-553d-4656-a64c-08d9625d9082
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5485:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54857D82F219F58321B2C4E0D9FF9@SJ0PR10MB5485.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9GNBS5WjNQWJkkqrQftkx4J4dpMh7R6yc9svWZjewFNwiBK42TeqBMyraQjGamEOuaqw3Gzu0zJsfUCr890j3bKY0CZZue1dkt8EqjTTpE3E4hpXSDmrtCKTwhv9+PwkOip6nx4DtxdmkjGjvXVFnOK2N8m3kU7VLYgkDn7xnXWZl1L4qLyAuFNzjW059aptR0VpupP8JLOj9qug2LoaL9fnZI3LFqU4uWo5fDNbqnTqUYFQot5JD7+uOrzFbyjltfYAfvelnBY0GW7l/RY006Ka6KmRFBbcBiatTxBzGEk/F8gs6Mb1YedCw1FSkEVxMRB6sqDZRKw2trAZiTIGZegZx8OQ7MWysMSEZD8V9cyyqvPn/a9TNqmgYvlJZChu865DoNIYP+yChPeqgOk1cKUMFkOnU4W0RjnhcHNSRIsAsSik/2ALkmzenS/Oj/fmsWeX0ULla0bgZ26oNd6CPSY1VThGLXO9ATmkglBnV+zOLH3wZvZPHywNKjc8DQdZ/ag7ACGzO63GOw/szCJjDACrAxLg5Po+j7J0PIln3qO50YYMFx1vFtqCwB8OD5WmzYYQo+3Az21Dz8mmAydSkp8hQYn/9H9K7gr4djQbkSdRzUGBQEdOg+Ua8NfxdvFfb05hBV/3vah9G2El2tVW87D4YGBmO9QxsJ10xHkCQhv4Sj9Cli6c+iJWM8ksnrbNlKp0ygoYAkm1QgzZcxiu6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(136003)(39860400002)(2906002)(86362001)(6666004)(8936002)(38100700002)(7416002)(38350700002)(83380400001)(8886007)(316002)(186003)(55016002)(26005)(5660300002)(6916009)(52116002)(7696005)(66556008)(478600001)(4326008)(224303003)(1076003)(36756003)(2616005)(54906003)(956004)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3XRzHDzc4i09NPIBRMbwwXaOQpDZczupsEp00sYPgj+gDBEb/Je4ubLZ/wPU?=
 =?us-ascii?Q?i2uAH4EOF8+NJZRjCFUMm/YHseOfK2cWM6UuAZ3CBSXEnjdcxyWYf9YFr86s?=
 =?us-ascii?Q?UPh1lygSwbsmVk923glm9bEuDKSJn/jMsJWbSMp9UCb9mZw4qpKeMxKtwliQ?=
 =?us-ascii?Q?l4UXG33NOcZopZvHqNJxy5wxSKDya8ECvS6g7tAdbKg9XhMPT97KCPsOnIyV?=
 =?us-ascii?Q?HpQNt+WHvz0u92MhCM8YLs7WgnCK6yWDsB4JGgRUbFGuT2FNsRxYQDKRZdk9?=
 =?us-ascii?Q?zlrvTv3q3c0RbyLsGxaKpt0elCxbuNhBmr3/k/53i0sWEQvk7wxrhc/e4syS?=
 =?us-ascii?Q?gXFBjZA2SgZmT+ipgkQBr8pDPGvVPdOhPqYpoQcQglGhQeGxxTxNWLPZmWAz?=
 =?us-ascii?Q?s+A10m6K+Q35DTniOUwpR8sHpjqI2lHYYZ8iyBVD9lPlU1tW2GJ2ww/ZrgtX?=
 =?us-ascii?Q?Xguvr/5+B+o6/WDHtEkmqZTE/yPue9spq2oI345DyMTHDZ3XN2Qk3Uu/UoU2?=
 =?us-ascii?Q?avG645YQr5jjYXDA7qwyNkyaJbQZMPCi8ytQhYn+euuHyeHS4J+mPNN8BZ6M?=
 =?us-ascii?Q?Jz7x93zpPg6MsBER61mp0waKC6JF0zWSaMqxTvyHiSbtmKO+PFU2ON7g7Ah2?=
 =?us-ascii?Q?NaMiUSOEwql1XAlll2+MnEml7j5CLZ9NdERXSxoEQI+MWi+OTiWDM5o1DJYm?=
 =?us-ascii?Q?KbLtmE5N7+9BKMlN5iEeXxXxofxLWTgCOY2v34siu4o+YCisb7u6M+UJ/sMG?=
 =?us-ascii?Q?rkFGMMmUbaYEGTzKnUnfSkv6l4QZRJIhupT9h5OXBMJewdQ6bF1xdSY/KEP+?=
 =?us-ascii?Q?dAJaJkPrSFsWFmD4A9UhbxQLOBDVrkACZELt0MIiFgdJm3WLtmwk5CEErAYL?=
 =?us-ascii?Q?2Ppqp1Dm9+cZX+GXJrqHfsXvDi85WCE94Ybv2T3h9q+/COtIMgkM1uCxOxAJ?=
 =?us-ascii?Q?KRhrceqrP4IgtCJvnVcrrlERK6ufq5WYReNN0v4IiE/3Bw1hDxC+jD8sfmlF?=
 =?us-ascii?Q?l/+AJcaBd7EELtTE35avq9mVppp5ZIXKr29qdsxj95By8t846cnHTLZjKMsW?=
 =?us-ascii?Q?LuDCQshyoaXP9iw1/ouELbu4or0SrEVJ3QTbHFZMd6m7PNHXRNAa7G0RvqJD?=
 =?us-ascii?Q?F8A1YiNFgOoeYmHVV354tKI3HJHvmrsnzgG86hCn45wxwarEpiZBA1Ar/esH?=
 =?us-ascii?Q?J9TfNw7dQ47wQaaZKucLcaiDzb4Ewi0u4iWNexlkpRM0LCF0G24duzByl6T+?=
 =?us-ascii?Q?Em+cA1kWprwOShsXHP34/tAeeq/pf3oYb5misOkcDrz6xvz1r3kHIBGbPyoU?=
 =?us-ascii?Q?vlv17t7sbWOglQQg92sIGoqM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49385cbb-553d-4656-a64c-08d9625d9082
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 15:33:44.8146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ey+zgxUeiL3sucfPfBJ1UGsbhwiAFCWyqn/osQ/0oxuy4/UYKc9dFw/w4NviefNGzhWv/Qfj+fHDMyBPYGbB1xtXoJD1a+mknfemy0VR3aU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5485
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180097
X-Proofpoint-GUID: BUjHpAmfWU1n2nrC4bQbpeFtmedwLr8U
X-Proofpoint-ORIG-GUID: BUjHpAmfWU1n2nrC4bQbpeFtmedwLr8U
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 03:55:08AM +0000, Li,Rongqing wrote:
> > > diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c index
> > > 893eece..48b117e 100644
> > > --- a/kernel/sched/cpuacct.c
> > > +++ b/kernel/sched/cpuacct.c
> > > @@ -340,7 +340,12 @@ void cpuacct_charge(struct task_struct *tsk, u64
> > > cputime)  {
> > >         struct cpuacct *ca;
> > >         int index = CPUACCT_STAT_SYSTEM;
> > > -       struct pt_regs *regs = get_irq_regs() ? : task_pt_regs(tsk);
> > > +       struct pt_regs *regs;
> > > +
> > > +       if (task_cpu(tsk) == raw_smp_processor_id())
> > > +               regs = get_irq_regs() ? : task_pt_regs(tsk);
> > > +       else
> > > +               regs = task_pt_regs(tsk);
> > >
> > >         if (regs && user_mode(regs))
> > >                 index = CPUACCT_STAT_USER;
> > 
> > It still suffers from task_pt_regs().
> > 
> > Why not make cpuacct use cgroup2's approach?  Remember only delta_exec
> > here, then on reading cpuacct.usage_*, use cputime_adjust() to scale the
> > user/sys from cpuacct_account_field().
> > 
> 
> I think your suggestion is reasonable, Could you send a patch

I'll leave that to someone else, got other things going on for now.
