Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771D94353BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhJTTYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 15:24:23 -0400
Received: from mail-mw2nam12on2077.outbound.protection.outlook.com ([40.107.244.77]:4737
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231485AbhJTTYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:24:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7JfpW0KkyOt0WYDPAVGB1eC7tfHgTtTpMo1lQ6WP+EIPARBSV0w10KfIDXCOEFQVq8ow9utvr/TDpCAsUdrkGdrsrtpL5HP877cYN6Ck4AlaE20QqDpyL/t3Rxao+Br3br7+URh0BM0CspBgBqnU6DpvbbqUBUmqAIN9n6fFJwxVPTZE+bBWmpOIAP5Wg6T/6vJoMQ3b7z+fHN87j60o/EgevpWm0dmdg6H+BX+DFZvRE4GVY2LB51DGBlIPRgxLG7V1+5COIw60nwppzHEy49MMfdzGcVAtsJOJHXFuOpFh1LY/Td+b44bL7Bf0NcyylHFXs5xB5iKBCHnBS0HuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eYB1Rs5VjFffnWOsXbzsKPRFc21/xRz075CdJI1A9A=;
 b=cNgRnACDccUSqJz2WfCXi7KaSt/PFrKneM6aqXuWv7tNlPSp6n3i29bVs/TJLVxbOHmBxoEykvixGx3BYZg+Aw60iduIixv3izngIJO8tEaB2Mly/PzoiDOQBguXsiFZA0eI2uotslOMjF6ISfQIiAf9iyR/C5N5DXP9KnTpUUbfwwxQg+6uf5ozJbUIYXmRuDLXczf577PWgsSSjzWHONcIhyoEpuSbhR7ymGUgF5ZPtyCcmFLWttYxonVAFWiK6DG7dgSOJLPozI3DSKIu6c9d+toSTvIggP8Uf4a5p50tTv7PGKNgwsdehuxfkhlBdSsdxqA3dSvCcXvQESh/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eYB1Rs5VjFffnWOsXbzsKPRFc21/xRz075CdJI1A9A=;
 b=qFcTz/TCdI6XVARHVBASyY2yS3rJP98Z5hoW8ZBU/sLmUd0xAK01TD1wujFa8xakTBEyKNHOJj7pfnVtoDXmi0Z66CFsFQyKV6YXM3IaAgiZUdkp6W/Ps5h/rwKXxbGgYcsjlPgsLoOVPBctUNkAZ79OFhEA6zyP/9hLeyb9yPU=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SN6PR12MB2781.namprd12.prod.outlook.com (2603:10b6:805:67::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 19:22:04 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::a118:1560:d5df:ba59]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::a118:1560:d5df:ba59%8]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 19:22:04 +0000
Subject: Re: [PATCH v2 17/23] x86/resctrl: Abstract __rmid_read()
To:     Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>, x86@kernel.org,
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
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <81826a4f-c3de-787f-8059-4808815b4800@amd.com>
Date:   Wed, 20 Oct 2021 14:22:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <dfe2f33c-6103-9699-42f9-73983fa62057@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:610:32::6) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
Received: from [10.236.30.47] (165.204.77.1) by CH0PR07CA0001.namprd07.prod.outlook.com (2603:10b6:610:32::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Wed, 20 Oct 2021 19:22:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47dc5857-397f-4310-2b8e-08d993fee61f
X-MS-TrafficTypeDiagnostic: SN6PR12MB2781:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2781A60EBAC723ABD4AE890695BE9@SN6PR12MB2781.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wf2Wuk0OlYPU86f9GBhgoALPaPQYuQocrB660DEtkCidB1jZXzftZ9DSbZ3vjgIKfxKElumgRzRdMO0zp4nf0lz1izwe8yzGHNgBgT9vXIq+TLuq0QaRZ4UrvcpYgxRf9M2wkYQpLC+ZUWEww6k4berFSmKEnda7gz5VdBi9HDGOdlmc1lG1KCPZa9lhRtiF6XuefxseACMGAnURP8QTh3cyDu0rj36N7CRWWI2rO4fgOlOWgI5dbSc7soNFWsTkuPXjX8Kh5T9YD0UdJY89B99+Nsft9tgb6AIFE8cXKk21MyfWG0lYS8wMfuhiB+6bxaXZGqLZE1VQeoruqqyQIj6yhsGYMSVhjp3K/cqk6/o3c94PNTqmdTIsX1WiPn/dABxADdB8SsL1V22aNdbrNsRcsAvyTl8Z0pJjSBCH1psww3H27QY+bVNQgp99UCsDjRJ4m74M3N0mwcv9elLLVw1CHZleSoCiT8L5xosxqdqphiM9dbSDw8vUNCPxfd0P3DpmKgFE+TVjwYorRJKF8Cl3q+Mb80iSFKhNleHeSatIkzUwh3Xqwo9LbJV8/2B5uEDqOuth6QzgTZa0MvhLYAamyt8EzOZqDDJpJFDFLsbsV0WEYD3KASpu10dRP0tWdZ4gHh0bjdTD812IdjdIoaOH4V8Z0Gcv6wl/OY+/7VF6OSQV5SlWMe9d9+kkKuJ6hACsrnl9jTM/CMr+pKfu/FojIrE+KeMUdz7VJhBGkKspWLP/Z5XeJItxb7Z1Hmrnm2pc78x1was6cUzub1t5HA36akVDEY2Hoqy4C41rIHw7l6JkfHrck9ArzwIGKxoX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(186003)(16576012)(316002)(6486002)(966005)(44832011)(45080400002)(66946007)(508600001)(66476007)(83380400001)(66556008)(4326008)(2906002)(8676002)(956004)(2616005)(7416002)(8936002)(31696002)(86362001)(110136005)(5660300002)(26005)(54906003)(31686004)(38100700002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2NwUktpSFdJNkNYUncyaTFvZ3pucTlrOWNDSXdFWk4wdWZxYnVNUUR4WmIz?=
 =?utf-8?B?RFpNcVp4MzYxT3NwVGtWSC9yT1BBd3craFVKWXB2M3hQcHhlRGxOWWsrT1ZE?=
 =?utf-8?B?QjhzKzZaWEVVMktXSXAxaDdnWGlCWEV1UHgreG4vRjl5UGNSK1paTlprUTd5?=
 =?utf-8?B?L3MxTnZZR1BVSUtRWkZnbkVlUk9kU1JFNWlzTzVZdEk3ejE0UnE1RHBPb1V4?=
 =?utf-8?B?ZVJ3WHJyb2VYcVNROGJaclVseDNROUZVTlJKTHNlSHBkdTM2cUFJVmlxZzV2?=
 =?utf-8?B?MEZYRGc3STY2SDlaRzJsME4vV2grNVY2Nm10VDVFd3RkRnpHWU44akVUVmFL?=
 =?utf-8?B?L2tUa3VhZnVUOVZLQnZiM0ZNazRuODJkYVhqQlE5VlBNQjVseDNyM1ZoblFp?=
 =?utf-8?B?OUl6UXMzWXVmV20xRjFnTUVlSEN2ak9GVnhGSDJhY1hTYU1LVGFxOHFheXlx?=
 =?utf-8?B?ak4vZ1lyMmxNMUhleUN3M1JoZU8zR0JFL05HdEtQd0NKVTY2eFRtZ05tRkZy?=
 =?utf-8?B?NVNqbGxtOUQyZXQzTnhwVlNzNHcrTmk2amRpSXc5YlB0dGRNNzVJZjA1ZkUy?=
 =?utf-8?B?VVhlVFRVeU1ob1ArUzBlS0pZTEFUcms1clFhdUlsMlgxMWpDUXBud05BOUJ5?=
 =?utf-8?B?WHhzN3FHQ2xqbkpnNkFBRloyOFhEeXNRb29Rb3N5eDl4ZWIzd0JLTkZCMU9U?=
 =?utf-8?B?NWRSMWRyamlEWkRZNjgwM3hCU2hjY0VtQ0hMYnVuRTM1WmZISmc4T1BVUEVV?=
 =?utf-8?B?Y3RGY1h0YUFYenc1STJZRkE0eXExMGMzVDhrb2x5KzNuanJBUGdrbEkvN2lk?=
 =?utf-8?B?WnNTandTeEE0dE9JYktuaDFLUnJ1QzdaNUlvRmI3WmNzNzZFNEtoTEQyajBr?=
 =?utf-8?B?Z0hsWXQ0WlBZTFRZTklKb25sQjgxaXlsanUwVWpzN3dneW4zbE03RmdKdEMv?=
 =?utf-8?B?d01Vb1JQaUQ2Qi9nZVppeGFRVERiemVnMGV3UHZ3MFlhd0QrbzFsYngyM0s3?=
 =?utf-8?B?ZFk0ZzJCZllIRDQ2THZJeHEzVGRRYUhldFNFMjU3ZlBzemxDY3NlVHJUUSth?=
 =?utf-8?B?aCsyRFN1bHRxVXZCSHVMYXFia1JuMndCbUhlSnB4OHJ6b2FxNzFBV00yVTE0?=
 =?utf-8?B?UnFWZkpPRE9pRjJ0T0wrQnF4eElqakk5ZjlpY2g3R0QvQ3BRY2FGMUZoTFZI?=
 =?utf-8?B?THgrMGVOTFk5WVgzQWh5TzhPanBjVytwajRoaVdobHNsQm1BbWJkTVBvYk9y?=
 =?utf-8?B?ZWdXWHhPYkRHOEtlQXErMnFMMkVJYXY3b2hodThrSkZ4ZmIrTzJWR1htelVm?=
 =?utf-8?B?K3ZUTUExZFliZ3VZRkFBTmdqZ2NBNk4rUmowa3BLTms3aW5NbUFQV2ZnVVF3?=
 =?utf-8?B?cWwvVjliUXo0WTFUMlFuSHlWYTRVSk5UZTZKU1BqTGNYVjVWaEp4UnBkYUpX?=
 =?utf-8?B?aWdTb2hpU1I2Z2Rud0s1cGx4QVN1SFFyQWVLcno4MzBZOXc5L1ZjZTdMdmVR?=
 =?utf-8?B?RUQxZEJXNS9kY01NUW1wUjZRTkhKQ3dWMlRpNHY5MUIzTWo2RU9DUzhlSkJa?=
 =?utf-8?B?enNwOGpNRHJDTThaZkxMcUdjZjFEeU5hdncwZVYyV3dxNUNOZDN2Q2tDajc2?=
 =?utf-8?B?elVua3pOa0FzUTlhNEF3L3g0NU02NFptTEF2VStSNWVqY2xIdjFhbVRpRTVK?=
 =?utf-8?B?dklIZTliV1RsNmJVQlFaRmllR1BpUk5jZjhQWUZvckhybTQvMmQ4UkkyVnBL?=
 =?utf-8?Q?Zj7fi+07CvqF3v7l5MRMsIAngmFN8jlx5ArcVzm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dc5857-397f-4310-2b8e-08d993fee61f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 19:22:04.3186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmoger@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2781
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 10/20/21 1:15 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/19/2021 4:20 PM, Babu Moger wrote:
>> Hi James,
>>
>> On 10/1/21 11:02 AM, James Morse wrote:
>>> __rmid_read() selects the specified eventid and returns the counter
>>> value from the msr. The error handling is architecture specific, and
>>> handled by the callers, rdtgroup_mondata_show() and __mon_event_count().
>>>
>>> Error handling should be handled by architecture specific code, as
>>> a different architecture may have different requirements. MPAM's
>>> counters can report that they are 'not ready', requiring a second
>>> read after a short delay. This should be hidden from resctrl.
>>>
>>> Make __rmid_read() the architecture specific function for reading
>>> a counter. Rename it resctrl_arch_rmid_read() and move the error
>>> handling into it.
>>>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>> ---
>>> Changes since v1:
>>>   * Return EINVAL from the impossible case in __mon_event_count() instead
>>>     of an x86 hardware specific value.
>>> ---
>>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 +--
>>>   arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
>>>   arch/x86/kernel/cpu/resctrl/monitor.c     | 42 +++++++++++++++--------
>>>   include/linux/resctrl.h                   |  1 +
>>>   4 files changed, 31 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> index 25baacd331e0..c8ca7184c6d9 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> @@ -579,9 +579,9 @@ int rdtgroup_mondata_show(struct seq_file *m, void
>>> *arg)
>>>         mon_event_read(&rr, r, d, rdtgrp, evtid, false);
>>>   -    if (rr.val & RMID_VAL_ERROR)
>>> +    if (rr.err == -EIO)
>>>           seq_puts(m, "Error\n");
>>> -    else if (rr.val & RMID_VAL_UNAVAIL)
>>> +    else if (rr.err == -EINVAL)
>>>           seq_puts(m, "Unavailable\n");
>>>       else
>>>           seq_printf(m, "%llu\n", rr.val * hw_res->mon_scale);
>>
>> This patch breaks the earlier fix
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fh%3Dv5.15-rc6%26id%3D064855a69003c24bd6b473b367d364e418c57625&amp;data=04%7C01%7Cbabu.moger%40amd.com%7C85219a5827114935cdaa08d993f59fa0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637703505420472920%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=yP8awDgGGZ%2BWj5ZItdTNJItTVuK828yGnibwq%2BrVaf0%3D&amp;reserved=0
>>
>>
>> When the user reads the events on the default monitoring group with
>> multiple subgroups, the events on all subgroups are consolidated
>> together. In case if the last rmid read was resulted in error then whole
>> group will be reported as error. The err field needs to be cleared.
>>
>> Please add this patch to clear the error.
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 14bc843043da..0e4addf237ec 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -444,6 +444,8 @@ void mon_event_count(void *info)
>>          /* Report error if none of rmid_reads are successful */
>>          if (ret_val)
>>                  rr->val = ret_val;
>> +       else
>> +               rr->err  = 0;
>>   }
>>
>>   /*
>>
> 
> Good catch, thank you.
> 
> Even so, I do not think mon_event_count()'s usage of __mon_event_count()
> was taken into account by this patch and needs a bigger rework than the
> above fixup. For example, if I understand correctly ret_val is the error
> and rr->val no longer expected to contain the error after this patch. So
> keeping that assignment to rr->val is not correct.

Yes. You are right. rr->val is not expected to contain the error.
Hopefully, this should help.

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
b/arch/x86/kernel/cpu/resctrl/monitor.c
index 14bc843043da..105d972cc511 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -441,9 +441,9 @@ void mon_event_count(void *info)
                }
        }

-       /* Report error if none of rmid_reads are successful */
-       if (ret_val)
-               rr->val = ret_val;
+       /* Clear the error if at least one of the rmid reads succeed */
+       if (ret_val == 0)
+               rr->err = 0;
 }

 /*
