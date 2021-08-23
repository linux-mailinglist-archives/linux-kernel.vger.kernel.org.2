Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA663F4F69
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhHWRV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhHWRV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:21:28 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6C3C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:20:45 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id j13so14367283ybj.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8JSmD33jCZgI4ZSaQy5K3s54xcB739cSJ9JuXolesw=;
        b=P5bg4x+sppTF8KfYOZ6xzQ2IuZWnsL3ygtYFeJxzzIIi7j7kAKCH8d/yLgi+zyFFqi
         u9TP3tE4mnS6dWJRj4pZ/QNn2d+GXi7o3wWSPRLMMRdeF1FPMZ60nP6MXVCNJAGbwIXV
         fIe5+7zt/iOBKvlNwwvgrHL0tJH/7XcHVDGoSGD7c5Jhx3VEkZ28AGT623sp1UIOB9EB
         UcXROEvoFM9pnMiLGIC8618oJxeRgF0QuUyiVNaX08KIj5PL3RUS36otWfBLa3DFyR6h
         G2gmRrNEu2l6hwmif6PddC4du1tO2qXJn9mEcfk3rI4szbm9lKzjqpQ/jyfmn/D7B+Vo
         nBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8JSmD33jCZgI4ZSaQy5K3s54xcB739cSJ9JuXolesw=;
        b=VTpCGhi1U5dkfdT54CvrcImu7b+IX2442rTTqgu0X4fBCYTpR6VuiqUJIfqYl//UKt
         6pTOR0Ds3T37HYp4ig1/vD4IyDmC0WFkKIpK/qJsXL6varq3kJv0D1LRXKVvNSdmJQeO
         DFFXpPwlzxogdMhAyK1wg0UzB+nQO/rb7/GZt6H98JCx7ilcT+QKEFP3YT1+ebt/cm+3
         4ETNrjFMagfTJwijELYsYAqZGr5lZGFaOL9LZZ17bMxZ1B/Hr4LPKByM2J9AF8NvSNE3
         6PsTJs9pl19SF6+mlE9LVzXtm80+R4TUap8J6P8uKzEM4qxo5GbmqbNs6WmYtiRKjOKe
         m7Qg==
X-Gm-Message-State: AOAM530/U6JCEa2g9uqMt8Tn1qiuX/714+oaIaubFUknSXFhDZTIX3Aq
        97ZI5GM24QppJ+HULILYRoofq8E8YZvtBRzjDl5qAA==
X-Google-Smtp-Source: ABdhPJyyiBA5CCMkXEhpbhsS/96cPOh2zy3DLZEEEW5Gl5DuBQPzg1bxS5UHBRMWXBf8KH5b1JU24ZYb31adZ7PmR3E=
X-Received: by 2002:a25:734e:: with SMTP id o75mr24134262ybc.498.1629739244588;
 Mon, 23 Aug 2021 10:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com> <1706ee8e-c21c-f867-c0be-24814a92b853@redhat.com>
In-Reply-To: <1706ee8e-c21c-f867-c0be-24814a92b853@redhat.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 23 Aug 2021 10:20:33 -0700
Message-ID: <CABCJKufrpx9arM-hfX_bR-efO+13VBMFNBTe4ff036VEZi1LZQ@mail.gmail.com>
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

On Mon, Aug 23, 2021 at 10:16 AM Tom Stellard <tstellar@redhat.com> wrote:
>
> On 8/23/21 10:13 AM, 'Sami Tolvanen' via Clang Built Linux wrote:
> > This series adds support for Clang's Control-Flow Integrity (CFI)
> > checking to x86_64. With CFI, the compiler injects a runtime
> > check before each indirect function call to ensure the target is
> > a valid function with the correct static type. This restricts
> > possible call targets and makes it more difficult for an attacker
> > to exploit bugs that allow the modification of stored function
> > pointers. For more details, see:
> >
> >    https://clang.llvm.org/docs/ControlFlowIntegrity.html
> >
> > Version 2 depends on Clang >=14, where we fixed the issue with
> > referencing static functions from inline assembly. Based on the
> > feedback for v1, this version also changes the declaration of
> > functions that are not callable from C to use an opaque type,
> > which stops the compiler from replacing references to them. This
> > avoids the need to sprinkle function_nocfi() macros in the kernel
> > code.
>
> How invasive are the changes in clang 14 necessary to make CFI work?
> Would it be possible to backport them to LLVM 13?

I'm not sure what the LLVM backport policy is, but this specific fix
was quite simple:

https://reviews.llvm.org/rG7ce1c4da7726

Sami
