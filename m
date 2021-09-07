Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106CD402D84
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345617AbhIGRNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:13:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49476 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241028AbhIGRNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:13:14 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 187H9ANs015642;
        Tue, 7 Sep 2021 10:11:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=uq3EK/b0eOql9a7bfuqFKe30n0FqPpqFQ86AQrU+sT0=;
 b=JPjEIHVVuHYQ5AGES3vBOIaAxyM624Y6ZkVPAFcGBmhKrwHHTsE4CpIOUfAtlEszLOSg
 hSDMuLAKUVOHz5t12XchMsNYbmG3B7AGi06PqKb8IvuEyhkFfDvkD7lRhkZGXCK/TvTy
 jPo60lhqXSYId+7J3rVHHlyeW6nnycYXF7w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3axb8f0kn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Sep 2021 10:11:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 10:11:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS85Oh1yRBctCOJN16prNkBVnnjVnqchEFrTfjB6nVFP7A4Zz5073C9UZFFlKL8ZuAlg9CAiZs/sMUyDNqor4tskVGXNv6QwQVo9ghetcVcama/IMTS8F45ppCedF1hfc12RSjCnWZPncoWLLe1hX0oGAnlfsRrFwzhRm8uCOXBlZpZk6vqEkYPa+NCvsjhaxQj2wpQwOPZgb4h+fTnRtFL0A13iGh1BQ3azLxH8C+Lvul5/5hoZuXx5eKfNg6eu5Y49LgftCQ2lhlm6dURmUt9K1Qu9fwPXGAJl1iu9e9Xl8GxyRkNZuE0vhUsfbDnV+n/l8Ie3Rz8Pa7kc/zGG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uq3EK/b0eOql9a7bfuqFKe30n0FqPpqFQ86AQrU+sT0=;
 b=dAQSb9WXWehN16SsBZm3lkhE1PJfKB7H0fIb/S4pf5j9OGdjjTnyAACPFtq/HjXklTP9pm8xLsC7HWN7xl3SO/4EeTS17Cz9ckjUeGD41U0q8EOCvZUTqdcP1Wj0c/Fam365WIDQC5e1lXSD4d110bYO9WDQlFE3aj4Amt1T2o1ntBrO3H3MRqk8G0NAersvvr3BN6p4cjGGGD7/ST+RJXGbIIb+QEglNXq1ma0Kh+siQnEIphnxipDt+cJ8XKhI/Ugje/KdBQ5WY7977vrIa6FSH41L+8sk4bU1Xq6agwadBX4PxS9NgqyMic2fJAJvKCW6SVSRUW7OduC91VOntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3448.namprd15.prod.outlook.com (2603:10b6:a03:103::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 7 Sep
 2021 17:11:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1144:84e8:6ae1:833c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1144:84e8:6ae1:833c%7]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 17:11:24 +0000
Date:   Tue, 7 Sep 2021 10:11:21 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Serge Hallyn <serge@hallyn.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yutian Yang <nglaive@gmail.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: Re: [memcg] 0f12156dff: will-it-scale.per_process_ops -33.6%
 regression
Message-ID: <YTedOVCV3s6Z210f@carbon.dhcp.thefacebook.com>
References: <20210907150757.GE17617@xsang-OptiPlex-9020>
 <dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk>
 <CAHk-=wgrF65BpP6P6_a6+k+C8V+JOBiEx0X-c9idiM87uk32FQ@mail.gmail.com>
 <774dee70-69bd-9f95-d197-4cff83e4e633@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <774dee70-69bd-9f95-d197-4cff83e4e633@kernel.dk>
X-ClientProxiedBy: BY5PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:f46f) by BY5PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:1e0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend Transport; Tue, 7 Sep 2021 17:11:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 158c725d-8824-466a-cb0e-08d97222857c
X-MS-TrafficTypeDiagnostic: BYAPR15MB3448:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3448D3357D6EFAA06D389ECFBED39@BYAPR15MB3448.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+lt8dRLSKtz6Q7U1FNU9mFB9i9/MdmOD3YnnpaB9C7DlDRa+zbXPQ/Lh6Vs7CzMc0qQniCUsxM4JQxwpiuj8u+x+mJwRJaY4oadfJdh37+HuT23YdXEXc3coF9b30IKtizgdM5d/SVAsEeteTHwGbZhdcJsALLriNlBgvPvskTisJys7ZjjfRt+o4cwb7IfH2BI7krObrh8yU+TSogllhps2toneXQb7AVs809xj8n7dQV9eHmvMNjncXJC8z7W0tWwSWmGXnokL8ielq1XkNSWkTQPAq/u94JH/6D7AfBBclqJn1LhgfaQKdnMCyPQVsDSDOYzm+/HeBxIRJRJ1t/BpHVD5YSggZPrivV1DOsIE/OERcXynnnyY7A90dHEXwsidf+zsVP0hr8M4Gvr9AmLqFaFOpE24lHPN2aZfMLqxTkz2un8gEeAlQYNsHayQPyOu+yudj0VZThe9OJOvdQUpqHjW9NHmHswB8K6t+7KAJ7CwKfoEQDtHDVVggCfnJh5Rie4mUjjS/B4ivUNOUiyuMR/lNHWWqG1Qy4Z3uo8EIThLp4lWm10MViN4eFoz97UUZcMHlk9zjT/jBsR48Yv8sKTPRmVFCSLbDTfTGx1n/W+GiKHLNTIXMXt3UJqlUM5FLSob7/y9rNwi7pEUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(66556008)(66946007)(508600001)(66476007)(8676002)(9686003)(8936002)(5660300002)(186003)(52116002)(53546011)(4326008)(7416002)(83380400001)(7406005)(7696005)(86362001)(6916009)(316002)(2906002)(54906003)(38100700002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fk453BclGFspxLN+TuUZlsbMvn/vfur66XoA1gsb9kRM374Z1HcounpzyDOl?=
 =?us-ascii?Q?uSVRsCtyo6QBdoNC79EI0rVdDgzlsYqRBk8kdQstkbSOzxyJSQUTjufiAGvP?=
 =?us-ascii?Q?rE7WscAzux5RdLuRoTt9hLn/h3GisppD4epobLRmucvrM5qlQOOhDUnkLOxv?=
 =?us-ascii?Q?ovq2onxmKf6tubqgg07/0ut64oqwseeWCUdI0jaM4Szj2i4LQvwOvuOhLpPT?=
 =?us-ascii?Q?qK0pMXkbalSe62gebOO79hbRb6UWRnqOAxSxRBCAAd7xEYEBpknRJo/pSqht?=
 =?us-ascii?Q?/pjyjt6cM2/6wFHhJezPv2eobcPUXIvQggvsK25xgW1FnlG/J7XC6FmAhm2j?=
 =?us-ascii?Q?R9mf/VRKvddU9ZCmwu/VMhHKFPU9WpqIveBechHZe2yCZsDnTfKznHt64HJI?=
 =?us-ascii?Q?sNitfzh6ptrrlOvrzzTL4bTwAdD/cIcN4K6xCbsjn9240n9KkF0BgnLP15+m?=
 =?us-ascii?Q?fde06SB2awnWJIaUdduMDZndxtNQD5GY7bFxrma5KQP4YxXQ6SDouyPpOBJC?=
 =?us-ascii?Q?wfzcY4RgIBf35ul+duu0XUFMZ8BiXA8u6UbdbB90Y6vK7oG5frQWvRZCvuB/?=
 =?us-ascii?Q?ZD8qVHhnfEF3UxX2Gbweoy0EQrgOP1AskKSGEKzTlK/rhRiFregKmuLCGYlw?=
 =?us-ascii?Q?byaEeE63lmssqODQgx+FauQsbc5OdQiqiHzj//ct6mmPITU1y5yVEuvoU9MT?=
 =?us-ascii?Q?lROSP6QG7KoOzZRyNLbbRk2knNU+cQq2GNiHNEQ9x44nATIr5XpVkVjnL4GE?=
 =?us-ascii?Q?G2yCzS/Gu1fn5pYamoVM/DwYkEOFxlhEK0e2MKjtkYX5qzqH1tm8vucyodD2?=
 =?us-ascii?Q?Jbi7e/cWBgr9XtNHlYXDkuMS1AGsE81CxB67kETjocil2RDfvhjg3mIzNIfU?=
 =?us-ascii?Q?P2o6ogDRxc0y0sXF/x4TGNsn06En/5AJBCO0G4bQpqU2xeMSzkehGVj6NZhw?=
 =?us-ascii?Q?XtW4C86Tc3Ct53MMHRJKAjMgWN/X7T8HtWADmfEk1kx0fGcDOdqsHclqwZAC?=
 =?us-ascii?Q?kVu4g/TPTj0+dhvNGA0kC4NOGZoyQtCrWSi3RMy5hP13fX8QH1VLuQDgPS2b?=
 =?us-ascii?Q?fneNi3jR8B+I3tMh/TRF5oPk70Y8tN3H5cXvQawc8mOLMtd7UMWHMvpR93Rg?=
 =?us-ascii?Q?6V6hqdWmjdiTpkz4TEcf5sYyIqXPk5xKDM02pZZpCNHOqMRh1tJ4CMW8o1Ip?=
 =?us-ascii?Q?8zweLs0a8ZMSRwzHKiTwlSrdeh3TqVsbZpOoUqu7bIRy79BTwazBPTirtwKS?=
 =?us-ascii?Q?H0rSad0cU7PwSirw6gf+q9zEwMgxB/rFXyKJV8tyDhiAB0MXLgrjwfNMw4Ct?=
 =?us-ascii?Q?RrvGFwlVcd2iF85TNiQ/P2ZAu/2upJVPbMLA1nK9Df4C2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 158c725d-8824-466a-cb0e-08d97222857c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 17:11:24.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ap0shElmae6gR3Lo2xa5TYSSe2X/wnSK4G+lgO+bJjQQ1397ix30x9iCxIZcJAZf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3448
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: jlyPk5568zMFQXJlTjOT9VAiiZ9b0k5N
X-Proofpoint-ORIG-GUID: jlyPk5568zMFQXJlTjOT9VAiiZ9b0k5N
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_06:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 malwarescore=0 clxscore=1011 phishscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 10:43:46AM -0600, Jens Axboe wrote:
> On 9/7/21 10:39 AM, Linus Torvalds wrote:
> > On Tue, Sep 7, 2021 at 8:46 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> Are we at all worried about these? There's been a number of them
> >> reported, basically for all the accounting enablements that have been
> >> done in this merge window.
> > 
> > We are worried about them. I'm considering reverting several of them
> > because I think the problems are
> > 
> >  (a) big
> > 
> >  (b) nontrivial
> > 
> > and the patches clearly weren't ready and people weren't aware of this issue.
> 
> I think that is prudent. When I first enabled it for io_uring it was a
> bit of a shit show in terms of performance degradations, and some work
> had to be done before it could get enabled in a sane fashion.
> 
> The accounting needs to be more efficient if we're seeing 30-50%
> slowdowns simply by enabling it on a kmem cache.

There are two polar cases:
1) a big number of relatively short-living allocations, which lifetime is well
   bounded (e.g. by a lifetime of a task),
2) a relatively small number of long-living allocations, which lifetime
   is potentially indefinite (e.g. struct mount).

We can't use the same approach for both cases, otherwise we'll run into either
performance or garbage collection problems (which also lead to performance
problems, but delayed).

I think of maybe building a generic cache layer for accounted allocations,
which can be used in cases like io_uring. Shakeel, what's your plan here?

As now, I agree that reverting patches causing a significant regression is best
way forward.
