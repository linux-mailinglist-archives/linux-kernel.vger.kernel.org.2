Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70A042FE0D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbhJOWYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:24:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53586 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231343AbhJOWYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:24:32 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FMFEIK008575;
        Fri, 15 Oct 2021 22:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8gqoK9wDPx4kgDYjzz5NpqAF3v8CK+KG5cAMtb7WiOg=;
 b=hozaRT51rK4llapUrx2gKQGLqRXrlGAj8rpsAy4E0KLPNIryh535J8EyaCjjQG2rlZp9
 Bz/vqmq/xab/UdMRcYyX3foi7ghu3DWYhn3jKOvZ1V7pXI92CHWrU2V3ZMTKytO5wy84
 +FZQtNwsF+D0RXmM63qe32r2Ft0ZSNYSWdUCM08hXfkGy5ubaGElJvYtxC7dfc9a73GB
 t4qxh6tV4PUfZWcNaEQ1mDd1BmHunR7GhphqfwZtUVUAOWtkAz/s7N3KP+GDfWgXAFya
 fwiQLpMEOGwiJpI0AeFdjUpqsCDCrSY4hbKPd1AsMfk62HprY+4TVDkyA8kv9IQIlfIR 9Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bqfjk0va9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Oct 2021 22:22:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19FM5JqE081656;
        Fri, 15 Oct 2021 22:22:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3020.oracle.com with ESMTP id 3bkyvgdswk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Oct 2021 22:22:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ3MqXVTS2yKC0tJwpo/YdkO8wkAV9LVeNek7i2UMqis/pi4gHVnStJxdjcPNltWNvUWf7qtJrlbnYYbSB6iBls40pw7j89ae+EL29p3I0CqNYWppjB+Wy26cu2aGIk+fYcZVWtua2uzdoVKEvQwPpWda/3B4SaxY/pyMgMHcFOQNr4HNRpFtMeOeIWqnK2wcfx3dK3wfxAS2b9++iqB/Fb75f0eegcqjDq7Xwu0YUYmRlKpEQVyUfO2OIpcbzwoXiYh4wBW6LXU48b4fRDOg46IsEFNrpRofaXRRbvSuBNX+ogQgEIn9gjBSDOUO5B9OUdXo8pDWaYrkVPC8afvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gqoK9wDPx4kgDYjzz5NpqAF3v8CK+KG5cAMtb7WiOg=;
 b=TuTVi4xS/HCaSyx49U/SGTsZhYukOZgXZmL18OwF+DaU6HsSdJlbz5cecKC1/Wcq11/CFUQ5lR0H9IZUnjtSjVSrtDvwyfawNEJ2HDJFDLJ2s5mdDxCBL0Ef/oaWqI5rjONNd8di9jT12OBqG4UwpYYu0rLpNKAV1wRRJANxnIpS/yVuLYqLA088b2mDlWnKDem9f+Af/jiCdpBgUMnBmPlLCEeaDk992PPM0+Lj1nHtDkej00KjXBxL+5mIlaep+tfPq4L4SFCC2j18Bo1X5T32avuMIBbVzLx6YK+PLwQWGCvVbnA76iR05g7XUpaOPIzCMxwbtmdDTLv15Fm8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gqoK9wDPx4kgDYjzz5NpqAF3v8CK+KG5cAMtb7WiOg=;
 b=GvBFCLeFYO0sV1jATgMA6bUd5gPkOWi6ijdBcsX6DciJle38RXP2YvLhA3CW3/l8Vk0xuscmVXevhdGVLWFYvAyCUg+djz8C8m614qZLoIyVu35V+xrcScKnanOHy0IQnkA2aJO75SbCHPzGa30+JhqUJfk/8alRO8lupJkquBQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2902.namprd10.prod.outlook.com (2603:10b6:a03:85::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Fri, 15 Oct
 2021 22:22:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%7]) with mapi id 15.20.4587.026; Fri, 15 Oct 2021
 22:22:08 +0000
Subject: Re: [PATCH v3] hugetlb: Support node specified when using cma for
 gigantic hugepages
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mhocko@kernel.org, guro@fb.com, corbet@lwn.net,
        yaozhenguo1@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <bb790775ca60bb8f4b26956bb3f6988f74e075c7.1634261144.git.baolin.wang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3828f912-774b-1422-d84a-b41d221fa490@oracle.com>
Date:   Fri, 15 Oct 2021 15:22:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <bb790775ca60bb8f4b26956bb3f6988f74e075c7.1634261144.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR17CA0066.namprd17.prod.outlook.com
 (2603:10b6:300:93::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR17CA0066.namprd17.prod.outlook.com (2603:10b6:300:93::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 22:22:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e2ea3f4-f8df-453b-6485-08d9902a399d
X-MS-TrafficTypeDiagnostic: BYAPR10MB2902:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2902EB5AFC6B64943DB52BEEE2B99@BYAPR10MB2902.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ms8I8/yedI8H3xDPuYUoRJHMaytQaTeiVgN4J400eF2Xg1AQoBcjZ3qrcsp+OwNb9bM624DiH4SqWxEpVECt9WJ8raw9UD6CLt4+njjXaLF5rUpyJmLHjVkzoPsJLqRm0KicglT8WstLE2iXD2gcwmT+/rlq3WxqlfAUHfL9tkfLetl41p0oUv0prv1VdbAPaBlvSWr7W8Txver/RUwkn61NFzshd16udo9KRiApLjMEj38n18uJjbUhj08gupauYbcaCmjDN0eD/bOjhVu4DbNLIdQMuTc7MselXIeYI1anklc2WjAATYUTrvaB5DS8YUXin4ZHvilnIAw+wWsCngSETYf1d4cGmNGAkL9JfokhbvUp3HM1lonWVqc3zV2PLdJlWFjdtbFYjovIp2NMfWdKreMsdU7a2/QYwGl304A+3OEYeEWQiVKlySW1TA6PfQSjmRxK+sufggwMHjcrc85qbL6IF22Vme3z7p9VgvihPlCuVObQ/JrLungy7tG8AaYPtm/o4jxjFqZ76CuQnoT86Lp4BoqCWrgsAtN9WIaLp4xtxY0y/gwhJMTOCn3oKUj4P02QnQlnYB9uSN0HtCc2jWZuyvOylmz1eLL5gwVut72Z3icdqZ98SWI86N7Mfo1wU/YUHxwl5NSQJN+Yza3e0V9hoNqHAqmK9rD1lOUEV6ROjKT7LM56642F5PxORNOTlLzm22u5GtiKpQi4Z3uPclLd9aByExVnyVtxB+vhQ0A08Uj+EALNJmF6cjs75KiUHPvt7YhokVUr7OpeLrtsLs1bKsIel0kIoD83WgIYVivgq1C1121B0WjeEmoKH0WZlwxXq3ylUFEaklfNEX21Ss8BNKJ5RlaNS1XRjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(508600001)(966005)(316002)(66476007)(4326008)(31686004)(16576012)(66556008)(83380400001)(66946007)(2616005)(8936002)(52116002)(2906002)(26005)(5660300002)(38350700002)(186003)(956004)(38100700002)(31696002)(86362001)(53546011)(8676002)(44832011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1VzSVFoSHJPSXNaV2t4QkI5RHBFMTBSMGZDTzhnc0tCNXV3RDlldDZqMmI0?=
 =?utf-8?B?TFVlMVpWOXA0RnpoYXcvbklkNWdWTDBZTzRsUU84YzRBNGZXQnJhcHhBTFJN?=
 =?utf-8?B?Z2R1b2IrdDhlMkIwWTI4U1dicW1SenY4L0FDbkg2V0ZFR2xJSEV5cFlYS1pV?=
 =?utf-8?B?bXhiSExmZVF0RzBqWm9GOFFjelhBMURNaS9zY25hNi9vanJHYlgwYmpleEMw?=
 =?utf-8?B?N3hHUEE4dEpMWXVvRU1NaXpzYlBYbEltaElpY0s2aVFCbGNqZzFodVNnRDBC?=
 =?utf-8?B?MHhHYVlFUFZDSzA0SUprckNYeTFMSmpsNHpzZTl5TitVRVRteGpEdVJFcUtL?=
 =?utf-8?B?b3JRWEczbzVmSjZ6b0tsdmt1S1J6U1k1ZFJuRFNBUEZFd2RieDQ2WHBJaHZn?=
 =?utf-8?B?T1pzSlNFc3p0a25qbFBMZitMbkprWDdUd1plUkhYcHZBY0VBdEVCM28vbVIy?=
 =?utf-8?B?TFNEYTdCc3c3ZUNqeEVGMWtxK2hmbzEzMHVLbzJobmpzdktHYlFwb0U0MkZI?=
 =?utf-8?B?Nk54b1IrL3FGNFZZR2IyVDZpNjF5dEhGREJaSnBQeWZYd1NnR1Nja05QZ0Nm?=
 =?utf-8?B?THJraXFBS3pkWnFySFVNSGpaOXZOZjlhdmNpS1krb0QvUm42a3F1Wi9USVRj?=
 =?utf-8?B?cTlUM1FiRERlaC9oNEx1OEJVM2VVRk5hc1BDdkNKMThJb3VkRy9yclBJdm1t?=
 =?utf-8?B?Mzl3RXYxZDBTQ01TT1M3aW5CZE5TVFdQdnNtdVhBYVFMek1JOElmcDhIekNS?=
 =?utf-8?B?ZVV0ZnlaSHlMNmJMWXdsTlJQUldzbWRWcS85d2wzUU1ZOElaSUJSRTdFMDVz?=
 =?utf-8?B?MmZHZkVIdkF3UnVhSzhMV3JHeE5jVFFkdWZScHoxR0JXZHIxc0ZJSTQ2V0Ro?=
 =?utf-8?B?RkpNYS9wTEpqNGRDNlFWR3ZpNlU0UUpSckZVOVNwd1psbVJjTEMzR2lmK0hy?=
 =?utf-8?B?YUlUWE1RS3dEWUtGMHhWOHpzdCt6SmpoNjJtdFZrOHBweENiWjJJcXcvVklK?=
 =?utf-8?B?N0pkeDdzVzFVSDZpSDJnaUFlZTUvUmM0RE1GSXZYaTdrV1kzUmQyeW94RzZY?=
 =?utf-8?B?bnJ6MlBCMWprYXhlTVl6cTFSenFKRXE3SlpKOTV1QWRpa0JLT2wzTEp3Unoy?=
 =?utf-8?B?b1BaMFJ3aHozYWN0bjI3L3F5VXkyWWZjYUJ2alg1bm5hOHMyZzBsZFNPVFJG?=
 =?utf-8?B?Rlc4S3BJSTlib3pHVmw0VGNMcFhDM081NnVKampHVUVrd2t2SnRnTGdoZUpV?=
 =?utf-8?B?UGJFWWx3TGFvb1htejdvQnBqejV3cE9JaElvZXFxTzJiUWlYU2RJMUsvMVBD?=
 =?utf-8?B?ekREMTZlakFBZXEwbk1BU25IR09NY1AxQVcwbGF1RG9tNklCWWw5dDVpLzBJ?=
 =?utf-8?B?a0xEc2V2QWZNejhhQkhUNklDVDRScDBYMWhSbjZrRG95YXB3ajh2MUVFNWNl?=
 =?utf-8?B?YVBvYWNiMDJsMkxJZE1hL1VXTU9LU1d5MkN0TUhrRENFSlFJM3Y4b1lFL3h1?=
 =?utf-8?B?ZnEyS2pobXJEczU3QlZmQm1PQjhEcWdSVGIyNisxRVdqTEh2dFRsdTBTRVVG?=
 =?utf-8?B?ckNCS0w3VTJFNUpTV2d6ZU9JSUpsWUl0S0tTdVBvOXluc2E5NnhweXNsQVpr?=
 =?utf-8?B?WWdPYzM1RWk3dnI3N1loR3BvcTlTTUJDU29yUUNuRytrVzZMc2IvSEVES2Ji?=
 =?utf-8?B?RXRLUlZIZ0lWRnp4SXN5aWV3aFV4ckZKdnVQOHF5NFYxWnlObENjRGxveFlO?=
 =?utf-8?Q?ymQZ5ppB45kZZZc5shUKoGIEYaJFeEyrM0Dq5a4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2ea3f4-f8df-453b-6485-08d9902a399d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 22:22:08.7422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPMn4sVaYC3dPmE7lxLv11PqnReTiCymr5mPiV5VXnk/8+c7HmHxxzhb4SzbIMMHMFaDxQpKUp92JvkSBgK+ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2902
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10138 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110150135
X-Proofpoint-GUID: X7JyPADP5HlCNP-1-gPQUiFBzzyI8Zha
X-Proofpoint-ORIG-GUID: X7JyPADP5HlCNP-1-gPQUiFBzzyI8Zha
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/21 7:03 PM, Baolin Wang wrote:
> Now the size of CMA area for gigantic hugepages runtime allocation is
> balanced for all online nodes, but we also want to specify the size of
> CMA per-node, or only one node in some cases, which are similar with
> patch [1].
> 
> For example, on some multi-nodes systems, each node's memory can be
> different, allocating the same size of CMA for each node is not suitable
> for the low-memory nodes. Meanwhile some workloads like DPDK mentioned by
> Zhenguo in patch [1] only need hugepages in one node.
> 
> On the other hand, we have some machines with multiple types of memory,
> like DRAM and PMEM (persistent memory). On this system, we may want to
> specify all the hugepages only on DRAM node, or specify the proportion
> of DRAM node and PMEM node, to tuning the performance of the workloads.
> 
> Thus this patch adds node format for 'hugetlb_cma' parameter to support
> specifying the size of CMA per-node. An example is as follows:
> 
> hugetlb_cma=0:5G,2:5G
> 
> which means allocating 5G size of CMA area on node 0 and node 2
> respectively. And the users should use the node specific sysfs file to
> allocate the gigantic hugepages if specified the CMA size on that node.
> 
> [1]
> https://lkml.kernel.org/r/20211005054729.86457-1-yaozhenguo1@gmail.com
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thanks for all of your updates.  This version looks good to me.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> ---
> Changes from v2:
>  - Update the commit log.
>  - Remove hugetlb_cma_nodes_allowed nodemask and related code.
>  - Rebase on the current linux-next branch.
> 
> Changes from v1:
>  - Update the commit log.
>  - Avoid changing the behavior for 'balanced' gigantic huge page pool
>    allocations.
>  - Catch the invalid node specified in hugetlb_cma_reserve().
>  - Validate the size of CMA for each node in hugetlb_cma_reserve().
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  6 +-
>  mm/hugetlb.c                                    | 86 ++++++++++++++++++++++---
>  2 files changed, 81 insertions(+), 11 deletions(-)

-- 
Mike Kravetz
