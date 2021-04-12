Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CA035D261
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 23:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244759AbhDLVKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 17:10:18 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:18023 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240605AbhDLVKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 17:10:17 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d24 with ME
        id rx9v2400321Fzsu03x9vcL; Mon, 12 Apr 2021 23:09:56 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 12 Apr 2021 23:09:56 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH 2/3] staging: rtl8723bs: Use existing arc4 implementation
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <7e16c40d5baa007dca81a12b967a597ed00d8dd7.1618055514.git.christophe.jaillet@wanadoo.fr>
 <6a4aebf9feb9ece975734f2e51da5ecae2996cee.1618055514.git.christophe.jaillet@wanadoo.fr>
 <YHQUH+Nqc/zS14Tb@kroah.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <b37bc546-c087-0f9d-b16a-bfc2231e0849@wanadoo.fr>
Date:   Mon, 12 Apr 2021 23:09:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YHQUH+Nqc/zS14Tb@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/04/2021 à 11:34, Greg KH a écrit :
> On Sat, Apr 10, 2021 at 03:35:52PM +0200, Christophe JAILLET wrote:
>> Use functions provided by <crypto/arc4.h> instead of hand writing them.
>>
>> The implementations are slightly different, but are equivalent. It has
>> been checked with a test program which compares the output of the 2 sets of
>> functions.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/staging/rtl8723bs/core/rtw_security.c | 101 ++++--------------
>>   1 file changed, 21 insertions(+), 80 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
>> index 9587d89a6b24..86949a65e96f 100644
>> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
>> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
>> @@ -6,6 +6,7 @@
>>    ******************************************************************************/
>>   #define  _RTW_SECURITY_C_
>>   
>> +#include <crypto/arc4.h>
>>   #include <linux/crc32poly.h>
>>   #include <drv_types.h>
>>   #include <rtw_debug.h>
>> @@ -31,66 +32,6 @@ const char *security_type_str(u8 value)
>>   
>>   /* WEP related ===== */
>>   
>> -struct arc4context {
>> -	u32 x;
>> -	u32 y;
>> -	u8 state[256];
>> -};
>> -
>> -
>> -static void arcfour_init(struct arc4context	*parc4ctx, u8 *key, u32 key_len)
>> -{
>> -	u32 t, u;
>> -	u32 keyindex;
>> -	u32 stateindex;
>> -	u8 *state;
>> -	u32 counter;
>> -
>> -	state = parc4ctx->state;
>> -	parc4ctx->x = 0;
>> -	parc4ctx->y = 0;
>> -	for (counter = 0; counter < 256; counter++)
>> -		state[counter] = (u8)counter;
>> -	keyindex = 0;
>> -	stateindex = 0;
>> -	for (counter = 0; counter < 256; counter++) {
>> -		t = state[counter];
>> -		stateindex = (stateindex + key[keyindex] + t) & 0xff;
>> -		u = state[stateindex];
>> -		state[stateindex] = (u8)t;
>> -		state[counter] = (u8)u;
>> -		if (++keyindex >= key_len)
>> -			keyindex = 0;
>> -	}
>> -}
>> -
>> -static u32 arcfour_byte(struct arc4context	*parc4ctx)
>> -{
>> -	u32 x;
>> -	u32 y;
>> -	u32 sx, sy;
>> -	u8 *state;
>> -
>> -	state = parc4ctx->state;
>> -	x = (parc4ctx->x + 1) & 0xff;
>> -	sx = state[x];
>> -	y = (sx + parc4ctx->y) & 0xff;
>> -	sy = state[y];
>> -	parc4ctx->x = x;
>> -	parc4ctx->y = y;
>> -	state[y] = (u8)sx;
>> -	state[x] = (u8)sy;
>> -	return state[(sx + sy) & 0xff];
>> -}
>> -
>> -static void arcfour_encrypt(struct arc4context *parc4ctx, u8 *dest, u8 *src, u32 len)
>> -{
>> -	u32 i;
>> -
>> -	for (i = 0; i < len; i++)
>> -		dest[i] = src[i] ^ (unsigned char)arcfour_byte(parc4ctx);
>> -}
>> -
>>   static signed int bcrc32initialized;
>>   static u32 crc32_table[256];
>>   
>> @@ -150,7 +91,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
>>   {																	/*  exclude ICV */
>>   
>>   	unsigned char crc[4];
>> -	struct arc4context	 mycontext;
>> +	struct arc4_ctx mycontext;
> 
> Are you sure you can declare that much space on the stack?  Is that what
> other users of this api do?  In looking at the in-kernel users, they do
> not :(
> 

In fact arc4context was a u8[256] but arc4_ctx uses a u32[256].

Maybe arc4 function should be modified to use u8? Or at least when
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is defined?



Concerning the other uses of the arc4 API, in fact there is only few of 
them. Most uses are buried into lib80211_crypt_tkip.c and 
lib80211_crypt_wep.c which is the way to go, IMHO.
In fact, I think that most, if not all 'rtl871x_security.c' could be 
removed.

However, it looks like a big step to me. And without any hardware to 
test, I'm pretty sure to break something.


Any hints on the best way to axe some duplicated code without to much 
risks to break everything?

CJ

> Can you fix up this series to not take up so much stack memory?

I guess that _adapter could be used to store this arc4_ctx, but I'm not 
convinced that it is the way to go.

CJ

> 
> thanks,
> 
> greg k-h
> 

