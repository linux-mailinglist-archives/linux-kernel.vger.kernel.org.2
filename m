Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4568936218A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 15:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbhDPN45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 09:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDPN44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 09:56:56 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE70C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 06:56:30 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 18so12002845qkl.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2QGm2sRtCil5mHsgQxFQfGnF3vI93kskrsLNMDWKvsk=;
        b=dA4EiF/YysshkLiS492NIUABBLcT4oN+U26fu9zAYuhQKhAM7566q6TihEkH03Uxpi
         4y3perir6E8QMrVebawv9tkID0z4VIXVPA/J5z+90OWzNwWNEvq0orAfJqqU2aLq29PI
         EiO0PCQ1caux9pF+8McAh9cL5Vkj2HM1Ly7G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2QGm2sRtCil5mHsgQxFQfGnF3vI93kskrsLNMDWKvsk=;
        b=IXti4qXH6l4+3R2jU6vh0fhRrUrTWJR2XJaJpqM+K+Jl/zdEx4sTn6HfSbfsUOmKse
         R3k4i4kL7x9C1S76BN4iNmktobou88lZPPkYuTHdRpBU9K9qPdix8qmq/LgrfJ9yrEzc
         4Yy582Iv+Db5zPEBWU4GqqOZdGYwS4dA/8G1OTxNlsUlaR2lb0re0UMQqkB968+UhdLH
         vkIyK9yxUwyKqCDz9YB0JSx7RDri3y2A8xhgF7V0kkXzr91FQ4ek3yLKx8U1VBhi7Wxk
         oVWFRIHO1DH2fPFC58z3oQr0KX+HGrDb3IKEMDI/UdGZYpu6y5ptvBcnUkPRhvkh0qgw
         laAA==
X-Gm-Message-State: AOAM531CypRgUaYcJP6kpkKuI8IFfGjLx7bq3jiTF36oBqZYe2liw7rC
        aWIjavqV2m7pm6jd2ZjsXbWM2w==
X-Google-Smtp-Source: ABdhPJw1RpdhhYzBbnWku3IXzOG5OBordjjGxcdg7skJaSifLZBYQlBobyX59Hb3fLU11gb9iFnJlA==
X-Received: by 2002:a37:71c3:: with SMTP id m186mr8764641qkc.453.1618581389958;
        Fri, 16 Apr 2021 06:56:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:27c])
        by smtp.gmail.com with ESMTPSA id m11sm3941002qtg.67.2021.04.16.06.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 06:56:29 -0700 (PDT)
Date:   Fri, 16 Apr 2021 14:56:27 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YHmXi303WxVZzVwI@chrisdown.name>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
 <YFDAfPCnS204jiD5@chrisdown.name>
 <YFHAdUB4lu4mJ9Ar@alley>
 <5ea3b634-5467-35cf-dd08-1001f878b569@rasmusvillemoes.dk>
 <YFMvfawY+0CncS8G@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YFMvfawY+0CncS8G@alley>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Petr, Rasmus,

Apologies for the delay, I've been out ill for a while so I'm just coming back 
to look at this.

Petr Mladek writes:
>> Anyway, on to the other thing I mentioned on dev_err and friends: I
>> think it would improve readability and make it a lot easier to (probably
>> in a later patch) add support for all those dev_* and net_* and whatever
>> other subsystems have their own wrappers
>
>This is great point! There are many other subsystem specific wrappers,
>e,g, ata_dev_printk(), netdev_printk(), snd_printk(), dprintk().
>We should make it easy to index them as well.

These would be nice to have, but we should agree about how we store things 
internally.

For example, in printk we typically store the level inline as part of the 
format string at compile time. However, for `dev_printk`, it's passed entirely 
separately from the format string after preprocessing is already concluded (or 
at least, not in a way we can easily parse it the same way we do for 
printk()):

	void dev_printk(const char *level, const struct device *dev, const char *fmt, ...)

One (ugly) way to handle this would be to have a new "level" field in the 
printk index entry, with semantics that if it's some sentinel value, look at 
the format itself for the format, otherwise if it's some other value, the level 
field itself is the level.

This will work, but it's pretty ugly. Any better suggestions? :-)

Thanks,

Chris
