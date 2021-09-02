Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C353FE64F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbhIBAM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 20:12:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10340 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229898AbhIBAMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 20:12:23 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181MKIVc005715;
        Thu, 2 Sep 2021 00:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=H3D0dZLGgUOIoRU3O8JlCSu3ePqX9Apk0ZOCfSbSm7w=;
 b=krRgEsCGJwJ4nVoh5HSz9Iq6mWwi2znuJ5VXM1M2voqYD3AtPqxBwAz13EmJKYdkeMZm
 IpPwTy/3WyCv6kffRGO8arG7F9sFobJvbH/68QHcClEd3pYhbWkYhOVrxLP4hZFcdiQI
 nB+iH4q9mhcudBxzRXXt6/ef+5+i4ptWlPqYjk59Z8JIb/uUYp2bAvvvZI+HrTahv5K4
 SC8Fz0mLB6RNfwucGW4IVByySpFApnnZMhXT2PkPS8qa3YPsTNyB7rInIMwFdx36Lxz9
 XwzNwFvkCqPY7Y12FNzawmkDBsJh9S8Un4yjTEA4+nbncRtPd5YxKNv1Qd1wakD2quEV LA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=H3D0dZLGgUOIoRU3O8JlCSu3ePqX9Apk0ZOCfSbSm7w=;
 b=eKYRRkNeIoVhs41H7nBkr4+cBFco3iHLq9xvbzwciZeANyuIxtcpXX/Z9HvFPAYquT+m
 1RWybvSa+o9V2ShJzqtjg2R/i5ONkwCDtHvTTnqvnqaZ6c9dDNkx1UdLcryKDk+XXwS5
 +7H3oX4TdvTkEKA7G4jOtD0xKW78rIDqkfOsrpTaf5ARtqufT9eViJ1QjYKWerd1C4H9
 rcMM/HzuSnTl7y/tkU2Rjs6SD++Nb7G/eRm1BTSQwwBaN2FrCeeFIzdo12/uGhTrk0jQ
 1vjRK/1/5CEwtSICX9UxuES7r+adNuDeNp7UVfNjr//YDqkY3kCzBgp6tVEY6vkyCVE8 3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw0gve3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 00:11:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1820ASpb160580;
        Thu, 2 Sep 2021 00:11:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by userp3030.oracle.com with ESMTP id 3ate04xtbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 00:11:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxaxPuMubbIxAm6LEBscwLegmltNWfXGyXyHp0/TV5ZIzJSmsjGpeQs/5nscPHpboD2mPeZfZGYN6H5Y/2AppxRb/Iv2SA8lPsGYbmlWchIUbwemOH5rmR5rYTi7/Iu4T4r6kHluGz3f78VfPRto6+VOMOTu5a1aTZKQsREaBr/+6KaiEJHIqmW3CrNi/tX2e4b7/LstqpQqzKXBPhHQO2MLtX8eu7PpD1eKrCZlRkqrLnwkb4Ry5NyCY+RUSLw5MxiK0DJsO16nJvqno+lX2HUpaid/z1DIWc51fl5T7QOdWoCcdwDR872/ONeRiA+WjE5Pl6zTBPhtseeT6UE0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3D0dZLGgUOIoRU3O8JlCSu3ePqX9Apk0ZOCfSbSm7w=;
 b=emJXRjws2hdSQPWABCSgyiaeg/lNIX9UE+xbc4ye5ioqSMc+hRRo9hbfc1B4ykWD38OGc+LB3alrbCRnklCP7uDI9j3ICdHI4NaPrbEmSnl9ImP1UYjGyFOpyQ6epFWY3rYxaZnu3zNX1C7DiaSOOk8gcUn/ms9LKwUAKFNdSJzgUqXpzXByo5nQ5595C1IWr4bt0qK/ktk7cU4OUUwgVsBkj0wNY9HVbvzdjcR9U1pAbO8wV02mmGsit2Kn7hgQ4RO2ZTwPdI0jmOufcGH48+dGaeZICCZ5cxAz4bi1WopjzYdDG0Uyyr28PleupYYodAxUD4PsHmVb5Pvn/mqZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3D0dZLGgUOIoRU3O8JlCSu3ePqX9Apk0ZOCfSbSm7w=;
 b=SVnIVLnhf/erQ9gIgnEDt8HG9hzZ5PnYVpQwnbR3TX74rEolyJxiD0Dh3plamHbFetAPmxTYnJX2QbyCJufzZRHXrfMTdQnd0fQ1ESpbL2KkjPUHGEtYWCcVc5H1bGfn5pYbOT85ceaHhIjduzSGeDSw4x98VAnGSFTweVDqiTg=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR1001MB2128.namprd10.prod.outlook.com (2603:10b6:301:2d::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Thu, 2 Sep
 2021 00:11:17 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e1f7:a0f4:46c5:3df]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e1f7:a0f4:46c5:3df%6]) with mapi id 15.20.4478.019; Thu, 2 Sep 2021
 00:11:17 +0000
Subject: Re: [RFC PATCH 2/2] lib, stackdepot: Add helper to print stack
 entries.
To:     Vlastimil Babka <vbabka@suse.cz>, geert@linux-m68k.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>
References: <20210901051914.971603-1-imran.f.khan@oracle.com>
 <20210901051914.971603-3-imran.f.khan@oracle.com>
 <f425e27a-8f4a-7687-589e-b726085c5c7a@suse.cz>
From:   imran.f.khan@oracle.com
Message-ID: <9527f084-4d60-2a85-f4e3-8e16cf7aad08@oracle.com>
Date:   Thu, 2 Sep 2021 10:11:11 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <f425e27a-8f4a-7687-589e-b726085c5c7a@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0043.namprd08.prod.outlook.com
 (2603:10b6:a03:117::20) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
Received: from [10.191.132.27] (138.3.200.27) by BYAPR08CA0043.namprd08.prod.outlook.com (2603:10b6:a03:117::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Thu, 2 Sep 2021 00:11:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10f9000e-f6d0-4420-fca9-08d96da62f0a
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2128:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2128D01CE001164966C21BC7B0CE9@MWHPR1001MB2128.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oAN2Iigz7ys9880ce54BQ+iMrpIEHGhxMAVnDCZZPp3LlmYVBw5Gky2hynfC2JcK3QWHVTXJLPibYTgocVBJUxg6fsnEDbyZ37MBs5ZPMQa5Wa8DrjMZjZLCDXCE7Cc9UHSQJDxvOW433JErkcQiJU6xbNWUFnzTN/CjyHT350Vle3dYWnoIHYFhXv/mdll4B9ZiXDPUGhqZqamXFtgRYARU8EoKXj7lcmeGiYQrGhDs5cRk3Kooj7eOAptvt8Y/Fd3xHzWqQSmog4brAWywWTrNxSBBDgqL3kadOntsyJJWgtQt2iMr50WJ6duVkqAGR/t3AAn12RFsl6PGWWmFyRYXnL8iECYooqMhQ5xsy4eqt87Pds1uRfJK95qRHoiwvSqroPvzFFEoil9UC1Np34GUjz5SOqkDMGbBYD7j/oghhopW2Knt0AQ5WKhXPytKsQHU5NKHkpMN5KsEyoWiavVMR54GaY1mDnlJjSLSTHbfVJ/CF/QqaA2fjzHvpIoVHIYnQBYVKx1RmLIb8Lt1SO/AdUXZQ8lTs3RA12qAbfj4TPBo8UwQTPmaxoqxGpzNyi274eUf4Yl9U1jkIukGd2j1cCbyrVh5Tk12XN8/aK9T2TzR0+MX2uWudxcBbaxq1WISGQJdqrubETdlygG9PaWUMBP03QYc0burIElvZrkOAH4aK87+6SAb/wlTabffixnNewIhemsxCYvMtpuvEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39860400002)(366004)(396003)(4326008)(36756003)(38100700002)(86362001)(8936002)(478600001)(54906003)(6486002)(26005)(53546011)(6666004)(16576012)(316002)(8676002)(5660300002)(956004)(31686004)(9686003)(66946007)(2616005)(2906002)(66556008)(66476007)(186003)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmR5dWEyenRpQzdHL1I1MzJVaGh4OFo0cUFJdzR4eHBvTENWNnBkRGUyNDR3?=
 =?utf-8?B?UTBQTmlpSjNBRW5sMTRMTWoyVGJ0L1RobER0WlE2Lys1RkFTV1V5S3NiMmpN?=
 =?utf-8?B?a2ZQWGQzQnBUUHI5WWZPWTNsb3oxQ3VLamI4VjQvMks1MWZhcmE5dFpjSzJG?=
 =?utf-8?B?ZWVkdDR4ZlA0RURKcDc5NmdwUFBva1lPa2ZZNklKa095YzVRb0NBaHNWZk1a?=
 =?utf-8?B?SWNNbjV5UzZDSjhRMUVjbCszcklLc092blBLa2t6Rlg5Z1NGN3lwNnRPcnh3?=
 =?utf-8?B?RTJHSURyTXRoMzZBeGt0eDBmKzZmc0VsMGdxUFVZcElGbTRwZWNTNGlCaHR3?=
 =?utf-8?B?QnY5b0puK01RdHI5YWlPVHhIMEZobzhpSEVTNnRPZUExcXB5MVpxMjhpOHpN?=
 =?utf-8?B?b0N0ODhuQ0UwdzJPRHcxSVUyaEg0R0ltcThSUWRjcE9RbHMyNHdVQUxKY3lN?=
 =?utf-8?B?SEx4eWZzRGRlbHIxa0o2M2RLemNxT3FtTlk5dkx4bGRadVcvaE9Kcm5tZk41?=
 =?utf-8?B?dDBqT0FVR3dUak4vYXpvVHdpVTlsYUVPRE9VdlBUNC9MdW1qbU5zd2NQYTU3?=
 =?utf-8?B?VDF4ZzVaUzcxM3NtbnZnVjIwTWtzVmZHYXlrSUFXRnZGTFY0b0FON05teVlO?=
 =?utf-8?B?ZkpCSWpBbWMwWmsxUnhhRkNDQWUyRC9PL01qRm5yZjdPSThpbGwyWGtDNHBm?=
 =?utf-8?B?TVhGY2o3UTZORm5WOFR0VnVFNFBXRXp3UEI2WG1ROWNoQUUwZHJBUUg5TnBL?=
 =?utf-8?B?bldRYzRpVjFDVkQrTEdRQVdHZnJRVVFJdm5raG55WGVDTGdtaHBvd3F6MHRi?=
 =?utf-8?B?N1UyZHZFQjBUYTVCdmlVQXk1bXBsZ1BlRjFCVWtyMDZQQTJrM3k1c3hwMnFl?=
 =?utf-8?B?aTd2NHQwVnc1S3FVUThQT0NKZS9rdTJsZjJhYjNQbk00SDlWdjFPSDlSWUcw?=
 =?utf-8?B?VjE5a0tzdFBLcnh2dnhSRzFVT3BnZ2tGcTVjd2g2ODVYWnJsSUlKWFIzaDZC?=
 =?utf-8?B?VDFFWlkxTTFRS1BVRG1uU1VET0RuREsyUzFkWXlFWDZ2MFlaQ1FQQU5aMGZB?=
 =?utf-8?B?engrSVZDOFRhOHY5OVNsL3dhUldSZ0ZEaURIaXlwSXU4Vjl4ZHRjamhkbFk1?=
 =?utf-8?B?eXI4Vk5vNDA4Q1pMLzhHQVpRYkFpR3RVNzdXR2Y3d21ObHBwMVh5ZVJSY3B1?=
 =?utf-8?B?bGZ1SkplSmdCV2IwQXNoTC9hYUU4Wmx4aSt2UjRSU2FnU0g3cXhka2NsazJI?=
 =?utf-8?B?TjFlODVkdEVCYzY4cUNoS2dIM1ZGdDVxdHJzZENQWXYyRm43Wm5ZL1A5cXdU?=
 =?utf-8?B?QW1tWEpUc3N0aVhmb3dLeW1uUVpYZlAyQW5UT0RnZVNVWW1OUCt3dWk4Wnhk?=
 =?utf-8?B?dUJUTWFJanlyL1lRSFRSejZJRTU0NnFSdUQvV2FoVVd4TGtkWHVJcHZQYXpR?=
 =?utf-8?B?R2JmTnpaNlJ3NzhyaUNTRUVhaXNPT0tBRzFRWlZFT2Y4dDZNeXVTTTdOWkNo?=
 =?utf-8?B?QnZQdTlGWnNIMWtNT0hEYWMzbkRhOE9DSDF2Y2ZTaUhOYmNjSjYwOG14UHZY?=
 =?utf-8?B?MmRyNWpRYjl6akVvd2FCV1R1bTRDRnJyd2IzL3RoWjh4Wk1IeHM5bWh0c2R6?=
 =?utf-8?B?VXRKZGNDMTNzTnZZU0RpTFJBVDF1SWFXb2FzVzMyZ011VXBTMG9tWDRXdUY3?=
 =?utf-8?B?Ymx4YjVYZktjUFlJUTdrbEdIYVNXTHZaUFlLTnRpSUw2VzZOYzRVMlZ2cjVU?=
 =?utf-8?Q?EaSwl7SdV7ODnXkLreSlCIWAuBQa9zABaDNeP5h?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f9000e-f6d0-4420-fca9-08d96da62f0a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 00:11:17.1909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eekha0YGNZhsxXJPz36xngqBpb/SsYUdSGM/aDopwGACMPjuinPBO2BReWqZ/DGVMYbNOhhVFlrZb8nPz8vVkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2128
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109010143
X-Proofpoint-GUID: U3uNTfKioEHoY-yUuoqua2X8-UaWHiLn
X-Proofpoint-ORIG-GUID: U3uNTfKioEHoY-yUuoqua2X8-UaWHiLn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlastimil,

On 1/9/21 7:07 pm, Vlastimil Babka wrote:
> On 9/1/21 07:19, Imran Khan wrote:
>> To print a stack entries, users of stackdepot, first
>> use stack_depot_fetch to get a list of stack entries
>> and then use stack_trace_print to print this list.
>> Provide a helper in stackdepot to print stack entries
>> based on stackdepot handle.
>>
>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> 
> You should convert existing users together with the patch that introduces
> the helper. I think print_stack() in mm/kasan/report.c, and
> __dump_page_owner() could use this.
> 

Okay. I have done this in v2 of the patch set. BTW I also see some users 
(one place in page owner, rest all in some gpu drivers) of 
stack_depot_fetch + stack_trace_snprintf. Could you please let me know 
if it would be okay to add a helper corresponding to 
stack_trace_snprintf as well.

>> ---
>>   lib/stackdepot.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
> 
> It's missing a declaration in include/linux/stackdepot.h
> Perhaps it could be all be a static inline there anyway.
> 

Agree. I have added missing declaration now. I have not made it inline
though.
>> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
>> index 1d42ef9ef766..eab4476b060b 100644
>> --- a/lib/stackdepot.c
>> +++ b/lib/stackdepot.c
>> @@ -214,6 +214,23 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
>>   	return NULL;
>>   }
>>   
>> +/**
>> + * stack_depot_print - print stack entries from a depot
>> + *
>> + * @handle:		Stack depot handle which was returned from
>> + *			stack_depot_save().
>> + *
>> + */
>> +void stack_depot_print(depot_stack_handle_t stack)
>> +{
>> +	unsigned long *entries;
>> +	unsigned int nr_entries;
>> +
>> +	nr_entries = stack_depot_fetch(stack, &entries);
>> +	stack_trace_print(entries, nr_entries, 0);
>> +}
>> +EXPORT_SYMBOL_GPL(stack_depot_print);
>> +
>>   /**
>>    * stack_depot_fetch - Fetch stack entries from a depot
>>    *
>>
> 

Thanks again for the review.

--Imran
