Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647E2424826
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 22:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbhJFUpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 16:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239377AbhJFUpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 16:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633553021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1KF1LW5cDfM/ueFGMcYEy3hhTDIYMy6oUHH//f81E6c=;
        b=BKoq8nC+jne1oSnH9uT7FvwLr33/TXFGSOvCmNntehgPtyuNM7ihD6wapqwQEQd9sKHyH+
        YRkEl6g+9mzPy8cIdGOfuCbxa3RLp6FSCQjRdK5sfmN+dSZSIPhBgSQcjCXoZgJw8emDGN
        OwgeZv7/xnNufrPLTJthn7EopcHGe2Q=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-JFHkfigjNiGpc7v-uKvxmg-1; Wed, 06 Oct 2021 16:43:39 -0400
X-MC-Unique: JFHkfigjNiGpc7v-uKvxmg-1
Received: by mail-qt1-f198.google.com with SMTP id c19-20020ac81e93000000b002a71180fd3dso3249955qtm.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 13:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1KF1LW5cDfM/ueFGMcYEy3hhTDIYMy6oUHH//f81E6c=;
        b=ZVOc9cBQTTXOf6bAZsJm7NdnXwXmZeBTqJO2enqHSsLip9Dy2N53hCV0/l0vUORz4f
         cjBLGUsi45AS+f8URjIRBYxGEWq4C3mTd3zUv5J8+P+WW/7SDpAABlnikF7B2Fz19J6k
         Rpqh56RupBqG/vDoiGyKMtGDdC887MXX9dNUTfql4ZInOfqDMbmJMqGLk1LDLIz12NNX
         9AY/deEatbKB8EMYuHd5Mw8pybVyvi2xqUeF70ruYGDKBy4HuT2Aakk9xLp0hwuSfolv
         zMpdZpsSlb5AQNr88s/mbKph58vKFuzgqvWNEsOKtLg07JBfQBizMsDKvsSUS0ax1zKV
         /cwQ==
X-Gm-Message-State: AOAM533oCYH0AVEDY72mG3Z145rDieKuLTq9O9ZvOfvXszkEgyV2ohyW
        3+Ve2vmvr/QQHiCviM8XLhKztqwA7OAvznWFxYKdfd4pvLVfBUwUrNApF7N/WTQA/ZsCvfQh8A2
        FLhXuh2ck9ecaPoifAxuJ0ZWZ
X-Received: by 2002:a37:5f02:: with SMTP id t2mr244863qkb.264.1633553019258;
        Wed, 06 Oct 2021 13:43:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdGPlYUsWoR+CzZXbwhCp1TXr5QdHbHnuo20r9V6zPZV/k5CSYKHLQylIKXUmk2hZiajgHMQ==
X-Received: by 2002:a37:5f02:: with SMTP id t2mr244838qkb.264.1633553018965;
        Wed, 06 Oct 2021 13:43:38 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id 130sm12405680qkh.99.2021.10.06.13.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 13:43:38 -0700 (PDT)
Date:   Wed, 6 Oct 2021 13:43:35 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v4 06/15] ftrace: Use an opaque type for functions not
 callable from C
Message-ID: <20211006204335.xtymxt6wk4akx6fc@treble>
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-7-samitolvanen@google.com>
 <20211006032945.axlqh3vehgar6adr@treble>
 <20211006090249.248c65b0@gandalf.local.home>
 <CABCJKueL4Ebaan=JBUyO3oewq7RTHHXWUQpixgf2AfC_r5T3uA@mail.gmail.com>
 <20211006125809.5389b2a3@gandalf.local.home>
 <CABCJKudTuheEd5jyhXmfJHup7iYzOz3_OcO92hFnpRK1MapJSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABCJKudTuheEd5jyhXmfJHup7iYzOz3_OcO92hFnpRK1MapJSg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 10:45:41AM -0700, Sami Tolvanen wrote:
> On Wed, Oct 6, 2021 at 9:58 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 6 Oct 2021 09:31:04 -0700
> > Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > > > > On Thu, Sep 30, 2021 at 11:05:22AM -0700, Sami Tolvanen wrote:
> > > > > > With CONFIG_CFI_CLANG, the compiler changes function references to point
> > > > > > to the CFI jump table. As ftrace_call, ftrace_regs_call, and mcount_call
> > > > > > are not called from C, use DECLARE_ASM_FUNC_SYMBOL to declare them.
> > > >
> > > > "not called from C" is a bit confusing.
> > >
> > > Any thoughts on how to make this less confusing?
> >
> >  "Not called by C code, but injected by the compiler."
> >
> > ?
> 
> Sure, sounds good to me. I'll update this in v5.

"injected by the compiler" sounds even more confusing.  It almost sounds
like those functions are generated by GCC, which they are most
definitely not.

-- 
Josh

