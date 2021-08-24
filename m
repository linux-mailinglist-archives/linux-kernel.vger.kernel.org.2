Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECE33F6875
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbhHXR5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240792AbhHXR5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:57:24 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E3EC0C175B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:31:07 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id z128so42492881ybc.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qy5AIG6IAw5l/UjdlTFWswRnp3Bis0SbvNsE5T3Il2w=;
        b=VfHskVSdG1gsmTXp1PfQvFG0VZnTvg9PP8Er/13S5ik/PHR1yoCy26jnVMO3U6kiFZ
         yFVWxryNXm0lMHWz2KXsgA4J0NavHxyj38pIwSqEx+mcIB7u84B+volIh425RH6qw0XM
         QyIw+hK0Su8Bji5pUnT3nHCluB66iwXC8JiGMFcSrqinr6TzM+D4EG2gf3E92zONOI5g
         YVpuHIU405wCBHy1RuJoxdnRgTqSdFYvkWGF6oEB3dT2U3mh6x+PdVgJ6qOjpsp21fFq
         CFN/e/Au7cRTRt2wtUlJqrwoc4YfRpzSo+ps/Tz05hlVCpdGFlzjDD8cArqwXXDOjmY8
         rgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qy5AIG6IAw5l/UjdlTFWswRnp3Bis0SbvNsE5T3Il2w=;
        b=OYILGSZdhQAMNNSbS+msXGltGDnSDQL/l+FRWJsncPytEhratiIBKTTqekZgptBtjm
         LeYJiGTqRFSDe2kNV+CAFd2W061IJ+AdJ2B7H8ebx+DKvAr59ZzASjk9BOEwLP08zWq/
         vT9EzuDoqiGEIpWfOkp6BxiAAsRAGF8NbE4TuNbgIa13d6+FEmH4jjBnSKR1gNH/rFRc
         11EJrq1fJJXjsSKPMWa0ACANtBEN9VwO+zBRLFpt6SHIpVWc3SX3R1aeZuq3XCMk57NQ
         phLjiY6ZwdjFGvTkBW9H4IBevZlSVf8DV45qBne8mV+2cW9og/dv62DPofTnnZZ4hM6d
         oB+A==
X-Gm-Message-State: AOAM532Xb6QjGwVrOCpd9H94cKMRvKV+lrEQOrdxw4PnoZmK9wnSxbq8
        d8l+H4CfEzH3yLiWZDq0lgkGnGUdaNyH3qgS23iWmg==
X-Google-Smtp-Source: ABdhPJwfFTJxj8yvs0YKLSiHeRAa0qFHMwxBi7hBm5u3mt+HdTEb3jbP9WNTaTsUrBXISb/zPHcE/OqQi0FHa0P3QPU=
X-Received: by 2002:a25:7ac6:: with SMTP id v189mr51220058ybc.485.1629826266324;
 Tue, 24 Aug 2021 10:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
 <1706ee8e-c21c-f867-c0be-24814a92b853@redhat.com> <CABCJKufrpx9arM-hfX_bR-efO+13VBMFNBTe4ff036VEZi1LZQ@mail.gmail.com>
 <9349a92d-f2a7-9ee4-64db-98d30eadc505@redhat.com>
In-Reply-To: <9349a92d-f2a7-9ee4-64db-98d30eadc505@redhat.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 24 Aug 2021 10:30:55 -0700
Message-ID: <CABCJKudiTVXOdzxzY1OxF4MMtwNt4XZ_-JJ70dM9H8AEHJmLNw@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] x86: Add support for Clang CFI
To:     Tom Stellard <tstellar@redhat.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:26 AM Tom Stellard <tstellar@redhat.com> wrote:
>
> On 8/23/21 10:20 AM, Sami Tolvanen wrote:
> > On Mon, Aug 23, 2021 at 10:16 AM Tom Stellard <tstellar@redhat.com> wrote:
> >>
> >> On 8/23/21 10:13 AM, 'Sami Tolvanen' via Clang Built Linux wrote:
> >>> This series adds support for Clang's Control-Flow Integrity (CFI)
> >>> checking to x86_64. With CFI, the compiler injects a runtime
> >>> check before each indirect function call to ensure the target is
> >>> a valid function with the correct static type. This restricts
> >>> possible call targets and makes it more difficult for an attacker
> >>> to exploit bugs that allow the modification of stored function
> >>> pointers. For more details, see:
> >>>
> >>>     https://clang.llvm.org/docs/ControlFlowIntegrity.html
> >>>
> >>> Version 2 depends on Clang >=14, where we fixed the issue with
> >>> referencing static functions from inline assembly. Based on the
> >>> feedback for v1, this version also changes the declaration of
> >>> functions that are not callable from C to use an opaque type,
> >>> which stops the compiler from replacing references to them. This
> >>> avoids the need to sprinkle function_nocfi() macros in the kernel
> >>> code.
> >>
> >> How invasive are the changes in clang 14 necessary to make CFI work?
> >> Would it be possible to backport them to LLVM 13?
> >
> > I'm not sure what the LLVM backport policy is, but this specific fix
> > was quite simple:
> >
> > https://reviews.llvm.org/rG7ce1c4da7726
> >
>
> That looks like something we could backport, I filed a bug to track
> the backport: https://bugs.llvm.org/show_bug.cgi?id=51588.

Great, thanks!

> Do you have any concerns about backporting it or do you think it's pretty
> safe?

No concerns, it should be safe to backport.

Sami
