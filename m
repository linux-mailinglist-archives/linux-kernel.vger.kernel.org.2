Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323E242426B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbhJFQT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbhJFQT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:19:57 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06A4C061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 09:18:04 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id s4so6633733ybs.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 09:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Az3RnbDsbDEe5BQeBA4RkbM3K2KO2nnyOEu1gJMKy8=;
        b=h12w95BSDwtU2m8MnPhdNVT8cMBy/deUTCoZeqUhZdgQsLqDe+FrqOR/aQ8faIbNW1
         FWnQwsHuYKFCfwI9UkUgP6+dqR6jOFk8mjFYz7rqMNNPxZakginPk/sVEj9/lOhdHXjd
         uNLwkmbsQU6ilj1th4AJMkStoYSLcynW80ZlGkZHfcVImauavrpLSslFBFGgn/vRbNep
         WlUEkUbDN/LBIBJDnmT0dKOwi+M56mp3i70eCmdt30vQ5fPdTnlyIb1YFg6I1ZDHY3kk
         4rPGi2Jjv5OaJj6z0C18lVCqNYpni4hdsrJwQ00lFbDrU9njbAQm1R2UcmbVV31oQRGU
         NTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Az3RnbDsbDEe5BQeBA4RkbM3K2KO2nnyOEu1gJMKy8=;
        b=f35XwjAYgiuI1G21TJIU5oP4PspDaQFAfsVoGde9tBuDAVWRVddOEqMVBE6h5kRutC
         N5yJ1HPSDyAcM6zhu2MRnHuiXPKQf0JZ+3GsKqNvpuR8LPMojdCdtus0LJR0aadH91SK
         qwqpaOQh1XePxtM+XcAxfsCzIqCf2cJuLML8fD3AuzL5L6XjNkrkcxCbGXFUfgN0n242
         k1y6uHiLjqcQgtP8ODZGfXrUhssvxG3iEf000s2rmbo88jenNIlcRhzQdDA7y+SNpfEi
         TuBERfJ/OoV0gsE4jwGRuozCoSVlUXOZDuFUkMMgraNeFvlgwgJuA9cApyKhcFHT/c1A
         3t1A==
X-Gm-Message-State: AOAM532OV+MC1sk9smlUqLJTIFw+NtDRzhAw6oMcMqykRD7bzP+Huhz4
        HQNQ/TR2OrCakNKXiE/fXqNb7yHHzIVGnwTJS3Ux8A==
X-Google-Smtp-Source: ABdhPJxT/XIupfjSJyXj/eYUPTKnfTRQjMGA4Hv97bbuvkz3AF2BKXvxYWlKmo9d5Jzx+hJU9aedr3RiS7pgaW3BV3o=
X-Received: by 2002:a5b:286:: with SMTP id x6mr29888199ybl.59.1633537083704;
 Wed, 06 Oct 2021 09:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-12-samitolvanen@google.com> <20211006033145.vcj3ohkekv5rexpo@treble>
In-Reply-To: <20211006033145.vcj3ohkekv5rexpo@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 6 Oct 2021 09:17:52 -0700
Message-ID: <CABCJKufSkOKm6MXzH3gJP17wte=5QfW0qoXH=Py6e6cAH5YkjQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] x86, relocs: Ignore __typeid__ relocations
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
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

On Tue, Oct 5, 2021 at 8:31 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Sep 30, 2021 at 11:05:27AM -0700, Sami Tolvanen wrote:
> > From: Kees Cook <keescook@chromium.org>
> >
> > The __typeid__* symbols aren't actually relocations, so they can be
> > ignored during relocation generation.
>
> Then what are they?  It would be good to add that information here.

These relocations are for compiler-generated constants that it uses
for indirect call type checking. I think we can clarify this in the
next version.

Sami
