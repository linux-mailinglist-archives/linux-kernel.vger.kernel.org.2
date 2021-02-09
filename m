Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49634315BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhBJBAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:00:39 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50686 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbhBIWSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:18:01 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119IuPBE030979;
        Tue, 9 Feb 2021 18:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=21+3qsDe+ONWQ36GBK8Pq5ujLcYuUIhWUjZStadpRc4=;
 b=NgntU9wrU80OXD1ep2CksHNmwaj92RRh4iSufCN1kqcc+573u7HHlCycDuYWNbRJoP4r
 2535gEHpeGiTf7NXjBj8xSJam9ZATJ6UcHONQJPx7NDLeVCep0g21MQ3xg/hwF4ku4KH
 tTNymzRXjhSIkFmxnNicaUUzKxhmijEPlQUmiDp3KxuBT+mCyedPlZV6xFCB0WiLyEVu
 705RBP1h3oMTSS1IbUdNtm9eZeqHDov0rL05g63FwfFIIltXQVs3PMxq1OOVF45eaCuQ
 Yzhe3E8bMdvjOvOAdGwcIFHC43YtN8G6kREIPbC48mNpgK+txvTA3T+5Ud9zCnQA7QBy fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36hk2kgnjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 18:56:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119IieHj086252;
        Tue, 9 Feb 2021 18:56:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3020.oracle.com with ESMTP id 36j4vrrb98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 18:56:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVqAk6EmCyorzGUAUvGiDfSJI+TvVadn/3aXDBBILJKw9LKRwGUusttyZL3NZOiO4dS/e0RajpQnVGNjXMry9Uc6xSz8T3893fYVp1/u01XGvZ7wHTEB4Fgjvqmbbq73En5V/Pb1G8MGuLX7AEY5nIJkriEVLs3V5WLpkqDgVM6iUY7X0Gkb5qtIZkp1LsPlroKEzgk4nJK/yR7eskFbx5lRCsyeKOevGBsL6z5bCwic+Agr/dL/x1mFArX1XQeH7dG+VH/I5YxzH1aQ+mdxee/HWqNg4q9C4540WwMYKENfyb0byP/lnOALFf61m6Y9pD33GXoIHd4gneTJTSDTUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21+3qsDe+ONWQ36GBK8Pq5ujLcYuUIhWUjZStadpRc4=;
 b=M2Vk6uJh6bv8h3eO0rUkyOvaiqnzYAwntS7gTPEiWZCDbI5MMZGOzIfN/KjII61WOddxkNX2IbmodiZQ5HqxziSZNedliJE0SuDVyz2kBxXZnIcjSWlwPhvRVNNBo79k4i9VErGxYWD3LltV/LQ+kd1gKK4ZW7tAu8bi79DeAcBo5hOLsZnp/qk9zcQUT6UkZDcZ7HW1xwY0rH5MhDLZwkOKIn77WCD+xkAlL5xWflTH+sOsHsmKP2PwiarPw0FcYJZCo8qklX2FQLjlUOYll1EbU8wSBNJbA0EUz9K2vbJLyZ7+WGzzEotWT8uHi6Xj5n4NSUEyeWDyTfGUVVeBvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21+3qsDe+ONWQ36GBK8Pq5ujLcYuUIhWUjZStadpRc4=;
 b=VUXW8pwfXeXBn/gZiyBsocQA100BPpJtCSpGJhrvK7P0DOkEBEqmtx+YIPCRqEy30xEqQXbnPL61ZOhcqKrumrCtYHgLsxL5w8PyRZbm+9hLVUZHFnUPfOVHYRQX06W4HSTAbV5yb03zABpfvcyfqZUhkaTJjf1IPLlMsKT/dqQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4611.namprd10.prod.outlook.com (2603:10b6:303:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Tue, 9 Feb
 2021 18:56:22 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.027; Tue, 9 Feb 2021
 18:56:22 +0000
Subject: Re: [PATCH RFC] hugetlb_cgroup: fix unbalanced css_put for shared
 mappings
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     almasrymina@google.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210123093111.60785-1-linmiaohe@huawei.com>
 <32100d84-8a26-2f8f-303f-52182ce72f52@oracle.com>
 <1f683c18-6a22-b5a9-6352-2e7d956132bb@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <14ed5468-156f-6ac4-ba1e-283a88bab917@oracle.com>
Date:   Tue, 9 Feb 2021 10:56:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <1f683c18-6a22-b5a9-6352-2e7d956132bb@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:303:86::12) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0187.namprd04.prod.outlook.com (2603:10b6:303:86::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Tue, 9 Feb 2021 18:56:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c08a815-f6ff-47af-313a-08d8cd2c648c
X-MS-TrafficTypeDiagnostic: CO1PR10MB4611:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4611DEA2537EEC3CF49BB281E28E9@CO1PR10MB4611.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBRnUoyxbtV/SPoSpzndJcBdnZuooTOJ20aGLMifX0cyeOkTpK7lgR1xtt9Lt1zQOpXQbnxynfK+uUFDAiNw9tvOaTiFIAk9lEoCOi8yw9Z0EQoMWa2kAWhaKMbwjVCkG47urQLE8ZDwSa3Iyn/aHzCFmoNAwVV2wy6P+8CciIPkvwwQOLYFeQZYmw30lqOeAYt42Xlr0kMRb1ctJFJXnWnSQx5MM8j6tbzf2KJ2NjCTCjerGma94fNzrDzo22UvcK5M70CRrJzSJEb0ejIagfj9ZuEOPCyDZNgebRBCdLZMneopu2LNXIM9u9JRQc62sLGrtGxJuyleQDgxXF9zRUl3ecoTQZzrYdTfPUAildfGaFel1R1IxvclPebgOT1ULs/zZeNazZlP+6dPQTpLw8K7UPTWfJ3yo7tXO2gGP5PvUCHpct9pO0OPogzDfcCWPY4SOaKNMPnalhgj8K8J1r+tt89yovk/im/3/ePe0InCMNXJY6ekpuMKa0/WYPBkcQ+wBani7zhdqJDrS/BGvnu5c10Li1vr2bFS+Y/aKqSpOn1+Q73NgFpUw+zZkHAgPIT4WZE3s9oUqsPbqX7e0EJ/HwWFai64u91siPS0aGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(346002)(396003)(376002)(53546011)(16576012)(316002)(8676002)(2906002)(44832011)(956004)(36756003)(2616005)(5660300002)(83380400001)(26005)(6486002)(86362001)(4326008)(8936002)(66556008)(478600001)(31686004)(52116002)(66946007)(66476007)(31696002)(16526019)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bUFWUENmYTRvb3FUTHMxR0UvSzZmZGlRcEZwdGNxUG5WVkFWcFh5NFVTZis2?=
 =?utf-8?B?MEFRU291cW1aMnFrd0xFSlRSNU9UNkE4eEtSQkErcDFocllRUGFzUzlFWGUv?=
 =?utf-8?B?SFVnSWF4bklwWEUycjFjaHBsN2dkZTF4ZThjZGlrS04wbmJ3NzVpb1lqV1ov?=
 =?utf-8?B?cVFUYTl4K0h2ZTZLSE4yL3FjdnpubzFjNmpKS1dDYkdJakIraGdnVDJQU29I?=
 =?utf-8?B?aHlNd0FWL0RjUVhRcHRyRmFDcnNCT1ZWSXhaVDByZldmOXJZN05IdlVtQ21B?=
 =?utf-8?B?RG9ZbS9KcDNWY2ZPbVh1ejd1aEdyeGdLb1hxQjY4YWVOdlRmREVOaTFQUWlY?=
 =?utf-8?B?azJLYUdRbGFjRUZFdjBVZjNibnFXYkthbGthLzVFek1VaXpMZWlOa2JRbngz?=
 =?utf-8?B?R2dhR2sycU15ZVd0NVNJMUk4SFc1YlJVYnVxYzl0MXBzbitqZVY2YmZSRVg4?=
 =?utf-8?B?SER5VDZNV2g0cEk0UkUrWVhRanViczBFWGI5dVRtcDVocGtDZVBZTXMyNlBj?=
 =?utf-8?B?cE1FdG1XUkFxMkkyK3FWSEdad1NmWmk4NVN1cGp0RlZjOC9rT3k0WWE3Y1Zr?=
 =?utf-8?B?eDYrNHFna2hmNC8xWGw5R1RTY013T0hmMWErT1E3ZVAzOFlCUzQxU21aTXdL?=
 =?utf-8?B?V24vR2FrRHJTZ1lDbVVCWTVFSkhreVdIaHVwVXNWanc2RkhCN0V6OWkxWDhx?=
 =?utf-8?B?dmhNS3Q2cVFpNjhlNkZOK2laUDdXcUlPdUlPb3dkSlVlOG9XMlowdzRwOHgv?=
 =?utf-8?B?bkhGSEZSeTdTYnVOYmFDMDZDZFNUT09ZM243TnVoVWJKdlZRNERiVWU5cUM2?=
 =?utf-8?B?Yy94VlE4NlRzT2RsZXowNnQzTWlyRTZKNmV3aTZlSzdGeitmUFhUc2I1VmY3?=
 =?utf-8?B?MmIxWjNvQ0l1OFFoTWFkSHlzSVorbCtIb3pzV01NNjIzakltd2U5OW9SL2xS?=
 =?utf-8?B?YUhnSnRaZWMvUUplZDB3eTBEci8vQ1NwOU9nenUwcnpSdVdaUlFYLzEvOUJo?=
 =?utf-8?B?S2tLb3AvVVJ4bTFrNW5lUU16SFBBcEZhWjFNMGthWERCVUs4UzZnQ3h2aVU5?=
 =?utf-8?B?elhKYWJvRnZEbGNUL0sxQmxIaEU4RHlhOE1ya1pZeHRMKzNQYnk5U25JTHE4?=
 =?utf-8?B?bzE5M3BsMTB5b3BRTFZPd2hFNUVBUXpidFZ5STNhekdMKyt6VTl1MGR3SVdK?=
 =?utf-8?B?REt1TE14cU1JcEtYZmZDeFhkNHlEQUxhS2pXWWF3RGNmT1ByZUdOUURWSUFR?=
 =?utf-8?B?L3lnaHNMUHFJbEd5R2dkTGpId0NsUElpZTNpYVJPSThZTUpuTVY0anN6djFP?=
 =?utf-8?B?RXhFYkEzZXFFTzFJcjNOYUg0alQyTTN4YkMwdnplMGVLMmJUOU5SMjQ3ZlpL?=
 =?utf-8?B?NXIzeUloYUxsbjRSSXFZK1M2UndsU1EzbEhUS210L0xmclVCZTdYUlZ0akgz?=
 =?utf-8?B?Mnd1cThNaVZtYW1sNXZEa1g5a0R4S3RyQW9QQjNMT3VoeGdFTUptYzRlc3BK?=
 =?utf-8?B?SHFGVjJxdGdLeFMyQ1Z2TGVkQXEvTjlEWFlKOXhNcUxHZEp5UFhWb2VNNllF?=
 =?utf-8?B?WStYcHZIQ0NVMXZKKytyU2hyWnJyWXVmcm4xZVhGMEppQ0xwM0xrZVo4aVVS?=
 =?utf-8?B?MjBtUVQ0SGJ6Vy9pMlJKdDVXakRoR3pXTGkwVWZvVE4vMk9ZZG1wMEFMaW5i?=
 =?utf-8?B?RU9VdVF5Y0YyaGhiYzY0ek1FUHpENmltbDIvSHFoNWFvSjdHK09rRjM2WGo0?=
 =?utf-8?Q?slRCHX/W6Ox9m4jMS2zdYzGUys5vvp/vTdcJ0sa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c08a815-f6ff-47af-313a-08d8cd2c648c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 18:56:22.5238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPK66i0aPgQEep+UZ4OpxoIucuJIJT83HLD8PCdXHOtiJzUkc1ADU6tYY/26bp2VMkYkQa/emoP50CI+RzlGOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4611
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090089
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 7:27 PM, Miaohe Lin wrote:
> On 2021/2/9 3:52, Mike Kravetz wrote:
>> On 1/23/21 1:31 AM, Miaohe Lin wrote:
>>> The current implementation of hugetlb_cgroup for shared mappings could have
>>> different behavior. Consider the following two scenarios:
>>>
>>> 1.Assume initial css reference count of hugetlb_cgroup is 1:
>>>   1.1 Call hugetlb_reserve_pages with from = 1, to = 2. So css reference
>>> count is 2 associated with 1 file_region.
>>>   1.2 Call hugetlb_reserve_pages with from = 2, to = 3. So css reference
>>> count is 3 associated with 2 file_region.
>>>   1.3 coalesce_file_region will coalesce these two file_regions into one.
>>> So css reference count is 3 associated with 1 file_region now.
>>>
>>> 2.Assume initial css reference count of hugetlb_cgroup is 1 again:
>>>   2.1 Call hugetlb_reserve_pages with from = 1, to = 3. So css reference
>>> count is 2 associated with 1 file_region.
>>>
>>> Therefore, we might have one file_region while holding one or more css
>>> reference counts. This inconsistency could lead to unbalanced css_put().
>>> If we do css_put one by one (i.g. hole punch case), scenario 2 would put
>>> one more css reference. If we do css_put all together (i.g. truncate case),
>>> scenario 1 will leak one css reference.
>>
>> Sorry for the delay in replying.  This is tricky code and I needed some quiet
>> time to study it.
>>
> 
> That's fine. I was trying to catch more buggy case too.
> 
>> I agree that the issue described exists.  Can you describe what a user would
>> see in the above imbalance scenarios?  What happens if we do one too many
>> css_put calls?  What happens if we leak the reference and do not do the
>> required number of css_puts?
>>
> 
> The imbalanced css_get/css_put would result in a non-zero reference when we try to
> destroy the hugetlb cgroup. The hugetlb cgroup dir is removed __but__ associated
> resource is not freed. This might result in OOM or can not create a new hugetlb cgroup
> in a really busy workload finally.
> 
>> The code changes look correct.
>>
>> I just wish this code was not so complicated.  I think the private mapping
>> case could be simplified to only take a single css_ref per reserve map.
> 
> Could you explain this more?
> It seems one reserve map already takes a single css_ref. And a hugepage outside
> reservation would take a single css_ref too.

Let me preface this by saying that my cgroup knowledge is limited.
For private mappings, all reservations will be associated with the same cgroup.
This is because, only one process can access the mapping.  Since there is only
one process, we only need to hold one css reference.  Individual counters can
be incremented as needed without increasing the css reference count.  We
take a reference when the reserv map is created and drop the reference when it
is deleted.

This does not work for shared mappings as you can have multiple processes in
multiple cgroups taking reservations on the same file.  This is why you need
per-reservation reference accounting in this case.

-- 
Mike Kravetz

> 
>> However, for shared mappings we need to track each individual reservation
>> which adds the complexity.  I can not think of a better way to do things.
>>
> 
> I can't figure out one too. And the fix might make the code more complex. :(
> 
>> Please update commit message with an explanation of what users might see
>> because of this issue and resubmit as a patch.
>>
> 
> Will do. Thanks.
> 
>> Thanks,
>>
> 
> Many thanks for reply. :)
> 
