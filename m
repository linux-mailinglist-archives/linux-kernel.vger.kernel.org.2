Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C2D310618
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 08:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhBEHzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 02:55:36 -0500
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:5248
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230406AbhBEHze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 02:55:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZsC1u6FWZvz3ZdNcZQhBbrhDrGjXtUwHIKHHNuiuK57Rpe3JEx5+PHqxO2Z819mWuaBf8F2cu8LPG3o4wR6fpnO/rqLDVOsyUYV5SAl5a4zShs4+ok6V05HGTA033v8iE650IDBTcgtvqgrbi+czQkd5+PsjPKuLXeeUX5x4HFKXXZ47QvQoCK6M0dCBXLyBbLRC4x0zKy0sVCCVGI7s6YWoNrVVGvprnkbv/b2PhnTLXgbdNaeZvXiXebRe361Dk3LkvAGhvoNJjB+yR17KSGMeoHX3tkdyusb8JS5JCAFfSaeieR7nJwKD8eXCvaWFvozGE8FLaEiN8htIrDBfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOE9cE/e5tU8c4fx0jyFp9aO6ma0Jctskbbv9yA0VRw=;
 b=NNEVcOaq5GgEyVWZ91MQOlQPihJoD8fNOBNSNIcAMTwJt8C+Gbyg5X9eBCTkXm3SAdUByapDxBJBZ9zgNNIYxHA85Z5ZtofZuima3ywn013pC8AgfFlPDyftlQY7F86e17sxDw8P0fZ5A6qu0rhbUfnLOnLh2aBrlGXtvba/uQXXvaa65bLyeIfupaSDLCJbPQpCoyGNpf6LGgAcL5xHeBqHX4QlsDZST9kt3qy/DLDkmgAKKmwB7UXaYLRmt7Xh6edBm/JmAWHhyjnjN6soY5mSDuD4k//s19tLQD9XyDCf/t5WXXOgKXDCYioEF9UY1OI+SvpmUKLR/xkopZtCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOE9cE/e5tU8c4fx0jyFp9aO6ma0Jctskbbv9yA0VRw=;
 b=5REJIHkgFhPauJVUM/l5sHUGkmpAKDbCZpIbBCfL3+wlApzrL5rkcBUMuLncQy1wR5H32/KIua0+3pSPb2Y+ic0u+frjFSIWn6qb4H82NJk/JBYH+9xB5qXe0Ks3EbqZTm9sP9oHWXA4vbqgrTBmrjXYETK593lDOio9NosLCGM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (10.255.86.19) by
 MN2PR12MB4390.namprd12.prod.outlook.com (20.180.247.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.23; Fri, 5 Feb 2021 07:54:37 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3825.023; Fri, 5 Feb 2021
 07:54:37 +0000
Subject: Re: Possible deny of service with memfd_create()
To:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <e7e6231d-8cf9-80a6-7459-5fec9ee547ba@amd.com>
 <YBwrGNS+Q4JMpuom@dhcp22.suse.cz>
 <alpine.LSU.2.11.2102041627040.2796@eggly.anvils>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <762ad377-ac21-6d8d-d792-492ba7f6c000@amd.com>
Date:   Fri, 5 Feb 2021 08:54:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <alpine.LSU.2.11.2102041627040.2796@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR0302CA0008.eurprd03.prod.outlook.com
 (2603:10a6:205:2::21) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR0302CA0008.eurprd03.prod.outlook.com (2603:10a6:205:2::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Fri, 5 Feb 2021 07:54:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 27b79db8-73e6-4524-0eec-08d8c9ab4880
X-MS-TrafficTypeDiagnostic: MN2PR12MB4390:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4390E0B174AFFB51F9E3532D83B29@MN2PR12MB4390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q92g/aGVy3ZB2ALTXYmyhRd+dMCUln1ty9NiqoEhZHUL24NeZnfLkj+NmTxoJ2DIQ5q6L9xW3AM0hUDHsvPxCRfHYOW284S7Lb2gxAKYvggrUMBbaqM6R+XrlwXqK4+wZl1SyoMEs92ZdbdJcA54eIEiAQaksC8NMGNBQxyNKptHEJTsC92cuiqXyqM3zxWmzVLrDYVaYB0xEyjzluwP0nboIBzvlV9AD2CSzRrz5bhhjIN7qDGqGQm/RVAj2eBC/SSZLuW6BPX6xVBu+BWtEvritq5LVvetF5FQdowMRtuwjl0ZZZP1+0j3XgD0QLiM0wiHcPEY0EuIx9LeqoCPemvsnWuJHiTwgggACNha2QNLwIvX4XaJiKUYIv8nbpgrGT00tXQhSgBerVTVYEHKGbK7mNDwdGdxvic536/FIQ8Rd2RqtfIGE17giGniEbBoVy0bB22303UcxGRYlan4NwcwOnt1IvHUxYcE6k+nMqV039St0I2L+JDcH+RxmCnbVM7DUJCOY0wFrJqr5CmVGW/Yq7fFh1lXOSWBB9azXYkZFYsJFKw9hzcdEu/fRNH2PIvK+pqYlMrDcHR1499zKnSsg5Q80wKPph5QfvcVQNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(31696002)(8676002)(36756003)(86362001)(6486002)(2906002)(8936002)(2616005)(4326008)(83380400001)(16526019)(186003)(316002)(6666004)(110136005)(52116002)(5660300002)(478600001)(66476007)(66556008)(31686004)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cU5sMGhZUVdHWW5YRjduNkhCc2hJcVQ1OUc0SUZudE55eWFtSFhxU2Nnd1dG?=
 =?utf-8?B?a2FuenJjT1R2djlRNndXYi9qOFZHL1hORGM5TEZNR215NjU5a1lDQWNwOWxV?=
 =?utf-8?B?OHNQd0crbXhXL0c1dnd3RHRBR3BiR001bmdSWmRMbHFZUW9JdU1mQiszOWx3?=
 =?utf-8?B?TUh0UXRqK09ud2tMQ1BPNUJrTnE0TmQ0VjA3cFhKcjhCbnNHcUpRK052VHlh?=
 =?utf-8?B?THFWdWs0MmpFWHc2aHV2U1JCU3NWbWcvMDhpYjFEakVzYXNWYmlMdXZIaHU3?=
 =?utf-8?B?ZEIxNE5VUEpvakl6Q0praUpEazdwaytqMEVCbEk0ZTdwMndmSjJWUDlNdy9h?=
 =?utf-8?B?RkJaU0RJNUFERTV4c1NCbW1rWTJ6TEhaRGZ4eHhvSHBGaFRoenltSmtFQmdn?=
 =?utf-8?B?dVJUS05FRFE2Tk11SXIvVmJ5MEdsQWpkVk1qRWozeG5IMlNndWVHczc4Smti?=
 =?utf-8?B?M2VDUjJEekEydEVKTXZlbXVnLzJrdHd4bGtZd0VTcy9xWVlXTmNxMDk0TlBs?=
 =?utf-8?B?NUt4VmRyQU1EeTJOdjh5OVYvZkFiQkxkN1piOEhFdXQyRGx5SS9NUExEYjJZ?=
 =?utf-8?B?RTZ5KzFjNmpUc3RkQ3Z2U2pySDF1REpMK3p6S1VYL3lFMjV0b0w2dHdTenlw?=
 =?utf-8?B?RXdwUEJjYXFWQzJLdS93cWwxaWNRNGJOczJ2WnkrKzRIQVZRbHZxK01veWxK?=
 =?utf-8?B?RHhxMmkrZ2o2bTIzSjZEY3ZrelVnSU5veUhORG1laU1ySlhhZnJDQlhZUGRy?=
 =?utf-8?B?RUJjYWNzRkJjTENibDYvbmNJekQyTFFrZ1VVV01EVWdSb2h1Z294Y1FZN1RC?=
 =?utf-8?B?WnNMajQzemJSNHVZRkFIOHhPbjlTTzZzMGJCTHpORDQzRkVGeEJ0T0NFTVJ3?=
 =?utf-8?B?VXBidGhjZ05nQnRMSVFSVlE1cnlWMnp0NjFNWHZucmNjeExaSDVaczBPK3NM?=
 =?utf-8?B?VFBLUnBnMGIwR3c1Vk95R2o5eEsvbW9yNEcrYjhwY3NnRmUzV0JFZldScXpX?=
 =?utf-8?B?bUpHeDljdkRSQnBuaVc4NVlUbnpJTDNlT09FcUpqMFlMQmR5YU1Cd1FOdENI?=
 =?utf-8?B?WllKeURudnB2NUtjS3lpQlo4WmxBdXFCZHlSd1BicjAwbGRlR2lhY096S1RV?=
 =?utf-8?B?cnVQUTZrRFlzOTJiS2dMSVNET2NjUU5qS29ESzdPZ2g3QzBqMVlmSExMQXl4?=
 =?utf-8?B?cklKZVNjcWNhcktPQ3BPUUlGNFAvNlVoUWNyczVJUHU0MktZOWJpMjVoWlA3?=
 =?utf-8?B?S0laYjdhazJGNEpxd3NJY0tscXdzZE5XUnVKa2FzVHk1OFBXckJuSWdPSlRY?=
 =?utf-8?B?TDdnbUpObS9HQU5KYjdURXRoMzNjMnlWcFFNYnpxdzY4djJub2x5T1IvUC9p?=
 =?utf-8?B?TXNJOGpFczFZL0o2ZEV0WHVwaDRzd3krRkVTcmVpWmpsY3N6L3RETmRnQUZh?=
 =?utf-8?B?THhwTjkzZ3hEay84a3RTYWcwRGtQYVlmTTlmSFRkdk5QSmQwa2EzbG14bS96?=
 =?utf-8?B?b3F5TytxL2pKdVQxYVV1VlNzM1NiVFBld05hSXdXdEplb0FwcVlDVEFrY2ZN?=
 =?utf-8?B?N1NJc2FONFN4Yi9PN1lqWkFzM0JrMi9XMFdIcjJqWkFxV3pGTDJzYlZkZ3RN?=
 =?utf-8?B?c3N6dXlUNlFzNUhRTUJoMmxqeFhQbm1KamxnRFYzSmFiQVNIdWhCNUpnQWJ2?=
 =?utf-8?B?a1FVTGhRcWIySVNzQ1J5WkZYRG92cmpIYS9mWWJrL0lVTjVxZlQrbG0rK1Na?=
 =?utf-8?B?UkVyMFRxQzRNdWFadEdaZk4zVFdXamhoOGRZMkVuSk9IdUJxZ3dmczY2dFM1?=
 =?utf-8?B?SEQ5dnY0REJCOC94M3BXblVUdnJpRkpqaWxlYnJpcXlXQnB3MkUwMFphRW8v?=
 =?utf-8?Q?sCmnLgbo95S+z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b79db8-73e6-4524-0eec-08d8c9ab4880
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 07:54:36.9545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHnjmOmXBd7GZHdwT85I4F96OiUGok/mIfye4o/H6xp84z+iSQcYEYNzh01lkDUn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.02.21 um 01:32 schrieb Hugh Dickins:
> On Thu, 4 Feb 2021, Michal Hocko wrote:
>> On Thu 04-02-21 17:32:20, Christian Koenig wrote:
>>> Hi Michal,
>>>
>>> as requested in the other mail thread the following sample code gets my test
>>> system down within seconds.
>>>
>>> The issue is that the memory allocated for the file descriptor is not
>>> accounted to the process allocating it, so the OOM killer pics whatever
>>> process it things is good but never my small test program.
>>>
>>> Since memfd_create() doesn't need any special permission this is a rather
>>> nice deny of service and as far as I can see also works with a standard
>>> Ubuntu 5.4.0-65-generic kernel.
>> Thanks for following up. This is really nasty but now that I am looking
>> at it more closely, this is not really different from tmpfs in general.
>> You are free to create files and eat the memory without being accounted
>> for that memory because that is not seen as your memory from the sysstem
>> POV. You would have to map that memory to be part of your rss.

I mostly agree. The big difference is that tmpfs is only available when 
mounted.

And tmpfs can be restricted in size per mount point as well as per user 
quotas IIRC. Looking at my desktop system those restrictions are 
actually exactly what I see there.

But memfd_create() is just free for all, you don't have any size limit 
nor access restriction as far as I can see.

>> The only existing protection right now is to use memoery cgroup
>> controller because the tmpfs memory is accounted to the process which
>> faults the memory in (or write to the file).

Agreed, but having to rely on cgroup is not really satisfying when you 
have to maintain a hardened server.

>> I am not sure there is a good way to handle this in general
>> unfortunatelly. Shmem is is just tricky (e.g. how to you deal with left
>> overs after the fd is closed?). Maybe memfd_create can be more clever
>> and account memory to all owners of the fd but even that sounds far from
>> trivial from the accounting POV. It is true that tmpfs can at least
>> control who can write to it which is not the case for memfd but then we
>> hit the backward compatibility wall.
> Yes, no solution satisfactory, and memcg best, but don't forget
> echo 2 >/proc/sys/vm/overcommit_memory

Good point as well.

Regards,
Christian.

>
> Hugh

