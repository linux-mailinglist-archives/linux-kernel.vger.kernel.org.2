Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EBC4242B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbhJFQdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhJFQdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:33:08 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A863FC061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 09:31:16 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id g6so6807311ybb.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1N3Etrc+IvlHyTpW7XkflFyYfrFk6rq2AqHGQBELZI=;
        b=do0VsLfLI2lEtXGQ1eVW8WxUCz+l5Lk4ygQl5n1FOf2jF3PCNgZ1wMObNtiIbTcf+e
         B40CeDdtVeIMVjl5dzsNcPlaZ6m8HdwJNLaxvu6gQobCuQXyqqQ+Kk5M3vK321l/ESD1
         KIaCA/RM8+7OKe5KEHOXwRIoWauGyx25EptJHukJY5bPGQbVjCCkM6WNZ4M6YAIut9Z6
         jPiwx0xBNmxc4GmTvsqedBpLvzX1bYX4USqwZhelY13DEIRDd8pbNfnQYAH3T2oHjQSK
         ocZ26P/QWYFDW5HzWK9VG1wwJ9ZymgHn+DPb973yudIMMSdYI5fUK50mwFWdPk9zAuu+
         VDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1N3Etrc+IvlHyTpW7XkflFyYfrFk6rq2AqHGQBELZI=;
        b=ImMfzyK5c23uWLT6+KffyOKmEbJlE+HhUfLRfDHQz2dEcx+ieNJxAM7lubUyFijTKz
         7+Hh/aJhJtRiCKigXN+6wGU6loMhj69HUiz9ep5z6HmJ5wBgfwMFSi7xDoK6JhewU9n/
         NZ3QqT1JVSX3fawNMhYkIRSG97NrqXnUEJSPrwrgOpymjPEo2I7pOGq6n6am/zBM6+sS
         hE/JPM5tTgqpdOk7/wcKjgbsN70ZOQ7BlcacLhUYa5BtC3o8syxRjYsPcTy3Yn7Xnkko
         Yuwfv7x4OIyW+wQ6wk8e2FBkAkPWJw/85bXD0reLh7gPNdlHX5bgsyACd8CJugy2tNsL
         UfYA==
X-Gm-Message-State: AOAM530yJQcm8kx6SDaRGNhwh5F2Aep7uq7pmgkDgjvSzXHlwwo43bcN
        yaWIPhfeNhd0wCni+WCjtqWQ94Q4ZzuzZwMvK5RhiQ==
X-Google-Smtp-Source: ABdhPJy8ZvP2+QO+CLs1N3WqFjTvJStSsRb5E6N64u3z88hwpMV+U4CySxFZZ2HW0mgzuvjTeBsNSu/GKHKGulEh6FM=
X-Received: by 2002:a25:aaec:: with SMTP id t99mr30955841ybi.456.1633537875696;
 Wed, 06 Oct 2021 09:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-7-samitolvanen@google.com> <20211006032945.axlqh3vehgar6adr@treble>
 <20211006090249.248c65b0@gandalf.local.home>
In-Reply-To: <20211006090249.248c65b0@gandalf.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 6 Oct 2021 09:31:04 -0700
Message-ID: <CABCJKueL4Ebaan=JBUyO3oewq7RTHHXWUQpixgf2AfC_r5T3uA@mail.gmail.com>
Subject: Re: [PATCH v4 06/15] ftrace: Use an opaque type for functions not
 callable from C
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 6:02 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 5 Oct 2021 20:29:45 -0700
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Thanks for Cc'ing me, as I should have been Cc'd on the original patch.

Sorry about that. I'll make sure you're cc'd on the next version.

> > On Thu, Sep 30, 2021 at 11:05:22AM -0700, Sami Tolvanen wrote:
> > > With CONFIG_CFI_CLANG, the compiler changes function references to point
> > > to the CFI jump table. As ftrace_call, ftrace_regs_call, and mcount_call
> > > are not called from C, use DECLARE_ASM_FUNC_SYMBOL to declare them.
>
> "not called from C" is a bit confusing.

Any thoughts on how to make this less confusing?

Sami
