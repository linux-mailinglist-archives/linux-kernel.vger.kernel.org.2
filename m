Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80323722FE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 00:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhECW3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 18:29:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59918 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECW3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 18:29:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143LxQlr178660;
        Mon, 3 May 2021 22:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MHvR5dleFNibHInsuuOM9iQ1g3ihpsiDfg+HMzEzaPk=;
 b=lV5lK0Ypu/pG4DV2jIXhsCUSnACPFQkQg0r+4O8zU5YK5tiogjyC+jB52YwivtbDXv9J
 BNdNMdFyFRfd7tzbNtn9NvLcJmeXvxKObCGdkiL74lRs5PWhf5YI61CsyKt7ZrvmKihX
 ktAMpbfkgwCm0/MSy8ewNRe482HieanZIjnqKhiypk33QLGA86VuyMJ/hp/WyTkCj9QX
 Iz8ZAbjVeBOQNcq/o4UrlEJUDTK6hU4rzLChL9MOElJ7Ohqp5F4DfLueIKdJBo98B+O8
 An1FXCpnNMWF4NJsTmy9sDP2NMM6lhKSfHtJUrcBUSiq1EDVodnL32CNnbVfLqZOfl6d zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 388vgbn9c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 22:28:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143M0FHX126492;
        Mon, 3 May 2021 22:28:05 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by aserp3020.oracle.com with ESMTP id 388xt32j1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 22:28:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdaU8bGsC+xx//3+rs1yoeWqgFRgreE1NNVAf1Evn3ZtdOF69fHHcuJSs6zK1vhZxHVB9YjlU+vRqvy63gZ91KBrz2k+2cZKuZxGQonNXF9vWOLMF//uAvI0klfbVaVIAM8kybErfPvYXHSEU++wLdIqrLFUqaFvCGhAXQuablQojJoN1o93Y7klN0TKXMzxluIOZDXI7Eidlz8ya0ZaqT2yLQFY4SiD7ynTbKTsQxFlsOp1c0QjvL4xUxvbxgAMa+D1SyojHdtRwkFu8XNHRIXAaUrjw9wltRA9Cd9NvgxqZvHNZ7sS2qY5BtvHMC93p/idy/HfwQHG10CvgTdjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHvR5dleFNibHInsuuOM9iQ1g3ihpsiDfg+HMzEzaPk=;
 b=VpR6N1CKsbdK5CmHGQEujkcMPqiqSaCnPp3EXFRu0Ufakh7DmFwrfDC/SaEoMsOO9Y7pZV4nVubz7P7C5toelW7j1/i2GzItzuSswolU6ThJcxwlC7L1o8LrghdVgnbYu34D0QhwFiTrKsz5RgIffhjI7NzMgPUWzbncgjMlb3IXHOa3bYkxNwidLAeataAwf5Nd/JFsTZRM5K4wxbguPFXzjTeR7bOcHb558hMfPd8p0cXVsqzdUxMGg14gLQtxs4VKZCPxmvcaxxHru0KikOY7d6JK/OuH9zJAo1W+IrKDLI1/3zRB97UZm2LMub2jJDYMH256gKXNwJJQByG+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHvR5dleFNibHInsuuOM9iQ1g3ihpsiDfg+HMzEzaPk=;
 b=FL6/rBlVRGWG1+0RuFiyiDStz0piSJc3jQ4P2TwSgut5z+cq/50qiZ0SC68rlTWFNUnyKaxrkcNDAaVHdYT0B9h505550bWaa7H4APi4EJsAKrm8cqgm6RE8SGHmoxRyINHTH97zvUd6nIne8O30summ4QlKlZef3LR3Qt1EpeU=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2504.namprd10.prod.outlook.com (2603:10b6:a02:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Mon, 3 May
 2021 22:28:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 22:28:03 +0000
Subject: Re: [PATCH 1/2] mm/hugetlb: Fix F_SEAL_FUTURE_WRITE
To:     Peter Xu <peterx@redhat.com>, Mike Kravetz <mjk.linux@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
References: <20210501144110.8784-1-peterx@redhat.com>
 <20210501144110.8784-2-peterx@redhat.com>
 <be33c24e-cf2d-3894-a450-7432fd976802@gmail.com> <YJBro5N+1SHkx8D3@t490s>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d6c600cf-4eec-49c2-7b57-41f1743a3b0e@oracle.com>
Date:   Mon, 3 May 2021 15:28:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YJBro5N+1SHkx8D3@t490s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:303:83::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0101.namprd04.prod.outlook.com (2603:10b6:303:83::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Mon, 3 May 2021 22:28:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 384e0341-a92b-49a2-46ea-08d90e82b777
X-MS-TrafficTypeDiagnostic: BYAPR10MB2504:
X-Microsoft-Antispam-PRVS: <BYAPR10MB250488528D45A07986C06FFEE25B9@BYAPR10MB2504.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Si/L8SvfrvZaZlDf++ua8dt3IWYtUM8aiEs/zuJDqKfbr8TNLyj9JtjopkmQZ0TSk7rZyqFoH/mHHLKMQfOzmwkeMc1UMqV/HHeGuTLZr8NzNLhh1mG5UwzXmx8bzKKV1TAGb/t++Ect75b4grJuNl6rI8ago08OUn9O3yFOH9gMFOl6UoLO7x4p2ontuqyJ1Dtt2iCwyXgPU3icXbpIGZW76aJ4qhUWLIlInqGh2JiEORxGIdQXLpob/JJNHyF+diuge7+/DtFl2Euv/L5rRjkSePdE2kXMsc2PfckQVT9t4y2uascgKY4tMWf+H318SZBgDuk12SXxKIaoV64KqGp77Wqd+7lfnR04TtExGFSP7Sn3x7EQ3XYxNattNGYYSH/heEhvJ7Oa1TvM9sWGZRDabOiSEwxmLC6RdLNk0hiUYGmtrsP97kdlaiZuyv8izoRdCpIqXGwNHPx7SZgmvLwZr0Ae3jd/GrY6ZLCD0S5EbIu6J2cPG045eh+KzZKgg/ssXEsp6O282FP8xz4L3GJCMk/wxOcwmVWvVGTutbJjWjXWYAHx7eMzOsxEdLy4Pq1GXMoT5FFTTWvKO2W5LGx/IlXuRIhJ6bVDNzPqMfyTB1/4gZEoHcYbt5mEZnB5eME30yV5AJ/+OYaA64IPxt+ePpv8CtT4ajT3puAmjiugbSJOxyhz9HOL78mXzxWCAs1a3ZCht1ERqD7+512LOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(376002)(366004)(346002)(66476007)(54906003)(2906002)(36756003)(31686004)(31696002)(478600001)(86362001)(186003)(4326008)(316002)(44832011)(38350700002)(6486002)(5660300002)(110136005)(16576012)(16526019)(38100700002)(8676002)(66946007)(26005)(53546011)(8936002)(66556008)(52116002)(83380400001)(956004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TDFnczdRSGU3Zlp1MUZqelMxN3VuakpKbjRtUFI2VkZHWnBjbWkyallmWXND?=
 =?utf-8?B?MVdZMktqdHZDN1BEWHhoOVRTL0xRMDZOUENXWFVNeEFwZzJZTHpMOTg3MzQ0?=
 =?utf-8?B?N1p4NkFLL3l4TWx1RUVybGxRMk5HdFNXeUJrUEZESHREZUZOU3VVUFp2V1kx?=
 =?utf-8?B?aU1WY0pjMTVxYVdyeVRVM1VrTGZzclZYUTVzMHV0TlN2QVUzWVZ1NnlYRGtU?=
 =?utf-8?B?NWVDelVWR0JLVlN3azlmc09xVHNub0VrWWh0YW5qSk8zendKbWl0Y3BxM1BJ?=
 =?utf-8?B?WEk5MEFnNjlOelN5WjNzSTJWOVN4YWxiK1JWTkFjdWdTV2dJNlA2OWJWWlRu?=
 =?utf-8?B?TXk3NVZsWnJUcTZHYVliUnlTWUN2eVBDa2p6eG1uckFHMklRM1JPWjFWSU42?=
 =?utf-8?B?MU9SVkdjbXA4TFRvV0FjbmhtdjRqYk1pV3N3ZURPaDdoc05oZ3FwQXpEaUpq?=
 =?utf-8?B?OWx0NVl5ektCZHlUZnhON0JBbDhnbnpsUkt2dnM1aUVoT0pGNllDWURQWTQr?=
 =?utf-8?B?clZROEE4ME0rT2NrVkZ1VVEwVnFZcGk5UzM4ejFITkRlUmFhNHUrQjQ0bklp?=
 =?utf-8?B?Y3dVYWQycHN0cUxrelEwVWdPdDFSVytXMXV5eGplaGFaK3k2VlBId1hvS1c1?=
 =?utf-8?B?TkVRMjRSMnVadzhTaG1zaW10K3NwelhQUWkvUXVnMURSNjNXRUpzTGxDZnJK?=
 =?utf-8?B?T01uUENRTXU3Qm9hVzdxSVF4bHhJMmhkdnNMTEIrbHJSMTkwZ3VVVzFGR3Fu?=
 =?utf-8?B?dDFXUkREdnR6S0lQSisyd1M4aHJkQnBkdWpVQ3dWYVRXUjBzdUxUeXlrUmxE?=
 =?utf-8?B?NFE1dEhBc2o3SGFvVUI5TzRYWHdnd3NwZHBBY1pUdjJlUWdGNThyRXBCUXBv?=
 =?utf-8?B?YTRrTCtmVlQ2Wm9QZThkRFpPNFdualRsMzRVdDd6QmR6Sy84M3pKMWVESldB?=
 =?utf-8?B?Q1piNHg3RVhuaUErVjY5Z0ZFQjRJYzBGdHVTUnJCUVVFNXBYclRoU08reUx1?=
 =?utf-8?B?RTZITkh0U0lOUS9iRTNVaWx1WjBFK2Q4YUFrdXlLZ0dOems3Q1loVHlTRnBv?=
 =?utf-8?B?czVSRk5WYkd6TVlrRWZGOC9lYlh1bVk5YWdlRVhCb2NxNWVpMjlqL0dUdjhi?=
 =?utf-8?B?NmlqeU5OeXR0dVlGTW5ieHJpN3J3UjVza1ZuMTZ4TGx0L3ZLQ1hCcGRadFBo?=
 =?utf-8?B?YW5JaDRJcnhHUkhsSVlQZG5yajQ3bkZRTFltZ0dFYWl1TUllRzhNSSszUUNj?=
 =?utf-8?B?dktoWUI4NUxnNlp2ZjNTcGN3Z3NSalBrMU1KL3B0b083YkVWc1FmckFrMy9U?=
 =?utf-8?B?Wm5LbW9yU3BnMHpYZTBBS0F5SkZhQXRiWElKeG10dTUyVGJ3WWNxNDJFYXE3?=
 =?utf-8?B?eEE2RjN6cUhkTHJYdFV5MWNLYXNiclhmYjdjd2svVGVtOEl6aDZ4Y2xNN0NQ?=
 =?utf-8?B?TXZCWkFFbmF2dE5uaXhZMWlSUGdaOUNBS1hsdnNxTU40TEVXRk5MdzZpZjVL?=
 =?utf-8?B?UXZ4dDhOdDFUYi9uVmxra0JqMjFhaVRNRFVEajVNNm1iNXNZM1UyYXpjbnp6?=
 =?utf-8?B?eStwMkZNalN0WTNRN3hhaXlXQU9aaHhubXhNTWZWbXJKcVUvbjM5MklyaHdR?=
 =?utf-8?B?Z3ZMUXA3dkQ2YWNjeUQ0L2J4WFFLTmZKWHVObDNxdVlvbUNlajA4TGdRQ3pI?=
 =?utf-8?B?ZTBibzBDWlFFaC9FaGVLVUZFZzVsRDUyM0hnS2Jsd3EybWpEeG0vRmx0WHNT?=
 =?utf-8?Q?XXGMHSIxowIw/SpDr1IRzZZZvhkkHmE0tIxS9dH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384e0341-a92b-49a2-46ea-08d90e82b777
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 22:28:03.6907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PvWhDY1T4CvRfKrr+LNcO+PKVoSsodpaP/XX+oOTIII5HD9zOc+AEiA0MVPAE6Q2w7PirBcmw1yt4QDdG+1YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2504
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030150
X-Proofpoint-GUID: AQsS0tmaaGh7YnK3QDEqahurK0bYbXCq
X-Proofpoint-ORIG-GUID: AQsS0tmaaGh7YnK3QDEqahurK0bYbXCq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/21 2:31 PM, Peter Xu wrote:
> Mike,
> 
> On Mon, May 03, 2021 at 11:55:41AM -0700, Mike Kravetz wrote:
>> On 5/1/21 7:41 AM, Peter Xu wrote:
>>> F_SEAL_FUTURE_WRITE is missing for hugetlb starting from the first day.
>>> There is a test program for that and it fails constantly.
>>>
>>> $ ./memfd_test hugetlbfs
>>> memfd-hugetlb: CREATE
>>> memfd-hugetlb: BASIC
>>> memfd-hugetlb: SEAL-WRITE
>>> memfd-hugetlb: SEAL-FUTURE-WRITE
>>> mmap() didn't fail as expected
>>> Aborted (core dumped)
>>>
>>> I think it's probably because no one is really running the hugetlbfs test.
>>>
>>> Fix it by checking FUTURE_WRITE also in hugetlbfs_file_mmap() as what we do in
>>> shmem_mmap().  Generalize a helper for that.
>>>
>>> Reported-by: Hugh Dickins <hughd@google.com>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>  fs/hugetlbfs/inode.c |  5 +++++
>>>  include/linux/mm.h   | 32 ++++++++++++++++++++++++++++++++
>>>  mm/shmem.c           | 22 ++++------------------
>>>  3 files changed, 41 insertions(+), 18 deletions(-)
>>
>> Thanks Peter and Hugh!
>>
>> One question below,
>>
>>>
>>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>>> index a2a42335e8fd2..39922c0f2fc8c 100644
>>> --- a/fs/hugetlbfs/inode.c
>>> +++ b/fs/hugetlbfs/inode.c
>>> @@ -131,10 +131,15 @@ static void huge_pagevec_release(struct pagevec *pvec)
>>>  static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>>>  {
>>>  	struct inode *inode = file_inode(file);
>>> +	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
>>>  	loff_t len, vma_len;
>>>  	int ret;
>>>  	struct hstate *h = hstate_file(file);
>>>  
>>> +	ret = seal_check_future_write(info->seals, vma);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>>  	/*
>>>  	 * vma address alignment (but not the pgoff alignment) has
>>>  	 * already been checked by prepare_hugepage_range.  If you add
>>
>> The full comment below the code you added is:
>>
>> 	/*
>> 	 * vma address alignment (but not the pgoff alignment) has
>> 	 * already been checked by prepare_hugepage_range.  If you add
>> 	 * any error returns here, do so after setting VM_HUGETLB, so
>> 	 * is_vm_hugetlb_page tests below unmap_region go the right
>> 	 * way when do_mmap unwinds (may be important on powerpc
>> 	 * and ia64).
>> 	 */
>>
>> This comment was added in commit 68589bc35303 by Hugh, although it
>> appears David Gibson added the reason for the comment in the commit
>> message:
>>
>> "If hugetlbfs_file_mmap() returns a failure to do_mmap_pgoff() - for example,
>> because the given file offset is not hugepage aligned - then do_mmap_pgoff
>> will go to the unmap_and_free_vma backout path.
>>
>> But at this stage the vma hasn't been marked as hugepage, and the backout path
>> will call unmap_region() on it.  That will eventually call down to the
>> non-hugepage version of unmap_page_range().  On ppc64, at least, that will
>> cause serious problems if there are any existing hugepage pagetable entries in
>> the vicinity - for example if there are any other hugepage mappings under the
>> same PUD.  unmap_page_range() will trigger a bad_pud() on the hugepage pud
>> entries.  I suspect this will also cause bad problems on ia64, though I don't
>> have a machine to test it on."
>>
>> There are still comments in the unmap code about special handling of
>> ppc64 PUDs.  So, this may still be an issue.
>>
>> I am trying to dig into the code to determine if this is still and
>> issue.  Just curious if you looked into this?  Might be simpler and
>> safer to just put the seal check after setting the VM_HUGETLB flag?
> 
> Good catch!  I overlooked on that, and I definitely didn't look into it yet.
> For now I'd better move that check to be after the flag settings in all cases.
> 
> I'll also add:
> 
> Fixes: ab3948f58ff84 ("mm/memfd: add an F_SEAL_FUTURE_WRITE seal to memfd")
> 

Thanks!  With those changes, you can add,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
