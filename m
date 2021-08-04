Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DC13E0843
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239171AbhHDSuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhHDSt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:49:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5781E60F58;
        Wed,  4 Aug 2021 18:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628102984;
        bh=WUYVf156RcIPEwIWQn3ldzC8WUV1abI36QAKl5eC/p8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=COHB57FEbdoqnaj6DRj+DxURedg2b03AqX1WkNYAadldHNbF8Wbhh0v5NPTIrK5Le
         h/45eOZiub+mWChzs26HkFQHoEeOPJkm6dw0bPiWw6GFwZ0VkLJTqfbrAszIJash1U
         5aL+rN5/wxUoI0Ght7rtyDGAvnHNpywJVFdpxpej7PPbCjJaXHACOhWi9xmOxfYyYu
         q7ZJr7TV06mKs9bXx9RDzKMkpfOO/vEmQfT1mlxOZ7JsmzWbf0ZDwCiXP0BC58KsYz
         xErSjhwSYZAvI7b5wR+Z862x6wPXicZfoNO4ZT9C4aN3e93rCvMSAGDlZ0cpAlYq6H
         rypDbYv46VHAQ==
Subject: Re: [PATCH 3/4] staging: r8188eu: Remove self assignment in
 get_rx_power_val_by_reg()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210803223609.1627280-1-nathan@kernel.org>
 <20210803223609.1627280-4-nathan@kernel.org>
 <CAKwvOdkehOWitL+o4s2jWiPk0eTmcjrntiw2rLbpiGynTqSfRw@mail.gmail.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <431e7405-8761-b014-5c30-c68353ef5af9@kernel.org>
Date:   Wed, 4 Aug 2021 11:49:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkehOWitL+o4s2jWiPk0eTmcjrntiw2rLbpiGynTqSfRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/2021 11:37 AM, 'Nick Desaulniers' via Clang Built Linux wrote:
> On Tue, Aug 3, 2021 at 3:36 PM Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> Clang warns:
>>
>> drivers/staging/r8188eu/hal/rtl8188e_rf6052.c:344:13: warning:
>> explicitly assigning value of variable of type 'u32' (aka 'unsigned
>> int') to itself [-Wself-assign]
>>                          writeVal = writeVal;
>>                          ~~~~~~~~ ^ ~~~~~~~~
>> 1 warning generated.
>>
>> Remove this branch as it is useless.
>>
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>> ---
>>   drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
>> index 335b120ce603..77889dc05858 100644
>> --- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
>> +++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
>> @@ -340,8 +340,6 @@ static void get_rx_power_val_by_reg(struct adapter *Adapter, u8 Channel,
>>                  /*  This mechanism is only applied when Driver-Highpower-Mechanism is OFF. */
>>                  if (pdmpriv->DynamicTxHighPowerLvl == TxHighPwrLevel_BT1)
>>                          writeVal = writeVal - 0x06060606;
>> -               else if (pdmpriv->DynamicTxHighPowerLvl == TxHighPwrLevel_BT2)
>> -                       writeVal = writeVal;
> 
> Hopefully the author didn't mean to subtract another magic constant
> like they did above. This also eliminates the last use of
> TxHighPwrLevel_BT2, but it's probably ok to keep the define in
> drivers/staging/r8188eu/include/odm.h.

For what it's worth, it seems that the DynamicTxHighPowerLvl member is 
only ever assigned TxHighPwrLevel_Normal so the first if statement is 
probably dead code too but I wanted to clean up the clang warnings, not 
rewrite the driver, since I could do that for hours upon hours :)

> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the review!

Cheers,
Nathan

>>                  *(pOutWriteVal+rf) = writeVal;
>>          }
>>   }
>> --
>> 2.33.0.rc0
> 
> 
