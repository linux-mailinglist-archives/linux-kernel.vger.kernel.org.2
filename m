Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D217C359006
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 00:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhDHWyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 18:54:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36884 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhDHWyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:54:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 138Mo6g2104625;
        Thu, 8 Apr 2021 22:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QinCbRn3/tF9SjKhMumbXAGYqlSceKf0j9pYtn2Wpmk=;
 b=GD2GRS1zar+3U/orRuQ1mO4RvxdqSNI2T4eL5TZk570NCQNFVqOEMh13P7R/d+HOnqlS
 wu6Maw/wo4SvxJFA3L/lMNmrgbbVs+qR/SBKA05wNZ77OVTdCixVcYPWTH6j8Bsd0iq4
 JEH/pppstSHRwwF8/GSgAW7cX/QGwMToXvQ5wM3kVIigkWL27ttDHJFeHCY1XBCgASIG
 +twUjypv6t/lezT+F/kgEd8rp2fM1g33J8fpHT/FH0zcdwAWfixeEcH/U5UgTs05RrHK
 mz5OHGv2AfegvOcYTvV1cP3zCFCIU22aaSFrSYtYFQI+3mtl4/9/Tsw0G2wfHVGv7ODU WQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37rva67hr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 22:53:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 138MoDho141179;
        Thu, 8 Apr 2021 22:53:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3030.oracle.com with ESMTP id 37rvbgvt5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 22:53:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef6rNdj1Nif7wLjoHh8uloCefXsnc02cyfsqgP0qFbTJHPe63Abne4ZwyjB45U8xab2c8O/Hm6NfWCu4jGCXPPt6mLwG9yidHO/jBYyVArplEI1D6+IusKh1yuAK34iEAIaZ39nZ+pD86HnUNKGCtqcQRqUed2yEbf724bebkTAo7hQvV77vcM0eWDWkIKYvlapjY0ajo1+0s59LrGugQ/xHYz6wO4xaklKpFi62yuLKf7vWAKhdacdw6Jvanj2BQC36xQQEU3c+xhymdBgPCNqCHrixQd3OO9C7uNW/LrUZS1FJM0dqM9kTATB7JuVChyWzsHYVywAmvLDTmdH3+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QinCbRn3/tF9SjKhMumbXAGYqlSceKf0j9pYtn2Wpmk=;
 b=HiX7i1b1sz1tXYaRIf3AVk3czYw5Dc5c+Ku3yNDtmZSkR58W66BOO13Jx1mc0drKhvDTbLQFRFW6lW2o8rxTEDkj9uQZ2tT1Ok5wNZMMggJrR2QQeqBcfB/F6HxeH6jLRF3ZE57MaDmZ8ptwEXQxSFsg/KxIOoeQR4hYdpKfOZDJ0qHw9D0OZVjr3pU6IthRUyLT52/3pIoyyPkq+snxWqeG2vhTPs4QTUYH7a8gjPmbpp8qHlBwkoeN7HVwdme2lYpelPX1lvhYQVx0unMC7CDzRN88sTla/ogKM5qTS6rXiiJruOoR0j+WdQ1qw80yAck+4EoJiCSL+w5NknUn2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QinCbRn3/tF9SjKhMumbXAGYqlSceKf0j9pYtn2Wpmk=;
 b=is8IcpsPSnGbV/F0qJN7JS4Mbl+WuKDSApA1zLLCnpN2EjAjt37fvVDsF38ydKI/Q/3rKl1ORQzTPwTqzvFS4gglhRJm09hQOfL1eGF1nza57xnFLiHXsgQkAp+NjIJjNyrMVYdiIeG/U1owahCNyVy6UpMdEKFH6JiBvf7qsV0=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4323.namprd10.prod.outlook.com (2603:10b6:a03:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 22:53:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 22:53:43 +0000
Subject: Re: [PATCH 3/4] mm/hugeltb: fix potential wrong gbl_reserve value for
 hugetlb_acct_memory()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210402093249.25137-1-linmiaohe@huawei.com>
 <20210402093249.25137-4-linmiaohe@huawei.com>
 <20afccd5-2bc4-9db9-695e-dd6175b0b42b@oracle.com>
 <1311fcfe-bc5f-e878-3912-ca9a9e0eed90@huawei.com>
 <ecd3e4c9-1add-c304-5f26-7e34e5e6494c@oracle.com>
 <ddec1fba-25ea-ebb3-fb87-41671db5cb92@huawei.com>
 <0ebaa062-80e8-b380-c02e-7eb72e67f973@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <90188b1a-a206-5586-2da9-683f7537f960@oracle.com>
Date:   Thu, 8 Apr 2021 15:53:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <0ebaa062-80e8-b380-c02e-7eb72e67f973@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0082.namprd15.prod.outlook.com
 (2603:10b6:101:20::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO1PR15CA0082.namprd15.prod.outlook.com (2603:10b6:101:20::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Thu, 8 Apr 2021 22:53:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d7ab38e-d4ae-45f6-b8cb-08d8fae128cc
X-MS-TrafficTypeDiagnostic: BY5PR10MB4323:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4323E883190904704FCF7748E2749@BY5PR10MB4323.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRF4LLZvqVXmpwf2kFvZz8f6lzMn6K2DZ8Jd+xaK4SVg/Q85YjjzShByGmuZ7NXamx4GHS7QfXdL/Q5gm+nJTRLNYbZiFbtqk27Bpe8T3LP50rt1Gl/jStUwWVvUAvBmgvFljAACKZ/dI2QJORIAdvOk4rVgdVUj2yvu8gtjw45m6HIQMz/8wnQ57RUSFpzhu7shZV2yZv/E8lUZQXEG+Ax0dwHFXSW0vv4vRAqw/hR2D35BCI2j6ZJVntFodfLbL4GufX8GV6jZ18oDDNIbENyEiAVaEbcVdiYT7CdTFAQeN4QsZrb8mYEMXrStmUjhfd0kGzepyuqxX00kOnSAmgUQmxgYaCMOJIVOfwF9Hd+icanE0yc8aiMJoGOxXWiyLrcSJVkZIewP/17D7lseM0wF/PXVHmf6VgR7Df6DclmhboDsVhXwvjAWm2cjD3zFeUrXzRpzDi60Q25KmADuU0roPplf3DkVcOUz99UGNMLH4INzSbxvJlmOtuhtE07uMJ7lUtkP1uNQ9PmKCCSv+aIE2DLxT4+ji8NcSQmdyd6HHPaw9vddtNZHHnveGMSLKCGfag2sluZFVSFatJpNOfrxfL3XHH3UWxMmccjwIBvmGQSE+mxX2jHJc9DTrm3TfYJW6twfYF/Ptvp/Tzp40XL8zCUb0DXI8ihhuChqNeqMZWcMnMJ5aePywbjrprkCxTFA8OhOoPeR4PvP6DpZkt4RLkcc3sM/9kVvG8dWkz603T2eShbWWIBf99yVlRV0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(39860400002)(346002)(16576012)(36756003)(8936002)(2906002)(83380400001)(38100700001)(86362001)(53546011)(16526019)(38350700001)(6486002)(52116002)(8676002)(478600001)(31696002)(31686004)(66476007)(66556008)(4326008)(316002)(5660300002)(66946007)(44832011)(2616005)(186003)(956004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WkZNZUVrcDlteDRpNDlQYys1bHpqbnVsRWxQaEtwdXoveVE1QnE5d083QW1x?=
 =?utf-8?B?bjBjUTlNc3pzbDIwMFF4cUFuMTdBQlNDSy9EaytrNDRFdGMvbmM3NHNjZS92?=
 =?utf-8?B?dktSOGREbGdoQnk1ZkUwaFlYdlRGVnRVRHNTRnY5MEcxU2VSK0srUjdNclcz?=
 =?utf-8?B?dlUyT3ZFSGtwSnNRbU1XRWNWTG9NaEhNVUhhb1hKM2RBT2dlNjVaOUQvNnpq?=
 =?utf-8?B?N1E4TUsxTkptY1VCWllkd0dTV2NMcGJjLzJlalFWRjVOdktoZFlxSkY2a3Vu?=
 =?utf-8?B?cDk0b3lleHNIMnVhRVVnZEJHc1ZuejBCbjRKU2YySjdaZUpUN1IxQWQxak5M?=
 =?utf-8?B?TU5mQ2Zxd0dBb3lvVjBpenQ2OXhvdEJHcndFV2E2QnFvZHhWS2xXTWxYWDFV?=
 =?utf-8?B?ZTVwSVZYL0NRODltSjJ1ZXNtalNVZVM5dmZ6UWRFUWFsU3Y3emNsdzEzV2hr?=
 =?utf-8?B?RmZub0hMb3ZFRWtRM2xGM0xNWllTQUNsZUtPRmF3bE5ZWHNxZEduT2JaS2tH?=
 =?utf-8?B?TU9oNEtQVTJMcE5DRFVXVUJjYWtwZHdRVUNSRmZNYUVNQXlzRzUzbFNGcVNN?=
 =?utf-8?B?WUxTa1VMNzVRazB1bUczVWFhRmpWNk9veTdZZ0xMQXkrd2oxY1JLVC9LNWtz?=
 =?utf-8?B?SlVsbG5KR1RQWlVob010QkZDci9na1JuOVFyRHhOUHRxRGtaUXBMV1VvQm1m?=
 =?utf-8?B?TlFDQUNqKzZuL3JZQXJjWmtNK1F2cmZmTFMyLzdNK3VjSWlHMTJhZGQzMVBJ?=
 =?utf-8?B?cmI1d3J6d2E5OTFwSDVyRmVwbGhTVFRDUHhhUGtjVEdvM25ZZTh1ZFRPZkNZ?=
 =?utf-8?B?UWk0NFFVOTdYVlF1alg2V2JJbUxpdy9HcHR0YUNaK2JFSFVrSkYxRXNQYWF3?=
 =?utf-8?B?U3VGWTVIZUNiMU9PdGNwSWJYVkVUS2JWVE91ZHR3UEZOMHJ0QjdDMmMzanl5?=
 =?utf-8?B?MUVudWtOVGpqUC8wMFIwOFFGRHkvVzE5VkpGUnBWcm5qUklYMnQrbHZYUGEx?=
 =?utf-8?B?QlVSMFp5UzBZODRlVlRTZ252VDFUckZUOVZ6ZE5QR3FqWUxMeEZvNEU0VkYy?=
 =?utf-8?B?eDd2VHY2cFlzUllOS2tHS3g2Yko3dkNEekJZVktsR292dUhPL0lGU1ZXMEF5?=
 =?utf-8?B?cjlKVmo0Y0wzWHozTVF4bWtqUWp4R1dhOTBMSC9Gdy82V3JmaTJQQ2p1WWt6?=
 =?utf-8?B?dXM1MHBXdy9mekFiSXczZERhL0E2bVJCN0wxeTVLT0wrbEZMZ045dndpVjFn?=
 =?utf-8?B?eUo3eWQ1cmJOWHduMU0rVFZxL3BSZU9ibXdTSWhGejdqUkh2czZTL0NzS3Y4?=
 =?utf-8?B?NmZYZVNxTkRKSVdFYWYrN2h1aGd3UmYyd0VNWEIyQnlFRFRLUEF3Zk84NHJs?=
 =?utf-8?B?TlVUYVNtSWs5TVRIdVlRZkFlWUxlbnNpZzBReDlXd1VRQWZjWkFQUjlxcU9T?=
 =?utf-8?B?QkxveDZpVGJPWElaRnJWZGU0RnQyODdTWUtEMXMwbFhteGxHQXB3OVYrclBK?=
 =?utf-8?B?UERPY3pQZjQxYXJwQ0Z2U0QvQlQvQVJOVUVOOEo0WEZTWTZqV2lPQ0ozdFJn?=
 =?utf-8?B?UkpYQnhtNldrWkgzVUpkNTUyK2VZL0dpdUVlc3ZXYUJvTCs4YTUvM0diWmhE?=
 =?utf-8?B?QStzZHhYMVZlQnAyMU1Ic1dJM1ZCdUhLZWc0ZEc4TGVXZlZNd3F1STc5Zm91?=
 =?utf-8?B?WkIzN2Y2Vk1RUzA4UU12Z1pYZEtPK1o5bkM3TGN0cWNvM1UxMDB2aVk0R0pn?=
 =?utf-8?Q?YE7uLC4K+qmuoneAms/tfhSkjJr43TO5z9+E3+v?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7ab38e-d4ae-45f6-b8cb-08d8fae128cc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 22:53:43.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJZCMfpIHsZSmxnRr6t67C+/rWkPRUtNCzO4cG6FrC30445qPOzg/Kc08DM7gHunfbmRvHRJW9uEVu8zmLnxhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4323
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080151
X-Proofpoint-GUID: u9gmM8Pud5fbb6O1ttgFtGRw-1uUP1DR
X-Proofpoint-ORIG-GUID: u9gmM8Pud5fbb6O1ttgFtGRw-1uUP1DR
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104080151
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/21 8:26 PM, Miaohe Lin wrote:
> On 2021/4/8 11:24, Miaohe Lin wrote:
>> On 2021/4/8 4:53, Mike Kravetz wrote:
>>> On 4/7/21 12:24 AM, Miaohe Lin wrote:
>>>> Hi:
>>>> On 2021/4/7 10:49, Mike Kravetz wrote:
>>>>> On 4/2/21 2:32 AM, Miaohe Lin wrote:
>>>>>> The resv_map could be NULL since this routine can be called in the evict
>>>>>> inode path for all hugetlbfs inodes. So we could have chg = 0 and this
>>>>>> would result in a negative value when chg - freed. This is unexpected for
>>>>>> hugepage_subpool_put_pages() and hugetlb_acct_memory().
>>>>>
>>>>> I am not sure if this is possible.
>>>>>
>>>>> It is true that resv_map could be NULL.  However, I believe resv map
>>>>> can only be NULL for inodes that are not regular or link inodes.  This
>>>>> is the inode creation code in hugetlbfs_get_inode().
>>>>>
>>>>>        /*
>>>>>          * Reserve maps are only needed for inodes that can have associated
>>>>>          * page allocations.
>>>>>          */
>>>>>         if (S_ISREG(mode) || S_ISLNK(mode)) {
>>>>>                 resv_map = resv_map_alloc();
>>>>>                 if (!resv_map)
>>>>>                         return NULL;
>>>>>         }
>>>>>
>>>>
>>>> Agree.
>>>>
>>>>> If resv_map is NULL, then no hugetlb pages can be allocated/associated
>>>>> with the file.  As a result, remove_inode_hugepages will never find any
>>>>> huge pages associated with the inode and the passed value 'freed' will
>>>>> always be zero.
>>>>>
>>>>
>>>> But I am confused now. AFAICS, remove_inode_hugepages() searches the address_space of
>>>> the inode to remove the hugepages while does not care if inode has associated resv_map.
>>>> How does it prevent hugetlb pages from being allocated/associated with the file if
>>>> resv_map is NULL? Could you please explain this more?
>>>>
>>>
>>> Recall that there are only two ways to get huge pages associated with
>>> a hugetlbfs file: fallocate and mmap/write fault.  Directly writing to
>>> hugetlbfs files is not supported.
>>>
>>> If you take a closer look at hugetlbfs_get_inode, it has that code to
>>> allocate the resv map mentioned above as well as the following:
>>>
>>> 		switch (mode & S_IFMT) {
>>> 		default:
>>> 			init_special_inode(inode, mode, dev);
>>> 			break;
>>> 		case S_IFREG:
>>> 			inode->i_op = &hugetlbfs_inode_operations;
>>> 			inode->i_fop = &hugetlbfs_file_operations;
>>> 			break;
>>> 		case S_IFDIR:
>>> 			inode->i_op = &hugetlbfs_dir_inode_operations;
>>> 			inode->i_fop = &simple_dir_operations;
>>>
>>> 			/* directory inodes start off with i_nlink == 2 (for "." entry) */
>>> 			inc_nlink(inode);
>>> 			break;
>>> 		case S_IFLNK:
>>> 			inode->i_op = &page_symlink_inode_operations;
>>> 			inode_nohighmem(inode);
>>> 			break;
>>> 		}
>>>
>>> Notice that only S_IFREG inodes will have i_fop == &hugetlbfs_file_operations.
>>> hugetlbfs_file_operations contain the hugetlbfs specific mmap and fallocate
>>> routines.  Hence, only files with S_IFREG inodes can potentially have
>>> associated huge pages.  S_IFLNK inodes can as well via file linking.
>>>
>>> If an inode is not S_ISREG(mode) || S_ISLNK(mode), then it will not have
>>> a resv_map.  In addition, it will not have hugetlbfs_file_operations and
>>> can not have associated huge pages.
>>>
>>
>> Many many thanks for detailed and patient explanation! :) I think I have got the idea!
>>
>>> I looked at this closely when adding commits
>>> 58b6e5e8f1ad hugetlbfs: fix memory leak for resv_map
>>> f27a5136f70a hugetlbfs: always use address space in inode for resv_map pointer
>>>
>>> I may not be remembering all of the details correctly.  Commit f27a5136f70a
>>> added the comment that resv_map could be NULL to hugetlb_unreserve_pages.
>>>
>>
>> Since we must have freed == 0 while chg == 0. Should we make this assumption explict
>> by something like below?
>>
>> WARN_ON(chg < freed);
>>
> 
> Or just a comment to avoid confusion ?
> 

Yes, add a comment to hugetlb_unreserve_pages saying that !resv_map
implies freed == 0.

It would also be helpful to check for (chg - freed) == 0 and skip the
calls to hugepage_subpool_put_pages() and hugetlb_acct_memory().  Both
of those routines may perform an unnecessary lock/unlock cycle in this
case.

A simple
	if (chg == free)
		return 0;
before the call to hugepage_subpool_put_pages would work.
-- 
Mike Kravetz
