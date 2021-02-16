Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC6731D1D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 22:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhBPVGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 16:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBPVGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 16:06:31 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC03EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 13:05:50 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n10so81410wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 13:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L1rdvx4z/ptc857CA7B6CcX99owPuUmGCU5Rbtb5uRg=;
        b=YMISgFeeOPogp5tH31t12LjNe3UKrfX8vSz0z5kbcX+ojZIapz5R/kFT3/1bxrPi0k
         ze4T88SeYljzNOG73vHYDV8raHaXXVdTJZjwi+l6SkTys52tJ2X3zLsf0khP0SSq6wDo
         rpwvzYdRKlR01NRPvURQiljWJ29o6MWdKithc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L1rdvx4z/ptc857CA7B6CcX99owPuUmGCU5Rbtb5uRg=;
        b=RejL7KEqkf0zFIY2moYh528xCRuthskNFJ/VqRfwpHFaC51EQvkTkLXcLYErnPsBA5
         v7G/mP1cRAYJmGUhzVAdaFXsNUcs/ef4aLmhDam8RmemdOrELyvjhsVUBQjnfIv1ZQ1T
         zqf+RAF8ZUBVGmICaQyvb9HKRdDhiYvraolS0HdUj1hSe+r3/FPSfQTFObMg2jyOaY4k
         laxqlkU3U3zeDV0kYEG3Be5x9IihHUjUnC001R9x95L/Xq3fPglFyLgYqFdpHtiK+Rl6
         sFFaTOMZTVSzyu231TNOY/n5aqTvRiFZlYd3agIRrGNK9dmHIVNrKgfwm35DVhD5fScU
         3JDg==
X-Gm-Message-State: AOAM532FGakUuosRETplosX/Cb3w1H2znrTMzGckVNlUPDzuCq29dkZA
        ZdU7db/C4hy8cbitH4dBaVWEbg==
X-Google-Smtp-Source: ABdhPJz31UTOiwrUynSRe+NTXhS8zzzhFGq9ib1RLd96SPtpNcAQg5Mr+9IBnYH8N5Usch3HpIlY/Q==
X-Received: by 2002:a1c:e446:: with SMTP id b67mr193910wmh.65.1613509549346;
        Tue, 16 Feb 2021 13:05:49 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:76fd])
        by smtp.gmail.com with ESMTPSA id z5sm18945wrn.8.2021.02.16.13.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 13:05:49 -0800 (PST)
Date:   Tue, 16 Feb 2021 21:05:48 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: code style: Re: [PATCH v4] printk: Userspace format enumeration
 support
Message-ID: <YCwzrLTaE9PwNihj@chrisdown.name>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCv9Xb7ePnDy9xRf@alley>
 <YCwAbGoVuZJspcx5@chrisdown.name>
 <YCwycC8hPsPD7ArU@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YCwycC8hPsPD7ArU@cmpxchg.org>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner writes:
>On Tue, Feb 16, 2021 at 05:27:08PM +0000, Chris Down wrote:
>> Petr Mladek writes:
>> > I wonder if we could find a better name for the configure switch.
>> > I have troubles to imagine what printk enumeration might mean.
>> > Well, it might be because I am not a native speaker.
>> >
>> > Anyway, the word "enumeration" is used only in the configure option.
>> > Everything else is "printk_fmt"
>> >
>> > What about DEBUG_PRINTK_FORMATS?
>>
>> Hmm, I don't like DEBUG_PRINTK_FMTS because it's not about debugging, it's
>> about enumeration, I guess :-)
>>
>> The name should reflect that this catalogues the available printks in the
>> kernel -- "debugging" seems to imply something different.
>>
>> I'm ok with a different name like "printk catalogue" or something like that
>> if you prefer. Personally I think "printk enumeration" is fairly clear --
>> it's about enumerating the available printks -- but anything that captures
>> that spirit is fine.
>
>How about config PRINTK_INDEX?

Ah yes, I also like that. PRINTK_INDEX is fine from my perspective and is more 
straightforward than "enumeration", thanks.
