Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F8B3E9301
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhHKNr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:47:57 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:64270 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhHKNr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:47:56 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb6113d4db165-65096; Wed, 11 Aug 2021 21:47:09 +0800 (CST)
X-RM-TRANSID: 2eeb6113d4db165-65096
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.26.114] (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26113d4dc0dd-43701;
        Wed, 11 Aug 2021 21:47:09 +0800 (CST)
X-RM-TRANSID: 2ee26113d4dc0dd-43701
Subject: Re: [PATCH] ARM/smp_twd: Cleanup the unnecessary cast
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210811131512.940-1-tangbin@cmss.chinamobile.com>
 <20210811133121.GV22278@shell.armlinux.org.uk>
From:   tangbin <tangbin@cmss.chinamobile.com>
Message-ID: <54505b20-a9c6-9ade-dced-cb4c24df0770@cmss.chinamobile.com>
Date:   Wed, 11 Aug 2021 21:47:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210811133121.GV22278@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell:

On 2021/8/11 21:31, Russell King (Oracle) wrote:
> On Wed, Aug 11, 2021 at 09:15:12PM +0800, Tang Bin wrote:
>> It's not necessary to specify 'int' castingfor 'PTR_ERR(twd_clk)'.
>>
>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>> ---
>>   arch/arm/kernel/smp_twd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
>> index 9a14f721a..423e9079d 100644
>> --- a/arch/arm/kernel/smp_twd.c
>> +++ b/arch/arm/kernel/smp_twd.c
>> @@ -199,7 +199,7 @@ static void twd_get_clock(struct device_node *np)
>>   		twd_clk = clk_get_sys("smp_twd", NULL);
>>   
>>   	if (IS_ERR(twd_clk)) {
>> -		pr_err("smp_twd: clock not found %d\n", (int) PTR_ERR(twd_clk));
>> +		pr_err("smp_twd: clock not found %d\n", PTR_ERR(twd_clk));
> Sorry, NAK.
>
> This change _will_ produce a compiler warning. "%d" expects an argument
> of type "int", but PTR_ERR() returns a type of "long". Sorry, but the
> cast is entirely necessary.
>
> A better solution today would be to get rid of the PTR_ERR() entirely
> and use %pe, which will get us a textual description of the error when
> the appropriate kernel configuration option is enabled.
>
Got it, Thanks.
>


