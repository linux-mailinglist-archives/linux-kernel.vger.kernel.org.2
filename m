Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DCE433A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhJSPfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234332AbhJSPfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:35:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50DD6610A1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 15:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634657581;
        bh=iCmSyqMmxKzt3nMwc23Yk2MEoPhytAS0pzkiqRt/Np0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=shUZoThxdyG9NreWRDhy9JebIe2d5u0sgZtncpkeRQuW/LE+0l45NxDeTSprCfRRY
         811Z7SAoEA5UX97emkKZQGghLJUhK+EW5iWDfMwr5ylGfqHoCvbKZaT6KvQtTXJglf
         cLOeeQQABPn0Ya+69yxwAFMC+lBJaxES5kH1/Tx0AaGTLA/u1EqVxrFCcRyQPF9bTt
         MytGP1Tk2fSm6V7+AdhutHDoZDwPR4m5ppHbtxxmi72YI/BdkxDx3OqwSXi+srZM70
         Aqb1hrkGNOagGTYwWvXMtYA/K+aEiEYPuuZuq5+PlM9/9IXxqFM4E3Dgb7AjDafoKv
         Z/3f/mcl5twew==
Received: by mail-wm1-f43.google.com with SMTP id z77-20020a1c7e50000000b0030db7b70b6bso3361347wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:33:01 -0700 (PDT)
X-Gm-Message-State: AOAM531q0ayGpwkZstmJlSashn2VQDn0/K9T0ZJ09shqKSsHrgFz+MkK
        x7Eb2PKuVVd+0X8EU5wzD2KMUPypmWUDqts8eRo=
X-Google-Smtp-Source: ABdhPJzBWL0609j2KrMD/tpj/g7L9anqnkXyV5JmyXcEBMw2jtlGifO1MILHXVHJyfbyKyVaZWhLEB6PfPQ4pWYUmRY=
X-Received: by 2002:a05:600c:208:: with SMTP id 8mr6558667wmi.173.1634657579815;
 Tue, 19 Oct 2021 08:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211018132538.2468989-1-arnd@kernel.org> <d4ad897585ddc815c188bbf0b3b8cec1cb40b7a4.camel@kernel.org>
In-Reply-To: <d4ad897585ddc815c188bbf0b3b8cec1cb40b7a4.camel@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 19 Oct 2021 17:32:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0EYcoPYDPa7MJJJB130qcRAqE_RPiJ-Era0O3i2GBNKQ@mail.gmail.com>
Message-ID: <CAK8P3a0EYcoPYDPa7MJJJB130qcRAqE_RPiJ-Era0O3i2GBNKQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] tracing: use %ps format string to print symbols
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Qiujun Huang <hqjagain@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 4:42 PM Tom Zanussi <zanussi@kernel.org> wrote:
> On Mon, 2021-10-18 at 15:25 +0200, Arnd Bergmann wrote:

> This looks fine to me, thanks for the patch!
>
> Reviewed-by: Tom Zanussi <zanussi@kernel.org>
> Tested-by: Tom Zanussi <zanussi@kernel.org>

Thanks for testing!

> > -                     seq_printf(m, "%s: [%llx] %-45s", field_name,
> > -                                uval, str);
> > +                     seq_printf(m, "%s: [%llx] %-45ps", field_name,
> > +                                uval, (void *)uval);

This turns out to be still wrong on 32-bit, as 'uval' is a u64 and I
can't cast that to a pointer without a uintptr_t cast first.

I was testing randconfig builds with clang here, and for some reason
that didn't catch the bug, but I found it after going back to gcc testing.

Sending v3 now.

       Arnd
