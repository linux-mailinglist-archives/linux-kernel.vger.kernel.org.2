Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30899439D66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 19:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhJYRXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 13:23:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36840 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233395AbhJYRXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:23:03 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PH291l006735;
        Mon, 25 Oct 2021 10:20:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=IUYnsKTCdexlCh8Bd52C0OWzZZNjz8FGmIx5iVc3b7s=;
 b=P15QCU8cDHbePbfnbNseRQQE3xXY3C6//kWxL+HnQbihT4V7EnFEncfhsZH8b7ZMiGBS
 FRZHKQWq8iErn+uYeTxxSmhkfgKnLkjoXev5gYXrUsR4YC863Urn4QLXbgXny/mwNLh7
 F/cTBK8gHHdnBXtXFaeb7C+rYqoMy8LWTzM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bwsn4k78n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 Oct 2021 10:20:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 25 Oct 2021 10:20:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlzMYZH8Ipkr2OfX6MkVEHF418zwuTglYk/qrCjYe0wIY2bfV9GaPqHdzFgYZE8Hsf631krci9e+sCwMjNbkO1VKcGVVc1n6GVCQn3iiLLM2ExlaGvsWNh8rUDUg3GytpJ8aypA3x7a4qwytmetJOnBVYZZMSEcLNZxGXpN/tckuO1cqyayeAbRk6lEXhyz41fn2BEfiHxg1DGJnMyqW/DgeUHPc9C3N/gPQYW3e7arUl5IxPv2YVyIyNw4H3D5waUj9sNkaz4nsh9PB6oqF3owZ53yBZu1x/bPQx8dl5SF4luSmCebo26+JpD0GRXnOdbQ3EWynNNsbMNtE8uZlyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUYnsKTCdexlCh8Bd52C0OWzZZNjz8FGmIx5iVc3b7s=;
 b=bman8wVmFIWH0cCbqS4+SRejYjwWhnYaa2D+AL/FdejdZU8Rzxd1gfZVeRYuXQh+i7f2UHiJMv6Az7/HdiiSUQpYC3SJDkQyyK70f1GflOzFie5FdKlOHbycaRV45s6w3nYZ04mC2EH3PPHXTebBt1Vw6mdC3/0M6o89/7QB8zYqN99e70ZYuAJlkVO5mz9NCkAMpEiCY8Fb11lk7F7b44U9IsruKL9NCg85xW2wEY6ouFPNjZiOWRhIkkZvjySzLcRkSzHD2x7aAqacVHLSfZl02jyH8f/5jas0jXeDoCNWftvk70wlNGtav3/XLRhdttsKKwamvmCX7Y9MgY0Fmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3142.namprd15.prod.outlook.com (2603:10b6:a03:b1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 17:20:30 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 17:20:30 +0000
Date:   Mon, 25 Oct 2021 10:20:27 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <akpm@linux-foundation.org>, <mhocko@kernel.org>,
        <shakeelb@google.com>, <willy@infradead.org>, <hannes@cmpxchg.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: remove the kmem states
Message-ID: <YXbnW/cjgxXQOnpP@carbon.DHCP.thefacebook.com>
References: <20211025125259.56624-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211025125259.56624-1-songmuchun@bytedance.com>
X-ClientProxiedBy: MWHPR14CA0031.namprd14.prod.outlook.com
 (2603:10b6:300:12b::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:93ab) by MWHPR14CA0031.namprd14.prod.outlook.com (2603:10b6:300:12b::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Mon, 25 Oct 2021 17:20:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3d49664-f9b4-4f26-3f32-08d997dbbee5
X-MS-TrafficTypeDiagnostic: BYAPR15MB3142:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3142AC8E0D128E1139E07F52BE839@BYAPR15MB3142.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r926A9CndZBhMWi70m6/Hhu97fKTjJCDTJhElkZ+z1AKZrbEi4+1AzZCGRH8wKJwp32PkYqWHuwF503OQbC/tXJ/edclE5CsnNTYCh4dY6I3AsMLiusED8Hafc0YNJeqwlRl37u5G6OuFPUAIBKv+lPnfoc6aBVnCAv17Il4KPOmNKR+RNkScMn0xGdjW72UeOXY0SXjY4AxX604Gl0+HDhjQGg3BeEsAOW8vZqyVNRWnz0HowTetzwGPuLh3z7EJHnfwwuYxIyGe6tRdTCIn+uU8KPU75fauPAsGlXb92Zq6IODZcbpp0NRED8/5NxRgvjonX4hqFJPrSNrJjy7uYepYTQ9nnNMed6yBVTyIVVlVHTKtk9qB4uF0tOax1bjyxYfeCuMkKXp0OL6CnduYIQdn7iSoH9LuiFesZSCfIgqt5z3HI2H/nRkfU8ghb5hQD4itOd37wsYa1Oj4dMeWPDZifllDf3l2llaL0PLdR+LEFnWW3CtAk76exe+qnurGh+V77Uy1QGM3JHtOjckjZ1+ruuhElnXTKiutj/scL/JbHJ5RuliDlax3wFNdrDECzffpuNcOSESmljRUyDuBjJHJP5QfLL/8Xq7h8AAgP4CHg04uw5o0/v6ckzXbi8iTT/m5g2nNGPu3GolodJd1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(55016002)(316002)(4326008)(6506007)(86362001)(508600001)(9686003)(6916009)(6666004)(4744005)(8936002)(66946007)(66556008)(66476007)(5660300002)(38100700002)(8676002)(7696005)(186003)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0DMvWOHCrKObogq+y1gpf/XtRq+L+sdo2lh+k79fhBMzw9o9h+afNwwg0Ed8?=
 =?us-ascii?Q?Z2Qq12ubeAxXftdmOOI2cL5tw+c2K+9Xra9zCzup9zJ0gs2+TbgvoWoOWkGV?=
 =?us-ascii?Q?t9zIo1iuAMdcNU7jDrHTTDSO4tSzNW4J9Erjk3hA2qAdwIC2trizQD22m6B1?=
 =?us-ascii?Q?0+phLiD6G+4HN4dd+2k4JhYOYrR7xiv3lZ0IcT2khEJexiCfuQ9g9qkDW2Ae?=
 =?us-ascii?Q?la5NlpDemzUAqKR/1APWGrcguC26wbJnhgbzmacyXLSUv/uoMV5oBpJVumwt?=
 =?us-ascii?Q?vSTyb+tFmQWSbxBoxGfoFmGBxAkMNUNTc7FAARa1KRI0yOPUnKnkvJWv13h3?=
 =?us-ascii?Q?alic0vBVfiOB6W6aqP8l7UnKfa5fC7r1R/ZtWfsQ07uyPgJCcgRHat4RAT5B?=
 =?us-ascii?Q?vhK0mKWWfqIYjITnkjhOKLkaGa4Es2ptQl3JfF+gd3LZBsXqiTFrYlYnN6pa?=
 =?us-ascii?Q?GILd6262dyQ+Nk3kVu88IMpiGFo+cika+lWg37qzggoa2Hq0rHWMToqUpgKX?=
 =?us-ascii?Q?Zs/YPEeSTFpo7DXHMXnOxVASyD+oXBbnVeptqCJVjeCLrpjaNasn5xHcSydY?=
 =?us-ascii?Q?Vb/OiPqXVs+eeCbeMEhthVfEgtvIN/BjmTlc1NYIMJln0F6MI5lbRWPGgbVA?=
 =?us-ascii?Q?JfWwIYK0X0H9lWFc4mEqIcOCCkm1PQqt8ZwmbxqZOp9vVXKe+sNz4l699ScP?=
 =?us-ascii?Q?uKozl79KJYvN7KAdgput+GWo/cXlbAvsZJ81fABqODeQLqFqYgGYgWrTAJpr?=
 =?us-ascii?Q?ENP5p3VVhy5TEiNCyFMqqCqb7KLvqjlxYxwjSY2wdOl7ErwepBGq5yAsWNwg?=
 =?us-ascii?Q?MNGbLfxKcFia5FfCIN3BkdD+lQzlOoE3eX8lxGBnl3Z6NNllyK5oO4VKIxYS?=
 =?us-ascii?Q?SsCbm4XgqIXLot67aZ5xeh/GgMkP0CGN88XL6tEqXNOxuMR7TUmNIi8n9Kqi?=
 =?us-ascii?Q?u9x/IIk761uSbyQ0DGKcaCvfdBao4bS3tWkNyaQIY30JTt5bkdHinBIzC9eL?=
 =?us-ascii?Q?WX2RILI49qXpDSg5BtNdIiPBw9IBo/OB+0xPjAqSzNA6c1FJmGEkf5m8YyD8?=
 =?us-ascii?Q?OTFiaXhuRxqEnCY1Jh6sTuQ2UkiKrbbFbY/GQWXrPp0wW8nnaP3bNF1vreTF?=
 =?us-ascii?Q?SYcup8vQFMqANEDEruzPQDvva02+thtKR+ReMj5WbsTA0ZjudGhYvBh4NqE5?=
 =?us-ascii?Q?AvHZtzQzwnSfLgTzivmENl3kDeBrxTtAstU6d5n2V1kLkB0u2eXcwSMdS463?=
 =?us-ascii?Q?6BQvtu+wqBz75p3dWVMcXMC33fKzj8MlauNl4HJaEXSWCEtYf5rBMTdO3OqV?=
 =?us-ascii?Q?x7QsFjRed1omJMcfFBdvcT8z1nFJbikEgJgyg9KkwaMOpagGq5BsJCZ/i4KA?=
 =?us-ascii?Q?HguS87Ly/aqXw59lKaNjnShbapVn2+08T3Wa7DuT0CHFqXZpNvK+8NKZ5SSI?=
 =?us-ascii?Q?ZHUcc663cQH5lLkTEXwMV2xPhDq76DY8Qc0RPIhVgUpswPbCN5e7o6Ee5RZL?=
 =?us-ascii?Q?rTK875E19NcHdIUsOOGmd1UBwjLuPp2JBQV+jWGLHKO/RXnYwlBIDjxmWxmO?=
 =?us-ascii?Q?By7bMndCJ51jxvdub/QHKphgX9ZPUPzO0Nle+IhYb/F430Ijp7sVrrMjDuGb?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d49664-f9b4-4f26-3f32-08d997dbbee5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 17:20:30.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhHsxiC8e3pDmO9TK/o1yHyefNoUsMCvY9cBwNplPhHWtFPj4kK2bE+Gkiu3eBzQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3142
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: yW4-e2HpCQtooiiwGfjNFMvt1HhOdh4i
X-Proofpoint-ORIG-GUID: yW4-e2HpCQtooiiwGfjNFMvt1HhOdh4i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_06,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=489 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110250101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 08:52:59PM +0800, Muchun Song wrote:
> Now the kmem states is only used to indicate whether the kmem is
> offline. However, we can set ->kmemcg_id to -1 to indicate whether
> the kmem is offline. Finally, we can remove the kmem states to
> simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Roman Gushchin <guro@fb.com>

Nice! These states made the code more complex without a good reason.

Thanks!
