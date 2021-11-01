Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D944420E9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 20:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhKATiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 15:38:07 -0400
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com ([40.107.93.85]:37856
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229541AbhKATiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:38:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juHbVdEoGK6aTPm8ChKrNXMUwr1u4cFdUSWkR3Szou/7gwBByXan9dGWS9Ym94MRTXwu9+TZ24+3UY/tJ+OJqbyyoSHild56MGsTh/yldYQd/wp1a6AgeVhyjhvhLT9/Jp0HPUND9Rpyzx8t6i4MkZr9VhBjJ6FVT0rM9/EX2Yl3SZfyPwB4Tyreg77e1hPIc21WRb7kRDuPXPuvLMqCEIt0IFakO72WHWLghwYY9yxFFY9+olz2Vx911IT9A/TWZIVlT0owRhb718sJkwfepsi1VF1CP6CwpdndP7B49MybW4B8V1pqOB8pSvDNEY4sdti6Aoen7jhTO/ED6NWXGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOv5fyCCEwKkX3DsBHz7mifuDopywulEsL9vl/NvMZY=;
 b=JYqg1VmUosiiVYZ/gwLHG2URx6/NRMRLUjrLyeYfr+EhNzvYO9rBpEYSCDvuGiiwtLyOunFOa/76RElClblMlGdbNaG8jfe6EyB3FrtJCzgSiMX26UbxM0+FiQvyHZny75ELRM+Aw1B5hDpyEsBV88f6+6ViEIbTc3ZpUhfJdXuR1/nsQdRUGIsGUGqYJ5qOsuaGPY/iXNJykF226AqfnX3XKhlJHxWfWFcXX6LhOPGm99oDGq5pGXv9JKsf0Qh96NKjkSkBWubspV0DZJPMYgrdqGZbfAoDEYXdAfmtqFrIFdygR/rKKBkmdE/lCM3jfHXnf7DhIw2tUNHgslGX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOv5fyCCEwKkX3DsBHz7mifuDopywulEsL9vl/NvMZY=;
 b=pTYcMylYZ8x1A6/QrjnZjsNqQCj/iAW0rhLzPp9o+rCN1sns2DAzzx7tnccAkFAbjxu91oBLa73F30ssEnJtpiRu/FVqz6uB/cDV5w2W/oZBMVacvsdfBYJVrFLDoIWLEMooBWVz4Y262KUuGrmY4sJ8lRbfmGU79ycNqlr3/mTlDm00hxA+/oKRhw1NYCUbU1ZL7yqGio6Gnnj/d1SWAiMkFLCPuvicJnOXq3JoVmwlcHVzezbzlgxNqylGFTZmk4xwExIe8QGknsApfiAfEcccZx4t0o9LwOawOp/OLwO9RL12XvJF0prgebcobOkeIV5MfUy/Yvi+p01nNt0zpw==
Authentication-Results: soleen.com; dkim=none (message not signed)
 header.d=none;soleen.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB2918.namprd12.prod.outlook.com (2603:10b6:a03:13c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 19:35:25 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310%4]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 19:35:25 +0000
Message-ID: <d2c569d8-d223-e0cc-cf9c-cdab14dcb5ef@nvidia.com>
Date:   Mon, 1 Nov 2021 12:35:22 -0700
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
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <20211026173822.502506-4-pasha.tatashin@soleen.com>
 <7b131cb1-68d8-6746-f9c1-2b01d4838869@nvidia.com>
 <CA+CK2bD6x01PevPqshzYqkO3aokjP2jBbt_4e5H5U3DVEdcJ5Q@mail.gmail.com>
 <b346cafd-d8b8-57a4-c7b9-6574b256a400@nvidia.com>
 <CA+CK2bBiomTe-vOuxM_R+0CMAippyrfZ6AgpXQGqps3ZFQCtRA@mail.gmail.com>
 <19d16b40-355f-3f79-dcba-e1d8d2216d33@nvidia.com>
 <27b7177c-71be-9ff2-716e-caaa5035d451@nvidia.com>
 <CA+CK2bDb4vZYFEYf7WuanbCYFh+Kb=U3VHqRwj-YTFhzsp6ZuQ@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CA+CK2bDb4vZYFEYf7WuanbCYFh+Kb=U3VHqRwj-YTFhzsp6ZuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::14) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.57.12] (216.228.112.21) by BY5PR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:1d0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Mon, 1 Nov 2021 19:35:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1ffc1b5-3681-4b23-a1ff-08d99d6ec074
X-MS-TrafficTypeDiagnostic: BYAPR12MB2918:
X-Microsoft-Antispam-PRVS: <BYAPR12MB29187068B8502AEA51E9B568A88A9@BYAPR12MB2918.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNxjraxZx3oW6Ijiuz9WhZ6ZbexuyXMoTapexTsGyRcc4FJcK+Pz3aWs652dHj50x+Nk/NZPW00MtkK9+CPxgYW+s5hmnFwVPyT+q5VfHyyZNFFmcmpjnGDZ5Bklwp0HOPcnmr0/1F5GpBfa5IBCUCWU9uRmkpeTGfzckJt8OvenVQM6f9JPbXV1JyVe8UjB9aWRlzVIUsnT9hsemS/+NUM2WEweUe49KZh/HACU45RWWfNWIkwWPgr3r2blZj9CkfRmVVEsZ4N8l/H53atKkSgnNnQdDmPlKey+SgdH3GvRpqQbnAol3Nzi1tzPhfum8yIu/Fn96lPL3RIXhIA73BxS68JAU8z+LVqtG+vF9+k/RBSpuL3KCwi9fYPw+73vYzXTLJIoC6z+PwdfI5QVbVumq+qqWukwJQg4XRg3jnenRlxMuTwGwBtmA2BSv8+WjSd2+em8ZM/NpYIhWiBXG/Yriu4qOnMoZHK1Zm+liUVhu2nId7UcL7bUQsNBCxz0/aOG0Z/7XKazWO5pzs9sdfm0lUs3R4bs0EUkfxtn4LzNDZPnQW2foqCRvitIWcpY8LjIbNFP3CO6/cnHYQrGD33MxGgNzCOB/Ycm+MUE93zwran7ln1JjvE662ezNmbQ5mhv4NRd6xJ2Nd6YmKQJqRYgf36x8CMqNZlPdooW8kMlZ5ljsgzapdvrCnq/eo990JH9R3p8/U3omUpxiqnvBtORTVfYFpNsv2vpI6NdsyJmEv63uITRqaGwIW0e019l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(86362001)(2906002)(186003)(31696002)(66476007)(8936002)(66556008)(36756003)(508600001)(53546011)(6916009)(83380400001)(6486002)(956004)(7416002)(16576012)(26005)(2616005)(4326008)(5660300002)(8676002)(316002)(54906003)(31686004)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejBJaERMK3ozMFh1MTJaVTFvZXZlZGpxb21nQmUzRFoweTdlM1k2bFZ1NXRN?=
 =?utf-8?B?S2hsbDJXbys1S0VaTHNpQ1ZyM1REN2k0UWFOaVE3UUE5TWhXTjJkZ0VGYmdy?=
 =?utf-8?B?U2laNlExNkYxNXoyc2d2Wmh6bFZ4czU5UDhvKytnN29zMVk3K1hKZjA1NmpW?=
 =?utf-8?B?cU8zcDBPaEZXeExOMHR0Rk1sVThhUE5XV014dVF0ZitYY3oxekhrWW5QQUI1?=
 =?utf-8?B?MGNhQ3I2cnlxK3dNaG9aOWFaeG5VMi8wTjJ1R05UTDZUaXoxbDdmbFFZVzJD?=
 =?utf-8?B?bFdGRVVpNUZqMDFkc090ZkdORVgza01DMHFiU1lZNUV0bWFsS1lxZSs0UDRp?=
 =?utf-8?B?enBUakJ0bXdrVHpKU0wxQWIxWGM2SThuWFpab1lhSkxLZ3lodk1teHFzZG5k?=
 =?utf-8?B?dDNXbk9zZXJ0R3pFM3JXNGVqODJTMnRmMTV3SzdwY0tmY1NqY3pwdkp2Q0pu?=
 =?utf-8?B?NFhUZzJZL0lyUEZra3B0bHBRZW5paUs5bm5WdmpLQmpra1duMXgyTzlFeWpl?=
 =?utf-8?B?RkJyUm5vdmpScjdEK2VsWjNjTVpTd2xTYWVvT0pmUkF6dXltcndtTUJuZ0l2?=
 =?utf-8?B?VmluakNmYzRZU1Nsci9NdWl6bjlFUVhVREIrNW9lR01kZi9XMHpZc2xUbUVt?=
 =?utf-8?B?WndZVDBMZjVsQVp6NTZWUXlHanplTmMvYVB3bkdiOHpVSndkUnpPMTlQYStF?=
 =?utf-8?B?ZjlOdlRRcjdtVVI0WXFUdFh2MldON28vdTNTaUtNSTVFR0E5clBxUVlZN25N?=
 =?utf-8?B?WGJ0Uk5PTzdobGRycEJ6am1HTnA4Z3R2Y1FIc3FSakxzR0FiTlpZS1RNRGtu?=
 =?utf-8?B?OHdVWVp5V3ZoaG5udmt0UGgrQXVnc3ZJSGlMUW4rTEZ6cFN4aEJYWkdJQnJL?=
 =?utf-8?B?Nnlkb2VaUHJpUjBjZHFZZGlxZGIrNXdDazViSkhPOXE0U1hESEFuVkM5K3Ru?=
 =?utf-8?B?Vkxva1gxM055TGoxUndKb0Zva3FianhVT3NjZlVFbUZqQ09zOG40UStML041?=
 =?utf-8?B?cVlrdnJDSjdhMmpGUjB1dnFSdDh3clhaUFl3U0FZdXRIVWJwcHlMcjdCYUNz?=
 =?utf-8?B?ZzFBeTh2djkwbFV4TElYcnBac3UxRmFza1VGTVk5S1RvdUlWa2ErNmhnSmVv?=
 =?utf-8?B?WjZiMlZlVm0xUVJhQUJ5MFlFRzZQNjZjZG1LWk5ZSVJPNm9XR2xsMjQzSFpI?=
 =?utf-8?B?bEpUWHhrekRLSzgvQ05FdHBOVW80R2ZrcDF1M1Nxdk5NTk92L3M3elg3ejlE?=
 =?utf-8?B?VFRobHNqMlljdEppd1hBa1F2TGpwMzFyeVZNenc0Mlp4NXNYN2ZTYXplNDF1?=
 =?utf-8?B?aFFFaE9Wak84bi9JRk5hWllPZHl0MVovWmk0Y1dsTTFHbTlLaU9lK1I0YlhN?=
 =?utf-8?B?NXowQjRnOHNsdDVhQ0dCZ2JvMlQ1RnlsZlBWQkxENWJCY0psaUF0YnNOTnh2?=
 =?utf-8?B?emY0MmpXbzYxTTNNTSs2Z1FpZXB0QzZhUjcrK0FlTUxrbG1hS1QvVCt2VTFP?=
 =?utf-8?B?SDgxMTJpWEdzQ2ZWMkRxRnBYNm5sekRWZmZJelYyU3RsRHVQR1hFdFBROWUy?=
 =?utf-8?B?V1g1bXJGOUUvUVB3Zm1iSU84VG4zditzaHgwTk1FVmhTcVFObEJZakluZngv?=
 =?utf-8?B?SWl6VU1rSWtvSSt5TldVNEJCMUpYaXZSaCtMVzd5d3hzUkxRWHZ5czhVZlhU?=
 =?utf-8?B?dFBvMTRpNVRPcjlWSFhPblNnNnI4Q0pHZUNpamJ1aUZzTk5LdUNhd2t4NUor?=
 =?utf-8?B?VmZxa3BuYmtlbnBzSkpWOEdRMEt1NytkL1ZTL1cwWDUzVTFMMmZLMlVkUjNZ?=
 =?utf-8?B?TXdoU3JxbWFnSEZFY1hobFdyQjRiNW15dXZhZzBJaC96QmVGZkl0dmw3Y2dR?=
 =?utf-8?B?RndFeXkzMXdtWEtBajQ5cDlQTERpdkxlZ0gzamw2WEpQYW9aMks0Umh3WW83?=
 =?utf-8?B?b1kzMUdCcWUzR25FRHkreW1LbWxGQ1Q0YXZ5dzZPdDZqMjZTR2sySnpGODg5?=
 =?utf-8?B?V0Q5NUxxM3paNXd3dEZMM2JkVzF5TUlUL1p1RTA0ZWlkNGhiMVYxUWFGNGxB?=
 =?utf-8?B?V3ZISlJsY2Fub1pqSWY4RmQzWGgzanhqelRyRVA4cVlxVVF4VzhqdDZta0NH?=
 =?utf-8?B?enhEYkZKY3MxZU5LNkI2SkZYbWpYTmZNNHN1bERrK2h5YkNLK1Nzd3QrcTFY?=
 =?utf-8?Q?ISUCfb9Bqh7zVapRbl3Cbsc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ffc1b5-3681-4b23-a1ff-08d99d6ec074
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 19:35:25.2947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5/aLx3Fjo0yjuZipM+eff6BDH/BTinOYxcIJSSepKNPUR3G86N/TWA1hR0Fcp+mOI5ZzyyL/F9Ir/+kvNjE+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2918
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/21 07:30, Pasha Tatashin wrote:
> On Wed, Oct 27, 2021 at 9:35 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 10/27/21 18:20, John Hubbard wrote:
>>>>> But it's still not good to have this function name doing something completely
>>>>> different than its name indicates.
>>>>
>>>> I see, I can rename it to: 'set_page_recounted/get_page_recounted' ?
>>>>
>>>
>>> What? No, that's not where I was going at all. The function is already
>>> named set_page_refcounted(), and one of the problems I see is that your
>>> changes turn it into something that most certainly does not
>>> set_page_refounted(). Instead, this patch *increments* the refcount.
>>> That is not the same thing.
>>>
>>> And then it uses a .config-sensitive assertion to "prevent" problems.
>>> And by that I mean, the wording throughout this series seems to equate
>>> VM_BUG_ON_PAGE() assertions with real assertions. They are only active,
>>> however, in CONFIG_DEBUG_VM configurations, and provide no protection at
>>> all for normal (most distros) users. That's something that the wording,
>>> comments, and even design should be tweaked to account for.
>>
>> ...and to clarify a bit more, maybe this also helps:
>>
>> These patches are attempting to improve debugging, and that is fine, as
> 
> They are attempting to catch potentioal race conditions where
> _refcount is changed between the time we verified what it was and we
> set it to something else.
> 
> They also attempt to prevent overflows and underflows bugs which are
> not all tested today, but can be tested with this patch set at least
> on kernels where DEBUG_VM is enabled.

OK, but did you get my point about the naming problem?

> 
>> far as debugging goes. However, a point that seems to be slightly
>> misunderstood is: incrementing a bad refcount value is not actually any
>> better than overwriting it, from a recovery point of view. Maybe (?)
>> it's better from a debugging point of view.
> 
> It is better for debugging as well: if one is tracing the page
> _refcount history, knowing that the _refcount can only be
> incremented/decremented/frozen/unfrozen provides a contiguous history
> of refcount that can be tracked. In case when we set refcount in some
> places as we do today, the contigous history is lost, as we do not
> know the actual _refcount value at the time of the set operation.
> 

OK, that is a reasonable argument. Let's put it somewhere, maybe in a
comment block, if it's not already there.

>>
>> That's because the problem occurred before this code, and its debug-only
>> assertions, ran. Once here, the code cannot actually recover: there is
>> no automatic way to recover from a refcount that it 1, -1, 2, or 706,
>> when it was supposed to be zero. Incrementing it is, again, not really
>> necessarily better than setting: setting it might actually make the
>> broken system appear to run--and in some cases, even avoid symptoms.
>> Whereas incrementing doesn't cover anything up. The only thing you can
>> really does is just panic() or BUG(), really.
> 
> This is what my patch series attempt to do, I chose to use VM_BUG()
> instead of BUG() because this is VM code, and avoid potential
> performance regressions for those who chose performance over possible
> security implications.

Yes, the VM_BUG() vs. BUG() is awkward. But you cannot rely on VM_BUG()
to stop the system, even if Fedora does turn it on.

> 
>>
>> Don't get me wrong, I don't want bugs covered up. But the claim that
>> incrementing is somehow better deserves some actual thinking about it.
> 
> I think it does, I described my points above, if you still disagree
> please let me know.
> 
> Thank you for providing your thoughts on this RFC, I will send out a
> new version, and we can continue discussion in the new thread.
> 
> Pasha
> 

Yes, let's see what it looks like.

thanks,
-- 
John Hubbard
NVIDIA
