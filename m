Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A753FFA5F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 08:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345901AbhICG2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 02:28:42 -0400
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:25696
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230128AbhICG2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 02:28:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqonxGVgIOqpXDU5UPvRWaCUB+K/tTt6mJR9NFuo06yrtPQ5Nhl+eVtcl1bYJlrizuVZDzTyQINS/H6OOII4BVQWXnhKafOK0YfvbkqacVLD6mQkrq3Yppw55w5n5InhP8i510hNdTa+weScFgS8epjTKEIwqrXJqxxjMhnqzovAO1W6M6AOCLP3Sxrr+sbBLiUwyfPNmmQtCFg6yH1ymQLz9GfPk84xu0wBRBf31gTPgEc1QcpGb6DU0pABTS7TnrMlfmlyb+T8iWlEG3mQDJvxPVzu29SmDLg4x2Ip/I3A6kAzkdfTa7pU40Qv7c4tL81LkPtUoW7qwONEK5FX4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=doE0DR+5uGLYi8IhZFsQ2IOmT8v/CMNwPojeS7hAZTY=;
 b=IlVZTSh7AL4998gewyFwSH+2UIdw7BxH8bQlmyayyumZ8g0wQwuQEu5QkXXRxGmg7lLi4JCqTIDWi0tesLWpvjRL0kCI0hItBi5hYUao4BvVMjb3eUETcqtmlxxRJU2BW5LK0PAm5h3gd0LqHtVu2Gc7pQ/fCfGkLbjSOObYoqpMkoC3AwZb6uGj9qmVefxYuHnRkVs2uYGLyosinBmDEjWcc76WOhdsSSEJpPSQx8fIFLyGA0Y8YGembynEJgdL7WdYE/jAnpbHy1UzqeMswyoUkw8hn57vYmKCLfiobhUajZXMAwQckkS3uIL/xNcIhpXMmbVjAoSFPTd2qdPPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doE0DR+5uGLYi8IhZFsQ2IOmT8v/CMNwPojeS7hAZTY=;
 b=n08NJP0m5jK4ijB6OgOVtwcqjpqBQWrV1inzHVV4WjjE/0W1NcYLNQ7OteoYICZzkA5qXExDMNqhDXNdxd5xLpvA2ECg2ImF8+rork/TYrF2Atkio7/ljsX5rAsI7zEOgwC+f3AfvFO0+2dDPTuRcyJJjgWdc/UeEG2M9XejIII=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4550.namprd12.prod.outlook.com (2603:10b6:208:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Fri, 3 Sep
 2021 06:27:39 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 06:27:38 +0000
Subject: Re: [PATCH 1/1] debugfs: use IS_ERR to check for error
To:     "Das, Nirmoy" <nirmoy.das@amd.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Nirmoy Das <nirmoy.aiemd@gmail.com>
References: <20210902102917.2233-1-nirmoy.das@amd.com>
 <YTCpuo00wM7jGSIc@kroah.com> <5ab7739d-15a4-2e84-0320-fee8d5df1e83@amd.com>
 <YTDBfO/byKzGWV8G@kroah.com> <c918f1a5-7c88-bf47-14b6-b6e892695951@amd.com>
 <YTD8+tLP7KeGRXEc@kroah.com> <a6817cbd-b43d-5334-3e1e-62c1cd99e8fc@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c170c646-0db4-52ac-6008-4a9199609ee0@amd.com>
Date:   Fri, 3 Sep 2021 08:27:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <a6817cbd-b43d-5334-3e1e-62c1cd99e8fc@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM8P251CA0009.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::14) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by AM8P251CA0009.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Fri, 3 Sep 2021 06:27:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9906b685-8b00-4e7a-e344-08d96ea3ed1a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4550:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4550784BA6E6A5BFDCB5871283CF9@MN2PR12MB4550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PY2d91L2sLZqn2wslmHcySr3UFx9zdgOZkuOKBSq19gkBPDZXLi9kWGyuUn938Mhue62z36g6FA1hS1qwFjT285cjSr1aegiHCf53yJFH5299oOUtZNrYFo0kVn1pHzkvFFhuxPYZVNZQ/p6RMXyUNbLj8lMYGAWsgmV6vxq1HWPHjHii5g/Icnpf76nObuX2dPaCwNfv+GeH3OZPxT3phoUAEEx0SiohiHDr0FCnc9ZBY228rScC8914RYX5jc5byysVd1OZKemgGfpwwOX60LFJmlqYDm9Id4W2ByBiklHT3zFj6uNcAkMAD8quGirtEuDSsSrHff4c8g4IJyBDFy/TDGTrN8pnXW73zAsKOrB4MiD8S6aWC289Z92t2iaHs6TUC0bmFbr/XaAxtagUCyK4sP/Wy4pOQPbZoUsRds/gB37dvmqQsYJM5XqSgMxgFNSDjt1vKv8t9qu03A1wpTfbsKbl0yGufmnPiwkxwD9pe3EnV0URuDuq/h9H8CoHP4ObX1xQI389Q8+dVFp2bpWLEM8zLI4zSIKmV1GQ8Yb+MwMvPOidTkFrSawqkHUopK4r6tCN8z95V82hYqVItC2sXStJBATJgZaLPUs0VHLUfMKVMwJ+FLhgwwaz6tHojxXYl8cCJ3fDAPPUo467EnoFFsr65YFlXDH3kYkP/4Ebicuz5byct8dHC6jcS/UXdQ8AMufOm/hYLQkXiSgOnFIigP7XEpJLo5o+6Fvup2/4W7I1YJBU+bVu08VVhe1wY6XgdP/HG1m0z3H7hJiLqcralx+DWR6GaqbKCtyxZOghneKt/kPLnzhZLtHGK+6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(316002)(478600001)(186003)(86362001)(8676002)(31696002)(26005)(966005)(53546011)(66556008)(2906002)(110136005)(4326008)(83380400001)(66574015)(38100700002)(36756003)(66476007)(6486002)(45080400002)(2616005)(6666004)(8936002)(5660300002)(31686004)(16576012)(66946007)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHIvMTV2VVlac081LzRpNVVCNlRxZVZsYVhBSjVVUitPcDRQa2V4Wjl6S0ZB?=
 =?utf-8?B?NVJiQmhGWkg3a1ptbFZvbVJYYjlGdnowSWplN2QxRG5mM3h3T0t1LzQxNjJE?=
 =?utf-8?B?Ti9ObUJsUXJVcFlPTDd2a3NmZWFXWWd6MHJMcDQ3REpoSzBRVFJ2RmlIQUlp?=
 =?utf-8?B?QURmL3Y1SG9zNWp3OWYvR0pEc0s0eFIyMnlabkpsS25CTmgxMUx2SzZTQ0ov?=
 =?utf-8?B?ak42ZnpRRWVFYzBBdVN5Nk9mdUJQa2l1alB3cTJTTnkzUzJodlRlbkhQOWg4?=
 =?utf-8?B?WnRjZnVEb0J3VGh6UVVac2FRVEhBRUtWMDcvVnVlbjBCVE1XK3l0enpiK3Rr?=
 =?utf-8?B?RXQ3VEVQQ05kTlAvQnJHZlNubUY3SnVmM1RVbXVoWS9FM3ZHT3ZHK0VOakVE?=
 =?utf-8?B?N3dET3lLRHBnQ1RDN0JnNGJ5STNTZnBkNytBVExOZUVFcTczczFQdTZGNG9L?=
 =?utf-8?B?RFlvbmtXTVZkVERjcGZkcENnTzJ4WVJIRlNSaEVVVU1SMVZWaWpZZ3FUT3A2?=
 =?utf-8?B?anVDYmxSeExDQTl0Z3NycWlHTGVNOThnaVAzbHV6QmVmQVNqK05UU1N3c2la?=
 =?utf-8?B?RmdTRTlQazB5cS9zVWZhV2lKOGtKRkEwalU1cUpjV1VjZHZhRlMvVExzUFVO?=
 =?utf-8?B?ZVJBREJtTGpUSGxveVdOaFBnVXFwU2VEdGZOd3BjTTA3WHlWQkVGak1xdFZj?=
 =?utf-8?B?VmZYa2NSNFZnUC80T2kwT1BSTHN5QlpUNzZsOFoyVkk4eG4wODN3a1lDdHhk?=
 =?utf-8?B?djFiaTlHVDFwbW1MbWsrb2N0YUw0UWhNV0c1SmVWQTJYT29za3lwSVBJNmVj?=
 =?utf-8?B?eitkL1JRL0Z4cUJWaDI2MkhWR3lZQ1ZWYVRzT3pvOXFPTzdQbDdTRXV5d2J4?=
 =?utf-8?B?REpMY0ZUVW9kcCt0UDBOQUtwWTVQRWNZTWJubXI0UC96M243Q3dGNFk4cTlu?=
 =?utf-8?B?cWE2ZFpBNW82b0d3SFVrbk8wYW4vU1VORnVMaHRuVHU5eW55cTEzcDhrREdi?=
 =?utf-8?B?S25EZytDR0FyK2J6Z1IxM3VKeWc3R2FpajJwMEhGdkUvRVM4dFRabW5KQkN3?=
 =?utf-8?B?YXpxV0VObTljYmxaRHgxZXkyNXlrV0lmZ2tpQzI4djZsZXVqTk43VnRUU2lq?=
 =?utf-8?B?bWhoQXdpVHZRZkpXMmZlZkhWSm5OR2lVdlJYcW0wZjFML0dEUjZ6cjVlbVE1?=
 =?utf-8?B?SWFYMU81K0FqMHNzc1dRcExCSkpSKzBuMmxHZGVNMW9jUFVKdEJ5cHQrSFNs?=
 =?utf-8?B?bzIvYlp2S3BDZ2VMbG1rSUVmQ2NZNjhRbXYrSlRzaUpzaWZhWDY3cFRkRzd0?=
 =?utf-8?B?ZXptNVI2bDRDY2UxMjVneVpoVzZlTGtuaGsxY3VXaUlnd0I0cHV3cEt0ekFZ?=
 =?utf-8?B?ckhTSDd4OU1vSDhHU1VGb2F0UkVvUkIxQ1VNd0NiMS9rMkpwSlBnczBLM1cr?=
 =?utf-8?B?cmtOOUVYU1U2MTJBU0MyWnNnUWRxWHFMS0NMSDRCbS9EQkFLTThLU0ZsbEZF?=
 =?utf-8?B?UGlHYnlRZFQzMUR6eWZSdmhlMEpxZ3JHNEZpRzJrcE1ocG40cTcyRzl0aGt5?=
 =?utf-8?B?dS9jdkVkMS9ibjhwdG1TTHp6dXEwS1FSQXgrVGRjVmpDU0xRdlBndGwvUE5R?=
 =?utf-8?B?MytVQytJc1FVWnJvYUcxWXFXOWRxUjdTazBaSW80UEVYWlVHSk1XTGV3dFNW?=
 =?utf-8?B?YVUzM3pMTmhBVy9IZFkvOWk2U2J3S2NwQmtsUk45ejJKakJ4UjR1UC8zc3dX?=
 =?utf-8?Q?hrDLRmwPEmc4Fve5kI9CVUf1Qliq3+S6uVCGVQ9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9906b685-8b00-4e7a-e344-08d96ea3ed1a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 06:27:38.7931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwJqWj04ZPkP4mH0NsD7+tEEmTbCbrzfuWhPTRkmMwVBl+2gYVpNkvB+cVaF11Wh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4550
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.09.21 um 19:01 schrieb Das, Nirmoy:
>
> On 9/2/2021 6:34 PM, Greg KH wrote:
>> On Thu, Sep 02, 2021 at 05:10:24PM +0200, Christian König wrote:
>>> Am 02.09.21 um 14:20 schrieb Greg KH:
>>>> On Thu, Sep 02, 2021 at 02:03:12PM +0200, Christian König wrote:
>>>>> Am 02.09.21 um 12:38 schrieb Greg KH:
>>>>>> On Thu, Sep 02, 2021 at 12:29:17PM +0200, Nirmoy Das wrote:
>>>>>>> debugfs_create_file() returns encoded error so
>>>>>>> use IS_ERR for checking return value.
>>>>>>>
>>>>>>> References: 
>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1686&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C7a1f1095c0d64416576c08d96e2f7b38%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637661973378236086%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=g9BQRJG8gvjGFq6oj5vk9PCemQ39U19CLmkMNHVUafg%3D&amp;reserved=0
>>>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>>>>> ---
>>>>>>>     fs/debugfs/inode.c | 2 +-
>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
>>>>>>> index 8129a430d789..2f117c57160d 100644
>>>>>>> --- a/fs/debugfs/inode.c
>>>>>>> +++ b/fs/debugfs/inode.c
>>>>>>> @@ -528,7 +528,7 @@ void debugfs_create_file_size(const char 
>>>>>>> *name, umode_t mode,
>>>>>>>     {
>>>>>>>         struct dentry *de = debugfs_create_file(name, mode, 
>>>>>>> parent, data, fops);
>>>>>>> -    if (de)
>>>>>>> +    if (!IS_ERR(de))
>>>>>>>             d_inode(de)->i_size = file_size;
>>>>>>>     }
>>>>>>>     EXPORT_SYMBOL_GPL(debugfs_create_file_size);
>>>>>>> -- 
>>>>>>> 2.32.0
>>>>>>>
>>>>>> Ah, good catch, I'll queue this up after 5.15-rc1 is out, thanks!
>>>>> Thinking more about this if I'm not completely mistaken
>>>>> debugfs_create_file() returns -ENODEV when debugfs is disabled and 
>>>>> NULL on
>>>>> any other error.
>>>> How can this function be called if debugfs is not enabled in the 
>>>> system
>>>> configuration?  This _is_ the debugfs core code.
>>> Well, that's what I meant. The original code is correct and Nirmoy's 
>>> patch
>>> here is breaking it.
>> Ah, yes, sorry, you are right.  This function can not return an error
>> value, if something went wrong, the result will always be NULL.
>
>
> I just realized that we don't return NULL on error anymore:
>
> commit ff9fb72bc07705c00795ca48631f7fffe24d2c6b
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Wed Jan 23 11:28:14 2019 +0100
>
>     debugfs: return error values, not NULL
>
>
> and the current doc also says "If an error occurs, ERR_PTR(-ERROR) 
> will be returned."
>
> If I am not missing anything, this patch should be fine.

Ah! Yes, now that makes sense.

Looks like that my memory and the documentation under 
https://www.kernel.org/doc/htmldocs/filesystems/API-debugfs-create-file.html 
is outdated.

I can update my memory, but I have no idea where this documentation 
comes from and how to fix it.

Regards,
Christian.

>
>
> Regards,
>
> Nirmoy
>
>>
>>> Nirmoys other patch is for a driver and there the function can 
>>> indeed return
>>> both error code and NULL.
>> You should never be checking this stuff in a caller anyway, so no, don't
>> do it there either.
>>
>> thanks,
>>
>> greg k-h

