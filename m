Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08613906A2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhEYQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:29:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35984 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232762AbhEYQ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:29:22 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 14PGNmwN008047;
        Tue, 25 May 2021 09:27:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=pphuS3QFsembLJirtWaKK/fqPRz23uczvTY1mOrAeYM=;
 b=ZbUjHTrgQuC09R4WuCDkQ9QM2eozNc7qXRcdmI9hypVnB4FtKAZ0cTk2QmLAVxyz0oIV
 5BzglrQPHC3ND0amM742Pn12kbxXllxzaYNGAIj63b80CGHNWfHliZaYJ13A2bDxR3YS
 0Rrxa+3EHqZvNN5n6kZQ65n8GNSe9MAPzmg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 38rjj261ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 May 2021 09:27:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 09:27:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giDfTsRAQDSjTyybw0kqoe2w6d8YKW+sMVuiJ1gZ0Yg9hg8OBLhEJgr3yxgvxMRNV7o2ndH0SHwSlwCDkdH3qw8Ty20TlYTXWy1mgZMOz9Sgtn6FD8YilWT+l2+ivCV+G7pHZmRXEe6aMBluKCOhCVqBqc1kPDgqEnLA0GqOAtdzOadp4JFhqVw+fZMwVEtr8PhNGd1FSlW/OFKrKcn/cExFcYsgJ5WXtnBxU0FFZao3YK1z35C7S5hQcsEuUr/U+B+47kTQ033zTDPVqps9i9HmDYjiFtis3U3jO5SljW0d3UzqatKWfi+45OwllmERWBVlbxI5cr3b2T+76Sva1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pphuS3QFsembLJirtWaKK/fqPRz23uczvTY1mOrAeYM=;
 b=msxKtQJDuvsCC2nfmx/jHQ546pSIU1gvjk0vuVBTHdkV8pNrA5VRJEApmZ9G/DhuU+1emuGAXQ+aQOWgVuW77WofW5XAgvseHOp66QFM4ZBDoxgqyiVpi2KiYMt5vsvJ5rUluhihSF+NYPBVA2r10j0EFVGsyWfYid8bsL0roNN09HJRFhOTMeraRiJDc5qB7wdp1X3Ry048Tm6ukXPljc11SBKyPsBXxOf5AGLoqnai0KUzt6vMT82QBHSdxXGGWrLaeo0ZDzUkD1d0PJMYcjaHmnduf1irJMeEhkL0HfO3tEkdoUwJSxTZS8h1QZP+y/RwSK8RDFkjAyg042Yodw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2630.namprd15.prod.outlook.com (2603:10b6:a03:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Tue, 25 May
 2021 16:27:36 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 16:27:35 +0000
Date:   Tue, 25 May 2021 09:27:30 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>, <bsingharora@gmail.com>,
        <shy828301@gmail.com>, <alex.shi@linux.alibaba.com>
Subject: Re: [RFC PATCH v3 01/12] mm: memcontrol: move the objcg
 infrastructure out of CONFIG_MEMCG_KMEM
Message-ID: <YK0lckLSLxhZMk3S@carbon.dhcp.thefacebook.com>
References: <20210421070059.69361-1-songmuchun@bytedance.com>
 <20210421070059.69361-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210421070059.69361-2-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:4ac]
X-ClientProxiedBy: MWHPR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:300:ee::12) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:4ac) by MWHPR04CA0026.namprd04.prod.outlook.com (2603:10b6:300:ee::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 25 May 2021 16:27:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d2ad5a7-9d82-4910-aff8-08d91f9a0145
X-MS-TrafficTypeDiagnostic: BYAPR15MB2630:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2630CFFE3B892A293FB912CFBE259@BYAPR15MB2630.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JokNZvVcCWrELqjBe9zG2qm1GgDAzXqAnihH4TCIJL0uORs2+SFY28lRo6ObNnGym7/T3pQ4xHwM2P9SQye390t2Pc6ok9BAukasqsRXz9O3s4XCH4Mi3e1pVFVaGjnp71RdO8Z1/XvF7A01RSoBCycwzx9bEY4W455P7eR8TrMpQcU4tJiEoHidl2PLZNiZJozSchEWXELu0E1Xim5Cw3OhV7evOADkbeiq35ogSNtZigmZoS9F7mQ/XTEw9kjESbp60Ey5gYaMrHIGgdTB6wzKHneD2wmKnalOn2XrV9oUSstIC5VhuQpI/8u+NOQIaHqP79e5FDmlhL+BdW9OirxggCcXFjVFBhY6cpZNS5aFWfmxHL/TMuxQR1PKQorBzIsWkOlwjmDKD/L/90OfIAdtG94htKZurztHX2AE1v/KKjHtkwNVuF2Ua5Iko0/PNg68wl7wLuJsTJBOWoc4+thzUx4xeXq8GNk6T4Om1EfUBKShlwsEk+2X+etc1rwDjcEKmJSfVEonVv1hyE6C/gZDXohTLWcNpMWgqqv+fSvvdvouF+9yXW3eIiJaTA+qK+vdSQxmej4qVc2qzprX2u2MVCyRT/+mkG8057JFJug=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(83380400001)(4326008)(5660300002)(7416002)(16526019)(8936002)(316002)(186003)(2906002)(6506007)(66476007)(86362001)(55016002)(478600001)(52116002)(9686003)(38100700002)(6916009)(8676002)(66946007)(66556008)(7696005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MR3kaQfuTGKOMFAH0R+Wb5lVHGduV7y4OZDEyWPtbNHADV1gxQP6Ebn/6fP7?=
 =?us-ascii?Q?2XlnVUjGflxvd10JhEnPzN8d1W81JqKlamBuAVDHJ/ENV0RR+y0hGmgQwlKN?=
 =?us-ascii?Q?gqe9S3or48Cmh6u8kGyipA6EzKKK41dXZ/Nukz/gXLdyid/QFKowgEiElpJe?=
 =?us-ascii?Q?WvYvZNS9TlES55RoHacYIEPFqD7dPLdI+V+g7x/CtQgoiCNd/4nwVPQfpXVO?=
 =?us-ascii?Q?RyUUiFgKrwRejTWpOOGf9GJVhBQHtpOIfI8+98aDKK+bu2rFddzgLSIGdzd4?=
 =?us-ascii?Q?76NjdDGaLa9yiHjV4OqJMC8w7qI4VJMFYghXgiIpFy4Ig5flTP/cCxTC9aPc?=
 =?us-ascii?Q?QGlIoq3O+mySd+hghD8xf7PuD1zzTPW9+Li1sofLcY6TEfJzAsPGanRV0m1Y?=
 =?us-ascii?Q?x5spAxy7sQlVTHhb1Hj6xAvQe0SZ9i5nt/qD6xyeC9LUfSPX37y9JnZR63EL?=
 =?us-ascii?Q?rxtTgPC8MyPQHA2mmAmP9mH8xpu9gw+sBHHdN7bf9iU6Ql14mbqUuPmM6RMw?=
 =?us-ascii?Q?ZQUj+n+pR6guYJAmnGf9wB5IxZaJVC1wuOeDBeflSnkeN8s/t/mnkRbdMXyR?=
 =?us-ascii?Q?63e+k/cVgS62t1HGmNQd3lQAXG0f6VEtjcL/bMsVmRkms9hIAlI2qh+w1/LE?=
 =?us-ascii?Q?cVSISp2lGJnkO8xjQUreb83IAYg3mReFXwuLZRdplZV/oXifPoXpk21rzC26?=
 =?us-ascii?Q?IkPM9bmoMTn//TNMi+qX/E0PRq9s9kwEX5234/X3q6RaLvtzPTRJHYVY0thC?=
 =?us-ascii?Q?s1IrToDYlu1MbktkXt91y2W+RUJgq7ODC8r0LFHqkUK6aAqpCd8N3ZDPsyXt?=
 =?us-ascii?Q?0Ok1W1DeTVtJquHO50TtVTCPlOOVGnEweNhrBGKI+xKZMFlWGGaRjjn7BqLG?=
 =?us-ascii?Q?HE8405bvwwobu460Up7JRn8onEyay0D3A4EOAQ3xGwGvIO3CPydP2ThN/M7q?=
 =?us-ascii?Q?+4RifJK4JGVqwhnvQkqaII1b9nUWdNk81jtbwMJswLhN/Rwg6YbtAnyMxMJ7?=
 =?us-ascii?Q?SI8TThuElzPHliB4uCG8fbJJZyP4yvMkCwQgGcmDkKRwdrdVinSSVPT6vkk1?=
 =?us-ascii?Q?217IGUL1XXZCxNVrtoWP7dqnub023t4IsgUDHk0BbHc+PX78SP7kxqFie5tE?=
 =?us-ascii?Q?AXeagf+kVVpyZy0zT2eTD2xaSuLb/79lnUV6ObzSGZdJSd78glFXRvcNZhFI?=
 =?us-ascii?Q?9CLn4BEi+kkZp8OMr4p+dikAzl/eLQkodLyFv8QgIC5ggBoab7waCE6/xSb+?=
 =?us-ascii?Q?q7z7GsJP7z3A+n8X7jppSQVHODBtVA/mfXtpfDFhbtarj7E0NHJpMCNhup4S?=
 =?us-ascii?Q?2cAm04uME0eGDA925bVmkm3IsWrBHjKUA3WGC9H0TjCVmA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2ad5a7-9d82-4910-aff8-08d91f9a0145
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 16:27:35.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFAVbhPVp9H9RexxUwotHlXowX8ichUOZmg2hRA96InMmp97j3czLHEMdkJJ1tnu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2630
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: _b80ppzCO1VZRx_MMzaZrxdv12whnQHL
X-Proofpoint-GUID: _b80ppzCO1VZRx_MMzaZrxdv12whnQHL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_07:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:48PM +0800, Muchun Song wrote:
> Because memory allocations pinning memcgs for a long time - it exists
> at a larger scale and is causing recurring problems in the real world:
> page cache doesn't get reclaimed for a long time, or is used by the
> second, third, fourth, ... instance of the same job that was restarted
> into a new cgroup every time. Unreclaimable dying cgroups pile up,
> waste memory, and make page reclaim very inefficient.
> 
> We can convert LRU pages and most other raw memcg pins to the objcg
> direction to fix this problem, and then the page->memcg will always
> point to an object cgroup pointer.
> 
> Therefore, the infrastructure of objcg no longer only serves
> CONFIG_MEMCG_KMEM. In this patch, we move the infrastructure of the
> objcg out of the scope of the CONFIG_MEMCG_KMEM so that the LRU pages
> can reuse it to charge pages.
> 
> We know that the LRU pages are not accounted at the root level. But
> the page->memcg_data points to the root_mem_cgroup. So the
> page->memcg_data of the LRU pages always points to a valid pointer.
> But the root_mem_cgroup dose not have an object cgroup. If we use
> obj_cgroup APIs to charge the LRU pages, we should set the
> page->memcg_data to a root object cgroup. So we also allocate an
> object cgroup for the root_mem_cgroup.

Overall the patch looks very good to me. There are few small things to enhance:

1) I'd rename it. Looking at the title I expect a trivial code move,
   however the patch is doing more than this: e.g. allocating an objcg
   for the root memcg. Something like "prepare objcg API for non-kmem usage".
2) How about obj_cgroup_release_kmem() instead of obj_cgroup_release_uncharge()?
3) The first paragraph of the commit log looks a bit vague: which allocations
   pinning memcgs? How about something like this?

Pagecache pages are charged at the allocation time and holding a reference
to the original memory cgroup until being reclaimed. Depending on the memory
pressure, specific patterns of the page sharing between different cgroups and
the cgroup creation and destruction rates, a large number of dying memory
cgroups can be pinned by pagecache pages. It makes the page reclaim less
efficient and wastes memory.


Thanks!
