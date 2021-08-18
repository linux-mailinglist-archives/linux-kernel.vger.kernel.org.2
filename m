Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C553EF871
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 05:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbhHRDSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 23:18:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29300 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235959AbhHRDSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 23:18:49 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17I3B2mZ027781;
        Tue, 17 Aug 2021 20:18:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=03/U4t+TaSu9gtlwWzx05GAJHNZVCHG2vTy1MIiP+3c=;
 b=OJFtoWsFkLG4fHJweiGWNdt0dmplgv7Nc9F6vYpEYBb98TZ3XJ4bIM515wNlMsovB0zZ
 UztnK/W2i4FPssJ6udOj5QU2Q8C2wvVpJ+j6skex1O8B4rbYcCu0kFzTz041kJPLoHjq
 JFNr3YVTt9WqtRq3khlf+khjF7+MJEh2ufg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aga68e0xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Aug 2021 20:18:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 20:18:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuyILK6bfPGFqM8I4DnDtvQlZMwGtYEKuRQJWyIM2cXKmCNlymsY+EfQqqP73hbWdU0mRr57wrEqCfRJzqARrKjz+9e8KHzAB+LQkzv+ya+5al7G5JByPK1cHMsKNIFsBpjO3H3jr0E2jgfWrFZ9/jYst00Z2Vapqij6JEvd4HHGhxwuln6THpJmN9IXxKk6swOtDfk1u4/UrbVrSD8L8/j0qFSOaLKIBn623uKVyn+tPsjDRHds/JKTb4Uby8VJtouHo58ERD6i+3Y9SFU3YYBxsH8xSP5Lj0DijiJr8fCcm8aRZgzhFnPQvJwycTZHK5eY2+NS8Z1gB0uustjiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03/U4t+TaSu9gtlwWzx05GAJHNZVCHG2vTy1MIiP+3c=;
 b=DtmPiSjxIdHbYDGCTJT/k/PI95wCORvW0tpPNqbm76cJPmQD01Dx7Hoo32q0iVtPYBu8pPZolXl/5OVOKQcKgpa+7d6P2DpaopSVMh/eOdMsOcmUEKLDNDEGekujRHu9xyTFAgJJFTvl6c58s9JEFdaUIs+UclxRlkCEFS2oZBybbYLcH4Wla0Gn1dLf7EMd3MF6h9aTcySMq7L4aV2EdjxKaVyieorlBo2Q0VTTLFoo13OhShCYnkb+DjDYInmVjru/5Jk58pzdxughce528leeWrurMpN1w0l3sNFjv1PXO1j2S6OQSwGuSXXKrce3W+HY34W3oPwxN47/TMOsVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3078.namprd15.prod.outlook.com (2603:10b6:a03:fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Wed, 18 Aug
 2021 03:18:06 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::75be:c42b:c0d2:2565]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::75be:c42b:c0d2:2565%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 03:18:05 +0000
Date:   Tue, 17 Aug 2021 20:18:01 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>, <bsingharora@gmail.com>,
        <shy828301@gmail.com>, <alexs@kernel.org>, <smuchun@gmail.com>,
        <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v1 03/12] mm: memcontrol: make lruvec lock safe when LRU
 pages are reparented
Message-ID: <YRx76SlTkTT8a1BI@carbon.dhcp.thefacebook.com>
References: <20210814052519.86679-1-songmuchun@bytedance.com>
 <20210814052519.86679-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210814052519.86679-4-songmuchun@bytedance.com>
X-ClientProxiedBy: MWHPR17CA0091.namprd17.prod.outlook.com
 (2603:10b6:300:c2::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:20bf) by MWHPR17CA0091.namprd17.prod.outlook.com (2603:10b6:300:c2::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 03:18:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc0011ef-d572-4b42-14a3-08d961f6cbaa
X-MS-TrafficTypeDiagnostic: BYAPR15MB3078:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3078C52E7DC478E5479490CCBEFF9@BYAPR15MB3078.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Lamfn8jKQT8bPA5ejQvVC4tH09jFbi0UvZB0chkSkKFhXq5iGwLxLCqG+A3ZnifyTYjvDslpQ9BlIIJNa3CxOuGJrIqj6NwwS7DGF0W3ZmZ7gOeL8xJFohLAWeoBVP5Pb/Uf1NF2ezcnaVbujxYdpNh7wJ0nYYlDZoofR93E8jv3wJsGL2zD3LwFGVgKaGiCkVKpu5mFOkXiOq0eNSMD4HXw2y2ljbUKm7Xg34yC2vSKvhB3UDFPSm495fOIpJP6z/S8T2wTmjll44tdK2eGBXfc8G+Eg8wgqcUB2hAJWS+fb7ygeakc0xfffFWxvpiklvIQ/0C3577ml11Oeu8BIFbYjUKznZbYHozFgXsZraYrfj1ClEx+KY4u3A0kQgKD6nDRdOqRgwY2TAMSJDRtK+yMXMx21xNnloPArL3vNz4egeHz55D0rCSxE/zqLwavk4P9WKdi6DHdloIYbcbvjOcT3tLrgvqCTG5wOUb/EenCI1TU1KjlwVBNTSOxAgdKJdQvXTUZsANk4nqe3FChOclN6eBpKnP3rjjK2gFYQTenNiecA/rBi6IY+4wjpCTfkMG3JI6fUnjzR+2c5ThpxILQ8NMKdJW+gs5OBT8qM3uA7DmLrnLOM5cy8EGvqXDn4duYXBQy7NnhPB7yCTaXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(52116002)(8676002)(316002)(4326008)(6506007)(9686003)(7696005)(5660300002)(55016002)(6916009)(8936002)(478600001)(38100700002)(7416002)(2906002)(66946007)(86362001)(66476007)(66556008)(6666004)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rJxcZ1AlRnlQdIppo6mNJkA/YP5cWxS+tCzlWlE3Tn1D2tyIwAvGpHGOazir?=
 =?us-ascii?Q?ztn7VHzL2CuBhm6Ya+xnPB97F7qlAUuMsAHho5GkzuA9KO5pP5P6qN+Mi0N/?=
 =?us-ascii?Q?KL1uSPNZQiX4CpQ0CQGx6ixDbT1E9powVCaOf3Iw4UdpwgQ1GMoPQKhy1N83?=
 =?us-ascii?Q?2U0qWXb1CmDFC+/9MYxAsHIZFLV1ca3qzCopebo/6IH/SCYeUS+2CjScjYpK?=
 =?us-ascii?Q?GC3LcyHOXUkLJATaM/+/SokFVajgNEheeDlYjK8NKMAke5wtIopmj8gvDehk?=
 =?us-ascii?Q?3mad4oojQ4SvOA1hzBDeGyuw3H1kKgzyvb5YkUQdGYKerDjtFyjEVW6OQZJu?=
 =?us-ascii?Q?QBVx/QZBzBSvX+COGlSCXF+2+MfsSFf//YB/R3qC+i5Tbgda+OW3y9iiVdqp?=
 =?us-ascii?Q?/nWBnSWvw5prtzTDOR7nc0o3Wvw1xiYoFSEeKuIWDNlCDq5a1QlEldvL+W/b?=
 =?us-ascii?Q?/2DD+tLNYn+aF04qjFcDTYi62C43LcadFeaGAZW7xTXwXCpMFn+z5wX/pkEE?=
 =?us-ascii?Q?+g/IpUOk916/T5srxqmzNDubo17DGahprW/7kDx18mKB3/b+wCYX/FJT+uQj?=
 =?us-ascii?Q?f+ZOekLX2F6w3qb2ToQTIVYzCIVuvHr8rBRrOrkGU66FY/kat4Y0UcFKyfz/?=
 =?us-ascii?Q?XvV/u/69IpwHFj/RPbWxKWumWdIP5VbXZZSn/DArFcVZ+ckw0gNRGrywNFJA?=
 =?us-ascii?Q?Fhg7dQteyXt6g1VJw3drY/zJXNnRpEIpzVv6bFfmdAk36Ps8Trd85tCBlO8e?=
 =?us-ascii?Q?IEd4nta4piv1QB5fS6aXWyE6DV4hSNig6FU8NgRuxDYiiCJ1Q/67Ccr55M3n?=
 =?us-ascii?Q?Va+lzaPHica9b6LERangn1FAWP4iZ27GKkHoRsSi8lK33NeS0R3arzlvamQR?=
 =?us-ascii?Q?rOUowbCwHvfl9hbR0WnZ4RKEYgCHndOnv9vr55/53bSwRCHWFz6jCtt6rBmH?=
 =?us-ascii?Q?CO4DMaekaWR+JQn0SB5vKHc6JeiZ7IAMLaIDHb3m4QFjOWqD1f7w2vw2H37t?=
 =?us-ascii?Q?QgvdImm6DEQXHDJOPr1jMbz93M0dBS/HFBmdL7oCGEGXexVQDDH1EXUSaKOK?=
 =?us-ascii?Q?ouD1rJRaqwBEIg2/fAojEb2tfs0c1tUFdk6Vc2d16z1Imiv7woUA+LzB7wZO?=
 =?us-ascii?Q?noHJOspLngol+xBIBnHbc/L2WLiC2G2DcC8U/WY24cWYtFY9ASa2W+uEOp3r?=
 =?us-ascii?Q?lMpEVfLjE8uLd3nIsVjLNMaWpQIaTgCDs9nFd3XqnUwdLIlQWcH6Y/kCYyRV?=
 =?us-ascii?Q?I+M/s7vxE32EgplG9XOJdk7YLr75dMPwMgUWT6FaYolHXvy3crhKsw1i9/IM?=
 =?us-ascii?Q?sraaSqDpJHcjYE3Oe15oXmvY91bzNN2R+0JBmT4luL8pNg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0011ef-d572-4b42-14a3-08d961f6cbaa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 03:18:05.8205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyXCfByQiXU33UfqZWom+B0Rxux4kVKvbZ23Eg9tnOeGhCXAPK57UEnwoieifw6O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3078
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: krbrWwEe7Khvy5U3Dj4HTQD8z6GyNU33
X-Proofpoint-ORIG-GUID: krbrWwEe7Khvy5U3Dj4HTQD8z6GyNU33
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-18_01:2021-08-17,2021-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=935 priorityscore=1501
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108180019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 01:25:10PM +0800, Muchun Song wrote:
> The diagram below shows how to make the folio lruvec lock safe when LRU
> pages are reparented.
> 
> folio_lruvec_lock(folio)
>     retry:
> 	lruvec = folio_lruvec(folio);
> 
>         // The folio is reparented at this time.
>         spin_lock(&lruvec->lru_lock);
> 
>         if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio)))
>             // Acquired the wrong lruvec lock and need to retry.
>             // Because this folio is on the parent memcg lruvec list.
>             goto retry;
> 
>         // If we reach here, it means that folio_memcg(folio) is stable.
> 
> memcg_reparent_objcgs(memcg)
>     // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
>     spin_lock(&lruvec->lru_lock);
>     spin_lock(&lruvec_parent->lru_lock);
> 
>     // Move all the pages from the lruvec list to the parent lruvec list.
> 
>     spin_unlock(&lruvec_parent->lru_lock);
>     spin_unlock(&lruvec->lru_lock);
> 
> After we acquire the lruvec lock, we need to check whether the folio is
> reparented. If so, we need to reacquire the new lruvec lock. On the
> routine of the LRU pages reparenting, we will also acquire the lruvec
> lock (will be implemented in the later patch). So folio_memcg() cannot
> be changed when we hold the lruvec lock.
> 
> Since lruvec_memcg(lruvec) is always equal to folio_memcg(folio) after
> we hold the lruvec lock, lruvec_memcg_debug() check is pointless. So
> remove it.
> 
> This is a preparation for reparenting the LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Maybe it's mostly s/page/folio, but the patch looks quite differently
in comparison to the version I did ack. In general, please, drop acks
when there are significant changes between versions.

Thanks!
