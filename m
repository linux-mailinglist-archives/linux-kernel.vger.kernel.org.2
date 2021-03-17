Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCE033E754
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhCQDBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:01:44 -0400
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com ([40.107.94.49]:46272
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229823AbhCQDBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeRzud6JjPDFmLwnG0cQVPQLDABBe5j/hlho4VG0hyLmeR5Kl3LYZsuHKCbwWGsiGs0kl/dLjC9ZZOK/OTeFQ7RynMPAg1OUZsfNNXUMaqxhz2obQmM03VC2j25Hy4eai84nBIwpdDD7XwbCS6DI698x81BNJxOgW2e3M9fyUVR4F7yjRORtThgPID2RR6Vx9Iw3vc+oAyzq6SMiA9hdG+cfk+Xcs8RrBoQr3RVuO4XDytD5FMyyJOjghhlQc4cmlUo/I7Ez9KIkshrt+OHJ5GCMMAIuH9hOwWHLMctjH/BsNMD5AU2nXRwdDahCSrKOotDaBNODe3Tcx3YEo9yuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHNlX6L8atSFOZqsC5RmfCMA6VVsD+k6okPnnGd5scc=;
 b=Vo7BTyyH56zBpwp5tT8iKauPoKbXWHj1PThwXV49fv+rYT+4nqTHf/na61kyGpdjSnKk1uS/XkJ1f8PHkTrBLF15wID+zJn4eIvp+tQi28RD3f58VmJD8mGF38EkpsgrNo825vAeigHNBXSX45HfRFfOJwlhcIXWGpJCwramiF/SsN3PFb9eP/YwwgRQwce7yX8ormC5ci3bQwn6MmLbKKbLuvbMDxdivqGrdzF7pSjysd9uKPQlq7B7tX9iGh8dCBAU0a+MGGJ8jNneeSKivtefQqD4TSXnO+q3QggsCpHIuXGkL6ghaQWSEEgNAqTWNNxZMS/rRiBulcj3PtKh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHNlX6L8atSFOZqsC5RmfCMA6VVsD+k6okPnnGd5scc=;
 b=FHBWerLnzoEyBjdsXpTQ42bdAjkeVF1iq4BmOwOnt+Jdp/3rUHaO2Wb8gvVs5DNBsOMYSv05J518mdh3eGEv3SvD5K3YfTK0V22V6bm5OlK/8mj+fKwaMnrDWL2oGC/zajJH4pKenq/rlHIYIAdItOfrcfE1aFEyQHCZurd49S0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2295.namprd11.prod.outlook.com (2603:10b6:910:19::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 03:01:21 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 03:01:21 +0000
Subject: Re: [PATCH] drm: xlnx: call pm_runtime_get_sync before setting pixel
 clock
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210310045945.3034364-1-quanyang.wang@windriver.com>
 <YFEV1ehZfivgBoKn@pendragon.ideasonboard.com>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <ef4532f0-59a1-4436-b3b4-07b3b812e4b1@windriver.com>
Date:   Wed, 17 Mar 2021 11:00:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YFEV1ehZfivgBoKn@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 03:01:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c449c7e-90d4-4b0c-46af-08d8e8f0efdd
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2295:
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2295F8B14649517CCA33635EF06A9@CY4PR1101MB2295.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRuCug2s7xdZd9r3YUKlQIm/jdqjbXKdeE3l0CPn+mfr3pk9f15P/2DCKShbT21E0rpIPNNgdH4FcuT0/E31phrh/S2YvjCVLAdqBlBM5jcFgUq/YFZ0UtVIhHL29vguJnrD+H/czBa8QH7ezSRCW9jfy+4Ql3/mcflcnAupHewKsI95NYLMenPFaMcM/SAtkNBBzeZUDyZ5OVJ/Kl1EZwNVHSDiUKXIkffTW6yFFLMxjtyEjmnI/zK9hRMbnhElhIDA3lszzzJogtFsbTXOKJA3zx1qxuJIsT3z5vL7q18XMZOVsT14yBamoqJK5aqeQOvzM2gEQMvKmjCxjYIA6OCYCHfpmZMeAoZ121bQmowmV9RBrB2hNlnRVpCRDK0KB6Z0JgCRgMr4MUL+NkL89LlHid3rs/z7DTd4RCg9fmFwZNmLADuuArg4mOVtiSt2QKCFlSSPwk3VRwGm70IFdat0vto+yKU4uCdZz9VO47oHj4nuq/QeuyHoDy0qeSxp0swOYsfsqc//GUGEXrEMWAK868J//W3edCuR4GLnEpY8HMuMRXbdM9zWKHFOhFuAWs2kfVGfoyWrBhlToTnk2rs9JNi/uU6YAuqfpkZ6uavh33i/KVT8zk+vfSMiAzLpXSgNLt45ADeCnMrfiL6lqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39850400004)(316002)(83380400001)(36756003)(6916009)(66476007)(53546011)(6706004)(16576012)(6486002)(86362001)(956004)(2616005)(6666004)(26005)(8936002)(52116002)(54906003)(2906002)(478600001)(4326008)(31686004)(5660300002)(66946007)(66556008)(8676002)(16526019)(31696002)(186003)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TkoybU83NHMrYzIvNmFGdFUwcnV1VCtVYzVUUjdZa0RUS25IYjVFazZpK0tu?=
 =?utf-8?B?OUNBOGs5N0dpeVdjRmJ1QWpLaWVyeHh5NmRaZFp5S0pPS05RL1R0YlpyU0xu?=
 =?utf-8?B?WFpzMTVSL1lmMS9iTktUZmljT0JkZ3A3SkRWWllYa3lQdUJoQXdUTXZFU2ZY?=
 =?utf-8?B?RGFBK282SVhTVVpiOHZveVk2eE8veE1SUEtBVm04ZXhVQnZuZVZuSURIaTJV?=
 =?utf-8?B?RSt5YitjRjhQOW01SHRFQ3puSDhBWW1rNDMvd3VpbE9ReDQ0bzAzUGI1T0x1?=
 =?utf-8?B?S0QxN2h0Wm5BZ3FqeXNudkRjTkdBWGtBZHdCRDBYWVI5VlV4NTROTTB1UVcv?=
 =?utf-8?B?emV3a2tBbjZDbnlXcFlkemNUejQ3VFJ6Vkw5UXFwUHU1UmU0UlplNEVzditZ?=
 =?utf-8?B?TjVYMncxODJnZkU3dUNaeXk1UlZ5RWU4SURTOWx6ZnY3ZjNSYmxOOU9ZVzhP?=
 =?utf-8?B?S3liM1hRVGVRditWTFJwLy8zbjZXNUlnRGI0TjE5WU5oRDNneFJXS3dzdTU5?=
 =?utf-8?B?bjFUN0g0dU9wYTNCQXA5MmFQWEhpRjJ4OFVtbWwyNDRFcVJYMmExa1ZTeWlK?=
 =?utf-8?B?Y3lKYk1UVW12enhpVk9MeWE1RTNXMzZnZ21XeThVMVNLSFhKUFJLMnQyc2ts?=
 =?utf-8?B?Zlg5Z0lUZkFzRDd1c1ZwTXJkOUIrYkgrWno5MFJFWnJ5dms4Slc2UTFiUmJl?=
 =?utf-8?B?KzljWEVsMmtYbXlwWVgrTzlzWFVRUHhmN1VjajMyU2c5bHovbGp5U3JqS1d0?=
 =?utf-8?B?cGhJczhyekpZbE01YTkwU05DR3FqTm9MdGs4YU5YUDk4Y0YrM1RvL2ZJcXM3?=
 =?utf-8?B?RkdmNkpWcXJEUldIcDhjaml0Smh6L0JGSDFGK2gzTncwM0FMSkhnRmo1bEg4?=
 =?utf-8?B?clNpazdEWmtJelBBYVJtVUpSM0R3VWtJcE5HbE5aZG9WVFV4clpIb2NadVk5?=
 =?utf-8?B?UE5sWWo2L285anB2OE5vbklkS3dxU1dzY1FyQzBmNEZvRk5ZTjFSTzV1WEF6?=
 =?utf-8?B?Z0R0OWZ1YlJ1aEdveXdXeGpXb3FxZkxBRkVoRDZDN1lnNW1xVTZuN1ZvdFdG?=
 =?utf-8?B?TzRXSDcydFN4bXB5c2syTDZSdDB2TFc2ZFpkbHpFL0ovZmk3cDB1a2V1d0lF?=
 =?utf-8?B?L1R5aWdqb2tLSUxnK1B5dUJaZ0hDRldQQUxGdmt1MjV1RHl4OUNmUS9xbXpQ?=
 =?utf-8?B?MkJEb2kreVQwYlhZcGEydlkySmk0NlJ3UnIxYlFpTDFTaTlUVDA5Mm5vT2FS?=
 =?utf-8?B?WEdhRlJseWthRmJiZmo4Z1U5cVQwZDlHdG9DSXptUEZnbkpGaWZyd2dsUjFK?=
 =?utf-8?B?V2RpUzNoNHVpK1RoeC9yOVU1RlJCZkFmMWRCbklBK1BVaGhZTWRsN1laWmU4?=
 =?utf-8?B?YnJHOE1rTWNocG5qVCtTcUZMT0pONUNIbjNCaTFoOWRyQ0VJaTJiVS9BQXRk?=
 =?utf-8?B?MHZFUnIvV2lOZnhFT3EwYW5mUGtXRFVCbnJpd1NsdVpGWTd4YlVzL2p3YklJ?=
 =?utf-8?B?TlNPWmlZRGtWRjNKZWhqWVMrUTNaNHBhQmg0d3dIU2N1b0wzMFhHdmtVYkRt?=
 =?utf-8?B?eERBd2ppdnF6dXp6QmNvTEpCeUJPUVp4QnBzMElTK21tY0ZMblRkMGJJTkEv?=
 =?utf-8?B?ay91UEpSTmNPdzlEeFMxMEVtUWc1U3o1YXowRVlIcjNvbGxQbW05WkZ0Vk1X?=
 =?utf-8?B?ZjlwUnNaTXpaVFFqOFZKNDRkRWV3bTVwNm15Zk14YjJ4OUthWEpxYW5GT3A3?=
 =?utf-8?Q?q9ELqMHYdL7GDljkHIgVnsOQb7lidvugOrf+yGU?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c449c7e-90d4-4b0c-46af-08d8e8f0efdd
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 03:01:21.4430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFlYe4SYV5m5HfSX7EveVKIvaU/wRPpHtavWoqG1mNbC42pItZIZs1At7hF2cMJyb21C3cBMB4AcGMTPuJWYawXkrGo/Wk2obMNpQOzyp9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2295
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 3/17/21 4:32 AM, Laurent Pinchart wrote:
> Hi Quanyang,
>
> Thank you for the patch.
>
> On Wed, Mar 10, 2021 at 12:59:45PM +0800, quanyang.wang@windriver.com wrote:
>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>
>> The Runtime PM subsystem will force the device "fd4a0000.zynqmp-display"
>> to enter suspend state while booting if the following conditions are met:
>> - the usage counter is zero (pm_runtime_get_sync hasn't been called yet)
>> - no 'active' children (no zynqmp-dp-snd-xx node under dpsub node)
>> - no other device in the same power domain (dpdma node has no
>> 		"power-domains = <&zynqmp_firmware PD_DP>" property)
>>
>> So there is a scenario as below:
>> 1) DP device enters suspend state   <- call zynqmp_gpd_power_off
>> 2) zynqmp_disp_crtc_setup_clock	    <- configurate register VPLL_FRAC_CFG
>> 3) pm_runtime_get_sync		    <- call zynqmp_gpd_power_on and clear previous
>> 				       VPLL_FRAC_CFG configuration
>> 4) clk_prepare_enable(disp->pclk)   <- enable failed since VPLL_FRAC_CFG
>> 				       configuration is corrupted
>>
>>  From above, we can see that pm_runtime_get_sync may clear register
>> VPLL_FRAC_CFG configuration and result the failure of clk enabling.
>> Putting pm_runtime_get_sync at the very beginning of the function
>> zynqmp_disp_crtc_atomic_enable can resolve this issue.
> Isn't this an issue in the firmware though, which shouldn't clear the
> previous VPLLF_FRAC_CFG ?

Thank you for your review.  I used to look into the atf and PWU code and 
it seems (I didn't add debug code

to PMU to make sure if PMU really does this, I only in kernel call 
zynqmp_pm_get_pll_frac_data to make sure that

the value in data field of VPLL_FRAC_CFG register is changed from 0x4000 
to 0x0 after run pm_runtime_get_sync)

that PMU intends to reset VPLL when there is an  Off and On in DP 
Powerdomain.


Linux ATF                                 PWU

zynqmp_gpd_power_on
->zynqmp_pm_set_requirement
-->send PM_SET_REQUIREMENT to ATF  ==>	    ATF send ipi to PWU   ==>   PmSetRequirement
									->PmRequirementUpdate
									-->PmUpdateSlave(masterReq->slave)
									--->PmSlaveChangeState
  									---->PmSlaveChangeState
  									----->PmSlaveClearAfterState
  									------>PmClockRelease
  									------->PmClockReleaseInt(&ch->clock->base)
  									-------->clk->class->release(clk)
  									--------->PmPllBypassAndReset //Here reset the VPLL then VPLL_FRAC_CFG is cleared.
    
   

>
>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> Nonetheless, this change looks good to me, I actually had the same patch
> in my tree while investigation issues related to the clock rate, so
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> I was hoping it would solve the issue I'm experiencing with the DP
> clock, but that's not the case :-( In a nutshell, when the DP is first
> started, the clock frequency is incorrect. The following quick & dirty
> patch fixes the problem:
>
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index 74ac0a064eb5..fdbe1b0640aa 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -1439,6 +1439,10 @@ zynqmp_disp_crtc_atomic_enable(struct drm_crtc *crtc,
>
>   	pm_runtime_get_sync(disp->dev);
>
> +	ret = clk_prepare_enable(disp->pclk);
> +	if (!ret)
> +		clk_disable_unprepare(disp->pclk);
> +
>   	zynqmp_disp_crtc_setup_clock(crtc, adjusted_mode);
>
>   	ret = clk_prepare_enable(disp->pclk);
>
> The problem doesn't seem to be in the kernel, but on the TF-A or PMU
> firmware side. Have you experienced this by any chance ?

Yes,  I bumped into the same issue and I used to make a patch (Patch 1) 
as below.

I didn't send it to mainline because it seems not to be a driver issue. 
The mode of VPLL

is not set correctly because:

1) VPLL is enabled before linux

2) linux calling pm_clock_set_pll_mode can't really set register because 
in ATF

it only store the mode value to a structure and wait a clk-enable 
request to do

the register-set operation.

3) linux call clk_enable will not send a clk-enable request since it 
checks that

the VPLL is already hardware-enabled because of 1).

So the firmware should disable VPLL when it exits and also in linux 
zynqmp clk driver

there should be a check list to reset some clks to a predefined state.


By the way, there is a tiny patch (Patch 2) to fix the black screen 
issue in DP. I think you may

be preparing a big patch which add drm properties to this driver and it 
may contain this modification,

so I didn't send it.


Thanks,

Quanyang

Patch 1:

 From 93311de2c61e87f2426b89259d81cded71aee673 Mon Sep 17 00:00:00 2001
From: Quanyang Wang <quanyang.wang@windriver.com>
Date: Thu, 3 Dec 2020 19:19:50 +0800
Subject: [PATCH 1/3] drm: xlnx: set PLL_MODE_FRAC mode to VPLL_FRAC_CFG by
  re-enabling disp->pclk

When the function clk_set_rate configures the rate of disp->pclk,
zynqmp_pm_set_pll_frac_mode will be called to set VPLL's mode to
be PLL_MODE_FRAC or PLL_MODE_INT by invoking an SMC call to ATF.
But in ATF, the service pm_clock_set_pll_mode doesn't really set
the VPLL_FRAC_CFG register but only stores the mode value to
struct pm_pll *pll. The operation that sets the register must be
triggered by zynqmp_pm_clock_enable.

Since disp->pclk is enabled in hardware before linux booting,
clk_prepare_enable will skip over zynqmp_pm_clock_enable. So
we have to enable then disable disp->pclk, and re-enable it to
make sure that zynqmp_pm_clock_enable is triggered and the mode is
set to VPLL_FRAC_CFG. Or else VPLL will work in an incorrect mode.

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
  drivers/gpu/drm/xlnx/zynqmp_disp.c | 5 +++++
  1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c 
b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 98bd48f13fd1..19753ffc424e 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -1668,6 +1668,11 @@ int zynqmp_disp_probe(struct zynqmp_dpsub *dpsub, 
struct drm_device *drm)
             dev_err(disp->dev, "failed to init any video clock\n");
             return PTR_ERR(disp->pclk);
         }
+
+       /* Make sure that disp->pclk is disabled in hardware */
+       ret = clk_prepare_enable(disp->pclk);
+       clk_disable_unprepare(disp->pclk);
+
         disp->pclk_from_ps = true;
     }

Patch 2:

 From 8c6d36bcb4e79e0e5f8e157446cd994b4a2126f0 Mon Sep 17 00:00:00 2001
From: Quanyang Wang <quanyang.wang@windriver.com>
Date: Thu, 3 Dec 2020 19:32:56 +0800
Subject: [PATCH 2/3] drm: xlnx: configure alpha value to make graphic layer
  opaque

Since graphics layer is primary, and video layer is overaly,
we need to configure the V_BLEND_SET_GLOBAL_ALPHA_REG register
to make graphic layer opaque by default, or else graphic layer
will be transparent and invisible.

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
  drivers/gpu/drm/xlnx/zynqmp_disp.c      | 3 ++-
  drivers/gpu/drm/xlnx/zynqmp_disp_regs.h | 1 +
  2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c 
b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 19753ffc424e..5c84589e1899 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -1468,7 +1468,8 @@ zynqmp_disp_crtc_atomic_enable(struct drm_crtc *crtc,
     zynqmp_disp_blend_set_output_format(&disp->blend,
                         ZYNQMP_DPSUB_FORMAT_RGB);
     zynqmp_disp_blend_set_bg_color(&disp->blend, 0, 0, 0);
-   zynqmp_disp_blend_set_global_alpha(&disp->blend, false, 0);
+   zynqmp_disp_blend_set_global_alpha(&disp->blend, true,
+                  ZYNQMP_DISP_V_BLEND_SET_GLOBAL_ALPHA_MAX);

     zynqmp_disp_enable(disp);

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h 
b/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
index f92a006d5070..ef409aca11ad 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
@@ -22,6 +22,7 @@
  #define ZYNQMP_DISP_V_BLEND_SET_GLOBAL_ALPHA       0xc
  #define ZYNQMP_DISP_V_BLEND_SET_GLOBAL_ALPHA_VALUE(n)  ((n) << 1)
  #define ZYNQMP_DISP_V_BLEND_SET_GLOBAL_ALPHA_EN        BIT(0)
+#define ZYNQMP_DISP_V_BLEND_SET_GLOBAL_ALPHA_MAX   0xff
  #define ZYNQMP_DISP_V_BLEND_OUTPUT_VID_FMT     0x14
  #define ZYNQMP_DISP_V_BLEND_OUTPUT_VID_FMT_RGB     0x0
  #define ZYNQMP_DISP_V_BLEND_OUTPUT_VID_FMT_YCBCR444    0x1

>> ---
>>   drivers/gpu/drm/xlnx/zynqmp_disp.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>> index 148add0ca1d6..909e6c265406 100644
>> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
>> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>> @@ -1445,9 +1445,10 @@ zynqmp_disp_crtc_atomic_enable(struct drm_crtc *crtc,
>>   	struct drm_display_mode *adjusted_mode = &crtc->state->adjusted_mode;
>>   	int ret, vrefresh;
>>   
>> +	pm_runtime_get_sync(disp->dev);
>> +
>>   	zynqmp_disp_crtc_setup_clock(crtc, adjusted_mode);
>>   
>> -	pm_runtime_get_sync(disp->dev);
>>   	ret = clk_prepare_enable(disp->pclk);
>>   	if (ret) {
>>   		dev_err(disp->dev, "failed to enable a pixel clock\n");
