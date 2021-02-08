Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CF031427E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 23:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhBHWDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 17:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhBHWCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 17:02:20 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43CDC061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 14:01:39 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bl23so27955857ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 14:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mShq+EZPqAzFmcoE5QfNWQlMbGl3Td2RAiT+iP0GQO0=;
        b=LIeOHWTs8CppkjnjGGTVNejIohuZzj2vwuq+Wv0F6b/WKkYCpB8gDpphPXP3FlOKPN
         5A04u0Rpo5Q3y/qX92+c+mubKZdMffhNUMN2SWto7gqKNwyDAztIYBDCEsM1k5Dgw6J5
         PUorSLrGpmMEkj6+nnFAgbXRrx53r7Tg1WhyP9GQUJLswcVvMPdYoTE3UPO7/VO554Ry
         UO6bWW7Vp5SYE1k54nn6jzH76jT5Ez2ONUTrXWlIJ5EwRQR6zPJrgaeH9bCjPc3POt8D
         qaZUP4Y42CEFtwXZpNF8n86BkCNsIDtR3P5pgsa1U6BXSikRw60kvb/PICgh7CLysA88
         MYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mShq+EZPqAzFmcoE5QfNWQlMbGl3Td2RAiT+iP0GQO0=;
        b=bwb4iXNlStZLNnw7tM1H0PxHilfqObYmWraTVqd3yQ+5WZfKs6DMjz9OcEQw/oTmf8
         AA2JcnaTUaWEqvxNRYFKFgwnb9HL/rzDOCwSdF9ofbGWWXs4iPIKoes2664pF0SVjbDr
         wnS6Z5dp1z2H1zH+VakcbwKQZlXRUxgyz9h42k6hJzRfKe5ZYBEFSun4FuML3aB5+86I
         fnTySRVqaK3rvl7B57sQCQotNRSCsZFvMO2Zit22dMYuMQJQ+XUCJk0gZfH/oswCPoEx
         35KFwHPY6QcBcIxxyGzn4ZDu1t1jlH34x4D3le8ekr2l2M56ywpGNTkaNPhWeXqHAfan
         y/PA==
X-Gm-Message-State: AOAM531R/4+uhhPwRZPfeJOtbOFGVVY3h9dJSIM6aIb55d4WY8a3FI9c
        SpQPkQ8oHtegEq19gUh06uU9qLh/yHFIIeKEjrtsuw==
X-Google-Smtp-Source: ABdhPJxSYjqAd+iDGcp9OLAiPy0mD8uhaA6FigkBUp2yzAGRVyv6UP6GWM/PhnsYydNLl4JDCCeE528oHXnhYsugpRI=
X-Received: by 2002:a17:906:1241:: with SMTP id u1mr19278962eja.196.1612821698360;
 Mon, 08 Feb 2021 14:01:38 -0800 (PST)
MIME-Version: 1.0
References: <20210208214327.65287-1-sedat.dilek@gmail.com>
In-Reply-To: <20210208214327.65287-1-sedat.dilek@gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Mon, 8 Feb 2021 14:01:27 -0800
Message-ID: <CAP045Ar1MvSGSrL9gL3YzSbGJvs4Xt0MMuAahLZz2_B6y0UbzQ@mail.gmail.com>
Subject: Re: [PATCH] x86: entry: Remove _TIF_SINGLESTEP define leftover
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

- Kyle

On Mon, Feb 8, 2021 at 1:43 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> After commit 6342adcaa683 ("entry: Ensure trap after single-step on
> system call return") a _TIF_SINGLESTEP define is obsolete for arch/x86.
>
> So, remove the leftover in arch/x86/include/asm/thread_info.h file.
>
> Fixes: 6342adcaa683 ("entry: Ensure trap after single-step on system call return"
> CC: Kyle Huey <me@kylehuey.com>
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> ---
>  arch/x86/include/asm/thread_info.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 0d751d5da702..8861967e0305 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -101,7 +101,6 @@ struct thread_info {
>  #define _TIF_NOTIFY_RESUME     (1 << TIF_NOTIFY_RESUME)
>  #define _TIF_SIGPENDING                (1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED      (1 << TIF_NEED_RESCHED)
> -#define _TIF_SINGLESTEP                (1 << TIF_SINGLESTEP)
>  #define _TIF_SSBD              (1 << TIF_SSBD)
>  #define _TIF_SPEC_IB           (1 << TIF_SPEC_IB)
>  #define _TIF_SPEC_FORCE_UPDATE (1 << TIF_SPEC_FORCE_UPDATE)
> --
> 2.30.0
>
