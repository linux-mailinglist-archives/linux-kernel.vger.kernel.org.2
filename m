Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A0D4310CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 08:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJRGto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 02:49:44 -0400
Received: from mail-dm6nam12on2051.outbound.protection.outlook.com ([40.107.243.51]:6486
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229533AbhJRGtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 02:49:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHQzGeHNot2nUTW0PPTMA5BlI3CKmtBZAJO92Igh7ovTLgq8zAvTaztx5WBlDg3t9iEtbxa9mt2TOlqsBUENys54uBYUE9lyYmADPSjeO0I1KzwvwR7KqM1U96ZfuBEyn3j1/cPfSAk9E6KJRsUxG+W8sGpR9uLVfS0vhz9B3YBRGF2axtcmxLGLQOfd4Zg/U13xGAvSL5ENozj0Ofi/u7uxqXSWGMlhs2yXktUEafy1qQPS5fnEpCEVXa1o7tyze7dprb02nuXLwWEQucX69XTlxOrZK16lq/+HylUuiH/8NWKvw/xtCKXiIyJQpoJceQFASmqh5z53k4ZAgQ4qxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuGK21jrAnxSXWn2rpJ/swOMfgpSCFR1Xbaul+F8pv0=;
 b=ZpBQSFCTC8MxXWJchHG3f9IxEaHqZoIfNfHpxODXiB44/Lx44bX4LAQcaOrxMuZKel6Rgokr0XlLIx+WQVQRt5VVzMlFhc4D5entl7747kknk7XEQb1rHE5O2prklapM28nzqnTPtL+rqUAIxEnIBm2iig8qAABrZewbeV1cGZiUSfQzKWv1haa3rMgEjFAmD5uNgTupVBim9Ym2YMeLUlB71fF4dlJpA2FhHnnbLN6kBU0CWGUw84LzuUZ9AjStEnz4A7HBzNlAOAAmIT/7BmNLEUZfSFf3lwVvcWvFmOXNFRE3BJWStebLodWsznycG7hqDfupQvFL2RekF2jgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuGK21jrAnxSXWn2rpJ/swOMfgpSCFR1Xbaul+F8pv0=;
 b=J+xKZ2vHSANiG/9Fcv0AxJ9RDtstqSphhehnfxdAzMSHUNpvLFGP8FO/7RNAt1b78LAH9m876uQQCtqYZOOYpJDlS/VgaXC/jo/OfXMCELnB6TH06eASb/QVgzMRRa73QE0imcSiPXAkPsSf3lL5hgpD5da7ncT/IiBkkOFBPmtJGJQPmMbCxUkIGc2rWdcEI3H3vPsS00M7wzzENqUjdaqRxsJKz5xIQA/j697wXXmqhCKqBRTBdX1d1IMe0m8YR3zzTo2/n8PsTzjrabSaPe6cc/XC1qufufMR4KbD7qz3wy0gWcKuXPCzBEPRz2Q7ZyyFgtCHUAbUcsI7a6DpkQ==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB2919.namprd12.prod.outlook.com (2603:10b6:a03:12c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 06:47:30 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310%3]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 06:47:30 +0000
Message-ID: <a8da9ff8-b612-c5e1-54cd-a975f9075dae@nvidia.com>
Date:   Sun, 17 Oct 2021 23:47:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mm/rmap.c: Avoid double faults migrating device private
 pages
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rcampbell@nvidia.com,
        jglisse@redhat.com
References: <20211018045247.3128058-1-apopple@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20211018045247.3128058-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:40::41) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.57.126] (216.228.112.21) by BYAPR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:40::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Mon, 18 Oct 2021 06:47:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ed4fd07-f4a6-4890-e487-08d9920327bc
X-MS-TrafficTypeDiagnostic: BYAPR12MB2919:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB291945D64B97AB39B04A981CA8BC9@BYAPR12MB2919.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WmwFjxg6EePifaRQG4MZQN/L8AXMbIu9RikIM2vLiRamcGIAfdmb/1VNR1ZuXx/0j/IOkNIkM0x8SwQOWIEDOk+IuipFahJLPUXd2ykwG19g7TDeWbe/FeSUAwuLfSLKdbdFp3BbfbZ9eCItIFdw2OJjhs/eoI7PC0zoEhIuLGbnZSsEljjDnnSZt8O8ukCfYiT1m0ZmgE3nqMu6+G9o0GvKisowDxnGYX4CbkO3JiheWgvcOeYSH4MqnmNXsfH71F4MKeQA2NS5uRAe8s3FudTwXQQNf3f9zfzmpqVfkUpEclsSp4s4SeEmdEm4CZSM0UtzQqqUP//KiBE1/b9/MEKTNmPwnEmieLEwB8cFqjC1cdbD7d8I6titOtUXd+FWtAun37MyfkxhsPowwxe/vGr3dqku2pYspfI81n12gdblEtFkPDjqkOTaNyxTE4G+/St0GFjvI032fZtieHE+3yXXmDkpameLpea2H0C5cDUQgP0+ESQSISb+EKLBjLrSUQRhbJueBHOWuKEG72IwKCMGlnA0qZTT0j9B4AmdSHKM3qVsUeigp8jsI0ymtkvRmrN+EFSxSmDOFrtqr2aHBsrhMmQljUONY+sKzSgphKZZrxt6y9lcIlSpVXgvaxKXP1PEl66LdsqJA2mlApcqk/ua9Qewky1DeSbBdauYgczBd8AldzHDU2gfMmagkceEHiVFq2FJk5wTsonjd5weMTsAyu+sOjNW00+3wd0Fi8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(83380400001)(4326008)(5660300002)(66946007)(508600001)(36756003)(6486002)(31696002)(2906002)(86362001)(31686004)(316002)(8676002)(956004)(8936002)(53546011)(66476007)(66556008)(2616005)(26005)(16576012)(186003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wlh2eFVhNVZ6VkVDUlpYd1l6R0JBWG1GLzhOT2NtRGh4dHVYd3J5MTB6bkxE?=
 =?utf-8?B?Q05jbjdkSHVXYmZwMmFBUzlUMGRMVFlsLzVxUHRiNVVOTGJwS1ZPVDkxWWJD?=
 =?utf-8?B?MkxnSHRneTRwanNIc3pXc3BlTVRPU25rTENPSlYyY25kVlo3WDZ1eWtiOGtm?=
 =?utf-8?B?MWE3OHVkbDhrVlNETEZmYTl3MWNqaDJyMk56T3QwNW9QcTBCQWE4M3JHc2hj?=
 =?utf-8?B?YzYzd0VXUCtwUUcvT3hJZkRBSW1QOHlxb2ovYzk4Ni93S1ovdkZ2aGhJakFw?=
 =?utf-8?B?MVk0T1poY0lQdWtCdHgyMjhyQmliTnptZ25TemZZTmoydDBCZWM0dkR1d1VR?=
 =?utf-8?B?NldpdmpOSVlaZ0dmZEVaZ0xJOGx2U1U4VGgxOEZwZGJFbnBGRTlIR1k4cWtq?=
 =?utf-8?B?cDQ0REdOcGV0a2dJcmFRM0U4YnlvWUhGNTZUNlRVazM5akRvMzRpblNjemo5?=
 =?utf-8?B?dzgvOHJzNnRjUmR2YUdMYXpib2xtbXhBZ2ZsZ2RjMGRJeTFoYjJ0T0taa2lu?=
 =?utf-8?B?a1NGWW9VZHNQNGdJaFJTbTFueWVGZE1qWlVJTHhzZmF3eW9adjJmRitwMXZz?=
 =?utf-8?B?TGlPdkNuc2VUcG5ZMzQ3bXRZNUp0U0FJZlFncUIyZlVnWXhDMk5hWnRGSm9a?=
 =?utf-8?B?eTByMnhrZDd1L1JXL2ViNjlqUmpQVXhZT1VpaGVqeUFTcHBvSjh2TGNaclRj?=
 =?utf-8?B?M1NGRmxvQjZXdEhwSlNjdWJoUXBBVXAxWE1ldEd1ZE10UUllMFA2SFkzMjdy?=
 =?utf-8?B?N1hTcHhEVnRqYVZRTEJMNG9rdEI2ak9kWFBsWmdLOWQwQXZZdyt1bC9MSGZp?=
 =?utf-8?B?ZnZMa3JLdGpaZ2VyUit3WFR0TEsrL3o3VVpYTGNrV2Z4bjdYWVRRZmhaRjJ5?=
 =?utf-8?B?TGVoM0M1SWEwMHRlSkd5b2VNeWZQTG1yTngwaGQ4b08vUDVRcDA0ekJEOEdu?=
 =?utf-8?B?VjRqbFNuM2VSTDh5WjFzU1VldFNhNVdYajVrbkxoRWpBcWdyLzhaWVV3UjVu?=
 =?utf-8?B?UFI2S3ZoZGhyNnYzZExBaWZ4djdLZTJvYmZzTXJ6aTU5UlE1L1RLSnQzZmhm?=
 =?utf-8?B?clFFVjJPbUNGS21ZY1RVcWxVSTZJcTlrVDJwMG1BQnJHNDIvTFUvVDQzQmt1?=
 =?utf-8?B?UHV5WjNxL0h5Yk5tQUU5VXc3QklGeVZZdm5nMmp3OUZmV2hTenBSWnJ1QUNw?=
 =?utf-8?B?aG40d09IODZXVmkyR0VtKzRxRThUeUJmZzdBOHNUQzBvVWRGWmVxa2w4ZDMw?=
 =?utf-8?B?L2RrTlhUU2toNzhaKzVmaThTU0owbm4rcWZSU3JDbGIrSWZFL1NMbGc1dlJ0?=
 =?utf-8?B?RHdrak52M0J6a3hjajVnV2VoY2w4WGh5WDdNa1c0b2JHWlAwM2hmaXgycDFv?=
 =?utf-8?B?cFdoaStkQ0c3cURRYkFRaVkrZUtsMG5LYi9UeUlSem4wZG9TaWwrVzh5SkF1?=
 =?utf-8?B?Q2VkNUlZc2VReE4zZFZZcE8wckJ2RjR5eGZ4NEVmeElFeHNMcG5BZkJmbWk4?=
 =?utf-8?B?Mm05YmcvZE9EU1UreWgyemdpOFhKSHVBcStNRnoxR0xpc1RTcnpEaFRZTzQ3?=
 =?utf-8?B?azhsVlNKQ0lVU3A0RGhDNXU4UkJvUldReEhFaTN3LzBFMHdmbEJwMEhYZW5T?=
 =?utf-8?B?UmNHZFN3WmdDblI1WmRLdWduYnZYUWYwbU9GQ1pzK01rREZHZGF3enQwVFFq?=
 =?utf-8?B?YWVta0dKOFNtalNpQWQrSlNPWncvcmxLRzhnYnpOZTFqZlRuS1lVaVE4UXdQ?=
 =?utf-8?Q?s9FmgTpwGWZ31bZIDljK6b/qvoUox2rPsSrlmjh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed4fd07-f4a6-4890-e487-08d9920327bc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 06:47:29.9789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5HmALVW0O/++/wKwzk0KWfpNCWdIUQVtokpmuMGDpbeg7ODwq+Dg9+khREV8VBdwxT5/tNR9ELUbA2s6JQcPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2919
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/21 21:52, Alistair Popple wrote:
> During migration special page table entries are installed for each page
> being migrated. These entries store the pfn and associated permissions
> of ptes mapping the page being migarted.

s/migarted/migrated/

> 
> Device-private pages use special swap pte entries to distinguish
> read-only vs. writeable pages which the migration code checks when
> creating migration entries. Normally this follows a fast path in
> migrate_vma_collect_pmd() which correctly copies the permissions of
> device-private pages over to migration entries when migrating pages back
> to the CPU.
> 
> However the slow-path falls back to using try_to_migrate() which
> unconditionally creates read-only migration entries for device-private
> pages. This leads to unnecessary double faults on the CPU as the new
> pages are always mapped read-only even when they could be mapped
> writeable. Fix this by correctly copying device-private permissions in
> try_to_migrate_one().
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reported-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>   mm/rmap.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)


Looks very clearly correct to me.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index b9eb5c12f3fe..271de8118cdd 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1804,6 +1804,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>   		update_hiwater_rss(mm);
>   
>   		if (is_zone_device_page(page)) {
> +			unsigned long pfn = page_to_pfn(page);
>   			swp_entry_t entry;
>   			pte_t swp_pte;
>   
> @@ -1812,8 +1813,11 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>   			 * pte. do_swap_page() will wait until the migration
>   			 * pte is removed and then restart fault handling.
>   			 */
> -			entry = make_readable_migration_entry(
> -							page_to_pfn(page));
> +			entry = pte_to_swp_entry(pteval);
> +			if (is_writable_device_private_entry(entry))
> +				entry = make_writable_migration_entry(pfn);
> +			else
> +				entry = make_readable_migration_entry(pfn);
>   			swp_pte = swp_entry_to_pte(entry);
>   
>   			/*
> 

