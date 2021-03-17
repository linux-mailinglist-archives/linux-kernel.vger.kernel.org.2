Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1493A33EFCE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhCQLuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:50:52 -0400
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:26529
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231453AbhCQLur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:50:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFV6BtDkwFqPWCdzfiR19/CvCa1ikZGXgKf0bZWOWVhydaDHdabC4nm3VXNpXjk/S5MWICNBpl7d2RwcJlLbdXL6A9JBWS7lsbFoQji9HxjOw+1/EdG3tNrr5o/BRxdLoxe3Vv3M5nbei7kX2ehk1D9Ic+iSNX5+559fFud6PX2UU+wuFYj6JejB32C3j5urh3ZfyV0VtMo1t8R06CUhp7YbJh4JDSbmdx5ucELfguK7rkhS1zHry85W6PZIjuOErFxo9zjWGybekjEpRyEAPlXC3oZQBmEkhOTn1fWDmkr6QlHsNelGaGwsVUVaGy+ayTyT330OTdkubdPRGHrFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUcvGIGle7jHdbaBFwdy4214C6jnzxO+vikGHZqx+d0=;
 b=lmhxLwC18kCUpL6zkeYVnjvR5NR/qVn/+hsduns/7I+VfU/Hz6EzQ/BEXoNJdXEu664HgsyZBUOioKrBfxrdHHBU0oUJJbBcwbq8BoD4mN/1L1B0qYzBAOazC6jw5tZOmIaMhnTJDTdZOc7IEZJCgfyNwNq+ngF8Gv8AjJgz4p6R42Gwgk0jYCZNqy30zy1dHpVgp3qOwsXjnf0DwncWvN773SmgPKsr/sNYfHQShdjPG36IlsOJm5/Q02V2hW/h8cigm6SP33Wl5LEZL0ZdEmj0kdqZOQGHI/wkqs4+KFUnHV2/TOOX6WkQJZtHHEM+oF6U/3gbLoD/B4ewDvBRwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUcvGIGle7jHdbaBFwdy4214C6jnzxO+vikGHZqx+d0=;
 b=jxGEKCilTUYZSK5ZAq33Zm60Q7SrYrDXpztFzTWIUbxpR7huQdiLf2XREbyq8Ok9UAtw31KA1WMtt6D2r/rpYJbflVmFB/ubNZ309zZWftHF8EeRvrklT8wyVLKySvdPkIVCYZzooiKPDpBgi3mqTZj0MdCeJaw0xud1C5mT01A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1544.namprd11.prod.outlook.com (2603:10b6:910:d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Wed, 17 Mar
 2021 11:50:44 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 11:50:44 +0000
Subject: Re: [PATCH] drm: xlnx: call pm_runtime_get_sync before setting pixel
 clock
To:     Rohit Visavalia <RVISAVAL@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hyun Kwon <hyunk@xlnx.xilinx.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210310045945.3034364-1-quanyang.wang@windriver.com>
 <YFEV1ehZfivgBoKn@pendragon.ideasonboard.com>
 <ef4532f0-59a1-4436-b3b4-07b3b812e4b1@windriver.com>
 <72a24e1f-8708-7f87-b1b5-a2b171bf4576@xilinx.com>
 <DM6PR02MB666647B8BF6F1AABFA744383B36A9@DM6PR02MB6666.namprd02.prod.outlook.com>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <31f7b1fb-6bb9-4ae5-9a9a-c1a7c094a6fd@windriver.com>
Date:   Wed, 17 Mar 2021 19:50:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <DM6PR02MB666647B8BF6F1AABFA744383B36A9@DM6PR02MB6666.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by BYAPR05CA0046.namprd05.prod.outlook.com (2603:10b6:a03:74::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend Transport; Wed, 17 Mar 2021 11:50:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8321192-b1c1-4176-41bb-08d8e93ae453
X-MS-TrafficTypeDiagnostic: CY4PR11MB1544:
X-Microsoft-Antispam-PRVS: <CY4PR11MB1544B25AC64A0E2D08F2DEBFF06A9@CY4PR11MB1544.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hda9ibmdSjcLSo+oh+KzoJpTrjcO9Muklx7jcuEvMKeYfnfxhAcOQDnjpeufUGC/lyNJqYemSnr/A+wnpr7yUpxqt17/Q5UKDqStV/7NMh+CHZ5x44C2L90K7M7LgAx5h9QxBGPVk37F/0TXEeySUil3QvpJInvSySk+SgW8j5luGLaAbx8jTzwlIQicDwjqo9wKkIg7Jge1bvePkZd3huEy1Q6MQJ+vYMCKUoVhohUFzYniSzTCWPihV7y8Bvm2S3XufRFIIsy29K0169bf3sfCDCY7BfaH6jp6Z/sAoutefwas1nuvqNwmKK2ZGHA/puDp+YL0ewJkOnbkkloE377LQWc3LVO2yNpCvWUm0e2eGpAPyqQf+EhH231bxwRgoE6Bd8OenvIvuwx6Iu0ieNErH7YEjduN6mPBNQM+TgkSYqlx4vxXLD9GEes46sqbGf/eqDl2lIGqJlEgriLLN2EHXz/OW9LGop2Nucm1ARm8rRjVk6VBJVl2zzZ9fh9YHtOwqcNXDfFSN9hh1Db/yOk6EJcJeSNAqJqkd8RsmbTpGnyiM2eYi/FFox2mG1fFF0lVSXOVkMDIoE6abAHeNaMNeusoq57NbppDBT+h5WUCGarWz8PfMRh6AXPWO2FGt5hiOSekLEXveYsxLMZJ4Bo1GgSElHjzOubv2FOxGs0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(39850400004)(136003)(110136005)(6666004)(16526019)(36756003)(83380400001)(8936002)(4326008)(5660300002)(30864003)(31686004)(45080400002)(478600001)(86362001)(186003)(2906002)(8676002)(956004)(16576012)(2616005)(66556008)(66946007)(54906003)(6706004)(26005)(31696002)(6486002)(316002)(53546011)(52116002)(66476007)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NmppNGllZmZxdlBWUHprcjhHMGNOQ0pmQ3NZaVRBVG1HVE9nc0dHbFRBVk9E?=
 =?utf-8?B?TWZoNnZ2c2NwQnZiTFNrb1AvRVI2Yy9GeThEVDBpZGtlK0lENkVLN3FCcWxG?=
 =?utf-8?B?a3FwMnBaRC9MVWRwYTRvWGhIRENiaGhpdVhGYjZpbWYvQTNKTmVHZE4rNFBS?=
 =?utf-8?B?Tk85U1Y0U2VCek9mb1BGYXdNMEFSSUh1N1R4UWFKcFd0QlBRT1pYQnFzOHBk?=
 =?utf-8?B?cVpLZ0JqK0tocld2bVd1ZWk4VU5HdHRyR3BmczBKeGlyR2xHak5NNUhuTFFL?=
 =?utf-8?B?SWJiTnhQMHAwN1I2K1hCS2ZnWkswSGlYZU9La0NqejB3RmZPd1NIR0FabnNS?=
 =?utf-8?B?TGd5S0J2eUxXaGNQTUl5SXp3bkJoZEFCTmlaeHJBYVUxTU01RitZRHRPSThR?=
 =?utf-8?B?NzZwSDZOc2pkeFh1NlpIQWI1TnhWZVNHWFNubFZkblFHUWU2cXBzYWJ3eXBx?=
 =?utf-8?B?LzUwSzViUGVWZ0JGZFp0OW1naDVUcFBvbzU3b0tERXZmUStzMmxSelpuWlZI?=
 =?utf-8?B?OXZOaWlYUUN2WnE2Z204TU1sbkVEUjZLQU1mWTlhcnZIZ3ZXUEtINE1rbUY0?=
 =?utf-8?B?RHNFTTVwR3VBTE5McFFScWVKMEQ4RjlidUtKb3hNcTZaWFcwZHVYRVVJd3k5?=
 =?utf-8?B?QzJNM3JqS2VreUgwN09QNVRVZXhLZCtJcXU0RENrK1dUaXZ6cGwwVFFQQkRZ?=
 =?utf-8?B?Z1RxTEZ0ZFMxalNRK1BibDNiRWNpUzVKY2xkUTlWZDhGamNxUGJsMGFRb2U3?=
 =?utf-8?B?dUxyVi9ucndZSTN0VU9uZitQaXVpa3dmMHY4Q3BzcUtsNDJnbUtQbjJQUGZH?=
 =?utf-8?B?WGUrVmh0bkFVY1MyUXM1UE41bzlRZjgxN0w4VEw1TDk1c0Ivcmh5dVYxNjlp?=
 =?utf-8?B?bXB1aE9CK1l5Q1JuRWhlQ2VRK3pzTHV6eHBUQWFwblNyNzNzTW5acTV6R3hj?=
 =?utf-8?B?ejBSY2hxLzZwa0w2SjQzY0JKZitoaXdsWm03ZGZmd3Rmald1OWhwVUtJbzdV?=
 =?utf-8?B?cDlxUGF2dlYyWk81djg5WEZiNEp6anQxbytSa0ZKdWlQY2tMU2RXTmpiWGRl?=
 =?utf-8?B?NnZFRkV4MERodEUrcEtqdEg1djFRbHo0U1FibERtZW9MSnRRL3JhelB5cW41?=
 =?utf-8?B?NXBmVUx2UzhVVENyeU13aC9xNldpZDVRcW04T3o1bFpwMXZWM0s2cDhsUzBR?=
 =?utf-8?B?aSsvbk5BYSt1UEt3OU96WDRFanZkS1RheTdCNzZyYlplRXdrbEt4RmlvM2Qw?=
 =?utf-8?B?MnpVUTdpa3BQYkRGTXpOZTNTR0JJOXZHTmtXUEdzbGFrbUpzZmt6cUVyTnlX?=
 =?utf-8?B?RTEvZTMrd0J1QzJiTTlieU11SDhDellvSkM1MGc2cVZzaGNKSmVBRVpPdzhD?=
 =?utf-8?B?Z0NrZTdpUUE1NWRaWEdKOFFUc1JBZnE5WUdtS0RCM0VBMHdvQlVlUjhkbjY2?=
 =?utf-8?B?cE8vWEUreHVSOHlZVkJRQ0ZReDBQUndBcVVkVXNzSTI4UWtxdlJwYWVLYlRj?=
 =?utf-8?B?U012Z1NBdEpYck9oQmh2dW1FNkFVN01kbWtQVXR1VVdCdkhWYlJneWxGcTNj?=
 =?utf-8?B?S3hJemkyb0pTRXk0T3dXQWhtbDVGWWxmSzRPN2t3M3ZUOXJ1T0lqNnE5aldP?=
 =?utf-8?B?ZHczYjJEK0k0WEs1QkJuRjRNZ0w1YW16a2lOQmR3YndLdUtkMk9MTDlOME8z?=
 =?utf-8?B?dWVIZUZCaUpsOVdTdWY5OG1BZFNiTjQ2aWdHY3Y4QkpBU1V6SVFTcTRjMGMw?=
 =?utf-8?Q?/p7ElcTATeZ2EY7ngwM03GzIWCtvc3+dkEftaD8?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8321192-b1c1-4176-41bb-08d8e93ae453
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 11:50:44.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/KhDZMWFCb742a6+Aa8AlfeSqffEzkBijHVvUjQdEPCEfzlp7HIgBNc75nXQCLD3VoipQ9znef5T9WCwckmY/d5kl+ks6ND8bUNVMc8D+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1544
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rohit,

On 3/17/21 7:17 PM, Rohit Visavalia wrote:
> Hi Quanyang & Laurent,
>
> I tested this patch(which moves pm_runtime_get_sync at the very beginning of the function zynqmp_disp_crtc_atomic_enable), i don't see any behavior change with patch, means with patch also DP display is not getting up and it is required to resolution change to make it up.
> Also valid bit is not getting set for VPLL_FRAC_CFG on bootup, same behavior as without patch.

Thank you for your test.

This patch works under the condition of applying the below patch (drm: 
xlnx: set PLL_MODE_FRAC mode to VPLL_FRAC_CFG by re-enabling disp->pclk) 
(Patch 1) first.

Without Patch 1, the VPLL mode isn't set correctly and 
clk_prepare_enable don't take effect. DP monitor can't receive

any signal since the clk is wrong.

After applying Patch 1, there will be error log in the boot message:

[    1.325602] zynqmp_pll_enable() clock enable failed for vpll_int, ret 
= -22
[    1.325614] zynqmp-dpsub fd4a0000.display: failed to enable a pixel clock
[    1.456106] ------------[ cut here ]------------
[    1.456109] [CRTC:33:crtc-0] vblank wait timed out
[    1.456152] WARNING: CPU: 2 PID: 75 at 
drivers/gpu/drm/drm_atomic_helper.c:1512 
drm_atomic_helper_wait_for_vblanks.part.0+0x27c/0x298
[    1.456172] Modules linked in:
[    1.456181] CPU: 2 PID: 75 Comm: kworker/2:1 Not tainted 
5.12.0-rc2-00338-gf78d76e72a46-dirty #4
[    1.456188] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
[    1.456194] Workqueue: events deferred_probe_work_func

Then applying this patch ( drm: xlnx: call pm_runtime_get_sync before 
setting pixel clock), this issue  will be fixed, DP monitor

will receive signal, but screen is still black. Then applying the below 
patch (drm: xlnx: configure alpha value to make graphic layer opaque) 
(Patch 2),

the DP will work well.

Thanks,

Quanyang

>
> Thanks,
> Rohit
>
>> -----Original Message-----
>> From: Michal Simek <michal.simek@xilinx.com>
>> Sent: Wednesday, March 17, 2021 1:56 PM
>> To: quanyang.wang <quanyang.wang@windriver.com>; Laurent Pinchart
>> <laurent.pinchart@ideasonboard.com>; Rohit Visavalia
>> <RVISAVAL@xilinx.com>
>> Cc: Hyun Kwon <hyunk@xlnx.xilinx.com>; David Airlie <airlied@linux.ie>;
>> Daniel Vetter <daniel@ffwll.ch>; Michal Simek <michals@xilinx.com>; dri-
>> devel@lists.freedesktop.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH] drm: xlnx: call pm_runtime_get_sync before setting pixel
>> clock
>>
>> +Rohit
>>
>> On 3/17/21 4:00 AM, quanyang.wang wrote:
>>> Hi Laurent,
>>>
>>> On 3/17/21 4:32 AM, Laurent Pinchart wrote:
>>>> Hi Quanyang,
>>>>
>>>> Thank you for the patch.
>>>>
>>>> On Wed, Mar 10, 2021 at 12:59:45PM +0800,
>> quanyang.wang@windriver.com
>>>> wrote:
>>>>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>>>>
>>>>> The Runtime PM subsystem will force the device "fd4a0000.zynqmp-
>> display"
>>>>> to enter suspend state while booting if the following conditions are
>>>>> met:
>>>>> - the usage counter is zero (pm_runtime_get_sync hasn't been called
>>>>> yet)
>>>>> - no 'active' children (no zynqmp-dp-snd-xx node under dpsub node)
>>>>> - no other device in the same power domain (dpdma node has no
>>>>>          "power-domains = <&zynqmp_firmware PD_DP>" property)
>>>>>
>>>>> So there is a scenario as below:
>>>>> 1) DP device enters suspend state   <- call zynqmp_gpd_power_off
>>>>> 2) zynqmp_disp_crtc_setup_clock        <- configurate register
>>>>> VPLL_FRAC_CFG
>>>>> 3) pm_runtime_get_sync            <- call zynqmp_gpd_power_on and
>>>>> clear previous
>>>>>                         VPLL_FRAC_CFG configuration
>>>>> 4) clk_prepare_enable(disp->pclk)   <- enable failed since
>>>>> VPLL_FRAC_CFG
>>>>>                         configuration is corrupted
>>>>>
>>>>>   From above, we can see that pm_runtime_get_sync may clear register
>>>>> VPLL_FRAC_CFG configuration and result the failure of clk enabling.
>>>>> Putting pm_runtime_get_sync at the very beginning of the function
>>>>> zynqmp_disp_crtc_atomic_enable can resolve this issue.
>>>> Isn't this an issue in the firmware though, which shouldn't clear the
>>>> previous VPLLF_FRAC_CFG ?
>>> Thank you for your review.  I used to look into the atf and PWU code
>>> and it seems (I didn't add debug code
>>>
>>> to PMU to make sure if PMU really does this, I only in kernel call
>>> zynqmp_pm_get_pll_frac_data to make sure that
>>>
>>> the value in data field of VPLL_FRAC_CFG register is changed from
>>> 0x4000 to 0x0 after run pm_runtime_get_sync)
>>>
>>> that PMU intends to reset VPLL when there is an  Off and On in DP
>>> Powerdomain.
>>>
>>>
>>> Linux ATF                                 PWU
>>>
>>> zynqmp_gpd_power_on
>>> ->zynqmp_pm_set_requirement
>>> -->send PM_SET_REQUIREMENT to ATF  ==>        ATF send ipi to PWU
>>> ==>   PmSetRequirement
>>>                                      ->PmRequirementUpdate
>>>                                      -->PmUpdateSlave(masterReq->slave)
>>>                                      --->PmSlaveChangeState
>>>                                       ---->PmSlaveChangeState
>>>                                       ----->PmSlaveClearAfterState
>>>                                       ------>PmClockRelease
>>>
>>> ------->PmClockReleaseInt(&ch->clock->base)
>>>                                       -------->clk->class->release(clk)
>>>                                       --------->PmPllBypassAndReset
>>> //Here reset the VPLL then VPLL_FRAC_CFG is cleared.
>>>
>>>>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>>>> Nonetheless, this change looks good to me, I actually had the same
>>>> patch in my tree while investigation issues related to the clock
>>>> rate, so
>>>>
>>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>>
>>>> I was hoping it would solve the issue I'm experiencing with the DP
>>>> clock, but that's not the case :-( In a nutshell, when the DP is
>>>> first started, the clock frequency is incorrect. The following quick
>>>> & dirty patch fixes the problem:
>>>>
>>>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>>> b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>>> index 74ac0a064eb5..fdbe1b0640aa 100644
>>>> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>>> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>>> @@ -1439,6 +1439,10 @@ zynqmp_disp_crtc_atomic_enable(struct
>> drm_crtc
>>>> *crtc,
>>>>
>>>>        pm_runtime_get_sync(disp->dev);
>>>>
>>>> +    ret = clk_prepare_enable(disp->pclk);
>>>> +    if (!ret)
>>>> +        clk_disable_unprepare(disp->pclk);
>>>> +
>>>>        zynqmp_disp_crtc_setup_clock(crtc, adjusted_mode);
>>>>
>>>>        ret = clk_prepare_enable(disp->pclk);
>>>>
>>>> The problem doesn't seem to be in the kernel, but on the TF-A or PMU
>>>> firmware side. Have you experienced this by any chance ?
>>> Yes,  I bumped into the same issue and I used to make a patch (Patch
>>> 1) as below.
>>>
>>> I didn't send it to mainline because it seems not to be a driver issue.
>>> The mode of VPLL
>>>
>>> is not set correctly because:
>>>
>>> 1) VPLL is enabled before linux
>>>
>>> 2) linux calling pm_clock_set_pll_mode can't really set register
>>> because in ATF
>>>
>>> it only store the mode value to a structure and wait a clk-enable
>>> request to do
>>>
>>> the register-set operation.
>>>
>>> 3) linux call clk_enable will not send a clk-enable request since it
>>> checks that
>>>
>>> the VPLL is already hardware-enabled because of 1).
>>>
>>> So the firmware should disable VPLL when it exits and also in linux
>>> zynqmp clk driver
>>>
>>> there should be a check list to reset some clks to a predefined state.
>>>
>>>
>>> By the way, there is a tiny patch (Patch 2) to fix the black screen
>>> issue in DP. I think you may
>>>
>>> be preparing a big patch which add drm properties to this driver and
>>> it may contain this modification,
>>>
>>> so I didn't send it.
>>>
>>>
>>> Thanks,
>>>
>>> Quanyang
>>>
>>> Patch 1:
>>>
>>>  From 93311de2c61e87f2426b89259d81cded71aee673 Mon Sep 17 00:00:00
>> 2001
>>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>> Date: Thu, 3 Dec 2020 19:19:50 +0800
>>> Subject: [PATCH 1/3] drm: xlnx: set PLL_MODE_FRAC mode to
>>> VPLL_FRAC_CFG by
>>>   re-enabling disp->pclk
>>>
>>> When the function clk_set_rate configures the rate of disp->pclk,
>>> zynqmp_pm_set_pll_frac_mode will be called to set VPLL's mode to be
>>> PLL_MODE_FRAC or PLL_MODE_INT by invoking an SMC call to ATF.
>>> But in ATF, the service pm_clock_set_pll_mode doesn't really set the
>>> VPLL_FRAC_CFG register but only stores the mode value to struct pm_pll
>>> *pll. The operation that sets the register must be triggered by
>>> zynqmp_pm_clock_enable.
>>>
>>> Since disp->pclk is enabled in hardware before linux booting,
>>> clk_prepare_enable will skip over zynqmp_pm_clock_enable. So we have
>>> to enable then disable disp->pclk, and re-enable it to make sure that
>>> zynqmp_pm_clock_enable is triggered and the mode is set to
>>> VPLL_FRAC_CFG. Or else VPLL will work in an incorrect mode.
>>>
>>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>>> ---
>>>   drivers/gpu/drm/xlnx/zynqmp_disp.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>> b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>> index 98bd48f13fd1..19753ffc424e 100644
>>> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>> @@ -1668,6 +1668,11 @@ int zynqmp_disp_probe(struct zynqmp_dpsub
>>> *dpsub, struct drm_device *drm)
>>>              dev_err(disp->dev, "failed to init any video clock\n");
>>>              return PTR_ERR(disp->pclk);
>>>          }
>>> +
>>> +       /* Make sure that disp->pclk is disabled in hardware */
>>> +       ret = clk_prepare_enable(disp->pclk);
>>> +       clk_disable_unprepare(disp->pclk);
>>> +
>>>          disp->pclk_from_ps = true;
>>>      }
>>>
>>> Patch 2:
>>>
>>>  From 8c6d36bcb4e79e0e5f8e157446cd994b4a2126f0 Mon Sep 17 00:00:00
>> 2001
>>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>> Date: Thu, 3 Dec 2020 19:32:56 +0800
>>> Subject: [PATCH 2/3] drm: xlnx: configure alpha value to make graphic
>>> layer
>>>   opaque
>>>
>>> Since graphics layer is primary, and video layer is overaly, we need
>>> to configure the V_BLEND_SET_GLOBAL_ALPHA_REG register to make graphic
>>> layer opaque by default, or else graphic layer will be transparent and
>>> invisible.
>>>
>>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>>> ---
>>>   drivers/gpu/drm/xlnx/zynqmp_disp.c      | 3 ++-
>>>   drivers/gpu/drm/xlnx/zynqmp_disp_regs.h | 1 +
>>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>> b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>> index 19753ffc424e..5c84589e1899 100644
>>> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>> @@ -1468,7 +1468,8 @@ zynqmp_disp_crtc_atomic_enable(struct drm_crtc
>>> *crtc,
>>>      zynqmp_disp_blend_set_output_format(&disp->blend,
>>>                          ZYNQMP_DPSUB_FORMAT_RGB);
>>>      zynqmp_disp_blend_set_bg_color(&disp->blend, 0, 0, 0);
>>> -   zynqmp_disp_blend_set_global_alpha(&disp->blend, false, 0);
>>> +   zynqmp_disp_blend_set_global_alpha(&disp->blend, true,
>>> +                  ZYNQMP_DISP_V_BLEND_SET_GLOBAL_ALPHA_MAX);
>>>
>>>      zynqmp_disp_enable(disp);
>>>
>>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
>>> b/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
>>> index f92a006d5070..ef409aca11ad 100644
>>> --- a/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
>>> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
>>> @@ -22,6 +22,7 @@
>>>   #define ZYNQMP_DISP_V_BLEND_SET_GLOBAL_ALPHA       0xc
>>>   #define ZYNQMP_DISP_V_BLEND_SET_GLOBAL_ALPHA_VALUE(n)  ((n) << 1)
>>>   #define ZYNQMP_DISP_V_BLEND_SET_GLOBAL_ALPHA_EN        BIT(0)
>>> +#define ZYNQMP_DISP_V_BLEND_SET_GLOBAL_ALPHA_MAX   0xff
>>>   #define ZYNQMP_DISP_V_BLEND_OUTPUT_VID_FMT     0x14
>>>   #define ZYNQMP_DISP_V_BLEND_OUTPUT_VID_FMT_RGB     0x0
>>>   #define ZYNQMP_DISP_V_BLEND_OUTPUT_VID_FMT_YCBCR444    0x1
>>>
>>>>> ---
>>>>>    drivers/gpu/drm/xlnx/zynqmp_disp.c | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>>>> b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>>>> index 148add0ca1d6..909e6c265406 100644
>>>>> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>>>> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>>>> @@ -1445,9 +1445,10 @@ zynqmp_disp_crtc_atomic_enable(struct
>>>>> drm_crtc *crtc,
>>>>>        struct drm_display_mode *adjusted_mode =
>>>>> &crtc->state->adjusted_mode;
>>>>>        int ret, vrefresh;
>>>>>    +    pm_runtime_get_sync(disp->dev);
>>>>> +
>>>>>        zynqmp_disp_crtc_setup_clock(crtc, adjusted_mode);
>>>>>    -    pm_runtime_get_sync(disp->dev);
>>>>>        ret = clk_prepare_enable(disp->pclk);
>>>>>        if (ret) {
>>>>>            dev_err(disp->dev, "failed to enable a pixel clock\n");
