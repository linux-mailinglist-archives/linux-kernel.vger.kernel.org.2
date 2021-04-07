Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE44135616F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 04:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348118AbhDGCiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 22:38:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54076 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbhDGCiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 22:38:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1372TQWk122806;
        Wed, 7 Apr 2021 02:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=t01KNOxjnA3JPcI1NayTfsUirnctJe04OLBxBt8rEhA=;
 b=r9xhDZn38Qjnb0WM7imBewQjIVfwvCHsh8pNn4BPUzUh8WITIeIno81zD/MbWx7/9h7m
 chwLtsMqSgy5p94u5Jd9lNzQrNWWC88PTgqNLh+Ng/gnoTy9GTHCb+be8D77WBJfRUbI
 OmCsLrHp8f9e34MLBoRX820HOe4jMsetwOgR2XLbzvfW0GqWkDfo5B5chUp4CsCXNVk7
 LOQjOlmJQf7PhDmcsPQY5LNZzAqR2qXCnoxZF4Hqw3zlFrH0Qx/Ijo9ewcsorDqvJ/U2
 LG/2bgmnGmqZ/O222JKqxaWfNHB6gvBees6nFHMo2aB+fqna9SUEJU1ywo2Now0u3Qlv rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37rva60yce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 02:37:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1372Z3c9109780;
        Wed, 7 Apr 2021 02:37:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 37rvaxycjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 02:37:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTuf7BRGbPX8H5XO82+Tzr/A/3aZHl5y63bw20dJZ36l2eSmY4BTEIWsIXJSFvoKgRrU91kASYfpwz96IhhtLQ/riBmuy4PH7c/5WwW3jbpz3NlEHFwFWRQ3Nvc0I5fqWOmQ2b38DVROTJfhEcO1bvnRZElIVmfPxi30BsvTLsDoxocDo5YrD+stJY3EKLHZL2rANfIEy5r0Q1dNF2R/w+HFVTkiUzTNxWw9M6T1DrSntF47wBBSXwPjdC0FXqO+0gpk5vBiQXQ0J923CII1tTGA8rHi9MvuNdvexPeVvkvoQ5yxV95fu427fWy8Y4jsiR5WmkdzidtZbMy9wOCBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t01KNOxjnA3JPcI1NayTfsUirnctJe04OLBxBt8rEhA=;
 b=MYAT7pcHII9cnmZeranLytlI08CW0dNm5ONBRQOnadSAxf82Ngi6M9Nu6zi0egJb9gzyDv2jDk11Gvtd3qOoBpddBJkWXTEt6OmE16nalr2SLdnZZRiYcdrEEZdWB58U4isINR05hqLubI6rHZv026yFZDPs0o6rMpNhDrE5F7OORfrNV7ZE/WQXJ3Ut/mmBEtTDg3cesP5B7PHH0eccrTDuAwiF+vUrSO9qirSOQubjFS4RZ8zwUkv/h701eJDc/tLJTcs2rTny89aY0gvlQnh3mfk2aTQbka1Pze81oBK7k+ZMswz+hJwgjHq0c0vuVDmI119D3XTxhhwxQVFtsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t01KNOxjnA3JPcI1NayTfsUirnctJe04OLBxBt8rEhA=;
 b=xqd1bZOgZGmF/FbRXNF3cxIzsoLCveX7WLpqNhdBuApQQBXmuDVcNbBt2tkQpdd/78uuYK0NPZQpjBwlcgaW9fVHMZIcR+EQxaK1tKuUxiKi2DOBVqTmntOYZghKw+59ISI3ACkLWQK7X3AncskW+1APJMAfWib057oDloEui28=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3688.namprd10.prod.outlook.com (2603:10b6:a03:11a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 02:37:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 02:37:43 +0000
Subject: Re: [PATCH 2/4] mm/hugeltb: simplify the return code of
 __vma_reservation_common()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, hillf.zj@alibaba-inc.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210402093249.25137-1-linmiaohe@huawei.com>
 <20210402093249.25137-3-linmiaohe@huawei.com>
 <e958d731-67d4-a56b-aa1d-a8054cf232f2@oracle.com>
 <40114ff5-ba3d-ca66-3338-25db80a015da@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <aaea15d4-c8e0-ee37-8ceb-35326b7ad1ae@oracle.com>
Date:   Tue, 6 Apr 2021 19:37:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <40114ff5-ba3d-ca66-3338-25db80a015da@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR19CA0002.namprd19.prod.outlook.com
 (2603:10b6:300:d4::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR19CA0002.namprd19.prod.outlook.com (2603:10b6:300:d4::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Wed, 7 Apr 2021 02:37:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7427953-f3f9-42d7-17cc-08d8f96e1eed
X-MS-TrafficTypeDiagnostic: BYAPR10MB3688:
X-Microsoft-Antispam-PRVS: <BYAPR10MB368854A745383DD3DC7DCB74E2759@BYAPR10MB3688.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fw97mLaO49/WUi/b863QhuRZRh9GtXMogiXUEvEuzUd8mt1CSIHbd7+1LJGK8auktrwiODbQ/gzIq7LREIuZ3+bDyGB9emHSDweOUtbO5wDXcQBkY42p+GJjYhGN0bP5O8OZ2f5GzSVNSDwqSM9H8hbizvwI8Ks57GWJtVGsnrujnWn+H1VIqa1l57oDOKXhqFGaiiIXW6DTqeUXxKhFI8w2ErVlAYr0v6GGO0byyquTac88UFL5vz7KC/Axq4cmfstwWNI/GiCwapiuYSAOB2Ed+gYPWqn7em8NHMFrYu6ZKLXefEG66EwwIHdFQSN8yIakMNh8FBTp8ZCUD4ijO6GuCfzesVnHiki90JQXc3IFXQL9T7VbmJRV0ISsQNLoEcIeSIVVgVuyY1Og7FwFtcWTgH+8SVIhNsHkt743y6TF/G15jJedlHDTOTsddqyhlRD9h2yXQlZ7Ao8vpHnDM/GKkaB0qzNotzGVnWfkmt43o9odHGy1p3PbU65zW9aHHo7sMOFu9lN0TQGc8OCSCg1JMAzl4Px8w9YYK1YLVdASNOZegRRCUO+ktAmxsFYfhbSBhW4qQRJnAC8CaDfZVvppbOWLkPG8+7qNBJdrAbIT0fWiAbe/Ioj1vzuQ0Iy9YWX0WnpSkFNo+v8cc3awKRVIpmZPi1E9ne01NrJmv7pTNwGv1JYpb39lmBBXdOYuZaqn4hgCuPGYmeEQ2niNzqv+doPInHckllcqcRwb1FAiXPHcHE4Qp09xyyC01J4t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(2616005)(86362001)(31696002)(2906002)(956004)(83380400001)(38350700001)(16576012)(38100700001)(44832011)(5660300002)(26005)(8676002)(66556008)(66476007)(4326008)(66946007)(53546011)(478600001)(16526019)(52116002)(36756003)(316002)(31686004)(8936002)(186003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NjBJWGU2N3IyWjRoT200bk1CT2tuYWVrRFlRelZiSEJkSCtHY1lPdDM4NUJz?=
 =?utf-8?B?eEY3TFZZT0FEbDJaL0xnUXZUbzFNckMvakNsbUV5T1VONE9rNHd6ZmV6SVJl?=
 =?utf-8?B?VFlRWjUydkY0d1Z3U2tzTzdmYVZwYVA2Y3hXelhDMi9ZN1NqdTZvMmdOSVMw?=
 =?utf-8?B?Q2V6TUI2M0hDd1FTeG1idk92RGZLVXlKQXdTK29qQWlpTHNZcTZPTWtySVZ6?=
 =?utf-8?B?MDEzZ3Ayd3hGclEwMWtTamNRSThsdlFod3g0QTY0TlA1WVlYWHJSelczS00z?=
 =?utf-8?B?L2hBblpUeGF0Nm9RQk9GQlNWNXBQZkxBSmtOZk9GVzBqT1EwbmU0NUJySVJJ?=
 =?utf-8?B?TnB0NElId2MwRVVsQzNFK3lRZVhmUzFIaStBUjJUd3hzRjI1d1dKcEhxbnFB?=
 =?utf-8?B?M1ZmVm54c0tQSTB3bGhBN3A0RzlybjNFSmR4TXVmSyt3M1cvMU1vMEFKczBZ?=
 =?utf-8?B?SkE5UExSa280NGVkSFpGVVp6NEduK0NNc0dxaTZlUU44cFVoTmcrR2RJMGV3?=
 =?utf-8?B?TUg3RE54MkhYWFZMemUya1BRbnZUTE5qRStMNERQZmRncWs4L2drMVdDckVx?=
 =?utf-8?B?VElxRWUxS29taWcvVXpESXhDSThEbjNKcGFaZmdraTZqbnBGQ2hDY3grVzZx?=
 =?utf-8?B?UEpzUjJCY1FDT21DZXlSbGJkaTg0WEg5OG0vamN4Q2J0N1NoRExUUnhPc3NX?=
 =?utf-8?B?ejZUVWpDd2NxMmkvNTkzWTVvMDZTeW5Hc0FNQmRlSktGYmhVdVZSTXR1TDNl?=
 =?utf-8?B?T3hranFXaEJNR2xGRkw4QVJhMXdLeEJjNDZISVg3YjVvelZ3OUNwdmw1ZnB1?=
 =?utf-8?B?MERUcXZMdVRmaVAxY0o5VjFpOUN5cTkweDRReTcxY1BUN0pXU0QwanVsS2hZ?=
 =?utf-8?B?VlpYNnR6dU5HRCtqdjgwSFc1S3QxNGhvK01vYzYxWElSTE9ROWVidWZrSDZM?=
 =?utf-8?B?T0M5eHJYZVVCdTFXZzZ5ZWF4L1AwZm9FckEyWDZTbXdha05KWEYzYy9BT3ll?=
 =?utf-8?B?citNOTZKUUFJYjdJTllrbGg5cXY5eGVsMEtyUGN3RkpEUkxuZUxQSDdrd2RR?=
 =?utf-8?B?RmVFbXhwUVR4ZHBRZHdNbDB1QUNKTE4zckUreUtjRXpXMmVxQVQvMnhUSWd3?=
 =?utf-8?B?S1dLbWN6bGk0dFBSSjBLQ240VndOWk1EMkVsME9XUnlZcVlJYXpna2NqMkRC?=
 =?utf-8?B?aGZ3SmV1WWFpdWJKSTU5cWlTeURESXM1K2JpWk1Fa3o2YVFKdG8rRjBTZkhn?=
 =?utf-8?B?ZW5DWGlLazg2N0dQZnQ0MEN5MGxxZTVEUFdrKzkzMnp2WnZ3ZzN2VFR6NFpn?=
 =?utf-8?B?VHJITStyYXJEUERDVEd1ZGZxKy9nZDMvWE5BQmVNR1ZaL3k3dEZnaHFDUU9x?=
 =?utf-8?B?MlVPTEZBanZidW9OSFNvbXk0eGUwSGROQldBdGlTclc2d2NwR2Y4bmx4WlhH?=
 =?utf-8?B?Z2FIUHhVY2lhZEhoQVhhbG05dmpReFVwZENlZmpTbGlyR01uMXEvZHA5UGNU?=
 =?utf-8?B?SnRJNHRRc0J0ejUzZkUzZ05Bc2twM0Q0Q3V5b2RKN1Z5QitCeERVbEJvaXpR?=
 =?utf-8?B?ME1XaU1vV1hLbFBSc2hSVTBDL2UyNVNvRzRsYWQ2Y2RyYk1YK3liSnVXMUNK?=
 =?utf-8?B?R0ExV1hVdUJhUFdaa3RiMGgzT0plT3hoUWZHUGJ4SVZZNjB2U2hXeTY4R0dy?=
 =?utf-8?B?YkNuVjlCMmZrTWczdGFjM0YxQ2d5OEcvaHhlMitSYVdaazZ5MTlPWFNlMDRZ?=
 =?utf-8?Q?LILJ1LkG7cYgGueRxdWjAHwG2dxAA/zjRaXhW6M?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7427953-f3f9-42d7-17cc-08d8f96e1eed
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 02:37:43.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9pAIfSiRs6DMxHt15AEE8jLxeVN5oQyP7WCQ8RHzFTpwE2ygpgRzHfP171YAOmA3BRT0XNoFCG9ZkQI9IRY/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3688
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070018
X-Proofpoint-GUID: YRr9YeTlKnayfug-ymzDRe5I5vlnxqSN
X-Proofpoint-ORIG-GUID: YRr9YeTlKnayfug-ymzDRe5I5vlnxqSN
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070017
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 7:05 PM, Miaohe Lin wrote:
> Hi:
> On 2021/4/7 8:53, Mike Kravetz wrote:
>> On 4/2/21 2:32 AM, Miaohe Lin wrote:
>>> It's guaranteed that the vma is associated with a resv_map, i.e. either
>>> VM_MAYSHARE or HPAGE_RESV_OWNER, when the code reaches here or we would
>>> have returned via !resv check above. So ret must be less than 0 in the
>>> 'else' case. Simplify the return code to make this clear.
>>
>> I believe we still neeed that ternary operator in the return statement.
>> Why?
>>
>> There are two basic types of mappings to be concerned with:
>> shared and private.
>> For private mappings, a task can 'own' the mapping as indicated by
>> HPAGE_RESV_OWNER.  Or, it may not own the mapping.  The most common way
>> to create a non-owner private mapping is to have a task with a private
>> mapping fork.  The parent process will have HPAGE_RESV_OWNER set, the
>> child process will not.  The idea is that since the child has a COW copy
>> of the mapping it should not consume reservations made by the parent.
> 
> The child process will not have HPAGE_RESV_OWNER set because at fork time, we do:
> 		/*
> 		 * Clear hugetlb-related page reserves for children. This only
> 		 * affects MAP_PRIVATE mappings. Faults generated by the child
> 		 * are not guaranteed to succeed, even if read-only
> 		 */
> 		if (is_vm_hugetlb_page(tmp))
> 			reset_vma_resv_huge_pages(tmp);
> i.e. we have vma->vm_private_data = (void *)0; for child process and vma_resv_map() will
> return NULL in this case.
> Or am I missed something?
> 
>> Only the parent (HPAGE_RESV_OWNER) is allowed to consume the
>> reservations.
>> Hope that makens sense?
>>
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  mm/hugetlb.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index a03a50b7c410..b7864abded3d 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -2183,7 +2183,7 @@ static long __vma_reservation_common(struct hstate *h,
>>>  			return 1;
>>>  	}
>>>  	else
>>
>> This else also handles the case !HPAGE_RESV_OWNER.  In this case, we
> 
> IMO, for the case !HPAGE_RESV_OWNER, we won't reach here. What do you think?
> 

I think you are correct.

However, if this is true we should be able to simply the code even
further.  There is no need to check for HPAGE_RESV_OWNER because we know
it must be set.  Correct?  If so, the code could look something like:

	if (vma->vm_flags & VM_MAYSHARE)
		return ret;

	/* We know private mapping with HPAGE_RESV_OWNER */
	 * ...						 *
	 * Add that existing comment                     */

	if (ret > 0)
		return 0;
	if (ret == 0)
		return 1;
	return ret;

-- 
Mike Kravetz
