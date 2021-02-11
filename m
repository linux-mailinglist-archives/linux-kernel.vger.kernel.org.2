Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AA031874D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBKJph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 04:45:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44976 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhBKJl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 04:41:59 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lA8TL-0003KX-5G; Thu, 11 Feb 2021 09:41:15 +0000
Subject: Re: [PATCH][next] soc: xilinx: vcu: remove deadcode on null divider
 check
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210210184938.146124-1-colin.king@canonical.com>
 <20210211073156.GB30300@pengutronix.de>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <8c01414b-fba3-f22d-152f-bfb7d76f9d00@canonical.com>
Date:   Thu, 11 Feb 2021 09:41:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210211073156.GB30300@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2021 07:31, Michael Tretter wrote:
> On Wed, 10 Feb 2021 18:49:38 +0000, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The pointer 'divider' has previously been null checked followed by
>> a return, hence the subsequent null check is redundant deadcode
>> that can be removed.  Clean up the code and remove it.
>>
>> Fixes: 9c789deea206 ("soc: xilinx: vcu: implement clock provider for output clocks")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/clk/xilinx/xlnx_vcu.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/clk/xilinx/xlnx_vcu.c b/drivers/clk/xilinx/xlnx_vcu.c
>> index d66b1315114e..607936d7a413 100644
>> --- a/drivers/clk/xilinx/xlnx_vcu.c
>> +++ b/drivers/clk/xilinx/xlnx_vcu.c
>> @@ -512,9 +512,6 @@ static void xvcu_clk_hw_unregister_leaf(struct clk_hw *hw)
>>  
>>  	mux = clk_hw_get_parent(divider);
>>  	clk_hw_unregister_mux(mux);
>> -	if (!divider)
>> -		return;
>> -
>>  	clk_hw_unregister_divider(divider);
> 
> Thanks for pointing this out. There is actually a different bug there.
> 
> There should have been a check for !mux before unregistering the mux:
> 
> 	mux = clk_hw_get_parent(divider);
> 	clk_hw_unregister_divider(divider);
> 	if (!mux)
> 		return;

Ah, that makes sense, I'll send a V2.

> 
> 	clk_hw_unregister_mux(mux);
> 
> Michael
> 
>>  }
>>  
>> -- 
>> 2.30.0
>>
>>

