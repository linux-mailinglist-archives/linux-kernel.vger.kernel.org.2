Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC5D39E8C5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhFGU4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhFGU4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:56:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F6FC061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 13:54:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id v22so27184420lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 13:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ytaaL5fir0dj08gu9cCAj1Ucrhllz0BBiheWMwRBwRQ=;
        b=hqeep5YtDSxKA6qwRNVO6EK0V8B59ffDylVG4gDG8J1/H6J0gFi4e+kUTUriCI9p3F
         vwXWUmN/RXjQXY6oFUISeIubCZ/Sg6R2ImoVOTNYGJWHmec2ppn8c9DU4qcWnyQG3Td2
         3gZyvkQ1p3S2p+FJyGcMQdus72rGjev7IR7OKu8ChcPiVcuekcYgrvpouvuH12ByEVy6
         zl829vdzi/CfjAcl39Kp/wTUaBySCm4vj5lxyB8lpxlcxFZ2yVOoN4nlDLexhaL+Rv2I
         EWCY6i10sDcGZ5gj7jSkgKYZl+IVzpZh8CnPQpCj/sZxrQfVPI3X2E+RKEyHBt2hzMmv
         Ktyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ytaaL5fir0dj08gu9cCAj1Ucrhllz0BBiheWMwRBwRQ=;
        b=Zi/DYi7q0h2SZRRtwp5zvESUDDrP8wLiZ7JjBwwGmnZblybnu7qYgDgVVHLuM6Tluk
         Sz4SBOMWbBcax8JXZMn3p9mA6dQkxbvftAgfvHcfwFTLMJykq2uv1bR8PoqOCAQGF9P0
         +kLj8kqnLxMxP86Uss/vzoRxPCiifriQz2edCj1iWq9c76lVGzrlZZH3EvDXc2+Fc5Wg
         OdOiygcB+I1JhyaYkBCvWn8bibaaZbjVNtEY8491EW1xQp4fv7vk2aTuRNh5LutTQvSC
         SWc4FXgMTN+myrirxj1c5r5F6KWcv+UtlmLMl2MXspvzmozsyOzTo+OmX2//3Z+KX4Xv
         I9uw==
X-Gm-Message-State: AOAM530sHWImMmO1/KzejbSztQREgknARqmxjWWj6/LODTYzywbbGWtI
        MbobufPOZKdX05vditSd1wA9iqMuPDRqPNELkh2waA==
X-Google-Smtp-Source: ABdhPJyO/ojl2JVkU5sr5XZdTj+VRCUt2REpAHvl/3sfoQQotau/KMPdfapo3lKOD7L45TXOlkCiojsHAMSqZKcUEJo=
X-Received: by 2002:ac2:5cd6:: with SMTP id f22mr13823923lfq.73.1623099288917;
 Mon, 07 Jun 2021 13:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
 <20210604205018.2238778-1-ndesaulniers@google.com> <CAKwvOdmhg2tj8cKe-XitoZXGKaoOhgTsCEdVXubt+LiY9+46rw@mail.gmail.com>
 <20210604235046.w3hazgcpsg4oefex@google.com> <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
 <CAFP8O3+ggR8N-ffsaYSMPX7s2XgrzzTQQjOgCwUe9smyos-waA@mail.gmail.com>
 <YL3RQCJGIw9835Y1@hirez.programming.kicks-ass.net> <YL3lQ5QdNV2qwLR/@hirez.programming.kicks-ass.net>
 <YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net>
In-Reply-To: <YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Jun 2021 13:54:37 -0700
Message-ID: <CAKwvOdkuJBwZRigeqdZGevPF9WHyrC5pBAsz6_tWdXAc-wO+1A@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
To:     Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, lma@semihalf.com,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>, lb@semihalf.com,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>,
        upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 2:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
>

Thanks, the below diff resolves the linker error reported in
https://github.com/ClangBuiltLinux/linux/issues/1388

Both readelf implementations seem happy with the results, too.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Nathan,
Can you please test the below diff and see if that resolves your boot
issue reported in:
https://github.com/ClangBuiltLinux/linux/issues/1384

> ---
>  tools/objtool/elf.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 743c2e9d0f56..41bca1d13d8e 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -717,7 +717,7 @@ static int elf_add_string(struct elf *elf, struct section *strtab, char *str)
>
>  struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
>  {
> -       struct section *symtab;
> +       struct section *symtab, *symtab_shndx;
>         struct symbol *sym;
>         Elf_Data *data;
>         Elf_Scn *s;
> @@ -769,6 +769,29 @@ struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
>         symtab->len += data->d_size;
>         symtab->changed = true;
>
> +       symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
> +       if (symtab_shndx) {
> +               s = elf_getscn(elf->elf, symtab_shndx->idx);
> +               if (!s) {
> +                       WARN_ELF("elf_getscn");
> +                       return NULL;
> +               }
> +
> +               data = elf_newdata(s);
> +               if (!data) {
> +                       WARN_ELF("elf_newdata");
> +                       return NULL;
> +               }
> +
> +               data->d_buf = &sym->sym.st_size; /* conveniently 0 */
> +               data->d_size = sizeof(Elf32_Word);
> +               data->d_align = 4;
> +               data->d_type = ELF_T_WORD;
> +
> +               symtab_shndx->len += 4;
> +               symtab_shndx->changed = true;
> +       }
> +
>         sym->sec = find_section_by_index(elf, 0);
>
>         elf_add_symbol(elf, sym);


The only thing that's still different is that the `file` command still
prints "no section header."

$ find . -name \*.lto.o | xargs file | rev | cut -d , -f 1 | rev |
sort | uniq -c
      1  no section header
   8377  not stripped
      1  too many section headers (33683)
      1  too many section headers (50758)
$ file --version
file-5.39

That's drivers/gpu/drm/amd/amdgpu/amdgpu.lto.o, fs/xfs/xfs.lto.o,
drivers/gpu/drm/i915/i915.lto.o, respectively.  I'm not sure that's a
problem, yet, and whether 9bc0bb50727c8ac69fbb33fb937431cf3518ff37 is
even related yet; those might just be huge drivers and figured it was
reporting somewhere in case it ever comes up again.  CONFIG_LTO
implies -ffunction-sections -fdata-sections, and
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION explicitly sets those, too.
-- 
Thanks,
~Nick Desaulniers
