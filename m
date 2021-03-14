Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15B933A3F4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 10:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhCNJlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 05:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhCNJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 05:40:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1ADC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 01:40:37 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lLNEb-0000iR-MW; Sun, 14 Mar 2021 10:40:29 +0100
Subject: Re: [PATCH V4] clk: imx: Fix reparenting of UARTs not associated with
 stdout
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        aford@beaconembedded.com, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20210313122818.445228-1-aford173@gmail.com>
 <e754a185-4aa2-295a-37a8-dd0c7ebc289f@pengutronix.de>
Message-ID: <0361ab5b-a26e-7631-9bae-8909715f6354@pengutronix.de>
Date:   Sun, 14 Mar 2021 10:40:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <e754a185-4aa2-295a-37a8-dd0c7ebc289f@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.03.21 16:16, Ahmad Fatoum wrote:
>> +/* i.MX boards use device trees now.  For build tests without CONFIG_OF, do nothing */
>> +#ifdef CONFIG_OF
>>  	if (imx_keep_uart_clocks) {
>>  		int i;
>>  
>> -		imx_uart_clocks = clks;
>> -		for (i = 0; imx_uart_clocks[i]; i++)
>> -			clk_prepare_enable(*imx_uart_clocks[i]);
>> +		imx_uart_clocks = kcalloc(clk_count, sizeof(struct clk *), GFP_KERNEL);
>> +
>> +		if (!of_stdout)
>> +			return;
> 
> Memory leak. Just do if (imx_keep_uart_clocks && of_stdout)

Please dismiss. I overlooked that you free it in a later initcall.

>>  static int __init imx_clk_disable_uart(void)
>>  {
>> -	if (imx_keep_uart_clocks && imx_uart_clocks) {
>> +	if (imx_keep_uart_clocks && imx_enabled_uart_clocks) {
>>  		int i;
>>  
>> -		for (i = 0; imx_uart_clocks[i]; i++)
>> -			clk_disable_unprepare(*imx_uart_clocks[i]);
>> +		for (i = 0; i < imx_enabled_uart_clocks; i++) {
>> +			clk_disable_unprepare(imx_uart_clocks[i]);
>> +			clk_put(imx_uart_clocks[i]);
>> +		};
>> +		kfree(imx_uart_clocks);
>>  	}

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
