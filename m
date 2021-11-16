Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19165452D2B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhKPIy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:54:27 -0500
Received: from mail-mw2nam10on2068.outbound.protection.outlook.com ([40.107.94.68]:62432
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232493AbhKPIyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:54:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGl66ovubCGKDNlpsxRoSfpkNBs0VAXdQ6A//XR2+ujfFzG5yIHIeNXK6/9euedEnZcTl0D9kYX3RCoaE9OXuQdX2qPCv9RYGULQAlax3bECdA4lOFlcD/ZlQ9JZumeYOVM+V7t2r8Rk/g53Vz1GJDlZ8hi5cDSF/AqZcQ5pDgoDTv5IS8faL75IEzAztaTGV4XoaTWdyeSYNH0VZWWj55pcStQb/cb2OBayQmGF9LM8yJFkbLKT9ipsQrmo2x7Jo7sVMeQKAc9CSalGQXZJkgmu+ZjCugB4GnZrqxKcH0kaAkyEDYTfmbA0HJc8H8PyGVdXvCEsJqEPcm7KLrADfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zD3dULoi8gwZ5W7tfE1ZY1wwhOmW5ixkeGlMTKWgA6g=;
 b=Wpl4aWYiBbHoOKC76wB1mqA1pn5EjwKwYTV2sIc4KLHa7HGD2xaCCeIMUBv1DfuX6PCOIedmZDB21CZmmA1y2AuRkXk+1E+UbHm1aCu/X82i7m079DG2HpsYyA/m3bjGrvTsFCrSrxk4pvK5JyjN4yzKwwexhyncK0wvN+3zV3b+E1I1eu5D2W5e5BoEhM7iGCH78fkCEUps6NY7jGWYNfHpAXYCjW0e44qtwzvISVxuHy5OYHDmPvMy9tTg3OYh44gm1Ugwa5wm6f8MvNB1RceAt1wy4ZxtIL/we5gKULsET5WVhlH0R7UNxHYbxyJyck66+4qXWr81u3YUnyGtmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zD3dULoi8gwZ5W7tfE1ZY1wwhOmW5ixkeGlMTKWgA6g=;
 b=NIvXztrBUOSnMejKugWpQkJe8NerVnaMgj/nwqlUbxZudJ9ribIN/oezEFB7BH4OxelZ14NChF8kjWGpf75+rv3ezXDaqgGwWW28tLWLu+06YUq86VNrcRKLAp5n+SRJUm1ZPIKgNxxjzTDcTBGuJSz0WkYQip+8ZCsSW3SIDZ0QDxfR06SlKA0Uw8zKBG1Ru2VXOJqV3oPl/yWYGfXpetkjkNyt5VH/5Z46qRhMHGF0uHHMpwQXnZeqQaMa/5t5PgQiKH5X6dXWog/8N1JCKu0Z1tzusG38zBU9I8sRtLm7t7V9mVa+4CfpvjHoxP+w+RI5GBdjWD/b3fkBAaTkWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 08:51:15 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310%3]) with mapi id 15.20.4713.019; Tue, 16 Nov 2021
 08:51:15 +0000
Message-ID: <8a5e44aa-243f-3a9d-e917-09cd3cf6609a@nvidia.com>
Date:   Tue, 16 Nov 2021 00:51:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RFC v2 2/2] mm: Rework swap handling of zap_pte_range
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
References: <20211115134951.85286-1-peterx@redhat.com>
 <20211115134951.85286-3-peterx@redhat.com>
 <YZJnTKKXDqKWZ6UP@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YZJnTKKXDqKWZ6UP@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:a03:255::7) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.49.227] (216.228.112.22) by BY3PR10CA0002.namprd10.prod.outlook.com (2603:10b6:a03:255::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend Transport; Tue, 16 Nov 2021 08:51:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fb114d9-6fda-4eb2-e422-08d9a8de3f22
X-MS-TrafficTypeDiagnostic: BYAPR12MB3126:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3126470CEAC02DF4B0EC58B4A8999@BYAPR12MB3126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ndY23fIIcVDDLFFxfkHIWrNWV9RdUNdJnoiw/M6BhKfSJkDN6M0BY60Kj4FeSK6jDF7zU5ZGwBDP1tP2K+ubl5Bm30ijjN9D4mhg897ZDRG8f8eoa6UFuC1U4Vw7gjhGoRIB+4pz9VY8p7Uo7dDBnqwFmsRysjzGRq2JE0jt6UWpD5RhYfY1NgGSm4ueTELOwx1st4h1hXM6RJsh7PUoFc5L4O9Y7kuuNeJa3grS6KFd5L8O07gbhu8FGMroy4aPsqLGRcAHKBueolDqg6K74E0MCm5Pl5qS3fqrM4eGCKFF8jbi7kjHPpKMzHjQ5D3zNJZQILXQxb9aXQb7nGBIjhkxhmYvmqP0wlxjWdIIfOImOajc40/dUmunSUOQbamNDbsiHk4//WF0ObIuQkKFDNSB4mm13b7397DpLd3bvCZUtUewT/1wbubl/epoOkyjiKFQSoZRmz3AsVsabeY27qP3EFPd/pdqOab10NRauDrhIHsuZMyhbbpebiNouSKgAMZ171k33nb+MiNH14I7tPGrkMF+exWsFHMDvFEbI0fDT1RzNiWj1VrZf25xV9c2vcwJq+BNGdwKGW4Izn8AnTKYTDQdBNi2HBT0VyJdGNdKPUcdE+uTTlCBjpq5YhCy7Kvh0lff8O7MAdEookoWdsqE1ydi9GE0Vdw8CjTcTOxfY3nDP8gDvWmAOgnYe9ReOIIwXzMwuOmSQ1laE6RMmUPWYlHMcB0xScx5bVxH9r7CzZ2yRq32Jw2SQPS+CdW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(2616005)(54906003)(53546011)(4326008)(66946007)(31696002)(4744005)(6486002)(508600001)(16576012)(5660300002)(316002)(110136005)(2906002)(8936002)(8676002)(66476007)(66556008)(31686004)(7416002)(956004)(26005)(186003)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUoxKzFCQ1RmbHR3WXdNYmZwakZoMmY4TEcrS1k3bmhGM252YUVYQk1pOFE4?=
 =?utf-8?B?U1FzQThINEJSaXoyUDM2Zm4xS3F2cm8vQWY4MHBwajZPTmRLTEpUaUtuUmF2?=
 =?utf-8?B?ajlIMEpieEM0cWlha1N1ZkFUektsR2JsTGdTMVlqWVNGeERSUk1uQVl3QTdD?=
 =?utf-8?B?Y243Tis5RG1RSFg1NTJGM2ZFNnQ0SzMzcnZzN1RZSTVteW9lSC9DSnIzb0kx?=
 =?utf-8?B?Nkd4a2dkNWh4TlE1ZHhMVm9IcVFQRWEvMEV4b0o2OThxMzFjOVdodnZPUER0?=
 =?utf-8?B?eng3cmlTdTIwbWhTZHRnUFg3QnlablBuS2VQK3hpdy9TQTlCWEJ2TFNGckRY?=
 =?utf-8?B?U3lndE9vSm9iYzQyY20wbnptbzBVRXMxU0xLOVRSWXVYYjF1WWwzemRJZnJ3?=
 =?utf-8?B?emlYVEtkQll0OXdvWm1UdWZpR3VoZVBhMzV2T0hNZFRJUkhoWG1RRXBPTElP?=
 =?utf-8?B?V0pDRzNyTm8xNGY4eE01UENpNWoraERpUzJUTlZrSVUvT3NVUHl6RWtuTnVD?=
 =?utf-8?B?KzA3TFhIMFBheDZVbU1EcDRES2wraGNPWm5wenVuRGdOaDdIRGpybTN6RlFp?=
 =?utf-8?B?UDUxL0tWeDR2WXdkVlNGaVJHbEtzVllRenN3MCtJU0ozb0trSmxCNnZQTGlH?=
 =?utf-8?B?UGNpWEFLMXVLd21OOVRib05SVExYVGIzOExOa1QzV3hmS0ErUWhxakhLYXlM?=
 =?utf-8?B?b0xLazZHOUZiSFBwS01hRHVpL2N5ZEwxVHNkTG5QRHBNcmZGKzhHWk5ZOWZQ?=
 =?utf-8?B?bCt0bm1odHlETjJpZ2tHWkVaTURQYkVGUktFd1lZSU5GaFpMRklhWWtGYk5x?=
 =?utf-8?B?NTh0bEwvMGtHcUc4U3RLM1pueWM3QVpCWFRqdXltdWFmV3VRWGU4MVZkVGZM?=
 =?utf-8?B?VjhpWWVUb0tvZUVxWEJBb1JjYW0zdU9BZmRBSFFwYkFraEQxNjBHcWRTWVFl?=
 =?utf-8?B?b1NCQzZlUkY5WU1heThCbU9zQjhjZTYvTmlqWStKR2Y1cGhzMk5GNk9Ea2pS?=
 =?utf-8?B?MTZFNkgyRFFBMysxb3VlNUZuR3ZzYmphQXE0YzZYSThyVC9PZ0EvbDZZZTA1?=
 =?utf-8?B?L3pYeWFicTNlcWNGRnMvak9MbTQ5QjU3TkxJTUZTdEdpMVZiNlZudVVCSHht?=
 =?utf-8?B?b0R3UnpSMG9iaHhhWDJSZzdGbFhDejVkWTF3NjJnd2d0K1dNcnIyMUxPQ0RN?=
 =?utf-8?B?Q3Y3ang4SGJXc0NWQUVBYlhqQkZsZ3BndEFQK3FkeVI5SlRmakJsaTNNRlNF?=
 =?utf-8?B?a2Nwb1dxZ201VWVrZDNkQVNKS3dsY1pRcXpYc1NBSEhQNFRFSUVSb0NPL2gx?=
 =?utf-8?B?Zm51dDI1SFZONWdRK1JuSmYrN1FwMFVibGZZTGlsSVJwR29lUTlUZTd6NnRV?=
 =?utf-8?B?TDF0UklwWEJVQUsyK3hIMHlMbjVBWkp3NUNNT2RJajRDRXFMTERodDFIU3ZY?=
 =?utf-8?B?T3ZCOTJ0R3hoZjFvc09tdnZrR0prekZUSjZXcXRWZFp6Wk5GZ3p3cUhPaUts?=
 =?utf-8?B?a0xPUUthNm1lSHF0bWhvZktvUGJZVElqWSttT1VMM0FBL3ozbS9uTWlhWndh?=
 =?utf-8?B?NUVrNWlLdWNRVUVjR2dYdFRjNGJnU05HUWJvOEZpOFR4OFFySEhFV3V2TnBn?=
 =?utf-8?B?QkZDdmE3TUdhaksvbytPSGhvb0dMUUlJZzNRMy9STjhUZDZXcGhPSzBkR2s4?=
 =?utf-8?B?QkNmdlVLMG5wUkc0SFhFUkx3eWNtemxabzBTTGVaMUpBRGZhYzFYN1ZWUS9t?=
 =?utf-8?B?SVdyaThNZTFwZTl0ZlpwS2tKUXIwTWFuWXljekZmcXRUZ2l3dkFreTY3K2Nh?=
 =?utf-8?B?OVRqQVFsWG0wU2NyVGlDUlA1dllaMGZoNGlWaCtGRFdoUnRDME1KZTlzZmpu?=
 =?utf-8?B?UzJZanRVeHc1WEs1R0tETTNGYXQzai84SlhhcUltNk1QeFFHdkFIUXppVGt2?=
 =?utf-8?B?Q08zVmV3UGVscmRlRm41Y21VU3JWMldkaEhUcDNmTDlsRk85eXlUbmlVR0pJ?=
 =?utf-8?B?YnA3LzlDQys0NzlRVFVHdFNuZnFMZDNvZW5SdTlQUkl1dUUyc2dYMDJORDlL?=
 =?utf-8?B?N0FUd3JWZkV6b3dGbVUwNlRlZHhQTnBacGZScXVSdlRYN1p6MzZ4QmN4blln?=
 =?utf-8?B?N3lBU3VsSmtlWFFoY3BScUh1Y3RydDRvT3Y1SjBHYzkxcmFaM0MvNk9zWGdx?=
 =?utf-8?Q?GnXywyB17mZoHK66OcPzSOQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb114d9-6fda-4eb2-e422-08d9a8de3f22
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 08:51:14.6636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcBNdFJ49mQwW/lSObK98yyzzb/z1JarNwhhPJxYu89/IWEINyFwgYCc0CCHjSxXrOJ462Nrn1X/jLY0bcCx1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/21 05:57, Matthew Wilcox wrote:
> On Mon, Nov 15, 2021 at 09:49:51PM +0800, Peter Xu wrote:
>> Clean the code up by merging the device private/exclusive swap entry handling
>> with the rest, then we merge the pte clear operation too.
>>
>> struct* page is defined in multiple places in the function, move it upward.
> 
> Is that actually a good thing?  There was a time when declaring

Yes. It is a very good thing. Having multiple cases of shadowed variables
(in this case I'm using programming language terminology, or what I
remember it as, anyway) provides lots of opportunities to create
hard-to-spot bugs.

> variables more locally helped compilers with liveness analysis and
> register allocation.  Compilers are probably smarter now.
> 

...as long as the above checks out, and I see from Peter's response that
we're OK.


thanks,
-- 
John Hubbard
NVIDIA
