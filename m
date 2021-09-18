Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41822410266
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 02:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbhIRAbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 20:31:43 -0400
Received: from mail-dm6nam08on2083.outbound.protection.outlook.com ([40.107.102.83]:36513
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231128AbhIRAbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 20:31:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOXMLU2ARR/WMAOc8DtubLxkcM49idJhdAP19bxct+6UX8z4mCfXon5Cs/iECHPmfTfIEG/FPFXIuKemyGzXJLxD98jQU9nYuwDYzlX7etjFVT2vwGpKL/JlwVeadrXYCOPeMQRUibKkUb5ozthOswOF7SL0V6pObG7bf5Fuix3zD0//cOEWfJMlR0MgAwhLLdMo6uZbFjdxfwkN63J36PgFTx8fLHHSyOvpy3OwdOnslmFIEYfoq986v45/n2CZXO6ewIRPYl40DpRqS0AoShEa7Df5nnxj3h+P8M838Asd+bnpY8OrzufbwyGhSY3biyXUXtOq86A4MjHXON1P9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1PDB40kDZI1Vw5+efKaLAjJkwnqC/3Su1SaDXfYF5Zw=;
 b=YIK1BfciBODh1BK+2rt7aj5hw4Sbi8voM/9bCNgF7mvV2uWjJ1Kv0c9P+7ZUo50x5rvMzxd583+gtfCC4tsTWWKidiHXvjd0DXk8Cvjotn+/tKSUsxFtxPROIMcOmg5pfxJ0svwsYfRVt786PwhMKmccCPxj8k2muMenxiNFP/Wu5/uu9gyEEYwtSWEukPsrg4l4F5JZdFCrl+9loLYF1zlPRDS/WhtmiO5GL/2VVJvWJMNbpd5Et6D7tL7KBBOfPIFnXzh7PVHemLO427j7pfqRBmFaozVA5bFurzLu3sQGfblEweyJTt7UVKPHoDH9f4r+0pGwel/88JcqLE14gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PDB40kDZI1Vw5+efKaLAjJkwnqC/3Su1SaDXfYF5Zw=;
 b=jT6AOp6xjFdnQ7vh0pJ+8ALHMme2CyR4oWYYR5pQBGWc2mhH3CJxtGBrJNJyLefL7sldPVeMzmrbsG5dGs5B3s/Iym7aWQEFjpOtvlP+DsgE5v99193E43YO+tNPR0HQNrHZ2NB1zrr+tcZUG3Q1n6oNxBml24ajKVGQ7naMn2gHBair/kfUt5F2pqq4BBwDzYjp1tWtTw1J+aIEcdm+DYv8k5dVAEinucDDaZ327LfTTT2M+PL+yEwRMMyiVtcNL9n4RPjJgMmDKzAshX9MM/oEbOlLmjlN8dU5uxXvJHvCUUOgbZUjTb09RM6GhQKQrvWVjuF0+JiGQ2X8sNDfsg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3141.namprd12.prod.outlook.com (2603:10b6:a03:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sat, 18 Sep
 2021 00:30:17 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9%9]) with mapi id 15.20.4523.017; Sat, 18 Sep 2021
 00:30:17 +0000
Message-ID: <3cf9bb7f-618e-4e4b-32d6-4d3c207b9a9a@nvidia.com>
Date:   Fri, 17 Sep 2021 17:30:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] mm/debug: sync up latest migrate_reason to
 migrate_reason_names
Content-Language: en-US
To:     Weizhao Ouyang <o451686892@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210917061432.323777-1-o451686892@gmail.com>
 <871r5nptt7.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <89a06743-b37a-b85a-1c04-5d863a1d2cb4@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <89a06743-b37a-b85a-1c04-5d863a1d2cb4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0129.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::14) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.48.243] (216.228.112.22) by SJ0PR05CA0129.namprd05.prod.outlook.com (2603:10b6:a03:33d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend Transport; Sat, 18 Sep 2021 00:30:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c4e6bad-8bd9-49b9-7663-08d97a3b7d5b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3141:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3141D941D0604BB92D312174A8DE9@BYAPR12MB3141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpR8JHSgTBpMfV+YRO8UUKrDGWQZbhWLViQd7GKXo38yfblRvlVD+JqbV0ljonYWzADZY5bsPxjh/BpiyCkBa0qZGROUD4iSFSBsnc/YnNDKhB10rkEQwEiI89/BVqy0JkLDJN+iWk2D2GcRdxDBLh3PTIIGqrT6Xkj4nvCgFJu86/ZBt33E5D8X6CopbmQ2GqS5H/lHImgBPUFMW6BveZKbvTQTYsPSraHJGlYoui4CUqpwgH+RRlxTF8isFZfMBsOr7nYo3mDVCApClEIZntexTcOjIehSdeK3JSlm/f2jkghu2kLgT3l5w810xrcc68VRmKTWDN/xdsUQmERmoebLkURqWR3rh6rL8liWEDA82hr49d6ShLwkYdBOPeKH2htXZm0SeITbSKbWgiEk/h3kshCs9gxuyEwGN7sT4pMdVcEwShFwhwF9n2YPYNDaXzqCOa08v3WPT5sEvmrFATsTCyZZg0Ps/hyqhdGQwSqQa4i2x6pBryja/Ab7xD5HkHfYMCLIHEyzWSZmeoBbuhXbI5Zn6G72fgXknpGj/1wOlxrOB8ysRD/zczZp5fiBJlPk9hAqxe9oDbwnjhp7YouPykFu2pSBVmlxwp1YQe46MxM6Gw6amJ36XAVLVc6wc9XOZySv48iD+xjRqMtM3ECJo/n8sp5e5MAQlVfXOJMiLiG5K86sCMkgrsmNyRi/787mntHM0sihFh1LsZIKTW25TOj8HHVj30c2iwO1t5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(316002)(8936002)(508600001)(110136005)(54906003)(5660300002)(4326008)(26005)(186003)(66946007)(66476007)(66556008)(53546011)(6486002)(38100700002)(8676002)(31686004)(2906002)(36756003)(86362001)(2616005)(16576012)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjFrY0tRU09LU3RzSXVMdW9aVzNRK2k5Z1lzYi9ITllGVnRyaDlFb1dDYXVG?=
 =?utf-8?B?QksydkNscncxZkVURDNxVSt0bFovY3ZRMVd2S20rRzkyWDEvU3QwdWcvTWJs?=
 =?utf-8?B?cXVKTDZLSFFnT2ZNdUE5Ymppc2s5VkliU1k2K0FWaDBHaWFqZmtZV1JWLzho?=
 =?utf-8?B?Z00rUDhsRExJTGsrNFZHT2R6L2NUYU5ScEEwRWVhQTFvQTZQLzhhUjRBTnVn?=
 =?utf-8?B?eHRkY21WYkd1ekE1YzBGdXI1Q3N1TURTM01kS3RPbFRDMFpOVUxFY3RsUXNt?=
 =?utf-8?B?Z09uU01kZEdIdnpzbE9SUXJ0RTAyMFBUWksxWFdwOXRiSXlkdTdOQS92OTZi?=
 =?utf-8?B?cG5oRmdVU2NlNytEaTZ3RnJ6RVlVUGQ3bWVBYXR6OW9rWnVUSDc3MkFRelR5?=
 =?utf-8?B?OTBYdThTSSt0dDBTVU55eHhSYWdIdVRvZzVYU1EyTjVaOWVQTlp4OXc1bHhJ?=
 =?utf-8?B?K3IvRFZlQ0UxaEdaR2doSU9KNUtPTE01Y0VILytBNTl5OFE5VDVFMjhpS0tL?=
 =?utf-8?B?dHZxY25SUDYyWGlqRmUvVENwSHhBS3pxQmF0QmNSelhwVmlpdDhZUklod2N4?=
 =?utf-8?B?eGJ2QVdBSXBwdDFvVXFQd2o3K1RNbjdmY2JRVkpFa0psYVorbWpOaTFMUnBF?=
 =?utf-8?B?MldydklacHlUQzk1RVRQeVQ1MHNrSnpjRzN6R242ZXRLZmtPejUyd0dGRmhr?=
 =?utf-8?B?RmpuTlcrREdBVzRlK3BDYUVIVC9iUEFuUFVZa0RpRmJ5bnBqajRNS3FiMVNx?=
 =?utf-8?B?d3VicVRmN2VVQmkvWU9TNDJMY2dITTVBM3VHNHN2dDN5VnpISWRnR2tYUE55?=
 =?utf-8?B?Sk0vRWZDeThLcXB1TjVHeWVHRXVZOWFnQ0J1Sk9OajhIT3RjNTZ2SkUrVkQ0?=
 =?utf-8?B?dFc0anFaeEhnVG5YWGhpTjhJSFdtblZISVZzYjQ5OEM0V0pEZnFKSmkweGVr?=
 =?utf-8?B?bWl1VGJnYUcyNlI0Y2t6Ym1VUXVDbHF6cVlUcWViZ2pzNkNvc2NoUk93NUJr?=
 =?utf-8?B?WnNkVi9UcW5rMGRXUEFOMW00a2Z5dk5Sd2RqSjBmaE90dnp0dWErWW41QS8r?=
 =?utf-8?B?SFJhbWpaMkFxUnFWb09rVm1mZmN5RzdhUzdlZTNXVStGaE1FZFZOZWQ0dms4?=
 =?utf-8?B?d3luWnRwKzdLU0JGT0FhR2hHSm8zakVBK1ltY3ZlMkVTT3hxQUc3RDhrQTZE?=
 =?utf-8?B?QmJzemVkQSt0ZmZhM3JjSnFvRTJEYWZNSTlFcS9KRnpUWWNETmt5MW1YK1Fh?=
 =?utf-8?B?WFk2NVpMUlZMSmtLYjNncUZWdTE5a2piNjdsdjJ2SzluNWF2czNQMkhmcmRK?=
 =?utf-8?B?SE1MSHM2c0daekRrM1lJakZPaUlibmJSaGhwZ29XZGRqL0VUSkZXcktsRE1y?=
 =?utf-8?B?bVRIZUR4NFZ3ZTg3VHBoQ1FQTFpMQzNPczR1QzkwTVMva0NyRGhmT1c2d1E5?=
 =?utf-8?B?MkhMOGgzRjZhNTNaTHNUREo3WlcvbTBJc0NFb1Z1b2gxcVFzWGVJT0R0bm1i?=
 =?utf-8?B?MDgzTU1nMkliTmJ5WldKYVg0Q0J0SlJqSVBMNDlaSDg0cGZIQUZOeVhCSkw3?=
 =?utf-8?B?dFc2MlJlSTZnaUgwWjRHSXlKUkJEQkxGL3BoeStSU0VDL241RW12QW50MWhy?=
 =?utf-8?B?S29RWG9iS0dlMnJJdnRBbDViUUVxTEt2ZHYwUHRCN3NOVE5OYzN6Z3JlYytI?=
 =?utf-8?B?VmpwUi9XU1pwd2tHNktGRE11QXNLaWZvVVpFM1BrVytvelBrY0p0am9jM2Jp?=
 =?utf-8?Q?3Txp6KEJiT4S5/+FgIJohyGH/WRPeJqTJ12ZFu3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4e6bad-8bd9-49b9-7663-08d97a3b7d5b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2021 00:30:17.6631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fa3DmupUH0mTwL0MD+WYCaZfa6O1xqqXfk6gWZuugO9hbcCWuG0pYuBw/G3LO2lpq/bvR/BtkEEpj6LE4JZ5uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3141
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/21 02:48, Weizhao Ouyang wrote:
...
>>>   const struct trace_print_flags pageflag_names[] = {
>> Good catch!  Thanks!
>>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>>
>> It may be better to use BUILD_BUG_ON() to capture similar issue earlier?
> 
> How about move migrate_reason_names into mm/page_owner.c and make it size uninitialized(get rid of MR_TYPES).
> Then use BUILD_BUG_ON(ARRAY_SIZE(migrate_reason_names != MR_TYPES)) to check it?
> 
A couple more thoughts:

1) From a naming and location point of view, migrate_reason_names[]
really doesn't want to be located in page_owner.c.

2) There are actually three places to synchronize, not two. And in fact,
sure enough, the MR_CONTIG_RANGE is already drifting out of synch: it
has a string of "cma" in mm/debug.c, versus "contig_range" in
include/trace/events/migrate.h.

So...is it possible to use the macro and enums in
include/trace/events/migrate.h, to define the connection between
migrate_reason and a string, everywhere?


thanks,
-- 
John Hubbard
NVIDIA
