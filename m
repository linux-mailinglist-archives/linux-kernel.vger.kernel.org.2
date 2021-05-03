Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988D6371156
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 07:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhECFvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 01:51:13 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:32698 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229451AbhECFvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 01:51:12 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d70 with ME
        id 05qE2500A21Fzsu035qEXC; Mon, 03 May 2021 07:50:18 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 03 May 2021 07:50:18 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH] clk: zynqmp: pll: Remove some dead code
To:     Rajan Vaja <RAJANV@xilinx.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "quanyang.wang@windriver.com" <quanyang.wang@windriver.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
References: <71a9fed5f762a71248b8ac73c0a15af82f3ce1e2.1619867987.git.christophe.jaillet@wanadoo.fr>
 <BYAPR02MB394182A55D073BC6061F6D76B75B9@BYAPR02MB3941.namprd02.prod.outlook.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <d47c05e0-14b9-c64e-1468-4bae7db83840@wanadoo.fr>
Date:   Mon, 3 May 2021 07:50:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB394182A55D073BC6061F6D76B75B9@BYAPR02MB3941.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 03/05/2021 à 06:56, Rajan Vaja a écrit :
> Hi,
>
> Thanks for the patch.
>
>> -----Original Message-----
>> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> Sent: 01 May 2021 04:55 PM
>> To: mturquette@baylibre.com; sboyd@kernel.org; Michal Simek
>> <michals@xilinx.com>; quanyang.wang@windriver.com; Rajan Vaja
>> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; Tejas Patel
>> <tejasp@xlnx.xilinx.com>; Shubhrajyoti Datta <shubhraj@xilinx.com>
>> Cc: linux-clk@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; kernel-janitors@vger.kernel.org; Christophe JAILLET
>> <christophe.jaillet@wanadoo.fr>
>> Subject: [PATCH] clk: zynqmp: pll: Remove some dead code
>>
>> 'clk_hw_set_rate_range()' does not return any error code and 'ret' is
>> known to be 0 at this point, so this message can never be displayed.
>>
>> Remove it.
>>
>> Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> HOWEVER, the message is about 'clk_set_rate_range()', not
>> 'clk_hw_set_rate_range()'. So the message is maybe correct and the
>> 'xxx_rate_range()' function incorrect.
>> ---
>>   drivers/clk/zynqmp/pll.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
>> index abe6afbf3407..af11e9400058 100644
>> --- a/drivers/clk/zynqmp/pll.c
>> +++ b/drivers/clk/zynqmp/pll.c
>> @@ -331,8 +331,6 @@ struct clk_hw *zynqmp_clk_register_pll(const char *name,
>> u32 clk_id,
>>   	}
>>
>>   	clk_hw_set_rate_range(hw, PS_PLL_VCO_MIN, PS_PLL_VCO_MAX);
>> -	if (ret < 0)
>> -		pr_err("%s:ERROR clk_set_rate_range failed %d\n", name, ret);
> [Rajan] Instead of removing, can we get return value of clk_hw_set_rate_range() and
> print in case of an error.

Hi,

if it was possible, it is what I would have proposed because it looks 
'logical'.

However, 'clk_hw_set_rate_range()' returns void.
Hence my comment about 'clk_hw_set_rate_range' being the correct 
function to call or not. (i.e. is the comment right and 
'clk_hw_set_rate_range' wrong?)

CJ



>>   	return hw;
>>   }
>> --
>> 2.30.2
