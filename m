Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039F640B7FD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhINTbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbhINTbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:31:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0731C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:29:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k13so774108lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d29wXxwYw2ENSPs6TRPPGxX2mpwXTs89xVA0k6Truos=;
        b=gzzlYXXnDXnAPtA+FrKZ63b26A/QISqEkQn1GTIsTdZuF3rY+FjMPv6G/CBaQdQfcV
         GECZTVFSX030xXczfKSob7lV6bH7tZ8pP5+SqWZvJlvypQpGjXNfL+u8gB/ghN4U4bSD
         pLWZbH+eV/Q0e6FipKBbnvh3C8WRxNm2xDe7hR//2Pj+CqjXAkBbT54EGf8ZqVacJxTP
         X/7Xg1aFAklQw/4golyXVgSVjx6eHp81U/4X+alZ0r6HV3tWIzt5vEPKdLJgjjURWf12
         IO8ggV+0yBFkKGjSU3CUPE87dpkddg9klVdygkGCva/ewWij63YvddUKOoaOUNzybrm2
         +sWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d29wXxwYw2ENSPs6TRPPGxX2mpwXTs89xVA0k6Truos=;
        b=QBnW5t4xAKSxhfEpklqrTAGkPA5lAOcJ1dx2NSLFS3tZItGWmeT+Le5FhKbkoeGIeg
         hzMcvb+9I7i4Z6OD4EwXv4S+H0aRAQ5cV0ftg/CrgI3oyOSrqusnnMb1+NEwKQ6W/B9u
         9MXQpn/BpPY+ylo3kuAloizItdlEMaMDkOawhE7fLX+i2lI+1ioJaWuzWron1ztvV2b+
         d02Dqm3iYnqENuiZ/DnaHQb0vBxhyM2JutOY9VWsrk50v1/rHX5V02Qhnfhu5jUP3Hus
         CyoWalgrYXW8WQh4323pKOcFGwM4fch94x8GbD7OPgWj/+4DvUbABilTXyOA/ekMp0eb
         pivQ==
X-Gm-Message-State: AOAM5300RsyOeHq87dqUEDaXXJmYy43jZxyw8tdOJgbxallUtHbLcOke
        TU5TMO4sYc6Ee0AMjR/ZofojtbnLFfCg7lB1nBGGB5+Ijp+WeA==
X-Google-Smtp-Source: ABdhPJxsP1zDxcsnFy/3ynjlb5FnrOMwXGzJuXEWOybMu4FPprFz8WzCh6GMJPNS3NJbUFlNplxl0nksRyN7cLL5YJM=
X-Received: by 2002:a05:6512:3b9e:: with SMTP id g30mr14030392lfv.651.1631647790861;
 Tue, 14 Sep 2021 12:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com> <20210914191045.2234020-2-samitolvanen@google.com>
In-Reply-To: <20210914191045.2234020-2-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 12:29:38 -0700
Message-ID: <CAKwvOd=pmcfJRkgBFnqePauMd67+eQ9=JAbSjxrWmBQY9zRveQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] objtool: Add CONFIG_CFI_CLANG support
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:10 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> With CONFIG_CFI_CLANG, the compiler replaces function references with
> references to the CFI jump table, which confuses objtool. This change,
> based on Josh's initial patch [1], goes through the list of relocations
> and replaces jump table symbols with the actual function symbols.
>
> [1] https://lore.kernel.org/r/d743f4b36e120c06506567a9f87a062ae03da47f.1611263462.git.jpoimboe@redhat.com/
>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  tools/objtool/arch/x86/decode.c      | 16 +++++++++
>  tools/objtool/elf.c                  | 51 ++++++++++++++++++++++++++++
>  tools/objtool/include/objtool/arch.h |  3 ++
>  tools/objtool/include/objtool/elf.h  |  2 +-
>  4 files changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index bc821056aba9..318189c8065e 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -62,6 +62,22 @@ bool arch_callee_saved_reg(unsigned char reg)
>         }
>  }
>
> +unsigned long arch_cfi_section_reloc_offset(struct reloc *reloc)
> +{
> +       if (!reloc->addend)
> +               return 0;
> +
> +       if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
> +               return reloc->addend + 4;
> +
> +       return reloc->addend;
> +}
> +
> +unsigned long arch_cfi_jump_reloc_offset(unsigned long offset)
> +{
> +       return offset + 1;
> +}
> +
>  unsigned long arch_dest_reloc_offset(int addend)
>  {
>         return addend + 4;
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 8676c7598728..05a5f51aad2c 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -18,6 +18,7 @@
>  #include <errno.h>
>  #include <objtool/builtin.h>
>
> +#include <objtool/arch.h>
>  #include <objtool/elf.h>
>  #include <objtool/warn.h>
>
> @@ -291,6 +292,10 @@ static int read_sections(struct elf *elf)
>                 if (sec->sh.sh_flags & SHF_EXECINSTR)
>                         elf->text_size += sec->len;
>
> +               /* Detect -fsanitize=cfi jump table sections */
> +               if (!strncmp(sec->name, ".text..L.cfi.jumptable", 22))
> +                       sec->cfi_jt = true;
> +
>                 list_add_tail(&sec->list, &elf->sections);
>                 elf_hash_add(section, &sec->hash, sec->idx);
>                 elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
> @@ -576,6 +581,49 @@ static int read_rela_reloc(struct section *sec, int i, struct reloc *reloc, unsi
>         return 0;
>  }
>
> +/*
> + * CONFIG_CFI_CLANG replaces function relocations to refer to an intermediate
> + * jump table. Undo the conversion so objtool can make sense of things.
> + */
> +static int fix_cfi_relocs(const struct elf *elf)
> +{
> +       struct section *sec;
> +       struct reloc *reloc;
> +
> +       list_for_each_entry(sec, &elf->sections, list) {
> +               list_for_each_entry(reloc, &sec->reloc_list, list) {
> +                       struct reloc *cfi_reloc;
> +                       unsigned long offset;
> +
> +                       if (!reloc->sym->sec->cfi_jt)
> +                               continue;
> +
> +                       if (reloc->sym->type == STT_SECTION)
> +                               offset = arch_cfi_section_reloc_offset(reloc);
> +                       else
> +                               offset = reloc->sym->offset;
> +
> +                       /*
> +                        * The jump table immediately jumps to the actual function,
> +                        * so look up the relocation there.
> +                        */
> +                       offset = arch_cfi_jump_reloc_offset(offset);

Sorry, this comment is curious to me, it looks like we jump to the
offset+1, not directly to the actual function?  Perhaps a comment
above arch_cfi_jump_reloc_offset() and/or amending this comment might
make it clearer? Sorry if this is obvious to others?  Perhaps comments
can be cleaned up in a follow up, if this is not a bug?

> +                       cfi_reloc = find_reloc_by_dest(elf, reloc->sym->sec, offset);
> +
> +                       if (!cfi_reloc || !cfi_reloc->sym) {
> +                               WARN("can't find a CFI jump table relocation at %s+0x%lx",
> +                                       reloc->sym->sec->name, offset);
> +                               return -1;
> +                       }
> +
> +                       reloc->sym = cfi_reloc->sym;
> +                       reloc->addend = 0;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int read_relocs(struct elf *elf)
>  {
>         struct section *sec;
> @@ -639,6 +687,9 @@ static int read_relocs(struct elf *elf)
>                 tot_reloc += nr_reloc;
>         }
>
> +       if (fix_cfi_relocs(elf))
> +               return -1;
> +
>         if (stats) {
>                 printf("max_reloc: %lu\n", max_reloc);
>                 printf("tot_reloc: %lu\n", tot_reloc);
> diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
> index 062bb6e9b865..2205b2b08268 100644
> --- a/tools/objtool/include/objtool/arch.h
> +++ b/tools/objtool/include/objtool/arch.h
> @@ -81,6 +81,9 @@ unsigned long arch_jump_destination(struct instruction *insn);
>
>  unsigned long arch_dest_reloc_offset(int addend);
>
> +unsigned long arch_cfi_section_reloc_offset(struct reloc *reloc);
> +unsigned long arch_cfi_jump_reloc_offset(unsigned long offset);
> +
>  const char *arch_nop_insn(int len);
>
>  int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
> diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
> index e34395047530..d9c1dacc6572 100644
> --- a/tools/objtool/include/objtool/elf.h
> +++ b/tools/objtool/include/objtool/elf.h
> @@ -39,7 +39,7 @@ struct section {
>         char *name;
>         int idx;
>         unsigned int len;
> -       bool changed, text, rodata, noinstr;
> +       bool changed, text, rodata, noinstr, cfi_jt;
>  };
>
>  struct symbol {
> --
> 2.33.0.309.g3052b89438-goog
>


-- 
Thanks,
~Nick Desaulniers
