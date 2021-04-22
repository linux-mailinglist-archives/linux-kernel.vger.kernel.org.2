Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5495D3676A4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 02:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbhDVA6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 20:58:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47664 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230338AbhDVA6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:58:38 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13M0tIZT032115;
        Wed, 21 Apr 2021 17:57:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=UWTKJEIQ4e1pAOleEA+Gua54/4Bw0OzMNP5R1IdiQMg=;
 b=lw/Zs0dvtKn3U2ww8+iOZocP4rEgo7zHgXGMFnMPTSY1tYsZAT9yyAgd1RmDJ7uzNfFB
 5hOkV/yrq20iCEbhvtFs8x2/5w1K583fhTVonsZEYL5Er5OwfIMC9Yy9aT21MyuAq/HM
 Nu9RKnZymULUwR7LkJbHoS63WdIkTaGNooE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 382k2uvynh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Apr 2021 17:57:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Apr 2021 17:57:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAYyiH94lkOYFVtbpVk7pni01U7N47zWsGSO/YsRpb03a5g4w8FczeikKcmh9WKYNpkE7i/++44tZl9/2KMx/MbwMXiysAv2k0WKWPWpuqTv3FnkrGaamfX4kmuDXY0fjsxv2GtyuaESHOTTJmcJXoF1owXxGjBB/u19Z9A95f9MIWk67Z+vIe00JQiiShxqy0wAOjhFi++a5kqFF/h8tG6d0mxj8FRbppaqIjMjKwE/zHOXCY8MbXsZncXYthvSIcgMb1/EUx7+m4wKUP9Y6+R1sXzJf8McGen2OdKvmyZ8Ut4x3Ycosi22R/0jvHB4FguBycR7OfETLUAgONzgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWTKJEIQ4e1pAOleEA+Gua54/4Bw0OzMNP5R1IdiQMg=;
 b=SFWwFwkf+W0UufP931fCRFf+rM6M4j24pAYaxxMfW/B9XHx3l9QdHdoJlDay3XKY14R0zUJNTROgBe77dAb9lOsw9B9UVAe5nwUGYBnA076MdDAhZZARAVwND/9GpCibqvazm3uBruE4P+Wol+4VGrj0QRFlSn46yJBfYsgrHoKs/pZmHPIMy71q18WmbEAS/jK8BmCJiF5TO5Zke6PuHpgJBUBAku5r9icEfgg92G+wCQ70rw030sEc52as1yMrGHyBWK4scyJUMPSh35mypOTzt0bWHXLyz1Syj7ZPLiDBw2tuSTr7b1MQWF8OnltD3z6xBpQGC89RcPn6tTdMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4645.namprd15.prod.outlook.com (2603:10b6:a03:37a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 22 Apr
 2021 00:57:54 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 00:57:54 +0000
Date:   Wed, 21 Apr 2021 17:57:49 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix root_mem_cgroup
 charging
Message-ID: <YIDKDQxOq8IK82Rt@carbon.dhcp.thefacebook.com>
References: <20210421062644.68331-1-songmuchun@bytedance.com>
 <YH/Vf8SDRy7VR7ur@dhcp22.suse.cz>
 <CAMZfGtVpz1FvzmhWFzXAJE3wWBMJwdwU+JqQ6a8KeOhV3FGJ4Q@mail.gmail.com>
 <YIAimEdqpen3/38Z@dhcp22.suse.cz>
 <CAMZfGtUOXyK3RDZ+P0GaO4p-P0XatFB8ZbmXEFvfet1HSrdFog@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMZfGtUOXyK3RDZ+P0GaO4p-P0XatFB8ZbmXEFvfet1HSrdFog@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:30a9]
X-ClientProxiedBy: MWHPR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:300:13d::25) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:30a9) by MWHPR20CA0015.namprd20.prod.outlook.com (2603:10b6:300:13d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 00:57:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e962e814-e269-4649-114d-08d90529a985
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4645:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB46456A0F30365F30A18727C3BE469@SJ0PR15MB4645.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2LzZp7EYFmkfXet7F4JR4UO83EFXgUwJeTH93CeoA6d0/NNIGhHGI1P8LJvHdQTYaPnLIEwLdrKpg8XeauObZGyhcfmUjQ55E3qcNAr/h6CyzvlEoeyHffP0pGRi0PwyaQaNofqC61iNx3gheNi4CdgdyUyoQuRFf62FEDBmSfv4phCsYgUb/U9zQ8Mgd3zURBKsNKp40bEg3OOr8iPOQUNssQ3iYs8vSlaHepsme/RSn+Kl2Yx+b39H1WsiwDdyYFlZ/NUbgxkh98cX+huKmcqGkXszx8kHklqnZfh9Za49Ae3bFdrC4BBGSwo6BCwRKZzGW+5lG2/a0aINhdNDsZEOcP89y5La3rO48cGS1qUMNyM+m4zYPsHqAY+kalWOM6dGYF3PzjVRcM77Yf/FH1QCNqf7X1LzMpMbxZ0yZyzXE3OOD6QgPCXAoTeZbTwjAUSaVn2BW0hbaLtblsUVwBizgDQfmMvtKOqWt+37A/E9dILkSpDeOSpCUD/08STQjsmGBuR7JnflW4sLyGA/3Sjgr896lqd0sPXdWcdKKDdmZ+KgeUuUmVwWPu7mJHLthN5bKDb2touCGYF1+Gg05DvHQUV5/WzQkA7KPBFOmrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(39860400002)(396003)(346002)(86362001)(9686003)(7416002)(316002)(6916009)(66946007)(6666004)(54906003)(16526019)(2906002)(6506007)(4326008)(478600001)(8936002)(7696005)(66476007)(5660300002)(38100700002)(186003)(55016002)(8676002)(52116002)(53546011)(83380400001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wmn2kjlcSr+ybUL1OWqu1eEr34I3w1EEjQkwx+0G2gYed4WCZ7u37RkAqgSY?=
 =?us-ascii?Q?K6BNZxLklA0UTTXiDeL9y3liP0Oitk2kMmNQLcU26S8U4a9AUNMstd1PjJ+8?=
 =?us-ascii?Q?CddijmOtpMlW0AwPzGpUm2T4GPu0KYqQVxsBnWLqdfAjaLIHAWLnDhP7sKgg?=
 =?us-ascii?Q?DvzHFVEV7WIjmeN19nhGTW9zNkyN+OjkNovUj7ejrJa++VFBGxG4Rt0D11tk?=
 =?us-ascii?Q?Q7Dcw8ZNUsNeBpyJi5neW1b9p95VlPVAP2OU3t529O66jxD23vCfYr/b/owx?=
 =?us-ascii?Q?7ikS2GLaRfHnyoH4iqpV6U9oPRkFJT6R5L2K9U/9F/hBcvRyS7WrWUCORtFY?=
 =?us-ascii?Q?Mno14YttUPBk995nOaLlIUU9+J+xGEvSwE0Z5WzhPu4lSYbiT98JpJT3VUzR?=
 =?us-ascii?Q?b/p6i53PieALSdDSomE0Ryp12kARLiUmCakcw45pLHhcUWM22oUC1d167VuV?=
 =?us-ascii?Q?I+Nqcr+sQ7ZWzxyt/UXS4q/iWog8Z4+bibi5ZTMhvKXLGFyabLMtmr1n0+uH?=
 =?us-ascii?Q?POIn6V0MFYrzYfdoKiGQnr/EAuLTwdBi44yY+2LciZrNpejMO6VKSleMNBuN?=
 =?us-ascii?Q?MYBBY6JbeX0xGwyc2tY4cotfBJDU/8+r2fA2hnCqvv5MOxul79nPC/p48iQV?=
 =?us-ascii?Q?1Xa9wcRaUJqUkNNzlctZXRKlr8pljXbzSMVpoJH1ZvGA1LVIRG4usxEFxMfk?=
 =?us-ascii?Q?phIW7WW6wKsILAMjNuvNR6wG7Qer5gHXxJmPQUao7Nt2HyGFm4inK4MQGs2i?=
 =?us-ascii?Q?J63mFnaBKGsvL9lSWXEg9KPmpN6fb1oMCSYMUiF1/3dAp9iNT181ilxR1k7U?=
 =?us-ascii?Q?bQ/LvRimCLj1tFs6EPto7lP+k2CnrLnFoYRvhHpfFQEQvJyDwKTWrUVJFBYe?=
 =?us-ascii?Q?QRgaVdrvOn4kYX/U+Bbt1Wph2yxdmhKbAKsYLEePEMPbtbwu3hORXRefuR6B?=
 =?us-ascii?Q?O29qrYI93RB7G135zwBjaWB0tRqxaAoypeBmOPlqDtCl/5k7IMHTWaZv4yCW?=
 =?us-ascii?Q?cFHh44mf1hiJltexbbGiWE7qHViAL1B8wiuS3Xz+Im82z+Qpne9c2XeJr+Wt?=
 =?us-ascii?Q?hpUCI7FM+DKtDEvYhnFu7y1Ttbqw2UZfgVnHFzW4Fd2ZXNtrQSK/IKDAuYor?=
 =?us-ascii?Q?0OlDWXFHmXpYTwpBe5thx+FVNKJtR4Fz//ViHjZjlRjsyPmHYSmS1ap9mYuZ?=
 =?us-ascii?Q?/mnevmUIE9L5sJCcP/93xKRX963LRBRntwfMrd/ntHhIgtjBzEUIMTYunzp+?=
 =?us-ascii?Q?7ifuRyYbsl5TkzH3AZjk/KMFEi7Q1Ap9KtoA0acpucYZIZDqwCfAfxbjotZC?=
 =?us-ascii?Q?QdcWyNNxFDPrKvfcKfX6xggoHyLhfMciCJrpUfaJ5Zgfwg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e962e814-e269-4649-114d-08d90529a985
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 00:57:54.8142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YagtKgcWkJuhIG6s/OobsjZpb7ixSofi5DTiHWm00e7SGkZyLO48dDUN6UhTTNr6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4645
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: XbVQZoyKw1lyXdZHCzo3XCzhRm6EfToX
X-Proofpoint-GUID: XbVQZoyKw1lyXdZHCzo3XCzhRm6EfToX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_08:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=854 lowpriorityscore=0
 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220007
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 09:39:03PM +0800, Muchun Song wrote:
> On Wed, Apr 21, 2021 at 9:03 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 21-04-21 17:50:06, Muchun Song wrote:
> > > On Wed, Apr 21, 2021 at 3:34 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Wed 21-04-21 14:26:44, Muchun Song wrote:
> > > > > The below scenario can cause the page counters of the root_mem_cgroup
> > > > > to be out of balance.
> > > > >
> > > > > CPU0:                                   CPU1:
> > > > >
> > > > > objcg = get_obj_cgroup_from_current()
> > > > > obj_cgroup_charge_pages(objcg)
> > > > >                                         memcg_reparent_objcgs()
> > > > >                                             // reparent to root_mem_cgroup
> > > > >                                             WRITE_ONCE(iter->memcg, parent)
> > > > >     // memcg == root_mem_cgroup
> > > > >     memcg = get_mem_cgroup_from_objcg(objcg)
> > > > >     // do not charge to the root_mem_cgroup
> > > > >     try_charge(memcg)
> > > > >
> > > > > obj_cgroup_uncharge_pages(objcg)
> > > > >     memcg = get_mem_cgroup_from_objcg(objcg)
> > > > >     // uncharge from the root_mem_cgroup
> > > > >     page_counter_uncharge(&memcg->memory)
> > > > >
> > > > > This can cause the page counter to be less than the actual value,
> > > > > Although we do not display the value (mem_cgroup_usage) so there
> > > > > shouldn't be any actual problem, but there is a WARN_ON_ONCE in
> > > > > the page_counter_cancel(). Who knows if it will trigger? So it
> > > > > is better to fix it.
> > > >
> > > > The changelog doesn't explain the fix and why you have chosen to charge
> > > > kmem objects to root memcg and left all other try_charge users intact.
> > >
> > > The object cgroup is special (because the page can reparent). Only the
> > > user of objcg APIs should be fixed.
> > >
> > > > The reason is likely that those are not reparented now but that just
> > > > adds an inconsistency.
> > > >
> > > > Is there any reason you haven't simply matched obj_cgroup_uncharge_pages
> > > > to check for the root memcg and bail out early?
> > >
> > > Because obj_cgroup_uncharge_pages() uncharges pages from the
> > > root memcg unconditionally. Why? Because some pages can be
> > > reparented to root memcg, in order to ensure the correctness of
> > > page counter of root memcg. We have to uncharge pages from
> > > root memcg. So we do not check whether the page belongs to
> > > the root memcg when it uncharges.
> >
> > I am not sure I follow. Let me ask differently. Wouldn't you
> > achieve the same if you simply didn't uncharge root memcg in
> > obj_cgroup_charge_pages?
> 
> I'm afraid not. Some pages should uncharge root memcg, some
> pages should not uncharge root memcg. But all those pages belong
> to the root memcg. We cannot distinguish between the two.
> 
> I believe Roman is very familiar with this mechanism (objcg APIs).
> 
> Hi Roman,
> 
> Any thoughts on this?

First, unfortunately we do export the root's counter on cgroup v1:
/sys/fs/cgroup/memory/memory.kmem.usage_in_bytes
But we don't ignore these counters for the root mem cgroup, so there
are no bugs here. (Otherwise, please, reproduce it). So it's all about
the potential warning in page_counter_cancel().

The patch looks technically correct to me. Not sure about __try_charge()
naming, we never use "__" prefix to do something with the root_mem_cgroup.

The commit message should be more clear and mention the following:
get_obj_cgroup_from_current() never returns a root_mem_cgroup's objcg,
so we never explicitly charge the root_mem_cgroup. And it's not
going to change.
It's all about a race when we got an obj_cgroup pointing at some non-root
memcg, but before we were able to charge it, the cgroup was gone, objcg was
reparented to the root and so we're skipping the charging. Then we store the
objcg pointer and later use to uncharge the root_mem_cgroup.

But honestly I'm not sure the problem is worth the time spent on the fix
and the discussion. It's a small race and it's generally hard to trigger
a kernel allocation racing with a cgroup deletion and then you need *a lot*
of such races and then maybe there will be a single warning printed without
*any* other consequences.

Thanks!
