Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E532334DD5C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhC3BOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:14:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28614 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229709AbhC3BOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:14:23 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12U15dI6018003;
        Mon, 29 Mar 2021 18:13:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=SpG0bbPWQl5ZzMZWcj82/nA+RfzDoCZVI0zq6MpRpEo=;
 b=lYql2egTdvVxUCMpC1GqulNkvDif8mlIUwfMLEL0etDG6QuXhteVPWJYExyLhHVSL4VL
 0ALyd9EnJqBEnF6gUrQBgtFtlQjlxTy66k36fcb3pzerzl4FWxYOmsRazeg5TSMjETYn
 dFfEZVkrTwBEdTod0YZFXSc94dvv4hHQcSo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37khfy39uf-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Mar 2021 18:13:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 18:13:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EliN5xsv/2C79ICO4IDi+xD7BRYoNnLWdbBhmY657VdST25R1MZHTtYS10+EZwOIFx5wAn5+JTkj7uhMEVq2m939lqDPsNvQlWrG1rOICO0mcEGsmvymCiRXEPs6CY2UqUhe04LyNQoCC0q+ll4sMNFV1JcbE3nmKSG6CxQ0Ehda06QEznpPVXe54Sq41OK8CEl+5GgWQOitw+dPAONVJMLbrouGqym2J9zry4vOknReqyIo9gTR9oHIFcwc+omkfrrnzv/NVadBl5UqEeGoR4TGZSeiIJleN9CHivbKbe0FQ1mL8grhxtZBZmC7uOTVCWWv/USrr33Hh4WxqDOdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpG0bbPWQl5ZzMZWcj82/nA+RfzDoCZVI0zq6MpRpEo=;
 b=DOZJlB8mo78pwdBDCaLY3yrveCVRJqmARhxyqV2u9o0vN6Nmvc18bYMj+hccLo3yTYU1Y0WJTm4TMdCUO1T5SnLt4oWZ+HExu7yeEwl6IdDN/DGvDZjyHqhyLckO7ywtMYewjQS6RZ6y0188xX/1+05bv23dx0Ary+dge935ZFrovCK/IIMPyS8UxEwQv66nPNgc1qSsxEpYFsJz4KrPwga2FTYH4poIvbUTetDgmtF1DQCkRHEPLF3aouO4aEatD1+cOQ/dx1rjfpkCgDUEiyo8YIDbyjv9oqqe7pY9kggSQvmI8nILPdqkwSWM4RYeQFxaT44p/MTM7m0vLTST2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2710.namprd15.prod.outlook.com (2603:10b6:a03:153::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 01:13:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 01:13:24 +0000
Date:   Mon, 29 Mar 2021 18:13:21 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/8] hugetlb: no need to drop hugetlb_lock to call
 cma_release
Message-ID: <YGJ7MZsmunBtG7pt@carbon.dhcp.thefacebook.com>
References: <20210329232402.575396-1-mike.kravetz@oracle.com>
 <20210329232402.575396-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210329232402.575396-3-mike.kravetz@oracle.com>
X-Originating-IP: [2620:10d:c090:400::5:8010]
X-ClientProxiedBy: BY3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:254::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:8010) by BY3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:254::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend Transport; Tue, 30 Mar 2021 01:13:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14b72e68-2570-43b7-468b-08d8f319040f
X-MS-TrafficTypeDiagnostic: BYAPR15MB2710:
X-Microsoft-Antispam-PRVS: <BYAPR15MB271039C4A8570F1B96B7228FBE7D9@BYAPR15MB2710.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jNDedCzFb1JlJ3AU2w4vk4sJxDmjvJ2lf3mt+4SZwv09hVPUeCh4wg3LhRCMfuY0wWKDFvMqS8+KVq9J8kqxwVfOb9q/EElNsPgfTHkcsB5Dyu+SLxCfMukOZwuKN9zp3FIx/p4n7LU6vpEHHtUreXlbkFiBG90puu5elqSOsrCs23Al/vkZoMNgap/XXXJ6dBFEXWgiaufbkI1ko4DkuZWwUvg092qbdU60BhSEdIo9DfMG32jwtVhZ1TfhdUBLIjPV82nCYJQsA1sG69dItxDlmvdCtaEgxXsnAU2d3H+tVVCIHrkJFONHHJMj9pD4CZnR04ze6FXH9m9sA4IiZEO6SucKfRwlwOCeMcElCDOPqF40s1WDmusgKcUXUNpUXQG4IJ87IDX1geP6rr+oD6Y7TUghpFNXPfPPZOHzle58D9msWD3B44ePY5+NIZuWAUbJa8BVlN12f/XutJDxZRCVeOEggTur9T3zfDEPwI6A73u+EXkFwLieoP1qFBsdh8Ad0rZTx2yJRPmllbvsiYu0454LzpCvZi3TxfKs1T3FpTjMk+es5C/TaTMH3A51HMqInXLDoVov5WteAqCg/EGozsoteOAceXdLz/iSnZwr/klcZ0bvuYPiUOmsXzviU711RfntDl4F0pmb9UyoqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39860400002)(83380400001)(316002)(5660300002)(6506007)(7416002)(16526019)(38100700001)(54906003)(66556008)(86362001)(7696005)(186003)(52116002)(8676002)(9686003)(478600001)(8936002)(55016002)(66946007)(4326008)(2906002)(66476007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MP7vvMTrsIRZgDQ8XkGQqXW5LbscoKfQY/Yt0sLBASKGlsmxt80U3QlwHo8f?=
 =?us-ascii?Q?MgiNQke6+EYYzSGgK0ltRBLeJXJBm0raRBjZjyPkPsDczL+LyF2znABs6XsQ?=
 =?us-ascii?Q?raOrveWs9EE/8PSEkjBRdcxg2JXu/GiEOyS+o/2BIpt+D1jQabfdROSBo5qA?=
 =?us-ascii?Q?zUqWbTL6JfO40fR2oU1JDOGnn3OOuwSB6xF+AvLRwSgWPwFZItvbWb+8Ozx9?=
 =?us-ascii?Q?s2almyngaDg/aYInFh+s0wEDkokqvlyL9UD92JW6wnfSSYI7kM1pF3+mKMc6?=
 =?us-ascii?Q?P1qvXMIRw4vklwk4QyGC5HOsJEdDA+jRMk5q1eqtcqXz7lT62kXChpcENlo3?=
 =?us-ascii?Q?2BZLE3tM4JVx1uGHi9w5DPjvKZFQ09SoCEOdyhb8umvTpF9Gf1upqZXFnXz2?=
 =?us-ascii?Q?NDQDlvoUNGwx4DTF02KfJ31E7ErXfpi1AL9TKZtUI8U/4DMYNWruvgQUYhFy?=
 =?us-ascii?Q?VQFTTkZTgZ8EO0gocSTZAOoG+iK7KvDwEw5WpM1nnPULnuknmqz4nBwC7PBY?=
 =?us-ascii?Q?wGJ3AvLDlotVp4Jhjoo7l5fB1nXLEEn6dtfWNx9YJT0IGIvhQDr9SyfDvB4M?=
 =?us-ascii?Q?awlIWn7x3mdAG8QQ82P72vmOp6lvd+zLDWtAmHkToJ+sv2VFJdCkTTLZdttf?=
 =?us-ascii?Q?8Ue9w5LHq530SM+Wa3r7LiPlh7xHdFXqVRJd7zy2115PAgBRp1T1Wd2Di292?=
 =?us-ascii?Q?/TJarwPkhCOPcakMpaHh7dbOM/b9014NCDjvM8f5zuGbuD76+8G2fqRt7MRT?=
 =?us-ascii?Q?RTnQCAp9ftTADXnAuRehyygJFftAUO+uiaiElMbezH5zeG0P3mPaSpLCGPXy?=
 =?us-ascii?Q?DL5lGaxn8wojqTU/OtU+t6uF9SQU0PAZKIxWRwHxfJWS6vRObSBlJ1kdzfLI?=
 =?us-ascii?Q?qlDmdjftcCdbyqIe1pEJr+lK8r3D1bZbjq79PFPhbw4dBA0m//ZRGyypIh38?=
 =?us-ascii?Q?HT8IedmcjWoh7AKbNdTRcgB9hv1nN5HafzR0N/zWSPK5IMudbFD/dglp7p0E?=
 =?us-ascii?Q?ApTESZarBeNMtP4NPAct2N7a2wnQNqOrsPyC1ElS0iHym28mnRoXgjVE/47x?=
 =?us-ascii?Q?XmbBOrnHVgMTtAzem/wH7DMEHW5cYfc6wIBqUIc7vdhKbh7bbJZJgNBZ6LRH?=
 =?us-ascii?Q?fbRKQsKqkZ/V1/r6qRUHr5NpIIPeP5D5gM5Gl9PzNmvHEEGlyyIw0rUfwqMG?=
 =?us-ascii?Q?HD889u4Cb7zDhK1Wcy7fyVQqkDovGxhgyWUOn1i8jROMbsh7mYwrUnZ4pKlK?=
 =?us-ascii?Q?MwR/kk31+UkyBjWRDWYRDyIb0tfvdPPRN0LNFON4kQ6QoelvzVqBOfKih+aj?=
 =?us-ascii?Q?iFismjaoFnqMeW/WfC979qv0WZ8cHozB2iq5JdbsRNnpoA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b72e68-2570-43b7-468b-08d8f319040f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 01:13:24.2803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUW/MdMWuONWIMBlOqvcGwBQzJv7b1XLwLNbVfSquSPatZRTG59S1Ne/8SJDbKzB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2710
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: W1ZR73SvQAAn_eUoFSEHZ6waFYyaO-TG
X-Proofpoint-ORIG-GUID: W1ZR73SvQAAn_eUoFSEHZ6waFYyaO-TG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_16:2021-03-26,2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 04:23:56PM -0700, Mike Kravetz wrote:
> Now that cma_release is non-blocking and irq safe, there is no need to
> drop hugetlb_lock before calling.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3c3e4baa4156..1d62f0492e7b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1353,14 +1353,8 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>  	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
>  	set_page_refcounted(page);
>  	if (hstate_is_gigantic(h)) {
> -		/*
> -		 * Temporarily drop the hugetlb_lock, because
> -		 * we might block in free_gigantic_page().
> -		 */
> -		spin_unlock(&hugetlb_lock);
>  		destroy_compound_gigantic_page(page, huge_page_order(h));
>  		free_gigantic_page(page, huge_page_order(h));
> -		spin_lock(&hugetlb_lock);
>  	} else {
>  		__free_pages(page, huge_page_order(h));
>  	}
> -- 
> 2.30.2
> 

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
