Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50488413E91
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 02:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhIVARN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 20:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231690AbhIVARM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 20:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632269742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v3dL4FvidqqtKSFv5hVIotnqO/OfCmL/sS6Sby/WQIs=;
        b=CZ/aL0rCDJBhXDRSKx4VxrujaRBnuqr5rvcO/ti1I61SPhwS2CpjaYi86y1orm4oFP50O7
        gzXUCUDlxf/TD+d/2imM8+/TB8zYSB96DHcek8dCJwbXJ8nANawL6AEIKXYgLddL+CcNy3
        8W+6aG2fnc8obKDhb+jdTzvdAjVyy4Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-ONJ07cn3MXirapUpLuMJ8w-1; Tue, 21 Sep 2021 20:15:41 -0400
X-MC-Unique: ONJ07cn3MXirapUpLuMJ8w-1
Received: by mail-qt1-f198.google.com with SMTP id b15-20020a05622a020f00b0029e28300d94so4795906qtx.16
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 17:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v3dL4FvidqqtKSFv5hVIotnqO/OfCmL/sS6Sby/WQIs=;
        b=V8ZerXjSQvxfsw4rSksAbqUE6ChvKJ8DyEuCzynRyT4we9WdLqxLijXSZMM7ApA2rs
         AOeip/5KbXg0hnAjdQZYmc8nnCVeM2Ac50MWSQujYDUTXwhxXajikL+Qi+kEaPisuFDC
         ginvVqS3YukWF9HSbZ0XR9q8xoYVfmR/y4M8faB8zUv29nPYZsVT+gR/9/fFH8KkJwP8
         9V0ozYrg9qSgqZK8biT95I0TQkf2M6arOFOhk5mRhUQinIg1GgBJM+YLBzEoFdah5dgw
         osnR28Ulf99dkKfEPjKY/JjIWmimCyAh0WsyIlgtFaKQDDEP4Ed9sBxpXnnpXYSI+kAY
         3PeA==
X-Gm-Message-State: AOAM5324NsNnvh3SwNohcn9DfjeB09ZT/eQSkpOU+HCGeyeUohvZDkrc
        WmaI70PKmPuv0sDYcPQ7CM89se3vB2E9lrR7PwoM8uzVb3ZxmzU3N3n/qOPqK022XJqHBtf/XYQ
        KkF/+sKr2qE1BkfmKA2P+AtwK
X-Received: by 2002:a37:a143:: with SMTP id k64mr14021056qke.402.1632269741382;
        Tue, 21 Sep 2021 17:15:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4RxlQB8E8BS90k1fJDSDyVTsE2hzh5oRAeAS8+vPCaPq6hkolGLn8GzLe3tKjXieOAyuipg==
X-Received: by 2002:a37:a143:: with SMTP id k64mr14021046qke.402.1632269741160;
        Tue, 21 Sep 2021 17:15:41 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id x4sm483761qkx.62.2021.09.21.17.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 17:15:40 -0700 (PDT)
Date:   Tue, 21 Sep 2021 17:15:37 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>, peterz@infradead.org,
        luto@kernel.org, jannh@google.com,
        Kees Cook <keescook@chromium.org>
Subject: Re: CONFIG_ORC_UNWINDER=y breaks get_wchan()?
Message-ID: <20210922001537.4ktg3r2ky3b3r6yp@treble>
References: <20210921193249.el476vlhg5k6lfcq@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921193249.el476vlhg5k6lfcq@shells.gnugeneration.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 12:32:49PM -0700, Vito Caputo wrote:
> Is this an oversight of the ORC_UNWINDER implementation?  It's
> arguably a regression to completely break wchans for tools like `ps -o
> wchan` and `top`, or my window manager and its separate monitoring
> utility.  Presumably there are other tools out there sampling wchans
> for monitoring as well, there's also an internal use of get_chan() in
> kernel/sched/fair.c for sleep profiling.
> 
> I've occasionally seen when monitoring at a high sample rate (60hz) on
> something churny like a parallel kernel or systemd build, there's a
> spurious non-zero sample coming out of /proc/[pid]/wchan containing a
> hexadecimal address like 0xffffa9ebc181bcf8.  This all smells broken,
> is get_wchan() occasionally spitting out random junk here kallsyms
> can't resolve, because get_chan() is completely ignorant of
> ORC_UNWINDER's effects?

Hi Vito,

Thanks for reporting this.  Does this patch fix your issue?

  https://lkml.kernel.org/r/20210831083625.59554-1-zhengqi.arch@bytedance.com

Though, considering wchan has been silently broken for four years, I do
wonder what the impact would be if we were to just continue to show "0"
(and change frame pointers to do the same).

The kernel is much more cautious than it used to be about exposing this
type of thing.  Can you elaborate on your use case?

If we do keep it, we might want to require CAP_SYS_ADMIN anyway, for
similar reasons as 

  f8a00cef1720 ("proc: restrict kernel stack dumps to root")

... since presumably proc_pid_wchan()'s use of '%ps' can result in an
actual address getting printed if the unwind gets confused, thanks to
__sprint_symbol()'s backup option if kallsyms_lookup_buildid() doesn't
find a name.

Though, instead of requiring CAP_SYS_ADMIN, maybe we can just fix
__sprint_symbol() to not expose addresses?

Or is there some other reason for needing CAP_SYS_ADMIN?  Jann?

-- 
Josh

