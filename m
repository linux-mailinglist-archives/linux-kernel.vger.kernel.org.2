Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8721344E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhCVSMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:12:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43102 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230440AbhCVSLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:11:36 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12MI7c3O020970;
        Mon, 22 Mar 2021 11:10:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=vM4qLbn6LRDu1yo72losvJT4lGBhrt6CkCHSxTvlzcU=;
 b=paWXe4rH5hmFk5lfGbL72uk6dmE0gKwKJxPkHfdszIBE42COxAtXNB5Y79FXkmVcf3Bi
 jYhSRCcPSP+c6hKVmTD74EETeO6cRb/Q+5g9Z7qSgXaZO5nLAxbTvjDWSPv+5fXfwkFR
 9JCggT+cVHqXc6ZcY3pO2UGWj4M8ruuudwU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 37dcqp274c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Mar 2021 11:10:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 22 Mar 2021 11:10:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePh23upoe13r/jiKHbZK6wm4yQ26WxwxI5LykOLmNdiUwB1SysHaEwl4MiJDMYIwg5W8o/yOt9cQBL5fIhXqr+BfRXzLBsIPFetwF1zjJbnv8EWIFPmj0rvoB/g1Oqj+olFZSWkJzZUGuQMgxJ9faLcA+/H6HUPahMd+UnOZW0T3DoyfsX/z94WEKAfy/LEb8jMeN3NDdblq2jmM704DVcJDSl1Wu8pZUx7QR4vHea/x+onEi5jKsb/lcJuk7eLUvsQ9XS6gWmnG4MWpbXUxWjEka+9xMXgdrdUvv/VnDFNAxMACFY+fJw5LZiXgfgj60TRfc1DeZKRL0jShhiTcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vM4qLbn6LRDu1yo72losvJT4lGBhrt6CkCHSxTvlzcU=;
 b=TPa5noYDU4gvmWgoNPso1oIDA8HwinR+FIS0QzFp6zdyAFpuaa2mG7hjl+/9f/ZBJSa2HV1J51C+LeBAsDrGvgwQDW6inUT9OMOCobRMjFNfUEKgd8nUIPwriglngEwlD+iVP1QFKR88YSDh7vikoyjLS1uhUqb++2f55YEKClJOzD76HZ3tp+0wPhT8idRBDmnCUyvbRXjPlBahNO5tpunwXURwm1ap5R/XV0KuV8e62i5cKy+wC4O/nKEr9euMHjfXzaKkEIbKTNsEHWJJ53MhhZiWzRO7B9ekB/Mg/gCt7ugTl+9FUUXtRK6bXTRAykcUN7ZNvaguAwaedXnuYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2936.namprd15.prod.outlook.com (2603:10b6:a03:f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 18:10:50 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 18:10:50 +0000
Date:   Mon, 22 Mar 2021 11:10:44 -0700
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
Message-ID: <YFjdpDwKaqwvW1I9@carbon.dhcp.thefacebook.com>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-8-mike.kravetz@oracle.com>
 <YFhYHZ9onwdZMeDi@hirez.programming.kicks-ass.net>
 <2383057a-29dc-383b-720f-7cdcdd015e40@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2383057a-29dc-383b-720f-7cdcdd015e40@oracle.com>
X-Originating-IP: [2620:10d:c090:400::5:cbc1]
X-ClientProxiedBy: MWHPR10CA0053.namprd10.prod.outlook.com
 (2603:10b6:300:2c::15) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:cbc1) by MWHPR10CA0053.namprd10.prod.outlook.com (2603:10b6:300:2c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 18:10:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1cfc367-e762-423d-74ae-08d8ed5dd2c2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2936:
X-Microsoft-Antispam-PRVS: <BYAPR15MB29366BA9A08E022E53C627ADBE659@BYAPR15MB2936.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j64MrwX8aaI7NmUGEmAV2eck/XIRft++R5A09W2rC7CYPi3mJNTokQExSp+iBLQXcfXJhFJxegDrXch8NAT4xLVvvunL5xq9gHX8KnvP1I5NbGAVGlzCftF6NhgmQeRjTGWdFPZ/nrBYfY3aIZsoRsl/6vLgYfvCTk7ZxXrV7//Xcamoz4+mYr+kGSpSFcmLTzLgAENmbaL43r7q8mYKgV61pnwl3IfwOxpxqQBBp1eDIzyXG8637QB6SW0eCmcjC9AG9skOsN0bwk1BEOuzk4h1RPsW31GQkrmWwbDHV2628XoIDB4C1PEz5wDnd73MJigQFyH7P2Jrw+f7Q+DVV36KqPlXGjbt3WAMy55qNskdnIhVZ3Zyi97vuNjgsiUg06HNp/jxZFKEWhydYyXfQoooV10k46PEFDKv9rQJFRTFQ4c3bgP58rZaCbUXWTOBeFj+LNAUAFdOM11eq3K3Jhmu27QIc9+OciLi8XlxhCSWWKSmtvdkhGjqDYvN/gHkP2WADSm0znSzvUKyMp4CUf5fpNFAi35d7QHj91KhuokJf55UUN+roiDXvZ713WvLT/V81+9USL1E33o2kG1fgmZYvX73rchkrWKNfkB5aV4blQdzCOnBTaduE5hlJaE5DQZFY4EvuBtfkkcX9RcKxmbyXFpQlgNRBCzHKcjKGOnUAEv+Pc1IkZ+VWv/T1cQnshc1+/c9ls7nMbfkBuvSQKM0CCrrgFucUy+LV/vwOAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(346002)(39860400002)(366004)(16526019)(52116002)(6916009)(54906003)(7696005)(66946007)(55016002)(8676002)(7416002)(186003)(9686003)(316002)(4326008)(38100700001)(6666004)(86362001)(66476007)(66556008)(5660300002)(15650500001)(83380400001)(8936002)(966005)(478600001)(6506007)(53546011)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?T1uGi5NtPF83UcF/tGmbu7F+1KE9Ftl51y1D76R9k/iJHDGi3Kq+pKjkkSkd?=
 =?us-ascii?Q?0jcIPXUVjQyx4DjQRs2ZcEsHchr6paWOWnLdZj9Ju+noZMmMdYKBUUylI1XR?=
 =?us-ascii?Q?v05PuTxzPO4I/ubsxoHEAeGsKVzbaPzchca4yrgHLWDW6fk2V9rD4iYva87f?=
 =?us-ascii?Q?esPCUhY8gtnxvOX6iOmfwvD8ZXkWUpZNa2sJiEBAUwIQ+/X9l/RyalllUebM?=
 =?us-ascii?Q?HWb33aYfPffSSHXjj2EUE27INq2vTKIKWK+q1yZ3kGCtDkrvxQ/AksIbdaKx?=
 =?us-ascii?Q?HDBP0IYo8GtjfghseANrDDtRITzb025QzorU8KsHz0UH/utWR3iI2vsf8CNf?=
 =?us-ascii?Q?YgXqMYlEnaAkeSQhTBsHAH6UseNmpmcMWovgnq7u/Eyt32pS3A2hvMd3en9L?=
 =?us-ascii?Q?ShV9y4wC1pIfxkyK+m+mPMttg2mgjLaXSB46leNhzPC7bLeN/DRaXxBc28aw?=
 =?us-ascii?Q?eYpikBcKlxygWcm6yxTJEaPxSwHz4unLIPwQ8q6epXm5PfXltjvotDqriUQ4?=
 =?us-ascii?Q?q6ZoWoFeX7b2572Soi+pb40tZIzLxetvCZXE1VON5NhOozFH5cbpCVGb7vUL?=
 =?us-ascii?Q?UEPxnUwVUjR4bOGQnrrLGLhr5zkq3HvVmnjDayDyc9EZCgu6GBOeol1fxZRi?=
 =?us-ascii?Q?thSodnyAdMXIT5cAnOkQ8q9MOX9F3CV01mYFhAF8KMfQIY/Mmo0aZwyT0o91?=
 =?us-ascii?Q?XlKURlTSesMG0KiT+haapHUY+5GgkY+i1eYoPc8GpPyUO2gQiSfBmoTOsCru?=
 =?us-ascii?Q?24SWowKo/kAS/CUD5ZK8HWTlJVawhYxRK2s3wMMYKtMpE67LcvISRCvenzpF?=
 =?us-ascii?Q?s3HgzKvr+HjOfgvQdFiuYrWY3pBLm+S6POFBnjxUGk2V1lUWgryz9Bu97Y9w?=
 =?us-ascii?Q?bfzbfN4HQqWgWs7k+ZQyGgaHgMp0PfIIefG+oz3VAyMxMplhwB3O5jXKuG5U?=
 =?us-ascii?Q?9/hQ0npOFIwQcskGsEIJhkWCBLSyEISTOMT3GWNkY8xZqexKEsmhqJjc9X3+?=
 =?us-ascii?Q?CfNajd7nB05qIj+q8VYum75QPIMQqS6qfHTq3pBl/51hCYjQyq/os3KaBuhS?=
 =?us-ascii?Q?nXhs9tFSjGEUK6Tq2szU9PCap5eE2tq8v1X7Ow5i4mGsRTFJtZ/PS1PcfUAM?=
 =?us-ascii?Q?kEpPfh+us1i9mQW7hbIJYNJR61cr0r6CFhdAaIZHSrybk3ENBhc7iGD+Ri2d?=
 =?us-ascii?Q?3/LLE5cJ/tkWx0lvLvNWdefopjmGdHgyI/vIZtgUNZeQ3Qy8rSUX4fYDPiER?=
 =?us-ascii?Q?CYeNuXJDPlNGC51KI1kPgjiwDLUa8xnBQdEbgFV9aYMtyYNeFKk+jDMASKQT?=
 =?us-ascii?Q?VDee2BxTe6UNpfmoDPQHB5YXPO78rUq7BbYhpB429Q7Chw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cfc367-e762-423d-74ae-08d8ed5dd2c2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 18:10:49.9234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SMTuqX/jy8o9cbdGROth4Ro4C9TTLML9bVxd2Ri/aMIIMTv7P3PuOYRefOzRCbv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2936
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_10:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 10:42:23AM -0700, Mike Kravetz wrote:
> Cc: Roman, Christoph
> 
> On 3/22/21 1:41 AM, Peter Zijlstra wrote:
> > On Fri, Mar 19, 2021 at 03:42:08PM -0700, Mike Kravetz wrote:
> >> The locks acquired in free_huge_page are irq safe.  However, in certain
> >> circumstances the routine update_and_free_page could sleep.  Since
> >> free_huge_page can be called from any context, it can not sleep.
> >>
> >> Use a waitqueue to defer freeing of pages if the operation may sleep.  A
> >> new routine update_and_free_page_no_sleep provides this functionality
> >> and is only called from free_huge_page.
> >>
> >> Note that any 'pages' sent to the workqueue for deferred freeing have
> >> already been removed from the hugetlb subsystem.  What is actually
> >> deferred is returning those base pages to the low level allocator.
> > 
> > So maybe I'm stupid, but why do you need that work in hugetlb? Afaict it
> > should be in cma_release().
> 
> My thinking (which could be totally wrong) is that cma_release makes no
> claims about calling context.  From the code, it is pretty clear that it
> can only be called from task context with no locks held.  Although,
> there could be code incorrectly calling it today hugetlb does.  Since
> hugetlb is the only code with this new requirement, it should do the
> work.
> 
> Wait!!!  That made me remember something.
> Roman had code to create a non-blocking version of cma_release().
> https://lore.kernel.org/linux-mm/20201022225308.2927890-1-guro@fb.com/
> 
> There were no objections, and Christoph even thought there may be
> problems with callers of dma_free_contiguous.
> 
> Perhaps, we should just move forward with Roman's patches to create
> cma_release_nowait() and avoid this workqueue stuff?

Sounds good to me. If it's the preferred path, I can rebase and resend
those patches (they been carried for some time by Zi Yan for his 1GB THP work,
but they are completely independent).

Thanks!


> -- 
> Mike Kravetz
