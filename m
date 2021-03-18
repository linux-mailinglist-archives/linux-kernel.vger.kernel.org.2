Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9296334060A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhCRMsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:48:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36890 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhCRMsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:48:08 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lMs4M-0007re-NI; Thu, 18 Mar 2021 12:48:06 +0000
Subject: Re: [PATCH][next] soc: xilinx: vcu: remove deadcode on null divider
 check
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210210184938.146124-1-colin.king@canonical.com>
 <161301409895.1254594.6980739457487251623@swboyd.mtv.corp.google.com>
 <20210211073906.GC30300@pengutronix.de>
 <161307031421.1254594.40010291545314425@swboyd.mtv.corp.google.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <eef269e5-e16d-90ef-d765-8f50d7e2176a@canonical.com>
Date:   Thu, 18 Mar 2021 12:48:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <161307031421.1254594.40010291545314425@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2021 19:05, Stephen Boyd wrote:
> Quoting Michael Tretter (2021-02-10 23:39:06)
>> On Wed, 10 Feb 2021 19:28:18 -0800, Stephen Boyd wrote:
>>> Quoting Colin King (2021-02-10 10:49:38)
>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>
>>>> The pointer 'divider' has previously been null checked followed by
>>>> a return, hence the subsequent null check is redundant deadcode
>>>> that can be removed.  Clean up the code and remove it.
>>>>
>>>> Fixes: 9c789deea206 ("soc: xilinx: vcu: implement clock provider for output clocks")
>>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>>> ---
>>>>  drivers/clk/xilinx/xlnx_vcu.c | 3 ---
>>>>  1 file changed, 3 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/xilinx/xlnx_vcu.c b/drivers/clk/xilinx/xlnx_vcu.c
>>>> index d66b1315114e..607936d7a413 100644
>>>> --- a/drivers/clk/xilinx/xlnx_vcu.c
>>>> +++ b/drivers/clk/xilinx/xlnx_vcu.c
>>>> @@ -512,9 +512,6 @@ static void xvcu_clk_hw_unregister_leaf(struct clk_hw *hw)
>>>>  
>>>>         mux = clk_hw_get_parent(divider);
>>>>         clk_hw_unregister_mux(mux);
>>>> -       if (!divider)
>>>> -               return;
>>>> -
>>>
>>> This code is pretty confusing. Waiting for m.tretter@pengutronix.de to
>>> reply
>>
>> Can you elaborate what you find confusing about this code. I would gladly try
>> to clarify and improve the code.
> 
> The fact that pointers are being checked and then bailing out of the
> function early, vs. doing something if the pointer is non-NULL.
> 
>>
>> What happens here is that the driver registers a mux -> divider -> gate chain
>> for each output clock, but only stores the gate clock. When unregistering the
>> clocks, the driver starts at the gate and walks up to the mux while
>> unregistering the clocks.
>>

OK, so I think I understand this better, should the order of
unregisteration be as follows:

diff --git a/drivers/clk/xilinx/xlnx_vcu.c b/drivers/clk/xilinx/xlnx_vcu.c
index d66b1315114e..66bac8421460 100644
--- a/drivers/clk/xilinx/xlnx_vcu.c
+++ b/drivers/clk/xilinx/xlnx_vcu.c
@@ -511,11 +511,11 @@ static void xvcu_clk_hw_unregister_leaf(struct
clk_hw *hw)
                return;

        mux = clk_hw_get_parent(divider);
-       clk_hw_unregister_mux(mux);
-       if (!divider)
+       clk_hw_unregister_mux(divider);
+       if (!mux)
                return;

-       clk_hw_unregister_divider(divider);
+       clk_hw_unregister_divider(mux);
