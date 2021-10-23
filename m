Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D85438205
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 08:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhJWGOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 02:14:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59244 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229446AbhJWGOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 02:14:18 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19N2rXt6007787;
        Sat, 23 Oct 2021 06:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uRnPM75K5Vftxg/frRogdB3Fm03yRGFQofQvESak0tY=;
 b=T/MR64AolItWube6mspxMIMDO8Q2Y4D8nIT9Xpi2dina0PxUuDdcL6YSmaKop4mRtm0R
 cMioa/oRulluvMd1cxUkEe66U7rC07hfRq++THy7ymRRl0WiHHibo3aNisZz/mM6sdT0
 z3Ahqqf7umqaOgfKYwESRevJdiLIA5x8aDH+fVP++4hbvH9OEBhe5LR0h6zEtdhTZ0mF
 YH98yb8J8xoyNTieK2QpPKzDBmvLFfqe2J5v7Ien6A0/9EM7WTrka7iAIBTAeHx6Tks5
 02bWM5eiMX+wsvMg8gnLh0fENky8fGImkjUhjJuU57Fe7oVQZfIGY/P+ps8kMpDBqWxN rA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bva0treha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Oct 2021 06:11:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19N6B0gx078759;
        Sat, 23 Oct 2021 06:11:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3030.oracle.com with ESMTP id 3bv8eaxkve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Oct 2021 06:11:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+QN+Q3gN9iJoEG1C9nsINNkSDxx7V9m225zG+7CGHPkfv2Rji8QnBsugQRANPFeZg7dYzEtfK0A8HQKG6pXvK0Noa6unkYhIO3WQjBODKC1jSyqRTLnV7ZlaSmquIoZJJy70/IzhH7i099FuTEB6Gsnwac1TkvYoHqyLtX05wpDwfMglzbGjZLoYL1CW7BeCyYzk1OFsIG9JnUp3C45DiJcB6ryH6n7isirB6JTxlGbqugmN+/685os1i0ra2coWL9bHR0G3RFaJN1r5CiMcDpfd50qQXwyyO5ofmc0SBDYTtj9Hq+TfT5BdG8HMYcQ3wNfpH/NIgGQCePXqEs0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRnPM75K5Vftxg/frRogdB3Fm03yRGFQofQvESak0tY=;
 b=b38m3NfGzOY021FufkbsVLAstxGjJRvzKQn3s+ZmLtgLZCnvVrM5XWqZUflDyVbyQK8QsGazy2Y5nS3EgqttetuLIsXXyliWD5VgFLEW8/EMOHLN8rUQEPklur7thnkSoPI64jetgx/MGkvmSe58MD0xF8in9iWT22eV+f8M5Fyv47dTho5fyr4L+RJRoQQfzuWm/N+JfdICRD7stkqFFa4SNYS7iONgP/CAE3k971SMKtmqOxd/7DUVsOH3id/FN2Pe9+vpXXEjHX3c3XJqnU1Z5tqVoz+oIXW9ayBXMom5iC68XhxvUeOM+6OldmVpnio3GU6C5qIqJ3qfShJpUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRnPM75K5Vftxg/frRogdB3Fm03yRGFQofQvESak0tY=;
 b=rnV86Idbf3rD+1z4Hbuiypu9mka4EsrHZmi15ID+67B46iF1QiVdUZEWGCncwBGw6E75gkIg4h5BMtuHNk9jr56XPywJXhFJ3vliuhvmOPXHjrlKYlngaWAIvULMHRkE+HQED2vWOuHkwE5r1uUDueiEQ3JRWbiA57jQzkJUHNs=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2438.namprd10.prod.outlook.com (2603:10b6:a02:aa::22)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sat, 23 Oct
 2021 06:11:47 +0000
Received: from BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::8057:9886:f19c:a025]) by BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::8057:9886:f19c:a025%5]) with mapi id 15.20.4628.018; Sat, 23 Oct 2021
 06:11:46 +0000
Message-ID: <51d0b44e-c1d1-a8e0-50cb-df9386a0f039@oracle.com>
Date:   Fri, 22 Oct 2021 23:11:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v2] mm: Optimise put_pages_list()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211007192138.561673-1-willy@infradead.org>
 <cb85b8a6-b82f-3054-5d76-57af018d6b2a@oracle.com>
 <YXNhx/IYJGVR1ZOH@casper.infradead.org>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <YXNhx/IYJGVR1ZOH@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:806:120::9) To BYAPR10MB2438.namprd10.prod.outlook.com
 (2603:10b6:a02:aa::22)
MIME-Version: 1.0
Received: from [10.65.154.122] (138.3.200.58) by SN7PR04CA0034.namprd04.prod.outlook.com (2603:10b6:806:120::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Sat, 23 Oct 2021 06:11:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9373bc46-ac9c-402c-6f05-08d995ebfe65
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5647:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5647995A26813C0DD9C951E6EC819@SJ0PR10MB5647.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WpY6+CzOL9TlUuqsti5/jBZZ91VxoSoQsvgl3BXg8B/h9U0Il6kldVGA0Ak/9e252zuxzrkCfaCTpOOgZBYjHYX8BO/gydOenYXucKwWso7OSfxMlKAjnRCaXjOSqD2Por2f0+HRk0gX/J/sUNVuMopEK8uxIqLTzfilEuHN3QOwF6bTyae2EVzmdJNNRI4uAjD+iFKUDC/Z7WzKZc7Gm5sWnnG5U3XuUpkyh7okIvvBETnxI01BY7TavMCIkrdpO5oferhgBwqA+Rg0J2RHMWy9egXFPuP2iYg5mMi9za+JXNvWZKCF53bnUhuYm/go1sAphQRX9Q9r5Yzhl/aK2VfqdHcYTdWfd30tVisrCD2kkgixMcjPckBNjz9B2ydV1T4ZOfZsjOGBycuyFhIayowuwtc/zzBX7M6eCS6TUW7/tmu5cnmvPyCiUbNFA8Wf5bnyrta4cv2CytzPTRtXRvPoAf2vxHlFqkLlqvnuurfqizVVr//URQ8zI52Lf9UjwjlI2vpkkga/Ma7YM41UE+Gsgju/LMmNUCYSR5Nhzd9ZTJj+01t3+2yrOkrwgzPUOXSeTT11QQLq2NqP2yLg/Ddjs7veiCSJ2KvvGiXH5JW3+Rrlw1wDBjD5Hu9Ty68JyhM6c30z88qaGo6K97Ak9lmNuatDKf6MaIEyVjrf6WD2qQCpW1EdfL5RqIJKxzeoOIaz/YIfY2RrkSA9XiDv6sURUYFX1o519xEuBouINLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2438.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(186003)(36756003)(508600001)(66476007)(2616005)(66556008)(26005)(5660300002)(4326008)(6666004)(31696002)(2906002)(956004)(44832011)(31686004)(6916009)(83380400001)(8676002)(6486002)(53546011)(8936002)(16576012)(316002)(38100700002)(54906003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlJHTitLVEZwSTg4eENxTytMb3orRWk0T2Y3cjdkV2lMUlZvajFlTlZjbDNH?=
 =?utf-8?B?cW5BVm52ZzN6cVhROTZOYWRVNDJkMTlCS3BKaHpPa1BFUFJ3cktmQjhZZmhh?=
 =?utf-8?B?QzQwMzJQRVE3MTJ0dXZNZXhmdkptQWd3b0NoNENPM3E0cXB4bzdzWEF3R2tw?=
 =?utf-8?B?bjVjR1hDUG1pRk1TNDNPeTBvbEdDV1p0NFFJczhZMEt2bXpTUkF4cG9jeXdx?=
 =?utf-8?B?dUJoSWo2a0VzOUwvMENUcjBiUHpKVG1aNjBuWmJ5bFc1S092ZVcvK25pTFAz?=
 =?utf-8?B?a1JhQ3FtTjJZd2FwcmFNckxURjMxajVIZEdXRGRDL0I2cDh2aFNXZ056U0tz?=
 =?utf-8?B?elpnWHBDRThKNk0xclQvYXBZZXhIVmhFdjZuU1NoM2NvdDdSVjRUbitibElZ?=
 =?utf-8?B?UzBodDVmM2lhaGVxY1lBSFRRNk8vYm44MlJaajN0aWIrZkZQZjJoUmlXTXJx?=
 =?utf-8?B?clpadE5ZQWI1YWJOa3pRcE05UWc4KzhFZzRXbFV0eGlCeVVJNTdEbTV5b3ln?=
 =?utf-8?B?bTZaZklWUHU2eVhHY0kxZ3NaTjhwdXgvYlJxcndaOEZrVzJwUG12aXlTazNV?=
 =?utf-8?B?UHBQS1FPQjNtTE85RU1ZZWFuN0FLVU5HM2xTcGtCbkdJMU1IbzhxeUlIOW5J?=
 =?utf-8?B?b29ZZWhJRnVJRjB0KzNhSXlpL3lYcngzdnJRNGVzclZOWVdXYmVjZVF3eUlB?=
 =?utf-8?B?YWZETkZBWEd1Tzc1M3F5L2wvQTgwNVpUT2E0NlZjSjl0d245WmdIa1p0MFZz?=
 =?utf-8?B?bkRSbG1sZEFhNnJ2K2hTNkJhYzZlV3Z4K1pHc0hYMUN3WnBnUkFEcklKdkdu?=
 =?utf-8?B?SFo0YVRWS2hyUWMrNEJqdEI0clhrdW9Db0VScGZlTDBkQzJLTXlNVmt1VEZX?=
 =?utf-8?B?QmNOL0VzUi9ZY1gxSUFjQXovZ2l2R2dmRSt1OXU1Y21HdUhkN24xb3ZCeVhk?=
 =?utf-8?B?OEFIQXFGYWF2aXplMk9BeE1WVmpoT2tySVlQYnQ3TEF3TG8xT0FtNHVxcVhv?=
 =?utf-8?B?MUZBbWVteFNLZGh5cGJ0N2JDQjVEM3BxeUdUd3FycEJyTDV3VDdwbXJOUzZt?=
 =?utf-8?B?bVlXMkduVHBlazBrWThJd3A4L3lSaHlRbnFSajBVbGh3Z0FMOS8rS3F2Wk1V?=
 =?utf-8?B?TVI4ZTBFSGJkT3pLWmxudXkxYjdrWUQ3NG5oZXg1WG1sWm9uVi82TDEyTUdz?=
 =?utf-8?B?eWx0T1d3NXFnWmN4bXRoRWs2WGtrYnJMREZJbFB3UmdqcmZ4VDgwRWdLdnBU?=
 =?utf-8?B?V2g4Z1lBVzdjYmcvcG9mdDFqalRTNXlMSXBuellSMi9YWHhKaDI3TFk5cHA1?=
 =?utf-8?B?di9IaFI1aXNLdlN4UUhSeFBRRXRDYmI4ZURLWCs0aVArR1E4OWRhTHI4bk84?=
 =?utf-8?B?SzMydHVVTUdRV0MwdjNGemlGS3lHTGlCcEg2SnUyOVlENXl0S0NhL0V0Y2hL?=
 =?utf-8?B?aVZCSzdDZ3RsYTR5SzJ2eXBZdVhWbEtJTHNjRDhxeStYUHJnTlNjd2tGeUZC?=
 =?utf-8?B?OTl4RmczNGRIeW5hUmhHUENycFhaMjR2RXNxRXdQQWNmOG04NmVtK25ZWmJ2?=
 =?utf-8?B?cFlnNTFYRWU5UmU3dUhMbmIxcVowa3pFZzNQcFgzM3lyRFNqVU1Za080TzlN?=
 =?utf-8?B?UDhNdzk3V0hBU2dXT3RxYk1oN3ZXcnoyZTlPKzQ1NENIdEJES3J4Zk1UMDNJ?=
 =?utf-8?B?TTViNnJsL0Z1ZzNsVVdkL0FXU3lzQTl4Mm9jUW9oU2wrbkhyUW82NTdsRVFK?=
 =?utf-8?B?Rm13VmVxN1ZMU2VLQVdrK2JDS1B0Q1paWHdSdU9hV3Q2UXhmZU5ySmVkMXVN?=
 =?utf-8?B?RUloMEIwWkkvb2w5a25FOURSeGZsOVpUclpIZE1BeXVwVGd2YXJ6UXh4UGR6?=
 =?utf-8?B?eHVybmE1UTlDMjRZM1o5bFE4dXM4bGk0VUgzRnM1anhnYk1lZnBibElGRDRI?=
 =?utf-8?B?S2xDeDZKNUF3cWtIUkhKZDZmbkVHYzNhUlFaOGhuS25EM0s0dDFWdzlVZXVy?=
 =?utf-8?B?aytxU2NGTmZEWVp5Uk02LzFWbzVhS1lwN0Rqc1lzcVZDcm5sR0VQM3VLcW5o?=
 =?utf-8?B?SlZLblZwZ0RBd3lYNkFFSllwWWh4azdJUXZXVnBoSHFsNVZyN1Vyd0Z0VlRP?=
 =?utf-8?B?clprSWlYVHJlUElkdE0xL1RCRmFXcnVVY2ZHY3E0WjU4UzRLUmxqRUhzNjZK?=
 =?utf-8?B?dk5MOTN0eTJMVHJtYnpLcWJTYjVjRTQwdk1rNWhGejlQVlcyWVhNWW5FV1Jz?=
 =?utf-8?B?b1p2RzdlaHV1aStVLzlhMGVDaGVnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9373bc46-ac9c-402c-6f05-08d995ebfe65
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2438.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2021 06:11:46.8508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcpBzCJnurhQ90660o2XOhKmRrnY3T3BOwiUnpWkPiqH4dKc/4+EZ1c6CrLp5VTRLtsc+lwEzNVCeIba5+6GRiLtgvi+3aMWRkyTyqX/ieM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10145 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110230037
X-Proofpoint-ORIG-GUID: BpMVvysWJvLunymFVxxw5EAT7cwigkhL
X-Proofpoint-GUID: BpMVvysWJvLunymFVxxw5EAT7cwigkhL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/22/21 6:13 PM, Matthew Wilcox wrote:
> On Fri, Oct 22, 2021 at 04:26:59PM -0700, Anthony Yznaga wrote:
>> On 10/7/21 12:21 PM, Matthew Wilcox (Oracle) wrote:
>>> Instead of calling put_page() one page at a time, pop pages off
>>> the list if their refcount was too high and pass the remainder to
>>> put_unref_page_list().  This should be a speed improvement, but I have
>>> no measurements to support that.  Current callers do not care about
>>> performance, but I hope to add some which do.
>>>
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> ---
>>> v2:
>>>    - Handle compound pages (Mel)
>>>    - Comment why we don't need to handle PageLRU
>>>    - Added call to __ClearPageWaiters(), matching that in release_pages()
>>>
>>>    mm/swap.c | 23 ++++++++++++++++-------
>>>    1 file changed, 16 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/mm/swap.c b/mm/swap.c
>>> index af3cad4e5378..9f334d503fd2 100644
>>> --- a/mm/swap.c
>>> +++ b/mm/swap.c
>>> @@ -134,18 +134,27 @@ EXPORT_SYMBOL(__put_page);
>>>     * put_pages_list() - release a list of pages
>>>     * @pages: list of pages threaded on page->lru
>>>     *
>>> - * Release a list of pages which are strung together on page.lru.  Currently
>>> - * used by read_cache_pages() and related error recovery code.
>>> + * Release a list of pages which are strung together on page.lru.
>>>     */
>>>    void put_pages_list(struct list_head *pages)
>>>    {
>>> -	while (!list_empty(pages)) {
>>> -		struct page *victim;
>>> +	struct page *page, *next;
>>> -		victim = lru_to_page(pages);
>>> -		list_del(&victim->lru);
>>> -		put_page(victim);
>>> +	list_for_each_entry_safe(page, next, pages, lru) {
>>> +		if (!put_page_testzero(page)) {
>>> +			list_del(&page->lru);
>>> +			continue;
>>> +		}
>>
>> I know that compound pages are not currently passed to put_pages_list(),
>> but I assume the put_page_testzero() should only be done on the head
>> page similar to release_pages()?
> Fun fact about pages: You can't put a tail page on an LRU list.  Why?
>
> struct page {
> ...
>          union {
>                  struct {        /* Page cache and anonymous pages */
>                          struct list_head lru;
> ...
>                  struct {        /* Tail pages of compound page */
>                          unsigned long compound_head;    /* Bit zero is set */
>
> so if you try to put a tail page on the LRU list, it becomes no longer
> a tail page.

Ah, makes sense.  Thanks!

In that case here's my r-b:

Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>

Anthony


