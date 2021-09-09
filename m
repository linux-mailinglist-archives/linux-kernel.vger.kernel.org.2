Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAA1405B4D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 18:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbhIIQv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 12:51:59 -0400
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:24801
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234524AbhIIQvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 12:51:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKnUHWE1TBA5vIh5ho0ZpbxPAZyb4YyGJAnrZuyn//Ov/5M6+rDVGkSmbjJEnmUIBXcZz7jHH7R5R9nii4Jk6A6KMSGKVBu0mK7k8/cc2fullZR6fxjA47ZzAbFFbq3emSJ+z4vDdLEVrNqvxLk/2c142S390gn8PDNpr8SbOGY1BQ7Jst3DE3KryiEG52YTJmaaeMNRpduUeJzGeGds/0Xni0RwLAfP7oveRFX3BkdYtmlQzyc3TqEMpYbdOVGAVxQp/nfiSmBUESsJ6LS2axWVTAYjkr+cgYlhdXV7rYQjtj20XedY3pev1nOK7Pm0tzR40ZKmfPfCEpqo3erbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IHtSLSzyTK4SCMR9VBn1c8YOyoMMHG5gTrhy7TLIiOk=;
 b=oQwRGI6LI9b9+KZZL1OkuyflDxvsgZlXysk30Q9KA61WUXqX5cD7DDQyYfXB8hq+CdTHSbqn01P/GTObyy5acAgzCyAgzb30J4dZ5wL7cjbyhM4PnXB/1rMRmzSxVKEhV6l35HVzXX3puNI/DYqg8bkWrP/88oaJvyAsAuLNaHiZG1SL5KSu2UrjPiyu4x81ZyU5NjrG3yCrXKe37KgjDR/V0tjmAPbfs/mfgyBskVJ49KkkFRxWMrNMrKsb0jglm7K5DKvCJvmxXXAG0fJYDZpX/Grofy4LFUaoU6qWgM9L1RsaSt79XPb+OiIHmnpfBUOSqhmXdwYdBBsn4va3XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHtSLSzyTK4SCMR9VBn1c8YOyoMMHG5gTrhy7TLIiOk=;
 b=F2GloDs4AQUoSt1aS4Dzfxl/LHC5xm6zZ7glRpPgXI4BYME5PREE5aBs+vyaQkI/RuUBfu1BA+kfxdLJaFkbW0bkpwbwOYpwf2XHhcqhB5lJCyxaYtHe4ql9IrQVqnADM665mj/vb/2mvpWWDnOrVtEpzumhYklMZN75ebt4zGVKZDpabKdIdrxIs5OjoQQFm71B+h/r31b/kF4Xf7FpFgJ8cp3jV7A06zqxbyTXCf3Hg96g4r5nvpCPJpIOWyoZgOi5CIy4V2tmQeo1S1oaY4PqJA7wkvGvqlcQBRGeT6l0HRi32w9nZG/q4Zt6ZCZVkLkSr0ygC9xp/5Bqf4zZWw==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB4790.namprd12.prod.outlook.com (2603:10b6:a03:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 16:50:39 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9%9]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 16:50:39 +0000
Subject: Re: [PATCH] mm/page_isolation: don't putback unisolated page
To:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210904091839.20270-1-linmiaohe@huawei.com>
 <3b36529f-ab97-ddfe-0407-66f0cd1fd38d@redhat.com>
 <2d06db75-5c26-8fe2-6883-ac99056a9894@redhat.com>
 <b0a2947b-360a-40c2-03e4-f0f67845f4c3@huawei.com>
 <c60dc5e2-6f19-3be8-56be-555033cc9ca4@redhat.com>
 <b4615b3c-8217-9f32-39c7-b91c9ec3cccb@suse.cz>
 <80cfffdc-227e-c045-be74-1c08fb62c1e3@redhat.com>
 <febcceaa-7d94-c3a3-c683-7a8694981b47@nvidia.com>
 <efdab0d6-199a-1bb8-79bf-ea0a5b94c093@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <88bcab16-b248-3cdd-1270-1f162f43019f@nvidia.com>
Date:   Thu, 9 Sep 2021 09:50:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <efdab0d6-199a-1bb8-79bf-ea0a5b94c093@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:a03:60::29) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.63.205] (216.228.112.22) by BYAPR07CA0052.namprd07.prod.outlook.com (2603:10b6:a03:60::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 16:50:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1afa96ad-82a8-4e10-f853-08d973b1f3e1
X-MS-TrafficTypeDiagnostic: BYAPR12MB4790:
X-Microsoft-Antispam-PRVS: <BYAPR12MB47906CAED08E4875FDF52EE2A8D59@BYAPR12MB4790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJ2LyN0/HybzPvI5c4My/oH0GZcQTT/E3KSkrZUCjsiycXmVvg7MlhMKZW7OIqdD5fNcT+8tsstl5L8rUaOop7ibRfv6BuTkuIQu6MLlzDL1KqiOgK8hFMamu4NCwz8M4wuBvOkVsuNTd7dOl4KxiyPucw+ETFUs8FxLpBtCRyE/ZMX5H46NKsWSGf720VWAJWzotsNxKWbrVOb5EizhGvBiuPWIwYak1GRJQEDhif44ii+JFKI8MwrkOZFYh0ov0P/RVCz5GEuRT0LdIt1KQi9/RcaKjDv3sHvaZSVzHPpn785tTqFC2o1uQA7B4ww2AE3taxt5+b5JiyjF7iHMhDzFVDV8sZUsmQUxC84mcwV7Y471dSpG4KX9d6K1lwl0V0kzn7o+4cWOkbHGBb5BFxN61a3A21A3lD16lZd3wIi+ZY0XeiFlClIYPSMOdHn/wv9n3I2bhFt3CqpLqTZVKWphRiLRfYQEz9qwoL5XeC2u9H1YfLXkcjvlE2/ZR6kQdw8Brnt8dl1YQxr+TTXd5GFOk5yz0KIiB2X1kJwjbkkkJ7Minz6iT8L/2Ig+Bb+zEq2KydkwRO7nskQj8HMZ35HnM3FLk2Enu5iOlAjjK9/LYG5k17mmWS3+rLxWo+bewdUgGdyp7nug3jdav71uyi/6jfZ1tJ9m0BCoNSfoEiliRKaH7yO8AxtGk+gqb8Qar19WMExcxqcjvG9dsDImRhPpSW/G8x61Yj5R/2HI0VK09gUPblKzZ0oM8ccKlO02
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(31696002)(86362001)(31686004)(478600001)(6486002)(66556008)(66476007)(66946007)(8936002)(38100700002)(83380400001)(316002)(36756003)(2906002)(53546011)(2616005)(110136005)(956004)(16576012)(26005)(186003)(5660300002)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXcyOGxOOUpxUlVZUlE5ZkdpZDZoK0NzMW8wRHV2a0FQUGR4dWdCOGhCaWhP?=
 =?utf-8?B?SW1oWU0zdmt6OTU5dnFXL01DTTJuM0J2WGJnaFBmZ2d0ZktraG04eHlXQ1hD?=
 =?utf-8?B?ampNNmtEeENjZC9NVSs5aEJtUWQzZmVQSUlFT3dIMFZsZ045MFdWZ3p1U2lE?=
 =?utf-8?B?cVo4bE5qYzBzTHlCK050ZWsrSnJXV3J0elBERHUyWDdVQUhJLzh4aWlsbk04?=
 =?utf-8?B?YVlkc0pDaDFtSFI4RXB0ak4vbXIwWHpEL2tFR3VYK2o3TDd4SDNzT1ZTZExJ?=
 =?utf-8?B?Y1gvVjY4SVZCNnlSampMTDJvV3c4djVDaXBJRXArTU9EVE5XSzE5ODhXSVQ5?=
 =?utf-8?B?TXJNaGM0a1laa2NiTUJsaEhlbytYVzUvd2JDN05ubVpaWk1waFRiNm0zU0xS?=
 =?utf-8?B?UHNXdEhCWUlORE9zZUp1N2ZvWE96Zjl4UGZjcjMvK2lRc2lyTVBMczI0bWNQ?=
 =?utf-8?B?VExOb3ZScDJDcE5wVTYwOXJmQ2ZUekorZElTTnJwcExibGwycmF1R1BxY0RI?=
 =?utf-8?B?VThmNGE1SmhjZTZrWjNUdTRVdXp4REp4bGordXkzdFJQMGdWYmRIMVV5UTU1?=
 =?utf-8?B?cmNRaU1xcUMyZjg4OEVmSXhPd0lwM0Q3SktTMWdUSFgvdFpSenNtY0VRdytS?=
 =?utf-8?B?SEMzRzh0bm5xL2RkYzlCVDY2aFo3VjJ1UzNDWTdHeFkxZWo2alFsRmZxN29v?=
 =?utf-8?B?bzdWU1R0N3YwN1g5TlNQQmVINC9zVm1TUFpLOGUzeGR0TXhOWmFXZUhuRnJ6?=
 =?utf-8?B?a010MzVTK3VhQSt1N0xCQnNtck5wdnB3TWtldUZYTTJnRGZETmllV0ljUElN?=
 =?utf-8?B?bGY1SEZHOTdqc2drUmQyOHRkVzRTOUViakZYZ0Y2RzFYWThlNDNJY3dOSW9z?=
 =?utf-8?B?NEU3aWdzc01qWnpJK0dvZEd1dDZsTis2RG12eUtoekNRS1Jnc2p4ZzBLTTJD?=
 =?utf-8?B?NU9MMlJhQ1VnSG9lYVZiVFlzVDd2dmNOQ3daUGhDbWNKWmEvR3B1Njhqc0lE?=
 =?utf-8?B?ZHh2SFlGVWVjRElVWGl3a1IwMjNyMmw0c01Pb0FIblR2U0pGa3VDRW5ibzBV?=
 =?utf-8?B?VHFpMUErOWhaOHo4cTZKRmlQZXJvWFNUQmdpNHg1QVZUanQ1aTBxRzJJeGQv?=
 =?utf-8?B?c3kva21SRWxsY3RwSFlJY1dFeEllY1ZDYXd2QnVGUzJSQVJDQXRla3BUdWd0?=
 =?utf-8?B?bkNySVlVRUxnRGtqT0FDSlFhY250QUxxOTRIeVdjNm9wa3B6VnJpT3VvQVhh?=
 =?utf-8?B?MGJDcGlBQ2UvTXkvTUxZcFNFQ1psK0FuYzlLKzllNllLUlZwZ2FUOEN0VW5X?=
 =?utf-8?B?S2M0R2piV2FnSTRaME5ROGtWVEZQVTdLM1FDa0pmTHEzZnd5V1RhMDFVRHlk?=
 =?utf-8?B?d0lvUUd2M3hyV3dlSHloQ3RwWVhYTXY3MEdnQmYvSUtabm1mRVdodUxDc0hp?=
 =?utf-8?B?UDkzcDU0WkRsMHlIMi9ZZDRzT0d3YlNod1E2ekVPWGlma0d2VWZNNUtuM3Fm?=
 =?utf-8?B?NWo1a1Frall6R2QySkRNQXYxRXppbWhDRkdOQ1pKRDllM2ZEVlQxWGlhbjE3?=
 =?utf-8?B?bWZyQ2c1Q1VuN2orTWJabTNRbTRNbVZzMnNpemdWaTFNcG5lbEUwNzBGMUlY?=
 =?utf-8?B?TDNlczRDMWhLZ2NTcjN6ZWxKc3pBWDMySEZNTEVmdjZIbW5LWFF6d1BHSWdL?=
 =?utf-8?B?eVI5N3Fnem5xenlXcE16SUs3dCt4aTRBUmY5S04zaThJMVhrZEFtYkVvNDd2?=
 =?utf-8?Q?GWiOyIMrPV2xXqYMC8e1v/rprQvYSCzuNGH7jAy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afa96ad-82a8-4e10-f853-08d973b1f3e1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 16:50:38.8958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAv9LJEi6N5L23zw/y3fgGkEnJrihNiYEzcP8pIliG44acX6+Ss6dhObbOGnfRGpWOxFMbrNy/fxY7514CtaVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4790
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/21 1:56 AM, David Hildenbrand wrote:
> On 09.09.21 00:42, John Hubbard wrote:
>> On 9/7/21 2:56 AM, David Hildenbrand wrote:
>> ...
>>>> If this can be handled gracefully, then I'd rather go with VM_WARN_ON.
>>>> Maybe even WARN_ON_ONCE?
>>>>
>>>
>>> I think either VM_BUG_ON() or VM_WARN_ON() -- compiling the runtime checks out -- should be good
>>> enough.
>>>
>>> I'd just go with VM_BUG_ON(), because anybody messing with __isolate_free_page() should clearly spot
>>> that we expect the current handling. But no strong opinion.
>>>
>>
>> If in doubt, WARN*() should be preferred over BUG*(). There's a pretty long
>> history of "don't kill the machine unless you have to" emails about this, let
>> me dig up one...OK, maybe not the best example, but the tip of the iceberg:
> 
> Please note the subtle difference between BUG_ON and VM_BUG_ON. We expect VM_BUG_ON to be compiled 
> out on any production system. So it's really only a mean to identify things that really shouldn't be 
> like that during debugging/testing.
>

Yes, but the end result is the same: it halts the system. It don't think it changes
the reasoning about BUG vs WARN very much.


> Using WARN... instead of VM_BUG_ON is even worse for production systems. There are distros that set 
> panic_on_warn, essentially converting WARN... into BUG...
> 

This is different than BUG: panic() *prints a backtrace*, and then reboots the system.
That is still awkward, but a little more debuggable.

thanks,
-- 
John Hubbard
NVIDIA
