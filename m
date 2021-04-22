Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A123682DF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhDVPAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhDVPAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:00:09 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70248C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 07:59:34 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id q4so5656671qtn.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 07:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L8B1S1807Ti9iRmhUOx0J5m9UzOaeU1e5mQqlxKoCgI=;
        b=QODpvOCqkEBYRaCtW46brCzr6RvYiSSBUmPlBopHsKHFym7LgqsMbTGfgebDlEjU16
         TFsHhWJ4u/faxda2EK0WsDqH5MI1sSQxEYojrgrtZUmLmoFXcXyT3PCud2L2uvLHIPYy
         XO57Q72FmNnr+KAGVdKZL/ta4iqA7wATM8nDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L8B1S1807Ti9iRmhUOx0J5m9UzOaeU1e5mQqlxKoCgI=;
        b=mWL8tq8y0n5xBE+Eq2+ADnbsgZTMcSzuB62Ox9cufQUM/3/p5ZZTs/10ynvywEM/wV
         DaGoH84QfUfV0ZWmAxCQeg1hdvVJjTD+GjyEFKGrSvF18AAuPRJ4T4Qyld93dneJfqaU
         4z09Mb63QZeOJRe1JSn+nz5oCh70Q0JpNEz68BGLEkyGwUgdutG0Cuwx5HYNr5O0nIKo
         6wHLkPBlYQzGQ+brr8okM3vzCdltoi309iOfC0MmjEB3tFh25j5aJ8PL/iHA8zoi6pne
         oMpWlwnqnve4b2HDESdrQxrjsbVDvxGcGPTENxVVNNQYwiBK80rMSBKhooF6/dqZinar
         hIOA==
X-Gm-Message-State: AOAM530mBsUiPbxkJ/rMKuYvQI2BMt3xRaWpDnQEUAGl0xhcYW1++JK4
        M63oZnMK437J0frfFhaxpiP9hqoncUvGzHRk7XI=
X-Google-Smtp-Source: ABdhPJzziz24P1yVX9II5mG6lu4Z8l204HWT6N8NAnGWdFg098ClXqG4i5YEPB6C5vMBNVmeCXDH7w==
X-Received: by 2002:ac8:4c8f:: with SMTP id j15mr3542001qtv.318.1619103573645;
        Thu, 22 Apr 2021 07:59:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:7297])
        by smtp.gmail.com with ESMTPSA id h7sm2243820qtj.15.2021.04.22.07.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 07:59:33 -0700 (PDT)
Date:   Thu, 22 Apr 2021 15:59:31 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Joe Perches <joe@perches.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YIGPUzFFj1lduVg2@chrisdown.name>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
 <YFDAfPCnS204jiD5@chrisdown.name>
 <YFHAdUB4lu4mJ9Ar@alley>
 <5ea3b634-5467-35cf-dd08-1001f878b569@rasmusvillemoes.dk>
 <YFMvfawY+0CncS8G@alley>
 <YHmXi303WxVZzVwI@chrisdown.name>
 <e9f74575-1ba0-0c06-b370-59d151c72ed6@rasmusvillemoes.dk>
 <YIAlM2jXadciFfGW@chrisdown.name>
 <54e5b0ab49002e0dd92e9d44ef62ff08641e330c.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <54e5b0ab49002e0dd92e9d44ef62ff08641e330c.camel@perches.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches writes:
>You really should evaluate the utility of log level monitoring and
>reconsider adding some compiler extension use of __printf to generate
>this format tracking ability.

Asking again, because you're repeating what you said last time without any 
further clarification: how is __printf tracking supposed to be sufficient? That 
tells one which arguments will have printf semantics, so sure, one can get the 
format, but (for example) you don't have any access to information about the 
log level, which is essential since otherwise it's not known whether the printk 
is capable of being emitted or not. Without that, you're suggesting replacing a 
functioning implementation with a "solution" which is not fit for the intended 
purpose.

For the use case described in the changelog, more or less all of the essential 
printks that must be monitored use printk() infrastructure directly. We're not 
trying to monitor the world here when we have plenty of better metrics. I'm 
sure there will be others which come up with time, but this doesn't have to 
cover every single possible subsystem's fancy printk-like out of the gate.
