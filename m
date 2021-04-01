Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C374350C35
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 04:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhDACDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 22:03:38 -0400
Received: from mail-dm3nam07on2062.outbound.protection.outlook.com ([40.107.95.62]:6177
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230284AbhDACDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 22:03:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOGgy0xJ0lIfenesxhPCOaV+qG/1OH4neiGDDpryW+uEkKEZa386dvVzuX5ryWYtAguYB7sP7jwvo3DEOtsF8oZS+i3xcKB/U009bqTfPXPh/61DhrtSJNnsm8YVWF3+dfKKuYHdHZN+JJagqAONCGhPOkSmVUKBkHsKgYLjnPKhVOjoz1oaukJFuvSVYI2nShbhqyIgxoD8QPb7z0kZxMEVyk3Bku7qF+Vt84BT2C/HN8vSgR+gtfrvk7L10jc1OtJBjDpmeOg2UC8E/E1rfIM0rtJ9ilaNJyjSWDK3Vh13Ij/vl1lxAeRFE4rcHu+VtPBZrijIUgwRpXgAWAUY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3WR43gUNB69e4lV+OmbnzDB7K/Z8/D6Vl267eWYBp4=;
 b=dCtLbzQTvDFEw+NvbZoJxf1I9FLcDo7Bcx61VciQAWstVmiXQMPdpfn2lOhftXfddnanO6y/0eS6bM/ba/T3DHwMj8q81NjiF1Jb6E7llNcBMWYS9fp84oL82klLsSXEpTVkAW+v8zjd0EK1Glyerw8HmxIeXezEuZJtYOz6flmV84VrVYO1COqOLtDXKsuS8XJzG7tD8CPL0XdpHzSOj2k0c/yh/fFHoZZTrJH41J+DF7ncvvAPMwAImAInXUf3kDP/Th/QSTYoGUoRDXK/f7k0g/kvn8e1iI4w60cIm+XSpbPx5WQCmTUBPK4Z4WbCKZqlQKXuc/zqLVCxHcRsAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3WR43gUNB69e4lV+OmbnzDB7K/Z8/D6Vl267eWYBp4=;
 b=iP1i8b21za0i4KYxFpuMbzps2uclOtr5wezqZFHkS8iAlfWmulXC3jQYaQ5b6vW/3rthDlDt0bVm15xE04BN/m8qkiT837nipMlMqaIEwv/A2CBtgZ43wVj0eW+fOMpb6OPSC4rpeZDEUuHXgwOUqAdhIPt+cQqjcGZ1gBOI8eo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1718.namprd11.prod.outlook.com (2603:10b6:903:2c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 02:03:07 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 02:03:07 +0000
Subject: Re: [V2] [PATCH] clk: zynqmp: pll: add set_pll_mode to check
 condition in zynqmp_pll_enable
To:     Stephen Boyd <sboyd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210330121701.3258948-1-quanyang.wang@windriver.com>
 <161724174987.2260335.3629133210221429059@swboyd.mtv.corp.google.com>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <deac32ec-a80b-bca7-2573-4c80fe2bca72@windriver.com>
Date:   Thu, 1 Apr 2021 10:02:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <161724174987.2260335.3629133210221429059@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::20) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by SJ0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:a03:2c0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Thu, 1 Apr 2021 02:03:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5b52f76-1fb7-487d-a8af-08d8f4b24b0b
X-MS-TrafficTypeDiagnostic: CY4PR11MB1718:
X-Microsoft-Antispam-PRVS: <CY4PR11MB171833814D1ADABD61136833F07B9@CY4PR11MB1718.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EshzPiRedVpufcaGcr3buTEVUX39kQQx4rKvuOMIGwKIBPCrO6pHn4IUmmiV3UfIWXuNqWRFXOMza4vQdPHv5I01Iuo726brEvgcGVtQ6tBufX2EbpfFW/9w1Y+vNfXWPVTEd9swgpB0BJfimo3v465Z0tFBO7frQjEpQ+gFoK050oCDzlc6pNlSkl5Gbdhwrm/LtO4J2GLosRYCPJ6zd3t84kkC9Er8ZOCX66G7NDzaV0rxPpdQUVq3HSWm9l1tbGdUlhGzZDspljg6TFOnG7ogdMJNZKQaYm3aF2x9Og0xTRp9G/GH7OrepLvzQGJOmTBHzmY1waoZyeJj6lirMC9gGmOlGrR10/I3kILpWdUqLg2WwA5XK0E5B9e9VRD7DjcKrPxKSuuTbrmbsu3ZUbnYSkeKUgRtWuKMPDwibamT0/ybth+v9M8tjposTjfxf/TpzuvHLoChpPrEdDaLRbMsAvWfFT+f42NjHeZkppy1lIOYRNNln4CFxp4E4uAlQzDBcsUK1sSu+CdzNU6soFs8SPg1q49FQT3P1HbLON96AKs1YIbHM1/Cu/NBOiVsyMrkff2qwnMVVVh30oiSJtufxKOt5B9Rr8xS1rZyGpYsY+KgmvU0CvsYKKf1F3FRX3wjxGudiyaGyNtALsv+iMTX6Gh4BAaMEyjgMSA+RDYYFIeZOtv0NUT0VekaK7DwhDqBIlR1U85muf3vwnYCNyWoCc4mve2/jxxk/iy5eJu6n8b1u/gGTYf4YEZLXQ2m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(136003)(366004)(376002)(346002)(6706004)(66946007)(31696002)(66556008)(66476007)(2616005)(38100700001)(53546011)(478600001)(6486002)(956004)(36756003)(31686004)(52116002)(2906002)(16576012)(316002)(16526019)(8676002)(7416002)(186003)(110136005)(54906003)(4326008)(8936002)(86362001)(26005)(83380400001)(5660300002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bU9mUDdrQ2NNZzM2Tis4ZnA1ZEUrNFU5N3pieWN4T05FK1A4MFpNYUJSSGY2?=
 =?utf-8?B?YTA1Zjk3L1Y4ZnpYeXQ2U282M0srWHltUWZiV2dUcm9tQWpXTkNSbGZaUUVl?=
 =?utf-8?B?cldPTHVXQVg4OStSTVFCMXNPRTFqejhoMUhWOGxOYkpKNTFyTjFmZWxsd2RT?=
 =?utf-8?B?V1c4MGZ1VEVJaitWcVNqclpoekJBcm9ReVZvTFdJRTFnZXRuOEpJdlVRelBq?=
 =?utf-8?B?aGlRTlB4NU1qYnRwUE9oMWxQZWMxQWF3S2s0emliNzA5a1pxb3ZzbEtobFhV?=
 =?utf-8?B?Unl2K1BIMUNIQjRDMmgrSUltdXhuNmtLcHo0eVJDRXlnVlRINnIxc1JGUjdX?=
 =?utf-8?B?dVgyWnVOZVhCbGRrOXR4cmtLbm5IQXlRMUZYcUlJaCtudVFxbWVaSFVob0lu?=
 =?utf-8?B?YTh0WlBHczl6RXQreEdEeGNEU0RDYXBRazBuUFNISnZUaHRHNGc0OXpxQ3B0?=
 =?utf-8?B?Z1lzRGUyTEVnRTNvVWhaeXlONnVlMWdCbWtwaFdCeGZyMHNJK3Z2ZmZVQ3Fo?=
 =?utf-8?B?V1d5OFRSMnhqYUFqVGFFVjNhV1J3NWhpd2FSRWEyOTFoeWczd0xHMzBDU0pB?=
 =?utf-8?B?VWt5OS9obnMzaGRWeUl0dkdaVGlzZGZYN0UwN1A3dHdOWjR1aWtoM05qdTdC?=
 =?utf-8?B?Q2N1SmdWZlo4QnRhcEt2bTVaTXRPRE1yNHI0ZUJYbzB2OUNXSVNneUNVbVFt?=
 =?utf-8?B?dVE4djlLNFBabHI4K1JMQzBRZWdOOVBzUTU3VzlZYTZaOGNONGU0ejU3N1J4?=
 =?utf-8?B?SzdKcVhMTmJBR3BkNXRWWlBHT05udGhKamh0MmhJZVRidUNOVHBHQ3Z0Q0ZQ?=
 =?utf-8?B?eEVORmZxRTBqNmRjUmJkVUhVbkk0eEhQK1JrUkx6YU5reHYvT05wVVVTNENY?=
 =?utf-8?B?aFpFeVBacnRyYVkxL2VlbXN1R2dMdTJ4Vkx6bWh0SWQwTll6aEpjSGhNWUlF?=
 =?utf-8?B?YjBja2FJWmRoYUZSOUNEOXdZejU2MVMyZEN3VFV2bHV4amk3a3lFNC9NUzJx?=
 =?utf-8?B?aW11aDhUNEZMSDU1VXpkaytlUS9SdGhtZmp1SG9RUEkvdytPUm1pTG5WbFNq?=
 =?utf-8?B?Q1FDS0NnZ1BuUzdRS2wwRGxyQ0NNcG5Mb1BqT296NGpNYzFFMEZwY0RFbGlJ?=
 =?utf-8?B?SnBDRFJrM1VTbnlkbWdkd3NwVlhaZkxucmt2b1dFbmIzSGRGTkVnaFFhQkg1?=
 =?utf-8?B?d3RtZzB5WkNENStCM0JSNlRUZEhiYWEvdjg2eVVRRGtwK3BNZURNZU5KUEk2?=
 =?utf-8?B?U2RWRGkzT2NHcHpFZ1NXZzZxMzRxVjhWckZmOXAvTlBCSmtubVdkWml1TXo1?=
 =?utf-8?B?VzlIdnJPRWtTTHFGcUpaMFV6NDRzbWVnLzZGeVRLNkNFY3FTck1xQVFqOUIy?=
 =?utf-8?B?Sk83dERjVHZEVElIVEU2cGpPNVVvQk9CUmVkQUZWNFYxQVNJOVdqUmpVVTJz?=
 =?utf-8?B?Mkgzb3JReTVhVGp1RjNHTTIvQmpSMFhBWkg0dUp3R1dWd0ZSRUY1YWdWeXhl?=
 =?utf-8?B?NWxUbytSVnFNM3l1MnNGZm9ZZEFNdTU5UGpGeFV0NFlVbWZWY0QzdEcrVk0y?=
 =?utf-8?B?YktiKyttb1N5K2Y5MGgvSi9YNUdrREo0bGdpdkJCK2FUaWZsU0N4SVI3TUpC?=
 =?utf-8?B?UmhEZG9rcUdxZXZ1UUFFRzBlald2RUEvNGV3SUM4SUpPM1J5SzhMOGVnc0J4?=
 =?utf-8?B?ci8wUWVWampQOCtCUjhXbUdUd2FQallmNnQrTHVtenZCVy9HZEt2OFl2VS9y?=
 =?utf-8?Q?RCl3aLQWvJNmJBzSNsjsVc1KcGW2BNMTmFpmlc5?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b52f76-1fb7-487d-a8af-08d8f4b24b0b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 02:03:07.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8AlNb+GO4OeiWjSQnn9rbeh+qnwwJkJ9NyC4JEjUa8v28nvW1SS3JT8LBZBScfbG7VvGU5lEsWezc+DvoZ+7gco0UINLj+YMk1y2rGCGulk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1718
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 4/1/21 9:49 AM, Stephen Boyd wrote:
> Quoting quanyang.wang@windriver.com (2021-03-30 05:17:01)
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
>> successfully. So adding set_pll_mode to check condition to fix it.
>>
>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> ---
> Any Fixes tag?

Will add it at V3 patch.

Thanks,

Quanyang

