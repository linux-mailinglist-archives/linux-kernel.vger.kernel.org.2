Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA463319736
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhBKXyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:54:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230187AbhBKXxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:53:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E462164E4A;
        Thu, 11 Feb 2021 23:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613087556;
        bh=xtzmI2dR4hRaYr3yDSbATKA7Pt6c4sw8xv9I6JldghY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D72F1mhgSuhPSrhUH8Jo74/w0Z3fradjOWXTcGkZYfblNkMiHFEaevmvMuCEcmQ5h
         rk2RfBLEYzVlHpDBF65cLyIxgSaJzgdJo57tdY9oedM/gNClU/G97wtG37Tq0pRek3
         XeMkxW2gCIHQIHklktBKTWKz9cx/GJTPjxa3swyEcQrViNM6VyOjh5+GAGhwF1YdjQ
         34K/hEsWZyE5PKpvhFpuZLF6KbIzTjmVaVEV7SDVlO1h8Zqd8cUstZLsqHwM7N6B3V
         /amyA+8WFFyZ6vYFaSAvFVdw6R7G7F4RNMroZoMH60GC0/yzr6uS6eZnqUKh0PuwWQ
         qeWJ8+CqQlolw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DA69F40513; Thu, 11 Feb 2021 20:52:30 -0300 (-03)
Date:   Thu, 11 Feb 2021 20:52:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Dmitry Safonov <dima@arista.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jacek Caban <jacek@codeweavers.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Remi Bernon <rbernon@codeweavers.com>
Subject: Re: [PATCH] perf: Use (long) for iterator for bfd symbols
Message-ID: <20210211235230.GA1370062@kernel.org>
References: <20210209145148.178702-1-dima@arista.com>
 <CAM9d7civ8h5uh6_uMj9zKBkeRaCxr_UvA0inEiR8EmgHHxRtGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7civ8h5uh6_uMj9zKBkeRaCxr_UvA0inEiR8EmgHHxRtGQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 11, 2021 at 06:14:03PM +0900, Namhyung Kim escreveu:
> Hello,
> 
> On Tue, Feb 9, 2021 at 11:51 PM Dmitry Safonov <dima@arista.com> wrote:
> >
> > GCC (GCC) 8.4.0 20200304 fails to build perf with:
> > : util/symbol.c: In function 'dso__load_bfd_symbols':
> > : util/symbol.c:1626:16: error: comparison of integer expressions of different signednes
> > :   for (i = 0; i < symbols_count; ++i) {
> > :                 ^
> > : util/symbol.c:1632:16: error: comparison of integer expressions of different signednes
> > :    while (i + 1 < symbols_count &&
> > :                 ^
> > : util/symbol.c:1637:13: error: comparison of integer expressions of different signednes
> > :    if (i + 1 < symbols_count &&
> > :              ^
> > : cc1: all warnings being treated as errors
> >
> > It's unlikely that the symtable will be that big, but the fix is
> > oneliner and as perf has CORE_CFLAGS += -Wextra, which makes build to
> > fail together with CORE_CFLAGS += -Werror
> >
> > Fixes: eac9a4342e54 ("perf symbols: Try reading the symbol table with libbfd")
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Jacek Caban <jacek@codeweavers.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Remi Bernon <rbernon@codeweavers.com>
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> > ---
> >  tools/perf/util/symbol.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 64a039cbba1b..1645fb4ec9ed 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1561,12 +1561,11 @@ static int bfd2elf_binding(asymbol *symbol)
> >  int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
> >  {
> >         int err = -1;
> > -       long symbols_size, symbols_count;
> > +       long symbols_size, symbols_count, i;
> >         asection *section;
> >         asymbol **symbols, *sym;
> >         struct symbol *symbol;
> >         bfd *abfd;
> > -       u_int i;
> >         u64 start, len;
> >
> >         abfd = bfd_openr(dso->long_name, NULL);
> > --
> > 2.30.0
> >

-- 

- Arnaldo
