Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F4532D883
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhCDRV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:21:57 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45426 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhCDRVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:21:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 124HJCRP085894;
        Thu, 4 Mar 2021 17:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ffqqE+LJPhziFElTdMfz0SV2Hbozf0gVlcWQBG6zAtc=;
 b=QfJNaNusqyiQBGw/xBs23588hsszVRf8yIhFd8EM0NokUGj3cZJ1xB3XJ5PMEqgu48zX
 FUyE5HbS3IVhdwE5H6U4qyjsED+1Z/+mkWmwsDjnMceXPnnbD0Kwmxo+KxMr3dtkLCjt
 4Wkr5ZuZlfmjeE/GpdNepQijKar5LCi0HwiPc7u0jsbFYzCaGCJ3bzzELSaTwEfh0lwK
 FuPnjP3/DU9wvNccPzRIjtPYaFUDjC7GRckBbk/ifBIiZnkBydm3xT3Ym3PS7jMWUzUC
 pslt51SRuy7mro4SpiVoxT5UHtcD+NPSx8kHNIzehNdBQ/+hy9pE4GnUZl6VrX4s5bnx xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36yeqn7stv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Mar 2021 17:20:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 124HB92L031144;
        Thu, 4 Mar 2021 17:20:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3020.oracle.com with ESMTP id 370002wcyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Mar 2021 17:20:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brcTCjtG6M7o2rICHCR55kp1sDpwkSXR30Nk7tnMjdxHsDpz+vDHHF7BfPAg+PvF2db0hJUuFNpiscYQyvxDxyvggje333NZhfAcNM6pjiuLfgi9twZ8MGrm4SCfZtJN7jQoADhrKZwhbqvXw7LtJa2158ivzfNcxBXwZpnsj+ZGnuqknfaYpuVD1MrcxiKm8iW5lLcSGmbXDARUXUTdqvRIQsfqkKOs1HboQYnRch07KOFUOC8PXbWy5GvNjuuuRy9o/gUAvmP9AEkEj3UzxboXCrAsqQ/DTdb4iutB4B+HYn553dGfQjfmpoyC3GGvf0paRcjTy/RM1UJB1Y8dDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffqqE+LJPhziFElTdMfz0SV2Hbozf0gVlcWQBG6zAtc=;
 b=GqGjQX1m+F4t4Izjxswc0LNPQotkLG2L181ifb+fTOAnKqkCDXwRbNN+u8iyWqDnxPj3bXJhSn3japAyQotgCx5OqGipLvF8NQoaJnA9g4uLasTD+NLh0TnZzPGFS35bbZHBf8Fru+/bkOa+CpCG/p70MHu4ZiqU+QIA9ec3MdRIJzIXwjGYVsVc2l7WDnL/bmVamvPMmcm9HDLPOzhw50ON1tm8dpCezXcZcX3Bd9WfCBvY8+eCEwZt/weR/NzLIDaKo5emzo/QIc/aU+zfdEahO85Mb8kLMl7riFGtr8xWZk/VCN/qIlIeTnyQFtKneGTRTfZC9q4u8B6nS2g5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffqqE+LJPhziFElTdMfz0SV2Hbozf0gVlcWQBG6zAtc=;
 b=DsStZ5079sAgLPFZv+z3ICkjA8kpr/VRzTV6W4bRGcRzvMij02j73x3vDJYMKBj5FRdmAAXOmfZjh7TX0OrUtHaWab60NJVahR7uSrpR2LVNRzBLQVakalskiexZivJVUspimt1TN/4/jKqyV4fryKP8qeHY/zqaDxFTgZxMEcY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DM5PR10MB1324.namprd10.prod.outlook.com (2603:10b6:3:13::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 4 Mar
 2021 17:20:26 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::ad89:6caa:4481:b733]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::ad89:6caa:4481:b733%3]) with mapi id 15.20.3912.022; Thu, 4 Mar 2021
 17:20:26 +0000
Subject: Re: [PATCH] mm/hugetlb: suppress wrong warning info when alloc
 gigantic page
To:     David Hildenbrand <david@redhat.com>,
        Chen Wandun <chenwandun@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210219123909.13130-1-chenwandun@huawei.com>
 <46e76ac3-def1-80d4-14f1-61f7cd00d033@oracle.com>
 <cf79e9a4-72ba-8fa0-0710-5e82a5b5e4d5@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2cb384b9-1301-59a8-f678-c67ee26053b3@oracle.com>
Date:   Thu, 4 Mar 2021 09:20:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <cf79e9a4-72ba-8fa0-0710-5e82a5b5e4d5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:300:6c::28) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR04CA0066.namprd04.prod.outlook.com (2603:10b6:300:6c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 17:20:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f24d93c-eff9-4b1b-fa27-08d8df31cd0e
X-MS-TrafficTypeDiagnostic: DM5PR10MB1324:
X-Microsoft-Antispam-PRVS: <DM5PR10MB132409F708A8085C72E05102E2979@DM5PR10MB1324.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:363;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTN1bUzmWqOF6eWu0SSZat8aoU6DGZzt4AbpQjYQfRyLr5x4nQo/mf4xMMzCuVyE3qZzC8YYgdJbcbo0M871cIRKzW25zH+nvYeVpRvji2rpxnGUUjxjFzIRWHETLXqFVsIIoIloBKX/W4hFb36EQ73HpoimXcPx0sc5JZE0rSDv/Sx3meu4eJR0m4xHImxGNALqfvA+9tcH52mfpnXl+A8m33TbSE+lYL7ww1rxC3vmq1J6byq4Nfmwb8g4no36x+uVIuqXnKq3g59myL54aKdi1dW0mIfohi3EIZaedQi1cF+OCR6O4jaMP9SzFz31Ln2vRzNHHxTQ9tBb/8hk9YoCQSRw7WjBZO2foRn46HUSEV5VDzbErKaE/IRYq3FZQqvsiHERinLjqrGwOa4DjTt0/m/jj5x+KIk9adZ4DIrhbLj91OHMVjP5GFheUvmta8FWe6UMcr2HKls7rlODf6SFfKxN+b5ZBoJm3BnA1QEaqfz8/Rl+BuWD0wX7IQ6zBJfK1HwkAwr/C1BVdsrSYrbIr8QVBKJkrpoASeNDt2a419ssTNk3CEDoSFTVykPvC6vrSf6UFgaLlKoXBsLIA9vXYJ8J/0rjapk2HvRlnHCUc96BGPx9rZF57+MBifycVyg+UL/t08LK9NM6txwvHyGpHeAdVt44t9bDCYxBhLBBmwS5b4VkhOQ79sK7vIJc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(31686004)(966005)(186003)(2616005)(956004)(8936002)(16526019)(110136005)(66476007)(478600001)(66556008)(8676002)(83380400001)(5660300002)(26005)(52116002)(2906002)(86362001)(31696002)(6486002)(53546011)(44832011)(36756003)(66946007)(16576012)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NVVvWUg1dTZmcW9oUUI4eGVRSUQzRFhMVkQwT1A5amVweUpudEZYYTBjbGJJ?=
 =?utf-8?B?RWQ5N095SGw4TzFSWjQzR2YzNHozVzhXUnBqZGY3RWR5TXUydHNLckJNTWRx?=
 =?utf-8?B?WHZSWVFGaEVXVXcyM3R4SlRkTGdnRW9KUGRvdDVldVIzNnRMRzNralZSbHpD?=
 =?utf-8?B?d0dxY2szU1BHUTc2NWxmZ0RnZXZDak1YUXR2QXg4NHF1WmRqL3pUMjRyWG5Y?=
 =?utf-8?B?N1podmRVWFNteEJkNHZWbVNFbDgxZ2h4ZFNOY09HaW1FU0RCYXY4TzFPNmhl?=
 =?utf-8?B?NnZUNnBTUCtWcFJJNDlGL1VvQWswa0lRYTBLM3JxdU1GUHZ0eHNUWDVwUkhp?=
 =?utf-8?B?bW9BUitsUlhpMWRrMmNVQUlSSEhoNjA3czF6cThVbk5XNi9MM1J1VU1nanVB?=
 =?utf-8?B?OHhvY3l1U0Q2RVlrVTVabUVQM0xjM3QyY05lYkE2d2JaSVhDNlo5akhsUHJs?=
 =?utf-8?B?WHpuZHNxUzZOK3FXeTV4SG10UjBkVVFEM1dnK29wMEJoZWRMVERyc3V4R3p0?=
 =?utf-8?B?anlWcFBlV01lakl4OE9XYkx1MnpKVHd2MTh6azVtUmx3SkFuMmlYODdRMCtp?=
 =?utf-8?B?MTkyMjdNbDh3a3BhTWE4QU9JcTNvR0RpWm9PcU0wMmJGejc4NmE1S2doL094?=
 =?utf-8?B?RlQ1cFdwNS9YeGJrb1ZpUDdDcmdJTWpKWDFyVmlpa1Y4ay9GY0lQWmE3Mk15?=
 =?utf-8?B?Z0lLTUhteHVRbkJ2QUFKcGVtT3NTelNrckF3ZllZeWlYNldvQjhzeGc5UEJ4?=
 =?utf-8?B?WlFzcHNkRUE1eVhDdHJtdGpoWDRjM2NEWGVSNHRpYmFBUXBUYXV4aS9wMk9B?=
 =?utf-8?B?R29ObWVZYjlsNzdTQ2hWTFVIa1hJd0xSS1JEZjFSbmNXRGpEb2VjVFFHTlds?=
 =?utf-8?B?S21rTm5jZWs1SFplVGtMc1dKVVVMUllJOVNic0JQdkd3UWdBOHVxWkMxUVh2?=
 =?utf-8?B?Q1lNN0JQM3F1NEJXQjBCZE05bnVIWDJ0Vi84UXpNcldRbm16NzdWcVJGaTZo?=
 =?utf-8?B?M09JY3ZKRmV4S0RZZTZLTkFvOHE3OEFRbmp4TyszK3k1WC9PbTg3K1FNQ2pI?=
 =?utf-8?B?SG5qQjBHYzNXdjBuM3ZycHgxRUFKZW1DajlMNmx2dC8rQVpaTUk5VUYwWm9Q?=
 =?utf-8?B?Q2hlc012aCtRMFN6MlJ2NU9zdnozUktidC9CZmo1K21rcHlSYlNTSUczbUVh?=
 =?utf-8?B?dE1JWFR1R2thRGU5N3JUTTlQb2x0U2F0Y0lLMG8zS0tubDJwYnV6RnE3R2dk?=
 =?utf-8?B?YkFwVDl4blVXQzY5TkJMQ2kvbmFkVWI1U2FjdFZIVDlaQXQybllQOGlmRG9W?=
 =?utf-8?B?bFVXSUFlUFpmakY2K1dmMmpYQlpOaDN1czlaQXhkTjBBbHJ5aElPMEV6QnNU?=
 =?utf-8?B?UXpIMlVYbTUwU3hFMVMvQk5rS1hQbGxFV2JQMWdNYy9FMXNyNVMrUGlwRkZS?=
 =?utf-8?B?d3hTVjgzOVBxVitCaUt6dXF1bWNWMHc3eS95UXFkZHhONlFLTDJCMHo3a3J5?=
 =?utf-8?B?NmZWc1A0cDJ4T01WeW5HUG5oN0hTUDZ0Ym5IbFIraEsybHh6OERUd0N0Zjlh?=
 =?utf-8?B?OTd6S1lJUHUwZkQ5eVpuWUlteEdvK3NZSGFCT3RTWlhrZXJVR2FmOHQ5Q3Ft?=
 =?utf-8?B?Q1pqWDR0TjRUSEQ5RzkrdUNJeVhVUTkzWkowVmFrUFFQVGxSSEFkcTlCY1Mz?=
 =?utf-8?B?WC9idnpYRHNVbDBReWZyVHhZVXpXTWJWMVY5TVJUWGZBa1FidzFablZzc0pP?=
 =?utf-8?Q?c1FafBNkElXUhkQt9b4uVDhhP3LcA+SlJ3Foutb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f24d93c-eff9-4b1b-fa27-08d8df31cd0e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 17:20:26.1369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sFfZQQ0MHNf0VP939w4DuwuUIgJm7emNJOEauWscsgwGvNfSgPQWU11aZCVLuoC/+58gnL3c3cAJI2avPxVqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1324
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103040080
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103040081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/21 1:35 AM, David Hildenbrand wrote:
> On 19.02.21 20:14, Mike Kravetz wrote:
>> On 2/19/21 4:39 AM, Chen Wandun wrote:
>>> If hugetlb_cma is enabled, it will skip boot time allocation
>>> when allocating gigantic page, that doesn't means allocation
>>> failure, so suppress this warning info.
>>>
>>
>> Normally the addition of warning messages is discouraged.  However, in
>> this case the additional message provides value.  Why?
>>
>> Prior to the commit cf11e85fc08c, one could have a kernel command line
>> that contains:
>>
>> hugepagesz=1G hugepages=16
>>
>> This would allocate 16 1G pages at boot time.
>>
>> After the commit, someone could specify a command line containing:
>>
>> hugepagesz=1G hugepages=16 hugetlb_cma=16G
>>
>> In this case, 16G of CMA will be reserved for 1G huge page allocations
>> after boot time.  The parameter 'hugepages=16' is ignored, and the warning
>> message is logged.  The warning message should only be logged when the
>> kernel parameter 'hugepages=' is ignored.
>>
>> IMO, it make sense to log a warning if ignoring a user specified parameter.
>> The user should not be attempting boot time allocation and CMA reservation
>> for 1G pages.
>>
>> I do not think we should drop the warning as the it tells the user thay
>> have specified two incompatible allocation options.
>>
> 
> I agree. It has value.
> 

Hi David,

Sorry my above reply was too quick as I did not take a close look at
the code/patch.  See,

https://lore.kernel.org/mm-commits/YDAbeDsG7GhV6s6B@carbon.dhcp.thefacebook.com/

This patch is actually in Andrew's tree.
-- 
Mike Kravetz
