Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49BC30C98C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbhBBSWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbhBBSUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:20:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D60FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:19:44 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1l70H5-000128-Sk; Tue, 02 Feb 2021 19:19:39 +0100
Subject: Re: [PATCH 1/2] dm crypt: replaced #if defined with IS_ENABLED
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dmitry Baryshkov <dbaryshkov@gmail.com>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        kernel@pengutronix.de, Alasdair Kergon <agk@redhat.com>
References: <20210122084321.24012-1-a.fatoum@pengutronix.de>
 <20210202181035.GA14886@redhat.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <6bf5f23d-ff89-7e03-a226-d23959f34abb@pengutronix.de>
Date:   Tue, 2 Feb 2021 19:19:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210202181035.GA14886@redhat.com>
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

Hello Mike,

On 02.02.21 19:10, Mike Snitzer wrote:
> On Fri, Jan 22 2021 at  3:43am -0500,
> Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> 
>> IS_ENABLED(CONFIG_ENCRYPTED_KEYS) is true whether the option is built-in
>> or a module, so use it instead of #if defined checking for each
>> separately.
>>
>> The other #if was to avoid a static function defined, but unused
>> warning. As we now always build the callsite when the function
>> is defined, we can remove that first #if guard.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> ---
>> Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
>> ---
>>  drivers/md/dm-crypt.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
>> index 8c874710f0bc..7eeb9248eda5 100644
>> --- a/drivers/md/dm-crypt.c
>> +++ b/drivers/md/dm-crypt.c
>> @@ -2436,7 +2436,6 @@ static int set_key_user(struct crypt_config *cc, struct key *key)
>>  	return 0;
>>  }
>>  
>> -#if defined(CONFIG_ENCRYPTED_KEYS) || defined(CONFIG_ENCRYPTED_KEYS_MODULE)
>>  static int set_key_encrypted(struct crypt_config *cc, struct key *key)
>>  {
>>  	const struct encrypted_key_payload *ekp;
>> @@ -2452,7 +2451,6 @@ static int set_key_encrypted(struct crypt_config *cc, struct key *key)
>>  
>>  	return 0;
>>  }
>> -#endif /* CONFIG_ENCRYPTED_KEYS */
>>  
>>  static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string)
>>  {
>> @@ -2482,11 +2480,10 @@ static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string
>>  	} else if (!strncmp(key_string, "user:", key_desc - key_string + 1)) {
>>  		type = &key_type_user;
>>  		set_key = set_key_user;
>> -#if defined(CONFIG_ENCRYPTED_KEYS) || defined(CONFIG_ENCRYPTED_KEYS_MODULE)
>> -	} else if (!strncmp(key_string, "encrypted:", key_desc - key_string + 1)) {
>> +	} else if (IS_ENABLED(CONFIG_ENCRYPTED_KEYS) &&
>> +		   !strncmp(key_string, "encrypted:", key_desc - key_string + 1)) {
>>  		type = &key_type_encrypted;
>>  		set_key = set_key_encrypted;
>> -#endif
>>  	} else {
>>  		return -EINVAL;
>>  	}
>> -- 
>> 2.30.0
>>
> 
> I could be mistaken but the point of the previous way used to enable
> this code was to not compile the code at all.  How you have it, the
> branch just isn't taken but the compiled code is left to bloat dm-crypt.
> 
> Why not leave this as is and follow same pattern in your next patch?

It's safe to assume the compiler will constant-fold the resulting if (0) away.
The kernel coding style documentation got a section on that:
https://www.kernel.org/doc/html/v5.11-rc6/process/coding-style.html#conditional-compilation

Cheers,
Ahmad

> 
> Mike
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
