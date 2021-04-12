Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B55D35D05B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 20:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244986AbhDLS3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 14:29:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59974 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245046AbhDLS3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 14:29:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CIFkKd094097;
        Mon, 12 Apr 2021 18:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=cJ6li/Kwa4UnlgUolRT3YB683W9laiWP2P8HwQuh86k=;
 b=RcQQcl6/04AwBN8Muk+blkpQnnlnwR1/EXTl8hD/Arc6I9iaus5OZhrGYI2nMVDi3F1L
 L3NSA0jTPnwPrx5oLcwpNrWNPZFxJEJxYQhdktMeoh7DCzT8VFFpjpGN2SxBjF2tOEoh
 IFGTWUkhqAC6rxFaSs/qJKGIMYFKUugjrUDIL3zlOQYRB5un7Tf69gAh7QrbkFLr2z+7
 EgeUH5tRFnU2n1D+K1vjyp8Pgw+64d8s42UZl9lWc4/CVnbCmVehcWlpV0JROsvslUVa
 fUvUXq/J/kWDhiJeGkIAy99CDykLuLZ8Ha+U8eFK19lM2sjBJiM6GgiXsDTHJqlyLVF+ /Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37u3ercqja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 18:28:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CIFPks044119;
        Mon, 12 Apr 2021 18:28:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by userp3020.oracle.com with ESMTP id 37unsr9em0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 18:28:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxTQVC7CSAG5rhhBBHbEDsW2jh9FQfjM1x7HcmLEAacPXhRi2rJUTPt/hy6+N4TOAGmKRo57K8Msc+kPqI+qq5dh+WBWvAD1ECIoOIAT4qp5bfUDDBAZ+DD0Nw21J4YCI2D4N5uaOjSOTvJ152k8dwgY6qxrn/tp07CgapBZDXxey37Es5GlQzAkpdBJLPYoTM8vhWg5xcroHV6enS8yrRgCr1r2v03KdeL+DUaLCNnLUJi8HYi2zbQyqTsZkb8tfrYnPWCrHbXp+AiRMf50MjyrzJ9LFKeN87LHqKfocoyjPBou/57+Nq9mgkwgoCfjspDPPSt4W5tpayrqjyDEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJ6li/Kwa4UnlgUolRT3YB683W9laiWP2P8HwQuh86k=;
 b=kEpc4VjbYfHV/jokaxooOlAhGcB7VhBYMgFSo3eKRR+zEo48wW1GxLzJQSru2iaQ28nH8kTT70qWPqOiMdXXQUZN6vE/S4fHZCgF8KSTD2SPrvPQAwTeaSsl8hYwg58mssZDktFkJ8FA9MAPj3hVgLKv+gsUjW/+cgyLVJ6auOQYr+iTF1320ENg/Nj6Prx8q7794/yNyRuFY0optmmRgNiDVWLN3792R3zCmcqoJfXSRFIy8sMI9W3RcuUkldxzBD/g3WHF0vtJBtITvL1NZtJIX9SoZhqY+xTIMQW8QWVhstnF1ZcZ9i2PEBsvn8990nRhgF5z1utb4u7/41HV1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJ6li/Kwa4UnlgUolRT3YB683W9laiWP2P8HwQuh86k=;
 b=QukjDB94kh7LYg6E0NWtn6hNZyomgDDkxnf2FEJST79rIqGreXql4Oxqa7m7r3qdpttSHNEMDsCjtffraNQAF4qF+w7mKPDtljHR3zKk45zcb9784Dn9DFVy5dhbpRFY1jgLg1EoFZfsvu1+CIwng+SfvJ+0SLgrmmSwqPoVGHY=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4371.namprd10.prod.outlook.com (2603:10b6:a03:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 18:28:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:28:42 +0000
Subject: Re: [PATCH v2 3/5] mm/hugeltb: clarify (chg - freed) won't go
 negative in hugetlb_unreserve_pages()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linfeilong@huawei.com
References: <20210410072348.20437-1-linmiaohe@huawei.com>
 <20210410072348.20437-4-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <23a4924a-2881-3c5e-b70e-ece65a0cb7ca@oracle.com>
Date:   Mon, 12 Apr 2021 11:28:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210410072348.20437-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:300:4b::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR02CA0013.namprd02.prod.outlook.com (2603:10b6:300:4b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 18:28:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff0df141-c9b3-4ff1-d02e-08d8fde0ccee
X-MS-TrafficTypeDiagnostic: BY5PR10MB4371:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4371203EA46A42535AAACE55E2709@BY5PR10MB4371.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +vW9bauo1Y8DbXMCljEQgib0B32ebIZXm/9k9FUrG+rYxFOc5Y39Oz5qdEX+A4LruVITOwnf2Yg5/d12b528ogN76p+iv3dWOaA1mWhU7jNsmJob6wp5iCQn+uZljiYInBc7BH2cmSmhuca8zez9Eapok2+kWFh6RI9K6xNTIfEbfVndYPDf7lXxGz1J71segzJrV+CdBEQSp5hriS8IcFFudmn6Z+3WZQtHUcigXUlxwlxxHh0bf/Zh3UJd94VrDQrpvnxlMv8NShGBsCHx8ZyrprSmlhJqfY3tsBOHn3CHUoI0AtauC79F7q1K0bTXnHAp9NCH5FeNvsFDBb8TAy4VjCXeGKmooVvEzlvz77J8PnvrtiLhLW7jFdrFaakj/MMRCHCI1Zcpgj+9ExwD5d2Jk7HGm0KsH8BeYV+N9WD7Xh5BGSoycMriE0ZJKiCyU6oISoJuTrGemgOrAJLSPc9Oaa9a8MBrKqtsTyFVOOY90odDO9yxjRYkDAsdKs9RT790KT48IcsYcCw4gqhJaKb7Z4iEydsqrZ5A/mgdW3RNy0ktOkAcIHvA8tFHFbwwc7bpyPOnqARu8VRtAybmkVR7DGfsM/69PRZkwnZXXIU4SQoAKMaJVWJMl/yAdlj2NE9zw5vehomTZ/AgYed5qlJX/MF+ASMJj10C2ZTHcx1cnmQaLedu1fRv/renngB8Utn8+xhYqMFiLm8y9ThfR/brR/Ic4PBAeU8PLxCvJ6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(396003)(346002)(136003)(2616005)(66476007)(66556008)(16576012)(956004)(86362001)(8936002)(26005)(5660300002)(6486002)(38100700002)(4744005)(31686004)(186003)(38350700002)(16526019)(53546011)(44832011)(478600001)(316002)(52116002)(2906002)(31696002)(4326008)(36756003)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NU1PdlVZVURqV2g5ZHlvMytZL2sxblN2b29pWGZEZ3RWZW5ma25YL0xHQWI3?=
 =?utf-8?B?RWNCbXRaR0wzY1R0cFdrSWtRdWFoeFRueXIyVC93UWN4MDlZcGlEMlVRbVRr?=
 =?utf-8?B?eDZ2YUkvWjErNTZKMzZhb2QyL2ZFY2ltZlhOWk1ubXpEdll3N3hpZjdsV3Vp?=
 =?utf-8?B?NUZtZ3ZxWHg4cXZ2ZWJlZXpyVXcvS3RWbUU3SStUd0JTU1FMMnlQRDV6Rys0?=
 =?utf-8?B?dTgvZHNvMWxzamdVN0RqdTF6cEVnb0kva0tKaWo1RzZGaGM4U3hDRlpRQmt2?=
 =?utf-8?B?THdRV1dJOC9DUFg0SlArcDVuajJQM3VNem5pRW9MZmQ2aXpxTWNtaXQvYUJC?=
 =?utf-8?B?djdTdWJYQkx4Wlhpc0lwU0tNVkVxd3h5UzlXMGdxR1NpdUp0djNGdUdNbGxv?=
 =?utf-8?B?RFNQTG53WXpwS0JEdSszdnByS2tsT21YYlV5V21qVENuMFR0cEloenZxa2sz?=
 =?utf-8?B?TzNsTWgzMGxxL3N2bzY1VWIvZmZIWmtoVTR2UlJjenlGUXpPUWFkRnF2MTV1?=
 =?utf-8?B?N1N1Q1d4NzhxTVRmazhUQVYxdVFXVHJkejFIczh1WktYZk9JU3VpQWRlaGUr?=
 =?utf-8?B?dXZSdTZQbXdBV1dOdU9keG1OeU5Ha2h3Z2JiSGw2VW16UDNTbWVjSkRpY3ZR?=
 =?utf-8?B?WXdNb3kwSVJSa3Bqb0JwWDRzdG5PTVZ6VWhGcnR0ZGdodzRiR29NTlRreW1P?=
 =?utf-8?B?eEdhL3p4MzNKYXZzOTFoVS9rbXZyc3EvRWhPVFp0My8wZnVPdFp5aXdmV2x2?=
 =?utf-8?B?MmZRWm5WRStBd21wTUUyNHZTUVBZK0poa2s1UGtxZURzVlhaQnNZY2QwRFE1?=
 =?utf-8?B?WWpMWFgrYm9CZ2tONjE1NFlTOU1qaGtObUoxQUJNMHFiTW0yclhXdHZQQVRx?=
 =?utf-8?B?eHkvcUY3dFl5TDFIY2lHZzd3UTVjeU04OVFzNjdtZVBob2lmU1BOSmtCMWZ1?=
 =?utf-8?B?bHRBaTI4RlE3MzhHV09TdTBVak5zQUo4MkxJZWh2VGpINmhiV1BaYXZsOHc1?=
 =?utf-8?B?eGQ5V3dUUmhXRUVZYmFGOXJtRmxFNmE4MVNKNXVqa2JqbVhDbWJBZUdJVVpz?=
 =?utf-8?B?aFYzNmFFV0dDYThqcC8wR3pORml4VEVsdmxNc3BneDZQKzNrOVVjK1A5bDNS?=
 =?utf-8?B?Z011QTRmQ05kU3BWSFg1ZnFZelNwN0JtZDA1TFdyeFFFdHBnRG5WVUQ2YkF0?=
 =?utf-8?B?YVNvZ05ONDhiWk4za3ExUTEzQkMwL0g5M0RxZFM1WEpVSitZM2twK1VCeU1G?=
 =?utf-8?B?SnNYd0gwYnFsRmQyNkgxdFVubk9UR3did0oxbTl4dkxWeGljOG1taXc1b0xm?=
 =?utf-8?B?SFovbmwwdzRZNHY5cWVoaUdwVFdrbGd4eThzdElyaE9FYXhGODBpYVFPMkY5?=
 =?utf-8?B?Y3k2S0lxbzA0WHZhcGU4RW9KRFk4aDZIQTluOXRqTmkzNkwwYW92TE5FYTJ5?=
 =?utf-8?B?RVRRTEJpYlhZSEVjSTZadEpEUy92eEUxMk0yMTRMbkpISEc4dURya1RwbG15?=
 =?utf-8?B?clpmd3ROaGNEQk9uVmtKY1NkNTFyOWlsUlB3Zk5nWFZNS3ZOTkM5d0ZRTWhD?=
 =?utf-8?B?QWhKQlgyMEl6OEM0aDZjUXl2cDNmaE1YSW54SFVLWTRJWUIrYlNXSXdud0ZZ?=
 =?utf-8?B?R3JQNVp0TzhjaUVyU2t1N29SVWJYRDJYN3NzYlh1QXh5elZKK2ZSS0JqeTBV?=
 =?utf-8?B?UW90QUpoek5QN1ZIc1k2OEFmTEh6dlRFUytyejMzMFJZQW9qbTZWdWlLaHNF?=
 =?utf-8?Q?i7iUIjhQiT0UoQlcCQFu/FeE4L3E2r1hplZN8hj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0df141-c9b3-4ff1-d02e-08d8fde0ccee
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:28:42.6714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvJNvmm/w5xITaWsd4R9mb9mUse6neTQ04p7+NgdFnX3zDFfA3rUWQtrTHIvEOXxxREub4xjnUsDkZaJYDPrzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4371
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120117
X-Proofpoint-ORIG-GUID: DedbmyiH_VipQ7VAsPJbmFIDU6KN10Xm
X-Proofpoint-GUID: DedbmyiH_VipQ7VAsPJbmFIDU6KN10Xm
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104120117
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/21 12:23 AM, Miaohe Lin wrote:
> The resv_map could be NULL since this routine can be called in the evict
> inode path for all hugetlbfs inodes and we will have chg = 0 in this case.
> But (chg - freed) won't go negative as Mike pointed out:
> 
>  "If resv_map is NULL, then no hugetlb pages can be allocated/associated
>   with the file.  As a result, remove_inode_hugepages will never find any
>   huge pages associated with the inode and the passed value 'freed' will
>   always be zero."
> 
> Add a comment clarifying this to make it clear and also avoid confusion.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
