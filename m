Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F1835A72F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 21:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbhDITd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 15:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbhDITd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:33:56 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37AEC061763
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 12:33:42 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u9so7751546ljd.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 12:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agSy06aIEctwExyBOpH0Av56/yWfK/K39QTHh943O30=;
        b=M61olKQ5+31eeF6oDsDJTw+9q0ID5tuTA1oUYG7DNLA9oXwHDakqaexMtwt84sWv7N
         33Gx+Cc5K/Y5fUsk054bWmOYF8bCHWgrKQ3kq3hdqy4mCDd0VKGeFiAHGCw3WvQDvOLC
         Xp699j8Fkm5g4NfcWDzStV95Q631jBzoXJkecJ1cKDbQbaDuQ0nqmrgDHCYyxjUX22ox
         F6p9siNDiI7gvpSSNhzzW0hhOHVw0SyRdSfF5TYyzY0H62S/QXKTnP+Ko+RXVsRafdi3
         MUN//rqPiHTS/haFSEN+I8Jb9+NPQrisau42+PhAO42jbiFanzUaf546YuNRsnEQ0m+R
         bKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agSy06aIEctwExyBOpH0Av56/yWfK/K39QTHh943O30=;
        b=DAakK01WTPzMvzlL+s+EjtKnplaQ0BLvpM5sRoGowsQPEbPQlfSc1onS0k9yBIeA4D
         ptqjnyBIZ46cXAe2iMltHRkQdifctgenXcMwtquqS0vNbM+uE2eeMNwpTbYuyuF+r6ys
         UJIMSW26U1lTmhLX4ChhsnJ+1OikQZG6b9ZojWwvMUS9TyNnXzQ0beFl6ITQ/sHwV2sM
         UwVUTXXT33nolASJKeb4AJmAevADwNmr5SqoIkUU3dB3Gya1o17xlftWyK73krPFnst3
         HZ8dUMqOZiXMV7orCGkW9lHPVxokefZvIZSaQF+oN2LlXg3Cdzh+3YUN9f5+evoiGCfs
         ByrQ==
X-Gm-Message-State: AOAM5323hQfUMJvN/CvyIP0oa1YEBTvDygQQaeYkScF7HvsOmzf0ZGWn
        4bBGBJbQb+zJZ9NNBpm+rfjiPO4+0LZPIH1keFXkxg==
X-Google-Smtp-Source: ABdhPJy25HpVNFlFcheDTH68HRxhNLAcL4xLp/tawSRz2tdW4Bf4mAWcl+v83N12y/1CeRZ2QgaRFdpDztxZrJQaG78=
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr10166764ljp.479.1617996820957;
 Fri, 09 Apr 2021 12:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
 <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com>
 <877dlbzq09.fsf@oldenburg.str.redhat.com> <YHA3iGyT5dMq7/06@hirez.programming.kicks-ass.net>
In-Reply-To: <YHA3iGyT5dMq7/06@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 9 Apr 2021 12:33:29 -0700
Message-ID: <CAKwvOdnBXyR6gPgQjaXbHF8Ozx9Kk=OKgPv8_P7=jvvsWRVHEg@mail.gmail.com>
Subject: Re: static_branch/jump_label vs branch merging
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        dmalcolm@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 4:18 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Apr 09, 2021 at 12:55:18PM +0200, Florian Weimer wrote:
> > * Ard Biesheuvel:
> >
> > > Wouldn't that require the compiler to interpret the contents of the
> > > asm() block?
> >
> > Yes and no.  It would require proper toolchain support, so in this case
> > a new ELF relocation type, with compiler, assembler, and linker support
> > to generate those relocations and process them.  As far as I understand
> > it, the kernel doesn't do things this way.
>
> I don't think that all is needed. All we need is for the compiler to
> recognise that:
>
>         if (cond) {
>                 stmt-A;
>         }
>         if (cond) {
>                 stmt-B;
>         }
>
> both cond are equivalent and hence can merge the blocks like:
>
>         if (cond) {
>                 stmt-A;
>                 stmt-B;
>         }
>
> But because @cond is some super opaque asm crap, the compiler throws up
> it's imaginry hands and says it cannot possibly tell and leaves them as
> is.

Right, because if `cond` has side effects (such as is implied by asm
statements that are volatile qualified), suddenly those side effects
would only occur once whereas previously they occurred twice.

Since asm goto is implicitly volatile qualified, it sounds like
removing the implicit volatile qualifier from asm goto might help?
Then if there were side effects but you forgot to inform the compiler
that there were via an explicit volatile qualifier, and it performed
the suggested merge, oh well.
-- 
Thanks,
~Nick Desaulniers
