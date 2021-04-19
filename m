Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148A0363C76
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbhDSH2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhDSH2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:28:15 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56654C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:27:46 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sd23so42658278ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=khlBaKC7Uy9m/TB2qiaU47Jt52mOQ1eZT3K5qpMQi88=;
        b=VMVm8buPK2gHdN1NsyeBJnh6P9Bwb+PhqlyavTBc3y85dK7c7NBRx4gtn135f/VN9K
         8KskdsIZOgRHZIKeiJMGhSzKDkKsOy4cRzcm/5AlMIB0dP/2hPwgwm6qk6WMvB0y844W
         mpBVbx1gXhLabawKEBRCDH01s4KX1JxOMtzdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=khlBaKC7Uy9m/TB2qiaU47Jt52mOQ1eZT3K5qpMQi88=;
        b=mnjTJWYxqWUb6VswQ/lm33cw8UPKEMhsGJzrSnpmQF8Sz3j+KyHSPHVgi0TOnGgO6K
         Ppm6A3xKhjoZKqFPfXFS6UdaGAaoiE/aXHiSzk8TTQAFxwK7Ik1Z9sMACWiJdFI+uMw8
         rtAVa024J/c9ZIVD4FENoTpOR/WrLIUwsw/fJyHCGuwhq9zYcORQwos40yVkPyiLD1rL
         adEhzyjprMqf/jzwwuBV/tcWQ4f5YB313/tr3Zp6K6nhdDUW63KhEVU0MdU5J3kPplQX
         ibQBvxZRMa6XTHCEp6EaFPmgeC2OTU6Ky/LfFWo7imTY2e/atYudotmRyDekOH9PeH89
         6VlA==
X-Gm-Message-State: AOAM5310hNvw3qWSixmdnVZUDCaoO7J/k8qFId2k8exYL/Cz5dlvMvHg
        c9apiEscvY88+gOrCljkr+PRpA==
X-Google-Smtp-Source: ABdhPJwUEqZdxq6cJdqX7ypVkC18j50D3KiRw3sYJZCb+S6kTAdkx0nsGfzdR7epUTJVI3yGheZdNA==
X-Received: by 2002:a17:906:3ce9:: with SMTP id d9mr20613728ejh.172.1618817265108;
        Mon, 19 Apr 2021 00:27:45 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id p2sm9769023ejo.108.2021.04.19.00.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 00:27:44 -0700 (PDT)
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
To:     Chris Down <chris@chrisdown.name>, Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
 <YFDAfPCnS204jiD5@chrisdown.name> <YFHAdUB4lu4mJ9Ar@alley>
 <5ea3b634-5467-35cf-dd08-1001f878b569@rasmusvillemoes.dk>
 <YFMvfawY+0CncS8G@alley> <YHmXi303WxVZzVwI@chrisdown.name>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e9f74575-1ba0-0c06-b370-59d151c72ed6@rasmusvillemoes.dk>
Date:   Mon, 19 Apr 2021 09:27:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YHmXi303WxVZzVwI@chrisdown.name>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2021 15.56, Chris Down wrote:
> Hey Petr, Rasmus,

>> This is great point! There are many other subsystem specific wrappers,
>> e,g, ata_dev_printk(), netdev_printk(), snd_printk(), dprintk().
>> We should make it easy to index them as well.
> 
> These would be nice to have, but we should agree about how we store
> things internally.
> 
> For example, in printk we typically store the level inline as part of
> the format string at compile time. However, for `dev_printk`, it's
> passed entirely separately from the format string after preprocessing is
> already concluded (or at least, not in a way we can easily parse it the
> same way we do for printk()):
> 
>     void dev_printk(const char *level, const struct device *dev, const
> char *fmt, ...)

Hm, yeah, for "naked" dev_printk() calls there's no easy way to grab the
level, for dev_err and friends it's somewhat easier as you could just
hook into the definition of the dev_err macro. I'm not saying you need
to handle everything at once, but doing dev_err and netdev_err would get
you a very long way

> One (ugly) way to handle this would be to have a new "level" field in
> the printk index entry, with semantics that if it's some sentinel value,
> look at the format itself for the format, otherwise if it's some other
> value, the level field itself is the level.
>
> This will work, but it's pretty ugly. Any better suggestions? :-)

Well, that was more or less exactly what I suggested when I wrote

> One could also record the function a format is being used with - without
> that, the display probably can't show a reasonable <level> for those
> dev_* function.

But, I think the real question is, why are we/you interested in the
level at all? Isn't the format string itself enough for the purpose of
tracking which printks have come and gone? IOW, what about, on the
display side, simply skipping over some KERN_* prefix if present?

Rasmus
