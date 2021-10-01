Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1E541F773
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 00:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhJAWg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 18:36:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24518 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230386AbhJAWgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 18:36:19 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191MIN8K021219;
        Fri, 1 Oct 2021 22:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Wmn08m7aEwlPgZpGGlnb3NdMiGfn/yWStYo31jxi6Ns=;
 b=CDXoCMgXwxU2G90fhVKPUKqTo7ZpXjT/UXUaCKenRqRAuLLsqjffTXFcf5XMYLPDRVYX
 YBB+5RAJYbc5JBvd7HRmOPX+PqBGuFsjibtt0TE4ekdMOwIYJQ7XYB/IloRgwrLXOPeK
 kSvjSd4zwHfM6EFHF/3VJZUK9SlyR2AnOcKALhb0+9nPT5OV4GU3wj8miqV4RGu/CC/7
 NTgiTq22jOiaBMR8CviTfwiYWaVzUZEy0dYzL7LV+ngOKIl4Krgk5Blik6M6YLp7LUDR
 L1+LuBVRTwfUKa0YgKiz5mIuDoz5aLatsBDn3lYCFoRqm8932JrsKbfTc1laHD/N9z1D CQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3be9u50gw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 22:33:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191MVMQL195062;
        Fri, 1 Oct 2021 22:33:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by aserp3030.oracle.com with ESMTP id 3bd5wd9v76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 22:33:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdPX+yHNrHu0wmfUuRNuCEuuHfp+uUenvTO2xDY1HFFQZgkgb0r4OIO6egWsPGenKVp2qNlRlWSNIBMpbe3KNZlnHzmQu9OxCDaZvgBNbzv1nJZyQ6HcIjyBYPrpNRbIKuKQx/SVwGA2+hSCwtOONGu5wopMs2u4gz6LqhqcyWFcoMgR7OoToPJu0rkFDONDXvtAsXA68nKiNTWkAO4n7M+2LA4PC58uXZ7g96HFR4ji1LQ8mQTyd9e3QnFznMj2hVsxrGj8cS9yLLswrQHgLwZy3J7mF+dBVfhvZSH0y6MFYyMpyTyetfm6VLGGaqDQBpMjOuybZtqlhRT/s4Shyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wmn08m7aEwlPgZpGGlnb3NdMiGfn/yWStYo31jxi6Ns=;
 b=FFmEX6jVHC9efR/gRLc8BixKnuB+Ve0atWR0E803lhC3+Ywjcm3WCG2HvtNbwoxCY0TdWZShO7zt/ozHsDgi3f1p8wx8HRCqEsEfgwkdxLkhukLjaI9wDwCB1+GUN+UaDGgfeFpEdTemWZ4gwY0/5T8xkBYm1wZ5hxpOO9ElBjUH/C3no0X9Hn8+/yDW4whxLpR2cYhZJTZridqoy0nLSJZBWrATfimYIXmG9dHT8Ui6ggAODRGoGE3fJCEAop1eh4kEofCiS5+kAYpKJ5V8EPd96tdBFvjB0rPMkH//NNGRwsLFHbwdYVOqp465BeHKIb0sxQ6Z4aNtx7yabY679A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wmn08m7aEwlPgZpGGlnb3NdMiGfn/yWStYo31jxi6Ns=;
 b=Y0y3FvUvMCvu1UjDs5rH9wRxHWKatbxMZwtNneD1XPOtzRfQ0Hc/zerShV99trnUvw/Asj42qD6stJPCQBmepSX/ZC59HBrcTXReDMVokELrB/oXsW3ZrICb3CBkQIFKf6S1S71XZSGJZrL7qo4V+dfpfNEHT2IjeUJrxiAsSIM=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9)
 by CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 22:33:34 +0000
Received: from CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::9516:b37d:b134:1e73]) by CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::9516:b37d:b134:1e73%9]) with mapi id 15.20.4544.025; Fri, 1 Oct 2021
 22:33:34 +0000
Subject: Re: [PATCH v7] hugetlbfs: Extend the definition of hugepages
 parameter to support node allocation
To:     Zhenguo Yao <yaozhenguo1@gmail.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        corbet@lwn.net, rppt@kernel.org, akpm@linux-foundation.org,
        yaozhenguo@jd.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
References: <20210927104149.46884-1-yaozhenguo1@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c83bffef-53ca-5448-38b5-27282ba97499@oracle.com>
Date:   Fri, 1 Oct 2021 15:33:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210927104149.46884-1-yaozhenguo1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0302.namprd03.prod.outlook.com
 (2603:10b6:303:dd::7) To CH2PR10MB4200.namprd10.prod.outlook.com
 (2603:10b6:610:a5::9)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR03CA0302.namprd03.prod.outlook.com (2603:10b6:303:dd::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Fri, 1 Oct 2021 22:33:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3581d59-9d96-4a1c-8fa8-08d9852b8097
X-MS-TrafficTypeDiagnostic: CH0PR10MB4858:
X-Microsoft-Antispam-PRVS: <CH0PR10MB485850618255DD007C0F82C9E2AB9@CH0PR10MB4858.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+GQ7fbFmersnzOylcNa4Ki+UAUDp5HHDTXww4Wh6sY0900oZzv23Sbpdxn10xd8k49293kipuF/nekrTfLZQ8wezDEnM0iPkLa+rTQS3ZdRKbMoVZYub0WP0NdF+RVt+AdbYHPqqrUJHzRHxXuRl25XET4pnE372T24FeTkR4kES92xBplUs7iQI2KRkp8YIvlnOd0cSlHisOa/lFsLMQ4bJdDJnKRncJZTTsptRfgzTANxdE2JMsSd4/5utvwehTkX1i+0i8uFPY0JRHGLHwuzs6UnPbuLlDiwV5nTAaFpCh8aehrZxCkk87uQS7xw2daNlKPmiRgWsVK5zXdDhinB9LWNbghI8OT8Y5ztrnr9mfaIOtETANmRXa5BPZ8C5P/JMEuVlEYv/y3YDxSdf4DLoAqrqeV1e5i+5Z/txYJOJ/qK0ZvI3Ux/Vsz1kgWjKDi8AOStSw+g6pznvInBK5ReCrgDhNJSD/YSaU40U6MrISMxWno3GryAKHG+NBhyXKoDS0V6TzOjKy9T9UutPhCEh1KZRxqNFfil8ykQuzCMVlcJ3bQr0wDa/YIE63+bJgNx3q1tahf120JQeBGQEwDhk8EcAjgmss2Qix/ewOSXi8vCRGt1E6Hz4A5ZbgTOZZFX2tBMV9snJ4dqauhojwOp7feHuFZFF93DXMp+Jyho8OLakj/MxzPq1qj1G96XXa5Io9zAMfkg0fVudpbGO7jntEZ7nYmKGEUWxdMDP8h6ClYY8FWjZE0+bVpyG09T30QzrL4r7sL6EQNa/mrfXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4200.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(53546011)(83380400001)(508600001)(38100700002)(6486002)(31686004)(86362001)(16576012)(316002)(26005)(186003)(66476007)(66556008)(6916009)(4326008)(36756003)(8936002)(8676002)(2906002)(7416002)(31696002)(66946007)(2616005)(956004)(44832011)(52116002)(30864003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXpQM2ZVWlpJeDZzNU54TVJDWUJTZFBXWkE1N3FwN2lmSmJpQmczbTZOQU9L?=
 =?utf-8?B?ZU4rbzhVVElMZFdvb0s0TlFsTUQ4UUUxQWVPUEdsbDNsWUY1TmM1WnB0dnpu?=
 =?utf-8?B?QlBsUHJ5a3BhcWFLVU5XdFFHbnFKK1ZvaGxUeGtiRmVGUEcxMExJNXgySmZN?=
 =?utf-8?B?NDhkWlRkK1d3RC91Nm4xaTgwOFFKV0UwV3BtcXVGM2dMVVFrczBIUElvY0ho?=
 =?utf-8?B?LzVFdCtYemlkSkFiM2JUYXMycU9mdnZDNktHQkhZb3AvU3d2QmVtVXA5bm9r?=
 =?utf-8?B?d01JbjBFamk5WkFYdHA2a0xXZ0JxdDZlb1gvY0lkMGtWRSt1UHIvLzAycE9L?=
 =?utf-8?B?NEpGUFhJOHhwNVNTQ0NVTGl4bzJpdEx3WllOcE16OU5qaEp2VzhYTVdOcElw?=
 =?utf-8?B?LzczM2ZqMTJCVWtTWjhsN1JRL0x4QXVjU1g5ckgwK1Jxd0F5eDhjZnRMQlFP?=
 =?utf-8?B?eFlyNVgvOFAwQlY0QXc0dTRHM3RZWnZjU1FBUVNsTm1ZSHJuZHBPaEtHV284?=
 =?utf-8?B?YXorZDYxTWxTOFphSUU3U1JRc0RCS3FjWTNnTVF2VXZvR3dNc1l2bEtabndD?=
 =?utf-8?B?eVBJOGRDSHoxazdVeWRQSEdWN1Q2TmJ1cGNLWW5TK3UzUk9sdEFUdi94ZkVC?=
 =?utf-8?B?Wk5Zd1BpRmY0L0F2WkIzVmwxNnhBbzJENUZQU2ViejI1ZXlwSDR3b2JGcGo1?=
 =?utf-8?B?R0NnSy9TaGNiR2VJSCtraG0veC9TV0ZQeFlzT2ZmQ0tMVS9BZ1J3NGJSNFZX?=
 =?utf-8?B?Mis0cjBNRjZPdGtPUnk3MFU3ZFdxR2ptQXR4UWFUaXdlVGVOV2xhYzllcXh3?=
 =?utf-8?B?Szg3WldyaU1oTnNMb0JPa1NBUGpjZURTbkZxTzdUN2Zjdmx6eDRsY29uMzdj?=
 =?utf-8?B?bEhIbVFDbHluVCt6L2V2bll6WG0vblJFa1ljZjRGTGszYVhBbDlpL3oyN29u?=
 =?utf-8?B?RDZpZzk3dUg0bEYxMzF1T2Y2STFCSWtaQUYzd2RrUDloc0pNYktiUHNpcm9O?=
 =?utf-8?B?Yi90dU5pc3ZXeTZncjJpQTdIaUcveDhWY2RuT1ppQnkzaTNHTWNZeWRKckdQ?=
 =?utf-8?B?Qk84dzRHOThEdTRMdWVoRkdpSmxjdEUybzRvcWU2QWlCNzRaK3VXVEk3ZlRa?=
 =?utf-8?B?OSt5clM5R0dZK0RiNmR2ZTZNU1hJUy9uZGMvSVpxc21iRzFyRUVGdklSZENv?=
 =?utf-8?B?d2kvY0hxellGK2FGZVBLQVRxWTJTaTg1eEtOcEd6M1lCZDFON0xrTUJYR3FL?=
 =?utf-8?B?M0oxNmx3V2lLUW12NkFMNHpjK0JWK2hIcjVPODl1VzBKWUhyK0hXeHdISXhB?=
 =?utf-8?B?a2hPbDgrYmYzb1BYb09mR3FQYVZBdlVyQzlGdndFVVpGTTRMdm1kdXgwb1Rl?=
 =?utf-8?B?WlZDaVN6dlM2andUajB6N3ZzMU04MTZURHdqNis4SU1yU2JCYXhMVEF0Q1FB?=
 =?utf-8?B?SEI1V3FxQTJoOE14c2V0amxIM1UvWFlNSnd5ZGZvNUdQT2lTUlFYOWdiMDhL?=
 =?utf-8?B?Tngrdjh1WDVVT2JseEg0bGNlMXViaU9NSHRHeTh2RkJLd3ZEb1g2cmI3bWZl?=
 =?utf-8?B?Sm52WkJ1OXA2anIwcEF2UUNvYU0ySHQwNEZQMTI4bTJRYjN2Rk9vOTIvL0Vw?=
 =?utf-8?B?bW82VWt5M2YxLzdVMURWQUh3Q215TWd6NUloaDBJKzBKYWUxTWljTmxtWWZL?=
 =?utf-8?B?TzlKOVpaR2UwOEZaVDdoMGJTaUNUbFl4Skx3VDR5MzZibU5VMy85VnRHMlho?=
 =?utf-8?Q?v81L0LrSWVd7g/RwfgcU/17QTHnw55k02jdQiiY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3581d59-9d96-4a1c-8fa8-08d9852b8097
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4200.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 22:33:34.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fS5g8PqiaiuqOnpaNP1oUwaGFxoHNsnRHLgsXjGnQcy36lMcBxjIjrCY1q2ukQUR6meDydEXYaxr+QIMvo08Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4858
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10124 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110010156
X-Proofpoint-ORIG-GUID: FVBuAJ8ZM0OkydlKhQ5WiCagrdfdwU4P
X-Proofpoint-GUID: FVBuAJ8ZM0OkydlKhQ5WiCagrdfdwU4P
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/21 3:41 AM, Zhenguo Yao wrote:
> We can specify the number of hugepages to allocate at boot. But the
> hugepages is balanced in all nodes at present. In some scenarios,
> we only need hugepages in one node. For example: DPDK needs hugepages
> which are in the same node as NIC. if DPDK needs four hugepages of 1G
> size in node1 and system has 16 numa nodes. We must reserve 64 hugepages
> in kernel cmdline. But, only four hugepages are used. The others should
> be free after boot. If the system memory is low(for example: 64G), it will
> be an impossible task. So, Extending hugepages parameter to support
> specifying hugepages at a specific node.
> For example add following parameter:
> 
> hugepagesz=1G hugepages=0:1,1:3
> 
> It will allocate 1 hugepage in node0 and 3 hugepages in node1.
> 
> Signed-off-by: Zhenguo Yao <yaozhenguo1@gmail.com>

Thanks for your continued efforts!  And, thank you Mike R. for your
input.

Just a few very minor comments below.  Everything else looks good.
With suggested updates,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> ---
> v6->v7 changes:
> 	- replace nodes_weight(node_states[N_MEMORY] with nr_online_nodes.
> v5->v6 changes:
> 	- Remove v5 codes: using return value to disable node specific alloc.
> 	- Add node_specific_alloc_support weak function to disable node
> 	  specific alloc when arch can't support it.
> 	- Remove useless variable addr in alloc_bootmem_huge_page.
> 	- Add powerpc version of node_specific_alloc_support when
> 	  CONFIG_PPC_BOOK3S_64 is defined.
> v4->v5 changes:
> 	- remove BUG_ON in __alloc_bootmem_huge_page.
> 	- add nid parameter in __alloc_bootmem_huge_page to support
> 	  called in both specific node alloc and normal alloc.
> 	- do normal alloc if architecture can't support node specific alloc.
> 	- return -1 in powerpc version of alloc_bootmem_huge_page when
> 	  nid is not NUMA_NO_NODE.
> v3->v4 changes:
> 	- fix wrong behavior for parameter:
> 	  hugepages=0:1,1:3 default_hugepagesz=1G
> 	- make the change of documentation more reasonable.
> v2->v3 changes:
> 	- Skip gigantic hugepages allocation if hugetlb_cma is enabled.
> 	- Fix wrong behavior for parameter:
> 	  hugepagesz=2M hugepages=2 hugepages=5.
> 	- Update hugetlbpage.rst.
> 	- Fix side effects which v2 brings in.
> 	- add cond_resched in hugetlb_hstate_alloc_pages_onenode.
> v1->v2 changes:
> 	- add checking for max node to avoid array out of bounds.
> 	- fix wrong max_huge_pages after failed allocation.
> 	- fix wrong behavior when parsing parameter: hugepages=0:1,2,3:4.
> 	- return 0 when parsing invalid parameter in hugepages_setup
> ---
>  .../admin-guide/kernel-parameters.txt         |   8 +-
>  Documentation/admin-guide/mm/hugetlbpage.rst  |  12 +-
>  arch/powerpc/mm/hugetlbpage.c                 |   9 +-
>  include/linux/hugetlb.h                       |   6 +-
>  mm/hugetlb.c                                  | 153 +++++++++++++++---
>  5 files changed, 157 insertions(+), 31 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 91ba391f9b32..9b3d8791586d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1599,9 +1599,11 @@
>  			the number of pages of hugepagesz to be allocated.
>  			If this is the first HugeTLB parameter on the command
>  			line, it specifies the number of pages to allocate for
> -			the default huge page size.  See also
> -			Documentation/admin-guide/mm/hugetlbpage.rst.
> -			Format: <integer>
> +			the default huge page size. If using node format, the
> +			number of pages to allocate per-node can be specified.
> +			See also Documentation/admin-guide/mm/hugetlbpage.rst.
> +			Format: <integer> or (node format)
> +				<node>:<integer>[,<node>:<integer>]
>  
>  	hugepagesz=
>  			[HW] The size of the HugeTLB pages.  This is used in
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index 8abaeb144e44..d70828c07658 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -128,7 +128,9 @@ hugepages
>  	implicitly specifies the number of huge pages of default size to
>  	allocate.  If the number of huge pages of default size is implicitly
>  	specified, it can not be overwritten by a hugepagesz,hugepages
> -	parameter pair for the default size.
> +	parameter pair for the default size.  This parameter also has a
> +	node format.  The node format specifies the number of huge pages
> +	to allocate on specific nodes.
>  
>  	For example, on an architecture with 2M default huge page size::
>  
> @@ -138,6 +140,14 @@ hugepages
>  	indicating that the hugepages=512 parameter is ignored.  If a hugepages
>  	parameter is preceded by an invalid hugepagesz parameter, it will
>  	be ignored.
> +
> +	Node format example::
> +
> +		hugepagesz=2M hugepages=0:1,1:2
> +
> +	It will allocate 1 2M hugepage on node0 and 2 2M hugepages on node1.
> +	If the node number is invalid,  the parameter will be ignored.
> +
>  default_hugepagesz
>  	Specify the default huge page size.  This parameter can
>  	only be specified once on the command line.  default_hugepagesz can
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 9a75ba078e1b..dd40ce6e7565 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -229,17 +229,22 @@ static int __init pseries_alloc_bootmem_huge_page(struct hstate *hstate)
>  	m->hstate = hstate;
>  	return 1;
>  }
> +
> +bool __init node_specific_alloc_support(void)
> +{
> +	return false;
> +}
>  #endif
>  
>  
> -int __init alloc_bootmem_huge_page(struct hstate *h)
> +int __init alloc_bootmem_huge_page(struct hstate *h, int nid)
>  {
>  
>  #ifdef CONFIG_PPC_BOOK3S_64
>  	if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
>  		return pseries_alloc_bootmem_huge_page(h);
>  #endif
> -	return __alloc_bootmem_huge_page(h);
> +	return __alloc_bootmem_huge_page(h, nid);
>  }
>  
>  #ifndef CONFIG_PPC_BOOK3S_64
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1faebe1cd0ed..3504e407567c 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -605,6 +605,7 @@ struct hstate {
>  	unsigned long nr_overcommit_huge_pages;
>  	struct list_head hugepage_activelist;
>  	struct list_head hugepage_freelists[MAX_NUMNODES];
> +	unsigned int max_huge_pages_node[MAX_NUMNODES];
>  	unsigned int nr_huge_pages_node[MAX_NUMNODES];
>  	unsigned int free_huge_pages_node[MAX_NUMNODES];
>  	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
> @@ -637,8 +638,9 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
>  				unsigned long address, struct page *page);
>  
>  /* arch callback */
> -int __init __alloc_bootmem_huge_page(struct hstate *h);
> -int __init alloc_bootmem_huge_page(struct hstate *h);
> +int __init __alloc_bootmem_huge_page(struct hstate *h, int nid);
> +int __init alloc_bootmem_huge_page(struct hstate *h, int nid);
> +bool __init node_specific_alloc_support(void);

Agree with Mike R. that hugetlb should be in the name.

>  
>  void __init hugetlb_add_hstate(unsigned order);
>  bool __init arch_hugetlb_valid_size(unsigned long size);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 95dc7b83381f..ca00676a1bdd 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -66,6 +66,7 @@ static struct hstate * __initdata parsed_hstate;
>  static unsigned long __initdata default_hstate_max_huge_pages;
>  static bool __initdata parsed_valid_hugepagesz = true;
>  static bool __initdata parsed_default_hugepagesz;
> +static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
>  
>  /*
>   * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
> @@ -2868,33 +2869,41 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  	return ERR_PTR(-ENOSPC);
>  }
>  
> -int alloc_bootmem_huge_page(struct hstate *h)
> +int alloc_bootmem_huge_page(struct hstate *h, int nid)
>  	__attribute__ ((weak, alias("__alloc_bootmem_huge_page")));
> -int __alloc_bootmem_huge_page(struct hstate *h)
> +int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>  {
>  	struct huge_bootmem_page *m;
>  	int nr_nodes, node;
>  
> +	if (nid >= nr_online_nodes)
> +		return 0;
> +	/* do node specific alloc */
> +	if (nid != NUMA_NO_NODE) {
> +		m = memblock_alloc_try_nid_raw(huge_page_size(h), huge_page_size(h),
> +				0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> +		if (m)
> +			goto found;
> +		else
> +			return 0;
> +	}
> +	/* do all node balanced alloc */

I'm sure you saw Smatch does not like this comment.  Perhaps,
	/* allocate from next node when distributing huge pages */

>  	for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) {
> -		void *addr;
> -
> -		addr = memblock_alloc_try_nid_raw(
> +		m = memblock_alloc_try_nid_raw(
>  				huge_page_size(h), huge_page_size(h),
>  				0, MEMBLOCK_ALLOC_ACCESSIBLE, node);
> -		if (addr) {
> -			/*
> -			 * Use the beginning of the huge page to store the
> -			 * huge_bootmem_page struct (until gather_bootmem
> -			 * puts them into the mem_map).
> -			 */
> -			m = addr;
> +		/*
> +		 * Use the beginning of the huge page to store the
> +		 * huge_bootmem_page struct (until gather_bootmem
> +		 * puts them into the mem_map).
> +		 */
> +		if (m)
>  			goto found;
> -		}
> +		else
> +			return 0;
>  	}
> -	return 0;
>  
>  found:
> -	BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_size(h)));
>  	/* Put them into a private list first because mem_map is not up yet */
>  	INIT_LIST_HEAD(&m->list);
>  	list_add(&m->list, &huge_boot_pages);
> @@ -2934,12 +2943,61 @@ static void __init gather_bootmem_prealloc(void)
>  		cond_resched();
>  	}
>  }
> +static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
> +{
> +	unsigned long i;
> +	char buf[32];
> +
> +	for (i = 0; i < h->max_huge_pages_node[nid]; ++i) {
> +		if (hstate_is_gigantic(h)) {
> +			if (!alloc_bootmem_huge_page(h, nid))
> +				break;
> +		} else {
> +			struct page *page;
> +			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
> +
> +			page = alloc_fresh_huge_page(h, gfp_mask, nid,
> +					&node_states[N_MEMORY], NULL);
> +			if (!page)
> +				break;
> +			put_page(page); /* free it into the hugepage allocator */
> +		}
> +		cond_resched();
> +	}
> +	if (i == h->max_huge_pages_node[nid])
> +		return;
> +
> +	string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> +	pr_warn("HugeTLB: allocating %u of page size %s failed node%d.  Only allocated %lu hugepages.\n",
> +		h->max_huge_pages_node[nid], buf, nid, i);
> +	h->max_huge_pages -= (h->max_huge_pages_node[nid] - i);
> +	h->max_huge_pages_node[nid] = i;
> +}
>  
>  static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>  {
>  	unsigned long i;
>  	nodemask_t *node_alloc_noretry;
> +	bool node_specific_alloc = false;
> +
> +	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
> +	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
> +		pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
> +		return;
> +	}
> +
> +	/* do node specific alloc */
> +	for (i = 0; i < nr_online_nodes; i++) {
> +		if (h->max_huge_pages_node[i] > 0) {
> +			hugetlb_hstate_alloc_pages_onenode(h, i);
> +			node_specific_alloc = true;
> +		}
> +	}
>  
> +	if (node_specific_alloc)
> +		return;
> +
> +	/* bellow will do all node balanced alloc */

	   below

>  	if (!hstate_is_gigantic(h)) {
>  		/*
>  		 * Bit mask controlling how hard we retry per-node allocations.
> @@ -2960,11 +3018,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>  
>  	for (i = 0; i < h->max_huge_pages; ++i) {
>  		if (hstate_is_gigantic(h)) {
> -			if (hugetlb_cma_size) {
> -				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
> -				goto free;
> -			}
> -			if (!alloc_bootmem_huge_page(h))
> +			if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
>  				break;
>  		} else if (!alloc_pool_huge_page(h,
>  					 &node_states[N_MEMORY],
> @@ -2980,7 +3034,6 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>  			h->max_huge_pages, buf, i);
>  		h->max_huge_pages = i;
>  	}
> -free:
>  	kfree(node_alloc_noretry);
>  }
>  
> @@ -3671,6 +3724,11 @@ static int __init hugetlb_init(void)

>  			default_hstate.max_huge_pages =
>  				default_hstate_max_huge_pages;
> +
> +			for (i = 0; i < nr_online_nodes; i++)
> +				if (default_hugepages_in_node[i] > 0)
> +					default_hstate.max_huge_pages_node[i] =
> +						default_hugepages_in_node[i];

Very minor nit.  Not necessary to change.
The 'if (default_hugepages_in_node[i] > 0)' is not really needed.  I am
not sure if any potential speed up by the check would be noticable.  You
need to 'read' every value in the array.

>  		}
>  	}
>  
> @@ -3731,6 +3789,10 @@ void __init hugetlb_add_hstate(unsigned int order)
>  	parsed_hstate = h;
>  }
>  
> +bool __init __weak node_specific_alloc_support(void)
> +{
> +	return true;
> +}
>  /*
>   * hugepages command line processing
>   * hugepages normally follows a valid hugepagsz or default_hugepagsz
> @@ -3742,6 +3804,10 @@ static int __init hugepages_setup(char *s)
>  {
>  	unsigned long *mhp;
>  	static unsigned long *last_mhp;
> +	int node = NUMA_NO_NODE;
> +	int count;
> +	unsigned long tmp;
> +	char *p = s;
>  
>  	if (!parsed_valid_hugepagesz) {
>  		pr_warn("HugeTLB: hugepages=%s does not follow a valid hugepagesz, ignoring\n", s);
> @@ -3765,8 +3831,40 @@ static int __init hugepages_setup(char *s)
>  		return 0;
>  	}
>  
> -	if (sscanf(s, "%lu", mhp) <= 0)
> -		*mhp = 0;
> +	while (*p) {
> +		count = 0;
> +		if (sscanf(p, "%lu%n", &tmp, &count) != 1)
> +			goto invalid;
> +		/* Parameter is node format */
> +		if (p[count] == ':') {
> +			if (!node_specific_alloc_support()) {
> +				pr_warn("HugeTLB: architecture can't support node specific alloc, ignoring!\n");
> +				return 0;
> +			}
> +			node = tmp;
> +			p += count + 1;
> +			if (node < 0 || node >= nr_online_nodes)
> +				goto invalid;
> +			/* Parse hugepages */
> +			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
> +				goto invalid;
> +			if (!hugetlb_max_hstate)
> +				default_hugepages_in_node[node] = tmp;
> +			else
> +				parsed_hstate->max_huge_pages_node[node] = tmp;
> +			*mhp += tmp;
> +			/* Go to parse next node*/
> +			if (p[count] == ',')
> +				p += count + 1;
> +			else
> +				break;
> +		} else {
> +			if (p != s)
> +				goto invalid;
> +			*mhp = tmp;
> +			break;
> +		}
> +	}
>  
>  	/*
>  	 * Global state is always initialized later in hugetlb_init.
> @@ -3779,6 +3877,10 @@ static int __init hugepages_setup(char *s)
>  	last_mhp = mhp;
>  
>  	return 1;
> +
> +invalid:
> +	pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
> +	return 0;
>  }
>  __setup("hugepages=", hugepages_setup);
>  
> @@ -3840,6 +3942,7 @@ __setup("hugepagesz=", hugepagesz_setup);
>  static int __init default_hugepagesz_setup(char *s)
>  {
>  	unsigned long size;
> +	int i;
>  
>  	parsed_valid_hugepagesz = false;
>  	if (parsed_default_hugepagesz) {
> @@ -3868,6 +3971,10 @@ static int __init default_hugepagesz_setup(char *s)
>  	 */
>  	if (default_hstate_max_huge_pages) {
>  		default_hstate.max_huge_pages = default_hstate_max_huge_pages;
> +		for (i = 0; i < nr_online_nodes; i++)
> +			if (default_hugepages_in_node[i] > 0)
> +				default_hstate.max_huge_pages_node[i] =
> +					default_hugepages_in_node[i];

Same minor nit as in hugetlb_init.

>  		if (hstate_is_gigantic(&default_hstate))
>  			hugetlb_hstate_alloc_pages(&default_hstate);
>  		default_hstate_max_huge_pages = 0;
> 

-- 
Mike Kravetz
