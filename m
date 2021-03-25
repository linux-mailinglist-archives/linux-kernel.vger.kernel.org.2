Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27110349CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 00:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhCYXVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 19:21:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59592 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231384AbhCYXUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 19:20:38 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12PNIEEt024967;
        Thu, 25 Mar 2021 16:19:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=O6uaOUlTdYF37ATr24ogOegOhSOUCgkJYvE7nbNTbAE=;
 b=qt0gdDAzREDy81Hedp8ELLzBVopbjM7FGQahDB1W3SVRBBJpUPm1bW6FAe28f0nsJzHL
 GIJHw893C4Ntj9ZtlZf5fSt/ZZidnbkQisAzCeXO6DN+jzOrRZuv8CUku5TMMXOB2tIM
 CU7w8O3vM2WNGVS78MKoEg7Y6DG+4m7NrmQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 37h15th0a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 25 Mar 2021 16:19:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 25 Mar 2021 16:19:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwzY+gEYsOKqXAdgsancK4mjFnpZEpH55Ryid2qhC4+c/G05KZ/vbLq0gBqaMoisujt2QF6Z37HgQK0YXHXQ+HIi98X/D+iwzIZiuMrZJ3j+8XXG21zbyCTjkxLWF6H8XO5txjtURGbnnyF7ZrE1O69DiEGzBI4WVw5pbLAUy8KjZHDaTiaIN90rnsgzj6GSR4H2Q6P0yOdNR2TA/jqtQ2AiL7dJtDdhTgp2aRWBzGhfG7HTO3t1FGw2mRFNEO94RR1Nti17UW5lEKavDNABN0ZGRNM/tLEGoCZtsEb7hQXyle2/KXfdQB8s6wgBi2oDd2OvWM9GDd9emWoTiO8Ykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6uaOUlTdYF37ATr24ogOegOhSOUCgkJYvE7nbNTbAE=;
 b=MI3GlPyuPqJ3kNfrccE1aJwhXYkOXYln4tx6BhYGztjEpXybNyseWa1fA5Zz+1FUY65I5jKWg7O9WDSyj3snPMobaeg+hDgEUM4caef5TijvfOG2W+6Td9kMp+AAo+Pmv8TSt5SNhWgJ2+yQNH2Dg+nL7AUOqnckDNGL49ftqsPqu6M09mkztbsAoGLigvli90SOshW6kMsF3/eWUFWmdehFLEkJfnWNAqHhp6ckTe12JEK/brlg3SLQ/x+SixKlmkumkkIrbU22JhoUYjNvkWWiQgrxpriDPO9DRxWkVxhsDB+LuAWsRR/k9HXcUJtNXpiWILbG38xfkB11UXHrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2598.namprd15.prod.outlook.com (2603:10b6:a03:14d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 23:19:34 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 23:19:34 +0000
Date:   Thu, 25 Mar 2021 16:19:29 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Minchan Kim <minchan@kernel.org>
CC:     David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 1/8] mm: cma: introduce cma_release_nowait()
Message-ID: <YF0agS53iGkFo41Y@carbon.DHCP.thefacebook.com>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-2-mike.kravetz@oracle.com>
 <aba43427-0f51-7eb9-fa73-6e55237c8ddb@redhat.com>
 <YFxkXEXMpcMM/KWd@dhcp22.suse.cz>
 <76aaf359-9496-04df-a585-3662d0375749@oracle.com>
 <4bc3c5d8-f1a7-6439-8fee-582364a7c021@redhat.com>
 <YFzuw0S5S/aG7nVk@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YFzuw0S5S/aG7nVk@google.com>
X-Originating-IP: [2620:10d:c090:400::5:4460]
X-ClientProxiedBy: CO2PR04CA0064.namprd04.prod.outlook.com
 (2603:10b6:102:1::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:4460) by CO2PR04CA0064.namprd04.prod.outlook.com (2603:10b6:102:1::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Thu, 25 Mar 2021 23:19:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 774bd75e-48e9-4a2d-74ed-08d8efe4738a
X-MS-TrafficTypeDiagnostic: BYAPR15MB2598:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2598CE8FDA441E27E13FA4D9BE629@BYAPR15MB2598.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u7ljQOFao0P2qnxLKRYh9ISe8bNAEa9XtAQK4OkraNbXaFWtgbydm8WVE8fi6UpgeHuvlq5CMdHZBD+BssJoIYM/7RCYix2BjTzS0KccyHHFsS/osdLC77U5O9y2YzvpXo7uBNo67DqDwSCxWRWAz2IyGpK96Y/ksVL0akgzuJTFSwQDMe2hyUBDkZSA6fqKGiVqSnqifFY2GM7J+RD5NUk0xGtXAxGF/NPH2RGAzgQBaZCy7YDNhW7h6nbzGuntfBGeHd0qs7F2/qyTKAD9nrIdu+sr2McDZEkuXx8+ouchjj8zECPgP4xYSzYHMFmvlFcvJPcjIpuAZ30VolHQr5g+8DpRHclONBSQ3RkyZMZ2B4NEqPBUMY+7VGWF8IOP3CVVUdFuQKtVlNjSNWm2yrqqBmtDymGNqYr2OMmH/UdzebKPF31t8g/dcVAjS/9bnUO9tA0lL+kMgJkFG80zRLdwumfuV6toTrOHaJ83COv3ljwDC7Urd5ZrqRM26daWY5LN5CBNC23KCpj1T28RR8h27ie4+y6qE3FTfhhj6Lx7tFXQrb60wfrQhNZPPjh7KFvOxMNrRgnOe5Px0398q24w6cJWn3hjgJDZWW4srEy9gkmnVomsbndrJCKRA09eUkp+wsxw/pPOG5B1gZMTL+cMk0T5DXPFpeo8LlWvXb3c+bUzzZYBRa4u/aHUE9dZtZ0GqSxjIuGKLGrUZCNEqrUDe0krdwqG+W2oTp1paug=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(396003)(136003)(366004)(478600001)(186003)(54906003)(966005)(6506007)(316002)(16526019)(38100700001)(7416002)(52116002)(53546011)(83380400001)(7696005)(2906002)(6916009)(86362001)(9686003)(66476007)(66556008)(8676002)(6666004)(4326008)(8936002)(5660300002)(55016002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LRB7ArX+YNOIYnCb4PfO325lDBQBRdr4URRz4Wyijhzc5WJAiVjZJrK8nnEs?=
 =?us-ascii?Q?AQMIIQzoJGl4J4zvNbYPrezPL1Oihn4UYpbMXcnh2jwaaBiTfcLfzD6a6bsB?=
 =?us-ascii?Q?ToZE+NM5wLX+vxMHwM6pc0coFBriOmjzWYLow6rXxvTuS/IhV5Bs7HWKpNh9?=
 =?us-ascii?Q?3v2P/MYzJz94jP+AcOilMUILW6JHqU7suDOev/w0XC1pCGPndnDHWJj77ZuV?=
 =?us-ascii?Q?Jea/+ndayS24fhyc3WTqJ/YkxKLtLRpjnZ1GZ+fbxBB6jYVswuYnZ9pbW6SY?=
 =?us-ascii?Q?govPAuJqoHbKbZn5T6nboVm7nbZyY0kKUbJt7q2i8LgWqtd8k7++zTrmcG32?=
 =?us-ascii?Q?VPqWWhN4wIqAdPVnhALm1shxGP8ko+s1BbIt3F6SbnwJ6ktFQN3gbt2GT28b?=
 =?us-ascii?Q?WsFQvaVRYIuoLy+xSghaEi67NRBwx9p8rUe7RJV+FQ0zsL/jxfJhg08fr146?=
 =?us-ascii?Q?eyAupMdb0+2vJqXVwqK5ml0dpbj+M722dlVQfDvQtpDAs7+RtIf5WH55oBrg?=
 =?us-ascii?Q?AEj3JflvlT0WCrGTtIRBaiffvXr+rorWh0JOG62ZGpy7w4wwT5eLHC5hxB8X?=
 =?us-ascii?Q?22kKLWgiZ7f7PpsjkZhoFPwGdY5BFHmYLNDo2ic3uvZsvtC6o/gwjEtky0MW?=
 =?us-ascii?Q?C2rRWinsKN8hRQDZseU9shbFfYa4a4eOhYbJudoMVwfamP4JW7z8wVRwjazf?=
 =?us-ascii?Q?Dz0JLVXVVsQEEUFMpr2w6OlLnTEpebPi4DFjnpG4CZiWWX9tSQsxiHy4wYxO?=
 =?us-ascii?Q?Ds7vNCzrSh5N/vT9HBlWvthcdKcT+cHpw/3zI1xIS1Gx/eBd/2i5j3dvbXTb?=
 =?us-ascii?Q?EKJVl6W7wqF7WVZ2YH/BZ4daKyIrQSElDQIUo9nknYbOBSx8xcnzIHZ4giyL?=
 =?us-ascii?Q?VLjmmABKKSbKmo+X/OolfqD/MGHjmHUx0IRZfYOcZg74w8d6vEf+hprl/Vzq?=
 =?us-ascii?Q?RPQwgNv793wvW5lBr9BQW0CZRdFFnp6uuvtOmieNLsjMCYmbRTSEjkI2IRet?=
 =?us-ascii?Q?AQqjIwuY1XtG8jID4hTlwSnB4ShuCy7vUeu9nzgqy8xIoj95BRYpuvfcjwc7?=
 =?us-ascii?Q?VsqxAPp6OcQUoHHytikcdPIz5txED0pEXzfdEzV34ycQV2BHhwaV08jGqQ6X?=
 =?us-ascii?Q?J8K3UIDapgql8QMpjuWOEdJrzLmcmixxOOEpENO1JAIgEcmr5w8UUX1GUrY+?=
 =?us-ascii?Q?xVGC8FLFMtCa8TaGxQMsVdlDT3zOH4atHdD9mGvdiQB8FtPHJXULAIRhXiEI?=
 =?us-ascii?Q?62Q/P0k7NlCiLxb0QZQgnC35fC0fSq4xvj/0p/H/pyOSUsZQ87Y/0XPODzB1?=
 =?us-ascii?Q?Z1oRMLVYTjRJHX/3nH4MbjVHJXtd1spAC3dVsEY5OWWH3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 774bd75e-48e9-4a2d-74ed-08d8efe4738a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 23:19:34.7618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9r/BEI96tQHcEUaCBKoeK8MPG1bH3FRIqEFSSf69r8FVmEOo98Oo4kxp1naWsNf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2598
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: jN3Of7sjg4bAH4vme6_buxzE1EcE00lI
X-Proofpoint-GUID: jN3Of7sjg4bAH4vme6_buxzE1EcE00lI
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-25_10:2021-03-25,2021-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 suspectscore=0 clxscore=1011 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103250000 definitions=main-2103250173
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 01:12:51PM -0700, Minchan Kim wrote:
> On Thu, Mar 25, 2021 at 06:15:11PM +0100, David Hildenbrand wrote:
> > On 25.03.21 17:56, Mike Kravetz wrote:
> > > On 3/25/21 3:22 AM, Michal Hocko wrote:
> > > > On Thu 25-03-21 10:56:38, David Hildenbrand wrote:
> > > > > On 25.03.21 01:28, Mike Kravetz wrote:
> > > > > > From: Roman Gushchin <guro@fb.com>
> > > > > > 
> > > > > > cma_release() has to lock the cma_lock mutex to clear the cma bitmap.
> > > > > > It makes it a blocking function, which complicates its usage from
> > > > > > non-blocking contexts. For instance, hugetlbfs code is temporarily
> > > > > > dropping the hugetlb_lock spinlock to call cma_release().
> > > > > > 
> > > > > > This patch introduces a non-blocking cma_release_nowait(), which
> > > > > > postpones the cma bitmap clearance. It's done later from a work
> > > > > > context. The first page in the cma allocation is used to store
> > > > > > the work struct. Because CMA allocations and de-allocations are
> > > > > > usually not that frequent, a single global workqueue is used.
> > > > > > 
> > > > > > To make sure that subsequent cma_alloc() call will pass, cma_alloc()
> > > > > > flushes the cma_release_wq workqueue. To avoid a performance
> > > > > > regression in the case when only cma_release() is used, gate it
> > > > > > by a per-cma area flag, which is set by the first call
> > > > > > of cma_release_nowait().
> > > > > > 
> > > > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > > > [mike.kravetz@oracle.com: rebased to v5.12-rc3-mmotm-2021-03-17-22-24]
> > > > > > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > > > > > ---
> > > > > 
> > > > > 
> > > > > 1. Is there a real reason this is a mutex and not a spin lock? It seems to
> > > > > only protect the bitmap. Are bitmaps that huge that we spend a significant
> > > > > amount of time in there?
> > > > 
> > > > Good question. Looking at the code it doesn't seem that there is any
> > > > blockable operation or any heavy lifting done under the lock.
> > > > 7ee793a62fa8 ("cma: Remove potential deadlock situation") has introduced
> > > > the lock and there was a simple bitmat protection back then. I suspect
> > > > the patch just followed the cma_mutex lead and used the same type of the
> > > > lock. cma_mutex used to protect alloc_contig_range which is sleepable.
> > > > 
> > > > This all suggests that there is no real reason to use a sleepable lock
> > > > at all and we do not need all this heavy lifting.
> > > > 
> > > 
> > > When Roman first proposed these patches, I brought up the same issue:
> > > 
> > > https://lore.kernel.org/linux-mm/20201022023352.GC300658@carbon.dhcp.thefacebook.com/
> > > 
> > > Previously, Roman proposed replacing the mutex with a spinlock but
> > > Joonsoo was opposed.
> > > 
> > > Adding Joonsoo on Cc:
> > > 
> > 
> > There has to be a good reason not to. And if there is a good reason,
> > lockless clearing might be one feasible alternative.
> 
> I also don't think nowait variant is good idea. If the scanning of
> bitmap is *really* significant, it might be signal that we need to
> introduce different technique or data structure not bitmap rather
> than a new API variant.

I'd also prefer to just replace the mutex with a spinlock rather than fiddling
with a delayed release.

Thanks!
