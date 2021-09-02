Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D19F3FF1C1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346478AbhIBQpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:45:44 -0400
Received: from mail-mw2nam10on2087.outbound.protection.outlook.com ([40.107.94.87]:49057
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346424AbhIBQpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:45:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVyqXtgqvk5ALP7OGFyhv3oPID1gyddRgS/iHIf6BMtNYmW9LhG6hrkp1QnCvU7gOaz2v1w3BuPHUVFkBl0NCk6NIIhDDTv+EzPoaAMGrd7drGWwKA8rHJsNpvwFISX7u+NwPQ5imnstwPIS1nW6uNtGTeaaexxNfNGPOP6MjvHu7d/H6fS2ovLl1geIhgbcNiCrTUMXkszkRB372egNF7UtXBznRy5sceW7JHVrtUO0UpM/Xbokx98S4QvuBQXiDC8ZLhwGUJ3zb7Xhk3AhHqFbUbj4cQh8lzuUiKynTi/yvIdWLNxIm92LEWni59MLbcEpFWojwWgF3E7vlZVvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kzgTN6LC303Ovl3KK12Z9uvr2iLm9qQb2xX1wanohfM=;
 b=l/RKS7dN8dDc5OgQB8OYtbTlnFrEVLJQcjooGYc9hOiL44296Aq6haTK9NjFBE/tObW26AJXN4oVZar9h4kPNCzopjgthxwbtGnSSPLV+0wrB9/RXTDsuYlaJrxeGjAFDDRXKCFH8HnY8JhrXT1NjJjdo4g8ignOGoM2H5GhytjoJ0aTleAm6SwRpf6qXuFWM4PNkg2cr2vwFpDTrQhzsxhO2SiTQUFrO7S7sGNR/P1Lao28zjWemXF/CxFhNg1xUOas2Y402z/2NDq9+HMi9IU7mkw/pzicS62nCqYhAHwMS9ldrIO9sA/oMxFxzCUYWMNH+uIz9n0l+WMxaICY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzgTN6LC303Ovl3KK12Z9uvr2iLm9qQb2xX1wanohfM=;
 b=OTpDa3nT8T9KgVM22meyDIu0DKlMZh2/54HHvWVCwFVWNQmjXjiS0KcEvR6utmr1f8VS0oAKs8uP9pp6/pDkfc6szZDlhUYp+RaexmzPFnsTHU3bsH2LVpwMDDjPBhET/d649dzqpaM9AedER0y003pf2eM9A9eSQqI18WhPXt0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Thu, 2 Sep
 2021 16:44:43 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4478.019; Thu, 2 Sep 2021
 16:44:43 +0000
Subject: Re: [PATCH 1/1] debugfs: use IS_ERR to check for error
To:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
References: <20210902102917.2233-1-nirmoy.das@amd.com>
 <YTCpuo00wM7jGSIc@kroah.com> <5ab7739d-15a4-2e84-0320-fee8d5df1e83@amd.com>
 <YTDBfO/byKzGWV8G@kroah.com> <c918f1a5-7c88-bf47-14b6-b6e892695951@amd.com>
 <YTD8+tLP7KeGRXEc@kroah.com>
From:   "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <70d43cb6-c36a-90d4-b249-3d59706e2027@amd.com>
Date:   Thu, 2 Sep 2021 18:44:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YTD8+tLP7KeGRXEc@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR2PR09CA0012.eurprd09.prod.outlook.com
 (2603:10a6:101:16::24) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f1d:d000:ad20:9749:da12:5f0e] (2003:c5:8f1d:d000:ad20:9749:da12:5f0e) by PR2PR09CA0012.eurprd09.prod.outlook.com (2603:10a6:101:16::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 16:44:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8909be3-e98d-470f-80f4-08d96e30f6fd
X-MS-TrafficTypeDiagnostic: DM8PR12MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5448383F5566C358EB6083E98BCE9@DM8PR12MB5448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1i9uZdCbzD6kefo9376tezablYa1Pp1ImJ6rKyayYPlg2NhrQEbwaGbuXA7zlZLTifNIj3ZHP8KVhsbhBN4BSwQDRJpx9ioWtY7YHDMPeAee052oKtfebcrFktWD/QfgzbU9sDUo07EB6L+tPg6FcBPQaazCZh+88XGk+tCnJlzsZ/w8PTLSgcZnOg/ERj1btwbjBZ3rEMxE+UUj5ij5aRY6ef3EIBsD/d6DFNPqSyadwIlSboH/6RgRIun5X3T3mi2eRQx92vBg0DsvZyNJ49ZKFIvkc+hEjRoOc9fKPAoMZGgpN4oCA0I8N43yKn0OpEX/1+k8XNZHLwdgbb1CVRLy33nA2mfFE2OEzgh8bqNazks/wV2U1uLl71CM60PH61BfsQYELWOLvMuBLjJPnnNTvtQ88K+i+7TsGGpuIy1EoY8nJk/pNHPfwoNvrVksYaKmEOv1k/MaZuyo7jk5LjNDhNl6BD1UFnvlsrRayWc1/UmNXkmy+jbkqcjoC4QyT3xkC9isQT+tJ55kgS/Ze/5xB5+dz0DTUSO5C0MZKpH45OwLUw0r8taRj0iBf8wa24x1e/Y0mhNfSC7Xig6zz2XfsoqATpJ2lrdwed6YsX6X3SB/zCgz5J9JlAfZmCs8LDvhOOoIRyZoMzR3uFdn/5Pf96cgC8PhHxYB2LeDlSiF+9MK0s7r9xDynrgqXw/QYOkQFAUaYEnof9vAW3tx8HwTzJWYkZzbff7p2G/9UE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(53546011)(2906002)(45080400002)(6636002)(66556008)(66476007)(66574015)(478600001)(966005)(52116002)(8936002)(8676002)(83380400001)(5660300002)(316002)(6486002)(4326008)(6666004)(110136005)(86362001)(186003)(2616005)(36756003)(66946007)(31686004)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2wzeWN1UERXeEVoZ3JJK3NVR05rK2tvZ3lJdERDUHorcEVZSHpHczVkWWRP?=
 =?utf-8?B?VGNMMEx0azA1L2hJMTA4YlhhUkNNejgxWU03emJTN0puYU5MdVVuN3hhT0U4?=
 =?utf-8?B?RGtaWXVwYk5SLzBYMG0rZTJ4VFVlY3Z5U3JXbGZrMUc1UjZpMjFLWlNqbUJG?=
 =?utf-8?B?VEs2a0NsOHNTUlJIWlBjeSt3MmoyWTlwOElaR3pITitIN2dTdmxqWXlxalc1?=
 =?utf-8?B?bVl0WVp0UnZnV2FsRWdXVmE5T3JRNVhTOG5CcDJtZWZBbEpFVFdYYmU4TGsr?=
 =?utf-8?B?ZUlzUUVTRG9jUXUrVjZvdVFzcFpzVEtlZklLQ0VsL2tnWHR1aVRCYWNWZVFU?=
 =?utf-8?B?REIxZ1N5MTRybjY4ZWxEWTBlb1A0RUp5Qlc0MlhIQW9ReU8vTEs5Wlcvc25Z?=
 =?utf-8?B?R2JrdHgwa3VENWlvbDBvYzJKZ0hqVUttT2kvRExkSzdZMFdsbkRoV3BBZnd4?=
 =?utf-8?B?VERLK1NvT2tCK2dHUU82NFV0UDFtZEZ2MFRUSmt2dCtaMjhXRmFsYjV6ZDZj?=
 =?utf-8?B?SVEyRmYwSkU5UTdtUE5rUnVRaEZNc3NqWWpnSzlCbkFFTXJ6K1JxMmhmdTJn?=
 =?utf-8?B?d1piemRFazJuclA0czgvMDBLZ1dSNEZyMmZrRWlxWU1qbW9NekxiUlFrcFFq?=
 =?utf-8?B?b0ozNGkzNExDM2I1L2NaZDVPVmx3ckxoTzBLUEF5Z3g5NnFNSkI3ejZEckNV?=
 =?utf-8?B?eVpScDRrQ1VJcjlVb2RLdVprWWJiamttMGdsVFI1RVBXZ1dLaGkyK0pTUUZn?=
 =?utf-8?B?cjdCQjcrUEZ5bTZYYUF0WndmRWtoc09jVFlOYjFBQnJNU1FsWTlaY1M2eXJm?=
 =?utf-8?B?RS85MlJPMFRYckpYbW1hWUpLbzRzd0VOZ29yV2FpV2lraEw2cGdmRXJBV29o?=
 =?utf-8?B?M3RQT0JDQ0xjdE1Ua0ZkRm5maFJ0Z2dyY3hSeDh2SUJnRDVseFRmMHYxaGlm?=
 =?utf-8?B?dkMwck4vdDNaa1poS2NmTmoxNU1VTE5RRDNzeXcyWGxUeTN0MTZNUkRjempx?=
 =?utf-8?B?enM1OHEwbDF5dTliV0M4eFFleWdHRWVHcWJqaDhONVNTYTN4YW5uMC9CTHFO?=
 =?utf-8?B?VFlIMUUrYzlPbEhTTDdKN1IvOVRsOHNLNVVUZ1g1eTJ6NUdEQzRvM29rZHR1?=
 =?utf-8?B?MHh6cVZHVTNhWU5ST3dNKzRBSm5xcWNaaVk4V2YyWEtVcVV3NXFJb0NPdUpt?=
 =?utf-8?B?VnJ1ODVUTm1hZ2ZBRjU0Wnk3UFJwamVRWVdwMDM5bldmcVZqYlYzVHliYzZL?=
 =?utf-8?B?WkdSWDlUU1pGY01xQzNSR0FnbzdvTTBKMWlyRCtmSnJheW9TckEvRnNodzZC?=
 =?utf-8?B?TDVoNFdRZmJZOE9jR3MxbUMxcjdldEx5dnhMRjNxNWdNZWNTY3hWaUI3MDA3?=
 =?utf-8?B?b1l5amNzRWFxOUtXOE1vVTFmTEVLZG5sckxDd2lYdFFoNUZNRU1sMjVqNFd2?=
 =?utf-8?B?RkJBRlJkQWV3b3FKakpRYW5RbUtMR0R6ajRnanJ4YzI2b3hMWGhReDFJWlBt?=
 =?utf-8?B?dGlwVkFZTHgzejNkY0xjdEM3ZlJTK2srVWJqbmtHZVY3ajhRaElGMFg0ajly?=
 =?utf-8?B?MU43Wi82ZE44ZG1YOFp6ckQwQ09qTk1TZ0hmK1ZhTDEydWwrZ1JOTUpEdElH?=
 =?utf-8?B?cUVPNS9KajVJZUc5QVpGNG1aWjA5dGRMdjY4elRaMnZnRGUwanBmZzFWVjQr?=
 =?utf-8?B?U1NOY3lMbmVGTWxDQUZ5ZDRkeUtSeXJXeTlDcFlrdER6T29samtTVVpGaUFR?=
 =?utf-8?B?NHg3Qmt3NDhMVnlMN3BNNDg2Z2dmVjBibERXZlgvZ1VqcnhDdTdxdC9hd0Ur?=
 =?utf-8?B?N1JoSytRaFp5S215K040SC9vUlBaeFhsL3kxcG1UUTdxdGhKNkhkYm90aDJk?=
 =?utf-8?Q?z9jFvQjH2N/34?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8909be3-e98d-470f-80f4-08d96e30f6fd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 16:44:43.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aY3YP7FlwkTu4lGhATrgAyuAsZYirR+3jsvwFTSR9N+AuTwKGSqT0HeRsfHnGQJcf4PYnTiIjb6ygVppjYh1AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/2/2021 6:34 PM, Greg KH wrote:
> On Thu, Sep 02, 2021 at 05:10:24PM +0200, Christian König wrote:
>> Am 02.09.21 um 14:20 schrieb Greg KH:
>>> On Thu, Sep 02, 2021 at 02:03:12PM +0200, Christian König wrote:
>>>> Am 02.09.21 um 12:38 schrieb Greg KH:
>>>>> On Thu, Sep 02, 2021 at 12:29:17PM +0200, Nirmoy Das wrote:
>>>>>> debugfs_create_file() returns encoded error so
>>>>>> use IS_ERR for checking return value.
>>>>>>
>>>>>> References: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1686&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C7a1f1095c0d64416576c08d96e2f7b38%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637661973378236086%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=g9BQRJG8gvjGFq6oj5vk9PCemQ39U19CLmkMNHVUafg%3D&amp;reserved=0
>>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>>>> ---
>>>>>>     fs/debugfs/inode.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
>>>>>> index 8129a430d789..2f117c57160d 100644
>>>>>> --- a/fs/debugfs/inode.c
>>>>>> +++ b/fs/debugfs/inode.c
>>>>>> @@ -528,7 +528,7 @@ void debugfs_create_file_size(const char *name, umode_t mode,
>>>>>>     {
>>>>>>     	struct dentry *de = debugfs_create_file(name, mode, parent, data, fops);
>>>>>> -	if (de)
>>>>>> +	if (!IS_ERR(de))
>>>>>>     		d_inode(de)->i_size = file_size;
>>>>>>     }
>>>>>>     EXPORT_SYMBOL_GPL(debugfs_create_file_size);
>>>>>> -- 
>>>>>> 2.32.0
>>>>>>
>>>>> Ah, good catch, I'll queue this up after 5.15-rc1 is out, thanks!
>>>> Thinking more about this if I'm not completely mistaken
>>>> debugfs_create_file() returns -ENODEV when debugfs is disabled and NULL on
>>>> any other error.
>>> How can this function be called if debugfs is not enabled in the system
>>> configuration?  This _is_ the debugfs core code.
>> Well, that's what I meant. The original code is correct and Nirmoy's patch
>> here is breaking it.
> Ah, yes, sorry, you are right.  This function can not return an error
> value, if something went wrong, the result will always be NULL.


The issue occurs when CONFIG_DEBUG_FS=y and CONFIG_DEBUG_FS_ALLOW_NONE=y 
config options are set, so a call to

debugfs_create_file() will return ERR_PTR(-EPERM) instead of NULL.


>
>> Nirmoys other patch is for a driver and there the function can indeed return
>> both error code and NULL.
> You should never be checking this stuff in a caller anyway, so no, don't
> do it there either.
>
> thanks,
>
> greg k-h
