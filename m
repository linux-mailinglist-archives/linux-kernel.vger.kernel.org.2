Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0A03C7663
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 20:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhGMSWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 14:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhGMSWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 14:22:41 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B283C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 11:19:51 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id v6so14755615lfp.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 11:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRaC7OVMrz5Ujr3/sIQbWqu+KvqFyZ7N29CishV8qI8=;
        b=evshTzDppfeY9x3hYIsbNOMJ8CcauD5TsOYP9DkJvBeA9GufJE6DS7GF9hzIYdco2U
         Ce24pDdOo6a5tEYP7o2VdLLkKU9jN9UvzKHmb1+3Oxta5JNmheikWDE+Xa5MVUzr1vtD
         D3iaeVutWKvAF4A3+StWWM6f05LexN09eZlRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRaC7OVMrz5Ujr3/sIQbWqu+KvqFyZ7N29CishV8qI8=;
        b=uXkGsSYSdZS0X3rSFwlxzITnat8qlj+RnYtpTg+vpOo8Cust5EMYCzgL+fu2Kh0BsE
         GAj2cGwjcZZmlB6MUMq09I+FPBE9glcNlaaSkPBGDc15CgbMCvWeF7d4cnGsKHZVQGxy
         HyTaSF0ynkxfI/pe4EDFVKpBSKfRqEzReCIA0n9GS1CRGS9iXJQRWvC+LI7EGnEnOLT2
         38/vExFNHNKLHC70axwfJGplKetDDJjbq6EyC3jgIuLVWsAbRoFZYmfhwFXMaRgatUDM
         8wun+/HLLsAstH0s45gXWirOXKwDHQB5LYDFBOlPAGC+lbXmFyrwCCE7ZWnCmiXjAycZ
         frQw==
X-Gm-Message-State: AOAM531BsO4ZJjcEY83tv6Cu3IWMaHlrcFCRw+cuKT86ectUoNG1sXUD
        TyqT8J5xBjVwlRMnjmFtZafNR0qHq/JenNTCGmE=
X-Google-Smtp-Source: ABdhPJzJrSlExv1AnHn74s1lvlHA+6NxLaSffMcYc/rGj1EGx7ZP9e7oVoW/PRfKHZkZswnT3xy64w==
X-Received: by 2002:ac2:4294:: with SMTP id m20mr4596666lfh.6.1626200389175;
        Tue, 13 Jul 2021 11:19:49 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id c30sm198982lfv.19.2021.07.13.11.19.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 11:19:46 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id b40so31321343ljf.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 11:19:46 -0700 (PDT)
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr5223246ljg.251.1626200385898;
 Tue, 13 Jul 2021 11:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210713142414.GA28943@xsang-OptiPlex-9020>
In-Reply-To: <20210713142414.GA28943@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Jul 2021 11:19:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDif7SvA5DOWj9ssDuYHC4ujUFPd7ad-ydhY-WMLb-kQ@mail.gmail.com>
Message-ID: <CAHk-=wiDif7SvA5DOWj9ssDuYHC4ujUFPd7ad-ydhY-WMLb-kQ@mail.gmail.com>
Subject: Re: [mm/vmalloc] 5c1f4e690e: BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c
To:     kernel test robot <oliver.sang@intel.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@suse.de>
Cc:     Hillf Danton <hdanton@sina.com>,
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

On Tue, Jul 13, 2021 at 7:06 AM kernel test robot <oliver.sang@intel.com> wrote:
>
> [  131.014885] BUG: sleeping function called from invalid context at mm/page_alloc.c:4992

Strange. The call chain doesn't actually seem to be anything off: it's
writev -> sock_write_iter -> sock_sendmsg -> netlink_sendmsg ->
vmalloc.

All good to sleep as far as I can tell. The warning itself seems to be just

        might_sleep_if(gfp_mask & __GFP_DIRECT_RECLAIM);

in prepare_alloc_pages().

I don't see what's wrong with that commit, but it does seem to be very
consistent, in that the parent doesn't have it:

 > +----------------------------------------------------------------------+------------+------------+
> |                                                                      | a2afc59fb2 | 5c1f4e690e |
> +----------------------------------------------------------------------+------------+------------+
> | BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c | 0          | 54         |
> +----------------------------------------------------------------------+------------+------------+

Does anybody see what the problem is there?

There's an odd report _after_ the warning:

[  131.345319] raw_local_irq_restore() called with IRQs enabled
[  131.366561] RIP: 0010:warn_bogus_irq_restore+0x1d/0x20
[  131.433334]  __alloc_pages_bulk+0xbb8/0xf20

but I think that's might be a result of the BUG(). Maybe. But it might
also be indicative of some context confusion - do we end up nesting?
Because the BUG() has

[  131.036625] hardirqs last disabled at (283042):
[<ffffffff81656d71>] __alloc_pages_bulk+0xae1/0xf20

which means that the might_sleep_if() happens _after_
__alloc_pages_bulk() has disabled interrupts. That would explain it,
but the stack_depot_save() thing actually makes that call chain really
hard to read because it duplicates the addresses on the stack.

I don't see the nesting there, but that's what it kind of smells like to me.

Anybody?

               Linus
