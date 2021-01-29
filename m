Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67BA308F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 22:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhA2VtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 16:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhA2VtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 16:49:02 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82F4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 13:48:21 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u11so6034904plg.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 13:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDCl0b2Dk+cS7GVWEWeoYxC8mwKbqEi6yIqTF9Oo/qE=;
        b=eGTW4MG8Pl3TK+TMkm4WglBjmPDuVT8H+GAviEyFrguRE6MRa/GZZU7J398/6ZxFe0
         xKPb6fAPxgSfXD/5KNroU2ifvPgvO1IC8xBnFPZzEvffhM+8Q1IErfcPS36GrEAidfn7
         mZUNfyj0ahxaGDAbfudWd+sU+mGeZMHZfwwVpRbB+qDyxpH5crTLeJwY1PlaMWn6JFMS
         NZ0bST5Evxu51geiAxpQM2AAPsjDwei/x21em74ddRcVbmAwrCX90CFifsFs6qZ1MfxK
         MGUg4o5cVCabYzEtUhZy2YrZ/jRtkSNA0vITi/lAdQbWRMyGdCsUvL40t9Y8gL8BLvub
         ckIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDCl0b2Dk+cS7GVWEWeoYxC8mwKbqEi6yIqTF9Oo/qE=;
        b=aORyM66Te1eILmYq4R1rITgLa9Iuvd1xzCVBtOSlFN3WrHB061bv017M82ClU+OkfJ
         SLXmCE8+HIpjc4uvnNQCS5S1U8vK5a2xadE3lSfTjr25YNOuz7yrIqPSaIXKD72MvGSy
         75dBOZ9I1m5bxZyi9qOFSg0ct+5PaMzakMnznTYYBROHalmMPdrkpv9nO9zCeJM/H/sH
         fFcX6EBNXvsT5XmVcRf6YaqLuvTBe5a9tmQfnUHRuYQXSUL/aUAPnLU/D+sCTtdlfzYh
         kcaIETXluR6rUPWVcz0PGwJc7qHPAO+zVg0hq6QxMtbej8Rei//tN+MmtGCrhPylTQ/f
         OTzw==
X-Gm-Message-State: AOAM533rHMD3e52Y3w4dmlcSFaRtpV2Ba8NDEmhDh5E/XB9CpUJsm38u
        oTkFXQWppJO6kJxepDlKU4c0CedkpABTN4gKtoyHeg==
X-Google-Smtp-Source: ABdhPJyaUQFnwwGfCgFgWXfe9NvNBiQYNFxLJPMiY6STretlJGU4TmCaVSMStJjR790JfgkGm8fCqn5KCHfOCa2LqxE=
X-Received: by 2002:a17:90a:8b82:: with SMTP id z2mr6338917pjn.25.1611956901187;
 Fri, 29 Jan 2021 13:48:21 -0800 (PST)
MIME-Version: 1.0
References: <20210121082451.2240540-1-morbo@google.com> <20210122101156.3257143-1-morbo@google.com>
 <CAKwvOdm+3o8z2GivPjSJRa=c=UKdfkiY-79s6yn2BxJkFnoFTw@mail.gmail.com> <CA+icZUVbdbkboYNztXNtRDR+LH8yQbhZJ+Nw-h91TQRr=Z08Gw@mail.gmail.com>
In-Reply-To: <CA+icZUVbdbkboYNztXNtRDR+LH8yQbhZJ+Nw-h91TQRr=Z08Gw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Jan 2021 13:48:10 -0800
Message-ID: <CAKwvOdmyerPPJo=m+13jtWR_kPwrmOeb89jh=qgGzEaPhKDOLA@mail.gmail.com>
Subject: Re: [PATCH v7] pgo: add clang's Profile Guided Optimization infrastructure
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Bill Wendling <morbo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 11:43 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Some comments:
>
> [ hash mismatches ]
>
> Observed identical warnings when doing a rebuild with GAS or Clang-IAS.
>
> [ Importance of LLVM_IAS=1 working ]
>
> Clang-LTO and Clang-CFI depend both on LLVM_IAS=1 (see for example
> "kbuild: add support for Clang LTO").
> Sooner or later we will deal with this issue (hope it is not a local problem).

If you're switching back and forth between GAS and IAS, then I would
expect a hash error if you're trying to reuse profiling data from one
with the other.  The profiling data is not portable when switching
toolchains between when the profile was collected, and when it was
used.
-- 
Thanks,
~Nick Desaulniers
