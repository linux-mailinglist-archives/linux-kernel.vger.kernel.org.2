Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2078B34F152
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhC3S7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:59:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7614 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232953AbhC3S6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:58:46 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UIuMAE030721;
        Tue, 30 Mar 2021 11:58:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=CUl66fEnsNaIgbiHw9EmiG5oK1+QyoBim3JhwwZa2Tg=;
 b=h3Yp4Daisz1aeKtjvmRP8UCCumVl7xcaDQiHvYYC4h5MOWoIRpf/9mrgwtl69j4MCYSF
 oKAm1vBMSmmtZwvBLFwI7MZt4kDDurSrM4Lt22nlfoq57i1oSf6AfALa8om67QWj6xns
 iHlBB6pGaeUpOohY940yOUMvnmXWEQ7Y/tE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37m6h2shjj-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Mar 2021 11:58:37 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 30 Mar 2021 11:58:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8jLDnntASPpzd4MmvBCe2DYSodlvKI/5oYhAUGIZmLzantxUS9jHQJm0djfbqcNX8LnMQoHX3Nk+NydXQs8C+kUJ2ewxsWN3E3csOLYIzEPK7M/ME+URjSYqSeb9+2JAbM7InlBwR5fNjVQChVr2/PiA86nFrRjkgHBAgTRtUeQu8d9be93J04yAyAkOpbVvjU21wKD36dnyRqoTwjDTs349SKb1CkwpKJ1vwLB5ltcTk/H+ZgOXRmqqTFBfz1iO1eWlTt/lK5UFQ7fCfvNCGYThLvVrmRlmVd7YzYsMn6DP7+CGWI4LBIySQZeCz0pXHJ2wm2A1/civRqEiulD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUl66fEnsNaIgbiHw9EmiG5oK1+QyoBim3JhwwZa2Tg=;
 b=LF4z30C1j5ZAv2Am/XdYNsqANWmhhRUE+NPFLhG3rOhK/B+mPlrZa+Ug+0/9iGIuZbZf8yfOhJvV3tnmnwW7eYm1D/DxUzlSQbXUPnEIpDB30mhz9Z0o3vRp65nkqI2wYMyRqqWO+7sZVAPsaG/wxz5bMLGUwYrW4O3Y/a5qchT601TKnAwzL7l+cozSoLfCCmfejWsYPypBlapsMerzRUegjxYoQy4GUuckRy6duyOCTMJWNAtepS86wLhu7g4PLBU2VcLmFhLyoNXXGuF8XjvJM76B4sBg4+rQFFypQfI4aR08a14s5uKelhWCEySCNiAhYple/Jp+niLVAOcZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4153.namprd15.prod.outlook.com (2603:10b6:a03:2ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 18:58:35 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 18:58:35 +0000
Date:   Tue, 30 Mar 2021 11:58:31 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Subject: Re: [RFC PATCH 00/15] Use obj_cgroup APIs to charge the LRU pages
Message-ID: <YGN0141iu5HTGiNJ@carbon.dhcp.thefacebook.com>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
 <CALvZod4xHNmTQMd+zg71s7uyXUHEfwnQ-zqRXSWphwi9RogeNg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod4xHNmTQMd+zg71s7uyXUHEfwnQ-zqRXSWphwi9RogeNg@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:ae92]
X-ClientProxiedBy: MWHPR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:300:6c::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ae92) by MWHPR04CA0071.namprd04.prod.outlook.com (2603:10b6:300:6c::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Tue, 30 Mar 2021 18:58:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa8bb752-695a-4d95-d416-08d8f3add1d6
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4153:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4153E88DB8AF314F6BC4D96ABE7D9@SJ0PR15MB4153.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HgYJ1M+jwE0giT6NQKNaaq8+0up4e1cetdFIYrT7g6AVIYANpB0Dqo3/y6IaOYpqDqaXZ1uphlciVIxHOT2D9H9dI0mICwanc944lQ+A0PDQAoVAcUQnCxPyK9KMvtmQq+lXhJgcABUH/KQSCFfM7jlOb6AK9nfy6ZL7MP5N6psvnhNRs50zkrx+TKcW4821LRdd0kQkX3c2pTYyGrwCbFG/P4wKko0DyOchnK6asnjNjLYKkiYJth9u7lcDb1PPMc+sC/ZMDRfVZ0wcI9r1X5nxa35ho080uWc6mT6QSna31rUx9VqzHhGdOIWGSpQce9MfpN1GuBufmREL3HiWu/lDW55Gjbm+7UXrydUdSRZMJ0HTuLj7+CF4GjEe2ej3c181imu/FgrcY1j63HrgkuXqK1xUOtRRQwTXgF08xMTFyorghDI+eyGsp6MVbWz3vSTQi/oqXO0detGnADT8dEdho+OHetWBEBf34WGV/T/RShW5CsUKSvMMaWZVldhiaiMPChlW6fNvtTtjWNkrjeimdzhgAoS7JqYVd/skwexCkUnicVL8rvNpsQpPfSbjBRhuyFDkBQ3jPIqDG/UnGsPQr2NdRuRxtNRuFWTa5AUg+m5LCJoSgHLk1JHEOlAeua7xDYEXmaBmSIAo/Sgiuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(366004)(39860400002)(376002)(8936002)(186003)(478600001)(8676002)(83380400001)(316002)(6666004)(2906002)(5660300002)(7416002)(38100700001)(52116002)(66476007)(66556008)(54906003)(4326008)(9686003)(6916009)(6506007)(53546011)(66946007)(86362001)(7696005)(16526019)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ut2sNj0c8lbHXM7BWLazW5tE57MG1nIOI3jtbJnKbRiOeH0jq4hXJaaa7gGx?=
 =?us-ascii?Q?GyQxGlBWzapxohjWrcqmvUjrSIDqlTw/pkMBKrv+cwk9ttWc5mWXGS+Rk4of?=
 =?us-ascii?Q?2biEP3Eq5SknRfL2ZxooneYyZvLrfTzawjSSpN89mth+zSJBlr0EmSQNrMA2?=
 =?us-ascii?Q?XGvPag04k+ognZoPxtFHRkKUu69iJSOMKA7cEkBAougmaL8tRjXi8OV8nNWs?=
 =?us-ascii?Q?tf1kvTTK1rMNAqv7XUA5D+K9Xd0CGWb1DRId45HUtCAnudnVndd3UN/3lmm8?=
 =?us-ascii?Q?c7QCRvBqEtZ18RcnD+NavoMlZxp0IUwe0clBdRAvmNJnmRcd96dStPwdDOh2?=
 =?us-ascii?Q?EefWTGAufrezg5RyH6vS7+prfzlclWEpuxOIKs/aHWv1mqrJlYtiIy3grKbo?=
 =?us-ascii?Q?4lWR2e9mNpevz1Yf0Y79Tarylc+9iMwGi73KH+ESHjAy76wveiWujw/QD8Sx?=
 =?us-ascii?Q?iphzVhBV8y/Au/r/IvdleSVncIws/juTDYc2gW/Mo7JeFb3lRoZG9OjtHyUo?=
 =?us-ascii?Q?ebPjWLe+VdpfQct+ASJOKyj4Xx21I1WBG7IbbGRbyJz6Drc6L2LJZ7zPx1l+?=
 =?us-ascii?Q?Wk14L0sB9chCxHbNN3c5xxdRF2GOdlBsf0rC5Zg6Kf7Ag56N+8gXLK6wqRWQ?=
 =?us-ascii?Q?AY2DprJhJH2zNPyE8F+cVh4D9006ClBTK+zJXyBT+a68A5XQAfhUxY7Zo0fE?=
 =?us-ascii?Q?nOm7ppsWUGWd0+zOwdxDx9PkuzbwrMabyibg7+GjZeJ1ZYjkawdrETfSmBny?=
 =?us-ascii?Q?yBUTvZ6irQNdgmWhJTr4llqY7CVKPF59S3oB/UMZgCq9dWyDmmZL6siM1qdh?=
 =?us-ascii?Q?taoDYK/IuGqmeZVzkR+XNtl367ZIzD2EoFng8CTzfQSEBtJNV8ZKfYL+RofM?=
 =?us-ascii?Q?hAm4vNzH6ouG28MTzLPwCIltXd67d/vataokUwFw1rxbf2ciehPqoph3+zOC?=
 =?us-ascii?Q?85O5POJk3VYrf9W1EFEyiHnOAFbV5t6eSj+0P8pSfpk1aMEFhGGubpMBHAoo?=
 =?us-ascii?Q?OUxyrK9PAXtk5rjt/sIlvOmIwqbgP9/IkeQV8JRwRukytiXkeeN/JSitFJdl?=
 =?us-ascii?Q?88JNilZ+FXw6syq0nRhHVFt/tBmSY9lYoXAHZ9oe2jJebb8CMF9/vkEStfBJ?=
 =?us-ascii?Q?vxWxRdB3KgFvcm/BnSetJXq6Y2UmvFbCxpb22exHBGXnc3zMnBEU4S6esw/N?=
 =?us-ascii?Q?WFNPJ7uUGC67LlIDWpiIuKT8FKLFm/dxD4iGUdwDlngcLf/Lc6HyQvP0nvML?=
 =?us-ascii?Q?sFoa3ysSSEGO61WLlOlFucDju9+pvr7QnN6H78IOpopCz4AJzqL/eGTrJTxg?=
 =?us-ascii?Q?xw0NIwsjiz2PbAHhCJln5yvz/V9Z0WnF689EohzJQaZa6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8bb752-695a-4d95-d416-08d8f3add1d6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 18:58:34.9262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lw9N5kkT30JzMjSPtv+mAHiIMHwHkU7yhJVT8eHZhq8CtpS76sa/uaISegxe1May
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4153
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: PFJpZa5C_k-FZj1ly0Ve6Ot_-yJVovoX
X-Proofpoint-ORIG-GUID: PFJpZa5C_k-FZj1ly0Ve6Ot_-yJVovoX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_09:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 11:34:11AM -0700, Shakeel Butt wrote:
> On Tue, Mar 30, 2021 at 3:20 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > Since the following patchsets applied. All the kernel memory are charged
> > with the new APIs of obj_cgroup.
> >
> >         [v17,00/19] The new cgroup slab memory controller
> >         [v5,0/7] Use obj_cgroup APIs to charge kmem pages
> >
> > But user memory allocations (LRU pages) pinning memcgs for a long time -
> > it exists at a larger scale and is causing recurring problems in the real
> > world: page cache doesn't get reclaimed for a long time, or is used by the
> > second, third, fourth, ... instance of the same job that was restarted into
> > a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> > and make page reclaim very inefficient.
> >
> > We can convert LRU pages and most other raw memcg pins to the objcg direction
> > to fix this problem, and then the LRU pages will not pin the memcgs.
> >
> > This patchset aims to make the LRU pages to drop the reference to memory
> > cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> > of the dying cgroups will not increase if we run the following test script.
> >
> > ```bash
> > #!/bin/bash
> >
> > cat /proc/cgroups | grep memory
> >
> > cd /sys/fs/cgroup/memory
> >
> > for i in range{1..500}
> > do
> >         mkdir test
> >         echo $$ > test/cgroup.procs
> >         sleep 60 &
> >         echo $$ > cgroup.procs
> >         echo `cat test/cgroup.procs` > cgroup.procs
> >         rmdir test
> > done
> >
> > cat /proc/cgroups | grep memory
> > ```
> >
> > Patch 1 aims to fix page charging in page replacement.
> > Patch 2-5 are code cleanup and simplification.
> > Patch 6-15 convert LRU pages pin to the objcg direction.
> 
> The main concern I have with *just* reparenting LRU pages is that for
> the long running systems, the root memcg will become a dumping ground.
> In addition a job running multiple times on a machine will see
> inconsistent memory usage if it re-accesses the file pages which were
> reparented to the root memcg.

I agree, but also the reparenting is not the perfect thing in a combination
with any memory protections (e.g. memory.low).

Imagine the following configuration:
workload.slice
- workload_gen_1.service   memory.min = 30G
- workload_gen_2.service   memory.min = 30G
- workload_gen_3.service   memory.min = 30G
  ...

Parent cgroup and several generations of the child cgroup, protected by a memory.low.
Once the memory is getting reparented, it's not protected anymore.

I guess we need something smarter: e.g. reassign a page to a different
cgroup if the page is activated/rotated and is currently on a dying lru.

Also, I'm somewhat concerned about the interaction of the reparenting
with the writeback and dirty throttling. How does it work together?

Thanks!
