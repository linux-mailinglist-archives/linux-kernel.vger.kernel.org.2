Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51F73212E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhBVJO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:14:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230257AbhBVJNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:13:06 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49DD361493;
        Mon, 22 Feb 2021 09:12:25 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lE7GQ-00FHXV-Qt; Mon, 22 Feb 2021 09:12:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Feb 2021 09:12:22 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     "Li, Meng" <Meng.Li@windriver.com>
Cc:     linux-kernel@vger.kernel.org, lee.jones@linaro.org, arnd@arndb.de,
        "Hao, Kexin" <Kexin.Hao@windriver.com>
Subject: Re: [v2][PATCH] Revert "mfd: syscon: Don't free allocated name for
 regmap_config"
In-Reply-To: <CO1PR11MB48497CB7B11EDA65A3941FDCF1819@CO1PR11MB4849.namprd11.prod.outlook.com>
References: <20210115015050.26657-1-meng.li@windriver.com>
 <CO1PR11MB48497CB7B11EDA65A3941FDCF1819@CO1PR11MB4849.namprd11.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <36cc2d810d90237947ad953ebd6b9fb7@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: Meng.Li@windriver.com, linux-kernel@vger.kernel.org, lee.jones@linaro.org, arnd@arndb.de, Kexin.Hao@windriver.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Limeng,

On 2021-02-22 03:45, Li, Meng wrote:
> Hi Marc&Lee,
> 
> Is there any comment on this patch?
> Could you please help to review this patch so that I can improve it if
> it still has weakness?

If you are confident that the root issue has been fixed, no objection
from me, but I'm not in a position to test it at the moment (the board
I found the problem on is in a bit of a state).

Thanks,

         M.

> 
> Thanks,
> Limeng
> 
>> -----Original Message-----
>> From: Li, Meng <Meng.Li@windriver.com>
>> Sent: Friday, January 15, 2021 9:51 AM
>> To: linux-kernel@vger.kernel.org
>> Cc: maz@kernel.org; lee.jones@linaro.org; arnd@arndb.de; Hao, Kexin
>> <Kexin.Hao@windriver.com>; Li, Meng <Meng.Li@windriver.com>
>> Subject: [v2][PATCH] Revert "mfd: syscon: Don't free allocated name 
>> for
>> regmap_config"
>> 
>> From: Limeng <Meng.Li@windriver.com>
>> 
>> This reverts commit 529a1101212a785c5df92c314b0e718287150c3b.
>> 
>> The reverted patch moves the memory free to error path, but introduce 
>> a
>> memory leak. There is another commit 94cc89eb8fa5("regmap: debugfs:
>> Fix handling of name string for debugfs init delays") fixing this 
>> debugfs init
>> issue from root cause. With this fixing, the name field in struct
>> regmap_debugfs_node is removed. When initialize debugfs for syscon 
>> driver,
>> the name field of struct regmap_config is not used anymore. So, revert 
>> this
>> patch directly to avoid memory leak.
>> 
>> v2:
>> Notify the author of the reverted commit by adding Cc:
>> 
>> Fixes: 529a1101212a("mfd: syscon: Don't free allocated name for
>> regmap_config")
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Meng Li <Meng.Li@windriver.com>
>> ---
>>  drivers/mfd/syscon.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c index
>> ca465794ea9c..df5cebb372a5 100644
>> --- a/drivers/mfd/syscon.c
>> +++ b/drivers/mfd/syscon.c
>> @@ -108,6 +108,7 @@ static struct syscon *of_syscon_register(struct
>> device_node *np, bool check_clk)
>>  	syscon_config.max_register = resource_size(&res) - reg_io_width;
>> 
>>  	regmap = regmap_init_mmio(NULL, base, &syscon_config);
>> +	kfree(syscon_config.name);
>>  	if (IS_ERR(regmap)) {
>>  		pr_err("regmap init failed\n");
>>  		ret = PTR_ERR(regmap);
>> @@ -144,7 +145,6 @@ static struct syscon *of_syscon_register(struct
>> device_node *np, bool check_clk)
>>  	regmap_exit(regmap);
>>  err_regmap:
>>  	iounmap(base);
>> -	kfree(syscon_config.name);
>>  err_map:
>>  	kfree(syscon);
>>  	return ERR_PTR(ret);
>> --
>> 2.17.1

-- 
Jazz is not dead. It just smells funny...
