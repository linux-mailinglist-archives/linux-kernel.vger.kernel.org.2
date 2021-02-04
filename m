Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718B330F9F0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbhBDRjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238687AbhBDRiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:38:00 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2609C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 09:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=jLr39R/PL4TXbdpUeMm23Ng8ji1D7NXqkZRxcSPStYk=; b=JSNTrF/QiJP5oayE8kXQWsi36+
        3TL0RhCPQ1W+8/ZGOH/BNcXuOpH4k4CJllTjYrk3UU3Hd0u6EJF4IP+BUNJXLkzqyyZ9gqNbbXUho
        FtQCoYIZhtsRc7B15tSquOVhExa6TkwEqKDPJHy5DmXTyyuGRob7rG8vFNyKgznqDex6zrJ+eqtBB
        JTI9vDbkNwwFYTkqAQsY/+/4k7NvwNwQAYOzGdCj+qPPJ/r+KJwKcEOFKLjuBRpGXUih8TLit/4k9
        uEwwS27KxJyKJheMnvwpYDWYTNgKwuwv84ktMyLv9vObYB49mJpeNuS8P6K+wcI1nY0Px8Zc+ESt9
        3Gvs+Wog==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7iZB-0003JC-G8; Thu, 04 Feb 2021 17:37:17 +0000
Subject: Re: [PATCH] x86: Add a prompt for HPET_EMULATE_RTC
To:     "Anand K. Mistry" <amistry@google.com>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210204132043.1.I2392cf11fb353d10459958100b69d93346fa167c@changeid>
 <ec6caa23-28d6-9695-2b0f-b3ba9ef28b60@infradead.org>
 <CAATStaMRHai=jWr4x1cZVs2MrME+1QSqoXD75xAOQfxb723hQQ@mail.gmail.com>
 <507e5062-f575-e034-d6fa-f1dca4bbbcc9@infradead.org>
 <CAATStaNxPwkVGUxTMUP+GdD+y=die7hZxYFaugwTNJ3c7W=PGA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <586ac6a2-0b2b-1f15-47f6-8c42444133be@infradead.org>
Date:   Thu, 4 Feb 2021 09:37:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAATStaNxPwkVGUxTMUP+GdD+y=die7hZxYFaugwTNJ3c7W=PGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 10:55 PM, Anand K. Mistry wrote:
> On Thu, 4 Feb 2021 at 17:30, Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 2/3/21 10:13 PM, Anand K. Mistry wrote:
>>>> Hi,
>>>>
>>>> When you run "make olddefconfig", should this "depends on"
>>>> line evaluate to true or false?
>>>
>>> True. RTC_DRV_CMOS=y by default on x86 systems and HPET_TIMER also
>>> appears to default yes (on x86-64 if I'm reading this right).
>>>
>>> Oddly, the RTC config option doesn't appear to exist. Probably a separate issue.
>>
>> Yes, just a separate simple patch.
>>
>>>> I.e., what are the settings of these symbols in the old .config file?
>>>>
>>>>
>>>>         depends on HPET_TIMER && (RTC=y || RTC=m || RTC_DRV_CMOS=m || RTC_DRV_CMOS=y)
>>>
>>> Actually, none of these options are set in the old config.
>>> RTC_DRV_CMOS and HPET_TIMER appear to default to yes.
>>>
>>>  % grep HPET .config
>>> CONFIG_HPET=y
>>> # CONFIG_HPET_EMULATE_RTC is not set
>>> # CONFIG_HPET_MMAP is not set
>>>  % grep RTC .config
>>> CONFIG_RTC_CLASS=y
>>> # CONFIG_HPET_EMULATE_RTC is not set
>>> CONFIG_PM_TRACE_RTC=y
>>> # CONFIG_RTC_HCTOSYS is not set
>>>
>>>>
>>>> If not, is there some out-of-tree driver involved?
>>>
>>> No out of tree drivers involved. I tried this on a vanilla 5.11-rc6.
>>>
>>>> I'm having a little trouble seeing why this is needed.
>>>
>>> So am I. But this is the magic that lets me keep
>>> CONFIG_HPET_EMULATE_RTC from the old config. I did manage to trace
>>> where the option is being overridden in the conf tool, but the
>>> reasoning why is beyond my knowledge.
>>
>> Can you post the .config that you are feeding to 'make olddefconfig', please.
>> I'll take a look (or the x86 guys can do so).
> 
> Sure. Here it is:

Hi,

On plain vanilla 5.11-rc6, when I take this (partial) .config file
which contains:

CONFIG_HPET=y
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_HPET_MMAP is not set

and run
$ make olddefconfig

my new .config file contains

CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set


Isn't that what you are expecting?
or are you trying to keep the opposite?

# CONFIG_HPET_EMULATE_RTC is not set

Hm, I bet that I misunderstood you and you want to keep
it disabled. Is that right?

-- 
~Randy

