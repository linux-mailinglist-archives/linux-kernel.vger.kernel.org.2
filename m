Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CB035CFA7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 19:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244424AbhDLRqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 13:46:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23110 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238523AbhDLRqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 13:46:12 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13CHhO5g008216;
        Mon, 12 Apr 2021 10:45:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zTKCaYiHbz19q0BpCvZaoPngiQwnldDOiKXip2zaue4=;
 b=ku40sM+Uuv/AbEtZbeUJdsoPyx3DSbLDyny3Do27fQjs2tMCma4ajyfdz38gkHfRK+kn
 f408EkhaG/tDfj5C9E8cMvi3R5GXOYY6uCmsvXkFTuu6A6XmnVJMbYl70e6pMhvM9q5c
 r5FNdcI0BSUtjNDOCXUWE3QbctxjQg0Y5FM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 37vkb2th26-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 10:45:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 10:45:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjXt5zwjv8YuH9l0IkXzQDZuITWGvBXWt5MUQ8BKqMRURWx+YfZxZCbquzvTT2cNHP6cMcRoBswLaxnGLdx5crkd0PPTbnQL+u012WVBlntMQq6xD+m2hiGlwgfZ9Zsudi6aXlMWiV9Dv5ozEAikBsC0mOwAHKn3AaB9GTF+4YlMOsxPWfnTeyw8TUZvNoc3X0+7oxVXnwEMyR6XOFCzCm+rhneR4biYdLLVZwOkAwCvmzUtm56GCiuSk3BJqiIjTIhSW/YZgEk4K6tWsfh8agMoc52Q7uq+OSEdSoQGMvL2qDPcZp/oyQBwjuN1x7KBM214eE2ELYMvkUGhKaRwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTKCaYiHbz19q0BpCvZaoPngiQwnldDOiKXip2zaue4=;
 b=bGoVtC/5rpHPl/jjgLdS7rY9eikYcSEeUSd/L/u0Tu+6A/GDFdMWBzGa4SeFqR96O6pLdpFovPP4OrR/PjJ3VNFw8JOSZrQfFys5SEhtQcbRgYqD2pzSV8Xj7WYnIYqvgmvpdhG0m9j6w8M3QNFCwWuMDMvWhmKkDSt/Q6Z1kAUVideu7U+uQ2ZeL8ccTvSvfRRptnqpP6mHg1mgexaGtnwwBqbkI9uDPFeSAyDrw+XzvXDwlrn738Y6QdhTyJea2WF54KDEO9EPIj9fRCfRy4CiYaeuHcQZdT4IbGSO6ajmeis7thczLla50RCkqWYP6baWDFHb/45O7eoNifBdRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3222.namprd15.prod.outlook.com (2603:10b6:a03:10d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Mon, 12 Apr
 2021 17:45:41 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 17:45:41 +0000
Date:   Mon, 12 Apr 2021 10:45:36 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Muchun Song <songmuchun@bytedance.com>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>, <bsingharora@gmail.com>,
        <shy828301@gmail.com>, <alex.shi@linux.alibaba.com>
Subject: Re: [RFC PATCH v2 00/18] Use obj_cgroup APIs to charge the LRU pages
Message-ID: <YHSHQM/CMKb8t07A@carbon.dhcp.thefacebook.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
 <YHD/itVJlgzE2uXm@carbon.dhcp.thefacebook.com>
 <YHSAETyyXMkygPhn@cmpxchg.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YHSAETyyXMkygPhn@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:ea4e]
X-ClientProxiedBy: MWHPR10CA0060.namprd10.prod.outlook.com
 (2603:10b6:300:2c::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ea4e) by MWHPR10CA0060.namprd10.prod.outlook.com (2603:10b6:300:2c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 17:45:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae2d53ba-acb3-4c30-98c1-08d8fddaca55
X-MS-TrafficTypeDiagnostic: BYAPR15MB3222:
X-Microsoft-Antispam-PRVS: <BYAPR15MB322269064D7A3A5FF5928295BE709@BYAPR15MB3222.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qq2lBKnmXYI1/xz4lpeWEzZ6g+CB7jMrLxR7uMMIRZc5GhIJUZrBabD8a+N+bi40w2F7Na1msdNxtb5wVL97te9nLUSkOjNXW1QLrr9Rq1ke2rwB/TJabHognLlHB2MzZrnG640trbTLpkWGaIXNTBml0WOEe8rFqe2IizOEAEx9XAAsAaBV9S8J9HY8fk0+2azz3M+tyg2NGuZpum/QGU2nGuCX2HsowQolKYHT2rbg4LESgdP1OnRwLMYY4W2KTzNdZ1IrWqlBHotyA8KnsvKPJBykFP++5c2YY1VTQ83KDlDcoTNVYxrQl7f8bG3o2x0vnW/B05oZHqqOqi8m6TDuAoC6r968tWinRTbtRzcq2Z6GaGv1w0jKAmX4tnwOfhLNGvykkzEOSLAg4Ub4NO7QJNilsuWuA6VmCuSBjR8hrrQa1ED+An2K4sinPMSTxjhOrYQEPH3mQiqk0Sm98gMMK5UsSHUyLpUBWiM8HqyZIeO0XZ+16dF9cXnbT+hDS8SNhIpeXKnN6Z9jIsyapqKvtQy75plTVSknzcmlVfpHvFQZb6OR5ZqeKZIGGVBoxxdR8ZpKYtiq23iwDUt5op055vfhRI+1AODaDVCZoVawxKPmHwtLg21mwhXd8FeHfdWymb3tulJPx8OQo/S2QuCQCGvllYVIspOlkCQDGhw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(366004)(396003)(376002)(966005)(8936002)(6916009)(5660300002)(38100700002)(83380400001)(478600001)(8676002)(6506007)(4326008)(7416002)(16526019)(186003)(52116002)(2906002)(316002)(7696005)(66946007)(6666004)(9686003)(86362001)(55016002)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nWlTtwzaCmRyORhy8H8aFRg8aso2qNhf7LiEsff/gzcmfH3tXH79UhU9CsbW?=
 =?us-ascii?Q?ToqMt7SHdf/1MKN2TAtC9ZNJnobeJfQjQfxhfsO63P8lw48lZo0xcXSDcmUx?=
 =?us-ascii?Q?qagV/dLf33XKgTfVP71ABNrIh7frxe1z8lo3mBCbpPNNXljEOOcQeOhzfQds?=
 =?us-ascii?Q?YYk9J/P9luplmN1O+0OwdX08MfQ2ueBBAP7IkSvnGe0fa4cIDZ+54XQRlrsf?=
 =?us-ascii?Q?VjWxI3BATA4uNMdzB2fp1BP6lYYmBaUTGOObc7REeFxWbY2rj2zwKwmkAIYW?=
 =?us-ascii?Q?WoWIro8HSJsnmNvazgR6+92sE4vuJpl6gPMWMpBX8LRg2wDQqlMNzYsdv9od?=
 =?us-ascii?Q?SRSL7GLApTbAzUDmJnwLAXWg+MGGBrr/8PfZiu84ouG7hVA0V/ehbELJt3mk?=
 =?us-ascii?Q?15+2iIdrhB3bKKC4BxCWRHQuJM1dLNdI5oLkh/sEn1r5cE6KJYpZw2KECZJW?=
 =?us-ascii?Q?VSH2RdGRkyjoN5aVSivXhQOVkeYy7AXbcRGF0FIvgp2LrkWefIpgqHOSeWNp?=
 =?us-ascii?Q?MnmBwa+X2X89OyGj0NTHTKLj0xE+hx8ceBfTPUAmy8umfNC3CL5lXZEI2vh4?=
 =?us-ascii?Q?9ZPWHMMwgt+6GNrcTmEA7vRsN2MY+25NG3qlDneTxbx2slNlcnKAkKTwTgHu?=
 =?us-ascii?Q?B/DOvKFOUjIS2/L+xOb29yGO3aahUwWHxaLOSkMC40c4aQfjJA3Qd0GLRUBb?=
 =?us-ascii?Q?CNQQqWUgVuKbnerZLJhBFaMgBstjynmpN8vBVplh6M+seCe4k2+gOjxIg0Wc?=
 =?us-ascii?Q?Cl7GB4D90C0KYv0wW6AZ1V3pMob3qi3L/BTJFiq2TIL00cPJlvPlmZpqvzze?=
 =?us-ascii?Q?dw4RF1MteR0qFCddLFe3LwOXUcmB7VDXyBeA97hPrYcSYa+AajCH37JH26iu?=
 =?us-ascii?Q?ixN4CyEDNXWt/NFAfqVT5MLlJHD9Z68871ZJnJxhO9eOGagxaSSHhpZlo3nR?=
 =?us-ascii?Q?fPKEKfK2VR0Uv6v64y52YUlcaQ//oo6iaU2ApCehovPJTDPeF+49MXn6dO+Y?=
 =?us-ascii?Q?gJ1ez52waIdvHFnX2mFj03Hdsq6xk4Qg4Cb1/i18fWz+3H+DB3po/pA9K/VL?=
 =?us-ascii?Q?8uh1EBuRXGIXSkSTDRK7sZkpWTdPZhFIMMbbMcuy8mgRtNnRrF8MEaMb7VaI?=
 =?us-ascii?Q?BOFdcRifWWl0312fboo9c9P4hNSHfJh7+3UY6ebwHnCDbLec01+mJth/68lA?=
 =?us-ascii?Q?nsfjf/Dq5X9+cGF1sWg/okf4oVcFbkwkB0nZJVkIR4tytZe8BId7UoY1fYJp?=
 =?us-ascii?Q?ct5FyeAdj1RvzE0bhDfjne2uOlBLg1+LcpBQ/m7yEuL5y461YhYhfdYoQyyc?=
 =?us-ascii?Q?0Fa8CNrnwub37Qam4zDEFiRCtDLgdi1ayaEyaPtSv43CPQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2d53ba-acb3-4c30-98c1-08d8fddaca55
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 17:45:41.4399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNhjNlKXPVoPPfMj5SOGrEnDO2Rw1WL74WriPV5p3wlwFPog2AHlqxrwrYb34sdt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3222
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 8EwuVE05ZUqQxyMU4vrmOfJin3PwqjU0
X-Proofpoint-GUID: 8EwuVE05ZUqQxyMU4vrmOfJin3PwqjU0
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 01:14:57PM -0400, Johannes Weiner wrote:
> On Fri, Apr 09, 2021 at 06:29:46PM -0700, Roman Gushchin wrote:
> > On Fri, Apr 09, 2021 at 08:29:41PM +0800, Muchun Song wrote:
> > > Since the following patchsets applied. All the kernel memory are charged
> > > with the new APIs of obj_cgroup.
> > > 
> > > 	[v17,00/19] The new cgroup slab memory controller
> > > 	[v5,0/7] Use obj_cgroup APIs to charge kmem pages
> > > 
> > > But user memory allocations (LRU pages) pinning memcgs for a long time -
> > > it exists at a larger scale and is causing recurring problems in the real
> > > world: page cache doesn't get reclaimed for a long time, or is used by the
> > > second, third, fourth, ... instance of the same job that was restarted into
> > > a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> > > and make page reclaim very inefficient.
> > > 
> > > We can convert LRU pages and most other raw memcg pins to the objcg direction
> > > to fix this problem, and then the LRU pages will not pin the memcgs.
> > > 
> > > This patchset aims to make the LRU pages to drop the reference to memory
> > > cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> > > of the dying cgroups will not increase if we run the following test script.
> > > 
> > > ```bash
> > > #!/bin/bash
> > > 
> > > cat /proc/cgroups | grep memory
> > > 
> > > cd /sys/fs/cgroup/memory
> > > 
> > > for i in range{1..500}
> > > do
> > > 	mkdir test
> > > 	echo $$ > test/cgroup.procs
> > > 	sleep 60 &
> > > 	echo $$ > cgroup.procs
> > > 	echo `cat test/cgroup.procs` > cgroup.procs
> > > 	rmdir test
> > > done
> > > 
> > > cat /proc/cgroups | grep memory
> > > ```
> > > 
> > > Patch 1 aims to fix page charging in page replacement.
> > > Patch 2-5 are code cleanup and simplification.
> > > Patch 6-18 convert LRU pages pin to the objcg direction.
> > > 
> > > Any comments are welcome. Thanks.
> > 
> > Indeed the problem exists for a long time and it would be nice to fix it.
> > However I'm against merging the patchset in the current form (there are some
> > nice fixes/clean-ups, which can/must be applied independently). Let me explain
> > my concerns:
> > 
> > Back to the new slab controller discussion obj_cgroup was suggested by Johannes
> > as a union of two concepts:
> > 1) reparenting (basically an auto-pointer to a memcg in c++ terms)
> > 2) byte-sized accounting
> > 
> > I was initially against this union because I anticipated that the reparenting
> > part will be useful separately. And the time told it was true.
> 
> "The idea of moving stocks and leftovers to the memcg_ptr/obj_cgroup
> level is really good."
> 
> https://lore.kernel.org/lkml/20191025200020.GA8325@castle.DHCP.thefacebook.com/
> 
> If you recall, the main concern was how the byte charging interface
> was added to the existing page charging interface, instead of being
> layered on top of it. I suggested to do that and, since there was no
> other user for the indirection pointer, just include it in the API.
> 
> It made sense at the time, and you seemed to agree. But I also agree
> it makes sense to factor it out now that more users are materializing.

Agreed.

> 
> > I still think obj_cgroup API must be significantly reworked before being
> > applied outside of the kmem area: reparenting part must be separated
> > and moved to the cgroup core level to be used not only in the memcg
> > context but also for other controllers, which are facing similar problems.
> > Spilling obj_cgroup API in the current form over all memcg code will
> > make it more complicated and will delay it, given the amount of changes
> > and the number of potential code conflicts.
> > 
> > I'm working on the generalization of obj_cgroup API (as described above)
> > and expect to have some patches next week.
> 
> Yeah, splitting the byte charging API from the reference API and
> making the latter cgroup-generic makes sense. I'm looking forward to
> your patches.
> 
> And yes, the conflicts between that work and Muchun's patches would be
> quite large. However, most of them would come down to renames, since
> the access rules and refcounting sites will remain the same, so it
> shouldn't be too bad to rebase Muchun's patches on yours. And we can
> continue reviewing his patches for correctness for now.

Sounds good to me!

Thanks
