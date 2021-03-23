Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66632346895
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhCWTKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:10:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11656 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233222AbhCWTJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:09:36 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NJ5ZCT021502;
        Tue, 23 Mar 2021 12:08:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=EIxn4h/jH+c7OUCyWyUo97ywyY0r0Aus7W2UQ9KyKJI=;
 b=k9HgWpPEKIh3njzHG2xKlxBm9sLRWp6wf6hwYpOaHK7ygMblKZ1dJj1u2njsE7e1L4ll
 Vq5UebRWr4CV0HSsvuquOurjUKFvZt/fasPpgc8YTXR4Uyufs54Vp7AZSzg6cIT8Zfvb
 Fsr+QQc7kVosKh3QazOyx5W7L5SHH0eBaFk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37fnsx86m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Mar 2021 12:08:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 23 Mar 2021 12:07:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tw629laRkE+8QHrrPM3mjYIsdvm8yBpBJUEl3kMbvSPVNdQsTrojnhuCmRe3PP7JCEVRfkJ6GLlSBvubX2C0EZ20nqgpIuWBanE40hUe4ioMDj4sl4kuPFm4/puO7vJQ6uABhS7MdqtIdhHu5cq60bnIeT2dcBonTTbaL8MzQIbD/CD2CyGUi7T9XTy2ZPsCo0Trz8STNGMrS7dWdm6apanbzwsxDl8A3s9mz+/rSWFMG7wwRpSwAJZImZNfIiPxY4sbORo0bLrYyNMGA5kt7iYcA1VdNMITJzUqRrzVyuQYek0EzZZMFZH291Ze+i7fRwOy5cMNSBnYmvNNoHJNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIxn4h/jH+c7OUCyWyUo97ywyY0r0Aus7W2UQ9KyKJI=;
 b=lKgjO3bFXMO7HQ95FrmXaE/D/KXAOXNTqh97wjLM5qLAw+R/LtR2oLACDmvRiG0b1/iCVOMxXOxPd+t4gOd0/Sfnef6qInOSv3JISt+y6Vahu3qwI6NTScQOiUxcKI8hJ4Qy3AMHQvNuPRa0IFbSBiNV44BlgWsSUO2WvGgDwpiXSLdlySI7gNndq2oUlprhTKeddvpgzHVBESbT8EnnTqkYfHAe0/eSX+ZsdYLQBuekC+yPH07nFQg/RVo/9tigIENtL75rHQ4+EW5hI94o98fmZWSPOzzu1aQGOf39yAXlgRSsLaegGcgy7c91j94L+xFgpEV4hvF6UikdRzGfzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4647.namprd15.prod.outlook.com (2603:10b6:a03:37c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 23 Mar
 2021 19:07:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 19:07:42 +0000
Date:   Tue, 23 Mar 2021 12:07:39 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Peter Zijlstra <peterz@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 7/8] hugetlb: add update_and_free_page_no_sleep for
 irq context
Message-ID: <YFo8e6ATS2uWeyqg@carbon.dhcp.thefacebook.com>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-8-mike.kravetz@oracle.com>
 <YFhYHZ9onwdZMeDi@hirez.programming.kicks-ass.net>
 <2383057a-29dc-383b-720f-7cdcdd015e40@oracle.com>
 <YFjdpDwKaqwvW1I9@carbon.dhcp.thefacebook.com>
 <8a28c691-1e7c-1463-9d59-da31a2926adc@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8a28c691-1e7c-1463-9d59-da31a2926adc@oracle.com>
X-Originating-IP: [2620:10d:c090:400::5:3d39]
X-ClientProxiedBy: SJ0PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3d39) by SJ0PR13CA0087.namprd13.prod.outlook.com (2603:10b6:a03:2c4::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend Transport; Tue, 23 Mar 2021 19:07:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c17768b8-5c17-4dda-bed0-08d8ee2eef61
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4647:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4647E4B04E3C5C153125BE7DBE649@SJ0PR15MB4647.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sK4xCv71jn8EfPKW8sXyqNzRUJ4ysA4aLeKKaQtGKcnEb2x9uZvTfkYyIpKxQldwp6xgO4bbVBFqDN7XSNaQDfHXt1UDWlDrw+FZNUdCQlMGLKy4D+0YxNNlSPCd35jqGQwBsV+jDNHh3X8FNmfnrI9k8BZ++YAmihEOPqtgMtaUoJlPOVJLVglMLHQYL6tL/oiwfKNMEixOluF+9F61up5qS80j5HpHg9mClR3hmooT1BOxjPHRuhPYjWZmP69blRyvdjN+5Pxq0Vwcj2qSZ1yUE/5DKbWWzzEOnNymiSJMYwD8mK0wFUNpKiu6EAJjwsePatn9YYHRizGkDEBtF/43pXRKCUErENySd05EZg/wDFFwmYH7nOydkJ5IQaF24UZQLHgGDgK4bA0bd3d+6Y7/alD+ueuJFvoaSazdKXINEXlre37VkrdOveEHFTgwaaIZ8nVCHCVHY874A9MiUo5AeYEM89XNhKcOE28HgsfUI9Gqp867CYIHLp/hVx3UnEp/+KaQJmVExXOvwUyDp4A1ZZadeP8J83DumWTMPNIui5nUv8v9oV4cq6lrxuywjtJJNIN+Sve/uT5Sk6jbxRka4Be3xpOXwVbmiYZH/bj1k2DVUs78gimAI1CNU+3QEBO4e15bVbu6Ussr/sOka9R32BT+pAT35aR+kf0PqiDlWmMByzHZUpog1m5GjauWsGCHr81RQaKEEPii5nfY2RWO9QJiIUuEgMafori8RM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39860400002)(396003)(346002)(6916009)(478600001)(16526019)(186003)(38100700001)(6506007)(52116002)(7696005)(53546011)(8676002)(5660300002)(316002)(966005)(8936002)(6666004)(4326008)(66476007)(2906002)(55016002)(66946007)(7416002)(9686003)(83380400001)(86362001)(15650500001)(54906003)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?a/tsD7mk+W67As0KZtT/wYZPyfOMrOWrZQeCH1zlZiKAUzI0FJvMD3tSpvOq?=
 =?us-ascii?Q?BNJ6/aalX72Iw3+keCGpNggTfK5zQfaENlbYyNwceGmuADLOl002Vn7GuY+w?=
 =?us-ascii?Q?++tj3dmZD5KWbrAsFfeUDWwWvy4/4axgCYd+LmTgJlxSnf8Z+v0jLjLxVRi4?=
 =?us-ascii?Q?SQJVrPLjp1cDL/SpkxNup+fm16MPga3uvrfV28vgV28qLq5fOdTUBM4xWB5z?=
 =?us-ascii?Q?3+0dJWuAgdUOrPTMGDyjVFTf+Xbj2aJurpd/ylQRvcMg4E4hBoBsm4mbfiYS?=
 =?us-ascii?Q?KsXkor7XEu+81I9GggUF76MBpjw5Ym2pPoxrdmGDulB9JH/P7GLtqItB1Zgm?=
 =?us-ascii?Q?iKCK0OZmaNWrC9u3pK5ySi4l9mC9CDEDO2t+Kj7McwsiXY6ZeX/IsvwrKzCb?=
 =?us-ascii?Q?rEJw5IzcwabzbmnoCfX/gNkTHNZnhaM/4blLQe0kSczhmeAwpR0X9Dwu7dFQ?=
 =?us-ascii?Q?Kx+29jAEf01i7Nzrvt88YmIvV83fOl0+WtMKwdqh97Hd2jFeGmlavsLqc8io?=
 =?us-ascii?Q?DxJyKErBhr2ZGuTcAPomOPL9Sa3SXSLH7OxzR8mSkpQBV9lyBZbX/9ETiLoH?=
 =?us-ascii?Q?CRE3BolzeAEhcKbg0zA86Sp+AsMrRTBjpEvfuxNxgp44ld7wNnC2Yet8VHNT?=
 =?us-ascii?Q?zkkjVDrdYbBFNwvrsmGZjPuFuNJzLxvFE15opPrEjjNgBTHopR4egH1xninP?=
 =?us-ascii?Q?HE+Xxlrrwu2YEp/aZIJckFMMAOk9MiAaVDJONUmPqutlyeSgcgch/qkfKBlh?=
 =?us-ascii?Q?zZM8SSsVXOqGpQr3+x9WN2bBXIjR8OgxvbwlXVqPJ5nQsqQvoXTeoE+H6g/l?=
 =?us-ascii?Q?Yz0z34gz7DqgUaqpJ1gRLSG86EnABkLqDHkErJFQ1IgDldyDxJ0RCbQpbT99?=
 =?us-ascii?Q?72KxaE/FBpLa13RUenpjPHITPWA3UwzkwoLsif3eizN5BisruDcXBabSkaqa?=
 =?us-ascii?Q?zi0WyPrgwnXhg5KIRl5clRA7U65DxkBNRqyXB7ZjqFmmXlfj3wS/M7m8RIev?=
 =?us-ascii?Q?NLCtEFjeF8dVAAcHlKU5GUXNJrP/uxc5oP6TmivgP45enHQMW19a70IHlPeP?=
 =?us-ascii?Q?LK3Ke23PueJwwGZQO2Kd+Lw7uPhd3yYQz2X39NpBgHRcdmdYnyTtfRJ2GCRq?=
 =?us-ascii?Q?803VsibWoGjn2ZqRuvV5MC9G1L1d5Y9PAikmiIMwG8LlY9blMCJUv5YYhLW4?=
 =?us-ascii?Q?y22MnV2hm1kkZl86sj6CUHHYpi7vcWzLTeC7Z8XtkFXZ0L/KVfXaIGu2SkOV?=
 =?us-ascii?Q?AbKKaEqN5h7JpDsukT6d7mGU+pMvTODLxPnl4BFQu2RgzLbMNN9cZIT3UxlJ?=
 =?us-ascii?Q?/QFRcFIjcn9eWBaUNNBrGHWZvumryO2l3h9ZQMEU3sgcxw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c17768b8-5c17-4dda-bed0-08d8ee2eef61
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 19:07:42.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APepg+r/n6tLRNO3Dn1tFckK3W1jdA8F9854GB7jFTqkmQR/SCXEZ0MRU7Ux7azG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4647
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_09:2021-03-23,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 11:51:04AM -0700, Mike Kravetz wrote:
> On 3/22/21 11:10 AM, Roman Gushchin wrote:
> > On Mon, Mar 22, 2021 at 10:42:23AM -0700, Mike Kravetz wrote:
> >> Cc: Roman, Christoph
> >>
> >> On 3/22/21 1:41 AM, Peter Zijlstra wrote:
> >>> On Fri, Mar 19, 2021 at 03:42:08PM -0700, Mike Kravetz wrote:
> >>>> The locks acquired in free_huge_page are irq safe.  However, in certain
> >>>> circumstances the routine update_and_free_page could sleep.  Since
> >>>> free_huge_page can be called from any context, it can not sleep.
> >>>>
> >>>> Use a waitqueue to defer freeing of pages if the operation may sleep.  A
> >>>> new routine update_and_free_page_no_sleep provides this functionality
> >>>> and is only called from free_huge_page.
> >>>>
> >>>> Note that any 'pages' sent to the workqueue for deferred freeing have
> >>>> already been removed from the hugetlb subsystem.  What is actually
> >>>> deferred is returning those base pages to the low level allocator.
> >>>
> >>> So maybe I'm stupid, but why do you need that work in hugetlb? Afaict it
> >>> should be in cma_release().
> >>
> >> My thinking (which could be totally wrong) is that cma_release makes no
> >> claims about calling context.  From the code, it is pretty clear that it
> >> can only be called from task context with no locks held.  Although,
> >> there could be code incorrectly calling it today hugetlb does.  Since
> >> hugetlb is the only code with this new requirement, it should do the
> >> work.
> >>
> >> Wait!!!  That made me remember something.
> >> Roman had code to create a non-blocking version of cma_release().
> >> https://lore.kernel.org/linux-mm/20201022225308.2927890-1-guro@fb.com/
> >>
> >> There were no objections, and Christoph even thought there may be
> >> problems with callers of dma_free_contiguous.
> >>
> >> Perhaps, we should just move forward with Roman's patches to create
> >> cma_release_nowait() and avoid this workqueue stuff?
> > 
> > Sounds good to me. If it's the preferred path, I can rebase and resend
> > those patches (they been carried for some time by Zi Yan for his 1GB THP work,
> > but they are completely independent).
> 
> Thanks Roman,
> 
> Yes, this is the preferred path.  If there is a non blocking version of
> cma_release, then it makes fixup of hugetlb put_page path much easier.
> 
> If you would prefer, I can rebase your patches and send with this series.

Sounds good! Please, proceed. And, please, let me know if I can help.

Thanks!
