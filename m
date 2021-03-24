Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41B734754A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbhCXKFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:05:00 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:35689 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbhCXKE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:04:56 -0400
Received: by mail-ua1-f53.google.com with SMTP id j19so7668853uax.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QA9qCRV4q8FCBzwBCexGAMFH84YJlvMKLm6NwRtk5jI=;
        b=d7euuknH6dvCMQTyv/5agDBHo376P97D3rXiWyny9lrY56aj6ShjKicQcgU0dSWpee
         aKR4cYO7/gyTRJBoQB+Cbmt2XrfIOrwTdVurG5XgkFik/hQGujpgAn35Tl3yF5NDrj1x
         ewDSr4oxcsWgBSEAfJhNl2d18ynlxCKzJjGKxCJAG+fCzBdgkQ5ILuCecNUNlSeqBgO9
         +g43aN/7XO9rJaGZ4owBqIb8N8k89zr+qck63nA2kHfzz5S19govtHY4kr1rRjES4svv
         ggKpBi6GBdabwPBSF69wqEJULJ3J85Msqn+t2gSi7qQLvXx51uL1A6+9kMKLVQ5vv2RJ
         8PtQ==
X-Gm-Message-State: AOAM533zsuQWqKlOjnkls7x2rTK90TxoTq8jucpQnCPlIfNFCpV12iNO
        Bk48+kpLUGpxCvyjOvOBOkUXK9XP8lht7djP7F4LresY
X-Google-Smtp-Source: ABdhPJylNbiIwQp8T/jFMr2WrowitHkNaLD15BlDgRw/TrvUxbK7ZSmYga1Td7PLL2XdK+QzkQM54wMbVmBSne6ardU=
X-Received: by 2002:ab0:2c16:: with SMTP id l22mr1048390uar.100.1616580295889;
 Wed, 24 Mar 2021 03:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210324054457.1477489-1-masahiroy@kernel.org>
In-Reply-To: <20210324054457.1477489-1-masahiroy@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 Mar 2021 11:04:44 +0100
Message-ID: <CAMuHMdUUK3GzD7cmb-z+TW7U21NMQm7x2e+Tw=cgp5dVUCPdNg@mail.gmail.com>
Subject: Re: [PATCH] treewide: remove editor modelines and cruft
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 10:58 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> The section "19) Editor modelines and other cruft" in
> Documentation/process/coding-style.rst clearly says,
> "Do not include any of these in source files."
>
> I recently receive a patch to explicitly add a new one.
>
> Let's do treewide cleanups, otherwise some people follow the existing
> code and attempt to upstream their favoriate editor setups.
>
> It is even nicer if scripts/checkpatch.pl can check it.
>
> If we like to impose coding style in an editor-independent manner,
> I think editorconfig (patch [1]) is a saner solution.
>
> [1] https://lore.kernel.org/lkml/20200703073143.423557-1-danny@kdrag0n.dev/
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

>  arch/m68k/atari/time.c                        |  7 -------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
