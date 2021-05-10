Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15B63793C1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhEJQ3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:29:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41666 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230300AbhEJQ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:29:44 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14AGBF8o016388;
        Mon, 10 May 2021 09:28:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=hKKGfXkKfOjkn/OlYQyfLhvrjL+WVCDleCgXTMKlK3o=;
 b=AFTveCbIaAGEWDWVD/A+pUCqr44L5hfnlpHS3xf4f9fCM8VSpqGCsy74IYglypHAjGCA
 EXvMlsmvBqNX1/zx9vJiNhstxSUs5qEoqAQLiGnxbPnULnPMiLbTfk30CBjcrfmSLGjC
 1YzgKrzKZZSNhp12ldF4HlmOaxmfHZMWrbU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38eafxx6k5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 May 2021 09:28:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 09:28:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaxKbZnBC2HFSly0ftbWRrh8SwF1HA61izuIjWT5sDNY0wbIvYGhSo0LvUPxQCW8RR4OlD+yGP7dqSP9dpVCA7hapIK/NCWXYv6mckHI6Z54MleOF9zKqImpDZam9fNLei0zpMvgrihHGYzqUsc0aawVKbEH+CetfN/A81O0MhfXuiUwxrFdnkkm5gqJ/NMgHaI35m6RtkOuP9pKH0lOU15DCq8cyx5nqXha4hIdIRrmQca6/rGSp9gHwUSgL95IsB/yeXBmLgr1Ogiynfw2YMl8JYUkwmJwV4WQZrfwbu6ynp+nXo975XEqdm+KqgjMYXZNW1vmIgu4lM5M3jxS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKKGfXkKfOjkn/OlYQyfLhvrjL+WVCDleCgXTMKlK3o=;
 b=DED3TegB5f608yxBVQtvdirNLxH2M3MUvzKMnHX7Q6gB8mDI1SW6kkhH4VEXTketc6xFEWHN59AH7MkiGBpavr/SsqI7wdMlCgbUQr23CDlqLeBkDwsizuiQOXfudA3FY8NYTf0p9uoiJrfVLp/9w6qnv0YnF9g8IgT/25BXacRcD3S/xIxzPElU5Ni5xc6S5OCEnYb1Z9Rcv6EFk8KyhnsKp+ipypEVRD5lyV8h+J0dUCSMy385Wt7TNhogUyXl5/C/9yYu1Hwh3e3ywJgkgRIUQ0GopC0ljbpb6KBUz8aj6F7cQfLREFfwqbEUW4AEQL2auspL79lbthDQCdZa8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2341.namprd15.prod.outlook.com (2603:10b6:a02:81::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 16:28:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:28:24 +0000
Date:   Mon, 10 May 2021 09:28:14 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Muchun Song <songmuchun@bytedance.com>, <hannes@cmpxchg.org>,
        <mhocko@kernel.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>, <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2] mm: memcontrol: fix root_mem_cgroup charging
Message-ID: <YJlfHt8vmKURDX5z@carbon.DHCP.thefacebook.com>
References: <20210425075410.19255-1-songmuchun@bytedance.com>
 <20210509175403.ec3f33f293ed69f2a9b275a6@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210509175403.ec3f33f293ed69f2a9b275a6@linux-foundation.org>
X-Originating-IP: [2620:10d:c090:400::5:5930]
X-ClientProxiedBy: MW4PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:303:b7::28) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:5930) by MW4PR03CA0113.namprd03.prod.outlook.com (2603:10b6:303:b7::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 16:28:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 986fd2a2-8a20-4362-1c1f-08d913d0a222
X-MS-TrafficTypeDiagnostic: BYAPR15MB2341:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2341000301DB6815504F6D5ABE549@BYAPR15MB2341.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHiY39poUd9czDkdyQnwA0TjMcvQIVZXJvXKCQFiXhvSUmmbced5ORMA9GCAHwrDezxeF+x4pgZIPanKd6ENO/KyLE54VHzCQaB+3CB1jVcVh5R8oQI+cDrHD+8o+m+2itSKo/4AIWsgeIOi+CptMXLp/JuKNFLCCHGFv9MIsZ9And4Xfqvut4+3Nle1PIDefaA/CwdjkkE0Uz9cHNdrB6g0srxvslhKpJyQvCLaeuLvL2TLFm/NIyxNDoBKw1nOzriSFy7rpjpLD/o17QGRPJLVZ3ThZNZte4AXEL5GwgJcRTy1gu3brDVYDEnHJV+UV57ZraA33z7Bxi+evUlz8QP4cS4aAcC5pp24Bgak8tTvL9epkY5yWqT3yFQYHyj8Y/WejJYgkC0oylpAqx7b+TkHAZ35HPzG+SzqhHnfQOMyeT92CBLSPf8PVu+/MTON7E0DWcRBPcBFNN4mnTCHjRcIXUqxLP6nuz1HUdAeLlFXZ4qwNEiMHv8V08h018+hZsR6MVsJN+NRQuWLEgDus8vH2P2of/pwneUOrCo/jUYnL8w7rSeeQIKyk6q8QncMVv8cX2+zspn8Y5RvXfG+aKAzqEg26aM0KIeIsMJW5a4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(316002)(86362001)(66946007)(8936002)(8676002)(478600001)(5660300002)(186003)(16526019)(6666004)(4326008)(6916009)(66476007)(38100700002)(6506007)(2906002)(66556008)(7696005)(9686003)(55016002)(52116002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?J7s7oIsN4+eZRPIDL5JWIRgAfaywspDBrw6XCr06fFtkMhfBmeiVtq3vJxfg?=
 =?us-ascii?Q?8ECykh4CTwn9OmJfZIAw401ZKLfLu2LbWxjHSS4JhXbIcqJg/v7G+3GPDB0m?=
 =?us-ascii?Q?e3kknYeFRQ4QLQhk7u4j6s9Xh/7xgQSOu868eslgbjhP5WRywxNjf7RrDcMI?=
 =?us-ascii?Q?9K61iJJd5GOh7tei7++Kb5sG0qU0IGGFEGYo+lMo195ABz5ylIpZ3zcFy9bg?=
 =?us-ascii?Q?2RodOhVAQFOsUgfWdzXZILtZS4C16sykx4GrbqaPaB71/iUFznHxNJZMfUMN?=
 =?us-ascii?Q?Bfh5nGE2uaiIBLDBg4Ov0odk28wWGtB7D1PU52BkEgw/MB+ToiNP1XrFOjam?=
 =?us-ascii?Q?KWV0LkSPtk2sGAAhqM39GOTAtJGkCL/6iJrWd1XdSVkuSPrRsrIgMCopMLJj?=
 =?us-ascii?Q?1D7y61FYD9xJPg2FCHoy68Hdr11h6vkqAfXq2VnmQAN7is7+Qmo02QrhAdC+?=
 =?us-ascii?Q?DAJrF2cWO2+lWJL7fzUhSfQj+gOhlTKdHtE1wGc7OD5DW/Che7/i6tDBQ4ea?=
 =?us-ascii?Q?ElXv/sbKpCxfg+Z/mRwvwZRc6dhBitKj3UQkdkrsyV/aRLbCeAc4MKDC90pQ?=
 =?us-ascii?Q?PSdv9QQ44rAE87hRIS03I3Z0LDoCtpbLUFJDq1JWY8y1Toczae61aFZVtezm?=
 =?us-ascii?Q?29lnWAmS3sDBJmTzYdeqqEg7yDa2pz9TAZ06YqHfF6SF6qKaDA/qpElYt/X/?=
 =?us-ascii?Q?D/97m3MUs/ApJYUz9S7suPFGOlbF8IfJbfKEMzxM+x3ltp8vzzdp1HLRNDim?=
 =?us-ascii?Q?wWVuLCdkmF/lJkdh0eJh2SjRjvh8jg8asKSt6dWwAyOy1aqUveKkrobdMN2X?=
 =?us-ascii?Q?0MOUnml1kVWCojicT2gzkuK7n2XjiS7Ac72Nt1HKD5qrpyQsc0QX5UHRBZAD?=
 =?us-ascii?Q?50frVN8ZJRrJX5umfAQU/mVviEeFmlY2UDIURIhGaFvc5TNW7554NSTXE4qS?=
 =?us-ascii?Q?7deHg0kCKKd00ItgIc0QmQb7QF74FIAVVnJLUl7blZSigkdThKHNBbfu9Yqk?=
 =?us-ascii?Q?cH1mP9btqOJXBao00ggpTDuNfVXSBHjHrCEodeC8tEUHtS1iYWaAQ189jBkl?=
 =?us-ascii?Q?fJkvFnB/JvF5eQ1C7/8W49zU0xDIA416S2gGqsKQOmmpFXNaCu2AS0Jv/nHc?=
 =?us-ascii?Q?vIsnpLWVQwhAWyc8vKIXEmhTj2DPrafLbrMQqNBDCvCb+uF87myKkhas2fEW?=
 =?us-ascii?Q?xEMFGaJ/JbeN0S9Za9e8A/oA5/36ZTjLRJFkpgJfKom1Ov1bKyXVxSi+n4BN?=
 =?us-ascii?Q?N4LmlLjHhIwN6JX1b7rtIROZABCLgOkFATOhdCui/eYVUdeVwkPewKXMP4hi?=
 =?us-ascii?Q?3oV9T6dDnF6Aze2naeEFaDspySIqFAgFZo3TdroxO29G7Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 986fd2a2-8a20-4362-1c1f-08d913d0a222
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 16:28:24.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlfhfCtJuuMfiVOyNHqKYt0m7imk4b7lnjQMs+MVIRHvDSnpkiqnMZadjGcyyJ+a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2341
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 3ht2F5ML5Iv82asTWlYB-_YbzYF9sxYl
X-Proofpoint-ORIG-GUID: 3ht2F5ML5Iv82asTWlYB-_YbzYF9sxYl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_09:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 mlxlogscore=875 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2021 at 05:54:03PM -0700, Andrew Morton wrote:
> On Sun, 25 Apr 2021 15:54:10 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> 
> > The below scenario can cause the page counters of the root_mem_cgroup
> > to be out of balance.
> > 
> > CPU0:                                   CPU1:
> > 
> > objcg = get_obj_cgroup_from_current()
> > obj_cgroup_charge_pages(objcg)
> >                                         memcg_reparent_objcgs()
> >                                             // reparent to root_mem_cgroup
> >                                             WRITE_ONCE(iter->memcg, parent)
> >     // memcg == root_mem_cgroup
> >     memcg = get_mem_cgroup_from_objcg(objcg)
> >     // do not charge to the root_mem_cgroup
> >     try_charge(memcg)
> > 
> > obj_cgroup_uncharge_pages(objcg)
> >     memcg = get_mem_cgroup_from_objcg(objcg)
> >     // uncharge from the root_mem_cgroup
> >     refill_stock(memcg)
> >         drain_stock(memcg)
> >             page_counter_uncharge(&memcg->memory)
> > 
> > get_obj_cgroup_from_current() never returns a root_mem_cgroup's objcg,
> > so we never explicitly charge the root_mem_cgroup. And it's not
> > going to change. It's all about a race when we got an obj_cgroup
> > pointing at some non-root memcg, but before we were able to charge it,
> > the cgroup was gone, objcg was reparented to the root and so we're
> > skipping the charging. Then we store the objcg pointer and later use
> > to uncharge the root_mem_cgroup.
> > 
> > This can cause the page counter to be less than the actual value.
> > Although we do not display the value (mem_cgroup_usage) so there
> > shouldn't be any actual problem, but there is a WARN_ON_ONCE in
> > the page_counter_cancel(). Who knows if it will trigger? So it
> > is better to fix it.
> > 
> 
> It sounds like Roman will be acking this, but some additional reviewer
> attention would be helpful, please.
> 

The patch is technically correct, so I'm ok to ack it:
Acked-by: Roman Gushchin <guro@fb.com>

I remember Michal was looking into it, so he can probably add something here.

Thanks!
