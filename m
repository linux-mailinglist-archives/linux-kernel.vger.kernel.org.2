Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9046A3EF853
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 05:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhHRDCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 23:02:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22220 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234075AbhHRDCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 23:02:34 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17I2rLBq010987;
        Tue, 17 Aug 2021 20:01:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=mi5knW9Jn4ofm+zA4QFxUlSLjxWAkXnoidBlVasry1E=;
 b=WNrkjcMfKRvo7Tz3IkP8yoqftWPZUuECXfqPCo6v9QonrYTI6yRYSgxY5gPbf3X7Y9t3
 oxiDVRRzYyi3vf04f0PYnTI0PRi7D1AYweBj4/6h45ZgkA7+PUXiUJtc11a7PU9divmF
 n071GXUu2yvQ/NGs1o4Va2ORNtUBnW0NlZ8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3afrcbv5fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Aug 2021 20:01:50 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 20:01:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eajqFNDxVHIcjsoLVwtb7xVZ7cFKH6Zd6900wTZLYinYxGaHAkpUDuxTH/Kai7pbO11ZPRnciV8DW26I2g/Cw2i9Utahrh4DCfO9SLoDn0qdcKSTb7kSlgCSY/XzxE1S6Z62eB6gh2zLN+OTa7IOJabpVCudHd0azRuJ5VET68AoGWp/HlrAabHFOCyOetkru9z1Ee9vOGqfI4SNHcWoLWI6SW0UduHYa5X2qe0wnEHFe+k456EA8YELjjlzT1TFWxNs+reTeVSIZJLKE1Ki8tqw7t/sx6h2UloS1mVhlLNBPEFnkiflPXlPuno3lvIMylqTIBwlxnGMJK4AEbWZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mi5knW9Jn4ofm+zA4QFxUlSLjxWAkXnoidBlVasry1E=;
 b=ATYqwEeBg17DFLcVLBvo5/Z2j1rq3vo9AZjimSqMszOP+NlSUn1MRuHGxrX6Flabs+iY5y2bu8ELi60IQwmgh5Afq+EXT0rbx3esfR0y9ndU1vEJwfuKyUx41f9OQzz6ykdwmwJ59pVwvgnER7SjXCfXwC84zv7eMnIezQwHpc8ni2H4OQPHBpe8VCXQ6DJKbNwqbu8QN6qu2TJAkHJSz4fzUR59Cx+fDkZachg5nbNwUCKB7JjigNMdfTIuK4Hr7Y6WWeT9xESGUDQq7Q6HHR/UmI1r42vL/vPJF3M/KQ+mCDEDLPq7pD9z2HHUjr9KScI9Dlw8yjvuBf8vqw3AFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4357.namprd15.prod.outlook.com (2603:10b6:a03:380::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 18 Aug
 2021 03:01:41 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::75be:c42b:c0d2:2565]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::75be:c42b:c0d2:2565%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 03:01:41 +0000
Date:   Tue, 17 Aug 2021 20:01:36 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>, <bsingharora@gmail.com>,
        <shy828301@gmail.com>, <alexs@kernel.org>, <smuchun@gmail.com>,
        <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v1 01/12] mm: memcontrol: prepare objcg API for non-kmem
 usage
Message-ID: <YRx4EM0MWSjtutPD@carbon.dhcp.thefacebook.com>
References: <20210814052519.86679-1-songmuchun@bytedance.com>
 <20210814052519.86679-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210814052519.86679-2-songmuchun@bytedance.com>
X-ClientProxiedBy: CO2PR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:104:1::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:1f83) by CO2PR05CA0095.namprd05.prod.outlook.com (2603:10b6:104:1::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Wed, 18 Aug 2021 03:01:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25e071c9-8ad4-477e-3010-08d961f480f8
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4357:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB43579B3796D18D132FD3383BBEFF9@SJ0PR15MB4357.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Qc0Bh/tp5KzTfRnTjHUlDmm1wzqklk2jIS4WsU+SqWFdT/8LFs4ApZ23nOD6FjovqpWSwTJ+nQrM/lvdiG+QERkzWJoNud9jk3Jppc4lyK05xT+Lao0i9Yy8+c0iVwIiKHH1H4UPPz0F2wircsG/CnbEIZ54BLXpwZNHzGyq6u50jhTTqMsjRwEPOIjJ0ebGp2GQo/8DbqLVnhEqAOFk2MHK+Fqrr2AEtMtfo2Ov949OgflPFJapZVlt2vCko3yTHTR4Dgv7YH66UlWnqD6IRaRh/3pdhiMtdEpCTsRG3QIAulZxJH9MP5zLT2R1t7YpPpobcfalXvwp0EWC61JBAjtQlMZwGivipEAEFQ6XJpkeqhA12/xSkLBWcXDPjoBRve6n1rFhQ2sZTPUlgatDLkTOaJx56miv4jPLC0CiVUvlCsl2MDpO9csEQ2qcadrD1aqqEsXouczw4LK8coUHM+Cs6VbkDmBs11A9KyheR0dGlCiMdhm1N28RPKbzz1AjHeIExsV+JB4UPygzKUZndaZFYzcQpYIX/VxY+uvg6Ttq/qWN4PKx23f4bGmE7ZT2/hbmOqCvQG9bLcwPERi3oo6Y5VYKeF2U7H4xB1qJt+LslW6TQ9uoubbAClyEdSh60Up/eHfFMzJgxqGInyyaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(38100700002)(55016002)(6666004)(9686003)(86362001)(66556008)(66946007)(2906002)(4326008)(186003)(7416002)(66476007)(83380400001)(7696005)(6506007)(52116002)(8936002)(478600001)(6916009)(8676002)(316002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HT69Yh0Z+y0sfT73X/LrQ9SX/hTIUIxhTXONYkaaqJ7VmtEtfX7j2BNGoQtd?=
 =?us-ascii?Q?TkKQrqI7JHsh4GSutvnKudYA772o/wUuqFoXa3zTvbUwivUGI0rsLLl9bITr?=
 =?us-ascii?Q?UaQdAqgc8DeHzr6UCAY+F93YZhAdQ4+iomTIPld1/eqeBWV1mk3KRP0Wcaxi?=
 =?us-ascii?Q?92LgFbG+19gj1RlDHF8y4sZl0xWp0ksp71K1gSXW4xKqag/jbvVtPaPzk3W+?=
 =?us-ascii?Q?4yctlus2dVrgupWoKybhqvFMdG6J2jXNfAcOM9CnLyAxPB6/KJYh+WZDlwCc?=
 =?us-ascii?Q?Twhyi+T0/t6Cfa0vbZLRSfliVvv+XSFJcj3MfQOuGvDEWREEiNm8K1yxFngL?=
 =?us-ascii?Q?qan5/e2jRn2bpTTjH3qhtwII83vZVfogUx5Vd4eeYyxYD0OB2tF/I1dLF17y?=
 =?us-ascii?Q?wZJuwS2Q8RX5LRq2NU19jEy2suSMHE7Vyg+5PaFQaS2R7m9QSspdI1XFNsg4?=
 =?us-ascii?Q?r+c0gr0Gxj2ixn3StOx6DDOppwZcgEAt2nwO56IwhGyOLY26j3gTLit/GG+v?=
 =?us-ascii?Q?T04BeOggaJBxl2Y4rDxW6rtw3NKJ38ACJWBem1iZaprXFHsrtwJPG+i5sh6U?=
 =?us-ascii?Q?K59f+hxI9nH/X6mDPHEchChKYe1QST1QRysEhQvht/4Waa4JvddAxUNxyZTY?=
 =?us-ascii?Q?GP9KqjxzZ/Wnz3Tr/Ez5rx+j+6xgfZmsfN+kvJtkI/UQgb94CTpnpZTdVBLs?=
 =?us-ascii?Q?An8bEiARVehVA6rJaK17PNVTyeDGB9MG27cHt2HCTTRigmfQREW6JFWSZieM?=
 =?us-ascii?Q?hS0Om0DQlkqgLgzhTAu+Cs/0+LgX9ZkEFMVyDbZ59DueH+Q8yGKWZaxLp3I3?=
 =?us-ascii?Q?AnU8RnbR9677I3Y1m9zumgJGo9gKqJ2Wr/6QIeQiXX2Xv7gZ/G6pBLuTHpuA?=
 =?us-ascii?Q?SyigDEW6W3hbimOHKpxFkXovOsFYhsSJyAbIYy6Sy6id9VMogh965A+eljxr?=
 =?us-ascii?Q?hMH0BCfu9YGUPFmy+3Mnn/fEuGyJykCMcypMtmoQELEa21QdMmu6q3DnuhSa?=
 =?us-ascii?Q?+OqmBuRXh1vq51O4rRB6TzwMQE5zzpU3Lyf1nxJirvruNrA8dX3HFOG52FZ/?=
 =?us-ascii?Q?gFX9Ll4yccHFiNkwlLmgrHlbUfi9o6rFmkfEvYtmdxd+WXbS/7+upbW3gf9A?=
 =?us-ascii?Q?fU94wDor33GcGI61N2fZVfMKophS7km+LiDtD27IkMMi7lXfkaai4tgNsUQe?=
 =?us-ascii?Q?xPXLkpCPY/03v9Kx3CR+REFdgKYttqkiRT8CCCxUIAzNAHztvRY0OetzZIiD?=
 =?us-ascii?Q?pCcLgXKrB0cX5McoCETlS+lqwiM9OyeSglo2GL8qDHGu82GDXIEuTBIofBVa?=
 =?us-ascii?Q?bKgbLs3IaLCphUfzH54Klma40y2VoewCElFIcnJ8ljinUg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e071c9-8ad4-477e-3010-08d961f480f8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 03:01:41.4908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYDAchvBHAXyNwlnpJcLQnQLW0YUo52xoBSvYARCHDOQRhK+ci6y/OjPJ8LWDuhk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4357
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: oJi1R3GgGiepAoWadm2XbI0xzBAVBqg3
X-Proofpoint-ORIG-GUID: oJi1R3GgGiepAoWadm2XbI0xzBAVBqg3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-18_01:2021-08-17,2021-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108180017
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 01:25:08PM +0800, Muchun Song wrote:
> Pagecache pages are charged at the allocation time and holding a
> reference to the original memory cgroup until being reclaimed.
> Depending on the memory pressure, specific patterns of the page
> sharing between different cgroups and the cgroup creation and
> destruction rates, a large number of dying memory cgroups can be
> pinned by pagecache pages. It makes the page reclaim less efficient
> and wastes memory.
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
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

I like the "move objcg stuff to memcg/css level" part.

I'm less convinced about making byte-sized charging kmem-specific
(both naming and #ifdef CONFIG_MEMCG_KMEM). Do we really win a lot?

I understand why we might wanna compile out some checks from the
hot allocation path, but few bytes in struct objcg will not make a big
difference, as well as few lines of code in cgroup creation/removal paths.

Also it might be useful for byte-sized accounting outside kmem, e.g. zswap.
So, I'd remove this dependency and rename to something like
obj_cgroup_release_bytes().

In the long run we might wanna to eliminate CONFIG_MEMCG_KMEM completely,
so let's at least not add new dependencies.

Thanks!
