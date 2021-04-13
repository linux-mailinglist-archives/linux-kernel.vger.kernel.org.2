Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F25935E54D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347311AbhDMRru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:47:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60046 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347306AbhDMRro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:47:44 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DHZIwM013289;
        Tue, 13 Apr 2021 10:47:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=nmVEag0JEVvJrbzW7VvpOlEjxBl/fDzSdryIrI2MNNA=;
 b=GtVj/lJKhl9eg7fYRGexcdyveW50abIbrKHJTb8eii+vAg9zRY17yi6CRzteC/sLcQgw
 NOFz2fqMf55Ykle7dTeE7ASYnx2jCWUEPbgYzb+cujA88dqDJuC95MvBhKTe8uuwMd8I
 bOc2FfvU2uNr2kXdGGr0oef80z0hrLrfP3U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37wd5ws79m-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 13 Apr 2021 10:47:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Apr 2021 10:47:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igt5DYwtRuz3PbmX2YTv8GFPNWQqQv505qEJ0eBTwqZL0BNB4qM1CKLrnema/oXsBlhDunZeQoSf929RmifA8Uop4Rx9A6NmJ4ZlmaRbyxWTtccjC5iNGsafwc4QwCXJT1i4OHSkumq00LxTYe5Ogrk+IPacy9oLyw873lb8o6Q37zDSJrM50MG7RhTDxTLSiSSXw2iB33Sn68oU7ZOD2/PNmduuPCYCpl4vXSP7TK5724LaSaPJ+Tb6tZup5WLvdyDYbwXxW9JpEo/OPxcb76fGdtblZkHIRJql/1J92ShX21lgo0UfYjc8fe1IF2CUhhOaYwe53AUWIEBekSIJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmVEag0JEVvJrbzW7VvpOlEjxBl/fDzSdryIrI2MNNA=;
 b=BZAX3vnkDPByDFoLaNndKvFr1RugI9Ut8Tf9K/61scwu1yAFL5u1zhiOvRpb2saUJR+HWyenJ776Fo66S/OiqzmKWT1igdSVAZ2SsEV0KdT0F9Hdqmu7QjbGZ+9ZzK4V2oe0Iid5imu9BlPDjvX5dOG6t66vBjqQTUqe+uRZ2sCc2H98+KAsIC2GPKZeTYvpM751ius48i4KPDppqs3mDxmkGyVnKDtXigbR1uMzwwJArXwJQrfk6dRD3c3B1Amf3jRsI+TfUsVsN+bDj3QXukonDfyjANhWEevLcFnVSTP+v7d3TgZZ6LIAVqq7l1bpD6v2oHXsKOzv9iiKhWQJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2759.namprd15.prod.outlook.com (2603:10b6:a03:151::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Tue, 13 Apr
 2021 17:47:16 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 17:47:16 +0000
Date:   Tue, 13 Apr 2021 10:47:12 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>
Subject: Re: [PATCH 2/7] mm: memcontrol: bail out early when !mm in
 get_mem_cgroup_from_mm
Message-ID: <YHXZIMp+i5SwFjoj@carbon.dhcp.thefacebook.com>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210413065153.63431-3-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:ec38]
X-ClientProxiedBy: CO2PR06CA0057.namprd06.prod.outlook.com
 (2603:10b6:104:3::15) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ec38) by CO2PR06CA0057.namprd06.prod.outlook.com (2603:10b6:104:3::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 13 Apr 2021 17:47:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65f45349-c3a4-4c16-3aa6-08d8fea42d61
X-MS-TrafficTypeDiagnostic: BYAPR15MB2759:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2759A4E73AC43BA6CA7841A6BE4F9@BYAPR15MB2759.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFV3YTLEUhWBSyV9afR8EZYLD8r3Ks3Q36/NzHvbAM+XnoaGOLJ6qCke8d8YscWqd6UeDApApudFpUWiNmDaXfAMEaTwuqh7mzDrQmS5r1r8o/uTn2RRKX+z90q4X/TaDKwavrAyuX1yQCyaHfoQt6S1v8d0MN9zpcCjxs0TeMqU/jRRNeFgIiIk4InLD/XSUyS9ZGkshbP+FLfXlsvYwKJ+f74144b2KjWG4HVzyRFhhhn6YvjpODjtt6EICneVRLD9RplTAPDyX5uDMdSFxFucH2LVS7Pc4vcSmJq1p2lU/sWWt23rc3YzBru/GGI8zYBJeL3QH68MvfKymLMhaNvG2EKpz+jh8cOp0m2ntEZ3CPoL16sC7NqCTAHlT3gxW+GBtA790fy26yR6E5U/NJXGxbzFrT/te8/uQmJ4TDxMR33Jbvln+gw0I+Fbma58fA8Q7Wwt+jMxmQOlSFT5cV5rpicUXeGTOvOptDwEf/t23mOxqciFwP0X/UVGnQe1rbxo+YSorvnL07j1tro8FajKzHfGMYozx3cTXHvKFMhf55/4lMAAsdg0wNsxQmWgaH3ouAqWtit/RHKtQsts0QZZeWUnm0fTbaqFvPE6BpwJg99JdvrK0+mMClw8ERWon2xnLpbI9Cy7JJUJn4qtvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39850400004)(396003)(346002)(2906002)(6506007)(83380400001)(186003)(7416002)(478600001)(38100700002)(6666004)(86362001)(4326008)(316002)(5660300002)(8936002)(66946007)(9686003)(55016002)(8676002)(66476007)(6916009)(66556008)(16526019)(7696005)(52116002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LwShggkvfOAxGJO96H143tIGtU9xcuxr9XxB7r158GNPiNEfJEgnsE0O5f8D?=
 =?us-ascii?Q?dX+B/VcR4JajisSxi9JU0KPkCWtekCqLWhgiIgUlbB/SaUt3DdpCKiWOK1UA?=
 =?us-ascii?Q?ckGtYkyXcXoQimMjycMZ0a4bv1JiVgBEQKGCo/bldbzUBask97QGsL80gi1R?=
 =?us-ascii?Q?tZGRjKgsEGaD+wL2Dpls9JtfKhkxCKBAs6RhkaMyLjjmAXaikXVrjxta34LH?=
 =?us-ascii?Q?bYndGoXJhBJh/+Ird/MijBcxTX2ajXhhFpVTNL75Od/7ctARiVt1eIz82gxX?=
 =?us-ascii?Q?6mtyNRg+OuBEhRPoBgXQNNrC/ic3I8W/TAqb7fQlG28E9uStI4CFQ2ooU5cC?=
 =?us-ascii?Q?/JvVhhYqVol97YH4TSeQHRLwDoJME7WCVnVJwvrEJhFf300+0F/eXHU8/+TB?=
 =?us-ascii?Q?B2YIQnHzIXpfz4uw0OgKFm+p52VI4U6mC4+Lgua+fxtJzjX/7mt4QjlYi4GY?=
 =?us-ascii?Q?tAPzbKAoFKOF1pteENlzX4wrouKe7JtQ+BwxXb3D7ukgl9/2uM9QA/IISE+E?=
 =?us-ascii?Q?jQCeathqDvrJERp59qi5f5g0yr2H9O+klWL2E2dgbDeW10cpP4MuezSUhnmp?=
 =?us-ascii?Q?z61tfkQaqJTVY2zfocFdDe4r4xPK8Ll7gDleSd0ag+0Y59mHh8y0KjG02kEG?=
 =?us-ascii?Q?lxs+DqAx/rI7N+gsvDVA1tBoO5RkWMDDw5t7D2Plw0AIrmkvEZ03V70tEdiG?=
 =?us-ascii?Q?Rt29TaEDvacGjPHJXw2FUunXYQHV3CB56pQDskZS3WJJ7S45G81du3JveLlV?=
 =?us-ascii?Q?W9RZC13Y4dhtTnqNc9B89jTdzSTAitH1O+Jog1eiWatlCSBMIcQdD3JSfvzm?=
 =?us-ascii?Q?gN8Ke/a7n6GX6HW8dvYpGm3ATJNFqoFT4l62YQYBwl41Rt+7W+Rzaycfd0eq?=
 =?us-ascii?Q?0JDSgqzGi8W/2fBcl7R4xwnrGvXigpbW7WIs6PfZ/R2LqenluepRx05l3yfm?=
 =?us-ascii?Q?AT4/25VFYIBC0Wudfx0uEoSTWzH+UBouPfM6EzJPTb/39SkfIPBAWBN/L9V1?=
 =?us-ascii?Q?IO+3T06LHjP82uaiKNYwvQsS90Y5UYy6QA0hW8sXVC5jDLxWdB4T1soHUCLd?=
 =?us-ascii?Q?GHAj7njVH11hYZUNwsGJaKr9Hy/hR1KH9ph6gGQWLG1SecQFcmERHAVMufVJ?=
 =?us-ascii?Q?NUPuOsBlv3oQ1LH2ubb8p/QAo9C1A5H2NsVKJbQUEmEh9mXlpcuEzJYMHIil?=
 =?us-ascii?Q?mA2q/gvXZNCLMHfYEJkHISr5XqGrOfPzQtZQxVEv7oIjFoRNRFDL9q5T2X0g?=
 =?us-ascii?Q?lN9KMfVsYGedbRf9kI2coY/carxkw/jcxG1hTktgBundJKJLPBreyNxClu29?=
 =?us-ascii?Q?/WVUu2TBz145CldsqRdIjcOoPwQDWgT+W+VJ8cGsA31BoA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f45349-c3a4-4c16-3aa6-08d8fea42d61
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 17:47:16.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwAc4j7GADHsw4TBSAA8jLp2VzQNj/ZaXVp4MEbqXDEfjHPA2gdPsJoHcTTB2M2j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2759
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: CzpGSKoXZHF5jaNXkODns_fyLkAApbnQ
X-Proofpoint-ORIG-GUID: CzpGSKoXZHF5jaNXkODns_fyLkAApbnQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_12:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=926 priorityscore=1501
 suspectscore=0 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 02:51:48PM +0800, Muchun Song wrote:
> When mm is NULL, we do not need to hold rcu lock and call css_tryget for
> the root memcg. And we also do not need to check !mm in every loop of
> while. So bail out early when !mm.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Roman Gushchin <guro@fb.com>

Nice!

> ---
>  mm/memcontrol.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f229de925aa5..9cbfff59b171 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -901,20 +901,19 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>  	if (mem_cgroup_disabled())
>  		return NULL;
>  
> +	/*
> +	 * Page cache insertions can happen without an
> +	 * actual mm context, e.g. during disk probing
> +	 * on boot, loopback IO, acct() writes etc.
> +	 */
> +	if (unlikely(!mm))
> +		return root_mem_cgroup;
> +
>  	rcu_read_lock();
>  	do {
> -		/*
> -		 * Page cache insertions can happen without an
> -		 * actual mm context, e.g. during disk probing
> -		 * on boot, loopback IO, acct() writes etc.
> -		 */
> -		if (unlikely(!mm))
> +		memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
> +		if (unlikely(!memcg))
>  			memcg = root_mem_cgroup;
> -		else {
> -			memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
> -			if (unlikely(!memcg))
> -				memcg = root_mem_cgroup;
> -		}
>  	} while (!css_tryget(&memcg->css));
>  	rcu_read_unlock();
>  	return memcg;
> -- 
> 2.11.0
> 
