Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4213F398E5B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhFBPUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:20:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60064 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbhFBPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:20:14 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7569622D64;
        Wed,  2 Jun 2021 15:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622647109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZtBS4fx+lTzBrHRbz8ggAcz3XolLf1vUw2zGmkr8u4=;
        b=sr+QcvkL7fYlG7CsDsFiexBEfTyt58eZZPoYyxa/KxtdymxUt5mTC0JfOOj9Bi9fuNV79M
        NXxG01DtNpRSlHeNQCCOe9CGJ2+Luj7uEASQE1aHq3MpR9s110Wm8jnJOQ23vFKxVGRWJQ
        63tg7reRrxuQRRBwzYvdeavgAzBuuuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622647109;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZtBS4fx+lTzBrHRbz8ggAcz3XolLf1vUw2zGmkr8u4=;
        b=Jy1tGAiQeVFHsduDxPbljquxyI04oB0hKYEzdLxevuOBDewWHxUG2Q7GAlO1Q77Kkf8wXY
        v98MfTw+MznMC5Dw==
Received: by imap.suse.de (Postfix, from userid 51)
        id 6C68B11CD5; Wed,  2 Jun 2021 16:20:03 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id D7E5911DA4;
        Wed,  2 Jun 2021 10:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622630930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZtBS4fx+lTzBrHRbz8ggAcz3XolLf1vUw2zGmkr8u4=;
        b=YObkJak2xEKgggs+C041WX2XGHcsEw72USiZY+mFg/7g+68mL8bBON5F0wbC3spLTZ8iWU
        8NZtYfd1a3P8nyemKGYKfQK7M5xPVrpsFYOKJGhOjKMRRy0XHzfkiD+LS7byM2TWkxUGVn
        /f39pWCsFHjOi5pfhUcuwaChVb8QS9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622630930;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZtBS4fx+lTzBrHRbz8ggAcz3XolLf1vUw2zGmkr8u4=;
        b=3MSvg6W5KeWcdEP/VUkas4Qh/63MDJ/FsCIKQ/rz7Ms4uuOz5qNwmWKCLtH/ICp1Z2/OzS
        NcXNujrNccoXwSAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id lKMtNBFit2C0WgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 02 Jun 2021 10:48:49 +0000
Subject: Re: [PATCH v3 4/4] slub: Force on no_hash_pointers when slub_debug is
 enabled
To:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
References: <20210601182202.3011020-5-swboyd@chromium.org>
 <202106020644.UDFIJOUU-lkp@intel.com>
 <20210601172659.fd8c40a6548a1bd43be1bf11@linux-foundation.org>
 <CAE-0n50F0E706Hzu9KyR7+7NRG39f0Rn05XT9mi8ci8csenxtQ@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8a464fef-0530-aebf-5844-c8aaf2bf6f37@suse.cz>
Date:   Wed, 2 Jun 2021 12:48:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAE-0n50F0E706Hzu9KyR7+7NRG39f0Rn05XT9mi8ci8csenxtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/21 3:03 AM, Stephen Boyd wrote:
> Quoting Andrew Morton (2021-06-01 17:26:59)
>> On Wed, 2 Jun 2021 06:45:55 +0800 kernel test robot <lkp@intel.com> wrote:
>>
>> > >> mm/slub.c:4464:30: error: use of undeclared identifier 'slub_debug_enabled'
>> >            if (static_branch_unlikely(&slub_debug_enabled))
>> >                                        ^
>> > >> mm/slub.c:4464:30: error: use of undeclared identifier 'slub_debug_enabled'
>> > >> mm/slub.c:4464:30: error: use of undeclared identifier 'slub_debug_enabled'
>> > >> mm/slub.c:4464:30: error: use of undeclared identifier 'slub_debug_enabled'
>> > >> mm/slub.c:4464:6: error: invalid argument type 'void' to unary expression
>> >            if (static_branch_unlikely(&slub_debug_enabled))
>> >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Thanks.  Stephen, how about this?
> 
> Looks good to me. Thanks for the quick fix!
> 
>>
>> --- a/mm/slub.c~slub-force-on-no_hash_pointers-when-slub_debug-is-enabled-fix
>> +++ a/mm/slub.c
>> @@ -117,12 +117,26 @@
>>   */
>>
>>  #ifdef CONFIG_SLUB_DEBUG
>> +
>>  #ifdef CONFIG_SLUB_DEBUG_ON
>>  DEFINE_STATIC_KEY_TRUE(slub_debug_enabled);
>>  #else
>>  DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
>>  #endif
>> -#endif
>> +
>> +static inline bool __slub_debug_enabled(void)
>> +{
>> +       return static_branch_unlikely(&slub_debug_enabled);
> 
> To make this even better it could be
> 
> 	return static_branch_maybe(CONFIG_SLUB_DEBUG_ON, &slub_debug_enabled);
> 
>> +}
>> +
>> +#else          /* CONFIG_SLUB_DEBUG */
>> +
>> +static inline bool __slub_debug_enabled(void)
>> +{
>> +       return false;
>> +}
>> +
>> +#endif         /* CONFIG_SLUB_DEBUG */
>>
>>  static inline bool kmem_cache_debug(struct kmem_cache *s)
>>  {
>> @@ -4493,7 +4507,7 @@ void __init kmem_cache_init(void)
>>                 slub_max_order = 0;
>>
>>         /* Print slub debugging pointers without hashing */
>> -       if (static_branch_unlikely(&slub_debug_enabled))
>> +       if (__slub_debug_enabled())

A minimal fix would be to put this under #ifdef CONFIG_SLUB_DEBUG
and use static_key_enabled() as we don't need the jump label optimization for
init code. But the current fix works.

> 
> It would be super cool if static branches could be optimized out when
> they're never changed by any code, nor exported to code, just tested in
> conditions. I've no idea if that is the case though.
> 
>>                 no_hash_pointers_enable(NULL);
>>
>>         kmem_cache_node = &boot_kmem_cache_node;
> 

