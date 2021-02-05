Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F053117DB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhBFAgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:36:55 -0500
Received: from mail-eopbgr760050.outbound.protection.outlook.com ([40.107.76.50]:64238
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231743AbhBEK6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:58:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1W55xeij28RpJJiW1MsQPwaedRiRf9KFDmH/u4FGSygrkJ83vGN3sOOjZ1EfZ6XQ7q6UTPTz2e214AMnuBLeNKAwhEDTnzpSi7NzpXpmRvMECnsImSiUqwxkUwOf0q3YvKFQ7rq02jjBhX8vVzglWTyeFn7UdTGmt6dieOpKG96wgKqdDZahuIOhXLb3GTRNb1C/an1ww5XuxSZvM7jSzxXdI/3qg7CKK5z3pG/fgoPVMHX/d2zYlumN0B4jPAIDui77ejeuyM0YFw16jG8Dm8lvgFXLw4ySRON0oRo3Tv8+VBVI8GJlE4PPSCU2A1baMYC6ZOohH7JVSHWfLNKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zDAuLEN86gX4ncQqiQecUjIISRKmiV8IedVsE0Agko=;
 b=VlCl8SmUIIxMAr5jnR9vSkWdbOO2jn9kQErba9kal8Y/+iNhmXI/iGVJAGiA78LpKLR0dvUzBn3kP2DDpRf+yg/Sd6ZQXHsYCgPz7rRFQIQYrB3sCoMKTjkrrKZPbTMU+8meUHIkO17RufTsGNLT6Q1xpLiB4NVkPVOYRiEg8151iBC4S9t4eR3BCqtyNM8MUmUvFtpqi5PaZgFmWx6cTy6Ie2MhKTA1+ffTvxndvMf9Y0Fd4wnwwJgcyjABBWkYxVwvTmblniuDHKT4r8iX5P6hrct9kpKZQlOzjw8tSp3L8jZONGnKTY5pCKyAVwj8HWvx/hdmRY8AuYCtDrL2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zDAuLEN86gX4ncQqiQecUjIISRKmiV8IedVsE0Agko=;
 b=AwAY38S+vcXTPCWcPB1GpfDBAYSnRucfZIkJBPQB59YUwfa0OFfIA8efd86EqJzyh5/vBDvpc3ryRKpW65BdX0wgIxUPZXntnkUuFSPazh/eE4ScNy/PTCxhevfEZdLtUqVG3DCcHZf/Bdy7CciLLd+lEj6DWzMpTnONMaV8xBw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4535.namprd12.prod.outlook.com (2603:10b6:208:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Fri, 5 Feb
 2021 10:57:14 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3825.023; Fri, 5 Feb 2021
 10:57:14 +0000
Subject: Re: Possible deny of service with memfd_create()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <e7e6231d-8cf9-80a6-7459-5fec9ee547ba@amd.com>
 <YBwrGNS+Q4JMpuom@dhcp22.suse.cz>
 <alpine.LSU.2.11.2102041627040.2796@eggly.anvils>
 <762ad377-ac21-6d8d-d792-492ba7f6c000@amd.com>
 <YB0i3a6fIhWG7zCP@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3597e38e-ace7-104c-dcc8-59471e11dcfe@amd.com>
Date:   Fri, 5 Feb 2021 11:57:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YB0i3a6fIhWG7zCP@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR07CA0005.eurprd07.prod.outlook.com
 (2603:10a6:205:1::18) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR07CA0005.eurprd07.prod.outlook.com (2603:10a6:205:1::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Fri, 5 Feb 2021 10:57:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ede1342-c120-4050-edd8-08d8c9c4cba5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4535:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4535F6B45869FA4B07C0555D83B29@MN2PR12MB4535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHmhXwoyl0HO6RsZEuCfKZTk/YktmuYOtkeUXyhp9xKwX2tj0d8wXq4qP4rNKGxeG2dEgePrFkQvxMruQNWJk2Z/+RYEcBopKRJDCTBamFSYM04hzM8uKkNv+1b62iY/6Vp35NC7pwhfzdjdjs8XZgykY/jsslQN7VrfrBTCo5JjFaacD6iIuVrBDMlR4FfT9mO4XuxwALEx1ETMkzKCRfwBG0P6uG/uuC85pswtQNFjUH6iNjCkMzdbN5cX2by9VO0OWmctQyTdpbTwA4Dkfj8MFjfadJM9U95rnuPgHa0rozTKDJqAtbHxLIR0qPO7onKHaVsfp4Vun5j4/v+IHLQPG37ILfaGERRlZ8UrS2FRZNGWsuLn1ThNsxJq5jf81HhpLy83l7jdjePuOhw4IPJgyPg7NIHc/eE7BYwFMmhx5lLDbOhBYY+FriIMogmEi1MbJXPvn7QFb+aBclCvvPTunlZXoVHLF7hvMlkQygBkAVPI++qZd4LSGXiNODPvF9YvSyM4P9fFmHVxu9AHMTXMXHFVtPzgwa7+9DLF8jDyDI0DruQ3S3DTYzZlzjPwq80efmwcmyYsi+cHaVETSR9SNR3rzRAFgXR1zcyL4fU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(83380400001)(36756003)(2616005)(66574015)(31686004)(86362001)(52116002)(6666004)(5660300002)(16526019)(8936002)(6486002)(6916009)(31696002)(186003)(66556008)(66476007)(2906002)(54906003)(8676002)(66946007)(4326008)(478600001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z2U3RklCQlI0c1dtVVRkK1FNUDU4MGV1bmJHd092SVRjcndxejRIbWN0c0RL?=
 =?utf-8?B?VWJhZUlNNlFNeHJXRHlZMEM5U0NHY1p0UXg4TXFLY0ZHNW03YmF6VWRSUmNi?=
 =?utf-8?B?dzJTZFNDNWRQTkdaVVlhMFNoQmNtTVBhSG1kdXpjbVhLWnl5SmlpYzMxRzB2?=
 =?utf-8?B?V0JLdmhQTHg4eFEyOFZNT1R1OHIwNzdTMzF6UjRlZkdZTlU4eUtEWktXZkpG?=
 =?utf-8?B?b1VCd3FaeXY3MmRLYnNWZElya1grRDNKMDk1Qlp5M2hYa3c2SGxyMW5PS3lR?=
 =?utf-8?B?SlpJRUV2a2t0WndKMWduWjM0ZG9nMWs4dnhFeWRSNXdpSVAvSU5lNjhTWU5i?=
 =?utf-8?B?emJDc1ZpK2MxUEVFV2h4NnlSUERhNmpqNXptbEpPVitueHFsN294czZnL1V3?=
 =?utf-8?B?NkgvRFdxNWZCb0xoUERhZDNLQzZjTEtTdC9uNDJjRTZybjVXT3lTUmxXOWZn?=
 =?utf-8?B?RGx5bVlyL09ubmhRbkJCeC9iSGFXTC9ORk0va2lPTElucnJhbUpKYTd5c2NI?=
 =?utf-8?B?dzd5M3UyZFlhOSthS1hiSlE3VDBjcDBEM1R1SWpCa2lOTWovYTNyY09JaXA5?=
 =?utf-8?B?cjZpbklEVWQzWEROUy9yVHRGOU52MU9BOTJXUGZHbzhoWGNTSndVMXJVeDFl?=
 =?utf-8?B?elNtcHM4RjhBNGZYYlRLSHhIaUhUM0ltVllJaG5Od3R0V0xNa3lSMEtEVVla?=
 =?utf-8?B?Um1JZkp5RnVVeCtmdGxWV0ZZbXpRYkdoM2NORnBGWlpjQlplSnlSb1YxYjVx?=
 =?utf-8?B?M1ZRRzJLTjVvSVBzVXJvYXdYcGxhSUpzQnV3M2VQcWw0ZDFucVpsVUVSMXBN?=
 =?utf-8?B?MW1JeXBVQVJ3NWdiZERWTFFRQWo5dTlxRTZpMXVpOHk4bXk4TDUyYUZ0MkRU?=
 =?utf-8?B?eU5uejBuazdjVVRibjBkQUx2WSswVUJtdnU0cnNxbTlOc1AwYVVydmtBQjRR?=
 =?utf-8?B?U2pVSDRlWW02OFZ0SktPeEZHcGhINlRqZGFuK1NTRGJoVW1JaGduaWVzdU9Y?=
 =?utf-8?B?ZU9RVFA2MVpNbkdqa3NqakQvWWhVU05WTlpvS3ZRd0FJNzh2VlpMSllmMU44?=
 =?utf-8?B?K0hiSTVJYTc0RzRnTHFaeFE4c1poZzVxTkpVUnZVVWFoT3haM1ptdEJrTElE?=
 =?utf-8?B?TkI0TnZ2OHd4ZXhCTGZqQW9pdmpzTmVTSVpOYlBOQkM5eUVwZmlOZTBScHFn?=
 =?utf-8?B?dHlUOGwvQ0tMS3ZoTC9CS2Nqd3ljV2g0WGhCd0w4MGdhRDB3aEFHWFpTenVo?=
 =?utf-8?B?dm1JcWdpaDdGcTRHc2RwNUFaSTkydHhVQ2ZwVHkxakFHaVNUNTBjOXJnd051?=
 =?utf-8?B?Y0JJbXlTSFRXV1hNbVZOQWkwQUlqTmlSeFNucXpudU1CSk10S3E0TXBrMjZj?=
 =?utf-8?B?VCtYZmlUMUU2NXlqNTJMY1dYeERjd1dHcEZYeXNJQlMwdlNYcll3b0RJemRO?=
 =?utf-8?B?a3UvSkxydjE2TlIyUkF2aWZrM1VWN1dNYWJ4WUJzRnJUaXYyWkpKY2NrUHVY?=
 =?utf-8?B?eUhVblBHM3l4dDMrRUNLdHc1aGhiTG1BbitLTlI4NzBKRkExMElhOGp6M0tI?=
 =?utf-8?B?ZGFuZDBUa2FzemwvUEh5YzhEeWxUcHRiQlovZ0QvUHgwdEpDelk4RC9YRHhu?=
 =?utf-8?B?ZWUyRW5PVWI2WEdLNUgrQzV5MmRJNXlLV08wUmhvcWRGSmlMUDlQajhpMy9i?=
 =?utf-8?B?UVBCUTJsckhKUEpWK3JyYVBJYmhVMzB3MFpUamcxeE0zRFlNc2FSa3NKTWN0?=
 =?utf-8?B?TU1JeElpK3BDeit4dlI1YWV6S1dxZys0SXFrSEdSSTZmNXVkdlI5MkRXV2hw?=
 =?utf-8?B?V0t1cU51VnFJQ005c210OE5Ub25QdDh4TjkzbDZzcG5KVmd1Q29EdUc0WElK?=
 =?utf-8?Q?ZuIkOFfkSWLRc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ede1342-c120-4050-edd8-08d8c9c4cba5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 10:57:14.1876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqSXY1iv6zSXglGGPuumhp1vjM/JwMIdhtP2nGe+iUKebxza/sN6bbtV7cbybUfP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4535
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.02.21 um 11:50 schrieb Michal Hocko:
> On Fri 05-02-21 08:54:31, Christian König wrote:
>> Am 05.02.21 um 01:32 schrieb Hugh Dickins:
>>> On Thu, 4 Feb 2021, Michal Hocko wrote:
>>>> On Thu 04-02-21 17:32:20, Christian Koenig wrote:
>>>>> Hi Michal,
>>>>>
>>>>> as requested in the other mail thread the following sample code gets my test
>>>>> system down within seconds.
>>>>>
>>>>> The issue is that the memory allocated for the file descriptor is not
>>>>> accounted to the process allocating it, so the OOM killer pics whatever
>>>>> process it things is good but never my small test program.
>>>>>
>>>>> Since memfd_create() doesn't need any special permission this is a rather
>>>>> nice deny of service and as far as I can see also works with a standard
>>>>> Ubuntu 5.4.0-65-generic kernel.
>>>> Thanks for following up. This is really nasty but now that I am looking
>>>> at it more closely, this is not really different from tmpfs in general.
>>>> You are free to create files and eat the memory without being accounted
>>>> for that memory because that is not seen as your memory from the sysstem
>>>> POV. You would have to map that memory to be part of your rss.
>> I mostly agree. The big difference is that tmpfs is only available when
>> mounted.
>>
>> And tmpfs can be restricted in size per mount point as well as per user
>> quotas IIRC. Looking at my desktop system those restrictions are actually
>> exactly what I see there.
> I cannot find anything about per user quotas for tmpfs in the tmpfs man
> page. Or maybe I am looking at a wrong layer and there is a generic
> handling somewhere in the vfs core?

I think so, yes. I briefly remember a discussion about how to implement 
quotas for tmpfs, but that was a really long time ago and I didn't 
followed it till the end.

>> But memfd_create() is just free for all, you don't have any size limit nor
>> access restriction as far as I can see.
> Yes, this is unfortunate and a design decision that should have been
> considered when the syscall has been introduced. But this boat has
> sailed looong ago to change that without risking a userspace breakage.
>
>>>> The only existing protection right now is to use memoery cgroup
>>>> controller because the tmpfs memory is accounted to the process which
>>>> faults the memory in (or write to the file).
>> Agreed, but having to rely on cgroup is not really satisfying when you have
>> to maintain a hardened server.
> Yes I do recognize the pain. The only other way to mitigate the risk is
> to disallow the syscall to untrusted users in a hardened environment.
> You should be very strict in tmpfs usage there already.
>

Well it is perfectly valid for a process to use as much memory as it 
wants, the problem is that we are not holding the process accountable 
for it.

As I said we have similar problems with GPU drivers and I think we just 
need a way to do this.

Let me think about it a bit, maybe we can somehow use the file owner for 
this.

Thanks,
Christian.
