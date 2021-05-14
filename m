Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA50438115E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhENUHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231726AbhENUHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:07:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36E92613C8
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 20:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621022754;
        bh=ZKEAYTwausCmdbG0qh1fB7/NKEdzLp+qbI4i/JCr5vM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NBCpZehEwnEhP+7yH39SNRoSR083AwlT1RmC8Ox5sgSENhhccuLjSefqAQkfSOFkb
         BTg2eonoq8VM+y/FSVDqKZJ6Hj4JsPe09sjFStOGNO4Y+3v0J5rNHyPiQxoaa5w1OG
         rzn7o0Pzt8+fxIr4MrfIScWeOzRkIlZ3g8GhYM31SIZKTn2PkQY6kWMjqnzaxOTjsQ
         anyjNxe9uHmSK5XJOpmowjyAkJWFrFEOE2iI/+zXmkMCBcsnFfsxx40rMkeVq2yWrK
         dWW8GKeiuONeiHQwfKObiGcLCFpK1GAqZKynKzLnLo+8flV6z2EitNy0l6MOc7nMmU
         eGGn1cmcHpMvA==
Received: by mail-oo1-f54.google.com with SMTP id t17-20020a4a3e110000b02901fab2f46a48so129691oot.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 13:05:54 -0700 (PDT)
X-Gm-Message-State: AOAM532cQCTfE5Mc9WvzK5IV3stk1HJY6Svhj2bMx0nTLuyD8aOjFqSN
        1WsXRXl3bCkbxsHs4ko8WWCsBeEOj2GVTvxvDNA=
X-Google-Smtp-Source: ABdhPJxJtkydDgd7kiQltEhpE+SiAjs/MXVU11PdB7lS8RCU1THU9hNSEhdEUpT97GCeWYgOcOyqLAxkDpKh7F7GCQA=
X-Received: by 2002:a4a:be86:: with SMTP id o6mr20226189oop.67.1621022753593;
 Fri, 14 May 2021 13:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210514140556.3492544-1-arnd@kernel.org> <219848ed-e0ce-634a-29c2-caca813b054c@gmail.com>
 <42f70914-e46c-20b9-6b13-8e8d855112a9@redhat.com> <29d069f2-a1c8-eb43-02ec-69c86b3cb107@redhat.com>
In-Reply-To: <29d069f2-a1c8-eb43-02ec-69c86b3cb107@redhat.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 14 May 2021 22:04:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2J=rv6HW1SiTS1R89CZFDe1-bxn+7qRFO2f3trDk0EuQ@mail.gmail.com>
Message-ID: <CAK8P3a2J=rv6HW1SiTS1R89CZFDe1-bxn+7qRFO2f3trDk0EuQ@mail.gmail.com>
Subject: Re: [PATCH] platform/surface: aggregator: shut up clang
 -Wconstantn-conversion warning
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 9:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 5/14/21 9:38 PM, Hans de Goede wrote:
> > On 5/14/21 4:21 PM, Maximilian Luz wrote:
> >> On 5/14/21 4:05 PM, Arnd Bergmann wrote:
> >>> From: Arnd Bergmann <arnd@arndb.de>
> >>>
> >>> The assignment doesn't actually happen, but clang checks the type limits
> >>> before checking whether this assignment is reached. Shut up the warning
> >>> using an explicit type cast.
> >>
> >> I'm not too happy about this fix as (I believe) it will also shut up any
> >> valid GCC error message in case those macros are used with non-u8 (and
> >> non-SSAM_ANY_xxx) values.
> >
> > Since you're the maintainer of this code, I'll go with your judgement here,

Thanks for taking a careful look. After a little experimentation I managed to
come up with a different workaround that avoids the cast.

> I just went to patchwork to drop this patch from the queue:
>
> https://patchwork.kernel.org/projecat/platform-driver-x86/list/
>
> But it never got added there because platform-driver-x86@vger.kernel.org
> was missing from the Cc even though get_maintainer.pl lists it.

I checked this as well now: the entries for the various surface drivers all
contain a reference to platform-driver-x86@vger.kernel.org, but (at least
in v5.13-rc1) the entry for that subsystem that lists the include file
does not list this email.

Sending v2 to the list now.

      Arnd
