Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5023887EB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbhESHAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 03:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238803AbhESHA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 03:00:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB47DC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 23:59:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u21so18308688ejo.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 23:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o/3atY80Apw/f8q0aQiszBam6eib+C5f08kR6y1gnvc=;
        b=Ae5CBveUb+AV9JgMnk9qpIbvHuehsD9sKq3U294607Cw0UDS4kR0GDCyEBdybVdynl
         jzzS7y4dalJxVZv5ztr1AGe/4o2kWlbsHTUv51umYHqjVwh3uszO194sr3HOLssF32La
         DwUqRI3gm+E5479Xlxl7DZkgbaE4eP6eYERJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o/3atY80Apw/f8q0aQiszBam6eib+C5f08kR6y1gnvc=;
        b=pPAdLn5ekmjwli0uNc65OXJY8ddIFhT9EE+6xXQqBPFs2y87U1L1DCwj+YbKZjS7Jp
         8DoKVklEv/A0xYE9MmtFUICREFDK4sVv8vuipK3gYgRGdP9InfeyaFAvRupBXHh/AOxn
         5JQGa9/2HVhI7ZVQxsXUjk3aISgsrZpsgHYBQG+7VJJYBT/mFywQcmemXshuS0IrwUjN
         umnjPhOzru/+JND57KOuOZ6/qhGtXuRrIaa+3/BHErN1ZgCf9dTVijkJ4L9O4/bRq4xg
         4WP4FToL47AXsYKdH4LrGJ86d+iZUdnv3MzVcmSfngVraffgaJhwALtrdC8WIkkS9e5I
         8WPQ==
X-Gm-Message-State: AOAM532LQAWsaSX20RfEX3armqab5kN29fG3fnOH/C/ch7sKZHue8s1Q
        ZyfA77CeqV9TN7vzQmOSYDiLJw==
X-Google-Smtp-Source: ABdhPJxkNsmeRlpLb4+kB3Z1P17IOZWb0Whz4yT+S5ECM7tQy7qUiAacXQm/OtyiRk+zVOTY72QqGA==
X-Received: by 2002:a17:906:d1ce:: with SMTP id bs14mr10969383ejb.183.1621407547493;
        Tue, 18 May 2021 23:59:07 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id f7sm15251885edd.5.2021.05.18.23.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 23:59:06 -0700 (PDT)
Subject: Re: [PATCH v6 3/4] printk: Userspace format indexing support
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
References: <cover.1621338324.git.chris@chrisdown.name>
 <05d25c65d3f5149c1e8537f74041a7a46bd489d6.1621338324.git.chris@chrisdown.name>
 <YKPBk+7lTzs8WFAk@smile.fi.intel.com> <YKPKMCNz2hccaXfR@chrisdown.name>
 <YKPkkiCX6gdSa/rI@smile.fi.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <bdbcf438-50d3-7429-36e8-c077e31bc695@rasmusvillemoes.dk>
Date:   Wed, 19 May 2021 08:59:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKPkkiCX6gdSa/rI@smile.fi.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2021 18.00, Andy Shevchenko wrote:
> On Tue, May 18, 2021 at 03:07:44PM +0100, Chris Down wrote:
>> Andy Shevchenko writes:
> 
> ...
> 
>>>> +	return mod ? mod->name : "vmlinux";
>>>
>>> First of all, you have several occurrences of the "vmlinux" literal.
>>> Second, can't you get it from somewhere else? Is it even guaranteed that the
>>> name is always the same?
>>
>> Hmm, I don't know if it's guaranteed, but we already have similar logic in
>> (as one example) livepatch, which seems to suggest it's not obviously wrong:
>>
>>     % grep -R '"vmlinux"' kernel/livepatch/
>>     kernel/livepatch/core.c:                       sympos, name, objname ? objname : "vmlinux");
>>     kernel/livepatch/core.c:        bool sec_vmlinux = !strcmp(sec_objname, "vmlinux");
>>     kernel/livepatch/core.c:                sym_vmlinux = !strcmp(sym_objname, "vmlinux");
>>     kernel/livepatch/core.c:        if (strcmp(objname ? objname : "vmlinux", sec_objname))
>>     kernel/livepatch/core.c:        name = klp_is_module(obj) ? obj->name : "vmlinux";
>>     kernel/livepatch/core.c:                                klp_is_module(obj) ? obj->name : "vmlinux");
>>     kernel/livepatch/core.c:                                klp_is_module(obj) ? obj->name : "vmlinux");
>>     kernel/livepatch/core.c:        if (!strcmp(mod->name, "vmlinux")) {
>>
>> Is there another name or method you'd prefer? :-)
>>
>> As for the literals, are you saying that you prefer that it's symbolised as
>> a macro or static char, or do you know of an API where this kind of name can
>> be canonically accessed?
> 
> I have heard that modern GCC (at least) can utilize same constant literals in a
> single compilation unit, so it won't be duplicated.

Yes, except it's not gcc but ld, string deduplication happens across
compilation units, and "modern" isn't required, SHF_STRINGS and
SHF_MERGE have been part of the ELF spec for decades, with support in
binutils landing around 2001-04-13 AFAICT.

IOW, don't uglify the code by introducing macros or const char[]
objects. Using string literals is just fine.

> 
>>>> +static int __init pi_init(void)
> 
>>> No __exit? (There is a corresponding call for exit)
>>
>> Hmm, can't printk only be built in to the kernel, so it can't be unloaded?
>> At least it looks that way from Kconfig. Maybe I'm missing something and
>> there's some other way that might be invoked?
> 
> While it's true, it may help in these cases:
>  1) getting things done in a clean way

Huh?

>  2) finding bugs during boot cycle

What bugs would code that doesn't get executed find?

>  3) (possibly) making better debugging in virtual environments

How?

>  4) (also possibly) clean up something which shouldn't be seen by the next
>     (unsecure) kernel, like kexec.

Tearing down a few debugfs files wouldn't touch a lot of memory, the
printk format strings are very unlikely to be sensitive, and I highly
doubt __exit code is kept around and run at kexec time anyway.

IOW, please do not bloat the kernel image with __exit code in things
which cannot be built modular.

Rasmus
