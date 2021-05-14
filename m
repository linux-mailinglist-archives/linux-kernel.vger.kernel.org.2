Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E1838119C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhENUUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhENUUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:20:50 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22949C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 13:19:38 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id w4so39274169ljw.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 13:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8dn6xF6E4S7ZVtx8t+6PEIzcxkpUIx58HJDrNJtVpLQ=;
        b=L/qRdLEjxSDxpdeNNwcbpC2uoONdNBhnODiu9Bpm/Fo3DOapcrorBVTuwD/xMYeBft
         6J22I+lNSCesVvg6f+q4et4xP1sEfZ9e/I0b9xiHe9tWzZ11iNPiVljQufU6/LdsFH8S
         aG5MYRkH3qFL+mJrR52HTDIOkY8YeSuGi1WeWBik7H0tmyImp+xVjRb79VfQQWTCsOoc
         WhOMTDacHD6SNuoHLx8ybqb57tY1Z6UcaQLHHSpNvfPW6UeSg8CXQu/ZRVW7AWYCnTsB
         j2jJYomxeR4BRKCG3nahWr0t8YEr07xLrmejqDXIjWh5ZQRkJOP2MrDkRQzd5m+EmVmY
         8xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8dn6xF6E4S7ZVtx8t+6PEIzcxkpUIx58HJDrNJtVpLQ=;
        b=N8XE+BN30QRg/bYetaBImEywHvDoTI8LnVl3f+4O/mzVNn0uNUZf8AEdzxZUrJzq+e
         tYp2D3xMRKixA7nWHdJI6QwYuFpbp4eoqdhC1MqHUTN+qwY2+Xrhy59h8Pyws8waiIDS
         aP0h0qK3A4gmxVTyJGAuGfq+GH2yu5ojUxmZlDXSyucAgqCYEFMa19wooWmtVD7zMrV8
         DW91DWgx8rOvEawgXiX4ElEaoEESoW1s9nQGTrA4dgTYaQn8s68fmNhk/QDD8wmbNCnp
         feoTgRmFsQLoun93hxMXh5TOgm9HV11QOUbshWduT0nBAJd+lvUlvWAoAcv/uBVmf0h9
         7mCg==
X-Gm-Message-State: AOAM533Ms8xudtDvhAolABp9yk5BTFcRCS652koyTzwf7PXNVh1mxPlt
        Fxa29UCxN3W6vqn2OWD1k6KSkrnW4PyF84Kn2skLpw==
X-Google-Smtp-Source: ABdhPJy7UuUuh/yARQr6qCCMJxbyrC/N/RCc8T7z7Psi6Sxsv8BRRdEIaSnv0FARSQlmTOXDOGoyPHQQwqDpYLuwsLM=
X-Received: by 2002:a2e:a167:: with SMTP id u7mr38680058ljl.495.1621023576439;
 Fri, 14 May 2021 13:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210514140429.3334181-1-arnd@kernel.org> <20210514101610.4392adbc@gandalf.local.home>
In-Reply-To: <20210514101610.4392adbc@gandalf.local.home>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 May 2021 13:19:24 -0700
Message-ID: <CAKwvOdmJfm+PKxjR-N=YfFcjrXi4N4xUiRCLbSNMNJ+5g_wX+g@mail.gmail.com>
Subject: Re: [PATCH] tracing: events_hist: avoid using excessive stack space
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@godmis.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>, Tom Rix <trix@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 7:16 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 14 May 2021 16:04:25 +0200
> Arnd Bergmann <arnd@kernel.org> wrote:
>
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > In some configurations, clang produces a warning about an overly large
> > amount of stack space used in hist_trigger_print_key():
> >
> > kernel/trace/trace_events_hist.c:4594:13: error: stack frame size of 1248 bytes in function 'hist_trigger_print_key' [-Werror,-Wframe-larger-than=]
> > static void hist_trigger_print_key(struct seq_file *m,
> >
> > Moving the 'str' variable into a more local scope in the two places
> > where it gets used actually reduces the the used stack space here
> > and gets it below the warning limit, because the compiler can now
> > assume that it is safe to use the same stack slot that it has for
> > the stack of any inline function.
>
> Thanks Arnd for the nice explanation of the rationale for this change.
>
> But I still find it too subtle to my liking that we need to move the
> declaration like this (and duplicate it twice) for internal behavior of the
> compiler (where it can't figure out itself by the use cases if it can
> optimize the stack).

Under which configurations this warning was observed wasn't specified,
but I'd bet it's one of the sanitizers splitting this in two in order
to tell which branch may have overflowed the buffer.

-- 
Thanks,
~Nick Desaulniers
