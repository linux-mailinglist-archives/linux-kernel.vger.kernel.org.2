Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F62F350D32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhDADfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:35:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60898 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232672AbhDADf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:35:27 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1313ShNO015265;
        Wed, 31 Mar 2021 20:35:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=3ck5/9Gj1vjkt5CZ4711899IEDJ/K+tMaydu/2cNLV0=;
 b=GI2qZ75HhpUgfcohQ3Qf9RvdzLHLdPHmcte6wihIJoO2CILp6202I4mTsipje394FaKW
 Hfs+qQopwQwDSQnzNXj+Zt/Tif+R2XevS2MJBWNCiXPSlxBm+DD8wB7EXozyqJBuhKAc
 i9TaOvU9B562+E1cnhKVfN6uTdJ+q5Ay2fo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37n2ahs1vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 31 Mar 2021 20:35:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 20:35:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1Mr+asFcVQ2ZhPZd+uQijz8pxmMNiab1i+djp6DZcpqWL9Ly5/JIybnI2AIDZlwNbRoNXsP3uTKO6zufMA1SPgPnR4rvuTRn8B10ues6X1kNWj952R/W26JRfzv839m0bJvYW3UGoZ3G5cZiczu1sv0ZLarSm9ciStzNwJ4dAPr/9/n9tdzDE1a6OFkstAS2nVWFgvLoYvWheOPlnMvd06mTy5J3QC/HA/D3/P7U8G0PFFXgN0Ga6v7v/1wepHjhmEd67GWQSoq0QiT62rAejQ2EMDakvNUPPMrMKFT9UbOiYn+WVDQtZI6XQPa5GRcFUAQ28JkG537ySs7/EBuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ck5/9Gj1vjkt5CZ4711899IEDJ/K+tMaydu/2cNLV0=;
 b=Qs26TPq7BoqmFNM+wE1mAhoGV7Vt5a2+qeBxZ7NYgBBgQat4lJm7/CqJIGDS+9zJdR76oKBiITHzL63Hp3r2Wj7cgdEPxzNZJr8nXUzg8v/Dv6FvaKP3/mLIkpx5C4Rp/6JUDcLjb/wGxMgWgYWJsYtHRoI77LQbbmm+5saHtVdTPceh09xAsgZmAgLBv1AAqXhGtQ4fU7h8d0iS0Ud8E3XJFxYP7zHEFcWsBQHl37Y/4KecIOnOCzAqREhFlxqRctr4NU9zzagogNpQmevt6ygqc7dNzw6jpBYVR45/jKkmrmPwBALo6LC5La8iy4j+Q04a+rV5Tjak1umm3KKvsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB4133.namprd15.prod.outlook.com (2603:10b6:a03:9b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 1 Apr
 2021 03:35:06 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 03:35:06 +0000
Date:   Wed, 31 Mar 2021 20:35:02 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <duanxiongchun@bytedance.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix forget to obtain the ref to objcg in
 split_page_memcg
Message-ID: <YGU/ZojpKXXK9AnU@carbon.DHCP.thefacebook.com>
References: <20210401030141.37061-1-songmuchun@bytedance.com>
 <5c183fe6-637f-151c-67f0-fe19a0ce3356@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5c183fe6-637f-151c-67f0-fe19a0ce3356@huawei.com>
X-Originating-IP: [2620:10d:c090:400::5:5d24]
X-ClientProxiedBy: MWHPR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:300:4b::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:5d24) by MWHPR02CA0007.namprd02.prod.outlook.com (2603:10b6:300:4b::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Thu, 1 Apr 2021 03:35:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d4cdd93-a4bb-485f-598b-08d8f4bf2496
X-MS-TrafficTypeDiagnostic: BYAPR15MB4133:
X-Microsoft-Antispam-PRVS: <BYAPR15MB41333F7B73CAAF0E22B7EF1EBE7B9@BYAPR15MB4133.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0xxlTRiTIke49Ik3/2f2NR+y94O/XWTGxU1548uHTblzVIt6RyGUlXr5eWm/Qo9reHhaoZa4ktXn+pYcm+fvr/JulDfMhq9r9dwX55KlZ+jjp16iSDlgQEIcage6inSwmTC2QR7bVg6VmRUVkDw8t2Lk+yiJsS2NByg2SPSlyE8r6vt5pOr8rVgLHXoM6K4xmtkZm+Ni7l//hM1JQomOw6lcUGNExbNkY8vNIaPXm9v7G9VvwIPJkY1V2IzCYrii7WBrvoZB3k0aHBw2/Zgi7O3xdk3behWcSQ7AGYmViR6B/w9So6EWmzNa2H71lWEg2Gw9lX1c7XGzFBImQNdED6vBpdO9BmgzB8FtpDSrybG2VMflUOV+Zkd5JClzpjYSjASxvX5IAZNfKFQK0AZJcgHLHZlhhbo5114dUwpWmigonbasULRfSzmed6/iwzyMuSbQO8MYfDgmrf2Yc+sAASKDHLiguUdbsdcPsB6oez2R4M7CZCCC2sE5Nqnq1m9+ZkWxo3KfJqlllDuWKJo+imSGkebBPER7RqFdF3822GqzX4Fv7Y7KZZwH78303nnwMgev87efEyJee0uEwUl34162qMIxuNHTr3Fy9SVIsIqagUK8KsdeDxvI6s/Cs0TCVjjBV/hl6Plr2za4tgojg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(346002)(366004)(136003)(54906003)(52116002)(6916009)(16526019)(66556008)(66476007)(83380400001)(55016002)(6506007)(2906002)(9686003)(316002)(38100700001)(4326008)(66946007)(86362001)(186003)(8936002)(478600001)(8676002)(7416002)(7696005)(5660300002)(6666004)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vfJ+sL05VH0R/H0DiuZmT/MTXFKqmQYtVgA7kz80XRa7nunJKqfmryiRDF1X?=
 =?us-ascii?Q?aLx7vS70hqD1KprugJr882o9NFJEEPHqi79xLWdx25/jXwAMCtAiS1fRDzGI?=
 =?us-ascii?Q?efWbCP6Opk/4wtZPcWCmrONSVJzhWQ/G5nvQ7FTemVIZ/TGhdlrFoeAwlo/7?=
 =?us-ascii?Q?MPe8XiX91iQjXBD3QavjjxUu4G1IGdGbYq6Arr45EBReRwtWC1Eh4uZ++9ov?=
 =?us-ascii?Q?Weox9xbFQ7BQkszvdOxKL22HTCNdWniZrxUdeJT9EKLawj6pwRxKFYmYZ7o9?=
 =?us-ascii?Q?659XXD9pUnrD7ukniW8j+e3l31kytH8+RX9O7z1PIksfeJzlQXTup7vMfr7R?=
 =?us-ascii?Q?CVc7/p9oh889EkAkV0d0hfEE3CpbBpnyZD4e2DnjRIaZgO8xYyqJw3/Xz9jT?=
 =?us-ascii?Q?JikZPNzfn6K3ykAYa8xrZVXVUD/0DIQAIoctgcA5fKbI9aoCAyKoyfNXSyR0?=
 =?us-ascii?Q?qp6i0nJlSrvohMi4mWdCBsxTcN1Q3F/tZwUKZJMKGPiBqGB9fppJnS6VV+9P?=
 =?us-ascii?Q?kCVX3RKeeas5DoxM4iexzMspnaJA+OcODuFQd6Kk0tXwHXtpiskNXBBwlW6j?=
 =?us-ascii?Q?8Q6Aep7vPAxbeYx0lK3km4+ipEDaUiPKgkGXC2eVgzmAueZoBfzVmtWAmF5g?=
 =?us-ascii?Q?NlUcCT9/FnpShX6O4t6aM/wlTXK6vu3DkC0DZboCT9RkZL8LPtzRWVxkZwmA?=
 =?us-ascii?Q?Hkp9gK/GAiRDzThuWo6Z1JZJmwQ/9MC+BdbRsDHslffvPihbknaHLeVReoBF?=
 =?us-ascii?Q?RPYqIT7nRWNB1NJb+wAiojkOY1+ZkdnkJCpgjy3Zxh3JNQclBm4FuwaLVnSa?=
 =?us-ascii?Q?CkC+FR1GNcqbOf9XCB5pv3U1E4pTAvTwW+N7XgmfOsNziOvlQsfmlK+rbvY7?=
 =?us-ascii?Q?Pd3lV/o4b2AK7+K005CJp4Jma+ZtbHKDFZfQPZjmqJ+HYqRdlUIj/US1f97P?=
 =?us-ascii?Q?u7riDzGPhFiMzJOTO/pgzSpCVpUPlIpZ2qHyGsmtwf93ulc3n2V2e77wIzQw?=
 =?us-ascii?Q?fWxGw9NF4tXyq05uDJ7I8/yt+XhIHe0aieMv0N3mf1XWTPi15iEjODUznAAR?=
 =?us-ascii?Q?IFY0y9T1xDTgdO56WJVw2BkrmktWVBOhlzrAun9S6C+OS6R25WGDSOCjvq1J?=
 =?us-ascii?Q?/Zc1qrAaYcahWD/SmFe3XK07+Ocq7+JUfyZgD0DkBQgRT3j/A8rdMpQKcteY?=
 =?us-ascii?Q?lmnUWNOwn+Yc7o1EuNTMJgJFhjxZA3aq0/8NElb0BI2u12J8ONxaVHzRVwHF?=
 =?us-ascii?Q?qL7pJPAkbPkAe1XkLAMXIA/qFJZDGMDzKr7WMZvhjBAAH+XWpJpQGJl0DFvx?=
 =?us-ascii?Q?VX6o7joEyQTKmYAEV6lscshShZM3ZCjWEQmRrvgGj0bXHg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4cdd93-a4bb-485f-598b-08d8f4bf2496
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 03:35:06.4166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBop9KRoS6qIq36kRxxJfvqCNjN/u0MXwksXi9upoVWltkcu8/ac+1iS+hYcRzUw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4133
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: XSBNiTNXy-ISMlYzA6bS2Rj9e3Ny-7m6
X-Proofpoint-ORIG-GUID: XSBNiTNXy-ISMlYzA6bS2Rj9e3Ny-7m6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_02:2021-03-31,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:31:16AM +0800, Miaohe Lin wrote:
> On 2021/4/1 11:01, Muchun Song wrote:
> > Christian Borntraeger reported a warning about "percpu ref
> > (obj_cgroup_release) <= 0 (-1) after switching to atomic".
> > Because we forgot to obtain the reference to the objcg and
> > wrongly obtain the reference of memcg.
> > 
> > Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> Thanks for the patch.
> Is a Fixes tag needed?

No, as the original patch hasn't been merged into the Linus's tree yet.
So the fix can be simply squashed.

Btw, the fix looks good to me.

Acked-by: Roman Gushchin <guro@fb.com>

> 
> > ---
> >  include/linux/memcontrol.h | 6 ++++++
> >  mm/memcontrol.c            | 6 +++++-
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 0e8907957227..c960fd49c3e8 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -804,6 +804,12 @@ static inline void obj_cgroup_get(struct obj_cgroup *objcg)
> >  	percpu_ref_get(&objcg->refcnt);
> >  }
> >  
> > +static inline void obj_cgroup_get_many(struct obj_cgroup *objcg,
> > +				       unsigned long nr)
> > +{
> > +	percpu_ref_get_many(&objcg->refcnt, nr);
> > +}
> > +
> >  static inline void obj_cgroup_put(struct obj_cgroup *objcg)
> >  {
> >  	percpu_ref_put(&objcg->refcnt);
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c0b83a396299..64ada9e650a5 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -3133,7 +3133,11 @@ void split_page_memcg(struct page *head, unsigned int nr)
> >  
> >  	for (i = 1; i < nr; i++)
> >  		head[i].memcg_data = head->memcg_data;
> > -	css_get_many(&memcg->css, nr - 1);
> > +
> > +	if (PageMemcgKmem(head))
> > +		obj_cgroup_get_many(__page_objcg(head), nr - 1);
> > +	else
> > +		css_get_many(&memcg->css, nr - 1);
> >  }
> >  
> >  #ifdef CONFIG_MEMCG_SWAP
> > 
> 
