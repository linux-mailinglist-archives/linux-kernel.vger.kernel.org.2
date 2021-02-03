Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1092930D2A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 05:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhBCE3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 23:29:23 -0500
Received: from mail-qv1-f43.google.com ([209.85.219.43]:36533 "EHLO
        mail-qv1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhBCE3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 23:29:21 -0500
Received: by mail-qv1-f43.google.com with SMTP id es14so11094857qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 20:29:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZ0Z/pcttK9roAn4kNrNhpDQo1APxg3TKDvnfDsc7+s=;
        b=ckBHsE5FAbTa2hSwh7aTwu3Jv8/guy9XmyvrRQ1XNt0yo7bltiGnth40zv+lcBnbRs
         EvhFaXakt+/FT9fsiADWiwrArHvtFkIPeHX/cP5E53Agcbp5G8VHVgfL8LCyWMzIUE2z
         nefDpHzoU1bDZmcmN4g+Eq2sZR4/TE9BAMVfmA7wIIQFP8PrBNVS8bhwr3pKihDrSmeW
         xvg9m3lztrsXcaluuhEvaHJUfyWknlzSE9ouNkIWB6WBM07CyU9NANCsZmrrxiZo9BCE
         0vtSuvPry5ttn4N6m00+skwjXC9PSw0AfKJQ1MWdQY3DqtSyCX35Dq7w8amF/3qmNYRk
         iEjQ==
X-Gm-Message-State: AOAM533HtCcEWJRvIb0YCJ+NJyP2WtB0PkPgdt0UouJEPd6hnlzrd780
        OAd2a7z9HIkVfpjSJQj/SO+9o9CLxfWGUlvC0mM=
X-Google-Smtp-Source: ABdhPJy9pZ9mhM9JWIB2RqWzQhqROqB+S47F38lJT1VG8sRNfd5Cw8bd/AFLr3iExUXdl3Ss7A/uhUxq8NYoaxgWA6g=
X-Received: by 2002:a05:6214:21a5:: with SMTP id t5mr1351302qvc.20.1612326520068;
 Tue, 02 Feb 2021 20:28:40 -0800 (PST)
MIME-Version: 1.0
References: <20210113080128.10286-1-jslaby@suse.cz> <20210113104618.GB1331835@krava>
 <d6001540-c028-8728-413b-273a11d00ffe@suse.cz>
In-Reply-To: <d6001540-c028-8728-413b-273a11d00ffe@suse.cz>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 3 Feb 2021 13:28:28 +0900
Message-ID: <CAM9d7chXhSO0-haNn9WegP-CH4tqNBmMMgjhStZdiHjzCjTjKw@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Resolve symbols against debug file first
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jan 28, 2021 at 7:43 PM Jiri Slaby <jslaby@suse.cz> wrote:
>
> On 13. 01. 21, 11:46, Jiri Olsa wrote:
> > On Wed, Jan 13, 2021 at 09:01:28AM +0100, Jiri Slaby wrote:
> >> With LTO, there are symbols like these:
> >> /usr/lib/debug/usr/lib64/libantlr4-runtime.so.4.8-4.8-1.4.x86_64.debug
> >>   10305: 0000000000955fa4     0 NOTYPE  LOCAL  DEFAULT   29 Predicate.cpp.2bc410e7
> >>
> >> This comes from a runtime/debug split done by the standard way:
> >> objcopy --only-keep-debug $runtime $debug
> >> objcopy --add-gnu-debuglink=$debugfn -R .comment -R .GCC.command.line --strip-all $runtime
> >>
> >> perf currently cannot resolve such symbols (relicts of LTO), as section
> >> 29 exists only in the debug file (29 is .debug_info). And perf resolves
> >> symbols only against runtime file. This results in all symbols from such
> >> a library being unresolved:
> >>       0.38%  main2    libantlr4-runtime.so.4.8  [.] 0x00000000000671e0
> >>
> >> So try resolving against the debug file first. And only if it fails (the
> >> section has NOBITS set), try runtime file. We can do this, as "objcopy
> >> --only-keep-debug" per documentation preserves all sections, but clears
> >> data of some of them (the runtime ones) and marks them as NOBITS.
> >>
> >> The correct result is now:
> >>       0.38%  main2    libantlr4-runtime.so.4.8  [.] antlr4::IntStream::~IntStream
> >>
> >> Note that these LTO symbols are properly skipped anyway as they belong
> >> neither to *text* nor to *data* (is_label && !elf_sec__filter(&shdr,
> >> secstrs) is true).
> >>
> >> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> Cc: Jiri Olsa <jolsa@redhat.com>
> >> Cc: Namhyung Kim <namhyung@kernel.org>
> >> ---
> >>   tools/perf/util/symbol-elf.c | 10 +++++++++-
> >>   1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> >> index f3577f7d72fe..a31b716fa61c 100644
> >> --- a/tools/perf/util/symbol-elf.c
> >> +++ b/tools/perf/util/symbol-elf.c
> >> @@ -1226,12 +1226,20 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
> >>              if (sym.st_shndx == SHN_ABS)
> >>                      continue;
> >>
> >> -            sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
> >> +            sec = elf_getscn(syms_ss->elf, sym.st_shndx);
> >>              if (!sec)
> >>                      goto out_elf_end;
> >
> > we iterate symbols from syms_ss, so the fix seems to be correct
> > to call elf_getscn on syms_ss, not on runtime_ss as we do now
> >
> > I'd think this worked only when runtime_ss == syms_ss
> >
> >>
> >>              gelf_getshdr(sec, &shdr);
> >>
> >> +            if (shdr.sh_type == SHT_NOBITS) {
> >> +                    sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
> >> +                    if (!sec)
> >> +                            goto out_elf_end;
> >> +
> >> +                    gelf_getshdr(sec, &shdr);
> >> +            }
> >
> > is that fallback necessary? the symbol is from syms_ss
>
> To resume this and answer:
>
> Yes, the fallback is necessary.
>
> It's because syms_ss section header has NOBITS set for the sections, so
> file offset is not incremented. So shdr.sh_offset (the file offset) used
> further in dso__load_sym has different values for syms and runtime. The
> syms_ss (the NOBITS) one is invalid as it has 0x1000 here. The runtime
> one contains good values (like 000509d0 here):
>
> .text         00082560  00000000000509d0  00000000000509d0  [-00001000-]
>   {+000509d0+}  2**4
>
> That is, without the fallback, the computed symbol address is wrong.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
