Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEB131EAFE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhBROdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 09:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbhBRMmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:42:22 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1311AC06178A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 04:41:41 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o82so3494924wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 04:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2yM4QIJUWbnv3qV7hB4p/81CEeJSilGooTOMXeB9PUs=;
        b=ZgM2FNfs7o9TAWAekIEDSwUHlRQJ/N6cfdg7dInG++laCTbXZDcPCcwEpAnqkQE5Xq
         bZybIRR8lSn+BT6HcZ2Xi3HWsdyPVwV4BtOPvGBrX9beN4qTvI2CuZVxt3+2UPlEDHcO
         xF24S8tJpaHtJ7EngNI+Acgobz1M8IEpuwC3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2yM4QIJUWbnv3qV7hB4p/81CEeJSilGooTOMXeB9PUs=;
        b=T6yvc0JehTO09COJ2nt3GshTSz3q3nIlLdMODRihNikmH47ediNid+TuGyR8+QOFg4
         o7TRMyM2T4k7HrNbN/JadUGIThpS/VTRTbzE9vWWfX0mB/TN7YkpCWv1AxaBBf/A+CyL
         9XVog8euXg7NSdaYpJxfUg2xYs1csaCxy3FU1QbwOqNlmiZkOauNoK4LfoZMxjfa/orI
         XmRQAuqoThyH+/ejvPp1OekIUkiErwjt43cy/e3nBpD2RxI9K46VX6+oFaLFQm6dOkZq
         5759Gahr0ubA/f9NLDpgALRtdbF4QgR+PZhnzjRAyRJ/vVdnEsXkm+NGdjWGmUZf07Qt
         A+ZQ==
X-Gm-Message-State: AOAM533DugjjEkoeuBY2R0XZLewdDfWjEyjqTN9qOJaRrBdGbCpccwJu
        tD5X7rJtRr/gaRtxDVbWSofaVw==
X-Google-Smtp-Source: ABdhPJwQMeBhuVXrSgkkQURsWUYGotN7xdnkauFq9ofOY1yaOMlv971ciD9cGMV+0Vw/Lkn1PJqjew==
X-Received: by 2002:a1c:60c1:: with SMTP id u184mr3515552wmb.22.1613652099731;
        Thu, 18 Feb 2021 04:41:39 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:f7e9])
        by smtp.gmail.com with ESMTPSA id o13sm9699836wro.15.2021.02.18.04.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 04:41:39 -0800 (PST)
Date:   Thu, 18 Feb 2021 12:41:39 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v4] printk: Userspace format enumeration support
Message-ID: <YC5ggyeC0uqtOD6R@chrisdown.name>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YC5b4+hTjrGwG22o@chrisdown.name>
 <YC5flsiUEZnPs7qz@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YC5flsiUEZnPs7qz@alley>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek writes:
>> - Move to another file, kernel/printk/debug_formats.c or similar
>
>Just to be sure. The filename should be ideally based on the configure
>option and API names, e.g. formats_index.c or so.
>
>The printk_ prefix is not strictly necessary. The file is in printk/
>directory. IMHO, we should have used ringbuffer.c but ...

Sure thing.

>> - Use `struct module *mod` instead of calling it module
>> - Add documentation for printk_fmt_sec (or whatever it will be called)
>> - Rename things to pf_, pi_, or something
>> - See if it's safe to pass a printk_fmt_sec to seq_file instead of a module
>
>Also it might be needed to store the pointer to struct module.

You mean, have a `struct module` entry for this? I somewhat suspect that 
module.c maintainers are not likely to be happy about injecting non-generic 
code into there if it's possible to be avoided, but maybe I'm misunderstanding? 

>Both things together might allow to remove the global hash table and likely
>even the mutex.
>
>> - Handle cont + level
>> - Don't expose level/KERN_SOH directly
>
>I can't remember anything else. I am curious how v5 would look like.

You can join the club on that one... ;-)

Let me know if I understood you correctly on the `struct module` point, and 
after that I'll start work on v5. Thanks!
