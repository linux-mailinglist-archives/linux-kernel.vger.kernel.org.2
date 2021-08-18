Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD0F3EF9A8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 06:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbhHREp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 00:45:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24222 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229449AbhHREp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 00:45:26 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17I4f1E6012327;
        Tue, 17 Aug 2021 21:44:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Vac9PCbyGWiwR8M+mhIDMj38iuOJhLAgMFBQh+cq9gs=;
 b=Chx/TCySzOVvh4rVxb+j7lUjrP9FKhZgy69taihU3dQCe3UrdNxTSyxRBQ7vMvMKYJrB
 ozSh+gMAwozpDeuolBs1IyvPQO8TyEG/n6Xpl2GACdg6nuJmVzyL/dLJAg5yTU0LeOMC
 nt6XlkJT9NVdIljBjJO5kAyqFaAgJQEa0Jk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aga68eban-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Aug 2021 21:44:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 21:44:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCOo2ICaef7TtGyu8F32F0gpcQLYx8QZqCoPjZxBWF6LZnD197RLwfzq3epuHFWlJ7E+n33Ddea//IRAi1ZJl4c3cQOztBn69ZffIP/IyVLmZLHoTcO3+So8xaxfW45027ssnti28ZWsZzGW31wmOwj+kHXG/+m4auHnIoZ0LLngDY53qtcL4JtSrMKZJnbfZHXhClEeOY+OKB16MkoHoIkh+DWtw86Wr0AMbH37NF91cnQegp75YQrM7oyW9vQ/ENyFPdxPYnjMgPGdV5KWQxkQo3HnimRXYNBlwGRCLdAlFouKkysLkMrwr/LCsanQ0PBDFO/wgHm5nHqa4icGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vac9PCbyGWiwR8M+mhIDMj38iuOJhLAgMFBQh+cq9gs=;
 b=aItgioPkhC85xLScVOb44JCTnDG4uf65gZIehqK3Qo4vm69yeenPLm9tUJs90kgofupFcpc2kDvxCNyEYb37VUU/uarVkGmsjwY2lxa25vIUzHaKXvCT1/S28B+j6PppcBj112C7ydVqbkvjbsPbGdJQPB7V7R1jJDHWPDCTltxUFYS0C0oPWYtksZtsym5MBw0cNwnAky00Cpnz+5pyWpK4AVgprW/guJgGkkF5YC1izOfBYttZDufjdKf7ux+8xxjnaK+NZaerdvJ+tLOYEoEDSzU8LDQxnwrLl+JGmyMSbisz4WniD7Vi/hFh5AuKiSkdQ1VutqqcOeIUXo/+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2629.namprd15.prod.outlook.com (2603:10b6:a03:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Wed, 18 Aug
 2021 04:44:39 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::75be:c42b:c0d2:2565]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::75be:c42b:c0d2:2565%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 04:44:39 +0000
Date:   Tue, 17 Aug 2021 21:44:36 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: introduce PAGEFLAGS_MASK to replace ((1UL <<
 NR_PAGEFLAGS) - 1)
Message-ID: <YRyQNEc79Km6M9xc@carbon.dhcp.thefacebook.com>
References: <20210817033032.76089-1-songmuchun@bytedance.com>
 <YRxtZ3X8QGv/bui5@carbon.dhcp.thefacebook.com>
 <CAMZfGtV4LXDmv=Gyd5bKPy-V-3a4y3R62XGXnvZyeQ_xqCabJg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMZfGtV4LXDmv=Gyd5bKPy-V-3a4y3R62XGXnvZyeQ_xqCabJg@mail.gmail.com>
X-ClientProxiedBy: BY5PR17CA0044.namprd17.prod.outlook.com
 (2603:10b6:a03:167::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3eb) by BY5PR17CA0044.namprd17.prod.outlook.com (2603:10b6:a03:167::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 04:44:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aee97798-aa3d-445e-c869-08d96202e368
X-MS-TrafficTypeDiagnostic: BYAPR15MB2629:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2629CDEEB074D9350611FF3ABEFF9@BYAPR15MB2629.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChS+1Umah7HKfGBQJ5hks0JjfboyiloNfII/9JoVmcPwetr2ecS2Wqo4Ba15Wbe2WGHjCrQqQ2rGuInlcOFATBcjw2pov32PJLie1mgFHM+duqvegQCRM9PI2XoUMLoaNLH8KS9ePgj8bsIXp4hidI8B51JvwAPFwB+/ofkeI/c+eFzqgA/YxvZzlQMNmOo469Ks/OSisYHgbyCuGcTw6FKBKq0mkKjhpq8GvGpqGUq9BW5dHGE/jrVNY6U77IgbaYUObOK/3SehrqMm4OlMSBE6JdTCZ5eL2nnP5eg4FE1Qg7RGRDj8cY5lqxYlaT3ZXUxaxO1AlFcMWXHoywZwCTPwD3tG7kFWnhzbD5FAqDwxLNB/wdLPhZlHPcKtxLaHjI+Pf7yDaQhyyaIdGoaj6BMC4YWAOkMWA39a/hOH+LGzrtKvB7tjQ1ECCwO80orkq7YhdH34BVQ25E3l2plPnrA2SSPTH1YF0fJEKL5nDxHLrmb92DnL/e2/cVlf9nTwUfn1HYMnNHKsfKVvxeJHlvowA5fyRtuHl/diqb99/5Gl+ubyXjHXYlibj7b6ohcHFlRjbVKNNCxXRexSOgGWMZfyx2pYCuVQ77mSrsJnejGLUweaGtbUq8xa01sI055t0yD5pjrutbxe5ISaRsCC5Nw1cGgNPTe0WeKtVhYipbDVT8OElvlClKA4qWON4RB9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(86362001)(66476007)(83380400001)(55016002)(66946007)(2906002)(9686003)(54906003)(7696005)(52116002)(8676002)(4326008)(186003)(66556008)(8936002)(5660300002)(53546011)(6666004)(478600001)(6916009)(6506007)(38100700002)(316002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2WY7JclHcnVQPEg6cuPw9wZrFwrZwY2BdZNj2zzwkretkWvCwOB3RfjEwvMW?=
 =?us-ascii?Q?uL5WHX/8HxwSnXOjm734A1zYHRmvBZGDiXnQTSuP2l1vWjfetvUKaeldMzfZ?=
 =?us-ascii?Q?W4/Z+itYH1EyWsDeZuHMnVA0xTW/SfA0xicEUslAAt1h+qpSXCp4CR131Rne?=
 =?us-ascii?Q?yTht7+fWOJqWvKfI8dohce21tNASviD7OwgJ/obHIYaLtQYjFqPoBaPhCGzy?=
 =?us-ascii?Q?R5xQ022vWf1atBHjj0V0nhIfz70M/nG35tpDEm6jUKUB/MtAA1QYSfjFeOib?=
 =?us-ascii?Q?WJeBV6Awx6Z8ilxmAGxZhiEjBkcW9HTTyQ9o67N766jYxu24/0gRzpYq9apK?=
 =?us-ascii?Q?xxB5JuijJjN8e8fSs5z7IMdCd9fuUz7syVu/5vQruQ1VpIBawbNEdnNgO5S1?=
 =?us-ascii?Q?U96Ic5R6b3ZsStj95mZrsfVjhvVvRB8Q7eJgYSc6ItxOUtb4K0iCw5+4gF44?=
 =?us-ascii?Q?ImsWpGbr8GFT7o8nM8ictVHQKn/6yj3zonrAoMFFAHr+zY7cdthdQFv0hY6j?=
 =?us-ascii?Q?n3RMtZfbgg/vJdrLdvfPSpTWL315bbRSsyeWw8rhaviV2poVV9d/ZmR75YEg?=
 =?us-ascii?Q?Te0o42mCD9Xwc7bdFjLt2rwGTLmSxdRN6Hl8wJAOTKgPWIxRNzvpwVocWbqy?=
 =?us-ascii?Q?jeXwVrxKeRIhRLinNkE1H+PREWO8qBVTmFbU2ecSX08AVgFIst2gBr4p3A4s?=
 =?us-ascii?Q?Nq9t2kf234aAsDBLUQEjfbmUAdxZvHzj0qRvJKgdjb1ov5p8gq/qPwP2wXnv?=
 =?us-ascii?Q?bGH2JLY9yuNA4nJj6QpoTvniKcWVYZS5BDghtkKutrqOprStZJlk0DJO0QGj?=
 =?us-ascii?Q?0KZYiglc5Wr8o3KV03TMS+WCXGujY6EoqEwGN0lBblNE6gUK2GlBPb0Zfl4S?=
 =?us-ascii?Q?lk6a70hye5o5SYGoA9m25KgZLWtbVqVkPBJ76xtrWJAYs4L2ttcM+PnZJkf5?=
 =?us-ascii?Q?Pjo2/WAhbqHVpxyw3mU6zKbKcbroT3C3OOxy4APFXCDz+D0Z5hMLnnZhPgIW?=
 =?us-ascii?Q?hJIH1fFN+lqD7j19IGJVEcPq17dYv643h2581k8TBBdu76IZWVcGZdke3I4/?=
 =?us-ascii?Q?JeCJMbk80RQ1p56Cru3tM/ui15lFK/3WEU2Rz1BTg2Oi37SZTYTK3SwyOKYE?=
 =?us-ascii?Q?9iOUqJIwXOJfiW3wvTDRR3Y4U9f8pIla9lGzpaEiLgYTl83VmPwKKToAeBV5?=
 =?us-ascii?Q?WYxS1aIZ+m+L/CAnwTqahJ8OCetaGXk6xPTEsaCPT7tkJpZP9EaKurKUuMqL?=
 =?us-ascii?Q?0cMrxl0CuUvt+YygpPuYeVqFH8O18Wvv1TBKUVvU9dchKnqGpOx3VePJ4hZz?=
 =?us-ascii?Q?mNgGdyRSUyDroyH3BwqbFQF872fd8y2zD1LNs8ARH3shdQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aee97798-aa3d-445e-c869-08d96202e368
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 04:44:39.5446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6Q54Nn0otpeh4WWln36cpP6MIIfYXN3eltEdg7PBND3favY8OzUEQr0rG5mDLeD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2629
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: rZlHGlBH8qiqa5lObv3dvQAuVIZ0xMKW
X-Proofpoint-ORIG-GUID: rZlHGlBH8qiqa5lObv3dvQAuVIZ0xMKW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-18_01:2021-08-17,2021-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=996 priorityscore=1501
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108180028
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 12:35:08PM +0800, Muchun Song wrote:
> On Wed, Aug 18, 2021 at 10:16 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Tue, Aug 17, 2021 at 11:30:32AM +0800, Muchun Song wrote:
> > > Instead of hard-coding ((1UL << NR_PAGEFLAGS) - 1) everywhere, introducing
> > > PAGEFLAGS_MASK to make the code clear to get the page flags.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  include/linux/page-flags.h      | 4 +++-
> > >  include/trace/events/page_ref.h | 4 ++--
> > >  lib/test_printf.c               | 2 +-
> > >  lib/vsprintf.c                  | 2 +-
> > >  4 files changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > > index 54c4af35c628..1f951ac24a5e 100644
> > > --- a/include/linux/page-flags.h
> > > +++ b/include/linux/page-flags.h
> > > @@ -180,6 +180,8 @@ enum pageflags {
> > >       PG_reported = PG_uptodate,
> > >  };
> > >
> > > +#define PAGEFLAGS_MASK               (~((1UL << NR_PAGEFLAGS) - 1))
> >
> > Hm, isn't it better to invert it? Like
> > #define PAGEFLAGS_MASK          ((1UL << NR_PAGEFLAGS) - 1)
> >
> > It feels more usual and will simplify the rest of the patch.
> 
> Actually, I learned from PAGE_MASK. So I thought the macro
> like xxx_MASK should be the format of 0xff...ff00...00. I don't
> know if it is an unwritten rule. I can invert PAGEFLAGS_MASK
> if it's not a rule.

There are many examples of both approached in the kernel tree,
however I'd say the more common is without "~" (out of my head).

It's definitely OK to define it like
#define PAGEFLAGS_MASK          ((1UL << NR_PAGEFLAGS) - 1)

Thanks!
