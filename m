Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26A543C20F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 07:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbhJ0FOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 01:14:45 -0400
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:60896
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236866AbhJ0FOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 01:14:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFSSCtbfNIMKi7NolJ4CfcT7oMHpEGdAussg9/7JsjVns9BAAY7J52O2zDlhk8avfK7RgJVR5YwI0BPwu76K5myUn5DsuXMYNEzzA6OVCl53nQhjBIHU3sls/4lFkixRniS5x1CqgD9fRufMHKYKhpy+zgEZkiF7RPz13HvsUdLKi0xWyyB9sFpggLiFZX5YSc8/sE8EwP8HtDHaHrBpbTfhcG2Q2Ex5Eh1ox/qEaeep70c9vOzYTzvD/z66NTe21Db6w79/s0yn4lELZYGoKq7wy1guOUfv67FKgGGVLBSi4zV1X1wLk2vq+RqL4l+Pt5XNnp4j7LP4za5orKq7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ew9WY2TQmM/NVs1P/DEBLSBwfyNFuVYypHUnZ30vQLw=;
 b=BbU4Lpg+3Hdh3dQ+VRcAPLh8LYB0akYybLfzrO5r35/HcWgexvN85ZBRcep/BrFRiIf01TjoEu2aiZAviezBAxBKUEfRIHh13ExH0EHGYOMd3cRG2zrPWb0Rn50+KAPwirO6JXf8xJalwzMSH08BlKqAwJleTe+6nBbX/uMOMiENF3zC26cZAABhnnLfbJPkd6Jn78ugPwiKjAe8UzETVdFxYnBz16uR6H22PSAKG4HkJ7UrIfyAOzg5DautZ4zbe6WgztfgyquJsdTVJOii3No2PBy3L9LbMW3y3ZaJP98BOJkW+wcaD/f1wePknMpFFQWtEeAAkoRC4KA8k9+Kyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew9WY2TQmM/NVs1P/DEBLSBwfyNFuVYypHUnZ30vQLw=;
 b=EKZ/iMjBLvWtUnkSjNoP7xucnkEYUwEKB+MWHP6IhxluJgP4DxoFKnlM21aB0j6YMrabGHXNxdyZJyp0M/yN8QTFwUnyaxFnhQDGsFuYsQEvUwV4uPuMf2FcafAAm8np67dAo1c8Ukcd65ZGJfGqBpD9lOPpwH5dZvV2R/7CO7syA/fT70OnMndgiKlROsOxSNtw8GBNEjtssUkBT6NVcjZM0sMvIF8hD0Rmy5pdGGVsTyZnCH8cW6QBh7b0mkJCdBLFMEvesIOcp8VD/JRwCvbaJyxPp6wfNEIEt3+rHYZ5LIJHXgqC7cB0IsJJcmi+RUSL+Li813G0tPJaN69C5Q==
Authentication-Results: soleen.com; dkim=none (message not signed)
 header.d=none;soleen.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4935.namprd12.prod.outlook.com (2603:10b6:a03:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 05:12:16 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310%4]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 05:12:16 +0000
Message-ID: <b346cafd-d8b8-57a4-c7b9-6574b256a400@nvidia.com>
Date:   Tue, 26 Oct 2021 22:12:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC 3/8] mm: Avoid using set_page_count() in
 set_page_recounted()
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, songmuchun@bytedance.com,
        weixugc@google.com, Greg Thelen <gthelen@google.com>
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <20211026173822.502506-4-pasha.tatashin@soleen.com>
 <7b131cb1-68d8-6746-f9c1-2b01d4838869@nvidia.com>
 <CA+CK2bD6x01PevPqshzYqkO3aokjP2jBbt_4e5H5U3DVEdcJ5Q@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CA+CK2bD6x01PevPqshzYqkO3aokjP2jBbt_4e5H5U3DVEdcJ5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:254::18) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.61.40] (216.228.112.21) by BY3PR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:254::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend Transport; Wed, 27 Oct 2021 05:12:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fb5b45f-adbf-48fb-e1e4-08d9990857b0
X-MS-TrafficTypeDiagnostic: BY5PR12MB4935:
X-Microsoft-Antispam-PRVS: <BY5PR12MB49351C860D76B1873FC2DD4AA8859@BY5PR12MB4935.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TshTbNuj/fUrg30hukLVXBEOMkcIW0rnY9HiJm+Czd3RtbcXyD9zB4LorusqXimBgF7jXYPBLOvZGGPIuz6qbQOLLbXiLvCDxQAVAcybWX90ypX/4pvX/w5IugSvkuQ2fxf7+pgqcxmIx4HZTaC6hTTKd3EfsBsI00jh7ljp8bd1ZNK40Usf3HGIXYOGV3rUXL1cU5MZm4Ht9dIUMlPzjLFNuFddYpeav0UQ5FVrRNtmJgRJQhHXxUN26rRg9bdWEKucLTboH0GtIzR9yhjBbpimMsEbYLrZrP2H1NJXvgNAqef5u8Oyy27Ldw/L4+ov+lYyuzBCqpNpHHGK3ja+c9gpIZUrTkc5oCuO8qOCE6LQ+SCGk49IjB0htSzgsL5bys2flfIZqIR4ETQ0RkUDGgz3LKrh5EgE0iawiBI1uY+43kZAkTqSc3LByuWghGmJlhNtsWNWRbRsnWqqef4Vzcu7nZ3axPSFgr80aYkI4X70L0rSShoeKa4zOvA3rv0fagMHT485FbAHRAb2cOE0rAZRL1hpjavODAXB11DJ5ZhbFuQ2RkFKhMJSNs06kQKkonkLwJlgsYiqnsT7Gj5QBmrAZNnJHFBr9oeAHDntkla/YtvRFBeiiOMQTE0u1uPzJN+CvoGHfpKlTKe9e51KAHQwNS/nr8yP4Lf5/Rjv0kOa4zF/9Kxgq8KuK/6gUF1KE9vnbedAx/VernCKaDzSiNwcmfQDmz5m/vr0EgwGcL0mNxfQJPXRGT6o85yiAY7/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(38100700002)(31696002)(6486002)(5660300002)(53546011)(26005)(186003)(8936002)(86362001)(2906002)(8676002)(7416002)(31686004)(2616005)(16576012)(66556008)(66946007)(956004)(36756003)(66476007)(4326008)(316002)(83380400001)(54906003)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEJiMGg0a2IrR2JDQmNoWkNDaDBSVHJzWU52SENBc2xQVEZWUmEza2Zzbm5Y?=
 =?utf-8?B?eFhsZVZETGpIWmhXRGJkd2RjMDV0NStyQ0lVQ0IvdysrYkVZQm5mRVExKy9Y?=
 =?utf-8?B?dmJYRWN1RDZPZGhscERFNmpOK3NPVUk1a1dicEJoaC8xMXZYemtYL1BaZ293?=
 =?utf-8?B?TG55MTd5ck5yYkJ0Ry9naEZabzRsR2crWVVDWTlnT1JlRDNGNmJ3RHVpbEMy?=
 =?utf-8?B?eERVNk1ScW5NOGZ6dTI2NDRiSG53SUc4a3RnVzdrMjducGNQMGRDZi8wcnZI?=
 =?utf-8?B?aGhIY3VvNGhzS1Jja0hudCt1RkNtOXh2OVhGN3VHM0Y2UW56Ni9xbnhzUHhp?=
 =?utf-8?B?SGJHRzdmNWZSa29FZzlTOWhoSkRxOGJDMFl1OXNxRUcxZVk5Z2hHOE5FK3hS?=
 =?utf-8?B?WkZLeVVGMkpsY1RYS0hSbUxtc2hGUHBIdnVjMnBSYVlTdG5CbmdjekNVdVVN?=
 =?utf-8?B?ZDVzVnZManNsWVJsMU9HUXJUU2dWZTJGNWo1QTJ6TzhKMWN4WUdWcjlYQmVu?=
 =?utf-8?B?YklMUFpoYzh4dnA0b2Z4TGVaeXgxdm8zQi9xR1hHUHRTVjJyTDJHLzd1MGM0?=
 =?utf-8?B?R0JyZ25DVkRkcjFLUlJKS3Rnb3RTNnB0R2d1QUU3VDJBQm1VK1pQRnZYQnBj?=
 =?utf-8?B?Z2VOeUU5Qm5OWmhIaisrY2d1SFFwc3h3RXhkcDNTMGhvZkZlbTloQmZWQ3pC?=
 =?utf-8?B?bkNvc3Z6NmNRTVo4bHlyVTQyTENQYXNIdGtxQjVGT3dFU2hFNy80YmErUWp0?=
 =?utf-8?B?VXh5S1hpekovT0pyVVZmcUdGU05XemxjU3ppRmVObk9qWk1Bc1c3UjJLWFpn?=
 =?utf-8?B?ODFNUkQ0VzlRRXAydzRtZ3JKd3hadWcwZEtuTzhkQkpUR1htWFhrOE4vQjZ3?=
 =?utf-8?B?SEZqSWtiODBTNnl3SVRNeVE3NTVVUGw0K0Vya2xQUUljeG1TTkVUbytpcS9z?=
 =?utf-8?B?YVNXVjEwWHhLMmR6SkNZRGxhb1hZa0hFYXlSbmxKbDlVWkJnQy9meG9ielR0?=
 =?utf-8?B?b2pUQTVZZ1dIaXFjSDRSaGFwamNHVktTUkVEMjgzVjlXMFJDMm14YTMxR2xI?=
 =?utf-8?B?aVpzNHFlRG16eFF6bEM2SUJrT2pEN2p5SDBGU24zT0lJczU1VTNSYk01NG5q?=
 =?utf-8?B?azRQZkgwM2krVTIwNmhHcVdhbDhFQVBYdzlrMzRqUloxc2h3ck5RUHJyM21X?=
 =?utf-8?B?MUhpdlB0dXJSVjlHd25lTGtBNDhKNEEzejZTZ2JtMkxPVVc3TjJtSC9ScXNH?=
 =?utf-8?B?d0NGRGR0TnByY2lkUjhXeFFyaXRTSnpBdGdLamxsMTFtWDJNL1QyQXBZU0Fv?=
 =?utf-8?B?SFVUQUlSTmJtUjd6dkNlaW1SMExaelNFMUVwUFQxcUQrcTJDenFER1lYbDJW?=
 =?utf-8?B?Y2RKTlBkSTl1N1U2cnMxeUlaQW11MWxFUm5zL2UxNmpUTXowMU1zZnd2MTdC?=
 =?utf-8?B?MkpZOS96YzRhV1c0SW5EYlgwNk5aUU1CMnpCczl6bEFFLzNKS01VdkRBOGZS?=
 =?utf-8?B?NlhXcHhDQnM3QnRpRnhkUUFzLzFRUDRBcW1ZbVdGSVZWczFtY3o0cENYSXVu?=
 =?utf-8?B?UFlrV3ZCZmRUTHY2b1Z3SEE4bldublE2Rm9MSHpmbW85Vkd6UEFkZXp0MkJ3?=
 =?utf-8?B?NnJYSDZzcjZkcmVMRVNtTDF3a3lWaEwwdVN2bUZZME9hcFc3YTdkQzIxSkxj?=
 =?utf-8?B?Tnl3ZGpsdEZxMFBuVG1SRmV2MHVRakxFbW1peTk1TkM5Y1BOTWdpVTZGc1ZN?=
 =?utf-8?B?S3hoenBjalFLajNhc0p6cmZvM3FUcDJRY2NtY1NrbG1VNHFITGdOaDhJZDFl?=
 =?utf-8?B?SzkrWWprRHV1aVhXK3lNT014azFRVE1jdnUwSy93SjVtME54bjh1THJmQ1hZ?=
 =?utf-8?B?MUtXZVdqcnFjUXplR3lwdnp6NVYyZUdpV005Z0NlVWpET1ZNbzE1NGltZVNs?=
 =?utf-8?B?V2FZWk1VbGJZZEZJWVZGK0l6UUpwcUJrL3VmVHZSWlptY1B5VEhFYWE1dUY1?=
 =?utf-8?B?NGZlWTNNWnpOQ2FtN3BEU2VvRWV5K3pIQ0MrMlNQVVdsa0J2WnhUWEtzbVpn?=
 =?utf-8?B?NEdRZncvNGVpZGt6NW84NGg1UTlCKzFnZXFwcXhXbHQxdVJha3YvV1FscmpX?=
 =?utf-8?B?WmxhaGY3NzM2dHZQNFlGSVlaQ1lJN2YxRi9ZQklsVC94QlI0OEtOakplUlo4?=
 =?utf-8?Q?4WPSbGdcNmswdbzxcnNx99k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb5b45f-adbf-48fb-e1e4-08d9990857b0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 05:12:16.3765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RE31yhqWB5eYDKMxbSITiF4XrMXD6gz4RdpUTRwrxnNyZ8s/kb522i42KiqNvxc70xO5LlRKv0N4Hlulg1BFsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4935
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/21 11:21, Pasha Tatashin wrote:
> It must return the same thing, if it does not we have a bug in our
> kernel which may lead to memory corruptions and security holes.
> 
> So today we have this:
>     VM_BUG_ON_PAGE(page_ref_count(page), page); -> check ref_count is 0
>     < What if something modified here? Hmm..>
>     set_page_count(page, 1); -> Yet we reset it to 1.
> 
> With my proposed change:
>     VM_BUG_ON_PAGE(page_ref_count(page), page); -> check ref_count is 0
>     refcnt = page_ref_inc_return(page);  -> ref_count better be 1.
>     VM_BUG_ON_PAGE(refcnt != 1, page); -> Verify that it is 1.
> 

Yes, you are just repeating what the diffs say.

But it's still not good to have this function name doing something completely
different than its name indicates.

>>
>> I understand where this patchset is going, but this intermediate step is
>> not a good move.
>>
>> Also, for the overall series, if you want to change from
>> "set_page_count()" to "inc_and_verify_val_equals_one()", then the way to
>> do that is *not* to depend solely on VM_BUG*() to verify. Instead,
>> return something like -EBUSY if incrementing the value results in a
>> surprise, and let the caller decide how to handle it.
> 
> Actually, -EBUSY would be OK if the problems were because we failed to
> modify refcount for some reason, but if we modified refcount and got
> an unexpected value (i.e underflow/overflow) we better report it right
> away instead of waiting for memory corruption to happen.
> 

Having the caller do the BUG() or VM_BUG*() is not a significant delay.


thanks,
-- 
John Hubbard
NVIDIA
