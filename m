Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC75831A91F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 01:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhBMA5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 19:57:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58788 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbhBMAwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 19:52:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11D0oFBs165823;
        Sat, 13 Feb 2021 00:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lkDdw8v0FfKaUWNmlGP659kXnIBf5y9mPyQ7rzljM7M=;
 b=ouWrzhEUivd2eIq0raSvB4QEYt0Aw4ncmzrjRZv8A6DIqI/sPWtF42c57yqRs8MurSY4
 /fXhMvVl/Dg36sn4I23PKpZnNYhf2zm0siKDnAMJ330P/6dLl+7JKucOGOkk4l7z9CEr
 Wu/VVw1b91QC318fhU9nv09ApKaVEgrfZGPcLFzAtUTAsu540/RVs2iYd5ePWTryyUKd
 UfR/0eSf2vkqiLPVWkI88I3JKrlUdTE1MFRtYMYp6r5y904KQRteW4QTvxc8NV8umEFD
 +EcBE6O6e2+kodfX5UL5BRPjxxEaHmqctOjW2aQ1LOJo9cZp2hRmOn55lCzptPgi91rs Fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36mv9dy7tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 00:51:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11D0o84G156347;
        Sat, 13 Feb 2021 00:51:44 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2056.outbound.protection.outlook.com [104.47.36.56])
        by aserp3030.oracle.com with ESMTP id 36j4ptmgpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 00:51:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHgJiBC1HuuTFAMqT2BlHPoRb6/oax5vSIgxdc6lM1GHLZmxPvaoPgH06sdp/yqGjLFvCDZlWOo950mH/Yc50nps85a5QZHigpSOq8e6Q0Yvv/94P9e1Rri70BOL82TbViueRkp9NL+gpkuSY4wm8eX076T3HmdJyX9+QVHcuvLCYnBaPRITjr4+TObDss2FiFTykjOtKzyPzV3dCokzWmYyUBc4l8tP/CUtML+BJ/mUyd83iUL+0z7qQKM0OpBKZ2kTiSJc9GxQ9GXU0lneSp/NusFs+8y5nvD0HTNqK6XEvEzQc/dKp6yRVU23Ug9Ia6ln0xaskxy1gESNl+U4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkDdw8v0FfKaUWNmlGP659kXnIBf5y9mPyQ7rzljM7M=;
 b=KJf5/XwT3EvIU45GvlrOuNMcU8GygkQlQPLXz/WhZ0GGs7wMxOg22LK9G68l3+nxD7p/HOM+hvy3xWRKJyBZNXhPCXj6UqZrRrUgP07jtRPKwTYQDUCxH4u/k1Y9Av1qZFtgAIJIWIM6h3Ffo2ZIQgsiHkWFirYaIP7biPHUmdM3sQX0wFm+kPJk0nQx3Pj32mkuWATHBwfUCionTWiLEOTpy4CnBk7vKoxqxLRGa7ruGdajh6oV2SPZ799UxhxgPDnNtgAZ91ty/ESLksbbL+YqUP9P3IsnjFnpjweiutLc3RsbAR74M5eOAVWXK2i0vxqWDb48B6b9eKZQUS8uug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkDdw8v0FfKaUWNmlGP659kXnIBf5y9mPyQ7rzljM7M=;
 b=hfQcLrdVqxuzlSK1a45H6sjZ8DaeJHWm0mJKQ6p3XULPxCXfQxQyvQeQ3CxsV8r3uK/eCSdvYuqwaJdNhpU4H3fWjo8guwTCI1eE9yix57UrHXGLvkQXdDtwd2g98jwa8/F0uxS0C2vWaSBtSD6YnvzM2CGj8zgl6jRVmguIeDs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1630.namprd10.prod.outlook.com (2603:10b6:301:a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Sat, 13 Feb
 2021 00:51:42 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.035; Sat, 13 Feb 2021
 00:51:42 +0000
Subject: Re: [PATCH] mm/hugetlb: optimize the surplus state transfer code in
 move_hugetlb_state()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210210071251.44084-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f3f61091-3a3f-5c6f-bcc3-934cac25a8e1@oracle.com>
Date:   Fri, 12 Feb 2021 16:51:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210210071251.44084-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:300:115::25) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR11CA0039.namprd11.prod.outlook.com (2603:10b6:300:115::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26 via Frontend Transport; Sat, 13 Feb 2021 00:51:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 020782ed-805e-4618-bb52-08d8cfb98747
X-MS-TrafficTypeDiagnostic: MWHPR10MB1630:
X-Microsoft-Antispam-PRVS: <MWHPR10MB16309FE8E57914F5B69220B5E28A9@MWHPR10MB1630.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDn6uyETO1IYMd5XTNsDujcYb7ejq65Xr1WC4oOMo6AQw0i8xLw0g82dA8sSwblI2ohRo70chvi3pGkeqYAKPJhZlsbLO0sycAZvv0deJbWVkWfRlFXVZTGV//OaoGF5Yz3RNhKFRGPwD1STgRLA+CHfUq61I8yQ0fEu4JxzTcSQ/aW0HpHrCejXob4QuWQGXbnl0OtA+JTe8IDshcOfLwR8QMcxgc9UJcD8UiQz4jZWAe6ubA90AHMkV25Cw02UT29lYNAMPky9Ghr5VglTknrnCVZ/XIClj+4Dm8bTMGMuAWMukv4sD+AEipA22qgli4mqd0J8k6I5xohOOlyzNJBLUKbvVYqAAnY7J5PPFhpjELjABmfLgs7uqlzaeQJQ0nBlpNv9rxAyoncTWZh+VRVPXCaPRm4sxTUikeXfKfRAQmWQyOp65V6BvNCGUh/yOxLqFwgliTSwMEp8GdeJFTccWvl7Keouk7m+09am0EUP6YH8NPtNqPCDrDBLT05M8kAxO9wjylqkVpxwz3islb36LkSN4EbtrVoU/om6L6npH4CcGYNi8hrbt4YKoro3KOkriKzdjOBdtoKjSyRMjkAJH/PZotkDfyH7zGx9n08=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(39860400002)(366004)(396003)(53546011)(86362001)(26005)(16576012)(16526019)(316002)(186003)(83380400001)(31686004)(8676002)(5660300002)(31696002)(2906002)(956004)(6486002)(66556008)(66476007)(44832011)(66946007)(52116002)(478600001)(4326008)(2616005)(36756003)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eVVraDFwbFNqbjVXNFdMTlM1U056WEtlTmJERTUrdTJwOUVyUndvWVltYWRO?=
 =?utf-8?B?VXFjcUROOXNrc2NZYkZrb1Z0VFNoVkpHUjBic0wybTdoRlhSdDEwVU1WZEhv?=
 =?utf-8?B?US9LenZheG5INUMzZTZHaTNiT3pwRlJPZ25lSDNXT0VhYjRzL2RoMmpYRm9s?=
 =?utf-8?B?TUx2YnF3blJENkxzTzMreFUyZVFaSjRmL25KWk9FSmczSkQzdTBIY3ltUmpZ?=
 =?utf-8?B?UWlqV2xlV3R2M1BkaWhPczJ5ZDB1eFIzMjRRaUlWMWRaYldmaU1WUGgvRTM4?=
 =?utf-8?B?SzRwNkRHRFlBUHZlMUxPZTJSQThveXBnR0pwNVNlbks0QXBzbVBMeVFsUGNQ?=
 =?utf-8?B?ZmJ1alAvV1RFK3dnUnE5Vnl0bDBxV0Ewc2QrMFJSMCt6dG1ZN2FtTE9kcnRW?=
 =?utf-8?B?RDZraW5ReTVtWVR2TEp4MEE2ZitNbTliRDBpWlpEUTlUOWJDL2ZhNUdDa1o1?=
 =?utf-8?B?MU1nQUF5VW5pT3pqUFNkYXVtSjhrWDZIaFpxamQ5emcrRG91b2NTL1o4cXRH?=
 =?utf-8?B?Rm9iaE84ZGg2UWxiUUwyUDBGNHUyajludVphWGk2RWh6RDZOZi9VaGtzYWRp?=
 =?utf-8?B?bHZVSVg2dU9GOEp5bFdUM2cvWXhNU2xaOWNNbFlvM2tVaHVnUjFRRUZ1TnZv?=
 =?utf-8?B?RlRudjJ2VXVSVmtDWmRIbmU2NnpiZHRlQWtUYkJnbEJZYis3Z0RVSFZzU3Ro?=
 =?utf-8?B?NWxIWEZRZ2V6TnlhTDJuTkJ3dzMya0JKYlhEVTBCZkpFOWtycG9sUHZGNVFG?=
 =?utf-8?B?bkVBcmFWamhqV085RFJjSm9pU1MwNENZRWY5QmpSL3dCeitzZHcxUzFobDgy?=
 =?utf-8?B?VlVvZkRpTTgxUUlOYnQxa0YrdStKa2ZsRVJCZkZHL1M4dCtrYnFoRDZvdTAy?=
 =?utf-8?B?SCtMYkJneXQ0Q0xKMWRhb1Z6TVhRNi9PaDhtem01WUpUWFdFZTFiaXNmRlFL?=
 =?utf-8?B?UmxkTDM2Qmw5WW9vVVpyRGN2UlZ2cklkVzN4RklPYkJDaFZRVFpSdXZLdEto?=
 =?utf-8?B?VmFCRndjcHB3a1E3MVRzM1VXZDB1QTNCbkFwajByTkZiMFNmVjFER0JpeGor?=
 =?utf-8?B?d2N1cTA2SG1LalJnZmszWmUwZlRzMTdVSWtmbVluZ3FGY3BPc3RJOUdCL1Ba?=
 =?utf-8?B?bGttaUt0OWZPL0RvZThiT2k3ZjlsYzZ6K1FUeFpSR1FUems2Wk1kc204T3RY?=
 =?utf-8?B?V1dJMVJ5My80M0tJWkg5c1p4UnZIRktib0hEaXIrbWZCRlo4WUhmK3E2TGZK?=
 =?utf-8?B?cTRtS081V1hieWVzbG05SVhoUnA3dnNySmJLU1JBQXJZblgvVGlNbFJuUm96?=
 =?utf-8?B?R1pQdks2aklyRUJrNmUvUzB0NkViWllOZTBocTRvOC9wK2pkd01ranZ0NDFH?=
 =?utf-8?B?TDlNR3hYZGtESWhyK3FHdXBrYTFYZXA0QkZxMlJRTUpUTGJRRVFlQzVIZHY2?=
 =?utf-8?B?UHZRWHNuTkc4OFM1QWcxQ1QreW5wbHl6Vmhtbi9lYmx3ZmxNSUl5SUxZdlMr?=
 =?utf-8?B?QWtLLzNLQWl6V2NXQTJUd3ZPci94TWxlYUxYRDFLcEJxSXNWaEdod01QdUxW?=
 =?utf-8?B?cXF0L3VBMDhGNXFHUGxGMnBwVDVnYzhYWm9xcDB3RU4yVjU4OU5Mek05QzB2?=
 =?utf-8?B?TkZ5RlhDKzBGOS8zb0JJZjlTN3hRMW5IazVSeCt3Z2ZBM21xcjk4SThJRCtx?=
 =?utf-8?B?NWZmb21RYng0TkM3cVNHS0VMZHJwWUk5OXRnMXNOZ2FMcTlCVktGRFIzTTht?=
 =?utf-8?Q?FBrqHqkNz7gW5VVlHiIdR3weQJUGMxMvxhELClk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020782ed-805e-4618-bb52-08d8cfb98747
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2021 00:51:42.0988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwGQk8COYOSjSC0poRyJTuqN07MqE1hcUM+nshTKkfbhFO4WE3itA1j3zVfrcZATQ8CeBfElejIeydkNpMTObA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1630
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102130006
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102130006
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 11:12 PM, Miaohe Lin wrote:
> We should not transfer the per-node surplus state when we do not cross the
> node in order to save some cpu cycles
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Thanks,

I was going to comment that the usual case is migrating to another node
and old_nid != new_nid.  However, this really is workload and system
configuration dependent.  In any case, the quick check is worth potentially
saving a lock/unlock cycle.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index da347047ea10..4f2c92ddbca4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5632,6 +5632,12 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
>  		SetHPageTemporary(oldpage);
>  		ClearHPageTemporary(newpage);
>  
> +		/*
> +		 * There is no need to transfer the per-node surplus state
> +		 * when we do not cross the node.
> +		 */
> +		if (new_nid == old_nid)
> +			return;
>  		spin_lock(&hugetlb_lock);
>  		if (h->surplus_huge_pages_node[old_nid]) {
>  			h->surplus_huge_pages_node[old_nid]--;
> 
