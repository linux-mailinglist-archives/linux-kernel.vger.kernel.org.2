Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D8034D703
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhC2SZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhC2SZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:25:32 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6C0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:25:31 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 184so16979739ljf.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2dpHV13oSemjijajiv2fnI7bbtHFM2HWjOqGuAvrI7Q=;
        b=fwE8UUsPQ4os/YO4GSbNy23LUIYQF9jlM57K/WfrhzNXebaNAy/zwy15UyW3Z/K3eW
         cuLMd4xTn9HHeprw7/7qG+tLyPjEdz9V2mF9nlQ+0iC5IXigwvQpPkNvLtsgL8LYlKhl
         HI8+UVUXChW4xU0VJ1a7ocPGAKPhDZV67JthPVhOXAmEVJi39bbHDaXzDXMVw0a3/e3N
         igI/2F3vrQHD6uZG4tgTO8Oz2jhMEF+RzGeXfA28ujli/zIFJsncciPrPedE8CGs7tsf
         RpgV7sjqXIl815z2oLP7kiorspOg6StAXkknvbjY7H6h5XohOoOW29lfjG12a58RuGC7
         rxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2dpHV13oSemjijajiv2fnI7bbtHFM2HWjOqGuAvrI7Q=;
        b=VvJgHjUU9fzeuKD5gS3blV5ADLibKFwhBtDsbSD1zDWmf9VboNB4F036WvvZEMz3WR
         UOREhzS4FVUwNWTLCmZAnBOlbo2//Ql7MxlR0C0uJ3ORnP3miHywUMqeH+QUq1C1DFJN
         cfwE80uibrN9S7AAsYHy+uPdQPMkgwMyYrLTWpwUJgnGI5fy3IzDbox9HV0z3K/JZnTy
         UHktK0DZ+rQ9Zfzk+o/cU8CZlEL1VSIZljfSQ5ydkMGueC2HocQxSn+NeDKXqeVly/3w
         vjkVF61ewDT6/AMTDmOmssmjI5h+n2gotEGdA9RYzrmtLnnvkBlQoEG5/gYCGXe/R72x
         LCKg==
X-Gm-Message-State: AOAM532IZM3Y/BAQ//bQVDgVRZXmP57B24/S08Ar8wFZ/C4d6OFI487q
        RacSQDeY62yn4NLvf2p7+9hpCCqgz3JedzmxQE+pTw==
X-Google-Smtp-Source: ABdhPJxLC6IdXQWzkZo/5A1dFmvrH0DLUo4gNisGLZ/wV81vO8siyCZjD0Bnbd0b8+qDkXOGIJTY8bC8QhyW3wCmURc=
X-Received: by 2002:a2e:5716:: with SMTP id l22mr18680924ljb.244.1617042330190;
 Mon, 29 Mar 2021 11:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210322115531.3987555-1-arnd@kernel.org>
In-Reply-To: <20210322115531.3987555-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Mar 2021 11:25:19 -0700
Message-ID: <CAKwvOdmNUkS0Hh_9-kvcDoK-UTUOV8hXsQx-R2o_T02fxMhFLQ@mail.gmail.com>
Subject: Re: [PATCH] lockdep: address clang -Wformat warning printing for %hd
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 4:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Clang doesn't like format strings that truncate a 32-bit
> value to something shorter:
>
> kernel/locking/lockdep.c:709:4: error: format specifies type 'short' but the argument has type 'int' [-Werror,-Wformat]
>
> In this case, the warning is a slightly questionable, as it could realize
> that both class->wait_type_outer and class->wait_type_inner are in fact
> 8-bit struct members, even though the result of the ?: operator becomes an
> 'int'.
>
> However, there is really no point in printing the number as a 16-bit
> 'short' rather than either an 8-bit or 32-bit number, so just change
> it to a normal %d.

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: de8f5e4f2dc1 ("lockdep: Introduce wait-type checks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/locking/lockdep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 70bf3e48eae3..bb3b0bc6ee17 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -705,7 +705,7 @@ static void print_lock_name(struct lock_class *class)
>
>         printk(KERN_CONT " (");
>         __print_lock_name(class);
> -       printk(KERN_CONT "){%s}-{%hd:%hd}", usage,
> +       printk(KERN_CONT "){%s}-{%d:%d}", usage,
>                         class->wait_type_outer ?: class->wait_type_inner,
>                         class->wait_type_inner);
>  }
> --
> 2.29.2
>


-- 
Thanks,
~Nick Desaulniers
