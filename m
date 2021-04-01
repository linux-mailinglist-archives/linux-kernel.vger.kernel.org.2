Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4D43521AE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhDAVeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:34:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17534 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233588AbhDAVeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:34:15 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131LSmFG027234;
        Thu, 1 Apr 2021 14:34:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=5gG8Y3pQeDpOAaoGxBW42HRKc3IYth+6v0ngYDcASgU=;
 b=ZXe+skc2kp2hJN/2fIvafDgkn5HUODZA3k4VFb46+6xIkN6L7bS2Czd1e6x2mv82We7+
 470cprTSUlV2BtquHOyHsHXZAawY5RtoClWi0Q9QddahD371TlHezWWyqX06HjkOdbqF
 cM+X+v5D9m22CRACwr5nmPd0rnXpPzHnyPg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37nn48geuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Apr 2021 14:34:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 14:34:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyhwXk6E3Oimv+IP0YDiQhKpuguWUpbD29lpgKtlWnS/IjDMWP91/qpPejKF+1lk4vYeDPIRMs0w64EuMGo/6B65MishBxxetY5p0uZCYB8U44MYbiGQCYN8YvS73PhbwY9O5tWvVnZW3xr6pDenJrP16VkmotbJwe/LN4V+od3gir48oAityV94r1n8qVU5t8BvZWwrgrGIRGcHW2lIM1v0vDdQjqoOEdsX9HRczVoHoxBgXB0GKON3RvHk+C0mqcI1/eYuzMNvTjhfT1VNPl7xDEdODDixL/r7CP9UfC6/vfEjuM8CpiEVEmpC7+sljwzOR/D8czbWPQgyFJEYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gG8Y3pQeDpOAaoGxBW42HRKc3IYth+6v0ngYDcASgU=;
 b=JHtxrfJQLwRn5d9lchYPFlV5F/8p1j6ZZpiEoZ9X7ReZNBO7+Xg9EWsMuDLL+AvE7JT7FA03IIfTkS2yT/+8zqXRKwLG9gZsoFSXD28c8UovUFVWqahjWHb4IDQQ/LV6RO6hAcKbeXUq6q7cEuiKjgC2Oz13uqqE3OwHbaBNBZYf1qZtvu+W/7Ili3WQx/1vMzL2JCuahxkMTijtX5/csm+cUlkRErhnoxi6LsZVESf5Um10OCddtwWjh8UERlvog6l+J4+YEysPKbkHvE4nVRIbtWOaHi/GCId+/uP8PXluuovwG5d35uHTiXuK/NqgY1iaZLNJ854L640yHX/fyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4153.namprd15.prod.outlook.com (2603:10b6:a03:2ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 21:34:05 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 21:34:05 +0000
Date:   Thu, 1 Apr 2021 14:34:00 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Subject: Re: [External] Re: [RFC PATCH 00/15] Use obj_cgroup APIs to charge
 the LRU pages
Message-ID: <YGY8SIdOT3iY32Xq@carbon.dhcp.thefacebook.com>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
 <CALvZod4xHNmTQMd+zg71s7uyXUHEfwnQ-zqRXSWphwi9RogeNg@mail.gmail.com>
 <YGN0141iu5HTGiNJ@carbon.dhcp.thefacebook.com>
 <YGOYYgWbwiYlKmzV@cmpxchg.org>
 <YGOgth4IUflVE/Me@carbon.dhcp.thefacebook.com>
 <YGSSemLLpiHJHanV@cmpxchg.org>
 <CAMZfGtVYMDt_3CyH1g8d+Sey8J+W2HVY73xwCk_anm3UgHcr0w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMZfGtVYMDt_3CyH1g8d+Sey8J+W2HVY73xwCk_anm3UgHcr0w@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:5d24]
X-ClientProxiedBy: CO2PR18CA0047.namprd18.prod.outlook.com
 (2603:10b6:104:2::15) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:5d24) by CO2PR18CA0047.namprd18.prod.outlook.com (2603:10b6:104:2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Thu, 1 Apr 2021 21:34:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 843b37a6-9c4c-4ce3-a26a-08d8f555e029
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4153:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB415395432D8283F08A3CA125BE7B9@SJ0PR15MB4153.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: faxaG8sHxFaycLEtk6U7joAI3mguJgf2Yt412eKBUYFwO0oiA+c3z4qbznI/W7Ljc7sJluIbrSfSwOpn1EZm4FYJclme/+fzHsNVG/LzI+WST0bIEBjGcbRuDKxBb46SoObkqg/laXuiFxSdyYEeVuOmyq4iwCfxiu1tLSiKw0Q3lnO77Re0HBiUAXIbEcxkcP4Ku+vUbnszGtIfKu0s9fo4OIt6I9t3QWUgsFiTC0lqhEkdgbRUUx/86XAWAyB5ZrGriVyUF2kmsflKCFok/DYN6zIMbsSvpxZRN7Go3ihnwJXK7Nna88vuV+RNd/7Pvu4cR4smqjd0+pP7D4PCXH5ps0gm5+J/91gye901HUzygW8iHCNp3uv+cBNH47eh4GYcyW86f5ZlKwe/4F5gkmAR0oj8ckaG/oq8F/cCDOiP0TJ87H0yXsRCGvB10zR6KwqbJXFHlD1gtGc0BqRpN9eOU8BTK3RL3OLuodsDvpEV8Pp2eCLhIT4PgOxmGbLuAFmMr0y3xbM/JKL2kSsoW5+jNZdXPMPzyBEpvp2lC9QpGtHi6MmlgZFHfFln00j6ZWpPkNGRyiur199SMw71rKY7JOzcz6fN9gfUP8y7+WZEodRYSXVPjaCGC9p1mKWRWyD8rwAbQffyAUbJvtZUjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(346002)(39860400002)(376002)(8936002)(478600001)(66556008)(4326008)(5660300002)(6916009)(55016002)(66476007)(83380400001)(7416002)(9686003)(6666004)(52116002)(6506007)(53546011)(86362001)(66946007)(316002)(8676002)(38100700001)(16526019)(186003)(2906002)(7696005)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1JKHoSvNEfSyK9pmodBkSt6xGUs4d8FMnWfFfT2tch9B+Ik0FelpFbxYwb41?=
 =?us-ascii?Q?j1ZBJq9gvQeUxt8vafFUl+GyP9/qr46SpduvneM8adjkeTC3UKBO3u9XfGWT?=
 =?us-ascii?Q?WD/gErBDfacazze6BoTqckLE4nAqsS6y8AqEYvZEYzVJn8lXdw6QAtzpY4Tl?=
 =?us-ascii?Q?0Q82YG6I24WEm59QUseP7HfcurCc1ZwjC3xUiwbP0fdIK74TMwQ7NRcq7MGh?=
 =?us-ascii?Q?bn3XaeVRcyv1jAQIF08RPvR6dfIW1eTQm1t2f8VZHv9ySG2w9jLpIkX54QLr?=
 =?us-ascii?Q?rRYZzPpY+j3vNZfYHOOXRU2HWGif2FnVs4o237x65HVbqwkFyssc51Os/Fvs?=
 =?us-ascii?Q?bEO5GsbRPelCWb+BNuF8ALIINMLN0Vm2YgZOgfk/fyDsFEgi+P5WK5mO2aiz?=
 =?us-ascii?Q?GgDZxyeLfM0YaC+v/Delp0SAzCWsGKcfAUxrojU4gw2/ugALwEFLFAT+wBLW?=
 =?us-ascii?Q?h7P2l5qfhByoMigIoReue1z1w6EzUDlnRqZXeXEog7w97ed9D9/+ZFGPPIRP?=
 =?us-ascii?Q?Zy3Vf+6mNY1AvXbGpK6lqKz0WO4hLTGKKWra3ZPf4mOp37bK/qyknm86s3/s?=
 =?us-ascii?Q?c+z6IKabShg+kLLNtcU1pbeQDOVSnvf/68aWIa5BJzBJzJQlKUeYKvA4ptsF?=
 =?us-ascii?Q?Cp1qW3osN/P43yOJ9E3ohvcZpzMJYQF1hvknOFc9ZljahGMyq9/TZRwiiD+J?=
 =?us-ascii?Q?NOMh5vL9ExBtPAiUk98uJRkT2hWWIAWerguaKJVpesRP54yE3VrMHFjPcv7y?=
 =?us-ascii?Q?bG91rtRB2JwlZ6mmdVPP2mZTSylGXCtn5fTUbLjxXsn9jbj1nSgG6mB0e4B4?=
 =?us-ascii?Q?tROtNSjVqQQqDVgsvJUFe7ZmEkKqsD8npCu7310nUkWOVuu2Yfb7ys5QERmS?=
 =?us-ascii?Q?U9wkPMrhdU7Tdv/CNPJXjSLJMa5uUHyZIaWAg5g5TwAQrE3exkEiK6YC38F1?=
 =?us-ascii?Q?BAjTEqn+BPnCaj07Ojm35fVqU6ysDgs8MRO0IdO36Py7JjwQiOHzjuKB65Wm?=
 =?us-ascii?Q?kFJIxS4f5W8J+23YxTnUKJc47X10vvyNV3AUGK5gYVccDa4mo5C5TNAee/7M?=
 =?us-ascii?Q?j0pw1I7Bx2HuRWLcYdZrZ5bca/5gIZOoqJ/bHPfdtfXnrDF9IhoMjhVvz1Rn?=
 =?us-ascii?Q?kRYmMm5g9wuiLhEgffT/rLsLHXbTOHNjft9GNShiJ6NEKaeZkDkHgUTwidYp?=
 =?us-ascii?Q?EXstobWbLY2jS5GhuJ6TvfTqqJS397Z8TwU/uiRN+Edw8iYTTBNoUDw9nRuL?=
 =?us-ascii?Q?qprf90p2Df3n3iun2nwz2iA7xm1qPLKKjiQzA05/Fc0/RO0hmNEJ1reeTJhq?=
 =?us-ascii?Q?aZ5TjWKMNB8ItnG3R/OOb6wtOqcFN5YUo5s+3kZ45Bg9tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 843b37a6-9c4c-4ce3-a26a-08d8f555e029
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 21:34:05.8004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beSPM5jhlMSD8Dz6uMsPWeSa6LeofNpQ4N45t7lnyuuxDDq7p3n3m6FHGsSvnysL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4153
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: OFXP_NefxbVM_syYBTctohWFnFqIdkGx
X-Proofpoint-GUID: OFXP_NefxbVM_syYBTctohWFnFqIdkGx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_13:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103310000 definitions=main-2104010138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 12:07:42AM +0800, Muchun Song wrote:
> On Wed, Mar 31, 2021 at 11:17 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Tue, Mar 30, 2021 at 03:05:42PM -0700, Roman Gushchin wrote:
> > > On Tue, Mar 30, 2021 at 05:30:10PM -0400, Johannes Weiner wrote:
> > > > On Tue, Mar 30, 2021 at 11:58:31AM -0700, Roman Gushchin wrote:
> > > > > On Tue, Mar 30, 2021 at 11:34:11AM -0700, Shakeel Butt wrote:
> > > > > > On Tue, Mar 30, 2021 at 3:20 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > > > > >
> > > > > > > Since the following patchsets applied. All the kernel memory are charged
> > > > > > > with the new APIs of obj_cgroup.
> > > > > > >
> > > > > > >         [v17,00/19] The new cgroup slab memory controller
> > > > > > >         [v5,0/7] Use obj_cgroup APIs to charge kmem pages
> > > > > > >
> > > > > > > But user memory allocations (LRU pages) pinning memcgs for a long time -
> > > > > > > it exists at a larger scale and is causing recurring problems in the real
> > > > > > > world: page cache doesn't get reclaimed for a long time, or is used by the
> > > > > > > second, third, fourth, ... instance of the same job that was restarted into
> > > > > > > a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> > > > > > > and make page reclaim very inefficient.
> > > > > > >
> > > > > > > We can convert LRU pages and most other raw memcg pins to the objcg direction
> > > > > > > to fix this problem, and then the LRU pages will not pin the memcgs.
> > > > > > >
> > > > > > > This patchset aims to make the LRU pages to drop the reference to memory
> > > > > > > cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> > > > > > > of the dying cgroups will not increase if we run the following test script.
> > > > > > >
> > > > > > > ```bash
> > > > > > > #!/bin/bash
> > > > > > >
> > > > > > > cat /proc/cgroups | grep memory
> > > > > > >
> > > > > > > cd /sys/fs/cgroup/memory
> > > > > > >
> > > > > > > for i in range{1..500}
> > > > > > > do
> > > > > > >         mkdir test
> > > > > > >         echo $$ > test/cgroup.procs
> > > > > > >         sleep 60 &
> > > > > > >         echo $$ > cgroup.procs
> > > > > > >         echo `cat test/cgroup.procs` > cgroup.procs
> > > > > > >         rmdir test
> > > > > > > done
> > > > > > >
> > > > > > > cat /proc/cgroups | grep memory
> > > > > > > ```
> > > > > > >
> > > > > > > Patch 1 aims to fix page charging in page replacement.
> > > > > > > Patch 2-5 are code cleanup and simplification.
> > > > > > > Patch 6-15 convert LRU pages pin to the objcg direction.
> > > > > >
> > > > > > The main concern I have with *just* reparenting LRU pages is that for
> > > > > > the long running systems, the root memcg will become a dumping ground.
> > > > > > In addition a job running multiple times on a machine will see
> > > > > > inconsistent memory usage if it re-accesses the file pages which were
> > > > > > reparented to the root memcg.
> > > > >
> > > > > I agree, but also the reparenting is not the perfect thing in a combination
> > > > > with any memory protections (e.g. memory.low).
> > > > >
> > > > > Imagine the following configuration:
> > > > > workload.slice
> > > > > - workload_gen_1.service   memory.min = 30G
> > > > > - workload_gen_2.service   memory.min = 30G
> > > > > - workload_gen_3.service   memory.min = 30G
> > > > >   ...
> > > > >
> > > > > Parent cgroup and several generations of the child cgroup, protected by a memory.low.
> > > > > Once the memory is getting reparented, it's not protected anymore.
> > > >
> > > > That doesn't sound right.
> > > >
> > > > A deleted cgroup today exerts no control over its abandoned
> > > > pages. css_reset() will blow out any control settings.
> > >
> > > I know. Currently it works in the following way: once cgroup gen_1 is deleted,
> > > it's memory is not protected anymore, so eventually it's getting evicted and
> > > re-faulted as gen_2 (or gen_N) memory. Muchun's patchset doesn't change this,
> > > of course. But long-term we likely wanna re-charge such pages to new cgroups
> > > and avoid unnecessary evictions and re-faults. Switching to obj_cgroups doesn't
> > > help and likely will complicate this change. So I'm a bit skeptical here.
> >
> > We should be careful with the long-term plans.
> >
> > The zombie issue is a pretty urgent concern that has caused several
> > production emergencies now. It needs a fix sooner rather than later.
> 
> Thank you very much for clarifying the problem for me. I do agree
> with you. This issue should be fixed ASAP. Using objcg is a good
> choice. Dying objcg should not be a problem. Because the size of
> objcg is so small compared to memcg.

It would be nice to see some data from real-life workloads showing
an improvement in the memory usage/reclaim efficiency and also not showing
any performance degradation.

I agree that it would be nice to fix this issue, but let's not exaggerate
it's urgency: it was here for years and nothing really changed. I'm not
proposing to postpone it for years, but there were valid questions raised
how it fits into the bigger picture (e.g. other controllers).

Indeed we added an accounting of different objects, but it's not directly
connected to LRU pages.

Thanks!
