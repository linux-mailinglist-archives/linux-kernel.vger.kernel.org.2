Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221D931CE7B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhBPQxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhBPQxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:53:22 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF607C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:52:41 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id g6so13920402wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d4Oekxjc8XyDSKjFaxtpOI3FRArEZHy/EQSSJyQvN2k=;
        b=B4J5b5RThEGEcus+UwwEaz80EcbiQMz6DBAZGe2ZxzUcCcvIs0heqPSkHNlhSf9iyc
         99QgwDTJ/Ms1dhi+gad7C6OVzuR/xPiYlTha3kJcHv9KdWFvSVbrk36+1HA3qOO2CB9g
         nFatT7dRQ8bAfANkj1mTkv4U0L8cYJqXK206c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d4Oekxjc8XyDSKjFaxtpOI3FRArEZHy/EQSSJyQvN2k=;
        b=T89FykV50HFZDkK/wQLp1S6fSCIOZQYay+SdWCkSimhbkwDeWEwnIx9/DTUGbAKNus
         AqMUNFATlQbglJGFEqElBrkelXRq/mwc+mNga1gTbK3D/X+pejtYdsf8cHgNbQk5ngNj
         q1CqAQ4nWgT9Y2/TpOnNOKyjEOcRt4qUYt79lMOlXA0HOASvU0aL7BQ7FxOoMuWnVj9j
         /xq5wikEsxLnE2dIAAIIAjq8NAnR8+uO7Q2qSA5XojCCNwkoIOrfaqKYUYC1PeT/I0sr
         Yo54NU51J6gI6cTAozvBJ4Po9WYQ77By2dOT/TDQ3cDNBFYw7r9qsaF9PU+EyDW1GkXc
         xxiw==
X-Gm-Message-State: AOAM530K84aN/ncag9Abvu536Q4XqKvOezxL2GyjgEADkF2FW1NWLCHY
        PvmN2Y8oW20OuppU2LCqUZR0QA==
X-Google-Smtp-Source: ABdhPJxtH3MUDqZcYiZ5cl6Il5cRfTZM+zd4JBaK8cZXoot1VnD0nSRPI4DWKVXShMsX4TLd4NhYDA==
X-Received: by 2002:a5d:5910:: with SMTP id v16mr13989314wrd.304.1613494360312;
        Tue, 16 Feb 2021 08:52:40 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:76fd])
        by smtp.gmail.com with ESMTPSA id i1sm3922039wmq.12.2021.02.16.08.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 08:52:40 -0800 (PST)
Date:   Tue, 16 Feb 2021 16:52:39 +0000
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
Subject: Re: output: was: Re: [PATCH v4] printk: Userspace format enumeration
 support
Message-ID: <YCv4V5EFeuEmyxSz@chrisdown.name>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCvqdrBc3wLDClhv@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YCvqdrBc3wLDClhv@alley>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Petr,

Petr Mladek writes:
>This produces something like:
>
>3Warning: unable to open an initial console.
>3Failed to execute %s (error %d)
>6Kernel memory protection disabled.
>3Starting init: %s exists but couldn't execute it (error %d)
>6Run %s as init process
>7initcall %pS returned %d after %lld usecs
>7calling  %pS @ %i
>2initrd overwritten (0x%08lx < 0x%08lx) - disabling it.
>
>The loglevel is not well separated. It is neither human readable
>nor safe for a machine processing . It works only for single digit.
>[...]
>It looks in less like: [...]

Hmm, why is it important that debugfs output is human readable? My impression 
was that it's fine to have machine-readable stuff there.

Re: not being not safe for machine processing because it only works for a 
single digit, I'm a little confused. KERN_* levels are, as far as I know, only 
a single byte wide, and we rely on that already (eg. in printk_skip_header()). 
We also already have precedent for null-separation/control characters in (for 
example) /proc/pid/cmdline.

What am I missing? :-)

>Well, it still might be non-trivial to find the string in the code
>and see what exactly has changed. It might be pretty useful
>to mention even the source_file:line, for example:
>
><3> init/main.c:1489: Warning: unable to open an initial console.\n
><3> init/main.c:1446: Failed to execute %s (error %d)\n
><6> init/main.c:1398: Kernel memory protection disabled.\n
><3> init/main.c:1366: Starting init: %s exists but couldn't execute it (error %d)\n

Almost certainly a theoretical concern, but I am not a big fan of this format, 
because it relies on a character (":") which is legal in paths (although as 
you'd expect, we don't have any cases in the kernel right now). That's one of 
the reasons why I preferred to use nulls, which can't be in a filename.
