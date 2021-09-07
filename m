Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6884C402DBE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345662AbhIGRck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:32:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62668 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229493AbhIGRcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:32:39 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187HSAdp002074;
        Tue, 7 Sep 2021 10:31:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=YddA6gcHT4qdwMCxDLoCMVJvsWcQFGBisYxqxj1xaa0=;
 b=Wd1XNy97+JLdR/6VnPDjZDnM8KHULjypNOeiZR1OFVH3YHF3kQaaB1SaBDmy84eQefyP
 io6naaeNemHXn99oml5gfUNADSLBJrOaXrxhMCSyFxk861Wt4vqc1g+LjzSTkzL89NJW
 luUJQAhIDk3VfGBBCFSNGikLg8RRXut7/Oo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3awwxp5whh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Sep 2021 10:31:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 10:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAByyJT76Eyd5AOfYgcjn//uOTrZQGR9D+sRAQgAES2RM5FgCI1JCcReCZFPOd7WXa9fwDAPCOMkLnrHaJdKyqf1KII1KQKJoPE8uAuYwKlagLJeAvJHRqVZYCFkg9Tf1Nsf7z8bZQHx/XwmgUyjLr3ahkGrMBeKEdyxLOZ9MoOd6N3OzY6OTJoDWdmCpFWa+W8XHEQtszply2PodzwPvZv9bD+cStgMpum0dtHkOcUEQggUupjfiATHgXqXYFqDhXGx06xa+pcMZIzh/2F8cr216xcYx3d/M8JeXg6rnWxle60Sq01GqbHd1jlvAIaJKZXUhDfKyDiYQdHwbdyLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YddA6gcHT4qdwMCxDLoCMVJvsWcQFGBisYxqxj1xaa0=;
 b=UwN8rg7ZO8z8w3RwTR0+RXh/sxiJYFzOfLDfQmkYjZS8fyllHfFdbOsb6gkM+KEHEI1Alx7HRu5jKXg/NI7Up16V5SAiavcktvzmERRYkI2QnJpxf5wBaNpVu5WQOjuyyqI4zljv7/IwGNHtoTuNVoBaTEzNxb7X+G4EoL6hikPz/mJVb0vmbYXXPSUyMdXNdeSJ6WSicnVmkrxllUL6gRs1v249sDy97v+gTzTS5Bley9TCzbSp4N5wm6zU98445xkxPQCcfRUMCxXdmXWm/7XJOBgxk8t2lW814Gq4xcUmHv7A2Jvr6DZlzVD/w9d5+o60KMB92AZdTM7zBKQOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4373.namprd15.prod.outlook.com (2603:10b6:a03:35a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 7 Sep
 2021 17:31:04 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1144:84e8:6ae1:833c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1144:84e8:6ae1:833c%7]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 17:31:04 +0000
Date:   Tue, 7 Sep 2021 10:31:01 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Serge Hallyn <serge@hallyn.com>,
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
Message-ID: <YTeh1WkseQtyboM9@carbon.dhcp.thefacebook.com>
References: <20210907150757.GE17617@xsang-OptiPlex-9020>
 <dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk>
 <CAHk-=wgrF65BpP6P6_a6+k+C8V+JOBiEx0X-c9idiM87uk32FQ@mail.gmail.com>
 <774dee70-69bd-9f95-d197-4cff83e4e633@kernel.dk>
 <YTedOVCV3s6Z210f@carbon.dhcp.thefacebook.com>
 <YTeeBf64yUwj01Sf@slm.duckdns.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YTeeBf64yUwj01Sf@slm.duckdns.org>
X-ClientProxiedBy: BYAPR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::37) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:f46f) by BYAPR07CA0024.namprd07.prod.outlook.com (2603:10b6:a02:bc::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 7 Sep 2021 17:31:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f2a75d7-bacb-40bc-32be-08d972254494
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4373:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4373E3929185385B5D9B372CBED39@SJ0PR15MB4373.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WfdJwYBt/dqL1AgoADmv2+uuDSXrvZ/E81Z3YdEltTxZ9Tm3VyxAWV3OM3jOjd+8MNOgfZnkyt7kMc4xG7GEkcmricJaZvs25iIuAynhqGUZubd/IGY2iLPNWlmanz98x1Y9LqB57sttEvTVj7x/QrFzTIRTlYbqHw2syPgS+01GRBjdpeYEsMEoLHk264/l1I8oJjLTFR1TXhf8ROEODAKZU92NEx2bThmWluifTfV2LBcld2JGMg1lc8cUuNbm5MsORIs4VSHt9AB1THUFKMcNQUSTs5fWkyQsdCQmne12tukcli/gtrTJziGrbQh9L60/bXpyEM9aGG75wNTGmLNdBfAjqDkhWhHTpXby0uBpTH/aIonTQX9TUCdGy0Rw6fxoxPP544bWJ/O7a1h819dHDPpUN47gLdh1rX7SrLxAykzYY9XfSjiM4ApbRFOrzhLsCnjHj4/vIaJX4wax1O7u6yziXm7F9uhmiPs9zdjM4RsXePGH65ybmW89rV3SIjfZrHpprTXnZkjz126onzH9CGVryvvyO34Z5pull0TqmZSOIWve/BlD7IYt5aS1FPMTR+KLSaE3zXyoGtDpS+3SsYomZMLX6RsvQrA6RPFLFIe9I29PLIf5IBnKhLFe3SONimbFsN9FrQonuOZaqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(7406005)(7416002)(316002)(38100700002)(54906003)(6506007)(86362001)(4326008)(66476007)(66556008)(8936002)(66946007)(186003)(2906002)(55016002)(9686003)(8676002)(6916009)(7696005)(52116002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2DPeKor1Ykmmu9n0sVOmOnrZK/QQezV33ySTqfm4svVkoPLJo6Y+GkP3iIAE?=
 =?us-ascii?Q?zLOYUMaMa+iWr6GNRzJsAz7dQauc/+zlZA/37yoB6PKctoFuLUEvQ04h5wx4?=
 =?us-ascii?Q?Rr0eucLYoQbYZgWDsXVSmy7QhjB+zTfN27VN287HcHb6uaT9IbkhtMZPzewp?=
 =?us-ascii?Q?F4S1nW60xbEdysD683zGmnr143ZCAwQhfitS6p4mVeBVhfY9RMzJXNT1sF+j?=
 =?us-ascii?Q?N2fmyL/u/r723gaoDPZRXCvwh9NwzKfwWn2i/eCBFjx4TZ2Jlu+Yn/0tgURo?=
 =?us-ascii?Q?/L4h/rLwvMaDMiTbnHsrLbH6b7D7Zao/NbOf7Y9F7Lbxo5UsA3eCtuu0JQeV?=
 =?us-ascii?Q?XBvvUI0zeklAca99MIPzeT20QSyaTMh5wYX9LMRN5Wa6TGyI2OK4pbHwXcAL?=
 =?us-ascii?Q?jOgJXZL//zlSzgrHxOvw6Fb4RV5j5kzZfm8RoxedP9zZbf/LQ6fxPxJ5og54?=
 =?us-ascii?Q?h7qSYYABA0Fh/8sF/hOdMM4RpHaNCVklWyEw75Sc09XBDqz9tibphUyLtS4D?=
 =?us-ascii?Q?e6E3gw801kexD+B/H//sLrMVq9Xp7EEs19omE3ztqxr5zsComhHdGHSYKVNB?=
 =?us-ascii?Q?C/13ufpD7+gStIj6hqmaGgedUSL+YycW1FUfpM2RgGcjq7MpoLA4yhqBkvNE?=
 =?us-ascii?Q?cFLj3VHWDmQ6WFHcaarj4PJtCGLFzTXROp7Ni1/Df0o++90XPyXXbd5GOhpx?=
 =?us-ascii?Q?ToLMpHjsX68+IKFbWf+RNNxSN8dkk2jqYh2L0g4hlINIWy8IdIP/emSmiKav?=
 =?us-ascii?Q?0mRmIJJSx1o/rcdIAotXtLZZFJjGVtTD0/XMPGGbpc/0JoOBE167u9kr6wIy?=
 =?us-ascii?Q?uAK9AjdT53XlPQRO8qnkzwLZ3cR6ghfeS3BWjCdSMnGmI7ChC36N258Pjhv+?=
 =?us-ascii?Q?k/AumhczbaGzBe4vlBWvoj4pxUdxY99vsv+UCrivD1GMxc766TguSTSVn7Xg?=
 =?us-ascii?Q?1Jd9v9uwkWw+DdZWMTr/yqBoeJrkpSmDCHjIUCiwZEhmnw4CPkXwgySGFDOp?=
 =?us-ascii?Q?NnJbuyrQlxAK8yIH6oBqW7gwwJgBP3oh/H1neFxAuP+sg5OD9nTxR7ADKyrx?=
 =?us-ascii?Q?Z5za/Y6K4+SkWWW5ca7gCM0XurGy/KqWVLb+ALWp4ReRw9hs+tuc1du6ycza?=
 =?us-ascii?Q?saT4JHfASLzhIjvd39TqD66v7sBUtkDYAzfqOO0F2ng9ee7sRY8rRFEgDgXx?=
 =?us-ascii?Q?7LIJtyAfJjMGphHz/blvwA5O/BOPk4rZ0rbGZZEvERPuzgTlbLDmYaQ45/CU?=
 =?us-ascii?Q?nyo6/Or6x0PEoKPP6mzBI9i7JhpLgsrCkVyiLhOXZUREAmdFcqbn3UI7z2sG?=
 =?us-ascii?Q?KLDfUkadOCLs/yQsSEEWZ4BfgUAqDLiCP34dk1Vmr74kDQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2a75d7-bacb-40bc-32be-08d972254494
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 17:31:04.1084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gtNkXI5gAyQ7Lzwd8I6U9wolWEIU0m7tnmFvVTwBToR7qu1GZ76+J2UkMBncN10
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4373
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: k4aoTwQNHXlErLeMTnvpHwBZIAebWsc3
X-Proofpoint-ORIG-GUID: k4aoTwQNHXlErLeMTnvpHwBZIAebWsc3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_06:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=971 bulkscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 07:14:45AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Sep 07, 2021 at 10:11:21AM -0700, Roman Gushchin wrote:
> > There are two polar cases:
> > 1) a big number of relatively short-living allocations, which lifetime is well
> >    bounded (e.g. by a lifetime of a task),
> > 2) a relatively small number of long-living allocations, which lifetime
> >    is potentially indefinite (e.g. struct mount).
> > 
> > We can't use the same approach for both cases, otherwise we'll run into either
> > performance or garbage collection problems (which also lead to performance
> > problems, but delayed).
> 
> Wouldn't a front cache which expires after some seconds catch both cases?

I'm not sure. For the second case we need to pack allocations from different
tasks/cgroups into a small number of shared pages. It means the front cache
should be really small/non-existing. For the first case we likely need a
substantial cache. Maybe we can do something really smart with scattering
the cache over multiple pages, but I really doubt.
