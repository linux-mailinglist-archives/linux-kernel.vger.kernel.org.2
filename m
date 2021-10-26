Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8512A43B8E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 20:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbhJZSEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 14:04:31 -0400
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com ([40.107.243.72]:9825
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231671AbhJZSEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:04:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyV6rmj5fhEvddNS63DTmfGmAeZwhIWG2NRCMDep8UZuluQb0BMXtUkuIiXKCm6mVDIkQrCX0EXAk3KMZHoJFRcsijnFnEPpNmMTLT4EpkBNJ/kvcVXWbvpALLm2Sn8eZMTj8WeUVb7k881vXr/XR0rYRovafXuCeSNVp+mnRvJVvUXs0usLdjVUowPs0rRhP+7U/Gkb6oS4K2B51JQs95X2bYP6+n+FD9qcei9rPUkzJ67pjov5QsQsqIa5tmZ1UBo2mwQ5BYCriL622K8lHDZI08nmO5fbPr7WEdlJWAVyCEprL9h/PbfJ8h93pFuslpr/+4JhsiA1Pjz4PX5zCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJlE4lXMmnMILK7QAF+6u/2/LHJJofZ0j/OptydVf+8=;
 b=lO2D4z5msZUuKy/+A8uNelRYy3+7dykh4zauGfuqcL9cRrOUz3g9PjUYxxLLSCN3O8DIiya6lctJnc85pO2xu1cg7DNh2egY6MWBEgM8aSCVzwgQKHOfn8+kUYtzZynwT3oxE2OMA8QbrQ3L2y0i3kk7ITBF980a9ZqdkFBroA+RKLHrFnwTi9DCxvqGIzcyNdpp7DwXZ5KXMuap+LFlFCMqFkjqRglz9hb85ZWP2HTvOa3u8wyvV0/C/JAIci8S/ODridAaRkDC4V9fTrNQrjGIYkrF+YGeklRtpkF1EW+QroF67b4dSOHQHxoXWHqtCxACUQG2ZByKQtqaPUa8gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJlE4lXMmnMILK7QAF+6u/2/LHJJofZ0j/OptydVf+8=;
 b=Oe0s/fx8srZ232PmFOZG6O7z2lJ7Xv1UB9w/Dwl4Zt0/O4SVmNN7gc5y1nWGpNKAZxmbApIcf+t+QmWdtE4GMMUpjhWkR+BBbvGZVrJ5uWkbEpSvs38V7Q+2pztBc011A87YAgEwg3k6nE/LtsHj6ZPHjxe9jZO6oxKtNGvBNROVwycHV/7hpnfD0OFCqVvP3nPnEeBmHb/Xs6FKpfMce3m8NfJrdota1IAnwJOGD+QsljvOeWPnHHETSPZvdPXo0zkWD9odvvZ0PcH+IUZkSUhLIyCxBFj2ylXX9dORj6n7t/xaGATuzlZ6WdPbXcBnUWBuMLTCpzKngnqNFvkFLQ==
Authentication-Results: soleen.com; dkim=none (message not signed)
 header.d=none;soleen.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 18:01:59 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::4971:dc6a:3ca0:aa25]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::4971:dc6a:3ca0:aa25%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 18:01:59 +0000
Message-ID: <cbd20bc4-84ee-fd39-875b-75426bc61219@nvidia.com>
Date:   Tue, 26 Oct 2021 11:01:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC 3/8] mm: Avoid using set_page_count() in
 set_page_recounted()
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
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
 <7b131cb1-68d8-6746-f9c1-2b01d4838869@nvidia.com>
In-Reply-To: <7b131cb1-68d8-6746-f9c1-2b01d4838869@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::32) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
Received: from [10.2.61.40] (216.228.112.21) by BYAPR05CA0091.namprd05.prod.outlook.com (2603:10b6:a03:e0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.11 via Frontend Transport; Tue, 26 Oct 2021 18:01:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99e99571-7f55-4729-2721-08d998aab47a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4467:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44678611AB7487068AA09894A8849@DM6PR12MB4467.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6QrXdXTIKn02WobRFUeRLI6s5B5RdCXZZckYovRpGmHGcR1J1rTmr5yLLs3/2rr8o/Nt7vFNYyPi0So/kXtwPRQn0OGW348hD94qI4O1eVZBFwtrXtCcPn5279+E8gegHWlFGAjfaXYRj8ij9I79evxF7PE+XOULQYvSyoDqwbQYmISz5FfXD1TOdbTRuAZerWSZye60wWUFAf4cSUuj13HUAmtTQY249KMK6G8eFZcGnji2JSUEcfVLC4WDQMXGUsFmRfCzKOre/nCpwcfV3QBRdCAhPI63npqUM0U/49tGIPax0OAeYKxxrdZi8f2z87WeHwUm1zOWut/RZH6fCAz9C0qfpsI8423pxx8/j9axmzUv/mog0ThkCXO4/qu1d8qYwWhM0vzLZNxqF16UZ0Oz1lZR52qsgWFrNzRRD/kUz5px7//SO/T9qaHeuX0nPuzkwfLiknmphCHRvA8CK8BJxadpZsbwprVqynHs14sVj930TMmP1lIujOJ/cSWxO6ewJSQKyO3HCBvRL8zYZQViy4gvfJePPlzmPCk2TV08j2seErhbUVHPZd+2H+/O2gVk7jROIdGINEj7erZ8D21HaCSdqx87VeyN/qGBp7H/aHkQJ/9zSUUAKFwaF/Wl7VMWD+sNBBpQNwEpYDL8OKPyoYg5GmRnDy3gxlyKZbl5UHYpfkN9j/CSIoehB2amMhSoyOSRu5Z0P7JvA6PrIg5fLFo9YXyUPnLo5+JILgVbB6OX4xY+hahZNfuIOVVxCk/ew7Xm66tNweUq+idJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(53546011)(921005)(83380400001)(86362001)(6486002)(26005)(956004)(7416002)(2616005)(5660300002)(8676002)(31696002)(2906002)(16576012)(66476007)(8936002)(66556008)(66946007)(36756003)(316002)(508600001)(186003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUVSN3Q2WStsTUpiUjMyaUpuT0tteDFidXl0M052bTUwMGZxNkVlU1lLZC81?=
 =?utf-8?B?ejB1d3BSaU1aQVcrWFJYWGl0cElEak01czRPU1ovYzArRlVNQXRmRWtOd1A2?=
 =?utf-8?B?UVREZDFJc3grVTRHam0yZDJwbU5ia2tTVStLellUSU9oUUh6K2lVVGdWOFEv?=
 =?utf-8?B?dGhFNlRhRmtCdXRHdW41NitqNk13MEQ0cmVyQzJvQkorSmlXSUo0b1lWY0dM?=
 =?utf-8?B?RFBmYm5oYStzZVh2MEl0Q0JxNGZHMmJuQ09pVjMyd2xmWDA0VUMxWkRFZUN4?=
 =?utf-8?B?S3RtNEZxZkMxazdmcy9KSEFiUFVBSm45ckNtVzRLTjgvcnF0U2swUFowRlov?=
 =?utf-8?B?eEJWM2xHWkM2aGxGNG81b1pvOElnSEFmSDVXWE9ucytqRy9tQ0FmY1dRVFFY?=
 =?utf-8?B?T05Xekl2Y3VMQnp4bFZHVDAxL21ZdlZSc29KRHNjZWhnVm94K0JLMFVhdHdn?=
 =?utf-8?B?ajZjU05LMStKWDFjMkk3dTdnWVRBQytVYVVhWFhheXN1bGRZeG1jaHhBKzhk?=
 =?utf-8?B?UTlCQVJNRTQ4cVpFQzVlQmMzTTlhMVphOXJINUF0Qkw4djAvcTVPc2VJci96?=
 =?utf-8?B?dXRzUE5rMjN3U2hTaTFmcm1HODFmUGtmVWtzak5EaE9OWmFvVXoyQVdCM1dN?=
 =?utf-8?B?cjJFem1MOHZ1SEYvaDBtR3lMWHNJaFJMc3A0aVZlcW1xVVZZUXpNRjE2TFU2?=
 =?utf-8?B?QzNtQnAwem1wMlFlemJJSzA1Nk92VW8rc1htS2ZrUXdWbEJsOUQ2bWphMFM5?=
 =?utf-8?B?ZGtyUkFCaGpqOXozVXZOeWhUSjZaak5pOC9URy9ZbFNiL1FEa240SlFZem9H?=
 =?utf-8?B?UHdGT1Y3czJ3TXhUU2xNRjBacW44dng2SDBwZ3pzajZVL2F3dzg4T25mTHFG?=
 =?utf-8?B?REloNFZaMFFBWW5lb2N2RWFTLzRRT292cDY5VGpMeEtSVDQ0bDhFMGVEVzZD?=
 =?utf-8?B?anZNWklZdDh6Z1RPTDRGbXRxbzdSdDB5V3ZIVXlOZElFVWhiQ3dUNVlSMWlP?=
 =?utf-8?B?M3prZUdGS2xDVEVLQjF3ZTJCMjFoVVVMZE1FY2dHUVNvN2NUeFJuV1d4Wkx2?=
 =?utf-8?B?T2dyUS9OOWliZlArVWFlMFNFNWVMU0dvQnJlbWhXdHhIb0Nld3QyREJIYi9a?=
 =?utf-8?B?OE1iZFlQWVgwMCt6dDg3anY2R3ZWUXljYXJVd3hNMUNiMEJWUHJhUENLUWZX?=
 =?utf-8?B?RE5oNWx0WXpMQUl1WE56RGV6dG8rMzN2OG81U0FLdTBMcURSRnIxbmdkR2hG?=
 =?utf-8?B?R09USzVjSk5SMldEWGkwS0VialNrZGNzcW9GeWNQVndBRDZUUEdSUkJyTkZZ?=
 =?utf-8?B?WHEzUGdlQU9WbUoxRmwvV1VBOXpXaS8rbDU4clU5akpXRjZQSDl0QVZIUjFX?=
 =?utf-8?B?S2xSZjl3Nk82Yng3enhLQ3NpYjNSK21pL1l5cHUvTDNTaWxmenBrTUcxRm5R?=
 =?utf-8?B?RFBaNGtUcGo3Y3NvUzRVNCtGbDN1Uis0TCtQZVhjL3Evdk10a0RHYStlOTJG?=
 =?utf-8?B?TmZ4cmF3UzVIVnhnUGM1SE9DMjZxS2tiK3pjazVWRlVKMkFuR1A0aDIycCt5?=
 =?utf-8?B?Qm9ma3BTNFZ4cGxDc0NzeFZBeUVSTVJuMUxQYlFlNFp3YjNUVHJEcDFJMk5J?=
 =?utf-8?B?bllZZUkyZGhzbUI1a3ZSNkZzVDBIaThnNDlFZk5YTnpzS1ZuL0NFRnNvdDFP?=
 =?utf-8?B?VzFIL0ZkeWhBRC9GYyttSHRSWllGeDRLVmkyeDMyU3hJY1BFMnB1QWdwQXpJ?=
 =?utf-8?B?SlZBdVBaTGtDMFRCZlYzRWtTUG9WTTNqNmk0TTQvQmdxdm1GbHg3dEtCa2E0?=
 =?utf-8?B?cDQ5dS9iTmE0RlM5dk9ESis1WkRoejNSdVMxZHBsV1Vuc2xVNzdtZUN1ZlpO?=
 =?utf-8?B?NE5pY1NKM05YMFc5K2pwcnFwUDBWTnhsNGRta3JXSnBMeTEvQ3o0UE9nSTVD?=
 =?utf-8?B?azN6WlpQempJbWpvTzlmUVNMRE02OHpQajN3QSs2cUplcCtsTFZjZU5VbXVL?=
 =?utf-8?B?Q0lDOVVqSjU4VzY5VlBzWXQzRkp5ZVNXZVI1MENENHNYQU03L0ErWHV5dkJj?=
 =?utf-8?B?ZnA3RnQyM2tIQXVTN0pqZzVmQzZQRHJEa2dJUVJFNWFjZ0pGRGxYUWpZcnRL?=
 =?utf-8?B?V1JCSWVmb2pxTEdtT2tzbzV3TEE4cDVMY2M2OXJVUkZUTnhBbmZDSC9PUWU3?=
 =?utf-8?Q?l3Sji/que92UDpuYh/ZD25s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e99571-7f55-4729-2721-08d998aab47a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 18:01:59.1154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYYo6pE6i9vp70RFZWq7ORV3GP6sTuoCZYZ4hdgSOE7UZnFR+veMpa/RxKxs1ZJTrqKplgRw1Qy7+HfB/dV+xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/21 10:53, John Hubbard wrote:
> On 10/26/21 10:38, Pasha Tatashin wrote:
>> set_page_refcounted() converts a non-refcounted page that has
>> (page->_refcount == 0) into a refcounted page by setting _refcount to 1,
>>
>> Use page_ref_inc_return() instead to avoid unconditionally overwriting
>> the _refcount value.
>>
>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> ---
>>   mm/internal.h | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index cf3cb933eba3..cf345fac6894 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -91,9 +91,12 @@ static inline bool page_evictable(struct page *page)
>>    */
>>   static inline void set_page_refcounted(struct page *page)
>>   {
>> +    int refcnt;
>> +
>>       VM_BUG_ON_PAGE(PageTail(page), page);
>>       VM_BUG_ON_PAGE(page_ref_count(page), page);
>> -    set_page_count(page, 1);
>> +    refcnt = page_ref_inc_return(page);
>> +    VM_BUG_ON_PAGE(refcnt != 1, page);
> 
> Hi Pavel,

ohhh, s/Pavel/Pasha/ !

Huge apologies for the name mixup, I had just seen another email...
very sorry about that mistake.


thanks,
-- 
John Hubbard
NVIDIA

> 
> I am acutely uncomfortable with this change, because it changes the
> meaning and behavior of the function to something completely different,
> while leaving the function name unchanged. Furthermore, in relies upon
> debug assertions, rather than a return value (for example) to verify
> that all is well.
> 
> I understand where this patchset is going, but this intermediate step is
> not a good move.
> 
> Also, for the overall series, if you want to change from
> "set_page_count()" to "inc_and_verify_val_equals_one()", then the way to
> do that is *not* to depend solely on VM_BUG*() to verify. Instead,
> return something like -EBUSY if incrementing the value results in a
> surprise, and let the caller decide how to handle it.
> 
> thanks,

