Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4D239076E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhEYRXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:23:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64392 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230362AbhEYRXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:23:44 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 14PH7dCX025144;
        Tue, 25 May 2021 10:22:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zjyRsn+12dd6rgiL5Ds0NB3j+w5QP/tL9/h7CVVVb7I=;
 b=VXh1eeZofoB6DEPefE/om9t2M7IXM3oeWMgnuIgVo/Eb4QA1PgM4EU3fSQfK3oirxwkT
 1bLiWiJ6WcW/fzZm5IWVaTRWK+j4//SXxY+8dSddPe6wROeYSqbRy/XYqCsDcLiwF12r
 dwDEvbTR/lamuxc5MlRZmX1ZdGJ2TkDSbuk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 38rjj26ca5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 May 2021 10:22:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 10:22:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPhu1DemNv+k3iixjmEWXJIyFT9TE6AYyUfK+hvSjAJwqozUMYktRdE7CV0h4d8PfwY3JlA9HQYGnspOunaNo95qMn5lDu7vCjWR2Elb2p92bS4deqCETemArNfzQr8F6nY7q6eYtaIZl75KkGblnSRLmABMs08l361iLabb83wgVt9WfRiHSvJ8Ra/niWu7w8hmAhYq9jc9jkYLmdtOvGugrwAuWCEx2UWUadUwtwCJI3Yr0UNl+mgs5Zrfg6qXrd54OXa0CT6kcNjAqJt85hilKL78qAEwh7mjjqksM9J9463hQOxDfNO2jrFcmpwyKsRCPhxPznLu+MW6x22RmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjyRsn+12dd6rgiL5Ds0NB3j+w5QP/tL9/h7CVVVb7I=;
 b=ajFM1w5TKSmM/o2mrfJ6gjU9fuSub4/ldhthjZ1lcMiI++ujFUGhu+k/imicElHU99kSjc5Lc+ZkX26JeVivNW9Vi4VhdAQoDOLPpjhQ/9ns6ULzjq/UBqawk2if/sXohQBScFM1z4xo67nki2PGP7ruw/ZbJTNs73czYmvNppCsXDP6I26WZ1Ay/TYdRMmroYtPZqeC/hDWg3lGYmBbSZEpU48uQZAa6CZeSPtKtFS8P3tqWew4YM8bWxzYNBJi0e16Jw6uGQgUFJfuiH0QFvRGOxyIHSgJI3z5sLpicflJzdKrjhxTs1mIAq1VQm4rBCII7HNRt/5Hb3+LrQzUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3288.namprd15.prod.outlook.com (2603:10b6:a03:108::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 17:22:01 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 17:22:01 +0000
Date:   Tue, 25 May 2021 10:21:57 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>, <bsingharora@gmail.com>,
        <shy828301@gmail.com>, <alex.shi@linux.alibaba.com>
Subject: Re: [RFC PATCH v3 03/12] mm: memcontrol: make lruvec lock safe when
 the LRU pages reparented
Message-ID: <YK0yNQGu3jTCFTD8@carbon.dhcp.thefacebook.com>
References: <20210421070059.69361-1-songmuchun@bytedance.com>
 <20210421070059.69361-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210421070059.69361-4-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:5cc2]
X-ClientProxiedBy: MWHPR12CA0034.namprd12.prod.outlook.com
 (2603:10b6:301:2::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:5cc2) by MWHPR12CA0034.namprd12.prod.outlook.com (2603:10b6:301:2::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend Transport; Tue, 25 May 2021 17:22:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71984d87-0445-47c7-3880-08d91fa19bf0
X-MS-TrafficTypeDiagnostic: BYAPR15MB3288:
X-Microsoft-Antispam-PRVS: <BYAPR15MB32884A2A1CA86EB1D6730B5CBE259@BYAPR15MB3288.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQ4/SAcRKDnNRJzYIKnCm8TsLc4+Zcd6KRgCIqXag0HRxALF/yZuU6ymK51gmATI7fx55wRi3gMV8pRSn4WDwB1uzA5BtNJz6lpjI1wcmgfOUvg7uQ14xYesDtFkA4B5NsvdSwKaSWblObyZowXB2l8x+kFsGx4rWUMDuH672QH+cCoqt/3H2ttOKH6c13bEcjKyeulTHFrlG2vDJNutDj5FCpMgCPed/Glm/Emy1hBzFnej+3tIXRde408fUDveayhDrJqv9Lfa6LP12zdi5BncVkhe3f2Tb4BXk+GQA3FSqXY9yUji0Hej4ram/rmLftJ3sBPBQFIudfqvtScfd5qQxE37XIRTGFe2PLMJ/n9Z+F5f3qJ8Kku8mOvzBHBNrlv8ffsDN0mTLsb0sFqnspM+kffung4Y7H9gIct0Fnol188EPlwIrSvcophEi3ZjvO48LaLUU3+mjP8WkXtA+b8nIkbbkyPcqf7UsCUtvxTYBXZTik3e38lKguFTGZJeHqAAsq1TMEpMSRzor+oIYwa1bxtp+qpY4Uka50pCmdXeK7zeadLX2b0wK4L0EpcW0uC+w6FV7wwA+L/nfV+iJWm6xAMBFtQww8QEICadm1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(9686003)(8676002)(6506007)(66556008)(66476007)(16526019)(7696005)(478600001)(66946007)(83380400001)(55016002)(52116002)(7416002)(8936002)(5660300002)(186003)(4326008)(86362001)(6916009)(6666004)(316002)(2906002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FRGjtuHlgpNl+ViXEriekyCEj6iW/t7TTmp8qDZD2HCyttFHkhec63nV6JKR?=
 =?us-ascii?Q?xEWrKPv74ZDAA+CUMTY9DsHvTZVIDnUbB3Ty1Jt+9o573rFAStWjMY1tOapw?=
 =?us-ascii?Q?Ev6gGDYenX55LUeZgC3a9+serf6aKDF3i2h8cpmu29uJ7zcPKPUb7guca3yu?=
 =?us-ascii?Q?H4DzsaPd0hIqXt7f7vDtUb6sXF6KGXDLgROruZJvFmIYeeZwcGS5zHWnFsFX?=
 =?us-ascii?Q?vwo27chWPeXsMcz30WfwOlOa6eBan50H9sjiafTFpnOPmOQGP8wcihca2jBd?=
 =?us-ascii?Q?AvdKMnhwYMlod7CwBeuT/hSQ0KtiMxiPTQGDZ9FXSSy+wxHncF9ykND+rsOX?=
 =?us-ascii?Q?D2U5l6MRx530Ij3TEJm5uevDYYI0o2VGi2a6eYPY9nVDXAelUoVUJjhurkt1?=
 =?us-ascii?Q?P8+L8jwOSSVOMEqDzgIK+OK9chabkpenAVSkurEOfTd3PA9k8UUtd8KLYOuS?=
 =?us-ascii?Q?aZVKwG0Lmb34cf/WCTd/XkGLHLf1N+0oACPVXjBEUKcsO742Fd4s9wed3ln6?=
 =?us-ascii?Q?OmMyQFYlY4349jYAg35mc7XhccwlTN6AgMmYKIFKlg910WFfS+6IEnAKgDra?=
 =?us-ascii?Q?gD0ynlimKenbUVX6lAnvHd+xpfJYhKf+7T2X+OMgwEEmhG2n9aJCseHmcAHG?=
 =?us-ascii?Q?c/YrnDdHZeWaZRT6Sl00qxjOSvTqinKZ/NkH9SSB4llfGx0IHro4Fxx8sdop?=
 =?us-ascii?Q?1YvjplxJJp3kjqG/rY6DP9cpOcfK7gO2jGi2fVfvbUlCqwn8Y6l/efcgqGUz?=
 =?us-ascii?Q?ZVkh76nHsYl/yv6oqGAGBOQyKVXwh5xWAvu3OcKzNUPpGgyhEwNnc7i7dyLt?=
 =?us-ascii?Q?yFoVT3Bvig2VKd014YZwy0BqaVBaGn5E7PCpU1z/uleMrLyHi1efLBwidyI8?=
 =?us-ascii?Q?d5x3R5pKe51UjliJYjSG/7bo2nJnaMAJjEpBu0BJGVGdmC6vXKYY+u4VsGT0?=
 =?us-ascii?Q?b/8iM3CPw8mxrNR2g+eekQGiwCT8LAkSihIeU7bHaFU6nbiYyiy+FtWDR6Cq?=
 =?us-ascii?Q?AsPKtfsyh7CHX0AVhceYM/j6NAnfiMIfWbZZ8wazLBlcdC5T+3w4jawHUVe8?=
 =?us-ascii?Q?MzhlaUkLLVFi0IS9ue/XUi424DZCQx2cmCk901JsEMQXAq4zrxSDsiDbqzkE?=
 =?us-ascii?Q?gq/y7DcOcr4hb5W+2pGNgRC/owRFWpTiFVnJ4YMA3AxbxAp13loTSZAiUo/P?=
 =?us-ascii?Q?4yxhrs6Y0ywlhzZyB7BrW3GZLQxJYJeoTibfa01Xk1kMP/z6SMEI+256ulDB?=
 =?us-ascii?Q?bliJy5P/g9ZZ/VEb5E0EE9gPuFvCCzWeng0jLP0QDNzetJe9R6Hr0hxALBna?=
 =?us-ascii?Q?XnNL0TbG2tWCvjw7hOqcGiMk79Yaes/oRdBouLEmEb+MTQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71984d87-0445-47c7-3880-08d91fa19bf0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 17:22:01.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: un90LGFufARSTjnivoBlNwAPaopNMCJE9EE28BD9AWnWeRZbL0ARITgtDgSAK5+o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3288
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: PmdJrOm44Yapo6Mb7Eh08dn7144oadjc
X-Proofpoint-GUID: PmdJrOm44Yapo6Mb7Eh08dn7144oadjc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_08:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 mlxlogscore=841 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:50PM +0800, Muchun Song wrote:
> The diagram below shows how to make the page lruvec lock safe when the
> LRU pages reparented.
> 
> lock_page_lruvec(page)
>     retry:
>         lruvec = mem_cgroup_page_lruvec(page);
> 
>         // The page is reparented at this time.
>         spin_lock(&lruvec->lru_lock);
> 
>         if (unlikely(lruvec_memcg(lruvec) != page_memcg(page)))
>             // Acquired the wrong lruvec lock and need to retry.
>             // Because this page is on the parent memcg lruvec list.
>             goto retry;
> 
>         // If we reach here, it means that page_memcg(page) is stable.
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
> After we acquire the lruvec lock, we need to check whether the page is
> reparented. If so, we need to reacquire the new lruvec lock. On the
> routine of the LRU pages reparenting, we will also acquire the lruvec
> lock (Will be implemented in the later patch). So page_memcg() cannot
> be changed when we hold the lruvec lock.
> 
> Since lruvec_memcg(lruvec) is always equal to page_memcg(page) after
> we hold the lruvec lock, lruvec_memcg_debug() check is pointless. So
> remove it.
> 
> This is a preparation for reparenting the LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
