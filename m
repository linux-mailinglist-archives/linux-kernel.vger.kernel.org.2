Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D6939D514
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFGGjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:39:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhFGGj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:39:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DEBA6121E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 06:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623047859;
        bh=0YmlqGb0FyE2AjCwbtQ/9mSsCd5wlLanyBCpjo5ZUnY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FdoO8D5OBQkjg7pxfi/bbd40E3tMYAAwR7NCYNUkuSLZuC5YZvG13KsnU635mBP11
         RP9T9KV0EYMwz65lCzzn800HQX+FQJqYWIrnybmyECoQms45kdCgJo0L2IXmu6wf3D
         +dTecYd16rQQOUexTi3vmJltQ+1JCen5hDg+d+Y5gt2IHSkQrvzMtyDgPZJSUbQYO3
         Z6qUezNr6ieUDxTjYod/OpEG8D0C3fCJsQtrHXwADac3jmJ8eQkKUDMF+k9zhUj2hJ
         Uo6q4ecLCo+2vXyzi6JwAx4WAH5DUcnfEEXLlonxWUZPd9hh9oBgk3cQcZTJMTwabq
         WYDtaRppfEDtQ==
Received: by mail-oi1-f178.google.com with SMTP id u11so17057999oiv.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 23:37:39 -0700 (PDT)
X-Gm-Message-State: AOAM530aIsKVcYGBRi7XindJUY6qGdbYt1ThSop1L7ZgUreoetFSe16o
        jhBKbUAh7K49gRyNY5cpZuGz1XdHtTS/A/wRBgg=
X-Google-Smtp-Source: ABdhPJzOcTVXMD+VQv+VmTWQFeXQt2medBnqUlrqmgcBlwFaQTscifvcpNqNxk2KNhtQsPa7Yy7AFUlOgLk8vUGpmTE=
X-Received: by 2002:aca:4343:: with SMTP id q64mr10379921oia.33.1623047858403;
 Sun, 06 Jun 2021 23:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210607023839.26387-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20210607023839.26387-1-mark-pk.tsai@mediatek.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 7 Jun 2021 08:37:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE3faN7nSSdoSU=ed+OPruefD_vJuhyRnsMuNiRygZZbg@mail.gmail.com>
Message-ID: <CAMj1kXE3faN7nSSdoSU=ed+OPruefD_vJuhyRnsMuNiRygZZbg@mail.gmail.com>
Subject: Re: [PATCH] recordmcount: avoid using ABS symbol as reference
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matt Helsley <mhelsley@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2021 at 04:42, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
>
> Avoid using ABS symbol, which won't be relocate, as reference.
>
> On arm64 platform, if there's shndx equals SHN_ABS(0xfff1).
>
> Section Headers:
> [Nr]    Name                         Type      Address          Off      Size   ES  Flg Lk     Inf    Al
> [65521] .text.n_tty_receive_buf      PROGBITS  0000000000000000 3cdab520 000054 00  AX  0      0      4
> [65522] .rela.text.n_tty_receive_buf RELA      0000000000000000 3cdab578 000030 18  I   152076 65521  8
>

A RELA section's r_info field points to the section to which it
applies. This is why in the example above section #65522 points to
section #65521. This has nothing to do with the numerical value of
SHN_ABS.

> find_secsym_ndx, which use r_info in rela section to find the reference
> symbol, may take ABS symbol as base.
>
> Symbol table '.symtab' contains 453285 entries:
>    Num:    Value          Size Type    Bind   Vis       Ndx Name
>      6: 0000000000000002     0 NOTYPE  LOCAL  DEFAULT   ABS section_count
>
> Which cause an invalid address in __mcount_loc.
>

Could you give a better account of the error you are trying to address?

Also, arm64 no longer defines a section_count symbol (since v5.11), so
please make sure that the diagnostics of the issue you are addressing
are accurate for mainline.


> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  scripts/recordmcount.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> index f9b19524da11..9b69167fb7ff 100644
> --- a/scripts/recordmcount.h
> +++ b/scripts/recordmcount.h
> @@ -526,6 +526,10 @@ static int find_secsym_ndx(unsigned const txtndx,
>         for (symp = sym0, t = nsym; t; --t, ++symp) {
>                 unsigned int const st_bind = ELF_ST_BIND(symp->st_info);
>
> +               /* avoid absolute symbols */
> +               if (symp->st_shndx == SHN_ABS)
> +                       continue;
> +
>                 if (txtndx == get_symindex(symp, symtab, symtab_shndx)
>                         /* avoid STB_WEAK */
>                     && (STB_LOCAL == st_bind || STB_GLOBAL == st_bind)) {
> --
> 2.18.0
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
