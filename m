Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0618F43B8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbhJZRzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:55:54 -0400
Received: from mail-dm6nam12on2083.outbound.protection.outlook.com ([40.107.243.83]:35457
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235511AbhJZRzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:55:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLqdAGXC2ZFnhbv2+3/+cn6eFF7p9CpLkBi4yvNqA+hmR29eMxUCq4RiyyqRTKMaljW+r4tfTlNmEXkYSRUtQaMuMmWRfioPCL5YbK0yIjNDGx7ipNxaMyZC3sE5UxpjOFceX6xNnZfNFUrLJ+Aw+xxaasm+8PzEjuyLp2DjMn52Ks+d8cNkoT71MhY3KeLv1JHuFZ2KWKymwTjx2bCD8/+URkk3fvJvu0r617BrDSaU3ehnxeVpiWOwaCR6e8Wa450ta/A/EUlYgAga9eIHPdg3ajqkBNM7flknwyM1iUiVo21kT57v8UL+Z4bxambAGZScr/WzQZec5jPh7Zz7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3M3W5qPJh2he3Hox4e2uh9EFpk9eMn2vzfbPx40zJE=;
 b=HxEMmo4+C84KROSNWcIHpNag9oVJP1ZOze+z1nddbLMPb3Mjw2LO3ulWaoGJbdy7y4LrLxPrAkuKqi80rUj8I/zmRcLwxqkgSq0riV3qdCPfDTD3ynCI1fxTfLR37zwmenTQDguXUxClLkxbV58M+vsGwLrOAwOsvPJkOWJZRjfAQfMIS5lprmRR0YpmTmpe+ueGWxtPDJ4d+q4nqXNAtXqnR66/kp1y+CklccaH5Cqopw4o0nmqqMEzUrGbrcnwvVLo2ftzVhVDNGg3U0HAFGOV0wvyAb1Yewv2E3rlgXvTdH8m2jf0yB7HPxNDUyP8cU/rwFIGiQR49ZuXllv++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3M3W5qPJh2he3Hox4e2uh9EFpk9eMn2vzfbPx40zJE=;
 b=D+aJlHH36U4cPvLkIKPY6O1XbtCWHKig186qSaKmGLOfp9R8vd/ODp4eNYjLySrFB5pf+bpvjYxTSjRglg2czbAiKCGT525URhPQ3d74BPVWhFB4OBKRuJXWDH7VgM4O+ammFk33vevtpugCHNzJEGb/ZvxURhYt60od5T4r30FtssQt2tgi1lsYF8BTnqXgunocUPyYMYN77RuIZNQzz1yGPOJ0fe5JYRAMlLy5/3UQc8NYGo0fIMibUcEdJLiSs81jCApImxCOLoTB2Qi0Xs4AwaWXcIPfxU1aEpdkSAj0PimCIoAe53Tp5K381QNBLo/G6f9H3ZfDcVODYy2wOA==
Authentication-Results: soleen.com; dkim=none (message not signed)
 header.d=none;soleen.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by DM6PR12MB4925.namprd12.prod.outlook.com (2603:10b6:5:1b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 17:53:28 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::4971:dc6a:3ca0:aa25]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::4971:dc6a:3ca0:aa25%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 17:53:28 +0000
Message-ID: <7b131cb1-68d8-6746-f9c1-2b01d4838869@nvidia.com>
Date:   Tue, 26 Oct 2021 10:53:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC 3/8] mm: Avoid using set_page_count() in
 set_page_recounted()
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-m68k@lists.linux-m68k.org, anshuman.khandual@arm.com,
        willy@infradead.org, akpm@linux-foundation.org,
        william.kucharski@oracle.com, mike.kravetz@oracle.com,
        vbabka@suse.cz, geert@linux-m68k.org, schmitzmic@gmail.com,
        rostedt@goodmis.org, mingo@redhat.com, hannes@cmpxchg.org,
        guro@fb.com, songmuchun@bytedance.com, weixugc@google.com,
        gthelen@google.com
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <20211026173822.502506-4-pasha.tatashin@soleen.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20211026173822.502506-4-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::28) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
Received: from [10.2.61.40] (216.228.112.21) by BYAPR05CA0087.namprd05.prod.outlook.com (2603:10b6:a03:e0::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.11 via Frontend Transport; Tue, 26 Oct 2021 17:53:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e9a7be7-a970-42ad-edcf-08d998a983c5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4925:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4925E06FF3AA0E8FE23E1630A8849@DM6PR12MB4925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCuwa+/jWfYTxJY2GudUi/sFQtd7hUZJeKj4Q1LcBiqojTdU/ASBfakVZIXtPmiws9Dxdio+6ck7Via9Lga9bo4ySTjLskH7aSdcdQYWDC5i0n3bgUUP71D8XfylJ/OmR6WIsRBqcPVln7NF0Lk8dRAFAC70fMvqytkQ3n24aHRrwVJwdo5IpqyKfkr0wGe+WFoDMvvTiAUof/yrEyye7EGX+rv+uXf7nCxFfQkQ5Cf6rzylRQUIJ3KAFbQJL4ST1t8mYoChKr9UcD9agC/CS5+n/JbaP0jCx31oa9wcn7dYHq31gJ8do7Ketj3WEMvJz+016EcTMiKs9jL0CRk7GQqek1hBDgFTztfYpQqBEFlY6uIoM3xtDxz1kUu4FLHr+9X62ByKPTydqtuEVB1S8BYaO9qGa1iMENcHinX607H8v/3VjdI87OiB5jRSvVgwY9OlhbVSbSjvS00OcilAYt3Raf4k9Cyauhzz/GUjrzPVg/oABMB1JOCyv19PbiqAIjNtI3luFjE2WIr6oh/NRnd6flFpA3tvuqyMcd2wwA5KQOXj28ap2VxLAa5Kg8EoUbgXSVLt4qSRRH4ile4zAxCEKwckP+9lp600jpz6T4VLTDQphpAwKDz3nBzAw9oi+njPs2GBBLV/x/RNQYHZStnRgaSSSy9VEFrRa+qgHmCEAlp/Uy3H5t2VpJHFqZSoLUMUl5sBdX7YM0s44bt5sX8Jv0XTzD+tnh9BFhMKqRnfl17WrLhGPR3lOoxUhsakBbZDCOe6deJ99AEZqa10mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(66476007)(66556008)(508600001)(66946007)(31696002)(956004)(31686004)(7416002)(36756003)(8936002)(6486002)(2616005)(8676002)(53546011)(83380400001)(921005)(5660300002)(186003)(26005)(2906002)(16576012)(316002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1cxaUhXUUZzbldOS3dQbmpKSEU4YStLSS9lWmlSWmppMG5VWnZLZnhmdENn?=
 =?utf-8?B?Q2lEb2RSazVIK2JEZHlGNmJHdGdVS1IxZjU3c0lzY2tTbi9RYlU0eFVXN2tG?=
 =?utf-8?B?UE5CVkMyNFpIY1lzZDZCcXNiK3drN0dkQnVZZHB0emc5cndvMXZndWpoS09a?=
 =?utf-8?B?ekFuQjBXODIrM2R5ZGVMNGl6Tm8waXg2b1dmZ2pVQm5Ec0ZZQW9IMUd2b3I0?=
 =?utf-8?B?Q3prdjZ0Q2FaUmgwSFlnZ3prOWd3L1hmek12Q2p5YllOMnhKTitIay9zOHhD?=
 =?utf-8?B?azZ2ZUlmUVM0NFl4YjJ3U0ltWkNKTk5rNGRRZzBnL2NQeHlqRm9wUUsveDB3?=
 =?utf-8?B?c3FQbEVvMDlocnZ3aHJrYmJmSkl3c0dMUTFMemcyWjkxVWp0d3BXNGVLWG1k?=
 =?utf-8?B?a3BBOU82U2ptU3pOVExZNGdUTnROZ24xSysvZnRBaUhHWmFFdUUwa1lLbzlE?=
 =?utf-8?B?TEdQajJ1bU8xbEpCZkIyc05NeTFBZWhLcEUvZXRjWmFqK3RNZ0hndzUybzAz?=
 =?utf-8?B?M1M3b2tEa2dqNTVpWkViWFJJUVhWUjJzOUdRNDVTWEJNZFgxNnNlbEdyQ0sz?=
 =?utf-8?B?UjY4bHhRcm9IcjlDdHgzSDdEV1ErUkhQR0k4NEY1RURHc2tYZ3dLSStQdjIv?=
 =?utf-8?B?NW0zODBGQU1zTU5GdUNON1Q3YVRvMUNaOTJPTXltOHFuQldMMTdydVY3KytO?=
 =?utf-8?B?Z3h3MmZ5Z1NqYUR5WFdkMUc5eVI5Z1FxTVpjaXNrVkp0eGxCd01CbWVnQVVx?=
 =?utf-8?B?ekFYanVEd3JjZWpCQnVQV0I4M255eWwzeVVNZ2N1ekFWaVAwa0orTk9QNTk1?=
 =?utf-8?B?VEo3MzNkdHgzZjVZYjlZZTB4STNyd2tBZVdrUXBadCtzVHduNXZ4a3ordFNJ?=
 =?utf-8?B?dHh3ZlRlTmFFcXBEb2cyQ280ZVljblhRYzY2K2VnbVFJbHA4VU9IZlJIZ3Ja?=
 =?utf-8?B?OE9taGdxZ1cyU09vVVk5OG4vcVNpdzYvZGhodXlmaTZRT1c2MGFPSUZwUG1m?=
 =?utf-8?B?QjlSbk1RZWRjL3czbXh5TC9FL3RqRGJXb3c5bGJQMlg1RkVTWmFrR1JuMHRm?=
 =?utf-8?B?TWhsSU5SMGprSFU2OWEyV3VXejlmMUs4aEM0VVFsdHZvWW9iZklRQTRqSDky?=
 =?utf-8?B?bU01UFc1aFhlOEN1a0xLR21Dc21NOTQ0QWtlTzF2enpRb3NRWmEvRVB1K3gz?=
 =?utf-8?B?ME5oOVZabDBZbDJpNEVuRC9FNEozRnRmMDRKc3l4dG5oTC9FTndOdm1FdHFY?=
 =?utf-8?B?QjhCWWZDUzFzNUdFZGtLQnNKTHlsaVZrODRsZFAxb1pXM2JvQ083Um1Rd2NZ?=
 =?utf-8?B?d3FXZ2svczZ5aXBVZHV3eFFDemp4NExGbW9jU1dEbUpMRWhPNTdqQmhpWVo2?=
 =?utf-8?B?Y3Jid1dObzduK0lhek8wbFNEZXY4YWFibmNpZDdULy9VYUp6Vmd5UVFJYWhS?=
 =?utf-8?B?cFhudEIxVEM0R1VvdXM1VFJNbjFJTjhMSWdiRUIyQ0U3bTBOMytlZ0VFeVY5?=
 =?utf-8?B?UUwzMExjamU4c1dEU054ME1MR2g0NzFkSVkwZDd2Y3pnMld5OXVoMnZBVGtP?=
 =?utf-8?B?NjY2N0x0ODNQYk5VQ0cwTG5vWmxmV0lMeTdQNVNaZEs3dURDR1k1MlNRUTR1?=
 =?utf-8?B?eGdkVklqUlRZUGRzS0YyQm5sNWtkTE1CYXl5bjhSOUNTTU9sRmdPWFQzNDBT?=
 =?utf-8?B?ZFQ5VUlIRVFtOEo2NXhoYVdKbnVFUVJpMk5sUGdXTUdxTEtYK2w0MlNtTzlq?=
 =?utf-8?B?cjZQVk44L1N5azg5NnBXdWZGbjdmYmEwMm96S2E5dERSYk01dVlUZ2dpRC9Y?=
 =?utf-8?B?YW9MQXpEZjdoNitUU3U3aGxRK0MycUczK2toVm1IYURWZDhCT1htQkpxckpE?=
 =?utf-8?B?TXFpR2R6Y3lUTm5STDdBT1ViTzVnU0toOTkrSjZ5dDM4RGljYW9FQXN6K1lO?=
 =?utf-8?B?UU1wQjBvQXdDSUI4eHpaNGROUDFRZVhMdVI0d2RLRE5KRFg4SmV5V2FOSDRo?=
 =?utf-8?B?elVGSXNXditNTWFwMDRIQ3RNZ1dJL0xUN1ViUElqMi9SdTgwTFhTaFZKZXBW?=
 =?utf-8?B?TDZ2MlNqaTNZQlhJTklhVGdRNmIvY0pHWmNZOHh1TVNyNm00OG83WnVCWVM2?=
 =?utf-8?B?dmtMRCsxY2ZiRjBuWXNYK3pjSE90TlJSMWtOSHBLZlJBd0JBcTFWMnpLR1JN?=
 =?utf-8?Q?NqtxDZZ7lQEaU65IxVc11hI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9a7be7-a970-42ad-edcf-08d998a983c5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 17:53:28.0075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2jqxcREy+0sesiWJAFaKwpYSxqy2OJJ62iwrcRXZHAO1xHI4ZSOQGvQKJpJaZ8WtvCL5/7QFjvrirzVFr5nJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4925
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/21 10:38, Pasha Tatashin wrote:
> set_page_refcounted() converts a non-refcounted page that has
> (page->_refcount == 0) into a refcounted page by setting _refcount to 1,
> 
> Use page_ref_inc_return() instead to avoid unconditionally overwriting
> the _refcount value.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   mm/internal.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index cf3cb933eba3..cf345fac6894 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -91,9 +91,12 @@ static inline bool page_evictable(struct page *page)
>    */
>   static inline void set_page_refcounted(struct page *page)
>   {
> +	int refcnt;
> +
>   	VM_BUG_ON_PAGE(PageTail(page), page);
>   	VM_BUG_ON_PAGE(page_ref_count(page), page);
> -	set_page_count(page, 1);
> +	refcnt = page_ref_inc_return(page);
> +	VM_BUG_ON_PAGE(refcnt != 1, page);

Hi Pavel,

I am acutely uncomfortable with this change, because it changes the
meaning and behavior of the function to something completely different,
while leaving the function name unchanged. Furthermore, in relies upon
debug assertions, rather than a return value (for example) to verify
that all is well.

I understand where this patchset is going, but this intermediate step is
not a good move.

Also, for the overall series, if you want to change from
"set_page_count()" to "inc_and_verify_val_equals_one()", then the way to
do that is *not* to depend solely on VM_BUG*() to verify. Instead,
return something like -EBUSY if incrementing the value results in a
surprise, and let the caller decide how to handle it.

thanks,
-- 
John Hubbard
NVIDIA

>   }
>   
>   extern unsigned long highest_memmap_pfn;
> 

