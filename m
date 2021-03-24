Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCA7346E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 02:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbhCXBEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 21:04:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47544 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbhCXBEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:04:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12O111Jm094122;
        Wed, 24 Mar 2021 01:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DusIZ7MOyMBSHHvglBHjkPuke97odDGyoVt32sqW0hg=;
 b=Du/dgbX6ypYl6ta/aq4bz7rhiNlS0E1gxPDFBn9oHtOSX9hxBBhz9+T6QXazKnG5ikGe
 l4+mcC3DE9r8q2ATvtrIE4NtY6W2ZVasuzJhIYdCYbJOW8JLQL9hp4BmGcI0YLO+L8Gf
 CRQPcPs2cx7NCsYC3Yiy5JR1Dw0OZsoVmPapa+uZ7KP+tZN3EVAUBOUPvYSwuzADpNTa
 IePXuYRDTC4F7bihcAuxe0IbEyyCXGMYbAf977OuMV5xRx+k/YIYwBAKAW1nO6X6Dt6r
 e3PCecG348D3NhQsfI1iPs2wvE3ZfCayqsIDojv23ZMe8rx4DaN0Kqljyp0pnPXI1yBz QQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37d8fr93q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 01:03:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12O10lN3152859;
        Wed, 24 Mar 2021 01:03:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3030.oracle.com with ESMTP id 37dtyy6ct7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 01:03:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zk0jiQMJiqVmvmpu5PaSP9F2m6De8er1korLeA5SH33fGUNn2WfJPMFW5E3lTOxLsBgLmswuyJHb2bUUx8AMDTKSbc8XUREaQLn7az3euHqBsbTOlVnheaxlB16tFosrekCQm/SpVMWz8g4o1A433f5pkBu05G+ONzTBdeK0Q5PqtYSS7JKvkPEO5ipSeiEYbMnLHyew3ApRtpuOv+wJ7/xr8xrGFZejUxpDwsDsZCjIC6wQ3n7zOxq+nlS7wQLwldnZyhsYIE+LyzHZbpLucX6S56wBhLUKRWL6haecwekyWqAvmfqOumYlvnvj+Vpy7WD/G/UlRkJYeFBoUVJpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DusIZ7MOyMBSHHvglBHjkPuke97odDGyoVt32sqW0hg=;
 b=ehkY38c42aOA5xeiG8bj7c+WDhRxY5MUVZneRxPyscITwoj++5uZpMXDmWAjlYxxBPNk/2ZQ2QwG7LZv3dYKoLWkfo+dLcnfKSlOHAKCz9AQsBrdr5B/xJZZRmpoz/6xwqObpgSjaQXaD+1JuYQ0BFPHnn/NHWBDleV5FsM6iiLc6g4Sw/TkWW+zbe0NFF2JlMe6yl3RbwrHoPgAcgl3xjdJHKCyOdwJss/3r7vO6CcE+y7rVy/tnmpMlKsGXmYAcxvbcGjWdM14O6Rpo5udHnJZtDvq3ombFHp5iYSn7pZfK4SkLK2yHMJZwlWOMJdWbL8VpXexYtuvy88eBDI2IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DusIZ7MOyMBSHHvglBHjkPuke97odDGyoVt32sqW0hg=;
 b=ThNF8zSqAwk9ahJW+Jsb/KseWLWbQ38JzaBcUBdVFqGVCwNdjeJd9fXVtQHqwqHw3XH3jRUQ+mKjp5zdiWXZRAjraa/IViatolgXwpeF4Uwa14OujgM9niQjhiV0Tq/tv43G/7DFQUfGIefWU9UYLbvEx19yF2elc7y3ioCxZC4=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4590.namprd10.prod.outlook.com (2603:10b6:a03:2d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 01:03:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 01:03:10 +0000
Subject: Re: [RFC PATCH 5/8] hugetlb: change free_pool_huge_page to
 remove_pool_huge_page
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-6-mike.kravetz@oracle.com>
 <YFiqJSGjMMG3diWp@dhcp22.suse.cz>
 <fd723ea8-da7c-bd59-8d8a-e506be1b3af5@oracle.com>
 <YFmfegQjCKuY05jy@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d1fb9303-0053-947d-e714-c9414c456a08@oracle.com>
Date:   Tue, 23 Mar 2021 18:03:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YFmfegQjCKuY05jy@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0139.namprd04.prod.outlook.com
 (2603:10b6:303:84::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0139.namprd04.prod.outlook.com (2603:10b6:303:84::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Wed, 24 Mar 2021 01:03:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ea0c2f7-4894-446c-c168-08d8ee60979b
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4590:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4590E8563BA90A4E34178A0DE2639@SJ0PR10MB4590.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7vDR2yVb+uMsbHSqOY7VCbGwxD3WRsrJQMDytTwiVjmM4C9bMKOmQ1VeamTkIME3vCPkJmsI+ULf7AnjueqkUTz33WghMmDBaPGSX5WkgijRpJFKSyp66hp7kaJ/H7Iqv6P9TnSZsfwOZW0r3h2Ps/MronitG6v65Mb1lgZhUFM7Xwk9S26eb2inqwFoteIvZFzeQcXGysUsWhq8YeuGYfkzJi8iplmcPKXCyCvEsKkiFusSOiK8Gd02sLB3tbs6Ii0uPN4qhXp411T3ES43tta3fVYY030xL3qf8l1VSxI14ZAwbT6mZTWYw8RTZwwDJDbv69MNHKYR7NsRcPl5MwmX+sy/nqZMtEh2SwhU4nxuiyWSbfhD9h5RiE9cgnqdaobZjiXSUc1iOJRAmtzF+kaaT4ZjzftoKs8s5rFR+jlBt2OAuQyZmej11VWU9vwD/U7BTCkN/UX2CSTC4bPBR5Io0YSs9g1xqDdjQmOuQH45cVDo3P/uwcpxBDUMCmSMkK4GzitkWVlrjb3S3CsPbYqjooLTJaBS7mB/APYpLSLcZj33BQ9qKZuviOzD8VaOKfCe5JT6HUSxZO3sE30zLYo5ZDWFfZs7WarygcOS9LpdtMndAjCQnf++sfNbJtuqojtzmk1A9q1WkfnY3LnJJpqtTf1q632y3N9dw2joSc/lJsvQr57Kz8DtAB1ftz2vALerLGXmlO6aVqLv4x7SpJ47W5Lh2HUVW0D9q9VDPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(39860400002)(376002)(136003)(31696002)(16526019)(186003)(6916009)(54906003)(8936002)(31686004)(83380400001)(16576012)(53546011)(5660300002)(66476007)(26005)(66556008)(478600001)(316002)(36756003)(66946007)(52116002)(6486002)(7416002)(38100700001)(44832011)(956004)(8676002)(2906002)(86362001)(2616005)(4326008)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OU9iaFdpNWJmQnpOOUo3ZnY4ZGpEbWpZRU5sOEQ3N2VsSTZxb0c5Q3NuVHVz?=
 =?utf-8?B?NjZCL3VTdldsaEdROTFPeWpweWZuUjFQQWtsajBnaFFYR0FMeGMxbm5vbUR5?=
 =?utf-8?B?a3VKanZQbGtScWZITkV1eDJhUFRrUzkyT0paQWd6U01lenFEamJFY09tNVhW?=
 =?utf-8?B?NDYvY200b1lBSjBzaG5jUU1EYjJ0ZzFiVnVQRzJRQUJndW9tOVp2djRKYzhr?=
 =?utf-8?B?c0ZBV0x6WkZ2cUhJM0RjNFFTK2NnYlg2bW1mL2V0N2owb1VGbTZ2encyR25S?=
 =?utf-8?B?Ly8wS2JZSjlLd1pxT3F6VkhaM1lqRDRITW9BZGlsK3E3YTB4WS9XNkhaYS9Y?=
 =?utf-8?B?K0p0RnJOcDVFZTJ5VHdVTzB4VHhmZDcvNFNMMWJ6dm5qNy9rL0IyR2hyWjBU?=
 =?utf-8?B?THFWYW5FYTVqbXoxRjYyekpWQVNDVkhRYTJVeVZGdzA0M3hoVWJ5dWMwTzRJ?=
 =?utf-8?B?YzdTZ2l0c21oWWhmVWo1ZTNZZFZzR2grTVNjL1NNbUhPK0FhWklGRyt0Z1dU?=
 =?utf-8?B?ZVhWOElYaTZTNnJFUVFjZE01UU85alBLd0ZKWlhORUxCcFZlbnNzeUJmKzNU?=
 =?utf-8?B?WVdLWXdJR293YnRnNU1mWnlSZTNqcytvakd2bWJCRUZjcHlFMTg5WVhWcmNL?=
 =?utf-8?B?NkZvZ0VjeTJ2Z0VIWWZkWWo2VjRLalhYT3ZFRnJ4aEYzbFFzVU00dzBnZFBt?=
 =?utf-8?B?WEJIT21zS2tYVnIwdmtJVG80MytyZEc5eGhTVitRa095MkZCcUNDT1FZM2x0?=
 =?utf-8?B?L2VGY2VxWHFEeTNxbkRqK1JBR0cvR2hUYkZENHprby90V1VqS21QbnRtNStQ?=
 =?utf-8?B?ZTdndUxoYmhpY3EvZVdjRktWemRCSlFha0R6QlZDK0FBQVVuRXpXOEo0czVC?=
 =?utf-8?B?UTkzMUR5VFVERmtTMDFWTUtBY0dOTVlrOE5RYjlyY25URnFQWWdodFBLd0pR?=
 =?utf-8?B?N3crZTgzN0dTZVV2c3pvNWZvSFVjWFdRNzRFVTlnMmw4dmx0Q0hLTnJZbGpN?=
 =?utf-8?B?dEZRWkkyRHM0NCtyUDNtMnhMdGtTU0doNGJkeGIya2JUdWJvdHYrdFNZajVH?=
 =?utf-8?B?NWh0cHlVUVg0VDBnMjlEVmRhRmdQaG0rVVFGeHRHUi9LUnc1THB3dWc3Q3Ny?=
 =?utf-8?B?dldEWVNtOHRmakhpMnEyeklxZlJFd3VEUzBKS0NRQkhKVWVEYklXNzZaT2Zy?=
 =?utf-8?B?K3hxVXVVQnNyY25UeEhrUlZybmFWSG4wWUpJb2FPTmwyUjc5Njg3RWtrbmho?=
 =?utf-8?B?dGZwNkdvMis5aDd5cXBJaEozRlliM0xtS3dtdnE3aUhTR0RORHZsVTdPYWFC?=
 =?utf-8?B?cFozL0t0VzRUaG5acHdKU2FpYkZrRUtrTXM3RlRlMG9ka1B0cTVoalRMc3Iw?=
 =?utf-8?B?bWtwZzhwZlJtWkx5Ui8ybnlETEFHUW5iTHdwRDZVTzFaUHNNcDNZTlhQdDh2?=
 =?utf-8?B?TFU5dXQ3SHNlU1pDYWpUUGNaQXNzS3krN2lTRGtMc0lsV2xJQjdPL01KREQr?=
 =?utf-8?B?U3V0RHlpaE56dGRCbk9EeE1LVXNiODRhVEh6T2tQQkRCMm05UFlmSkkzaWps?=
 =?utf-8?B?cWtiRjZhblNMUlN0dTVaQWdqdm5DWkpueFVKMnNwSHVxSUJmRm1keDhQSHA3?=
 =?utf-8?B?Y2FsUnNtRXM1NVc0SHhvd1lpQ1Z5R2JVS0NULy85TGo3akpUQTNhS3hjWGd4?=
 =?utf-8?B?dE1nYmZScUVZL1ZJckdrNG1NN0tGenVWc1I2WFgzREFlNzI2N1NOekd3UEdZ?=
 =?utf-8?Q?Yr13a4svXS/paDRTVUnKNMBO/JmzrT8U3/b7vaL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea0c2f7-4894-446c-c168-08d8ee60979b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 01:03:10.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ia9TQZIZoo37QPPol8Ao4aHr4oFQ0aiqCxf3hG5M1AXOqZC2eDo5n9A8Yvlw70/TtB0Y19yXF+AJwF7qHLwhuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4590
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240004
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240004
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 12:57 AM, Michal Hocko wrote:
> On Mon 22-03-21 16:28:07, Mike Kravetz wrote:
>> On 3/22/21 7:31 AM, Michal Hocko wrote:
>>> On Fri 19-03-21 15:42:06, Mike Kravetz wrote:
>>> [...]
>>>> @@ -2090,9 +2084,15 @@ static void return_unused_surplus_pages(struct hstate *h,
>>>>  	while (nr_pages--) {
>>>>  		h->resv_huge_pages--;
>>>>  		unused_resv_pages--;
>>>> -		if (!free_pool_huge_page(h, &node_states[N_MEMORY], 1))
>>>> +		page = remove_pool_huge_page(h, &node_states[N_MEMORY], 1);
>>>> +		if (!page)
>>>>  			goto out;
>>>> -		cond_resched_lock(&hugetlb_lock);
>>>> +
>>>> +		/* Drop lock and free page to buddy as it could sleep */
>>>> +		spin_unlock(&hugetlb_lock);
>>>> +		update_and_free_page(h, page);
>>>> +		cond_resched();
>>>> +		spin_lock(&hugetlb_lock);
>>>>  	}
>>>>  
>>>>  out:
>>>
>>> This is likely a matter of taste but the repeated pattern of unlock,
>>> update_and_free_page, cond_resched and lock seems rather clumsy.
>>> Would it be slightly better/nicer to remove_pool_huge_page into a
>>> list_head under a single lock invocation and then free up the whole lot
>>> after the lock is dropped?
>>
>> Yes, we can certainly do that.
>> One downside I see is that the list can contain a bunch of pages not
>> accounted for in hugetlb and not free in buddy (or cma).  Ideally, we
>> would want to keep those in sync if possible.  Also, the commit that
>> added the cond_resched talked about freeing up 12 TB worth of huge pages
>> and it holding the lock for 150 seconds.  The new code is not holding
>> the lock while calling free to buddy, but I wonder how long it would
>> take to remove 12 TB worth of huge pages and add them to a separate list?
> 
> Well, the remove_pool_huge_page is just a accounting part and that
> should be pretty invisible even when the number of pages is large. The
> lockless nature (from hugetlb POV) of the final page release is the
> heavy weight operation and whether you do it in chunks or in a single go
> (with cond_resched) should be visible either. We already do the same
> thing when uncharging memcg pages (mem_cgroup_uncharge_list). 
> 
> So I would agree with you that this would be a much bigger problem if
> both the hugetlb and freeing path were equally heavy weight and the
> delay between first pages uncaccounted and freed would be noticeable.
> 
> But I do not want to push for this. I just hated the hugetlb_lock dances
> as this is ugly and repetitive pattern.

As you may have seen in my reply to patch 3, I am going to use this
batching approach for all places we do remove/free hugetlb page.

Since you brought up cgroups ... what is your opinion on lock hold time
in hugetlb_cgroup_css_offline?  We could potentially be calling
hugetlb_cgroup_move_parent for every hugetlb page while holding the lock
with interrupts disabled.
-- 
Mike Kravetz
