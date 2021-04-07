Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51893357659
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhDGUx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:53:29 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49626 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhDGUx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:53:28 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137Kn3MB187251;
        Wed, 7 Apr 2021 20:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=K7NzwZN2jUzmmqQtP51R4jbgRys3wA7YKifPDbP+/x8=;
 b=YVlgKWzk9rXZusZLMAHWpzq2U8B5jcU97eLtHZjVbUB8qtzOrBGrYnC7py74lnBq3Z9V
 6ak14xGeOAKPPgqgmuCtJb6HNtEv1gpvHk6gQ+izNUj+PLJrPxMtLG63wt/MTfmQdmpI
 24fcxQYdf3Q0mDWxtkYe3I2U9rDJAsF3zAZs8ZgVU45X5vvDCIjjc4sozAAn87OITOM5
 qlqFXhsBV5F1R5FSlZjFQZu4SxAhCS/swgvyjAMC0glYi7VcFfgtXVh78moTneYdxP6M
 7lO3Wg1zq5nE2BU8z48z+D4odjc/bvwSb2Uga7G/KwwEklTHmYR+l0S/nD0UspQPAKoE pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37rvaw3xjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 20:53:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137KnxD6093355;
        Wed, 7 Apr 2021 20:53:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3030.oracle.com with ESMTP id 37rvbeuuuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 20:53:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByQMK2ZOt3gpt4vScyOH5xyqBgS4kyJ7M51o5E0HupH0z3jHiMQcDg38DGhgACkTIziEZbGrZ6Q06OIOcON1kmF4dvpcaCMkC9zYmXnWTSqoZup0Jd2JhxQ52vXNmwxvV9EmGez92gs4fPrhFVqLsiwuvAo5+uW/FW3Ky4MPclYaSIDCZl3vh5hUdWSvp3X9NVqauXJYQZAUuWP6GnGlGRbZYL50jJ6SW0n/kNF8iYtV8wYNm4HnlR4cZ3D+4V+PUTQul2Za3pWMXE6JD6otgW2VMKn7qjF7HcSrykZXN6PvCSiLWD1VrjahHx+l2vVK+iIY3HWVoyTcGlkNYZibRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7NzwZN2jUzmmqQtP51R4jbgRys3wA7YKifPDbP+/x8=;
 b=FzQ4/w5iA/Qn9svpCOh3n0vqYxSv/usfRfAlKoOP4Ay9Ob+3eoNKx2ZuZpfsu7pqz0Y1OlinutVT6mljWYwcktYDjwyCHJ2d07PvkayK9L2vVfmxgWheNp5C5y9RII+I0RMoo6vMX07du9FOY35SA4rHZrbr52sV0q4nms95wQDQLDld+dojQALVMOcB2BJfn7GH5eJOtolaMb954+rCYhfYldB6wvhwb4zMIeXLXmjOkbslBhtlaQ9Mt0HAo1W5JkNFuB0+heQBMGoH9/FtpHJFlOw08XMghQceFFd1CyCwR4xMDhlM3VaBBbc3AZ8QKP9/qB2Pot1DF3mfQyO7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7NzwZN2jUzmmqQtP51R4jbgRys3wA7YKifPDbP+/x8=;
 b=gBv5x6ejWPo49xxeQHw6Vph2cstVd5BRHf2QwzPfQ1X5tBatt6QfontnK0uGPxI8KQj+NSQpFiyXwd/8Gyh/sHyG0fQlOB7FZlo7L26Ld6bVI+2s40W8DqBsi97KP5ylbXy58Ed/uSFqZ4eoAWkHVTK7uEnXGiUh8m4uQttFoOU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DM6PR10MB4203.namprd10.prod.outlook.com (2603:10b6:5:219::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 20:53:05 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::d973:8f33:7333:2717]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::d973:8f33:7333:2717%9]) with mapi id 15.20.3999.033; Wed, 7 Apr 2021
 20:53:05 +0000
Subject: Re: [PATCH 3/4] mm/hugeltb: fix potential wrong gbl_reserve value for
 hugetlb_acct_memory()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210402093249.25137-1-linmiaohe@huawei.com>
 <20210402093249.25137-4-linmiaohe@huawei.com>
 <20afccd5-2bc4-9db9-695e-dd6175b0b42b@oracle.com>
 <1311fcfe-bc5f-e878-3912-ca9a9e0eed90@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ecd3e4c9-1add-c304-5f26-7e34e5e6494c@oracle.com>
Date:   Wed, 7 Apr 2021 13:53:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <1311fcfe-bc5f-e878-3912-ca9a9e0eed90@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR14CA0052.namprd14.prod.outlook.com
 (2603:10b6:300:81::14) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR14CA0052.namprd14.prod.outlook.com (2603:10b6:300:81::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 20:53:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8c9619b-6daa-4529-09af-08d8fa07245a
X-MS-TrafficTypeDiagnostic: DM6PR10MB4203:
X-Microsoft-Antispam-PRVS: <DM6PR10MB4203473E4816F31AEB3072D6E2759@DM6PR10MB4203.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9NYakqpnYtzhfv9IN3n0IL0Rs1DlKhIswPGLX4xHArwrRYvFVvOnGT1sxrTcKvbshO2WyErQfQPQQRuRqfUgsoDh1bitaaIClsfVKTiBJRNMi4vtEA23dBVhuO6dfX7cPBVUp69rCDtnIH0fTLIUEy0tA2iYSu7dK+EIrijpWBCvzqwzL4g7tLQ5nigqKeXGOgS6kjyrYzmM/zWWrmx6yAV5HUAzeKZjbtJpO6J51/dcGUpQm+gCfGSQyFrB4PEmp1KjQUI53SGUDUkhJuf/HmM5EfmmKRXWyiQ0Sc+1R8QViooYm0W+PhpG8gEvRrXXLS5kwTVhntRrr6AMR5/m39OzSRKXE9cpjBsQoMOWT4Cf8V4Z2yZ6lt7Hp/Qu0F8Ugcc3hXuV8tLeoLvyDa20lCw7bSckRDiiHPrBr+gVDziDNxsA7zoDtcTLsUnwW+ACmcqEnIX7kU5t6pNj+6g+JJfp6LPiwACHyP6BGgpwj3ZN5P/gnZKhu0Df4VZBsQeafVrm4ufrdMahP36wawOUdT/L8hUcHXhqVZ7vwL7jSlOl4lyB976xE+bTIewTOAy3iDRBmPheIHqDrMRrxdpBr7P2WrROrFhnwf2INtj3zafjQ7DpyA6i0mPbYRVMsZPVGhkIsPwnScOn3R7S0b97lnDRvWIyCLxZi80iMWJO7HAuGMu62z5K0Qo1f6jSKF4H4zE4ThxPYJYxeXqDmzPdpL6tJiuCH69LqH/CsYrWiPtdAYzL5Ljj0ROsksmxq0Ln
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(376002)(396003)(346002)(83380400001)(53546011)(2906002)(31686004)(36756003)(8676002)(52116002)(5660300002)(66476007)(38100700001)(66946007)(6486002)(16526019)(6666004)(8936002)(26005)(4326008)(86362001)(186003)(2616005)(956004)(31696002)(16576012)(66556008)(316002)(44832011)(38350700001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cW81b09Pb0R6RTJCQlY1KzBjWXZTb1ppM05HemN0K0NhUVIrRTdaWnNNKzBP?=
 =?utf-8?B?dG9pUjU4VVBFYloxblYvWnQwREYzejFoV0Y1a3diaVZ6U01tanFpVG1uQ2li?=
 =?utf-8?B?TGJNMGxqOHJScFNYQTlHYmY4TXJmUHQ5ckZla01vMi9RUFNHb0pYM0RNRG1B?=
 =?utf-8?B?VEo0aHh6elBFUG5sRExxVld1cnVyY0syTm42TUxSS1VPNXNMMm8rcEVPSXdI?=
 =?utf-8?B?N2lHUnNKdWJDbzNTNWhrcnlyZVk4V1dKUkh3a1l0TVhNWk5SenpFYlFTK1k1?=
 =?utf-8?B?MmVlR2VPU252QVJDV3Y0QU5zR3hsam5tTy9QS0lJYzMyM3BsZnlzNFB2SHlu?=
 =?utf-8?B?NDhLbzBvWjZ2Q2plMCs5ZXRISC8rRlRlODJwTndzdWFhcUZ4SXBONDY0TURz?=
 =?utf-8?B?aXNnY2s4UWp0S0dqTlBFOXppQm9aMmJpWi83U1FZMTZZQ2xuRnB4MVVxVERs?=
 =?utf-8?B?Tm9tK09YK2crc0Rva3pKS1VzQzY4YjlaaG1kUXBmVGU2dWNLVlQ1ZUlsa2Rs?=
 =?utf-8?B?US9ENVNaWXRWb0tqWHdJdWtnOC9CSVV0SWY3SWtIOC9HdnAwMVQ4L2xjUFA2?=
 =?utf-8?B?ZHVMN0h3WmUwWWtReWwwOXUwV0NPU3crR2hRZmtpeDBIaWZGbGd3Q2s5Z3Bq?=
 =?utf-8?B?MGpFMnN3UUp5b0w4TXZ4Y0YwcDdiWWVjSTVRNGJuVUJvRk9SZ202RjZPeWdL?=
 =?utf-8?B?UlRqMjBzeXIzVjlKVW9qU3cyc05ETFdLVFBUNFpyTkhxc2FUQTBDcENEdlpr?=
 =?utf-8?B?R0ZWS3hWbjc2NmZNRk9RdkJ4VktrbGZPZjBmUzFab2ZVWDdmTVhYNUNjbjcr?=
 =?utf-8?B?UXdlSVF6VkdORGNhLzFkbmZjblVxTS9iQllxUmpVdEtRVk5xRXg2UFdJRTZR?=
 =?utf-8?B?TnRNaGMvOWtNSFJOazd3S3Yva0tvK1pEMlRtb2NPaU9uVkwyb1dmbHRzcUpt?=
 =?utf-8?B?YnZ6RVk1WWh5RnN5WFNnV0IzTFhpL29ybmdNTzFDVTd4Ym15bTgzYm9vdkVk?=
 =?utf-8?B?dStKWTZORUFBOFAvZHgvUUVGWDhPR1ZJU21McGxXM01OVUt5dlpjQmlWYUNi?=
 =?utf-8?B?RlB4K0RUMGoxTysrVlJLeSs1WlJDcWhpVG1QNzZja1dFemY4M3VPOWFFZnhm?=
 =?utf-8?B?dEc1N0pEeEFxeUR0SmprbThwMEk4dGZMTitTT01weXJGd3JHa2VGVVVXclR4?=
 =?utf-8?B?VHZvK2lsL0c0bmhjOTNralVFRkJIQkEzSjhMZHBGRWg1a004NXArcUtnUDRG?=
 =?utf-8?B?QVUvZFJBNmY2elFGLzd2ckJxNW0zS1pYVjNwUnhzSVVVdWI2OVBpR1pyclFs?=
 =?utf-8?B?SlRPdkZhUFZoOExheDZKWFJuT3NRdEVUTExtUmN3Rm8yYWtkdEM1bDEveVY3?=
 =?utf-8?B?aEV5ZlU3SVRmb2lxQ1Q1WHI0TmxRNkdVekhNL2Nxc0ZERGcxNHVYOWVZNUFs?=
 =?utf-8?B?OWxMcHhOeHFyWEFsUUc2ZExuWElQTk03TkpDaStLNGU4M3ZiZ3UrVkRGMlNL?=
 =?utf-8?B?TTRDa3IrMmVrS245NXJXTVRuaThJZlZGbVRveTc4WFZDSlhvaVoyKzNoMUJu?=
 =?utf-8?B?YXB3OUJ1UGVCQURTaUhjYVZ5eFphQlpIMDIraFpPYjVxQ2FVUGJKRXUwcDhX?=
 =?utf-8?B?c0hDcWpkbzJmbzczMHlpMmNYbjlvL3dEWDYxZzdHNE9XeHEweFBERjhZUWlk?=
 =?utf-8?B?VVBLbWk4SHVIbVBiY1JocHkyVGsvd2FJZDB1WWIwSzVzSGZFc3pVZlR3SWdG?=
 =?utf-8?Q?fM9+qcG/FdYMUypIuqxMU8i4rC2djhLT465/SNc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c9619b-6daa-4529-09af-08d8fa07245a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 20:53:05.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shU0OAw/Lp/UVXICXqQujka4k/dEwUNsbxE2nB31Dyt2xvL7OBm3L8RFIoI74JFoFdlHEOVMHVnqtjyPVLPliw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4203
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070147
X-Proofpoint-ORIG-GUID: wd6QIxKaYE_UShNsqe9KskGbBgyMroYD
X-Proofpoint-GUID: wd6QIxKaYE_UShNsqe9KskGbBgyMroYD
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070147
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/21 12:24 AM, Miaohe Lin wrote:
> Hi:
> On 2021/4/7 10:49, Mike Kravetz wrote:
>> On 4/2/21 2:32 AM, Miaohe Lin wrote:
>>> The resv_map could be NULL since this routine can be called in the evict
>>> inode path for all hugetlbfs inodes. So we could have chg = 0 and this
>>> would result in a negative value when chg - freed. This is unexpected for
>>> hugepage_subpool_put_pages() and hugetlb_acct_memory().
>>
>> I am not sure if this is possible.
>>
>> It is true that resv_map could be NULL.  However, I believe resv map
>> can only be NULL for inodes that are not regular or link inodes.  This
>> is the inode creation code in hugetlbfs_get_inode().
>>
>>        /*
>>          * Reserve maps are only needed for inodes that can have associated
>>          * page allocations.
>>          */
>>         if (S_ISREG(mode) || S_ISLNK(mode)) {
>>                 resv_map = resv_map_alloc();
>>                 if (!resv_map)
>>                         return NULL;
>>         }
>>
> 
> Agree.
> 
>> If resv_map is NULL, then no hugetlb pages can be allocated/associated
>> with the file.  As a result, remove_inode_hugepages will never find any
>> huge pages associated with the inode and the passed value 'freed' will
>> always be zero.
>>
> 
> But I am confused now. AFAICS, remove_inode_hugepages() searches the address_space of
> the inode to remove the hugepages while does not care if inode has associated resv_map.
> How does it prevent hugetlb pages from being allocated/associated with the file if
> resv_map is NULL? Could you please explain this more?
> 

Recall that there are only two ways to get huge pages associated with
a hugetlbfs file: fallocate and mmap/write fault.  Directly writing to
hugetlbfs files is not supported.

If you take a closer look at hugetlbfs_get_inode, it has that code to
allocate the resv map mentioned above as well as the following:

		switch (mode & S_IFMT) {
		default:
			init_special_inode(inode, mode, dev);
			break;
		case S_IFREG:
			inode->i_op = &hugetlbfs_inode_operations;
			inode->i_fop = &hugetlbfs_file_operations;
			break;
		case S_IFDIR:
			inode->i_op = &hugetlbfs_dir_inode_operations;
			inode->i_fop = &simple_dir_operations;

			/* directory inodes start off with i_nlink == 2 (for "." entry) */
			inc_nlink(inode);
			break;
		case S_IFLNK:
			inode->i_op = &page_symlink_inode_operations;
			inode_nohighmem(inode);
			break;
		}

Notice that only S_IFREG inodes will have i_fop == &hugetlbfs_file_operations.
hugetlbfs_file_operations contain the hugetlbfs specific mmap and fallocate
routines.  Hence, only files with S_IFREG inodes can potentially have
associated huge pages.  S_IFLNK inodes can as well via file linking.

If an inode is not S_ISREG(mode) || S_ISLNK(mode), then it will not have
a resv_map.  In addition, it will not have hugetlbfs_file_operations and
can not have associated huge pages.

I looked at this closely when adding commits
58b6e5e8f1ad hugetlbfs: fix memory leak for resv_map
f27a5136f70a hugetlbfs: always use address space in inode for resv_map pointer

I may not be remembering all of the details correctly.  Commit f27a5136f70a
added the comment that resv_map could be NULL to hugetlb_unreserve_pages.
-- 
Mike Kravetz
