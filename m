Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646E7454A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbhKQQLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbhKQQLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:11:01 -0500
X-Greylist: delayed 3169 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 Nov 2021 08:08:02 PST
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72735C061570;
        Wed, 17 Nov 2021 08:08:02 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id EC26F41F12;
        Wed, 17 Nov 2021 16:07:58 +0000 (UTC)
Subject: Re: [PATCH 1/2] usb: typec: tipd: Fix typo in
 cd321x_switch_power_state
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sven Peter <sven@svenpeter.dev>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211117151450.207168-1-marcan@marcan.st>
 <20211117151450.207168-2-marcan@marcan.st> <YZUn5S+RMF4yOnOt@kroah.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <7b55109d-a9b0-ae09-bd32-68fe67912ef1@marcan.st>
Date:   Thu, 18 Nov 2021 01:07:56 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YZUn5S+RMF4yOnOt@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2021 01.03, Greg Kroah-Hartman wrote:
> On Thu, Nov 18, 2021 at 12:14:49AM +0900, Hector Martin wrote:
>> SPSS should've been SSPS.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
>>   drivers/usb/typec/tipd/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>> index fb8ef12bbe9c..4da5a0b2aed2 100644
>> --- a/drivers/usb/typec/tipd/core.c
>> +++ b/drivers/usb/typec/tipd/core.c
>> @@ -653,7 +653,7 @@ static int cd321x_switch_power_state(struct tps6598x *tps, u8 target_state)
>>   	if (state == target_state)
>>   		return 0;
>>   
>> -	ret = tps6598x_exec_cmd(tps, "SPSS", sizeof(u8), &target_state, 0, NULL);
>> +	ret = tps6598x_exec_cmd(tps, "SSPS", sizeof(u8), &target_state, 0, NULL);
>>   	if (ret)
>>   		return ret;
>>   
>> -- 
>> 2.33.0
>>
> 
> This looks like a "Fix" commit.  What commit id does this fix?
> 
> thanks,
> 
> greg k-h
> 

That should be:

Fixes: c9c14be664cf ("usb: typec: tipd: Switch CD321X power state to S0")

Thanks,
-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
