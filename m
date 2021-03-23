Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0FC34675A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhCWSOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhCWSOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:14:19 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA69C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 11:14:18 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id b5so9894769vsl.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xTzROt3itpnrti9j03LZlWtci24fIc0v/ID50osegOI=;
        b=G9LSManCEm0ynRFxL0KfpbSwtGY42D+BJO4aqZzpdazH47X+7OW3AeHQu+vt1dxlqs
         kwCKfidzEMs/NtW9YLoiTyqbHNBfbS4Yi7HlukT7486VJk65AVQBWpIz6rLwBLEpoRZz
         WV1AQnUw5w5TdbQC7GVTCoww2Jfxqaun1PhzG506nw5O9sb6Bw8k8y9H6uwbl53s/EnQ
         Jwm5E7scoO1KiMcv+Kxg2BxJn4sjd/waOuiDsgUuCggMxVQYtv8dM5HPBSgNOKe5E0a4
         09TrE34zYUlHs3NO0pShHjk8Fu6ej5luUqS70hK5ZU4YMoOyHcI3lT/nTVz4ZDkRohVP
         awjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTzROt3itpnrti9j03LZlWtci24fIc0v/ID50osegOI=;
        b=VENHVCc28Pa4HIYSHtezG22nA0roI8/ykzNbGQCETT0m+ItL9t1Eb07EhK8Ve1ZxP5
         7jgC4xmVK2QvmHtbDeo8orCJaVijw2KxNI86WMz1Dvbk4nqJeIjtVCFX4RZNjMd7Oxb0
         7eFXW61SeVqU8VaL059T0usT5IFDoar7/x8Ve6lyaUp9frHO9UgOp+e8ZlL14e1msQlT
         9kAKFZYQGB6/negroeBXjxSVsWq+msPSt91G3aGNbNqdaJNRDlbIfteLJ5dPLyOEW0v0
         2PV/EPzSy2MN9z/x4MrJlbxqKvt4VHAdtoIeM81QAwjptNrwCojYRHp49+Av3DV8DXdH
         8XgQ==
X-Gm-Message-State: AOAM530fcZdlFAzevYXMejYTSgyzjQqhgZN5aafxmw04nTZsedHT1PSt
        0aO/u9UpqLEm1UsNS7QzSdLRqrDwwrcxjal+nIvNmw==
X-Google-Smtp-Source: ABdhPJxQfxePiAdqx2wIwj6cBcYftbaRTO90H9j82jX3SXWm+vInqDNP1WYjNB0ajdqoiCxSC2u3vyD9/cPX/2nCIDU=
X-Received: by 2002:a67:641:: with SMTP id 62mr4620421vsg.23.1616523257117;
 Tue, 23 Mar 2021 11:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210322234438.502582-1-seanjc@google.com> <CABCJKudMQ9CP1zhvywTf-_=PY5zmeviURR+=PqsMn_bqa_MV-g@mail.gmail.com>
 <YFoZBY1SqilWAmx4@google.com>
In-Reply-To: <YFoZBY1SqilWAmx4@google.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 23 Mar 2021 11:14:05 -0700
Message-ID: <CABCJKucYHQ893LS1iCHXivPS05RMDN2BpDFou306jOEbWnt1Dg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Merge module sections if and only if
 CONFIG_LTO_CLANG is enabled
To:     Sean Christopherson <seanjc@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 9:36 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Mar 23, 2021, Sami Tolvanen wrote:
> > On Mon, Mar 22, 2021 at 4:44 PM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > Merge module sections only when using Clang LTO.  With gcc-10, merging
> > > sections does not appear to update the symbol tables for the module,
> > > e.g. 'readelf -s' shows the value that a symbol would have had, if
> > > sections were not merged.
> >
> > I'm fine with limiting this to LTO only, but it would be helpful to
> > understand which sections are actually getting merged here.
>
> It doesn't appear to matter which sections get merged, the tables only show the
> correct data if there is no merging whatsoever, e.g. allowing merging for any
> one of the four types (.bss, .data, .rodata and .text) results in breakage.
> AFAICT, merging any sections causes the layout to change and throw off the
> symbol tables.

Thanks for the clarification. I can reproduce this issue with gcc +
bfd if any of the sections are merged, but gcc + lld produces valid
symbol tables.

Perhaps someone more familiar with bfd can comment on whether this is
a bug or a feature, and if there's a flag we can pass to bfd that
would fix the issue. In the meanwhile, this patch looks like a
reasonable workaround to me.

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Sami Tolvanen <samitolvanen@google.com>

Sami
