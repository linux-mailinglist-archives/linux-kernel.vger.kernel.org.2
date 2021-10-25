Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090C8439D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 19:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhJYRVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 13:21:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59054 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230183AbhJYRVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:21:42 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PH2BYe029556;
        Mon, 25 Oct 2021 10:18:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=tELLT9mii3ldwi2N/CA6il8iTrGIvuNr8TYoGJvHUcY=;
 b=HRZh94/ZVOHSH2VG6wCntjVloH+Gj1+79bd6iY/4Jd+qlWmZOMCDrRx7ltlKLRgAM2Vt
 WLfgoLn1evTBTLXMxjVVhFG4eLm6Y60hSXVXgAwRyBG3kfK4OvrwHXSS6O8E5Yii3SeW
 tyYbch6xCSmW8JdbPB4Ovc7NK85DAknfrns= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bwyej8tms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 Oct 2021 10:18:56 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 25 Oct 2021 10:18:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmyXDXNjaxx1jBMy9kq97L9FxoNB4dVURwlAr97ZJsmMEoNBGUfHZzHCobtw0I734T4e6Oe6KFL0uhIa973X6tbCoCg2Gt3sV57Ue54/bamepNTuMnGOA2V5HH0CsUHFAyu/8vSVI6le3/xuN6Vf6ZQC/ZfjLzIyz9Yzw40ZiyoZRKOE0cZG1e5qtZJEqMQyQ9at0UbBlqpssmIiQagCtLPth7yu5C246i1L66errTTTDhrDyGG2x7R+BXm0WjXBf+qTG1way7UP68fLS++qNliHOz7GEmNINF3/84GImJ65foIFqUC5+rFBci0OwuVT8J7HiTUDIh9Ro7lJmHYOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tELLT9mii3ldwi2N/CA6il8iTrGIvuNr8TYoGJvHUcY=;
 b=TwCHpaNNo0Npg6alxOs7NSLapPwpaykFJ3jUANTMhQ5O+SIGznRL7gq9GSFkyL9Zavsy/e9EaQGHNVbZhMJfAV3JVYLxezwoNitz8z/Un0gLKRdzdFBDTEeEnXEB+H2LfbyF9abATlxOS1Oq41D1mxcB4U7XMU++tQBeECpITPMA00keQO4S96t4WyPTwhmgnDFYxytnNhjq9bwCfkSrtlsB3GnlgBxNGG7Y/uvOwNU2g0CHMabI9aA4HnXFfwtSAgMmwvb6fH0VlOtxDmTTgGx8ZmcFhs0rjCgXNmU5ZtLW6XULTF3ssV4b79aFP1DS+tOs8alaKSYSY0E0EKPGuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2391.namprd15.prod.outlook.com (2603:10b6:a02:8c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 17:18:54 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 17:18:54 +0000
Date:   Mon, 25 Oct 2021 10:18:50 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <akpm@linux-foundation.org>, <mhocko@kernel.org>,
        <shakeelb@google.com>, <willy@infradead.org>, <hannes@cmpxchg.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: remove kmemcg_id reparenting
Message-ID: <YXbm+ow173NdCcP9@carbon.DHCP.thefacebook.com>
References: <20211025125102.56533-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211025125102.56533-1-songmuchun@bytedance.com>
X-ClientProxiedBy: MWHPR1701CA0002.namprd17.prod.outlook.com
 (2603:10b6:301:14::12) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:93ab) by MWHPR1701CA0002.namprd17.prod.outlook.com (2603:10b6:301:14::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Mon, 25 Oct 2021 17:18:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d921f065-5736-49d6-ce89-08d997db854e
X-MS-TrafficTypeDiagnostic: BYAPR15MB2391:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2391A896392F439CFC5FBA27BE839@BYAPR15MB2391.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+8Hvg8ywtWgEE1N8pvHXAyhactKqry1Bob+okeqD2MxTnog9qeM6QLNymDmWWspLSGT0empF8nX9akzoS99c/i59hIijUWWwtBjY0sFAMJSkaOJOPZwzhEQLItbbYhwVucztnK+AzlAGYtfkysU2pX++gfrYgRNbLsU1UssnN1SJsTobVP1JKMRfPGEbro6/4GRuUGlpiBu9PaMmsNZ6B2iQQFj+5j/KxHlEX/s8u75+qCnPaSy9z2+hqRFDtPt7FaQJkjGE0dYcLIko6Uamw7uGdlKXwJOprxniEteiOCdz7cW1ka4070t2XjXoVsG4RnL7dNeztmbkG3enzM7j/oyKWTHE/DisEUocxMNc0UuuBsdIqiVXHQmf/u1+W/Fen6IpUA6QrMiBZV44JEuOBnJa8MNy9h87G+h2fFa2Urk3h0ugmfvWMqDdJDSvXHfFiHszR61YJkbo3Zb7poxUVO01fjdKF+tOt0OkxiK4w2KuV/qdVpC/sHqxolDoeVHM63qameg7caQ87ipXhIJOlAKXR2jdZvOL6WFTQnYs9/G89ogKkHPAaXmQUGFbUdQfl2ziFPTov0sDgRlvB30zxEl4QD9KD4Ava1L2LsPprKmEoi0adA583LFqRAF64S4uSdi7yskWewFSBZ/faRG61j8ssez9dc7lvDUpdydK8lP4Ob2qZBEr4ee3gC/ESrT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(316002)(4744005)(38100700002)(52116002)(2906002)(9686003)(86362001)(66946007)(66556008)(8676002)(8936002)(508600001)(6916009)(5660300002)(186003)(6506007)(4326008)(66476007)(55016002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ha/w+0KVq/e08zdxPmaM7jNt0pMTiWvJUOugKQQmBm6OPZOlG+BRRpvwO8ui?=
 =?us-ascii?Q?edXRMdxxmpC1CUPV+dLF1V+L7h9Q6FxRNmYm7IiYAaup9bNz+032xW9tMi3E?=
 =?us-ascii?Q?V6v8duAaHQm6Ri+XSdpP+HsAunnWmoAT8puyoIU7C/UtrMdkDslSdbTDSI9m?=
 =?us-ascii?Q?ZoD78bJvaKwgeizIjh94ofv0RX1w/CywT0ngPPzhhlBCUFa90Odm/JErLod4?=
 =?us-ascii?Q?5oy9+VRIt+Xm5jvlcsNccJ/RnWN0yPMFFGqnAbahFf8Ia1mw4Av002cW3Gyl?=
 =?us-ascii?Q?zVwCJo2upNv5dhmbOWnzDiuENAryTvKbDf2rVMuMjhSQHPsGEew7GPSqZoOV?=
 =?us-ascii?Q?3g4nS6SFyvpLRfy7lwMzp8y9TG4sXoitLFDs6UWABsKDdD2Ap5ypEiYCwFzP?=
 =?us-ascii?Q?Dt+mnShlgUpbGZfLqkTtDxprHOUkGyXZKCuuWoXvoOAnUoLvad/7hhOGaHk1?=
 =?us-ascii?Q?rM6qU0ddYErpExVi1+ykhS23NfH6+ypVzCStWVqQDkIMeyRXcOTu9Yt1GLeE?=
 =?us-ascii?Q?ak+TQhy4zTuc+IO1hwGodG1LExOjY5djhahKbM/uc1Cr9N2zEPJgvIRKpPKg?=
 =?us-ascii?Q?A8w/wMzPlftDvkD2ra1nnkA5uVo/dtwSsHdLQ6Lbp9Ot+Y07CesE4Yh13mX5?=
 =?us-ascii?Q?c1Qp7DzYKlwIwnoc/N/T30efNXjdFqJxxhQwON7sWm7vrxDulGc/bQbTAHHj?=
 =?us-ascii?Q?YsefZgIDSmIpI/fqxylK1O8xVvGCZDrimd8//tJUtyjGCSVYusrt2e9zaMpC?=
 =?us-ascii?Q?1ilt3zk80PEy7RB116mNtRLkCq0ZxVnOxWWUm0CB+ehLOryOaQN4r33ZNRt9?=
 =?us-ascii?Q?NTlgyhl/3/g4k5TluRpLR4vZ83ytGPWT6F/3wRq2EDu6uoy0ZgJUaGedzJ4W?=
 =?us-ascii?Q?aRN/ICrcOpZLL/Jq13K/xgiqybM1YutQhdzGGRJAXITdp/vxn5fUt7/PyAlF?=
 =?us-ascii?Q?nR4jO2d2sDW+oIRUm6NO/elDpylhOEpvWWX77t1YKceENnMyg3vN/DVAzC34?=
 =?us-ascii?Q?l3VxIxH1PKJpMjRSZrsPzf3sXJn0yCRSNsEI7Z5x/a3lCTF6OIRGjCBINK1q?=
 =?us-ascii?Q?GvPYpzsq7mVJJ4bwui2RxZy+3+WZoAzmvP5AvjMXJwsXMVpm4rV+TVhdwz2U?=
 =?us-ascii?Q?C00OIcsSrirUAhkjx+jd5WgqDx79lFn63bUX2aS/FHhKVa6VFJfnS3UTW0WP?=
 =?us-ascii?Q?iNVT2GGEhc7P+NLqcdS75Xuf/xzC5lxsHbwvW7mHecvk/Jp/8e0dDTTKz5PG?=
 =?us-ascii?Q?+L0oqfWcVOUwUdn6F29NaZb85lSbsxGkdZv4ETnJtCQixpG0zfRsrGkUlQk1?=
 =?us-ascii?Q?4CW9110efVeP8tqAFCSA5iWJJDVPbnkVpK4xAjMHpsK0GG+GUtvSl3z2QIxx?=
 =?us-ascii?Q?xsFv8xgsKx5p5k1ITUhOi2qKYjol/yrgtclg5pxEsHkj0T341PMK4eScpnuE?=
 =?us-ascii?Q?ehHNBw2imgmfoHYvUkX2x8CroFbWxOwkxXgPQSWdwH+BTlJbHm7NVwvRB/Fc?=
 =?us-ascii?Q?6X1kAcDDCnHUObjYf7T09kLe5CwL17AvsuJ9jxfNDSVTYNrQcmGlzII3GPtz?=
 =?us-ascii?Q?VJw29o6aoUrC8ukFhYE6jVWHLgtYlZ92BndTqd8a?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d921f065-5736-49d6-ce89-08d997db854e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 17:18:54.2380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUs0e4Ca0hw52lfUCDEjq3G4TDnqiQ/zyuO/gQZ69D0v3CRH6eK8XU9B8vsaRQkL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2391
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: suPHFjAswg6gl_oH_mbpf8nYjKn6P35O
X-Proofpoint-GUID: suPHFjAswg6gl_oH_mbpf8nYjKn6P35O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_06,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 mlxlogscore=697 mlxscore=0 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110250101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 08:51:02PM +0800, Muchun Song wrote:
> Since slab objects and kmem pages are charged to object cgroup instead
> of memory cgroup, memcg_reparent_objcgs() will reparent this cgroup and
> all its descendants to its parent cgroup. This already makes further
> list_lru_add()'s add elements to the parent's list. So it is unnecessary
> to change kmemcg_id of an offline cgroup to its parent's id. It just
> wastes CPU cycles. Just to remove those redundant code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
