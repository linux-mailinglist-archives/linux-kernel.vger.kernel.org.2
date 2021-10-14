Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C9142D074
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhJNCd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:33:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62162 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229834AbhJNCdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:33:54 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19E0a8kP028900;
        Thu, 14 Oct 2021 02:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=i78HiKmTZdhZFsnbNX36HsRC1BzZURvzsKRMWVCj64o=;
 b=a4IQIoskmL2GKa767Ge7sUdNQk77nqaJE/2heFZZV6UGc5RpPz5hKuOQ/MZ6CRJ0AcwG
 YASfWLakuNad0gDIKsDmg/eMFUjl4Edn0Dj1jAVrLuY/DN1FNCKyl3IBfuhjc1cD6J0B
 DdlkwagZxp8GcK3DM3TuCbruohiD4iFOUM5OZzaypEwFcjVYuf10+OGrAN9tKMz+jvEl
 L6/n7+GkgIbvrrRNEAHkzDj6Mo7RIUibNWtgA21rpvP39PP7dOCvNA9gp1bOFY+SS/jH
 M+42AvVGSF47zRg0BJv36mGABY6vNdYiAJF0PM+FzXumUnKWNsAcq5cl2i3pc0kxt7kc Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbkfy7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 02:30:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19E2FCAs175787;
        Thu, 14 Oct 2021 02:30:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3020.oracle.com with ESMTP id 3bkyvd6a66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 02:30:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2ETnoAc75oAqY/lHP6R1edyoeBc1J4u6qJe1fJ01UUulTaUdOaDJ9mHNHm1W4jp0ZqpI+ggvPbzn9Ty+BsyZn8kI9bIu/QFdK5CL0X3vik51o0B2iwN7WtNQlLvzn1Nvkc6dYQalCm+2uRGblzgXukkjnDbu1Ai7xYvIHPN2z0YtCFen5yIYHmcynvuXlko4KTiEgIsrzz40eOvd832fuSf1MZNBW6YUDzUHdUUJxHORJK4RjgU6TQEmtASTEYUhawBnIoNTt80ZdttJ0xi3Q+L+ck8JQlNIIr/ktD0OoGMSogxypgexHWMikQRZ8IaUIVb3YGHJjj4BxmDLqg/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i78HiKmTZdhZFsnbNX36HsRC1BzZURvzsKRMWVCj64o=;
 b=MgIykd0p90J0C176uUrUVIYsRyOwC6h1uaEKF1aktrjD6deJbThGY2bAPPat5PLODBoWEaQlRFi7M9VDOykLk2fiOGueqA9y0uASfQyDe30MwP9zFb/8eSIRtk8IKewruJkKBNNmwiqdtFCzEQ5Rohavj7DF2uE4xBYSe0602cz9MeDShYl7VBsnjxtw0E8OPE0EUupIH6YyartE+7AL7sK4zJ/lETNbJuHeoRv+Vq/s+c1CQvZ0VnwU+RyPuH8VMu8SQDE72NA4Ql0yOY3TZz3eJckZEGjuOHBiYO+nIFy+XUCbd/bVg6BXNCzWvDzgnwqZrKqX6gMcUacpAGPpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i78HiKmTZdhZFsnbNX36HsRC1BzZURvzsKRMWVCj64o=;
 b=ea3EX896RFgJHuS3Xtk5HEiPg6Iey9p9iB9Xiw+qEvt/CzQBYC0STx+i27BnLpt1IEQEbMRQRj4V4uS8H8J+K6t4ANXR0FtnpdDxo/3i5yQZI15Ux3w9LKqzW23n20IZS/spl7W6EKZ5MrFPGzXwB2YKe8yq2SYA4E9Fp8YPKyo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5405.namprd10.prod.outlook.com (2603:10b6:a03:3bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Thu, 14 Oct
 2021 02:30:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%7]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 02:30:35 +0000
Subject: Re: [PATCH] hugetlb: Support node specified when using cma for
 gigantic hugepages
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mhocko@kernel.org, guro@fb.com, corbet@lwn.net,
        yaozhenguo1@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <1633843448-966-1-git-send-email-baolin.wang@linux.alibaba.com>
 <6bd3789f-4dee-a184-d415-4ad77f0f98b7@oracle.com>
 <326ece39-a6f5-26ce-827b-68272525e947@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3858dbb6-3353-749e-6867-a5d6046e2f1a@oracle.com>
Date:   Wed, 13 Oct 2021 19:30:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <326ece39-a6f5-26ce-827b-68272525e947@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1701CA0004.namprd17.prod.outlook.com
 (2603:10b6:301:14::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR1701CA0004.namprd17.prod.outlook.com (2603:10b6:301:14::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 02:30:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 823197af-81f7-4db3-e1b4-08d98eba99f5
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5405:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54058A482481BD3D547380E2E2B89@SJ0PR10MB5405.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:451;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aFnhuT1wBZEQLllFkXF8F78LqCi7T1Qb1wpOjVuktEUeZQpIr8dlFrC3F4cJkm1r3nBzeSYMfuHSztFZonzXC7JV2WbB/8bbjo9ETCWF0TkcgWC5wO7Y/MtB0nnAHCgrpatu6nnP8NqZKtIgr0GlLAptoI3Vm4wk7wcBRCcjO86Hd0gW3HmNFiBioi088X82o9/zFiAc+lCZWYpFK+zx+7d3p0MYYHObO9Xmc5TDhoAP0rglg8FQwk7+YAww/wXtbkKbaS9NNSzZQ2IvKhwpSTGm7EV3ZdF9TMPNrxXakuOwgPOVsoequlrluxaSrNXEuVX+fNb6FXpGLKYHVoxx1XCnAKFxTcPPZtZKTg1tpSaC9tnMzh8u/v89MeY3sSDorSk5BqX99MXfSbRl8DJS+z/hoW7NaCPZhnTS91U65UIXNj9UOG9nTY5z278eh5JSOQJ8wBEWsjMcVPlXp9AiDXGF8VSGhyoDHOKZP8AS9vckOewAjthLYQRXz1id2KpcW4RTltRr2tUYl7Ryt1KHMJIOmkyd2kQ3r7ewNiOKnyZpSwu6bQrzKzweDrmFGFkpIIcsa+XkO3NCThRoZNHpHKB60hvZVbhrMvvov2zksgGnRgpHqaIGT7WyOkTB/dtTD65YtZ5jYx4Fsb1+/40N5IrbTbCM1BYZsU0imSEkzU7OhhTLDXfeHUmuxJTWYKZnP59rVWRs7wyuk8KruRfrW/PPrlvG1fiJJ0ndL+E496V1AqljiAJ8CAfgVNvIzZ2Vm1e9ZYGCUtuINWI5sF6YFLaqIzuTv1GbjawfeN0VU8OO5YoP6DS0UPY8+MQpZ0ppsJTiNHFd1uFS3bvdIKkmfmjCNxJVhyXzp352I3tpQYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(316002)(31686004)(26005)(16576012)(2616005)(44832011)(966005)(31696002)(186003)(86362001)(508600001)(956004)(5660300002)(66946007)(8676002)(4326008)(66556008)(66476007)(38350700002)(53546011)(38100700002)(6486002)(83380400001)(2906002)(36756003)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWN2M0JjejhlUWhHYXBLWEVDTnlzWjQwNFJWd3M5RGdFVzdFaksxcVB4OWpZ?=
 =?utf-8?B?M2xUN3NFNVI4UGtSelV4VUtwTm5BM09STVNETUFTWVExbDE5QnJ5ZXNYRzlQ?=
 =?utf-8?B?NzlMNmhVZzVUZlY1aTFJTzRZWHNvanlZeGJZUHVrS1hma3dPVTFVYktsU1Nn?=
 =?utf-8?B?d1Y5YmR3VEdNQWs5b01RdjhGRXFERXFYWG9qWEZ6UFRlN0YzeWc5akVEdzMv?=
 =?utf-8?B?V3JGK1dJUFBIb0hiY1IvWkFZM1E1VmhFTzA5Vk5MdWYrTWNLMnp0ZmtZY1Fm?=
 =?utf-8?B?V0hFd2drNmtkTUl3bEFJK3V3eDNidHBxRitCck55K2libzUvWWtGVUFYSmdK?=
 =?utf-8?B?aHhub2JFR3NhQnphdE0rOTVhSUVpcVVzOG1YR05ZaW8xZHRaRmRhOGF4bE1T?=
 =?utf-8?B?UG9kUSs2U08wc1U3WFJqSkp3bXJnREJZTjB6WUVBekZYTmhlTWN0K0lVUVJn?=
 =?utf-8?B?cko4QkpuN2U0WThPMkY0cmRvUVBUbkk3RUlyVUhQdDJQam5sOGk3ekxyS2JP?=
 =?utf-8?B?VWhQSDg4bDBuWDhpT1JNVGducGtKOXE4NGlJUXV0aHJBMVdvRW95YWZUZE8z?=
 =?utf-8?B?YXRjOVRxcG96SXdXazBTc2VUbVk4K0l6eURKZzkyL0o4UmhuemFSWHNBemFU?=
 =?utf-8?B?WmcycUVXdXc3K2o1cUVtdFArQWIrNm9RUXB5V2xMVGlaTHA4OEhueXAvSzlT?=
 =?utf-8?B?TW5GaVdqOFQ4TGFwZ1duTW5Yc1J6Qis0V2UxNTArdW1qS2tiazdLRDl0eFpy?=
 =?utf-8?B?NkNFcHZxU3BLaDIwQkFmSnZBYjhKekQ2UE5CaGFZMWMyMFdYRVpsenBoZVFr?=
 =?utf-8?B?dHAyNHBlcGhrNE9haGg3akpOd3BWd0NEN3d1dzJMaFZVaWFUeml2dUs1MUlJ?=
 =?utf-8?B?Sk41KzljOVdLWEtRTGZIaFVoR1VVbjZVaXM5ZWFiWU8ra1RHUHFjWnAxUnJN?=
 =?utf-8?B?NjZCcmpQYUEwd2tCOWgyUnh2cEpqNVNRRms2WUJ5VVZlRyswS0RGQnp0cUN6?=
 =?utf-8?B?TXJ0UE00NHVxQ3Nxb0tyMG9jNHNEcWdHeTJHTEtHZSs4REY0c2VuV05OUXRG?=
 =?utf-8?B?Vk12QkM5TldGL214QXFlZlJJYmNleUR2WWh4OVU1aU15ekpaenQwamlBY1pC?=
 =?utf-8?B?V09QUVI0V0FpczA5UWcxWTV4M1d0ZHNtdkR5OXI3dVBmU0lRb0g4UjlBNVRN?=
 =?utf-8?B?K1NvYis2YnBtTmliV3ptb2NFWSs0cGpVTTNtekNtWmJMMUdjeDl5cFQ0NnV5?=
 =?utf-8?B?Y1BhTHB2TFdrUi9TQkwxVUVWU2ZOdGIyY2E1SUc3Q3BhNElrZ3l6cTc0MS9v?=
 =?utf-8?B?MXVRSGJqRkhudVZtNXMraGtkREFpK1ZIZXdwcGc5N0xXck82d1BCZzFuMFJm?=
 =?utf-8?B?bjBoMThQeU9lbS9NYW9FU2JTVmJtcHIrMDBKdW5Fd3FMQzRmR3V1d005Um1j?=
 =?utf-8?B?VVpFWFNITDZseHN3dXBIN0FBNzNIWGJvSGIwcGJybWVWYytvZ1hRZUdOZTQ0?=
 =?utf-8?B?NFQxdEdzZVp3OHdLQ2NHMU1rY1JZc1dtbm94YjVxUG5wbWNwUVBOTUxqYklt?=
 =?utf-8?B?ek9VS3lXQzMwbTNUQW5XcnhvRVBwRTNCNDQvWE1XeE9NYWI3NzZwVXRCM2ZI?=
 =?utf-8?B?WlI4RU9tQkNpNk52aHZHRWJBU1RiREtjdVhJR1hUL0tjdi81aDZ5SThYSTA0?=
 =?utf-8?B?VWYrT2E0MmVVTDlJUzdiQ2s1a0hiWVYvZ1FBYmtMNmlyWmdQd0FDRWFaVW1K?=
 =?utf-8?Q?6h5MEInvtmphI626770Zwtw9zxjkrwpH6AATG/Z?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823197af-81f7-4db3-e1b4-08d98eba99f5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 02:30:35.1618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NiHNbrh706gjNfiEM2n4IuPIgpzSHRDUu05JwKBN+8vAKeN7SgTxuwO9a3hABPWxj6YbBDTmowVFqvKFiGa6AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5405
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10136 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110140014
X-Proofpoint-GUID: -VNIRMSWhexqjgEM2tG9ipgP6zYtPvkz
X-Proofpoint-ORIG-GUID: -VNIRMSWhexqjgEM2tG9ipgP6zYtPvkz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/21 7:23 PM, Baolin Wang wrote:
> 
> 
> On 2021/10/14 6:06, Mike Kravetz wrote:
>> On 10/9/21 10:24 PM, Baolin Wang wrote:
>>> Now the size of CMA area for gigantic hugepages runtime allocation is
>>> balanced for all online nodes, but we also want to specify the size of
>>> CMA per-node, or only one node in some cases, which are similar with
>>> commit 86acc55c3d32 ("hugetlbfs: extend the definition of hugepages
>>> parameter to support node allocation")[1].
>>>
>>> Thus this patch adds node format for 'hugetlb_cma' parameter to support
>>> specifying the size of CMA per-node. An example is as follows:
>>>
>>> hugetlb_cma=0:5G,2:5G
>>>
>>> which means allocating 5G size of CMA area on node 0 and node 2
>>> respectively.
>>>
>>> [1]
>>> https://lkml.kernel.org/r/20211005054729.86457-1-yaozhenguo1@gmail.com
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>   Documentation/admin-guide/kernel-parameters.txt |  6 +-
>>>   mm/hugetlb.c                                    | 79 +++++++++++++++++++++----
>>>   2 files changed, 73 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 3ad8e9d0..a147faa5 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -1587,8 +1587,10 @@
>>>               registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
>>>         hugetlb_cma=    [HW,CMA] The size of a CMA area used for allocation
>>> -            of gigantic hugepages.
>>> -            Format: nn[KMGTPE]
>>> +            of gigantic hugepages. Or using node format, the size
>>> +            of a CMA area per node can be specified.
>>> +            Format: nn[KMGTPE] or (node format)
>>> +                <node>:nn[KMGTPE][,<node>:nn[KMGTPE]]
>>>                 Reserve a CMA area of given size and allocate gigantic
>>>               hugepages using the CMA allocator. If enabled, the
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 6d2f4c2..8b4e409 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -50,6 +50,7 @@
>>>     #ifdef CONFIG_CMA
>>>   static struct cma *hugetlb_cma[MAX_NUMNODES];
>>> +static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initdata;
>>>   static bool hugetlb_cma_page(struct page *page, unsigned int order)
>>>   {
>>>       return cma_pages_valid(hugetlb_cma[page_to_nid(page)], page,
>>> @@ -62,6 +63,7 @@ static bool hugetlb_cma_page(struct page *page, unsigned int order)
>>>   }
>>>   #endif
>>>   static unsigned long hugetlb_cma_size __initdata;
>>> +static nodemask_t hugetlb_cma_nodes_allowed = NODE_MASK_NONE;
>>>     /*
>>>    * Minimum page order among possible hugepage sizes, set to a proper value
>>> @@ -3497,9 +3499,15 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>>>         if (nid == NUMA_NO_NODE) {
>>>           /*
>>> +         * If we've specified the size of CMA area per node,
>>> +         * should use it firstly.
>>> +         */
>>> +        if (hstate_is_gigantic(h) && !nodes_empty(hugetlb_cma_nodes_allowed))
>>> +            n_mask = &hugetlb_cma_nodes_allowed;
>>> +        /*
>>
>> IIUC, this changes the behavior for 'balanced' gigantic huge page pool
>> allocations if per-node hugetlb_cma is specified.  It will now only
>> attempt to allocate gigantic pages on nodes where CMA was reserved.
>> Even if we run out of space on the node, it will not go to other nodes
>> as before.  Is that correct?
> 
> Right.
> 
>>
>> I do not believe we want this change in behavior.  IMO, if the user is
>> doing node specific CMA reservations, then the user should use the node
>> specific sysfs file for pool allocations on that node.
> 
> Sounds more reasonable, will move 'hugetlb_cma_nodes_allowed' to the node specific allocation.
> 
>>>            * global hstate attribute
>>>            */
>>> -        if (!(obey_mempolicy &&
>>> +        else if (!(obey_mempolicy &&
>>>                   init_nodemask_of_mempolicy(&nodes_allowed)))
>>>               n_mask = &node_states[N_MEMORY];
>>>           else
>>> @@ -6745,7 +6753,38 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
>>>     static int __init cmdline_parse_hugetlb_cma(char *p)
>>>   {
>>> -    hugetlb_cma_size = memparse(p, &p);
>>> +    int nid, count = 0;
>>> +    unsigned long tmp;
>>> +    char *s = p;
>>> +
>>> +    while (*s) {
>>> +        if (sscanf(s, "%lu%n", &tmp, &count) != 1)
>>> +            break;
>>> +
>>> +        if (s[count] == ':') {
>>> +            nid = tmp;
>>> +            if (nid < 0 || nid >= MAX_NUMNODES)
>>> +                break;
>>
>> nid can only be compared to MAX_NUMNODES because this an early param
>> before numa is setup and we do not know exactly how many nodes there
>> are.  Is this correct?
> 
> Yes.
> 
>>
>> Suppose one specifies an invaid node.  For example, on my 2 node system
>> I use the option 'hugetlb_cma=2:2G'.  This is not flagged as an error
>> during processing and 1G CMA is reserved on node 0 and 1G is reserved
>> on node 1.  Is that by design, or just chance?
> 
> Actually we won't allocate any CMA area in this case, since in hugetlb_cma_reserve(), we will only iterate the online nodes to try to allocate CMA area, and node 2 is not in the range of online nodes in this case.
> 

But, since it can not do node specifric allocations it falls through to
the all nodes case?  Here is what I see:

# numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1
node 0 size: 8053 MB
node 0 free: 6543 MB
node 1 cpus: 2 3
node 1 size: 8150 MB
node 1 free: 4851 MB
node distances:
node   0   1
  0:  10  20
  1:  20  10

# reboot

# dmesg | grep -i huge
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.15.0-rc4-mm1+ root=/dev/mapper/fedora_new--host-root ro rd.lvm.lv=fedora_new-host/root rd.lvm.lv=fedora_new-host/swap console=tty0 console=ttyS0,115200 audit=0 transparent_hugepage=always hugetlb_free_vmemmap=on hugetlb_cma=2:2G
[    0.008345] hugetlb_cma: reserve 2048 MiB, up to 1024 MiB per node
[    0.008349] hugetlb_cma: reserved 1024 MiB on node 0
[    0.008352] hugetlb_cma: reserved 1024 MiB on node 1
[    0.053682] Kernel command line: BOOT_IMAGE=/vmlinuz-5.15.0-rc4-mm1+ root=/dev/mapper/fedora_new--host-root ro rd.lvm.lv=fedora_new-host/root rd.lvm.lv=fedora_new-host/swap console=tty0 console=ttyS0,115200 audit=0 transparent_hugepage=always hugetlb_free_vmemmap=on hugetlb_cma=2:2G
[    0.401648] HugeTLB: can free 4094 vmemmap pages for hugepages-1048576kB
[    0.413681] HugeTLB: can free 6 vmemmap pages for hugepages-2048kB
[    0.414590] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.415653] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages

-- 
Mike Kravetz
