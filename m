Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C87D39BF7B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 20:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFDSVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFDSVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:21:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11656C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 11:19:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso6315395pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 11:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=83HlqsNDaTvNDG7BbR+kglAFQeKo20qcIcpEJ/mxm6E=;
        b=BVm6nVfz+d2kV1nYkwMf4qKufge/nfZOK+rZLhp20qi/+3dvQ2XT269wW8reKIohMp
         tC3t6YHWjfs1kBW6doTy0CPh5ULhHsLZ6T3QHT5aWtKdESq2vNbCx8FIvaKuRY1G5Qcv
         NArv2WEAv8Yoy2884H5hTmt5suN6bzK5kyetw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=83HlqsNDaTvNDG7BbR+kglAFQeKo20qcIcpEJ/mxm6E=;
        b=XaNMvNctOIrroBjpUS/zjVGYSIBByEweilDy8EmixMXzcU1HefL+SV/WQddVj1PaZf
         qMYdSmSR2S+WHkmhrdpFzRPHyoodkv8hkzHMvbtfqu8t5hO/3QHbZIhoNta+DKZCjvEA
         NCpuoPc3y7wUjyTodkKPsAhXHxJ9IRbAvFuoaOFTTI5yyKRaIcZIV0aWZXSlTUFXP92x
         +ChLukw+GKIEYgGPhxpMiaPhkkdY4OU4uvo+TUSgdMZeI0DEF7xSOVhTVEdD1yv+nklA
         bn+5g2Ml37TgKi83/VDxtwMZlBY4lrZEXSXcQSD0bIdfV2ZcmnP0Hdmm6PSqqSeMlbd5
         XWew==
X-Gm-Message-State: AOAM532pHB6K3CV+wHfLn0Hl+kAAtgL7ZxNE5Jalbqasq5FbyY9Oj9ge
        w95Dlm/zqtRr1dude3eucwTrCA==
X-Google-Smtp-Source: ABdhPJyK7Z9X4f7G8StIruSs00k0qQjd30ycabvjyT7TIg2ROSO9X0UzVUuS40DKkbyJ/QHF0Ngo8w==
X-Received: by 2002:a17:90a:6e07:: with SMTP id b7mr17916258pjk.7.1622830796483;
        Fri, 04 Jun 2021 11:19:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ce15sm5775894pjb.4.2021.06.04.11.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 11:19:55 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:19:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com
Subject: Re: [PATCH v2 1/1] pgo: Fix sleep in atomic section in prf_open()
Message-ID: <202106041112.D89F8B21@keescook>
References: <20210603155318.46346-1-jarmo.tiitto@gmail.com>
 <202106031441.FA95440A@keescook>
 <3874710.oRHo3lsn7p@hyperiorarchmachine>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3874710.oRHo3lsn7p@hyperiorarchmachine>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 01:15:43PM +0300, Jarmo Tiitto wrote:
> Kees Cook wrote perjantaina 4. kesäkuuta 2021 0.47.23 EEST:
> > On Thu, Jun 03, 2021 at 06:53:17PM +0300, Jarmo Tiitto wrote:
> > > In prf_open() the required buffer size can be so large that
> > > vzalloc() may sleep thus triggering bug:
> > > 
> > > ======
> > >  BUG: sleeping function called from invalid context at include/linux/sched/mm.h:201
> > >  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 337, name: cat
> > >  CPU: 1 PID: 337 Comm: cat Not tainted 5.13.0-rc2-24-hack+ #154
> > >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> > >  Call Trace:
> > >   dump_stack+0xc7/0x134
> > >   ___might_sleep+0x177/0x190
> > >   __might_sleep+0x5a/0x90
> > >   kmem_cache_alloc_node_trace+0x6b/0x3a0
> > >   ? __get_vm_area_node+0xcd/0x1b0
> > >   ? dput+0x283/0x300
> > >   __get_vm_area_node+0xcd/0x1b0
> > >   __vmalloc_node_range+0x7b/0x420
> > >   ? prf_open+0x1da/0x580
> > >   ? prf_open+0x32/0x580
> > >   ? __llvm_profile_instrument_memop+0x36/0x50
> > >   vzalloc+0x54/0x60
> > >   ? prf_open+0x1da/0x580
> > >   prf_open+0x1da/0x580
> > >   full_proxy_open+0x211/0x370
> > >   ....
> > > ======
> > > 
> > > Since we can't vzalloc while holding pgo_lock,
> > > split the code into steps:
> > > * First get buffer size via prf_buffer_size()
> > >   and release the lock.
> > > * Round up to the page size and allocate the buffer.
> > > * Finally re-acquire the pgo_lock and call prf_serialize().
> > >   prf_serialize() will now check if the buffer is large enough
> > >   and returns -EAGAIN if it is not.
> > > 
> > > New in this v2 patch:
> > > The -EAGAIN case was determined to be such rare event that
> > > running following in a loop:
> > > 
> > > $cat /sys/kernel/debug/pgo/vmlinux.profraw > vmlinux.profdata;
> > > 
> > > Didn't trigger it, and I don't know if it ever may occur at all.
> > 
> > Hm, I remain nervous that it'll pop up when we least expect it. But, I
> > went to go look at this, and I don't understand why we need a lock at
> > all for prf_buffer_size(). These appear to be entirely static in size.
> > 
> 
> I would think the reasoning of taking the pgo_lock for prf_buffer_size() is that because
> __prf_get_value_size() walks linked lists that are modified by 
> __llvm_profile_instrument_target() in instrument.c.

Ooooh. Thanks; I missed this!

Let's go with the loop I proposed so we don't have to involve userspace
in the EAGAIN failure, etc.

-Kees

-- 
Kees Cook
