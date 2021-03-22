Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4215C3440D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhCVMWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:22:34 -0400
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:45888
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230092AbhCVMWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:22:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4Qx1JzHKbLwwFxYSVgObiyVanH9jdkcx4seX9O6XP0sXN0smsws16PidXOdiKyD5Rr737KvalkDdTcEjw++Ie1O050iMBnQKZ3M9mfBPEyux3X7Vv3DPJFm84jUcDx5PCPwwhD6xHwjeE6iCYT3wE2Ifh6tDomEWenW2yeyL502xwSmO7UQQiOn7exmHb4eMYx4dDFjnJvvGZUIS7Jb5yGyn263fFbZeVCzh2P1FQ9xH/dUYF+85SeNaSEpHUQ6yhadhnbd5D7v8Wy+zZb7KC7P+blqjWdyV7pVisiXJ7Uy270USzlRVtIaF9niHI93yc0hG4af2pMrtT7m8GKDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cs6YaAznghO758glJgN9Dd2nm3fj86K3A2DgiyaQ9IU=;
 b=kSFpchY501USFw0HZ7FMr7Z7x8Nbc4joJz4smBK15XQC+N048NJ8dzrtwPaVoo1n4lVQdJJnemIg02XNy7qpUp8tlawd5Kuba16JzMYArPF6CTI5VDbvd3F9OWJKQX86AM/a8T9z84R6RZ8vVNr6amDmYlhWKzwQBqnUO6u+TZRe4pLYlxucU+ldiqYpb1xGIgf8D0FTepu5vLAD3i2AWaerZwDysZxQh66gKi+xkaAfTvv5OVauibMD0v81AQ8Z+mUpOI3sO5gh29OZEOFNaCCVeE8ixCwaaXmwpfQrpAJxuSblbemFOHeVy3UMaDCrO6K5turCPlU+vHk4ReQ+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cs6YaAznghO758glJgN9Dd2nm3fj86K3A2DgiyaQ9IU=;
 b=IE8Ba5X0JnVbomLdmQ48/Wd/peMIt6xKXjv6SVc6uYs8f3CtXh+rO56mPA3rf0ZmTS+pCX3riQ2HVFP2mMo7btoyncT11FUMfTzMuiSNo6ojLcIgJ3K5r/ATrLAz2jjxLMhyTKJSyUFacxOC1ZJ7Yz0hvANLT9294R3h5thHT7Q=
Authentication-Results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1349.namprd11.prod.outlook.com (2603:10b6:903:30::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 12:22:08 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 12:22:08 +0000
Subject: Re: [PATCH 1/2] clk: zynqmp: pll: add set_pll_mode to check condition
 in zynqmp_pll_enable
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rohit Visavalia <RVISAVAL@xilinx.com>
References: <20210319100717.507500-1-quanyang.wang@windriver.com>
 <YFaM1uCqM+c1ZOoX@pendragon.ideasonboard.com>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <73ffa8ce-8ae1-9438-b808-4f9c98b28103@windriver.com>
Date:   Mon, 22 Mar 2021 20:21:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YFaM1uCqM+c1ZOoX@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::22) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by SJ0PR03CA0227.namprd03.prod.outlook.com (2603:10b6:a03:39f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 12:22:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 553ad846-b0e3-41a6-88a0-08d8ed2d1c84
X-MS-TrafficTypeDiagnostic: CY4PR11MB1349:
X-Microsoft-Antispam-PRVS: <CY4PR11MB134991CCDDAF44E57E07AC0EF0659@CY4PR11MB1349.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kSfWEqppKZdMZD+0yRKJnzUS5MWwM8gLOHh8B9NRwk0/l5PkJYt41W8wfsmypafuxW4cC0k2e6+qN7NXzgW0VYMzYbQhIZDyPZbohzJ287W6ksZX/5dDOV8Iij2L0h2lAqM8vCe24gk+nn2RXDFUeD6HcRpkSYt4upTMDR6NIF1oThO6rFTD9FrTf0N+hstTjQmcgtOav3RY50F996yBjOZrBIHMqgH0gWvpGLtF9HLorWpM8Kf/MHPWxKME+bnOIynDIsMtAxtT+hSqU4IwMBjq2yRIY1yK7GBgefOrFubiLeGOSXcrfq3ElCjv0zj6tapEPZUzIpVseUirvPf6jKzgVgzeftripExQHU4mgiMafPJ2UqR/Ntq6h+woUpnWH3A4bD1MD1WiekV35TVl59y0Gexsa8szb3sUI725EXLOh/y1TWroIdiV9d3Qwn64fozbTkSQsNVXok+5ao/jaa/B8RUnW3cUdteSO/flsUJxkX17MXBz+i/GdC472FD2WpWS9YXpLtc9wdIMsE+lZljBHzHQTqgNL9lgDrkhkbbb92povu2C/81t7ILa7YhnIHhg271RfnDn2ufJwOEJu2eS2irLBbFo6rFtisEl870pD+ktgn2/Ohs6Z+YqWQtjUepy7dJt/PhM9q+tOu8uRy5AYgOgx4AOXm4XjiAsRnFAZIeflwOJw1fEkFa1kuk8FoswtHqeI0aJw2w4RMeszynQXbMaJzYdyEBiqWuTi19kvYBeI0pM30fsbuL+XGMyTCJGFnHehME0RXQjIg37llqKFDNG6kgregiSRA96gUU4FmCQoXAyhaU7MlIn+N4D5Mu2dmKcLvN//P6iQ7GfaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(39840400004)(136003)(478600001)(6666004)(26005)(966005)(956004)(83380400001)(16576012)(66946007)(38100700001)(5660300002)(4326008)(6486002)(8676002)(53546011)(6706004)(6916009)(52116002)(86362001)(54906003)(66556008)(7416002)(66476007)(316002)(36756003)(8936002)(186003)(16526019)(2906002)(2616005)(31696002)(31686004)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bEYwcXA1NjZNcUFEN3NaZVQrR0ZsTmNzNU9pdGd2eFVXUmRvOEdIcXlQSThH?=
 =?utf-8?B?aDl1SjlGRzdJRFhGdnU1WmNLandsOVg2WlZkeGtVRUxxTk16bk5VOGNQbUs4?=
 =?utf-8?B?cDBhRFNUcFN5V3Q2SDJKbGRUa082NkxSTHVVcjJ5ajEzUGtsUE5odFI2UjF3?=
 =?utf-8?B?elFVd0gzSk1VbytwUFlzbEtIaXlyZUtoMXBFdldrUFFxRENqdzFFY1p5cnJG?=
 =?utf-8?B?MVNjSzR1OGIwMTlhRXE0NVY5SlJFeUppdUpiem51ditYeEQ5b1pWOGJtRXNE?=
 =?utf-8?B?NjlPZHNQTTk3Rlk2Mm1uRVNtbWt5WGpDaGx4Z011MzRETWxKOEE5U3gyRjZo?=
 =?utf-8?B?dlE0dW4xbVlibXByV2hPeTV6V2FMaEdLV0trbjd4MmRKWllJSDBHOENVaGI2?=
 =?utf-8?B?Y1c3eUVmZFBYM1ZXdUhBRWlPcFQ5VHZzN0c1VjdBZnl0SmV4aGxIazd0b0hS?=
 =?utf-8?B?aTc2RGVoKy9oMHF1bHVnU3JBMDQwS2ZkSWlQOUE1eEpiQUZ0NllPbXJjVzN5?=
 =?utf-8?B?RDdZWHVUR3c5N0tYM0FrK3lTeHpReE8vZm9VTFliS3BHRUd3ekNrZk9hSERD?=
 =?utf-8?B?bjVvbnNYNDdtOXVxaERNUnExcVpsSmJkT0pSR2hMN3RIN3FNT2Y4eE96d0xO?=
 =?utf-8?B?WHFkZ09EQXBobFZNaFdaV2VFYmE2clVJd0J6M21CdmU0eVNGTE90YmVZR0xo?=
 =?utf-8?B?ZllWTUtESEp0M3EvSGNmTjk2NjZQUlhTTCtOM1B3RXFUSWtQOFNXMmlSTjNh?=
 =?utf-8?B?aVY3eWZLUDUyeUxKSEJLK2s1aVh5dDJ3aGdUU1M5MW91eG9qU2tnWHcxRWg4?=
 =?utf-8?B?cDZ4MzJ5emg4UUU2S2I4N1ViRzM0cndOeW1EQmpEeFN0K2h1Mm1GbVpCUGRv?=
 =?utf-8?B?dWJkZDl6MGpXakpodUEwMUtqaW50SGRhN3pieGdjY1FaK0FQZzFTQnZpNXpl?=
 =?utf-8?B?bm1WQngyYVVDRWlTRVZjRFFld3IzYTJkNC9Md3FQMmRiYUxEa3RGdU1Pc1FE?=
 =?utf-8?B?YU1aTjQxMFNBZHNEOVZ5bjNWUFA2OU9SUGdsSjIybjFBYUk4ZjVYZEYveHlC?=
 =?utf-8?B?Ti8vM1kxMWpOK3pSVXBpNXBLWGpJNlpGQUJicmJGRDNFK3RwMXYycVhDcHhl?=
 =?utf-8?B?K3BtYWxtWnpTb0ErUWd2OTg4OHZmaUpKdklKK2F2VHk4Wk5nZ2VaQUVGeG9n?=
 =?utf-8?B?MWI4MEZycWxPbHE0dWJXM2tDd0VxWUpkNlRBY3RaZjRxMHpjL2h0Y2xlSGlR?=
 =?utf-8?B?NFVCTStMemZSVXZ0Vit5eFZ4Nkd0MzQyZzNyamJKTWpVS29nUGxoL0RRbVA1?=
 =?utf-8?B?cE0rZkFGam9ZWUhoV0VYODZMOUY0c0llYzlwQTZ3K3hQbE5HMEw4K04xcm5R?=
 =?utf-8?B?YmZ1YlR5Wm5CY3RabnRpemVWVVFIUmgvQm1NWG9SWVE1aUdGaFZHa3R0N2ln?=
 =?utf-8?B?WDEvalBOZndqYUtnbGdhZFBEUHNwTytkaktWQ2JuME9jU2F3bVRwcHE0OTZU?=
 =?utf-8?B?cmpBS3NQR1lBS09vMGhsTGV4MWJ5Qy9hYTYzVGVMRFp1WFR6bktVMHpiOUEr?=
 =?utf-8?B?REJCYURhMHJTZ3MxNzh1Vkl0M0Jxc0tqeGdLc1pUWC9CSU03ZmFMSUtBdG43?=
 =?utf-8?B?MWhLVFF5aEdxd3Z2V2dsMWRSNXMwZTFCZzNuRStEK0E4VmovQUNocVFDRDgw?=
 =?utf-8?B?Vi9PTkJTM3l2NDBiVTZzb1JYcWtjVVl4VzNNVFhoTFhTTEZLME9UNjZJZU1h?=
 =?utf-8?Q?cHFK2vz89K8YDHZ+ljh6fCopZzpDMG9dW9gGWq6?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553ad846-b0e3-41a6-88a0-08d8ed2d1c84
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 12:22:08.3232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjUCAn3eHTKmqizm3+MZA8gTRxxJpBR1W1g3zao0R6yNBf0e8yA4pMV4c1pwqEnOexzIHFbx3hqwMYuoypgASLF5J1AWJ//C6uP7nwztMMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1349
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 3/21/21 8:01 AM, Laurent Pinchart wrote:
> Hi Quanyang,
>
> Thank you for the patch.
>
> On Fri, Mar 19, 2021 at 06:07:17PM +0800, quanyang.wang@windriver.com wrote:
>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>
>> If there is a IOCTL_SET_PLL_FRAC_MODE request sent to ATF ever,
>> we shouldn't skip invoking PM_CLOCK_ENABLE fn even though this
>> pll has been enabled. In ATF implementation, it will only assign
>> the mode to the variable (struct pm_pll *)pll->mode when handling
>> IOCTL_SET_PLL_FRAC_MODE call. Invoking PM_CLOCK_ENABLE can force
>> ATF send request to PWU to set the pll mode to PLL's register.
>>
>> There is a scenario that happens in enabling VPLL_INT(clk_id:96):
>> 1) VPLL_INT has been enabled during booting.
>> 2) A driver calls clk_set_rate and according to the rate, the VPLL_INT
>>     should be set to FRAC mode. Then zynqmp_pll_set_mode is called
>>     to pass IOCTL_SET_PLL_FRAC_MODE to ATF. Note that at this point
>>     ATF just stores the mode to a variable.
>> 3) This driver calls clk_prepare_enable and zynqmp_pll_enable is
>>     called to try to enable VPLL_INT pll. Because of 1), the function
>>     zynqmp_pll_enable just returns without doing anything after checking
>>     that this pll has been enabled.
>>
>> In the scenario above, the pll mode of VPLL_INT will never be set
>> successfully. So adding set_pll_mode to chec condition to fix it.
> s/chec/check/
Thanks for pointing it out. Will fix it in the next version.
>
>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>> ---
>>   drivers/clk/zynqmp/pll.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
>> index 92f449ed38e5..f1e8f37d7f52 100644
>> --- a/drivers/clk/zynqmp/pll.c
>> +++ b/drivers/clk/zynqmp/pll.c
>> @@ -14,10 +14,12 @@
>>    * struct zynqmp_pll - PLL clock
>>    * @hw:		Handle between common and hardware-specific interfaces
>>    * @clk_id:	PLL clock ID
>> + * @set_pll_mode:	Whether an IOCTL_SET_PLL_FRAC_MODE request be sent to ATF
>>    */
>>   struct zynqmp_pll {
>>   	struct clk_hw hw;
>>   	u32 clk_id;
>> +	bool set_pll_mode;
>>   };
>>   
>>   #define to_zynqmp_pll(_hw)	container_of(_hw, struct zynqmp_pll, hw)
>> @@ -81,6 +83,8 @@ static inline void zynqmp_pll_set_mode(struct clk_hw *hw, bool on)
>>   	if (ret)
>>   		pr_warn_once("%s() PLL set frac mode failed for %s, ret = %d\n",
>>   			     __func__, clk_name, ret);
>> +	else
>> +		clk->set_pll_mode = true;
>>   }
>>   
>>   /**
>> @@ -240,9 +244,14 @@ static int zynqmp_pll_enable(struct clk_hw *hw)
>>   	u32 clk_id = clk->clk_id;
>>   	int ret;
>>   
>> -	if (zynqmp_pll_is_enabled(hw))
>> +	/* Don't skip enabling clock if there is an IOCTL_SET_PLL_FRAC_MODE request
>> +	 * that has been sent to ATF.
>> +	 */
> Very small issue, multiline kerneldoc comments are supposed to start
> with a '/*' on its own line:
>
> 	/*
> 	 * Don't skip enabling clock if there is an IOCTL_SET_PLL_FRAC_MODE
> 	 * request that has been sent to ATF.
> 	 */
OK. Will fix it in the next version.
>> +	if (zynqmp_pll_is_enabled(hw) && (!clk->set_pll_mode))
>>   		return 0;
>>   
>> +	clk->set_pll_mode = false;
>> +
>>   	ret = zynqmp_pm_clock_enable(clk_id);
>>   	if (ret)
>>   		pr_warn_once("%s() clock enable failed for %s, ret = %d\n",
> This fixes the DPSUB clock issue, so
>
> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> I however wonder if this is the best solution. Shouldn't we instead fix
> it on the ATF side, to program the hardware when zynqmp_pll_set_mode()
> is called if the clock is already enabled ?

I found the commit message which records the reason of this change. And 
in this commit,

it shows that the code is changing from programming the hardware to 
buffering the mode.


https://github.com/Xilinx/arm-trusted-firmware.git

commit 8975f317e7608c832192b71531901602dc625484
Author: Jolly Shah <jollys@xilinx.com>
Date:   Wed Jan 2 12:46:46 2019 -0800

     zynqmp: pm: Buffer the PLL mode that is set using IOCTL API

     When linux calls pm_ioctl_set_pll_frac_mode() it doesn't expect the
     fractional mode to be changed in hardware. Furthermore, even before 
this
     patch setting the mode which is done by writing into register takes
     no effect until the PLL reset is deasserted, i.e. until linux "enables"
     the PLL. To adjust the code to system-level PLL EEMI API and avoid
     unnecessary IPIs that would otherwise be issued, we buffer the mode
     value set via IOCTL until the PLL mode really needs to be set.

>
> Just reading the code, I can immediately see another potential issue in
> zynqmp_pll_set_mode(). The function is called from
> zynqmp_pll_round_rate(), which seems completely wrong, as
> zynqmp_pll_round_rate() is supposed to only perform rate calculation,
> not program the hardware.

I agree.  Moving zynqmp_pll_set_mode out of zynqmp_pll_round_rate

and putting it in zynqmp_pll_set_rate may be better.

Thanks,

Quanyang

>   Am I missing something, or does the PLL
> implementation need to be reworked more extensively than this ?
