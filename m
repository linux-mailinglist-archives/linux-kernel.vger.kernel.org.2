Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E3E43D152
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbhJ0TBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 15:01:47 -0400
Received: from mail-dm6nam10on2073.outbound.protection.outlook.com ([40.107.93.73]:39681
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230073AbhJ0TBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 15:01:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pps23zMkCSoqU5+Fmwg/d9+AFb5BedMuDRtAq4dx1t/ExggJeJlE2splgv1mEyCUK5iIcimhjFyUgyzs7yun5/xWXXHmqdBHJ7btoT3rrwYn9trTkMY4fY8w/U+rh4eYjAolcYaN+P8PH/lqkmo+xOQT0Kcg3hKsVqBb498dn1OP24Hi4F02BBVq9sCOQVyFO+mlmuVVJHRMH4n0wXk60iVlV32vXvNB6wOtXRvNwv36pYYjikbrGya7bVXVOFqm4k+lyWkQE1BFuMQ6Xn99rPF7Bh9nDlWg9iCfpg3fRJaL3rjSF2gunkryMIlupRMqMq1pyWQMldaFitos90Wa9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQTER6c+LaabLgDb1kNwlNpF5hmGeDxwBccKo1EixEc=;
 b=WSVfek8aZQBHLeiVkzY64phOtYy27e2PRR+ODAgoqzSdPN6W9lKrwAj5Fue+PxRq2S0Gwx0HOBMG7KY1gs8doqlw66ICxMpNRgHX9WI694um8ZxOk3PXNoCO0f/tPN3LZf9hBLYZOD0v8qg7O6jvVy+IGpDnNlfUdnCSIuu+eJ264tTYlPUzZTZCuawwzLICmQX+JnkQXAzb51Cc3YkESwSmVT3b0j21WfClPjbmjKYcRHXRSC89aWfNyUSoYFVqVVdRezzG1xdCOk0mIIKYGClwrkgA1OAkMEYBXKSyyEC78DgWsroBep+hQSx6M40OfUxNZp8j7y4RY3bQsodY0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQTER6c+LaabLgDb1kNwlNpF5hmGeDxwBccKo1EixEc=;
 b=eL5/f0dkpqp3Lsg00gmK4RWQfxQDSOEd7cZWzWqRx96HaQ6NKMMgeMHZvbpeqPWao0Uyr8ApL6dP1ISLtNMYx35gwpEQT07Nzk1liOyaRAbFY3xfG/FNud9VxKSzg96IZkTPuLoeCKVD7oVhQgfVTAZom6zGqgLemAcSwSMpiPs=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR1201MB0254.namprd12.prod.outlook.com (2603:10b6:301:57::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 27 Oct
 2021 18:59:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1%5]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 18:59:17 +0000
Subject: Re: [PATCH v2 17/23] x86/resctrl: Abstract __rmid_read()
To:     James Morse <james.morse@arm.com>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-18-james.morse@arm.com>
 <887f8946-6d2b-27bf-a49b-f83af05cbc68@amd.com>
 <dfe2f33c-6103-9699-42f9-73983fa62057@intel.com>
 <81826a4f-c3de-787f-8059-4808815b4800@amd.com>
 <71efc804-4ca0-f31b-4485-005b3ad6e4d4@intel.com>
 <859c5573-b025-7754-94bf-294c7da3abdc@arm.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <438e6316-3a42-7f96-44c4-528f905eb832@amd.com>
Date:   Wed, 27 Oct 2021 13:59:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <859c5573-b025-7754-94bf-294c7da3abdc@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR14CA0024.namprd14.prod.outlook.com
 (2603:10b6:208:23e::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
Received: from [10.236.30.47] (165.204.77.1) by MN2PR14CA0024.namprd14.prod.outlook.com (2603:10b6:208:23e::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 18:59:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cec15c3b-f14d-44f5-6991-08d9997be03b
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0254:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0254643C5690F527855B4F8195859@MWHPR1201MB0254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDX8xaRkjaKFEmXRJdAAqOUHfXAkkdzpe8FG024v88A9TdUsObtjUrxVH9zTMOOQhsVQqsEwseDUak0ng3t3xCPcNHANzTw3jYK+JJj7PHoIF/MGqoh0c7E6Upv3xbB39jARnM21/w7PicwVX+OTCq4H+EaibX0Ph9tY8xjfOEq9PHucrhJrlUPnbZfph0+vdRcoCof/aFzZu972W8VGko5Xlpx+oNiepScoEDkyg82IvFE9n4dGDdu9lL8Osq/UYKDdGlcaTpZtINKB6R2AcFUnWV0Es4mQBdxJfFOe9Qf1XMJBJymo9g87jZfjKLOJnM5lZQK4Eh62UcpbOfkXBabbHCO5qcm6IHmy9PvVQN9RZCMY5nnTVZTWz19T/sP4sggrLINFWBK5YXMkMThXVxjh75uhwYJHR/+jr6RPoovqbrsV/XzYFh5vOtdUGBkaL35GPX+nMPd+LZhaOKNa5++BVM3jNm1LpuDRtSW0aX7g54uz8fQ8Y+XaZXFITiRBPF61IG8HI0QGhCP8ELFUZJV6sAu0cfo4B28DJuVNI/AMkWUz4z82s2rH6+z/vIDut6zUsQsnlCWGS3m/kv/FAw9zLK3vfBEXQqpj1rJ+bqgkhjfhPPNKwgrIf1+chcxeSWaUwXayn4YibxwxQzdvkHqZJwSAlkdqfMwAaqXGoT/v1qOzqCFHHvgZxCAOyobjWgDw/KIXf7DvYHy5xbUogj7wQv2BWwadypTuM/0rsuIOpJeLPozDoYJ1gYduZs/kuC8fuitTFgrqqXYS8+AbaXNDkz5eN206vXCi0ip0racQb+KHVusq4X8Zdzd4mQFo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(8936002)(53546011)(66946007)(6486002)(66556008)(66476007)(86362001)(38100700002)(31696002)(508600001)(83380400001)(54906003)(4326008)(956004)(2616005)(44832011)(16576012)(110136005)(316002)(36756003)(966005)(186003)(45080400002)(31686004)(7416002)(2906002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjkyN2hTMHVRc1RaelpGQmR0N0h3eUd2aEZPckUrYjhZNG8rZG5nZHllM09W?=
 =?utf-8?B?b1FzZk4xTldGNWplYW9mditBc1NHaFdEN1ZITm51dDBob2VDVytBdE51cEEz?=
 =?utf-8?B?a3JlOHo0RUl6c0tNRDZoMUVybVlSWFFtQ1JMVlZCNWRnd1J5N1A1ME9oc3ZT?=
 =?utf-8?B?eGRjNnY5bEc3NytXUU04U2l1RXpzYk1pYm5mTGVyUmlWU0JIMEx5UDVmTGFG?=
 =?utf-8?B?dnBvQmt4eTljcnNkNzBqMDNRRnZ4UVlDRjMrY1FnQ1dVRTdQRTh6WGFzSU1m?=
 =?utf-8?B?OEVoczZRYmlGQW1SOGZ2VzFqa3pMQ1VvMTdmQ0ZEZGFubExhVWpjODNvT2Vx?=
 =?utf-8?B?d2s3RnplRGZEelRNTktoV09SZEJ5WDFpK3Z6dDE3Y2pyZnM2Z09VbnBHMzFJ?=
 =?utf-8?B?cVB0YzVQM2JZZ2k0N1ZmN1gyTzJ6NGlOeHdNc1lRQjBjcExySXVGakoydkhW?=
 =?utf-8?B?OXFNUTRDOGg1SmovTUdGOU9hc29WNFFHa29lWFZKSzhNOTA2c3R3RkRWS3lL?=
 =?utf-8?B?S2VkZ1NNbytLamo4c3NBdllXc2VlZWV0eHVqUTh5anVDYkd4QVI4cEN6ajVT?=
 =?utf-8?B?VDczSHRhS2o2QXpLakd2QStFYzNFanYwaU52YlZMdjRLUE9ncndCSXlOcGJl?=
 =?utf-8?B?cmt4bStXcEJQaVovRFBTa2xaa014OEhOY3kyQVBaWG0wT2oySW1oaXlOSmJ6?=
 =?utf-8?B?SmpLZXY1S0Y0ajBQK1ptMk1tNkphc0ZJVzRKakw1NzFFRTdDQnk5cUhCRTlt?=
 =?utf-8?B?bSsveVF5K3FmU2hraUh6VGV5SmRmZ3BRcVovMythUjlCNW1OMDJRaUhqcnlF?=
 =?utf-8?B?Wjc3SUtJSHFEVVk5bndsL0ZTSjVKTUNCYy9jcHRQZDY0cmtvT0J4dWVRcGVu?=
 =?utf-8?B?MWc3Wk9zMTRWYktTQlU5UkJ4NTZHcDcrNFFkNVk5VzJVeS8vQXZDd1loZW1l?=
 =?utf-8?B?ejV6K3JxeGJwYnpLMnAxeG9wWFVHZnZQaVNtb1FhQ1Frbm50ekdMN0llVVVo?=
 =?utf-8?B?WHpVNU9jSWlNRWF0eUdDV0RiUm1NZDJCWTJjcVlYNWxPS0xQU3R0cTU3QWc5?=
 =?utf-8?B?dVhiakw4Qjl5Y2Y4VWtSelgxWGI2YXBoSzl3K0JvWXZuWUdSNzByb3RvWERq?=
 =?utf-8?B?VG9uNi9kZU1wT3NPWUFLOThoZkVGcHhJWTdpeGczc240VWczK2tKWjY3ZUQ1?=
 =?utf-8?B?YTJvQndmZzJrajJZRVE2RWhsc1J0L0tQYW9uTzdLQmFHQ3FHY0grZ2toejAw?=
 =?utf-8?B?YmlyY0RRZ1JWN1NwRDBwQlIvWU9VNG4yWTNVL3dXbHNnTU5OcDIyMXJXZk1K?=
 =?utf-8?B?NmJhcVFTbVNnZFp2aWhZblMrbkkwaVU2cHBtWWNRc2FESFVtdVplS21qR2VP?=
 =?utf-8?B?Vmd5RHh3Q0Z5U3RtU0VuZDRTRHh0bUdNemxxaFdHbWR0S3g3ZHpjKytrUkpR?=
 =?utf-8?B?ZXRRbm9ZU2tWbWNPdUtLMUZmNHFkb3JsWVRxNksyc1FnYy9mRk5JTnUxc0l1?=
 =?utf-8?B?bHRIMmpudEhwWSt6eWk5cGpTcWpvZjZpUWJDRkYzaDdHMjB2cmdIUWNSZnpy?=
 =?utf-8?B?cEtKazZVci8wL3A0T2VpQUxZS2NCOHB1dTFaRXJJU3VsakdHSmNBY2JyMVU2?=
 =?utf-8?B?TEozRDhGL0c5d2VmTTE0TFp0SlFtSDVEc0psOXk0Vml0MG1KaVN4R0dCR2xW?=
 =?utf-8?B?N1dINlRha0J6eHh3QjFXN3JYSEFBb0c1OE9oRklwV1c2NjFBV1lBNXJTVEJV?=
 =?utf-8?B?WE1ldlJxdzcyNHZqcjVoMlN6V1JnU0FPM253MWx4WkZxY2plR2h2QWYrZWlp?=
 =?utf-8?B?SUJLOGdIcSt3M0hIZDZZaFRZQjladlA3QzNHZ1FoTzR3TkdlOVVWSUNBbUFQ?=
 =?utf-8?B?cnhZRHlMS0NRcFVwb3JTS1hCRTZiRGQvbWRXdTFNbzVhVkRaZFFvdTRMZi9n?=
 =?utf-8?B?bG9mYldqRmxkL2pGdGlyTnFjVHJWb1JhdkV1dmdMbTJuNmJEVmRURkcwNlRx?=
 =?utf-8?B?RDUzUzBMS00xb1FUZlc0a295Lzh6bFY2VnRyOW83aXBsdmhCYlV6VnM1MFZ1?=
 =?utf-8?B?MXFwRkFHSzFwQjc2VUNqRElKclpYNFpqSGMxUzZkT3JpYzE4WUVobURHTS9B?=
 =?utf-8?Q?8dw8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec15c3b-f14d-44f5-6991-08d9997be03b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 18:59:17.4032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzUFmg5EhWA4EzWV5xo+V7iYjGadD2uudVnhvaqGeHyzbDFiSNiCtbLch1SG8jkL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0254
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/27/21 11:50 AM, James Morse wrote:
> Hi Reinette, Babu,
> 
> On 20/10/2021 21:28, Reinette Chatre wrote:
>> On 10/20/2021 12:22 PM, Babu Moger wrote:
>>> On 10/20/21 1:15 PM, Reinette Chatre wrote:
>>>> On 10/19/2021 4:20 PM, Babu Moger wrote:
>>>>> On 10/1/21 11:02 AM, James Morse wrote:
>>>>>> __rmid_read() selects the specified eventid and returns the counter
>>>>>> value from the msr. The error handling is architecture specific, and
>>>>>> handled by the callers, rdtgroup_mondata_show() and __mon_event_count().
>>>>>>
>>>>>> Error handling should be handled by architecture specific code, as
>>>>>> a different architecture may have different requirements. MPAM's
>>>>>> counters can report that they are 'not ready', requiring a second
>>>>>> read after a short delay. This should be hidden from resctrl.
>>>>>>
>>>>>> Make __rmid_read() the architecture specific function for reading
>>>>>> a counter. Rename it resctrl_arch_rmid_read() and move the error
>>>>>> handling into it.
> 
> 
>>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>>>> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>>>> index 25baacd331e0..c8ca7184c6d9 100644
>>>>>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>>>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>>>> @@ -579,9 +579,9 @@ int rdtgroup_mondata_show(struct seq_file *m, void
>>>>>> *arg)
>>>>>>          mon_event_read(&rr, r, d, rdtgrp, evtid, false);
>>>>>>    -    if (rr.val & RMID_VAL_ERROR)
>>>>>> +    if (rr.err == -EIO)
>>>>>>            seq_puts(m, "Error\n");
>>>>>> -    else if (rr.val & RMID_VAL_UNAVAIL)
>>>>>> +    else if (rr.err == -EINVAL)
>>>>>>            seq_puts(m, "Unavailable\n");
>>>>>>        else
>>>>>>            seq_printf(m, "%llu\n", rr.val * hw_res->mon_scale);
>>>>>
>>>>> This patch breaks the earlier fix
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fh%3Dv5.15-rc6%26id%3D064855a69003c24bd6b473b367d364e418c57625&amp;data=04%7C01%7Cbabu.moger%40amd.com%7C00eaab44815947ce7eb908d99969e584%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637709502411367349%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=4udUc%2BEurWdC%2BAPQFs2eG0aVbsv3SnIXcEyRj081hxk%3D&amp;reserved=0
> 
> Aha!
> 
> 
>>>>> When the user reads the events on the default monitoring group with
>>>>> multiple subgroups, the events on all subgroups are consolidated
>>>>> together. In case if the last rmid read was resulted in error then whole
>>>>> group will be reported as error. The err field needs to be cleared.
>>>>>
>>>>> Please add this patch to clear the error.
> 
>>>> Good catch, thank you.
>>>>
>>>> Even so, I do not think mon_event_count()'s usage of __mon_event_count()
>>>> was taken into account by this patch and needs a bigger rework than the
>>>> above fixup. For example, if I understand correctly ret_val is the error
>>>> and rr->val no longer expected to contain the error after this patch. So
>>>> keeping that assignment to rr->val is not correct.
>>>
>>> Yes. You are right. rr->val is not expected to contain the error.
>>> Hopefully, this should help.
> 
>> Yes, this looks good. If the first __mon_event_count() succeeds but a following one fails
>> then the data still needs to be reported so the error code needs to be fixed up afterwards
>> and cannot be done inside __mon_event_count(). Thank you very much.
> 
> Thanks both! I should have worked this out when splitting msr_val into two values, which
> end up getting set the same.
> 
> I think the 'Unavailable' issue is subtle enough that it deserves a block comment.
> I've replaced the rr->val chunk with:
> |	/*
> |	 * __mon_event_count() calls for newly created monitor groups may
> |	 * report -EINVAL/Unavailable if the monitor hasn't seen any traffic.
> |	 * If the first call for the control group succeed, discard any error
> |	 * set by reads of monitor groups.
> |	 */
> |	if (ret_val == 0)
> |		rr->err = 0;

Looks good.
Thanks
Babu
