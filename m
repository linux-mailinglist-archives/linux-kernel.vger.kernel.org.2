Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7681A333C78
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 13:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhCJMSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 07:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbhCJMRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:17:54 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25BBC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 04:17:53 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id e23so6968593wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 04:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gmOoh5rfSQ/bfLOfAKnidJz/mWzWfe0aQp/Ruh78YZ8=;
        b=iDAEkCc02bjHDQ+7TwJdJ1YsEO1KdagSmFzJxK4wnZ3Mo1a2QtWSUzNAdghFp4TtgM
         9nL1kMKyFivtbPBAPBtmTsQJ9d89hAAHNSbO3cSUFjaBlh3piJwuX+z4SseVwVhL1Wn8
         hvbPAAvBoyHRdKGVb7DVc+j0FDNsPQ2SOaRM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gmOoh5rfSQ/bfLOfAKnidJz/mWzWfe0aQp/Ruh78YZ8=;
        b=iCpTZsUTvJO2prWxGOpyEJTZqWdHBA2VlixQCmqDKnw7h1KKuHu1NLIxBieqnVyYOP
         JzqVf9Egv21/zaVA1Y0blxbxP+w97ZtN5xJ8bBDlAgccbZNZ04C3V+ni9tCjmD+ElWFI
         /YIc93+xDcIdJIZmZK5j7VC606pwUOy+JflgbKFIpx5pE+IusS4zwZrC1JfLbV77Q4we
         dh3LNPIINZdN+GabPL9VM5+leM8q8MU2vG0Y4/mpuP/1w4bocceF0U8fQKHaOfvWzVZ8
         lDJ+JEIjQORrLJ6K1ZjjNfpQJ5k7GfyUlD/ISP9q6WG9mJ4OhPtw/CuKEjHZ6l8zpp5h
         Jl0A==
X-Gm-Message-State: AOAM5320Fb8Q35OYt+adSFE4jVX5fqgmS+iavgbpxqde6JL6Qrh0sKDA
        j3ihaFpAtCvWi1AD/9eECbzLNg==
X-Google-Smtp-Source: ABdhPJzan8mC9QAWOYl9atk3ciaOsKSsGNokeW0oCmAohMtlA22gkQ4TEEWeqN2AFxVYgSjup8MD2w==
X-Received: by 2002:a1c:a74b:: with SMTP id q72mr3068415wme.158.1615378672676;
        Wed, 10 Mar 2021 04:17:52 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id a14sm30810152wrg.84.2021.03.10.04.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 04:17:52 -0800 (PST)
Date:   Wed, 10 Mar 2021 12:17:51 +0000
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
Message-ID: <YEi47xUFix0Dg1Li@chrisdown.name>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YEgvR6Wc1xt0qupy@chrisdown.name>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Petr,

Chris Down writes:
>    $ head -1 vmlinux; shuf -n 5 vmlinux
>    # <level[,flags]> filename:line function "format"
>    <5> block/blk-settings.c:661 disk_stack_limits "%s: Warning: Device %s is misaligned\n"
>    <4> kernel/trace/trace.c:8296 trace_create_file "Could not create tracefs '%s' entry\n"
>    <6> arch/x86/kernel/hpet.c:144 _hpet_print_config "hpet: %s(%d):\n"
>    <6> init/do_mounts.c:605 prepare_namespace "Waiting for root device %s...\n"
>    <6> drivers/acpi/osl.c:1410 acpi_no_auto_serialize_setup "ACPI: auto-serialization disabled\n"

Regardless of any of the internals, how does this format look to you? I ask 
because the sooner we agree on the format, the sooner I can provide an interim 
version of this patch to internal customers, even if the eventual 
implementation changes a little :-)

Thanks,

Chris
