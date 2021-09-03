Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0383FF94A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 06:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhICESy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 00:18:54 -0400
Received: from mail-dm3nam07on2041.outbound.protection.outlook.com ([40.107.95.41]:32800
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229561AbhICESx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 00:18:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/u6p+RL4epfnVwqV4U2tTINcM0xEuIIzH5t6g4T46zWwnh+bG+srYLCRPwy5pyqsGD3esUEODERgUlW4zHrN7KlNVjFNWwGuJx0ks/q1r34a3pxkZiMw3FJSb0a/0vqsi5SUOQLBfckfmlHW7BCXJSpLdKVL5sYHTEp6YWfiu9VkX7RP6JsTVxkO7bQlyF2utwHSFJ0NooFO8CiKUevqzeR0i2/vVttOWy3suQDiJUUi51myTWVlVKukNzNx2auzGq41LpEhkCZa40Ioj1wZMbxrdL3MkxYysfI5sjjPLbmYsDILk3Dtjwesw7546X0aDjh/m64hjAUsqES2LAVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QslqGIaFrPoQy6qFgeFjGZgAFPDBT7bNzPjLxkxwCdQ=;
 b=BLSQZ7jbXhMfZPHrSTtDSCmSRv6xUG4D1kOhL07U703XUOmpjwUcQiVxrmeYIC/Er30C+I5Ma0M9Drij54I5juAK2s7MScAU4C25z/4ZSQeM/aU7ZQZpYjNyekodqV/RYtN61gOVxKKBRZMV/RxQHlHE375tNqU935uEWjq4EwgKR+FsufgZG/s4wbu+dKNf5BAw25b8HEUA/bduPpyNngf5FBZKxzgwSpDaXod5o6wrfmVVZD70n9JIk7jlyR53MzJ3a1pwTzA1KxHMers6yzEdUk0zemXd44GU1W3mCU+u5MKBRLA0w5Z80l33ymfLhGFOBPZsaVeArsrhZx6D+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QslqGIaFrPoQy6qFgeFjGZgAFPDBT7bNzPjLxkxwCdQ=;
 b=4SsLA/JxrBCU4fyw328TdSe1H37br3KVWZvhpAuPDGSVcvL4LXGhdWGuvL8Rg5+kOI0XMazQr4PqYNFn01Qj2aefcnva9bbKiFaf9gTcgYJQvSM8gfjruKA3xW5olCRz2ow6fPAYgtvhznkLfggu1JRlYXZCXL2Kxz8uqHI5U4Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 by BY5PR12MB3716.namprd12.prod.outlook.com (2603:10b6:a03:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 04:17:50 +0000
Received: from BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::d835:2252:aefb:e3ea]) by BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::d835:2252:aefb:e3ea%8]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 04:17:50 +0000
Subject: Re: [FIX PATCH 1/2] mm/page_alloc: Print node fallback order
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, kamezawa.hiroyu@jp.fujitsu.com,
        lee.schermerhorn@hp.com, mgorman@suse.de,
        Krupa.Ramakrishnan@amd.com, Sadagopan.Srinivasan@amd.com
References: <20210830121603.1081-1-bharata@amd.com>
 <20210830121603.1081-2-bharata@amd.com>
 <b0c3c57b-1649-1466-b503-b42ddc392c23@arm.com>
From:   Bharata B Rao <bharata@amd.com>
Message-ID: <e37f46f6-3d24-03d2-51c6-28967bef0784@amd.com>
Date:   Fri, 3 Sep 2021 09:47:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <b0c3c57b-1649-1466-b503-b42ddc392c23@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:40::24) To BY5PR12MB4289.namprd12.prod.outlook.com
 (2603:10b6:a03:204::14)
MIME-Version: 1.0
Received: from [172.31.33.28] (165.204.159.242) by BM1PR01CA0130.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:40::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Fri, 3 Sep 2021 04:17:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ec44d29-2413-41b2-4721-08d96e91caac
X-MS-TrafficTypeDiagnostic: BY5PR12MB3716:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB371648D1F6F7AB8FBB63FF83B0CF9@BY5PR12MB3716.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJM+AoVQCPIHZ/3Q7YFCB8mslJLBN6KxfSTiisQQ/Re347Q6Ph3HQyJMGQwjWCbCB79bEbcy1QQHtP422/VPuxVoZRTM9LpAadvgRuMtUT35BcFq/oFJndOgqKbWEqgY0h7958o7bmv/RHrqecRhRxkOW7g+xxPDUNvak4miA/ZzALfl6rDUkm+de0aMpZZZeYAfZE8rBrS096uCku0CQbv7OcXVfTm3kr2Dib4E0tpyJKXsVHZBCGZ2PWZ+QM6m8MOQZskxzrYesT3WwI1vXZ9GQq14nOAtqBMnUogBQnbGyScwPYj+Te1gSHGrxPdF/Y2Ks1MX4LQ3L+IvKm9+32M/vgAyv6FvcY0pQQ/dVqYwCxMV5wnKcxB1CjTnpi7xAaCoUjZomKvyWop6ZSE0lnkRUmPw/GIiv60kcD8O3SSn9qHTWiRCqdWSi1f4TcSlHFnqYNRl+pA6YQ3o7AWekLeVAhAcdjFVdPTyPu+knSounAD4wKgbbe6J6uYDMGr9OKmfxOsMSgQhj5HjcIhU5DZMKfStfBYk70urNKrT5SFEIBKsqOqBkgAgfp4bWWy0poLSs/lW/VCu1h4LpesH4YlnYdW4oyoy9qZetakfAtpQuW2zyr95rrCp3IfiQRnRIfl2JFZkVQoQ73t3Xt6e7LMVI7sWDczkf9qyXUgseTG3quk3tRlA6aIa1A5d4Zn/ijdkBhaD00ITi/x7y5ymIZOZNdMMyKQbF9Gy8ZiTNOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4289.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(508600001)(31696002)(6666004)(53546011)(186003)(2616005)(16576012)(83380400001)(316002)(38100700002)(36756003)(26005)(5660300002)(66476007)(8936002)(4326008)(31686004)(2906002)(66556008)(6486002)(66946007)(956004)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmF5RnYvaGoyT3JjTVd3UzJhelJ4RFJTcE9BOXdhZmJ1UTYraTFySmFBRVpr?=
 =?utf-8?B?endzMTVQTUhDcnk2a1RnWlJXbGl0R2pUUndyZUh3TjdJUktMM2xlTWZ4SVZr?=
 =?utf-8?B?SndheE1BZDg3aFlUY3poU01kcUY5WjU1K2g4K2VlelNyZm4reGhnREJzbk10?=
 =?utf-8?B?cityWm8xR2FRWEZzc05RdDlSMThVQ3hTOVR3UXpPK1BtMjNMbDl2R01vQ1VR?=
 =?utf-8?B?UzM0L25VS0xCL3lubG1LM0tUTTJ0TEVXWDFwNWlYSzNwODNmZlRKbHhrb1pv?=
 =?utf-8?B?L29YZVVZL1Q5ZVB0T1gvVzVBUUorYmFLMnJCY3RZU2VCbU9kUzBQdmkvVVV6?=
 =?utf-8?B?MkxiUlVlODlWZXpSZm00K25ObGR5NTFtRWlESlhjK3Vnc0NZbDFkTEZ4WFBY?=
 =?utf-8?B?SlRxeGxkLzdaRkZkWnFiVFFJNlVxdnIyckVUb2laZWtOWE5oUkp6ekk1ZWNw?=
 =?utf-8?B?L1BDY2dqc1VPdUpIcHZIeUhpbENCNEczK2VWS2RTODhPQkc5YmpSMmR3d3Q2?=
 =?utf-8?B?MmZnYTVyR0x0VGJRZndjSjY2NE8wSEVLU2xvTS8yYldpMVQyOG1SWkp3VVFG?=
 =?utf-8?B?eVZGdmY2TVpUREJ1QWZYanA2RTViYlZTbWR4V0o0N0dzZ2FQOEJmMmxyVitV?=
 =?utf-8?B?dXRUaFJ6TUdpUmJjZ0VLOXhTMnV6dktJUWJPb2RGNVJmckErR0RsQnEwY2Vs?=
 =?utf-8?B?TUR2MHJic0ZqMno4b1lSbjlhSzF3UXkrYVpGUVNlMG1LdThhQ25JVFV3VlUr?=
 =?utf-8?B?UWNqYkwzc05zdTJFYXJUNGtxM0E5dWZCN3RzZXdtU3kzSTBFMjlKbSt6Uitm?=
 =?utf-8?B?YzFHQmw2QU56QUtyeXpYTFB4bUdCS1ZnaERYVlFtL2o3OEUzR2JyS0NPVzVF?=
 =?utf-8?B?YmJSb0VhTS96amExeWNSSG5QU3BhblNJdExtWmZnNFp0Mm45NjBPUXpmRnBh?=
 =?utf-8?B?bUtoS1ZGTytaa2t1b1JTcUVUSk1ZTGtrdlUzU2xMVFUrZGFoWUdaNG5ka0Vx?=
 =?utf-8?B?TmFEUGVYTmEvRWo0c1dyVlRBS3JDVnRMbEFId3JIV3Q5VkNkUnBkUUpnVnlj?=
 =?utf-8?B?R0xFUlkzNm9jQitNR3R1SHpxY2txaVowbVZDb25ROXd1YWZTSFU2ZHlTMTRQ?=
 =?utf-8?B?aERYeGs0c2h5TVdLYVFnTXoza2tXSkFZV0FhNkNYdjFkbVlidE40UWovTlN5?=
 =?utf-8?B?U1YxMFhyWTJUMlk2VjRxK0FOa2pBak00dVVubXZIamoxa3BJTlAvcDFQQ3Jl?=
 =?utf-8?B?ZEt4cXEvaGNRS2RKNnZmYk9uYTR2TWtSZjZsODR3eC95dmZ6dXFwbzliNjNu?=
 =?utf-8?B?OGk0SXBXT3FCQUN0Z0tYalRkWDZ5YWtadUpzWVZkdXZwRFBRdnE1M0ZsTGJi?=
 =?utf-8?B?M3VTZzFDSGR2aWZZMDBEWFlvOTZjVHMyU1JmcXg2NWJ5bjVKVEpielVHZnZr?=
 =?utf-8?B?TFBya0hWalBPbXU4M1IremtLKzhrSHBzQUwrZkxnd0ZwVDMzdFIvVjM2N1c0?=
 =?utf-8?B?Q1A3aWQzMXg2Z3BIc1pLVWhVRTBXMEFoa2ROQjRhRFZwbWYxQTY1YUFOV1lQ?=
 =?utf-8?B?b0M2ek5xZEtJejhsMTZxS05aOFJKNUx4d0F0VFhEQU1JZFB0QWtqQTdCZ24x?=
 =?utf-8?B?b0t1YStzbDF6bEEwa1V3VzdkVHcxSGtpMVBkZ2xoZUNvQis5MExVQzI2NnJu?=
 =?utf-8?B?UGFQSklrNXhpSXVycDlSaDVwQ1VFcnI2R1RkcnVKaVVEMGxUdmNMVm5DU2VK?=
 =?utf-8?Q?4gnvgiVBHTwNGgbQ1cZhDaZIhwGA4Xhk1MlZFI0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec44d29-2413-41b2-4721-08d96e91caac
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 04:17:50.1168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6R8aIg1cpWrU7BiDsQGWr3OGYi7ndO+549QLJHwx5Iq0vRi4Cnyi4LLoh6VEvWo5Ab+ANYluJnFeJJVSRiQnwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/3/2021 9:45 AM, Anshuman Khandual wrote:
> 
> 
> On 8/30/21 5:46 PM, Bharata B Rao wrote:
>> Print information message about the allocation fallback order
>> for each NUMA node during boot.
>>
>> No functional changes here. This makes it easier to illustrate
>> the problem in the node fallback list generation, which the
>> next patch fixes.
>>
>> Signed-off-by: Bharata B Rao <bharata@amd.com>
>> ---
>>  mm/page_alloc.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index eeb3a9cb36bb..22f7ad6ec11c 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6277,6 +6277,10 @@ static void build_zonelists(pg_data_t *pgdat)
>>  
>>  	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
>>  	build_thisnode_zonelists(pgdat);
>> +	pr_info("Fallback order for Node %d: ", local_node);
>> +	for (node = 0; node < nr_nodes; node++)
>> +		pr_cont("%d ", node_order[node]);
>> +	pr_cont("\n");
>>  }
>>  
>>  #ifdef CONFIG_HAVE_MEMORYLESS_NODES
>>
> 
> A small nit, checkpatch.pl throws up an warning. Should this use
> pr_info() instead ?
> 
> WARNING: Avoid logging continuation uses where feasible
> #29: FILE: mm/page_alloc.c:6282:
> +               pr_cont("%d ", node_order[node]);
> 
> WARNING: Avoid logging continuation uses where feasible
> #30: FILE: mm/page_alloc.c:6283:
> +       pr_cont("\n");
> 
> total: 0 errors, 2 warnings, 10 lines checked

Yes, I am aware of this, but then it made sense for the fallback list
to be printed in one line continuously. Hence used pr_cont().

Regards,
Bharata.
> 
