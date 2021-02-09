Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402973145AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBIBeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:34:24 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41162 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhBIBeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:34:17 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1191KIKI056298;
        Tue, 9 Feb 2021 01:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Whg3Wn3bkPLpIB7U3Jr/+uwByhDphb35+GY+uSfm3/c=;
 b=nClo1r90JJvWYNeTmdGGrODEM+OD92G2d0nr+8lYaveIA2Qp/CQkLdXKW0j+kXXQ66mR
 kPE86uSkZv3HejdsWm55GfXqKKi0/p8cr9YnQZas4ffPR6bErTawVTpJYYoYWxJpum1F
 Q93xc66rSPLjcXUTE5f1TYBMENL29ry0QalT+32jXlI3fFITDoxkC48Xu4nKYhJ33F74
 Xi9TW80QKLmDEUtva1Kh7v9HdlStenHWxYIldpvq00JCwrPRiGN617c69DpWNO57xHVB
 CRYUR+0ZXnZPuqLQpHUJcvbut6wAjpDYvaa1LnPZ3Y2/lFrx6mH7n0256DO22/uayLYz yQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36hgmae27y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 01:33:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1191KowC089571;
        Tue, 9 Feb 2021 01:33:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3020.oracle.com with ESMTP id 36j4vqmskk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 01:33:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaywACGJg17fOJwHr/VQbGQN9HfuKgJj4BQOCqxeyYk8J0zBob9dU7rfdtHoXzJIX625ToHHohcDARGKNnxY9gzjWuOTmK4A9bH4exYrIpP9buH4Kii2/Guh/KB+SiRtaIZBelgOc5x7GRGgwf8Dsw0Pgm+Tb+P0riUuc4sp9SOJGmQuUMQ2g/WM9yK19sGA6zfMLQGidLgp7T4Tw8kIEBpJ5RGyGaSPnVy1ZOXFaiR67iTzIYxn0qFDTtarwWcMav7A+KuFdIJv7d7P0KB2wih5b0qTT9FWWh2/AyotDM89d9pAX5pADjBce3Qn/8FcEyS4dm0ObByV2yPQUS6Bwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Whg3Wn3bkPLpIB7U3Jr/+uwByhDphb35+GY+uSfm3/c=;
 b=cA7UmC/Sr2AnqUFNemJXcHqbIpB0kioka6UU//hbZd0b4TVv8tmUFZeT3UfjfZa5Tf4X6KpbQtuxAO2wB70b+fCrLTJzFbzc2wVcMMwuz+nqRtPnItZsYJKWkEJe+NO2R/W69xeWmhAu/aSeHsdrAT+nd0O/jlj/0TIZyWGx10J+ZFYWIdYoFFwRf4MH6inqmWxE21I14skeB94CE6y6hQqJPOvlDlkXQhOC2FRGwyqbcgtJu8R11lR/QxOVfJFsG7freo3vvoHB7egcE/s90cNt7N2IL5AjVblmo3UKAsQVFhE82eZZpC4hpLKX77XnUwrIDUI4QVzeRiXzrsJJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Whg3Wn3bkPLpIB7U3Jr/+uwByhDphb35+GY+uSfm3/c=;
 b=CvcGj79KkMahBs8YPzMmvcebILo1gfquXIImK20A25V0pznU6NMElrvY9+qOn09DTxoKi2w/4P+YwCkwXvM9Y/fIWZR3HQrg+8BEzEekES8l6iwtvHeutHwfZPynImBdX4qIiHz603ayCr+Uu55FNmxD/5V1ebWaV0rQCszd4xc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4418.namprd10.prod.outlook.com (2603:10b6:303:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Tue, 9 Feb
 2021 01:33:24 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 01:33:24 +0000
Subject: Re: [PATCH] hugetlbfs: Remove unneeded return value of
 hugetlb_vmtruncate()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210208084637.47789-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a2627c06-6d09-0522-1d73-7f09ffb44a27@oracle.com>
Date:   Mon, 8 Feb 2021 17:33:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210208084637.47789-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:303:b5::21) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0286.namprd03.prod.outlook.com (2603:10b6:303:b5::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Tue, 9 Feb 2021 01:33:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ac8fb65-a4d0-47f5-79eb-08d8cc9ab10f
X-MS-TrafficTypeDiagnostic: CO1PR10MB4418:
X-Microsoft-Antispam-PRVS: <CO1PR10MB44180FC349CFC2208DC3B74DE28E9@CO1PR10MB4418.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:98;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfrJ0FlehOxcjggIAR1LhndcTU0Bgtap3mb2TdfxPQG+AwA9WnFqS9HWXgypHUPIBmhiwrwpVF2u0em/3pHvMkA7LNIQJ+NeYpnqmf1IdrUCbW4wDqsh4g26b3GQIlVzjl+g4GFuiwJSLTi4xGIr80PqXoXeHkvAB+4TqMkFh1dPohxxls1II67j+RVDYWOaJ9XPv6faxHwKnufwUoGCzDBQOMSWOuaEFZ5myf+bDsqRkt4gcIc9TQSrB9EXYTv0BzdqNF25TCB72FdM5pP1VC2wBMQVbDOTvH9JFsOYqx5Q+Zpt45ahjfQmcaqYN8qFC6zOugV3JWrIy2fifIg8yXyjy4fIDOzhq92NYNVj/gXt3mrohzXDaR9M0ottCk1cgYJe2Ef0vH2VOc5KtbPCTBT5q0OQ9wh15kfURIHSOvmR3EM4gIwQcOWrhNm4YDZzCvTgcRPkmUKX59WxJuxMKdIzvjTnPxVFUGzV884W/6wsI55pDm92OhYa6C23x+EYI4a2TihQGWYqkG+FSnc6jTnq+aI6vhzYNNXHuLmJOGP6P8RBRgnD+8zjNtN2UnhIBfRsJZrycOSi/xmogZ/FLzotU2hud7nnmEU9g6PwW7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(376002)(366004)(346002)(2906002)(66476007)(44832011)(2616005)(36756003)(956004)(66946007)(5660300002)(8936002)(53546011)(83380400001)(186003)(66556008)(8676002)(6486002)(16526019)(316002)(52116002)(86362001)(478600001)(31696002)(31686004)(16576012)(4326008)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NW1nWnhYQjBlWlpIMVlhZjZ3QUxHejRSYUg1d3BZVjR3U0EwSlN1VXk2K0tC?=
 =?utf-8?B?Y0pCa0VxZFh3WG56Y2xmTDBqYUIyNEUzSS9QblRienUxblFkUm5CSUVkcmhR?=
 =?utf-8?B?eDdHdzFQVEpVMSthUFB0L1pVa0FCYVlYVTlNNEpnZkZnSmlCb0JJQjNwVEhF?=
 =?utf-8?B?VUgyOXpySzM5RjJ1aXBGNE8rZVQ2Yy9zUTd4cVF2YzB5L0ovWHRXS1NvSDJU?=
 =?utf-8?B?OEJlV1BzYXhVZFNtczlnaDQvK1pSN1Q1WFBBczlQSWdHMkdvUXlEZktlMjhO?=
 =?utf-8?B?ejdocmxscEk4QWVTSTdsRGdEdmJmRUxVVWJURHdraTBSazI5VU5wQ1RPcTVC?=
 =?utf-8?B?QVluT0hmQy9LTW4rbEZkTkxnNEtJS2RFK1p3c2FFZmdBdTlENUplQ0dCY21W?=
 =?utf-8?B?SmxnR20zNXZPUFlYT24wL0gzdGxXRmtzNzI2TTZBK3hydWl5cHl6Q3RyT3g4?=
 =?utf-8?B?amZwbTdkNWZEajZPejZUNlMyZUNQZmtvZWlVZzBoUFRBRjBRdXRHTU5PM1Bv?=
 =?utf-8?B?cmo3Smw4K2YraVN2VE1IQk9nSTg3am5lRnlQZUhuUmVtdlJlc3c5UnFMSWcz?=
 =?utf-8?B?QTBNVEdDUG5SNzI0T0grTmIrY2xuUGJ6R3lHZ3pUZG9lREU0cStUMFk5UER2?=
 =?utf-8?B?ZFFrMmlBS0tqQjdDNDYxaS9PdG8zSnNiZkdiaXdvZlU3ZmdKZ2hEeTJrYkJD?=
 =?utf-8?B?Q3hmd3NUcUZyeFNxblZ1dUR5L0FESEJ0b3EzUWtzb0VlQ2tRU0hyMmxINE9t?=
 =?utf-8?B?NjdmbU5sT2E5ZmFwZjBmMGFIVi9QVFU0ODZCMFRodXAxV3J4MUtEZG9XeEVt?=
 =?utf-8?B?WDUyK2RjWldyd2ROdVo5WStQaEZ0RVRJZk5MTndsYjVtT0VJZWxqeGxzTXZT?=
 =?utf-8?B?QnF6cmdtRHNFdG44UjJqelluVGFZTWJYSUxsK011RWRxMlJnTnBaZVhldkkz?=
 =?utf-8?B?ZGZGQTlMaUFQLzdHa004aDJ0eGZOL09FV2VucHJlR0ZNcjZVeERQNHo5d2lR?=
 =?utf-8?B?V2UweGkwaGlNdjJUV25ESmFkV2tpdVBaME8zMjE4cjNZS2diZ1FSS0R0MzI5?=
 =?utf-8?B?b1BnL1hmR0RhMzBlOEpTWGtuajk1RlNEbXRuNnI5N1pDRFd6bmpabmx6R3RW?=
 =?utf-8?B?UHArcVJkb3hvYTFWS3F3eUZBSmVGaTRCYSt1dk12WTBkcVpRWHdqNEM0My9K?=
 =?utf-8?B?REZLTkFRSGltdnQrTkU4MnROUEllNG9oa0NqdFJKM1l0T3NNNHFneC9EMmov?=
 =?utf-8?B?MlE0SmZzOGFLUlRUbXVqTTJlbHRjOGVRd0tJdCt4SEtjc1dpT3VWMWFlcStI?=
 =?utf-8?B?S2NuWlhMUXFFeUVzWEdXVUorMlM0NXFiVHp2R3BaOGF6czN6L2hoZFZzR0Rt?=
 =?utf-8?B?WmM4V21SRFI2WncyMnhMMm1YaTN2azMxM2x6R2ZDbGJ0V2RDR1c4UVp6RHln?=
 =?utf-8?B?NklvMHBpWHhhVkQ1YWx3V2VTODlwN2d3ZldwTm00bEdLMEJLTGE2Ri8xYkxi?=
 =?utf-8?B?SkgrV0x6MjFRa2ZkM1ZPdHBoZERjZUtxOTVGQW9vNVJQckcxd2wrbDVLd2ND?=
 =?utf-8?B?MmY4aytNNzE2WW9VVmR0b1FEb0cwOU9uTWFoTmpIRUQ3RUltelRrUDZ2bVJs?=
 =?utf-8?B?YlZ1UlNKK2xOZkxqU2Vjd0JKT0swMHRKdlB6ZDE2OGFucUExaU9nNEtpZWlY?=
 =?utf-8?B?bFNiNUx6YUVOdVByaXFSeG1xNjNyZ09qYldmQnJsNU9SV0k5TnZ1Kyt0V0xx?=
 =?utf-8?Q?7i+/ijbeVc3TANO0pL/ogAZYzbkxO1JNO+rYQuV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac8fb65-a4d0-47f5-79eb-08d8cc9ab10f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 01:33:24.4604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8q9AkWpg800ScM7BqRiUui4I5GJPHuEPnBDever9dWpHsS/O3hiI4PwR3JMKLGLSiwdnupsUM8TkpbP7QBgDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4418
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090002
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 12:46 AM, Miaohe Lin wrote:
> The function hugetlb_vmtruncate() is guaranteed to always success since
> commit 7aa91e104028 ("hugetlb: allow extending ftruncate on hugetlbfs").
> So we should remove the unneeded return value which is always 0.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Thanks,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 394da2ab08ad..701c82c36138 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -567,7 +567,7 @@ static void hugetlbfs_evict_inode(struct inode *inode)
>  	clear_inode(inode);
>  }
>  
> -static int hugetlb_vmtruncate(struct inode *inode, loff_t offset)
> +static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
>  {
>  	pgoff_t pgoff;
>  	struct address_space *mapping = inode->i_mapping;
> @@ -582,7 +582,6 @@ static int hugetlb_vmtruncate(struct inode *inode, loff_t offset)
>  		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
>  	i_mmap_unlock_write(mapping);
>  	remove_inode_hugepages(inode, offset, LLONG_MAX);
> -	return 0;
>  }
>  
>  static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> @@ -781,9 +780,7 @@ static int hugetlbfs_setattr(struct user_namespace *mnt_userns,
>  		if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
>  		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
>  			return -EPERM;
> -		error = hugetlb_vmtruncate(inode, newsize);
> -		if (error)
> -			return error;
> +		hugetlb_vmtruncate(inode, newsize);
>  	}
>  
>  	setattr_copy(&init_user_ns, inode, attr);
> 
