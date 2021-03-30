Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D6334E762
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhC3MTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:19:13 -0400
Received: from mail-dm6nam12on2059.outbound.protection.outlook.com ([40.107.243.59]:35936
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231869AbhC3MTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:19:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpoH6Y9Ga6amBE/Pec6vawxrznUit3CaaRafRXsN/CIv7/h32dr1kNp8GsBtnO8XUu3ZDICBX6dX321wYDRXrySW2QZk3hGS/lFlz0XPbyAsP4W15ce1YrkilG3soMEy1haAdg6sc8BGs6NJX6YJ3IdhqExO9XBEC4zJG1MSdqwJLft/X20IxeFlqiN4u7zleSqjOJjvYXR8JDmHk3FUvQ9AwMm8y6r28i215XpQYBs2Y9kGDUNj1Tk0Y6FjSTVPwhFqDG0rHd55i6kYit9ZUHzf+I2jz7fQ4Rc0WCoTxJeBeukiKcLNl0W9kfaMo0yUo7wR2/y3hPE4hiUt3Tm9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpMM9TsUG4otRW87KjfipnjY0mkWiNQswmLxsJdT+NQ=;
 b=PGJ6tU+jdONIJs9wFSugnPTpcT6fyt1+lg2d+ki0+t3vzFVplVUppxrE9v32oVsUv45rw1/ylc3vcsPv73wTofhjnX8IfE+ceYXy3eZ3jEMqw5d0kEwdN3mD7+VOXWPcNmpMHk7OijF7xDpQCqnUeC5HoBaqLUlXTstpSHWigbbfqA+2YQfJEJtaNa+1xLm/4VGr1eQ8EznRCX2l5fCYNCMuEcDM92EKTa8WCDKLxopDN11TN9wvGtdvaOB4B4RZHLf6Ksr71lX86unZcnOsD11qKjENSDSFbce+BRlD51xl/vehCzNWZZo+ss2Pus6gKJAabDW5dHzObZLSQyNd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpMM9TsUG4otRW87KjfipnjY0mkWiNQswmLxsJdT+NQ=;
 b=CBt281svgkuf8wMBxEBzk+0G4znKMGHVlq+gJy3uMvldTwdRX8oLjS2srkAK18ghscYqJ8zdaU1EA+iiA/TM6H93oKTBMbJIacUljOfN+2tUCXpdooGc1TkQkfrjicYvZfQylHz2c6HzeuB/26/7Ca+LS5wlf16SFdvHkrRnoJw=
Authentication-Results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2341.namprd11.prod.outlook.com (2603:10b6:903:b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 12:19:07 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 12:19:07 +0000
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
Message-ID: <601d6a8f-f962-4b34-eb85-799b40a72e5c@windriver.com>
Date:   Tue, 30 Mar 2021 20:18:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YFaM1uCqM+c1ZOoX@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0023.apcprd03.prod.outlook.com
 (2603:1096:203:c9::10) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by HKAPR03CA0023.apcprd03.prod.outlook.com (2603:1096:203:c9::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.15 via Frontend Transport; Tue, 30 Mar 2021 12:19:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e73fd103-8ae3-47af-1559-08d8f37603f8
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2341:
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2341DABD6F8E540477617348F07D9@CY4PR1101MB2341.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAgR1vUj7rIQmUcNIsCtkqIP46SvRvcVf4JjsiJ7ZcqZWrCJIQg8FSov5NNEL5UgN1rjKmcNvbiZuDK995EaNDAIWmKludKYblzJU8W3IahzIgWnYWKQz8xW8KD1TcU2+ZkDf3OFUsYq4tikQfKY7IF8CiqhR0EbwOQKpVATHMMtk4VqoINkx3cOR+hCDnOjnL+t39TmNB5Dr4OJ70s/Ml386Nkz2cQDllzN9OQrNzSWj21KkvKIdTj9ephEbA0c6V/3R4U4Lus+XM9B0zNwIkTub3e0jIQzxYDBqLyjeqmP0hcaW963M7eUroa8j5qFRhvROFBffHiajQEwDxRTlmyx0Di5D4TL4elQ6WElIGEmlhwt3jj19BczBmNyQWwv4s0Y0ZFPGXDLIazf/2L7h91TWInt+XRSBUmX3VWYvLJGTmqs3X4KRiR+LL2QAteuJc45mYzJTLmMBDtVDY0rMMMPirHEaUmuyRbn4IZxbAbENRDx+MkF68fqIhpl0eRarRFd74+NhjF4DAJzUszeijDvSXeHDycc9YsoLg8EqZBcD0qpDUiU5+bHypjSYOLL7XNgNoTDLJas+ZuesZ22JPocs8chaW9vWcUOxFvHU0axY9cZioBbRsQx/Opwd/+8Ci5PYY24Jn5TX6COZ0W+TalPfo8hW0CzOVCfDHKStbEu42Pzyajd+KekgIGDGTumGWnmBBjtQymNp2myzN54A47BBZrVeNuf8t9M3P5vCkcIq6aRR3/LFImlzzK04OfY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(346002)(136003)(376002)(396003)(2906002)(186003)(31686004)(26005)(16526019)(36756003)(66946007)(4326008)(66476007)(8676002)(956004)(6486002)(38100700001)(31696002)(52116002)(8936002)(478600001)(6916009)(86362001)(5660300002)(2616005)(54906003)(53546011)(6706004)(316002)(16576012)(83380400001)(66556008)(7416002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YzBCQXZPbnZkcFZxanMyRnViY3hFWmNtekdHMFpsbXVlVkFta0dSUkszNnQ0?=
 =?utf-8?B?eDNNMEFDN2NlcFdtRzgzVXVHai9FTkFQeU5wOW9obEVPbTF2dHBGeEhpZGFM?=
 =?utf-8?B?YWt2ZVBoTk1DbzJLdFd4OTRLRk5ZN2ZGWmYwOWNsMHdRYWEvUU1aN1RaL1Ux?=
 =?utf-8?B?SDVRZERCSWlRN3ZyYytGU1oraTZiQVJRcGZDL2hBeHU5U2lQc3JCakwvQ3BG?=
 =?utf-8?B?bjZ2S0EyVXRMcm1zMnB0YitOVlpVUW1QaHZoSWVFYnQyTWFlVWRDN3hBMnZq?=
 =?utf-8?B?bVQ2d0FSTU11WU1CN0lraDJWNXpycURuU3dOTFRsbVNxL2ZlKytjOVoxa2Vr?=
 =?utf-8?B?bEVOckluOFo0MldrcXE3ZkN0SVhOWlB0TDVPalVKNUNpQUd2TTB1RVhDS3Mr?=
 =?utf-8?B?UkNaOVN4YjcvQUFraVNzU3l1MXQyYTFnZnV3K3ZvVUtEeGhQYStJZHFuNU8v?=
 =?utf-8?B?M3hDaHhWWU1OQXV5V2lySDROaExnVDdnOWJUbGY0Wk5OeXBvNHVYY0p0bTF4?=
 =?utf-8?B?c1E5bzIwaFdxZlRrZkswaHo4Wk9EZnlPOHg4c21MeFpsRlNDM3FDcTlOKzJw?=
 =?utf-8?B?Y3daZjhMYlBzaEVwcGZobmtmVmljNzdzMXZPdkVCa0U3dTFmSWJUQ1lrTDI4?=
 =?utf-8?B?ZUxtSFZyd3Q5K3Z1eVhmcnR6dVd3Q1dVYzFBZGFDT0dLMVpJRWhFTC9UU0Vv?=
 =?utf-8?B?WGV4R2pLQUllRkZDazNCZDJhb205OFZmUkZ4YUtJQkpJcEY3WWZVa05qeEZS?=
 =?utf-8?B?VzBJai9mVXI5REhhY2FCMkFIWHdJSFM1UURWMWQ0WDRna1hKN0NpTTU3NEl3?=
 =?utf-8?B?MnozV08vVGFReGJ0OTdXZnc3TWV3YlRHTCtaMFo4bkFRRWVvK3pMSVk3SXZ5?=
 =?utf-8?B?Kzc1V21PUVFtZXp1WVlYeWcxRERJelBJa2NjNTduUXcwWGVBaXlHYXNKS3Aw?=
 =?utf-8?B?Z1pOcE1ZVXNFNUU3bTNYMHFBMXZMRlZ5WGZpNTVCVGFWUmt0SnJNR2tlVTZl?=
 =?utf-8?B?VFZCTmZJZTFremtoWC9UbGxERjlQYk5LeEtOKzBUemRxSndMcldSU204RVJi?=
 =?utf-8?B?SU9OdkVpcTRxZURqV3Zxd1JhNk9kTnhoU0hJampnbk5kYkhIcWd0TXN5NlNa?=
 =?utf-8?B?UXVrNXBNa05xR0lnYjJ5NGtlajFRdFVuNHhaSzl2SmYra044SGVDUWJXa2o5?=
 =?utf-8?B?dDQvSk9Qd2FyZWVINmRNUm50dVdmRjNOZFp4UDAvVnJlM3lhUFJzRTRaQ3Vy?=
 =?utf-8?B?NGxyQ05KYWlVNFExTkFUZUpHbVBIdFhGUDNuRW9PdDFwMUNJbWdCdU03ZXVr?=
 =?utf-8?B?REVBdmRWTGw2eW5hd0VlbDhvQW4ydnRGdUJHV090emJ0MllvcktIY2F1TmZT?=
 =?utf-8?B?Tnd6RzgxcFJWRUQrL1FmbGZKTHk5TW5ZQUJUbkQvVXFjS2pTeXROelNxKzBq?=
 =?utf-8?B?S3kvRGRrdjRkd2lMZTlsSkorYnB2Y0wwazdOWnJFYStFV2thMW8vcGdzT1Za?=
 =?utf-8?B?cDBYMjRva0FrWEJKUGFjL3Rka3pFaDQvWkJCcGRkamVpRE5uVVJyQW5JSHdi?=
 =?utf-8?B?N3FrZ3NGNkVNWjlmZnZzbHNHOUgxVDdjQTVLWmxhNlBORU55bGVkOGttZ3lL?=
 =?utf-8?B?MWxSYzliZFNnN2xEWDltZ3FwbVdBYzJMUTVpeGlmSFNUaFFPRXg2VWxNT094?=
 =?utf-8?B?dTBJNEdYL2szck53Q0ZSV0gyWFpUbk5vMXlqS1I1QU00a3Zud3p3dW8zTGNN?=
 =?utf-8?Q?C6y9ItN095uKZ74LOuQY1YlwhjVYWtjuCRhxFEa?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73fd103-8ae3-47af-1559-08d8f37603f8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 12:19:07.3724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGu/b81dwQoUsyl+7s77NU3P7JeVOWyOMILDJhrtuuKdwmQqwmtSqSxpKNEYFQorcQsxCfIF/xXHt0xSWI5/St0Fn8mHb2yZWRUuypgdSjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2341
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
>
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
>
> Just reading the code, I can immediately see another potential issue in
> zynqmp_pll_set_mode(). The function is called from
> zynqmp_pll_round_rate(), which seems completely wrong, as
> zynqmp_pll_round_rate() is supposed to only perform rate calculation,
> not program the hardware. Am I missing something, or does the PLL
> implementation need to be reworked more extensively than this ?

I will send another patch to fix this issue.

Thanks,

Quanyang

>
