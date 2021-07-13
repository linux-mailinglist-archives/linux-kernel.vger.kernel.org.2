Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23033C7786
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 21:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhGMTzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 15:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbhGMTzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 15:55:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4A1C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 12:52:30 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y42so52449393lfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 12:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+35lHoPwaqRe5TACOCmYj4W/8yBukioGujN3udDCu0=;
        b=JaaZqfu9+E/ldL9Oa1Ma0Hg0OucK9ZQjPnHGabixSe7xGq8tn3yCfgdoPyCPX+itxS
         /l5xFvCQ/Xkm23rD7nzJt13I5dBFI33pnNgrYjsO/jLuPXV5izshIHRbqod+KW+Ikc9i
         hEa0Gnf6clASgC77BA0dUytCROV4iqxysbB98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+35lHoPwaqRe5TACOCmYj4W/8yBukioGujN3udDCu0=;
        b=V5MWEYp5uOSpYFyFoTpJN8yoEhTZND4QYz5h6v+fF2f7kubTfV9h4/3oM3oklMN7WZ
         4XGBwICZSuEUYWtfVObUXrZn2x+Y7WBER/CYKKQJW9CLxxCsHCNA0QQJPKJgvgdJaq+i
         UnnFEkGGX3Xy4xcp0m3JXSdxJmv8BKP2f/DNSohvXeHRbHjan3l2H0mBLShxu1z+AHZE
         2OoAnMdHP0OiglugTL+Bwq6DM2MFrRhP6TmoaHnJ6qCqLg1Mlr+u8W1L8SpwTx+qkmRq
         26c6WEFRSoIz7jmNZuXj6+26gXteYYmgTT+DMOLwz0rrcpUOYy/j9GhgBuybap2vZIb7
         JZ9Q==
X-Gm-Message-State: AOAM531Qzjgei9UyDvZU5JQ5JWouwTx6rlYrV1yP9w6a5BxdE/uTFF2G
        AUppBGiy/j6ZO/+s6VRsXj8vLYerGDhUO2NY
X-Google-Smtp-Source: ABdhPJwysRHulLK62mb9paneRyOJAHK5+1cq9zyORozPFxCC2zreqy3VtJef+fBsH2J+4gRXSqaWTA==
X-Received: by 2002:a05:6512:22c9:: with SMTP id g9mr4780514lfu.640.1626205948514;
        Tue, 13 Jul 2021 12:52:28 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id k21sm1756915ljg.36.2021.07.13.12.52.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 12:52:27 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id u13so13175048lfs.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 12:52:27 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr4608630lfc.201.1626205947428;
 Tue, 13 Jul 2021 12:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210713142414.GA28943@xsang-OptiPlex-9020>
In-Reply-To: <20210713142414.GA28943@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Jul 2021 12:52:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_uJayxT_6CFaGMkU5h4YYSgBhS=xYoN7iUVSs7BjnBA@mail.gmail.com>
Message-ID: <CAHk-=wj_uJayxT_6CFaGMkU5h4YYSgBhS=xYoN7iUVSs7BjnBA@mail.gmail.com>
Subject: Re: [mm/vmalloc] 5c1f4e690e: BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ I've asked for this before, but I'll ask for it again.. ]

On Tue, Jul 13, 2021 at 7:06 AM kernel test robot <oliver.sang@intel.com> wrote:
>
>
> [  131.014885] BUG: sleeping function called from invalid context at mm/page_alloc.c:4992
> [  131.019428] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 2928, name: trinity-c6
> [  131.023996] no locks held by trinity-c6/2928.
> [  131.027987] irq event stamp: 283042
> [  131.031844] hardirqs last  enabled at (283041): [<ffffffff8643af22>] _raw_spin_unlock_irqrestore+0x42/0x50
> [  131.036625] hardirqs last disabled at (283042): [<ffffffff81656d71>] __alloc_pages_bulk+0xae1/0xf20
> [  131.041305] softirqs last  enabled at (281858): [<ffffffff86800623>] __do_softirq+0x623/0x9db
> [  131.046157] softirqs last disabled at (281853): [<ffffffff8116dfee>] irq_exit_rcu+0xce/0xf0
> [  131.050925] CPU: 0 PID: 2928 Comm: trinity-c6 Not tainted 5.13.0+ #1
> [  131.055391] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [  131.060133] Call Trace:
> [  131.064110]  dump_stack+0xa5/0xe6
> [  131.068192]  ___might_sleep.cold+0x147/0x177
> [  131.072324]  __alloc_pages+0x462/0x650

Btw, can I ask the kernel test robot to do the same thing I asked
syzbot to do - namely get better backtrace annotations?

It requires debug info in the kernel (but I think DEBUG_INFO_REDUCED
is sufficient, no need for the full one that blows sizes up a lot),
but it makes things _soo_ much easier to read. Not just because of
line numbers, but particularly with inlining information.

It's easy enough to do: just run the kernel output through
"scripts/decode_stacktrace.sh".

That will also do the "Code:" line instruction disassembly, which is
less critical, since that can be done later at any time with no loss
of information, but it can be a convenience.

               Linus
