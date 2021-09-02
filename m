Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35B13FF1CC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346452AbhIBQtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:49:40 -0400
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53]:28000
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231368AbhIBQtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:49:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii0zmQyqpkbRT0wjhH5h+bND2F+LP13CMlNaN+LggfCq5h7ADB7/hEO+wOdRlYrIQ84J5Pa1TL2PwEzfIMsoRpyLwIgmSEJbvO4yLIqj29SCkL2FhsSShfaInY9aYsoWu6bgWsyam6nWoQ5qAQiukNcFcWLSR+ea/u3wJW24RhxBwmyiMwzRr+4RHYHtkI4jB35QF/vNGGi92ZElV3IkbBzMu9ZhsYr5/gK+SbYPEOTUgv/O1evVSwo3AoXnh/xyttP8oU+uSIJI+rkeRl0svejBvzC+aIZnHfpIRK9jzC7Lg5lf2yu8il24QWS4lEx1i4OcibKGnkSdjbpIxE0tZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CzDI6Z4cicmakoVYNBZegPnAXPBk9181VfoXWCCHhNA=;
 b=huvRhdj8GbIBI+2aZHwxyxIjCL6xs2x4kO+9uNmeKHKOxojJKcz1nlNkpBe4g5MHEdH7M67L8kXAWZ1WeMVczgIW6vSYZlNQihyhhZvNJzeAqFhieQim8V/BzLqKYIOPI+QYaYo5DHzgO5/J917mtsQ4+akXX9cuFz5Sz/TB5lWorfanJCq3W70kJdk2HJPKK7by73jDlocSKj+Lzc10ctOBJumo2AZFykhcdixmBOvt1OCLNplHz5APlVRnvYhrmL6X0NaqwIC+xdWODKE60yHlcEHipkGciFlzwqe1TYECeBbtovPU82FXuuGFuGkvszmpOrqIcVPw1ASgf2dIkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzDI6Z4cicmakoVYNBZegPnAXPBk9181VfoXWCCHhNA=;
 b=fmA1kwUh0+MdXd3dUVggMGlTZtdXPp7hvWXKFHTgyOXuwzvV/NBw2t7SWwgDDy6FAM+4Z6sRoCQ194yJHmQ9E738gmfvh97bmYWmjBd+vk5G09uf0yATEwjQwznDd4Xo2TqwDOW84DcCupzlVKUvBNBtEEMz0jau3aM9zscCR4c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 2 Sep
 2021 16:48:39 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4478.019; Thu, 2 Sep 2021
 16:48:39 +0000
Subject: Re: [PATCH 1/1] debugfs: use IS_ERR to check for error
To:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
References: <20210902102917.2233-1-nirmoy.das@amd.com>
 <YTCpuo00wM7jGSIc@kroah.com> <5ab7739d-15a4-2e84-0320-fee8d5df1e83@amd.com>
 <YTDBfO/byKzGWV8G@kroah.com> <c918f1a5-7c88-bf47-14b6-b6e892695951@amd.com>
 <YTD8+tLP7KeGRXEc@kroah.com>
From:   "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <8f9ad7f8-d4fb-1737-6728-3278af1b3504@amd.com>
Date:   Thu, 2 Sep 2021 18:48:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YTD8+tLP7KeGRXEc@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR05CA0076.eurprd05.prod.outlook.com
 (2603:10a6:208:136::16) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f1d:d000:ad20:9749:da12:5f0e] (2003:c5:8f1d:d000:ad20:9749:da12:5f0e) by AM0PR05CA0076.eurprd05.prod.outlook.com (2603:10a6:208:136::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 16:48:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 349b930b-e846-42ff-e99b-08d96e318396
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5311A01D1F9647F81D28F8E98BCE9@DM4PR12MB5311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJoHyza5Q+qzTI0EiRPdrdLZLpq1ewIxcabqtPnDX8Yh3VeZB9T6P5CUQUGxFFOgJARH2hjdlRmIkUWLBLA0CxVwyDDm72JVujobFurthlP6+72vvXUrPgRyKsnj8ZLk2jxxPDf5Dpo5MWb3L+dZPf2j5BaAML5ZGRt3rLGCi1GX4QeXeWhNvU6h0shSnQQHwfxBPOz4aRz03YjIbNZDR/w9C6KkWK/imnTSKmLvNuNefqLpK3HucWMt5ZZ44Xol5aP0qIe4Zc5f0hBeJJjnzuRKHeH8fFHRoO07y6nOrgd7zTYTLYZoQkcgaG0dS09d72BpoqIlPybUejUXAY3zad1atUpmul/3wctJqnk2ySWl8vEFKQ8k+aQWLBJqCs6MPvRGEBBpKQw+HaPXDIHHK47xOSkzR66kWZoS2vvgM2+PWOrd9uvYXpdfcH9LQPguBNqwEIAleroOAmJGh09+eaB2HeOgH7X4bhh5KpUbkQVEBC2nQ+1U0xoUvGD62oDi1sDJ0dJtR1+FYQFY/CMajCK0FEclP0BBIHOKw7HQrRp1oN+K/Tor4Tmz9mMeybr44l31Soa6f9ou2FKP83dJlIAaAVbSai3duZZx27t+fCY34BZh4DGr0NiLCUX7ONEIZXOnp63gnvnFW/fJ1NPecp56Bug3SYBWsWuY3DDk60ax2+MD7plaURbCk/5PMdV+vVhUjdB9sQOtFv7+v50aqe1HRbvQsVzv6fM+l0Wpwfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(66574015)(83380400001)(8936002)(110136005)(4326008)(2616005)(45080400002)(5660300002)(36756003)(66946007)(6666004)(31686004)(6486002)(316002)(6636002)(66556008)(66476007)(8676002)(52116002)(2906002)(966005)(53546011)(186003)(31696002)(508600001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RERocDdZYi9oSnhVVC92QXNmUE1CV0gxd0xsZFNOVS9YRVozc1QyUW4zejhs?=
 =?utf-8?B?eGxWZXB6SXBubEx5MDlFYkQ0NVp6M1VsZGJDY3dkeWVMRDJuNUtHT2hMdWxX?=
 =?utf-8?B?M2VUUzdTVVczMlJPdTFaWGYxeThzZlBKOE1jMllCVjNGWW8zTktLeXF2ZDV4?=
 =?utf-8?B?NGdVcjFLNWI5N2w1aWJpdUxWOE1Ib2dRK0NaU292NFRZdzV5cjdjWXJlSGlZ?=
 =?utf-8?B?Wkl6WDduOVF4TWtqOURBV09lcDVjb1FoNlFEVS9CWFh0TWlmcnF5djVSbjZ3?=
 =?utf-8?B?ekkrZ3Q4MUt0SzlrV3ZPeWFzZTUxL2NLQ0dpRHpBWWlHSkp3Y25jdGtSMEdK?=
 =?utf-8?B?OUJsSmpIaVVXTko4MnRZTHdmdHlKUmVOa2hGbFR2M0FEOVNYN1JRZzRxQUZ2?=
 =?utf-8?B?OGwxZjA4Znk5c2NhMVB2aWs5WE1MdkJidm0xZXBjMmw1YkNFcCs0OVZCKzBu?=
 =?utf-8?B?VHpPK245YWloNFFuUGZYWFFBQzJlUy80dkRPOE52L0l0aDV2Y0JZblp6MHdG?=
 =?utf-8?B?UDQyRmYzWTR0enNpeklVWExuRkxGWlVwcHI0STkvakF1Z0o4dWhhTHR0d0p0?=
 =?utf-8?B?Z0lsZ1pQMlpvZEZGMUpyWlowR0hKU1BnQXA1ZUdERHJwMC9Vc0EyNHZBbGo4?=
 =?utf-8?B?Y0ZpbjNtcFNSODZoazhPU083OGFpMmhTUUR0OE4vcE9uNXloVTNYSG54VXZR?=
 =?utf-8?B?VmJ5UzFpR2pPVXNENTBJK3lBRmwzU2Nud1NWNVBvT2NOd05McHpiTzFoRllK?=
 =?utf-8?B?Z1NrTlVwSnAzSGRKc2tpaVRKVGx1YzNBUmRMZElXa1JSVVlzRTIrait4RW5j?=
 =?utf-8?B?Wjk1enZHWG1kL1pUUDY1MHEzMWZDZnl2TVBDQzduSTFpYjJOclhlRzE1STZV?=
 =?utf-8?B?a20wZ1F4ZlR4cXpWZjFxZXhiTWIyZEFJWTFNdUJjbnBIcmFTZU9peU9zcjk3?=
 =?utf-8?B?Zm1mOU5lWHAwWTFHQ0t4aFBMQ0FhcWVyaW1HVUpBWXQwdnFCSUpPZjhXVE12?=
 =?utf-8?B?YVdHQjRXRXVSRHQ3SXQ5UVluZG00M25ndDFuYWpJR1ZybXRKZEI3OStEQjI1?=
 =?utf-8?B?ZXZtYzJ6WXdGbzA4cnMrSUk5YWJHMFZhbmZ6eENPY0JibWFEUGZ6ZFlvSHNv?=
 =?utf-8?B?UWNrekhzSTNGUzNFMU1DTjVFOEk5VVpka2wvZGFNWWthb0ErdUxUUU56ZWR0?=
 =?utf-8?B?ODRuTDNFWUxuWHZEdlkyVnl0U2FMdnJHWWlCZksrb1N5RWozVndmQkh1TFM4?=
 =?utf-8?B?T0xDUzBaVjdrdU9mL0o5SmxXZlloTHZUQ3VKM0plKzEzVHRsdTE3OTdXRks4?=
 =?utf-8?B?QitLeHhaMThPZ20zenVPM0VLZVl6c1ZHUmlVdnRmRkRZc29FMUF1TFlXQ2FU?=
 =?utf-8?B?VXNGcGdCT1NHTWRhazQ4bFNtY2gyaTBqd1l4anF4QVlNWE4vT29CMzdFMU4z?=
 =?utf-8?B?ZUsvRDhlZHJ5cll5M1RzYmdJYndvV2t4M29sbHpNY2hpUDIzTWIxdFJCOU41?=
 =?utf-8?B?djNkOGhQd3BLOUhNOG0xK0hwQTgxOU5YMG5EaHc4SFM0b1c1ZkdCbS9KT3Zm?=
 =?utf-8?B?VEt0Z0xoamxSSFoxdHNrQTFLbmxWSjFiOVljeFNDaVYyNWw2OFpFZ3Q2c2sx?=
 =?utf-8?B?cHNuODBnWFdDcThWNm10MHBKM05uL3kvWXpHbjQ3eFkzRTJkOHdvaXdRY01X?=
 =?utf-8?B?TkdKdTNhUEVhZGZrc00xNnhwVkxodzkzcHlKSWY0LzZwejNvUU5NdHlEdHV5?=
 =?utf-8?B?NmlFQVhJUGdDSlJCbGhIbkpTZWxPbFdLeVlJYUxEWWxGcWg1QkNwZGYxTDdu?=
 =?utf-8?B?ZHBrUTRkZ0xOcTJpc3hDNHhSSGljRzZVTThJaXJkTzh4UjI1b0MwcDRucmlZ?=
 =?utf-8?Q?q/qjbXPvsZm1o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349b930b-e846-42ff-e99b-08d96e318396
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 16:48:39.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soEIzVJ8Ei1rMjHosmIotjzX+GXAPq9eevcFzF8C9i4bbovrbjz2+lceQf3+BvPDUDUjUic9tXwloix8orgvgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311
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

[I pressed send too early in my previous email :/ ]

The issue occurs when CONFIG_DEBUG_FS=y and CONFIG_DEBUG_FS_ALLOW_NONE=y 
config options are set, so a call to

debugfs_create_file() will return ERR_PTR(-EPERM) instead of NULL. So I 
think it still makes sense to keep the check with IS_ERR_OR_NULL()


Regards,

Nirmoy


>
>> Nirmoys other patch is for a driver and there the function can indeed return
>> both error code and NULL.
> You should never be checking this stuff in a caller anyway, so no, don't
> do it there either.
>
> thanks,
>
> greg k-h
