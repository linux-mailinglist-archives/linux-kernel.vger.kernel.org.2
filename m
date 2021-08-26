Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816B63F8978
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242779AbhHZN5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbhHZN5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:57:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD97C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:56:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p38so7192329lfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=inSQQWtosadfeXbuqdhztupZ5LIFfVJTnI1NgiofxkU=;
        b=hJAaLnSJW95gQ9a4hYnI1R9hilGcFcyVP5cxnDEI3ak2LB3BcnX4X0mhIyKYgLUfXr
         8X5CAFC7jpEim5N2Z2grxemB2FnO+9Nyb4r7McoADFf/NdlUnBhnBcI2swBXXlnFB+ku
         swT9VsNOXJFjSOUCQYqZNOKOuUUzhzN3qpPxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=inSQQWtosadfeXbuqdhztupZ5LIFfVJTnI1NgiofxkU=;
        b=NVMzI2I8KEwLLmtAPxvgKA2wvjFv+fiNIFkoMd8qDs7ddxESNz9OR5WtOV808eHEo1
         rED7su03R5CetLG/DLgDIOru2/zPRSV4m5kownRdBDiUtLeQGcfiqaDR4gr3S/PMXJfY
         uUfa8oGt6sZ8q6xlCzm1SgB6xAswn3sEkzm+79z5RiTHCJ3/dOTmxa18rHbCOWslrAyU
         dpF7mcXWIoqgzHtIWnRqHK7tNqX3x/FO+6GyipUDkXXNgvNpn0v5PvMF9DV8e/X8q7ua
         hzIlTMWvMLnf3nxxo07EHLl+M6sJq4Lli2nplgWl2sl3K6HTy2PO9E7pg2wqLw271H0u
         8lcQ==
X-Gm-Message-State: AOAM531e4lf7XjUUzNfsLsUihbF0oDVExd915HCfwpOqWafLVC7Opaws
        7Fh0D2zXejHgfafShO2JD0jFaw==
X-Google-Smtp-Source: ABdhPJz1wR7YLi9e9bs39a6MDzFS0wTDZwXol9pXdx9n5BXXYbTm1pRCBsbbfzAXTfy4EqeyVBkJOg==
X-Received: by 2002:a05:6512:1583:: with SMTP id bp3mr2879006lfb.122.1629986209710;
        Thu, 26 Aug 2021 06:56:49 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x26sm324208lfu.206.2021.08.26.06.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 06:56:49 -0700 (PDT)
Subject: Re: "BUG: Invalid wait context" in ls_extirq_set_type
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Esben Haabendal <esben@geanix.com>
References: <20210825135438.ubcuxm5vctt6ne2q@skbuf>
 <26de7b85-e466-e9af-077a-9d1dc087e061@rasmusvillemoes.dk>
 <20210826133355.lbb26bdf4ov5jjyp@skbuf>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <42b39571-0c76-2cfe-20d2-6c67259117b5@rasmusvillemoes.dk>
Date:   Thu, 26 Aug 2021 15:56:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210826133355.lbb26bdf4ov5jjyp@skbuf>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2021 15.33, Vladimir Oltean wrote:
> On Thu, Aug 26, 2021 at 11:01:31AM +0200, Rasmus Villemoes wrote:

>> So, we've been using the irq-ls-extirq driver for years, on an RT
>> kernel, without seeing something like that. Does it require certain
>> debug knobs in .config? Or perhaps the sanity checks have been added
>> later, we've mostly been using it on 4.14.y and 4.19.y.
> 
> Grepping for "BUG: Invalid wait context" in the kernel yields a single
> hit, and answers both questions. It was added by commit
> 
> commit de8f5e4f2dc1f032b46afda0a78cab5456974f89
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Sat Mar 21 12:26:01 2020 +0100
> 
>     lockdep: Introduce wait-type checks
> 
>     Extend lockdep to validate lock wait-type context.
> 
> and selectable via "config PROVE_RAW_LOCK_NESTING".

OK, thanks. Yes, that explains it.

>>
>> I don't know what the right fix is. Am I right when a say that for !RT,
>> spinlock==raw_spinlock? If so, switching regmap's spinlock to
>> raw_spinlock would be nop for !RT and fix this issue, but would of
>> course have quite far-reaching effects on RT kernels.
> 
> far-reaching? Explain?

I was "suggesting" (or more accurately just considering the implications
of) _switching_ the core regmap code to use a raw spinlock
unconditionally for its "fast io" case. A change that would affect all
such regmaps throughout the kernel. Thus far-reaching (though IIUC a nop
for !RT).

> It is _a_single_register_, accessed once per IRQ line, all at consumer driver probe time
> (typically boot time).
> 

I know, I wrote the driver, and our platform is also a ls1021a.

> We are not switching regmap from normal to raw spinlocks, we are just
> adding the option for raw spinlocks for this one register.
> 
>> Perhaps it's silly for the driver to use syscon's regmap to access that
>> single register, maybe it should just iomap it itself, and protect
>> access with a raw_spinlock of its own. While syscon's regmap would cover
>> that intpcr register, nobody else would ever access it, so that should
>> work fine.
> 
> I believe my competence ends here, I will re-read Arnd's email too, but
> I just don't see how the syscon API gives you something that is "not a
> regmap", something you can ioremap yourself as a consumer driver.

Surely the driver could be rewritten to be completely ignorant of the
containing scfg node and just iomap the register itself.

Yes, there'd probably also be a syscon driver with a regmap covering
                     reg = <0x0 0x1570000 0x0 0x10000>, but none of the
potential other consumers of that regmap would write to intpcr through
that regmap, since intpcr is solely of use to ls-extirq. So the
ls-extirq driver could just have its own raw spinlock in "struct
ls_extirq_data" next to a "void __iomem *" pointer, replacing the
"struct regmap *syscon;" member.

Rasmus
