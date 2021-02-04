Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD5A30EC81
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 07:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhBDGap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 01:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhBDGan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 01:30:43 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4317C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 22:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=FgYRpKKDVxXJJLQv3gWCibfvKyrU+xlSM4XgTM+S+1Y=; b=1oBAJMlpXUPkfk02bOs75qPtU4
        bRVh+fCr2W/eB5K6D57BxbWpZ7Xy14xhfTopIfKd/lnj3lHxo2O7SbXJp4rySpZ7DgJf/vDDqUe3J
        09azH8VifA79MkGSO56fGC4SED44QQij8X6L6/HJahk3LUpWBFTL96HaX+2QMR11RXn3ylXqi60Qz
        8EZMQ+yUrMh8iWEO+8WTbPFYlnXmgM7OFJj164TX74YMuKIReTL1DrY+/2eZDLi8axMKilC+XIf8a
        z5A8cKixqvFCHif9tV6v4UKA6Gv5w+E8G0RcYMpKvWo83A/fGw+UrVVD8Aos8V+iX9tXrYg2suyRs
        1MGMdyzA==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7Y9P-0000cB-V9; Thu, 04 Feb 2021 06:30:00 +0000
Subject: Re: [PATCH] x86: Add a prompt for HPET_EMULATE_RTC
To:     "Anand K. Mistry" <amistry@google.com>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210204132043.1.I2392cf11fb353d10459958100b69d93346fa167c@changeid>
 <ec6caa23-28d6-9695-2b0f-b3ba9ef28b60@infradead.org>
 <CAATStaMRHai=jWr4x1cZVs2MrME+1QSqoXD75xAOQfxb723hQQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <507e5062-f575-e034-d6fa-f1dca4bbbcc9@infradead.org>
Date:   Wed, 3 Feb 2021 22:29:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAATStaMRHai=jWr4x1cZVs2MrME+1QSqoXD75xAOQfxb723hQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 10:13 PM, Anand K. Mistry wrote:
>> Hi,
>>
>> When you run "make olddefconfig", should this "depends on"
>> line evaluate to true or false?
> 
> True. RTC_DRV_CMOS=y by default on x86 systems and HPET_TIMER also
> appears to default yes (on x86-64 if I'm reading this right).
> 
> Oddly, the RTC config option doesn't appear to exist. Probably a separate issue.

Yes, just a separate simple patch.

>> I.e., what are the settings of these symbols in the old .config file?
>>
>>
>>         depends on HPET_TIMER && (RTC=y || RTC=m || RTC_DRV_CMOS=m || RTC_DRV_CMOS=y)
> 
> Actually, none of these options are set in the old config.
> RTC_DRV_CMOS and HPET_TIMER appear to default to yes.
> 
>  % grep HPET .config
> CONFIG_HPET=y
> # CONFIG_HPET_EMULATE_RTC is not set
> # CONFIG_HPET_MMAP is not set
>  % grep RTC .config
> CONFIG_RTC_CLASS=y
> # CONFIG_HPET_EMULATE_RTC is not set
> CONFIG_PM_TRACE_RTC=y
> # CONFIG_RTC_HCTOSYS is not set
> 
>>
>> If not, is there some out-of-tree driver involved?
> 
> No out of tree drivers involved. I tried this on a vanilla 5.11-rc6.
> 
>> I'm having a little trouble seeing why this is needed.
> 
> So am I. But this is the magic that lets me keep
> CONFIG_HPET_EMULATE_RTC from the old config. I did manage to trace
> where the option is being overridden in the conf tool, but the
> reasoning why is beyond my knowledge.

Can you post the .config that you are feeding to 'make olddefconfig', please.
I'll take a look (or the x86 guys can do so).


thanks.
-- 
~Randy

