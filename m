Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20506437F40
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhJVUTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:19:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17154 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232082AbhJVUT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:19:29 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MJ9VEu026086;
        Fri, 22 Oct 2021 20:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ErSQu4Q6ZIVKOrLNn/mfM/RvncCDi+dQbGXTMqqUdG8=;
 b=ppS75qdj0iEjHZBJZF87L7gfcxrcxpDmK5IFJTXuZvW4wF9vIEpmNugO+Nd2nNh+vhzJ
 xVzb9GQ35pKvLKMQ3tGqtHA0GXzdGcBbjtPZgy6CO4QVb1esSBT69E+f3FII27yLqx8M
 UGnYzE6clWqP94BH7kHY2mKOPffHS6kLXpqwqECZNa+v4GXnUSLJiFj8XQ3MEReDumjM
 wE2jFvWP7R8ZwrPf84mOnySXxApfetc1e1+Uvh0br2iYdyvgYxy71N0MACOpuwDxlkDU
 +XfXA4wiZynn80vB9MwDbMzftElXCzZ3bDZzdwW1vhp0G9qYQQe6XeClLjwRjqW05KmN dQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bundfmdqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 20:17:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19MKBiVA051153;
        Fri, 22 Oct 2021 20:17:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3030.oracle.com with ESMTP id 3bqkv4abdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 20:17:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idq4vLl10JTb/krAdaFAyqqtCr57uHQRcSm0vF0ZHD/8lbXNHZ/Jri77gFaBYKX5Kt9w3/nOsRevL/jnbXBJPPFGHwARjJAIwg86dM4UIFJoirB3fLMk7n1LmViDTPf6DSRyyeleyeJaWtNNruo3oL3S3MN4q8SyPKPFKyV5wJad2TNm6wCr64XkI8CwoRuAsdLpKGdzgdd/u9bsklMOvLb6CduPg0Vsn0sfqt6zRLz/jI3/pVkNq9ZBqGRwP/ZQxmSLxsXM4gxzucjfURjhtDMx1wHOUz1CulbYI1CDwLHALzN4jES9HQcapylFtmxio2aFpO/nVJgzSn8qSkUtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErSQu4Q6ZIVKOrLNn/mfM/RvncCDi+dQbGXTMqqUdG8=;
 b=LZphrt4kOba61kq1jg+MbsiQz6yPeTXHGtj1xW3l6C5dA73NeWETCAW7UluAb0r7/jr6FSfKVIGTmJVkvqixoOreZ6MkCm0w499pfFoHdsuZxkg/s1AB1hYvZoGA7Xt0roFxnHUfWhMF1I7+dQ3/iBj6FpSIDUMvhontxPKz3UCMWHRdP3nehQDrVim1GPbqs47yA4RbeS7qe5CZZFcJtZKp+Tbc/22Q8ph7NHad3YVsKVko11AGwBqNG9Hx2XcN/UasGuQOwzMv0KkyjvaatWAwiam02FQP3dT/nPKMmMuGaC7C3tT54WdIHKra/IiE7g/P9W+sp579CNmaecKVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErSQu4Q6ZIVKOrLNn/mfM/RvncCDi+dQbGXTMqqUdG8=;
 b=im+4kyT+MBXb18+BpMlkm6B+dj3d46v/133zQvsT/wr+nDTS2f6GIJtyHUniqzt+xJzUK2Z8SEc1yK+1iOjddJFO9QpyCZbtQjxpUn7UA2zsQpDNWrZWBFmm+1pQreoUvfe37Q6nSjsBatLPs5T0AKpKGq2/0wbHT85hFPYPINE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3541.namprd10.prod.outlook.com (2603:10b6:a03:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 20:16:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%6]) with mapi id 15.20.4608.018; Fri, 22 Oct 2021
 20:16:59 +0000
Subject: Re: [PATCH 1/4] hugetlb_cgroup: Remove unused
 hugetlb_cgroup_from_counter macro
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mhocko@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
 <f03b29b801fa9942466ab15334ec09988e124ae6.1634797639.git.baolin.wang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d99cedb7-1711-dc16-852e-df6ea9f450da@oracle.com>
Date:   Fri, 22 Oct 2021 13:16:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <f03b29b801fa9942466ab15334ec09988e124ae6.1634797639.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0332.namprd04.prod.outlook.com
 (2603:10b6:303:8a::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR04CA0332.namprd04.prod.outlook.com (2603:10b6:303:8a::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Fri, 22 Oct 2021 20:16:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3be02ea-70eb-48e4-dc29-08d99598e704
X-MS-TrafficTypeDiagnostic: BYAPR10MB3541:
X-Microsoft-Antispam-PRVS: <BYAPR10MB35411F8F79852DA6D52A40B0E2809@BYAPR10MB3541.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:257;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MyCbAL+tppKp3rQ64dGkZ2EJ3+hDryfDhgRV0xidhJSf5UHp9RaZ2I3FNmsPjMG2heBPGSb69TZkeKx7SvsX/JCN3yJAfAjcEX2uRfxhl+lQZIuaSfQU1aHw8q228KZd+VMQxedUru4GjMnWd3T/OD0Cg3URYZenQFkgCyDb5rl0i84QR4pZ+xeQxauAazxoTwO74jdytwP67fnLJmxpIXfox+fin8wJnwXKrAsuGtMs9F8z1+7nOO0WSI7VpoyFGZoAoBgyEnaR9VzfSmtJcWSut0UrPaFFxjES3ws9B7C/TtwK/xNfeT2dMO7fI8jNmgH+mbJHjoWvPXyqbrUVC6QCCvpUnaio4DrTDWGZNFFgMV/yagilwSbdIvB7kaJ0fZJJwvACXM7SjYsYC22ph95HGC9vZJuJPoDZElKu6cf41xOArisSfMntTsTGabQNnQeA3gizoSW674aKZrfNpkcMGLo+s7pxrJTlDVRFW5frdcSqOF73pBeu+dUaSdHG+xqgwG1IsFLIZVO9ZGpSeycdRrfJY43tWL0KXSQ4FLi0hTkqsRTQScTTbgnfV/q/rXVo/E9ymoTyny2vzP2iGZQmCa4aQwCTblxYbIL98fonQAfa6LaWs/4PEsK/uh5WsG4l+Vkew2odyj3BaHuRjOP0qyygPiasBczUuWLqltsGWFiSehUAhJNgc1kxc49pT2ZIlam+H8RHtxEdJA4S2vX0019qb42x8tW84d/zViWW4twLbVKNYHDm4TPvw1gxlcw2P4pOS7vuWWWWZN0Alw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(2616005)(2906002)(8676002)(508600001)(8936002)(26005)(44832011)(16576012)(6666004)(31686004)(52116002)(36756003)(66946007)(38100700002)(5660300002)(6486002)(38350700002)(53546011)(186003)(66476007)(66556008)(31696002)(4744005)(4326008)(316002)(83380400001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUx5bzVqbXh3NWl4S3UxU2ZVaWRneDhuTzcwMElRUzlDVlRKZzhIekNLTTQy?=
 =?utf-8?B?ZVo3VXV6NXBZQ2lISk84a0JzK1dIM3ZZVmVvaEdScm5PSEJTa1NSNzQyWU02?=
 =?utf-8?B?WUtveDVNVjdqcmg2dmVWa1lTM3I3NzVDdThBbkphVWE3a2dSWlFaOVA2V2Iv?=
 =?utf-8?B?bktwQmZNUjlSdWlPOUJzazUycjFxeHJNeHZpTUVydTlPTDNkbTY4UTFLZ0JZ?=
 =?utf-8?B?Z0FYZzl0ZjBzV0NtbDlGeEZWeEFSRnptRnNUYWsreTErUU5EOW1mZjVzRS92?=
 =?utf-8?B?WlhUbzBqZ3lrclFGNHFHR1ZvdFpGL3lGcG5wcEphNkNYdG05eWdIa214ekhY?=
 =?utf-8?B?U1NMckxEYThORmxqS28wVzZlTW1TNzloRmZtYzhTYWhBQVZjWHUzSUxPTkgr?=
 =?utf-8?B?WitIcTBFblBqMGJ6cGh3SmlBVkNSbVZFSE1PWE1UTTlNakJ2NEhPOEcxWDM0?=
 =?utf-8?B?MExobVhRVGZvNk5JTExKc0dlWHRqRmVrOG03cEN4djR5VzdnL1NXZFN1RmZJ?=
 =?utf-8?B?V0hsK01MUWJEODBvUEI1eHpldjlrRWNHVW1VazdyS09ESW9WekJPdFZKdnd1?=
 =?utf-8?B?WWJzN2V1cUdTQmJrcVkxU2Y2dFpJeUxSUTJiUmdHSDRaOWludVdWSFZsT3Ur?=
 =?utf-8?B?TW5lWSs1N3hvV0tva3loM2tSbmo0dTR4TllKTG1OeDlsN2JiVW1UV1dtc1hO?=
 =?utf-8?B?Z3Rtc2xMLzltRFF4Q3FOVC8rK3gwUGNuQ29ob1ZCeE1FR1ovYWdWVVlROG9B?=
 =?utf-8?B?cmRJc0dSblh2NFpBTFFzSGJLMnU1NG8wS2ZsdVR3alFobXVVQzVBcG5HUmJ5?=
 =?utf-8?B?TnFkcnZUbHZqbkR5YnYvZFRDbHlPREs4UTRod0hOREUxdWM3WjNya01WQUpH?=
 =?utf-8?B?R0VCeEJYUkI2bGZvRkphYUNPYTBsSVJSL0Rub2VpMUJ6dXdWQVpNTTREN0Zo?=
 =?utf-8?B?Z2FBRk00SmdQRGlIZ3hQdGFMUkppaVN2SjRZNjlFZDVEaUllMW0yc0FkckMw?=
 =?utf-8?B?RGVRb2MxblhubWhqMGNtT3EzVUxMTWtTNEFsV1FwSmNzTkVNcGpQS0s3VzN2?=
 =?utf-8?B?Z2daWmsxK3VXSlQ2Qm5id3o4ZXRaNkFJOTNEMmwvOWYyaUwwRTVvV1I2QnRi?=
 =?utf-8?B?N2xvS2ZtMnRLRWR0d3BPdnAxU3dGbG5yZXliaVJMUFFYQWxNUE1udFJCNEpN?=
 =?utf-8?B?cU9sTlVKUXd3S0p5cVVIY0puV0sxWkpOWFdITnY1WDZGcGd2ZS8vRWh6RVJM?=
 =?utf-8?B?NkJJeEhmNWZwbjRmQ1AxS0FMMU5nRytuZkFydjFlMzF1MjhhY2RTOSthVVdl?=
 =?utf-8?B?Y3F1MGZCWHFVblNYZm1yQVVKMkdubWQrREx2azI2TzRKZm4xdWR2amhYM0pU?=
 =?utf-8?B?QVovbzZ0MEdsdDErYXJWMEVzcGhCMi94aGdQSHhxMXkrMElpNWZUdmJvckV0?=
 =?utf-8?B?K0pCWnhFckUxTXBHejlzTGRDdFhNQ0NRd3BrUlhqN003N0dtSXVVbEFvZ3V0?=
 =?utf-8?B?VkRWSjNKMTlKQUh6ejFZaGdSaGVVcmkzZHZrTGVpKzYvNW1vM0R1eWpOaVJF?=
 =?utf-8?B?aGllVTZ0cGxhVzhINDQ2blVxdXRQSWt6YU5TNUZzRlRzWFU1emlzQzFEeEQ5?=
 =?utf-8?B?elZJSFJxSHNRb3NmRFA0ZzhYeHNHNFZzVlpqbTdpcTJvbUJTcDFVc0IrT2sz?=
 =?utf-8?B?OUdnYURjd21lY3hKRnVXS3BmRk9DdXlubnhWME5YWWVkMkpOUC9VQlJRejd1?=
 =?utf-8?B?RVR6ckdqbVRoMjZWclVhNVBScGRKaGVNSFM3V01WcVQvZm84WExNQ05TRHFI?=
 =?utf-8?B?OXpGQ1FjUEdBaFI5VGs1OFhwbUxodmpjQ1JqSUtJQzJTSWd4cys3T05mUXlp?=
 =?utf-8?B?OE96UnUvTGFnamdRN0ZCZ2tJam0vWWM0c2lUcllFR0tmWXJuSkpiUWpQdTFL?=
 =?utf-8?Q?QHvhMpMU1/E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3be02ea-70eb-48e4-dc29-08d99598e704
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 20:16:59.5010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mike.kravetz@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3541
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10145 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220113
X-Proofpoint-ORIG-GUID: oMj3W1JpdQw-3X3ZzTBLl5saX6yPCMth
X-Proofpoint-GUID: oMj3W1JpdQw-3X3ZzTBLl5saX6yPCMth
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 11:31 PM, Baolin Wang wrote:
> Since commit 726b7bbe ("hugetlb_cgroup: fix illegal access to memory"),
> the hugetlb_cgroup_from_counter() macro is not used any more, remove it.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/hugetlb_cgroup.c | 3 ---
>  1 file changed, 3 deletions(-)

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 5383023..79d9353 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -27,9 +27,6 @@
>  #define MEMFILE_IDX(val)	(((val) >> 16) & 0xffff)
>  #define MEMFILE_ATTR(val)	((val) & 0xffff)
>  
> -#define hugetlb_cgroup_from_counter(counter, idx)                   \
> -	container_of(counter, struct hugetlb_cgroup, hugepage[idx])
> -
>  static struct hugetlb_cgroup *root_h_cgroup __read_mostly;
>  
>  static inline struct page_counter *
> 
