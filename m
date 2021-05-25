Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EA73907DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbhEYRhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:37:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7366 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234125AbhEYRg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:36:56 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PHPsNo002580;
        Tue, 25 May 2021 10:35:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=i9NJ0T1hvtwPQWFwxKb8QdYhMMg2ELfTii0+JV6AxQM=;
 b=ObpYvAoZ4dlGfU0w0dJlHLCpwdtPZYxDkVUd21IFu58fytO0UXltAkt0+b/jJEZsD+dH
 jjHChinS0sR+l6EY9hUYU5zC2V9DPT02wtxWAKyE3vfz3u7mgXif6AnQBjC7XWf5+/Pp
 R0seB0BaDwdLkVbSxmQN7jO86YHnkC4eWOs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38rpf9mvub-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 May 2021 10:35:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 10:35:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtlaakMcZR2OyYipSw8bf+hn1Um8tMdH767I1QZ7oj5bTwIebY1tK/hgRspR9emjIM8ENsVCmEnzLteuEhVJsuE4GdMR4FmwvWQ003Jn3QtudwJgh4MhTvn65xJPlgCzJ2PO5ahRbAOxOSUmw1ZefmXUtV9d4UVnhF9ZJgr9HYYlejl6UisITUArLmckVQylNR8rvqJOVrd4VbMvi7zDlHIkhYfEtUZ5EdUzpipA+EmFo0ewNKQmtUeszp96QpyatHbD56aST8tvR3Q795pJraxk+WV+wQ0LxWj3S7CE32jfH55S9qATxLtFU2+cjX+doj0rIwM2em2eCrSUqIyuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9NJ0T1hvtwPQWFwxKb8QdYhMMg2ELfTii0+JV6AxQM=;
 b=oJHb5+pLJcCIwA5yDDuxagvDDTA7hGkeQoZayePceNeyoMxXAiqM+XXWb8WjR/Aa1agRCB3IdrlpaK4EkAWmSOMpici6ITxsdIl27jRowV3aDXgjCiP0GCJt4SFVE9eOsBcp6uFQCENO0NmTiCHLPkROyLr+vWUS425joJYlglTk2OhSOTpiMhT4S3Ufc1uVraTXcHZ4JZr8xvFeZXBmgln7fsYHklfsrrmetg3VwPleSxIbJmd/EB3oqAr639tIgEtThSGQHOYRX/2U/VOmDlNF0wwkr99Mm1xtndEgdINxIcTk0x9bR+2Du5kcQ5B773Nok2zc86sdwmaiwtq5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2982.namprd15.prod.outlook.com (2603:10b6:a03:f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 17:35:11 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 17:35:11 +0000
Date:   Tue, 25 May 2021 10:35:06 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        "fam.zheng@bytedance.com" <fam.zheng@bytedance.com>,
        "Singh, Balbir" <bsingharora@gmail.com>,
        Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [External] Re: [RFC PATCH v3 00/12] Use obj_cgroup APIs to
 charge the LRU pages
Message-ID: <YK01SgD7sFeviDGv@carbon.dhcp.thefacebook.com>
References: <20210421070059.69361-1-songmuchun@bytedance.com>
 <CAMZfGtUiKcM8WmP88J3K5edwLhJhsUkAUQo6rnkqx4BBOEY2SA@mail.gmail.com>
 <34366052-8A39-4E8E-A076-8B64AB4D015D@fb.com>
 <CAMZfGtXC_UG9gUD58ezL02a+Gyry_d7WfEwKup6UMQjvNi3HdQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMZfGtXC_UG9gUD58ezL02a+Gyry_d7WfEwKup6UMQjvNi3HdQ@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:5fb6]
X-ClientProxiedBy: MWHPR17CA0095.namprd17.prod.outlook.com
 (2603:10b6:300:c2::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:5fb6) by MWHPR17CA0095.namprd17.prod.outlook.com (2603:10b6:300:c2::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend Transport; Tue, 25 May 2021 17:35:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e62326bb-4b5d-4cda-1388-08d91fa37280
X-MS-TrafficTypeDiagnostic: BYAPR15MB2982:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2982BFF9779503AC1293E0E8BE259@BYAPR15MB2982.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bLLM0FyKEy8eIwW/zWpW05ejEvHdsQ+0ObAI4q6dPeLqjnVgMxR0AplJNhmbrWqVtxfeGgiuTcrRUddQNqwyuCjeCFwBzKI55G/UIfitvdkROJrspwpbX1/HwC2HSKGHMS2O8yB402sEyXx8Hz/MX3QrzWKOFkwmCWKge7DchvDYXj+uPNvddn5HBlCyqh2q1nEfWy7seqBdsTyYaQPQ2Uuj4qcW4G4DINHMA1dP3gDZNMCnzbg2NynrcZCwrJlSq89ZHm12Aw1A+JZf++vQgdYsXrljdBRM2pO1e9gy9yqsnwoxJ51m3tTCJ0MB5x297U1BuTe2lTARehKU3KpOrudxh/jHm/I2XUKDYdOTsTPbFxhvpW+tba6zq831Gxxv3erM5/TmLw6wqVXVl5gUVui/X4Uq/kuD+d289f0MlPFmB4Ba+kTjQadUGfDMcvbvhifVNtYPsukj9dJXeI9OGOLVJGdsHoTny6dSxENEAPdmO1ZgROdpXdEDQ2JYU989ryDN+yTqgatm5Cr/Rt3XW0gAjj3zI/4nQaMvVCJ+A7KD8fqa5c4o01lF5eQ6t4EZB5c28NPlARLeH2GnIGngUdpRyKmAR9e/2tJ7tNQcoT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(53546011)(86362001)(2906002)(54906003)(6506007)(83380400001)(38100700002)(7696005)(5660300002)(6666004)(4744005)(4326008)(316002)(52116002)(8676002)(66946007)(7416002)(478600001)(16526019)(66476007)(66556008)(186003)(9686003)(6916009)(55016002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U1k0bTVFVFArckZQQktCcmNEZFUzd0ZMWXk3UjliVHhBWTVnQ29wdkdOelhV?=
 =?utf-8?B?NXp6V0RUSmlrc2lsQkRZM3dIZEtWNVdUQUovd1A2RUx5UVJUa1VRRzFhblRh?=
 =?utf-8?B?OWgyRC95aytyYnIzRHd5cHVVQXRaUXFFNmFMajVRRzErdW90Rm9SQkpZdWZi?=
 =?utf-8?B?VFJCTERnMzlNa21DMzA5YmhrK0U2dDY0VWErWnJyeWRLT211UExibmRIL3NQ?=
 =?utf-8?B?TTRuT2FMT1ZYbTViR0pLdnZaVWlWYi8zUGNCODBtL2xDK1c3Q01jcmVSb1Fk?=
 =?utf-8?B?eU1tM2ZYOGQraXJ4OFZnUjVvOGdGSi94ZFFxVTdFcG1MWXFucUs2OCtBZkE0?=
 =?utf-8?B?NC9Vem5rVFZVNWFaa3RXOHlyWWgwakFzUlJMMFY5eG5QVWhZams2bm1DVWpw?=
 =?utf-8?B?K1E3Vmk5ZXUwSGZteVJxWkxsNk5FbGpzUHRIMURDZjRZODA4ekNLaElBcFVt?=
 =?utf-8?B?T09ZeTFLc1I0M3V0UkRCN2JoUGlCTVZYbjAyRHlmWmdHSEFQQllHUlM5L0ZO?=
 =?utf-8?B?TXU2aDFNQUM2K05aZTNzdHo4bnVmSWt0bG5rMXFnNnEvUVlHZStYazE2cVJ1?=
 =?utf-8?B?dkFYRnlwdUdrTjBUT3orQklBTWxlU1BIT2VWZDAwY1czeE15b1FJaWFzSG5w?=
 =?utf-8?B?SGxMTUVBdFBXQUlRNE9jZkY5a25leXpGRkFJY1FsSFE1Z2JNc0tKTitCR3ZN?=
 =?utf-8?B?TEV5Z2ZhL2t0MDZlYzJSQVhWb0hzWTVuM1hkR2l0MnhKcVZkd0hGcEJRa0E2?=
 =?utf-8?B?N2hCZ1VyUmljYTM5bnVkV20rdS9qOGgvblFYYVlxeUx5elFmZlVvTHpaSGRj?=
 =?utf-8?B?N1ZKOEp2YUhhZkFsS29MNTQ3YVdYTG9tZ2l4RzFOdnJ1cktvY2RJcEJyU0p5?=
 =?utf-8?B?Zjc2ekE4SWRSSFRQYVQ5eFUwMW5kbFFFYXpJVnN3bEY5NThYelcxaEV5QUh1?=
 =?utf-8?B?K1Z2RCtsU2RlSFJkZmtRMjJKaTlhS3BCYkF0SGlQY1lCRFpWOVd4Z2tsbHo4?=
 =?utf-8?B?VS9wYWwySEJDK2ZvYktKWk1zWGh6NTFudFRpQlRwQmExSnl3UWVUK1lmM0RU?=
 =?utf-8?B?aEZla05SWlFtWFIyQUlFNEZGMGVIeVZjQVlHd1pKV1lKa29hZVJMamNMRkxG?=
 =?utf-8?B?am5EZXlHUFVPR2VPbmFCU2FIODFQNzVvYXpTQTRQOHdERTJJS3dUbzNrSTY0?=
 =?utf-8?B?YWxRbGlicHk5Nzg0ZURpZ3dKSGZYSzBTbmxwSkJFUms2Tmkya3VBRnlRNkpC?=
 =?utf-8?B?NU1wVGZDWlF0cVJmWTdnN2dGWGs0NG5ZYklUR3hPcUxNSXkraDFpTHA2UVFk?=
 =?utf-8?B?WkJUZXFDVUNBZW01UUhORDFBdjlWWnZHdFRFMktLbWJzWEZ1c1N0MWVsSjdT?=
 =?utf-8?B?bC9kRGtBMUgyRjEyZEVGelFGMk5VNDNJeEJhaFprSGgwY3BzSjJtSU9PWGgv?=
 =?utf-8?B?QWxXeE9PM1JPOGtWSytUNVhMcGNRL2xMUjFjdEZLZ29OelAvcFNKRkNQdDJz?=
 =?utf-8?B?QWNONWxUM0tkSlpSdjhQbStBa1JtMlcxaW1sNDB0NEhiZ3FhQU1EL0JhM0p5?=
 =?utf-8?B?d29EMmVxdWVuSnNMMmtnN1Bvd1ZCd1p1Uzd1OXlkdk94SnFUZWtmaEFmK3Y2?=
 =?utf-8?B?ZWhpZk04OWdYUllZZ3BabloxZk1KT1VTOHFpR0Z6OEs5WUlXY1kzb3JvZzRz?=
 =?utf-8?B?aFhENzl3dE1EV0RpR1RFSmJuNWpKQ0FuUXA3MTlGd3J3cCt1UEpJbkFxazVl?=
 =?utf-8?B?NjAvSG00WUZQWkY5M2VnMVF1ZlZsMngvTjVaRGFRMWNBZ2VuSjd2ZnlxUnhj?=
 =?utf-8?B?enh0SjlOMWIzWDdhMno4UT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e62326bb-4b5d-4cda-1388-08d91fa37280
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 17:35:11.3680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8l7j89zaAOLNh4Gxc700jZCFpHtu1L0GLwCvAd3kqolSrN52CQHI0JXsigiW6HJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2982
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: HTtM5LXB6TKpODGX5AO8cvxSXXDyckNf
X-Proofpoint-ORIG-GUID: HTtM5LXB6TKpODGX5AO8cvxSXXDyckNf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_08:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=903 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 mlxscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 11:20:47AM +0800, Muchun Song wrote:
> On Tue, May 18, 2021 at 10:17 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > Hi Muchun!
> >
> > It looks like the writeback problem will be solved in a different way, which will not require generalization of the obj_cgroup api to the cgroup level. It’s not fully confirmed yet though. We still might wanna do this generalization lingn-term, but as now I have no objections for continuing the work on your patchset. I’m on pto this week, but will take a deeper look at your patches early next week. Sorry for the delay.
> 
> Waiting on your review. Thanks Roman.

It looks like the mm tree went ahead and I can't clearly apply the whole patchset.
Would you mind to rebase it and resend?

Thank you!
