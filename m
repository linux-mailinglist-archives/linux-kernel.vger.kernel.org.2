Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F247B318731
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBKJgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 04:36:01 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:38714 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhBKJO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 04:14:57 -0500
Received: by mail-lj1-f175.google.com with SMTP id x7so4692098ljc.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=758wP38Bzq3pGtD1F5IQahQXluuhdimdYtqrofhVkOw=;
        b=HZB2IZMhwB8E/Y+2o89dE1hAFvtvCFGq2SeTX0xYMsnnHmGSU5i+1deYKFHlXkaiD3
         /iqJKdW6UmirSKaMuZ8lKIVDwpBHRS2azO29y8h7TJSC4WLBFXmRWDrC147dCNU+RVqb
         LoyLXMQ2P1qjmkgpZsHMCjV1XuESkNG2ubmifH8uAqFNR6ZESpG/FUNLIa6eGcMD2Lth
         qSRTAMFweR3fEiDUXLlTAHuwaz5cGPmTkHdZZBytxLA7n9uk62/bXK+Lo+Zi1N5mfP8j
         XJteJoouRq+o6gGklZAG4YSqTpdAEkyEU7Zc7bqIZp7sPIFp6y5trY9JnU3wTeUG2qjO
         Xw7w==
X-Gm-Message-State: AOAM532ykpj0LX47g+pFEOfZTYJROTeT+v5CNe1B8coKm2fZ0rsWm/TO
        HgA0xEyZZ5tuKp+rUp2zRSFk+GeT6ew6y4gbmrc=
X-Google-Smtp-Source: ABdhPJxb5zTAEz2yOUu8xRc0UsOig//qEbxwEE1p6y9QiaQiynVuxnJS1Q79hv2hjszlInPGjgVDuNHP6SHNKbekGDk=
X-Received: by 2002:a2e:9007:: with SMTP id h7mr4318030ljg.26.1613034855437;
 Thu, 11 Feb 2021 01:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20210209145148.178702-1-dima@arista.com>
In-Reply-To: <20210209145148.178702-1-dima@arista.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 11 Feb 2021 18:14:03 +0900
Message-ID: <CAM9d7civ8h5uh6_uMj9zKBkeRaCxr_UvA0inEiR8EmgHHxRtGQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Use (long) for iterator for bfd symbols
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jacek Caban <jacek@codeweavers.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Remi Bernon <rbernon@codeweavers.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Feb 9, 2021 at 11:51 PM Dmitry Safonov <dima@arista.com> wrote:
>
> GCC (GCC) 8.4.0 20200304 fails to build perf with:
> : util/symbol.c: In function 'dso__load_bfd_symbols':
> : util/symbol.c:1626:16: error: comparison of integer expressions of different signednes
> :   for (i = 0; i < symbols_count; ++i) {
> :                 ^
> : util/symbol.c:1632:16: error: comparison of integer expressions of different signednes
> :    while (i + 1 < symbols_count &&
> :                 ^
> : util/symbol.c:1637:13: error: comparison of integer expressions of different signednes
> :    if (i + 1 < symbols_count &&
> :              ^
> : cc1: all warnings being treated as errors
>
> It's unlikely that the symtable will be that big, but the fix is
> oneliner and as perf has CORE_CFLAGS += -Wextra, which makes build to
> fail together with CORE_CFLAGS += -Werror
>
> Fixes: eac9a4342e54 ("perf symbols: Try reading the symbol table with libbfd")
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jacek Caban <jacek@codeweavers.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Remi Bernon <rbernon@codeweavers.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/symbol.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 64a039cbba1b..1645fb4ec9ed 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1561,12 +1561,11 @@ static int bfd2elf_binding(asymbol *symbol)
>  int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
>  {
>         int err = -1;
> -       long symbols_size, symbols_count;
> +       long symbols_size, symbols_count, i;
>         asection *section;
>         asymbol **symbols, *sym;
>         struct symbol *symbol;
>         bfd *abfd;
> -       u_int i;
>         u64 start, len;
>
>         abfd = bfd_openr(dso->long_name, NULL);
> --
> 2.30.0
>
