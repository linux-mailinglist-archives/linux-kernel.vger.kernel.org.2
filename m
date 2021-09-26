Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B348418A49
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 19:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhIZRLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 13:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhIZRLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 13:11:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CD9C061570;
        Sun, 26 Sep 2021 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=8xm+rGDse6q9JwU1HkWon/HXSZnwNhXHD3Oohc+oN0M=; b=CDI78vlhTXzyRrfBjOgYktwv8O
        1ngY7ltOZCG2ryxEQ4jiQ9BpK0ShCju5f6JHIlLoPvRfkC6qUTKfQugnHD3xQNGZ0iNZKKsfLglFL
        DOii2wdwooqzj8hKs4VVJsmKXbBHBaNdHv9nEdXMFhLp6xgFNzelnkWAHchMXzkbHBUjw0GZ9VLkE
        F/3fJoMmvv8DoIiE+5jKF4KltVJO7smZ2hz+Hojz4GuSUPSH/JzWbXsGTIk5W3vKrJvJEZfGCK7yi
        g1Sp+4khrP9+WG2FykfRyvmVVWGBY1oSQxqngWtiaJv27TXAAY/JdbltDu3gpxNW/Vc+Deg+Y9UHb
        cdMFvJkA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUXfG-000qnW-F4; Sun, 26 Sep 2021 17:10:10 +0000
Subject: Re: [PATCH] ia64: don't do IA64_CMPXCHG_DEBUG without CONFIG_PRINTK
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-ia64@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Chris Down <chris@chrisdown.name>
References: <20210926063325.13581-1-rdunlap@infradead.org>
 <6ee982ca-6b99-da23-ec60-97ca2c317bd5@physik.fu-berlin.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bf2568fa-86ae-79d5-750b-76d76d233126@infradead.org>
Date:   Sun, 26 Sep 2021 10:10:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6ee982ca-6b99-da23-ec60-97ca2c317bd5@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/21 2:10 AM, John Paul Adrian Glaubitz wrote:
> Hi Randy!
> 
> On 9/26/21 08:33, Randy Dunlap wrote:
>> When CONFIG_PRINTK is not set, the CMPXCHG_BUGCHECK() macro calls
>> _printk(), but _printk() is a static inline function, not available
>> as an extern.
>> Since the purpose of the macro is to print the BUGCHECK info,
>> make this config option depend on PRINTK.
>>
>> Fixes multiple occurrences of this build error:
>>
>> ../include/linux/printk.h:208:5: error: static declaration of '_printk' follows non-static declaration
>>    208 | int _printk(const char *s, ...)
>>        |     ^~~~~~~
>> In file included from ../arch/ia64/include/asm/cmpxchg.h:5,
>> ../arch/ia64/include/uapi/asm/cmpxchg.h:146:28: note: previous declaration of '_printk' with type 'int(const char *, ...)'
>>    146 |                 extern int _printk(const char *fmt, ...);
>>
>> Fixes: 337015573718 ("printk: Userspace format indexing support")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: linux-ia64@vger.kernel.org
>> Cc: Petr Mladek <pmladek@suse.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Cc: Chris Down <chris@chrisdown.name>
>> ---
>>   arch/ia64/Kconfig.debug |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- linux-next-20210917.orig/arch/ia64/Kconfig.debug
>> +++ linux-next-20210917/arch/ia64/Kconfig.debug
>> @@ -39,7 +39,7 @@ config DISABLE_VHPT
>>   
>>   config IA64_DEBUG_CMPXCHG
>>   	bool "Turn on compare-and-exchange bug checking (slow!)"
>> -	depends on DEBUG_KERNEL
>> +	depends on DEBUG_KERNEL && PRINTK
>>   	help
>>   	  Selecting this option turns on bug checking for the IA-64
>>   	  compare-and-exchange instructions.  This is slow!  Itaniums
> 
> We currently don't have a maintainer for ia64 - although I would be willing to pick
> up the job - so your patch would have to go through someone else's tree.

Yes, I know about no-maintainer. That's why Andrew is cc-ed on this.
(or even Peter could merge it.)

> I can boot test the patch on my RX2660 in the mean time.


and Chris wrote:

> This Fixes tag doesn't make much sense. This was already broken long before that patch, just the error message changed: printk() was already static inline on !CONFIG_PRINTK for eons. 

OK, I corrected that for v2. Thanks.

-- 
~Randy
