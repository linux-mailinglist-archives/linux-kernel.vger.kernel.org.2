Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D2C381951
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 16:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhEOOVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 10:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhEOOVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 10:21:13 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FACFC061573
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 07:19:57 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id c14so2722963ybr.5
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 07:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7FG3BGvp3UM5jwkyXQ9ZlVnWzk7AoLwEg4DG0jV0g8=;
        b=BlIAn7yBovT7i7007o96Z+T7lmIZb332DXK1i2O8sFig6d321Ic8GTpblnTqe4Gtox
         t7X9JHi8YC9DT2FEgiSApT0FeTzVss+jQj1yjNxCNFbsJFjnzzfVBU38R3SBwLRYtVzG
         WFK0h/WaM9sHGrrrrHM6jqENYuXVgwBWjH4mCLW9ax82V6h/QfqeR7ABbBgaI7rbZbMs
         CHDbCERJxfXeyQj17aVd3f5ohCNg1RHrMyu7SS8zV5CTZzEjBjAShqE7jwATlqZ19vrW
         uR52QvlUng5HiDpEjdpn9ngMph7SqtZ1QgOmBE3ghdvi3M/wo3w3lKF/vvz3/fHmOb3n
         kv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7FG3BGvp3UM5jwkyXQ9ZlVnWzk7AoLwEg4DG0jV0g8=;
        b=Sr7hEdKWDrwuTy6v9aBj1zdQaRhHdOonYn3MSnUYSHhJ9zs8xW5F01wvLj71kQHzlZ
         ZHYqvOh+AxD4FkU/LwIiyPZG1HfTlvIXaKRkZo8qvDUuASod61bZTRBZCuVWLunXLrGI
         xQn1uLqFcf3C1SEzlK6K8Y/9yUyfYc0kKEwL58ZqgioOEh9iUZw3FcHqhaHPkbeTkDzq
         CpBZM6nPZyruzmU0m4ZApuxvHo+SjwbgLg2pYC8WhHkpqkBI6jAXtWMvqLGU22cWOaEX
         +hbyJg39JEXQ1JjlBlcANm3LcY8guLlzrBSZKIeSzE6nk8v4UHMvVXlTBlVzMMao8T8A
         LUvw==
X-Gm-Message-State: AOAM532ovx9Vr/a8BXeMmaYATe/JrfHB1eQuzcEB+0BZ2q1JxisL51VC
        wk1JMEZdd1M5RQbySBrWM69G0XlBye2E87LqiI0=
X-Google-Smtp-Source: ABdhPJwa80HGHPhDG8um8Ip7Qau8mdkvBotWr17G3lMHIiI5j9jAhOX0OITqlK92EunHCxau6HuseZ3Culbr4R6+NrY=
X-Received: by 2002:a25:8803:: with SMTP id c3mr36944040ybl.115.1621088396581;
 Sat, 15 May 2021 07:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210514140015.2944744-1-arnd@kernel.org> <0ad11966-b286-395e-e9ca-e278de6ef872@kernel.org>
 <20210514193657.GM975577@paulmck-ThinkPad-P17-Gen-1> <534d9b03-6fb2-627a-399d-36e7127e19ff@kernel.org>
 <20210514201808.GO975577@paulmck-ThinkPad-P17-Gen-1> <CAK8P3a3O=DPgsXZpBxz+cPEHAzGaW+64GBDM4BMzAZQ+5w6Dow@mail.gmail.com>
 <YJ8BS9fs5qrtQIzg@elver.google.com>
In-Reply-To: <YJ8BS9fs5qrtQIzg@elver.google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 15 May 2021 16:19:45 +0200
Message-ID: <CANiq72ms+RzVGE7WQ9YC+uWyhQVB9P64abxhOJ20cmcc84_w4A@mail.gmail.com>
Subject: Re: [PATCH] kcsan: fix debugfs initcall return type
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 1:01 AM 'Marco Elver' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> FWIW, this prompted me to see if I can convince the compiler to complain
> in all configs. The below is what I came up with and will send once the
> fix here has landed. Need to check a few other config+arch combinations
> (allyesconfig with gcc on x86_64 is good).

+1 Works for LLVM=1 too (x86_64, small config).

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
