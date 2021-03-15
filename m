Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B7433B269
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCOMVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhCOMVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:21:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBF6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 05:21:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k8so5577246wrc.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 05:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wF2IyIdvNAleB+/6m+WbPaIfaxSFSC7N4OKaN9BjXDI=;
        b=DbPyUxC3xCSH6upHy830wWayHcW+0CJRCEj0CG9wEzEbywTzmpyxbdts8jecnEk33e
         Bo5ofRxukRdu25Sbu1fcnU8Q/p58j+XGHF0fEgOUxTlu5Mm/sf6Ax4HAflocEY7jNV0Z
         QQFfFOnSQGYK+OMF1CXJV0IpYg/DXR7NGYrl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wF2IyIdvNAleB+/6m+WbPaIfaxSFSC7N4OKaN9BjXDI=;
        b=Nabe1mQrv8VMsMdIki+a7dlxhJRMdY9DqP69Zb7epLOtv9FGXSE3yK4GH9mwD+/Fyd
         RQeZIzWy8fWhbSDrDPgIs6epCFDli6NMPIGqGvDWzy/ioihGRRQGPuz8gQFmWL+nhUUS
         d44VpxJpNZVwDmwviscRc8Tl9u/d5KXKCntHqCwj67/ZKprJPeN2KjKNPpOwyHNztaQL
         CuMOLCAE5iDSogEvzAU07d4vDSaLr03z9JhXjnJ0P2UWyQqFKWJ8TaTZB/0q7EDIVkiZ
         JZrKIVn36PaD2yOwSj1DS7BM17WPgyKJ2ZiF+ieLbXEP2VfSOOuWo49yFulsJCjat5Rx
         dBUg==
X-Gm-Message-State: AOAM531aIDJojPLxumnnDxjqpKVpJbV0FmJA4LwavmVIezmKoEvMx2rp
        jFuHyOsotyYOU60DQ1snMlkENA==
X-Google-Smtp-Source: ABdhPJxGGPLbOVuA8tyT3moJy6WA94TwOmb+VHUQqIewZui+0KLzV/N6O0ngYCVD3os49Hj+IUGTgw==
X-Received: by 2002:adf:ea82:: with SMTP id s2mr27774425wrm.1.1615810860785;
        Mon, 15 Mar 2021 05:21:00 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::4:43ff])
        by smtp.gmail.com with ESMTPSA id j26sm17997567wrh.57.2021.03.15.05.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:21:00 -0700 (PDT)
Date:   Mon, 15 Mar 2021 12:20:59 +0000
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
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YE9RK89jLbLQcSEq@chrisdown.name>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <YEtNKMF3KH1kUDxY@alley>
 <YEtyUM07gsqR6ltG@chrisdown.name>
 <YE8wvGHhbV4nAGGI@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YE8wvGHhbV4nAGGI@alley>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek writes:
>> I don't feel strongly that this is more clear though, so maybe you
>> mean something else?
>
>I was pretty tired when reviewing the patch. It was not easy for me
>to create the mental model of the code. I felt that some other names
>would have made it easier.
>
>Also the tricky pi_next() implementation did not help much. It looks
>like you changed the code many times to get it working and did not
>clean it at the end.

No worries. I'm not totally clear on what you're asking for though: do you 
meant that you'd like the SEQ_START_TOKEN logic to only be present for 
pi_start, or to pull out the logic currently in pi_next into another function 
and call it from both, or?

In my mind, pi_start is really just a special case of pi_next, so the code flow 
makes sense to me. I'm happy to change it to whatever you like, but it's not 
immediately obvious to me what that is :-)
