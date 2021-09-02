Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD783FEFE3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345691AbhIBPLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:11:31 -0400
Received: from mail-bn8nam11on2042.outbound.protection.outlook.com ([40.107.236.42]:12114
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229941AbhIBPLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:11:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHOK7P9Zb26E5xhWHTwKH3lU7HUpRa04IbvOI7QZxporx5W9UAKTa4lEHX8wV4dF+kqTmLtN9mHbAKa+XqI6Ri6q7/EbRad807beUfi1dDLsydsTUUgWBRfFvaKzyd83GGJ3YCUHl8nNEeMc+1VHwBnn5YBzku+GRqGF1t69A7xwwGTqoHyM5q3dgxUM9KqXG/jPDr7lUVlqDAUFUeD8lv6KsBW9tvMmFf2C0P3UTWRpLCdGRj3j24r/LbYg1BKTKtPzX2cd4B05WjrO23o4n8w29u7gQpYiU0uKp3eAoarFFfW+DZHCFmUvwbaqYpAaMwYLpb5QueVFJNoAVLGXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2og0tSw/SOtZzCB71oHrVdXIBfuDscIa/o6xEVmKQw=;
 b=KiGuA9uS2RagroXzxOjQzrS3tA9eIFgejEH2dFSMXZz+HQfbUuB8reEu5br68O9S6r24XjwVSKRoELi32C4uF4iGtva5RGE3sonFaElD9IwVSjXC3yXos0n0Y/ZMq6ETLiPLnXXsgZ5fxOZ4ps7ljiw/YmdIyhbYyZXRGQe8NOndGkJOPRpVlhS8sti4/xOl26A5PSaLN1b2xrnJCr2+29MD+D8haQeyihXwTfpsLouQMxTZ8rFVJ1LVScJkf8r8xsyE6HyGQFiHlh736eXV1VQRy+dIRKGBCAIC7Xm3/UEuSph9/1ALkkCENAqEk0m/oNWnM5Q3ryulBLKYrBPItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2og0tSw/SOtZzCB71oHrVdXIBfuDscIa/o6xEVmKQw=;
 b=nOjjAd5wZVQo0F+vOZePtRWDrpPfwGps7+Zt7DBsKFdGAXtBXbW3DwmowaQ7IfHQGkgwekg97KRL/uxrVGqdqI5wEHJfvcDvG9+xvKkgZ2Qfvi+ZLI3Unp3c1b5OLX5IpM9Xs//6xpzBfl4DmradCza6XjkqKoaAp3g4geFm7vM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4689.namprd12.prod.outlook.com (2603:10b6:208:8f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Thu, 2 Sep
 2021 15:10:29 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4478.022; Thu, 2 Sep 2021
 15:10:29 +0000
Subject: Re: [PATCH 1/1] debugfs: use IS_ERR to check for error
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nirmoy Das <nirmoy.das@amd.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210902102917.2233-1-nirmoy.das@amd.com>
 <YTCpuo00wM7jGSIc@kroah.com> <5ab7739d-15a4-2e84-0320-fee8d5df1e83@amd.com>
 <YTDBfO/byKzGWV8G@kroah.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c918f1a5-7c88-bf47-14b6-b6e892695951@amd.com>
Date:   Thu, 2 Sep 2021 17:10:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YTDBfO/byKzGWV8G@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR3P250CA0021.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:57::26) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:2def:7a94:6d1:1fd1] (2a02:908:1252:fb60:2def:7a94:6d1:1fd1) by PR3P250CA0021.EURP250.PROD.OUTLOOK.COM (2603:10a6:102:57::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 15:10:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a4617b7-b063-4cdb-b6d3-08d96e23ccf9
X-MS-TrafficTypeDiagnostic: BL0PR12MB4689:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB46893A758800B9CD6792B18283CE9@BL0PR12MB4689.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1sUSe7QcAZDkIsUzGgKMfNCKOoWGJXlW1FVqto+5D7HjxGVzaTnrERYO1SuWFhq0dGwyjYXV/Y9seGO+ZWJrbKrZbeT80LgYlIfosFRd18hu6KVyOBzFhX0/XnVcr8ygJhXv/UHF4WPcE1h4olMmyO7fvqVq06X4vWxT1/INclG74QG3WPr8k+fsX6W5IvaLbN2qeTtBGZ90GFkQ5ZtMrLnkEGg0sefg29r7FCI+dUS4wKhk9FqIEx/vKeQtuRDgc8LVDG6Zi5Ub4Rq6I9ALH4zIpbt4ZFr98175t9QS6+nrz9N0kqUgwMaGwkH4AD2TxJ3Nvamx/4CdvP64qSPCRKiokjQ12mmSq6i3yQT5dHUNgRrluZJERof99XhFm7UASXocgloTN8g7ofbv7g5HPu0CXNQzbAoeslSt1+D4UfKUoZuXjf+rkjQtnY8GkjwNRAy+xuAVXguryhjjcN/3A6km55BStTfQAmw7WLVVB/ZC4kFcEGPdBikMzi6jrf98DeZpA2AWCeXE9BQR3GQG+dt1WNh2dTP/Xl+Gt9vg9icjJxa98dTSCw+q8xPRPV1uL+hPM1jYnYC7vKepIdx6mN7TQQNYsTAQ4no+0DiGpL2vQSwk2mZlPXTw86MadpZynwFFkydevUPkUR57pBBDd1khxx2Rr0uMFgeBiICSXMVPE08MjrIxRybdmgWp0+DhReO9eURDczE870SIJzovvzZZ4TLBWN3I+/J6iZA+iE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(5660300002)(4326008)(86362001)(6666004)(6486002)(478600001)(66476007)(66946007)(316002)(66574015)(6916009)(31696002)(36756003)(2906002)(83380400001)(45080400002)(186003)(38100700002)(2616005)(66556008)(8936002)(31686004)(966005)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3lPc1Z1T0NuZ1JoQUMwbUxRZTNQcmxFdW1zQkUya0o1ZDM0NEFMQWlVampk?=
 =?utf-8?B?UWxzL2s2UUl4QmFHTXhwNG0veXVBVGVnajVOQSt1Q0VNdzhmL2plOGJUT0dn?=
 =?utf-8?B?VHZkdHUra1oyR2lCcC9FY0xKSy9VWElVM2JyaVAvQzl0YXdlK28rRkJVdVV2?=
 =?utf-8?B?UzkreFdwZk92WDNjQUdxR0YyeW5Ya3h2MjFxb0wyc0NBekpkR2NFd0Vvb0RO?=
 =?utf-8?B?S2RiSVBzcXpRaGlIa0dvODdTVGEyKzdxaXBjakdSYUxGN0FmNFE1amNCd083?=
 =?utf-8?B?dWpkTHFrbWNlOVpsaVFna0pUaC9VakJSYU05TVFFQWtVR2p2Vi9QNVEvZFov?=
 =?utf-8?B?Sk5Gb1JJU0ZMcDhCL0w3MzIzNzNTampWK1VoQ2dWY1lsOEtHQ0J3R0pIbklx?=
 =?utf-8?B?V0VGTG9oN3pVNVVpU212aGtUVTN3bGNPZWJDUGNENld2OFJCM2MvZ1g4ZEtl?=
 =?utf-8?B?L29VK3g3QU1SRGpFZHZRbitQd0dPRGFLbU1PZTJBMEx1N3NUYlkxVU1VenlU?=
 =?utf-8?B?czAxdVBLZEkvc2ZNQzBmZ1NMNGZMNWdwejgvOElocHI3MFUwVU8vWTFmQVp3?=
 =?utf-8?B?WHQ4RjhTdHFsUFBjWG4xNmVueXN0c0dmWFhIRnVvTUZsVlhOSHJyYnllcWc3?=
 =?utf-8?B?OU1YeTRMYVppclFYNzAxcFpnaFlOUVVralFVa3pMdmkvcW5Zc3ppKytsNWE5?=
 =?utf-8?B?SGM3NUpxaDg1UE1JSll2TUZpUTd5MmdKNEhOZDYyOE1lWTRJeVFtOXhyeDBO?=
 =?utf-8?B?UVNCcnNrc1M1cCtMVXFRV29OMnNvdkFzNVFNMUR0WGRGeXBlWjg4NHMwWU5z?=
 =?utf-8?B?dXlJU1A5M3RNZ3lZNC9Nc1RyR2FjTFdYRDdSbVMwVkJuUFNVV1hLSTBMSVlX?=
 =?utf-8?B?NEs2bVFLa0ZQNVJrdlZYVnIwUHBKQmtmTy9BUm93dkliMW1sUDM1NkR1V1d3?=
 =?utf-8?B?a2I4ek5PU2xBbzA0U3ROTnpBZm5odFFXQ1kzbFoxa2FybXdMV3JBTVZTUS9l?=
 =?utf-8?B?N2ZuNnRhVGFxRng0UHdxVDVtcXlab1o1d1QzVTdLWEE5aUFSS3dFUG8wc0RW?=
 =?utf-8?B?SG90amkwMXdUNFJYRUQ5aWFCK2xFc2h3VXhONDcyd1AvRWttUCt5aWxUN3cw?=
 =?utf-8?B?WnVXVXR5REhnRjljR3dtK0NVWFFiUGdCR1JlMHdJd3dheU80ditvdlNjWFZR?=
 =?utf-8?B?TytTVlQ3cEdrTFJIaHpaNVp3cEJmbVRCY3ZIdzFoQ2lJV0p0MnRyeGkvdWtG?=
 =?utf-8?B?OVZHcldtU3NramY4elkrakxvbjBORmcxNWRHTWNhekZXMXlUYXBLRmxBNExU?=
 =?utf-8?B?ZHBuWTFDcmN5d3RiT0F3SldNak9KY0RYNmhCeXNNRGRSMUk5enVZTFJlMTd1?=
 =?utf-8?B?MmR6SkI3dlJYUUZIT1ZmajRrSEttUDhzQVFHcXlsWGhqRDN1bFVBVUU3eDdD?=
 =?utf-8?B?NTlXN0xsdTJ3N1VoU3lxYXZjVm0zZUxCbXdBNkM5SFUrT3NRSUVUbUpWRHVn?=
 =?utf-8?B?R1NXcjJTamlnL21Ra3N2Rkt6Tk9TTVFZOWtzNXdMUVhod2NzSkJOL2FIRVVF?=
 =?utf-8?B?cVVkTFhlaUs1RitybUZ4eWkzZndyZks4Y3ZPR3NBTmpUWXZqTWFaVG1GMFpj?=
 =?utf-8?B?NzhZa1FqMHlxZEtwUUVYWEY0RkdsM3R4VlpwNDNxNTN0Q2dvMkFIVFZaa1Vn?=
 =?utf-8?B?dG1jZlNyZVltbVp6eWpocDd6NlJZQW40YXRRYWpXMTFSSWhSS21NeFBtOWM2?=
 =?utf-8?B?M0lFUDBmWTFiYU9EZE50LzA0a2dvNzQ5TE1IdjRmb2hvcmNqamdkWTlJZTYv?=
 =?utf-8?B?eGdzNVdQRHllbFhpK29FNkZ6MnFjeHFOejRsbU9LZ0VvUmltQnBOZW1tYi9h?=
 =?utf-8?Q?JbO3V/UrBc7sm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4617b7-b063-4cdb-b6d3-08d96e23ccf9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 15:10:29.3762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAxyIYj5HDV7wOjAAKgXUaaO0PB9H9WlCW10dhVYxGhWJXayfv1k3/FKOL+gsPT9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4689
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.09.21 um 14:20 schrieb Greg KH:
> On Thu, Sep 02, 2021 at 02:03:12PM +0200, Christian König wrote:
>>
>> Am 02.09.21 um 12:38 schrieb Greg KH:
>>> On Thu, Sep 02, 2021 at 12:29:17PM +0200, Nirmoy Das wrote:
>>>> debugfs_create_file() returns encoded error so
>>>> use IS_ERR for checking return value.
>>>>
>>>> References: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1686&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7Cffc1109aeb744082181b08d96e0c06db%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637661820207117289%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=6NDHX9sEhGF2jakVfUJ7Qurql6UAdNpFQZ6XvCjwz0E%3D&amp;reserved=0
>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>> ---
>>>>    fs/debugfs/inode.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
>>>> index 8129a430d789..2f117c57160d 100644
>>>> --- a/fs/debugfs/inode.c
>>>> +++ b/fs/debugfs/inode.c
>>>> @@ -528,7 +528,7 @@ void debugfs_create_file_size(const char *name, umode_t mode,
>>>>    {
>>>>    	struct dentry *de = debugfs_create_file(name, mode, parent, data, fops);
>>>> -	if (de)
>>>> +	if (!IS_ERR(de))
>>>>    		d_inode(de)->i_size = file_size;
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(debugfs_create_file_size);
>>>> -- 
>>>> 2.32.0
>>>>
>>> Ah, good catch, I'll queue this up after 5.15-rc1 is out, thanks!
>> Thinking more about this if I'm not completely mistaken
>> debugfs_create_file() returns -ENODEV when debugfs is disabled and NULL on
>> any other error.
> How can this function be called if debugfs is not enabled in the system
> configuration?  This _is_ the debugfs core code.

Well, that's what I meant. The original code is correct and Nirmoy's 
patch here is breaking it.

Nirmoys other patch is for a driver and there the function can indeed 
return both error code and NULL.

Thanks,
Christian.

>
> thanks,
>
> greg k-h

