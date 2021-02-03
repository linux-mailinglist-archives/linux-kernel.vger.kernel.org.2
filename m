Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC3D30E353
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhBCTdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:33:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhBCTdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612380736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yAz6hy9loozQPRe1Cm/DTHR1Cv8KYP3OQyapofOjRZw=;
        b=GhBlf6KKcmz5nelCNB8rUz9JTcxu2Ti5LcEJTRJRxaXe+8tjCpsWWnLDTNj8iSFMaVgi6z
        A1iucCYhg+0xsBZWRL7pPwC6MwRzIiOg4jwwnoc9ZlymFA65BrJHWGiYw2tc12CRS8btTu
        UpqgOXhh5TH2PDWnyQ5CFWSlXIQZwGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-eNzVXANmNhGMB7xZfIAr0A-1; Wed, 03 Feb 2021 14:32:14 -0500
X-MC-Unique: eNzVXANmNhGMB7xZfIAr0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8A64C7405;
        Wed,  3 Feb 2021 19:32:12 +0000 (UTC)
Received: from krava (unknown [10.40.196.3])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2A286709A9;
        Wed,  3 Feb 2021 19:32:11 +0000 (UTC)
Date:   Wed, 3 Feb 2021 20:32:10 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf tools: Resolve symbols against debug file first
Message-ID: <YBr6OmBom/381V5s@krava>
References: <20210113080128.10286-1-jslaby@suse.cz>
 <20210113104618.GB1331835@krava>
 <d6001540-c028-8728-413b-273a11d00ffe@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6001540-c028-8728-413b-273a11d00ffe@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 11:43:07AM +0100, Jiri Slaby wrote:
> On 13. 01. 21, 11:46, Jiri Olsa wrote:
> > On Wed, Jan 13, 2021 at 09:01:28AM +0100, Jiri Slaby wrote:
> > > With LTO, there are symbols like these:
> > > /usr/lib/debug/usr/lib64/libantlr4-runtime.so.4.8-4.8-1.4.x86_64.debug
> > >   10305: 0000000000955fa4     0 NOTYPE  LOCAL  DEFAULT   29 Predicate.cpp.2bc410e7
> > > 
> > > This comes from a runtime/debug split done by the standard way:
> > > objcopy --only-keep-debug $runtime $debug
> > > objcopy --add-gnu-debuglink=$debugfn -R .comment -R .GCC.command.line --strip-all $runtime
> > > 
> > > perf currently cannot resolve such symbols (relicts of LTO), as section
> > > 29 exists only in the debug file (29 is .debug_info). And perf resolves
> > > symbols only against runtime file. This results in all symbols from such
> > > a library being unresolved:
> > >       0.38%  main2    libantlr4-runtime.so.4.8  [.] 0x00000000000671e0
> > > 
> > > So try resolving against the debug file first. And only if it fails (the
> > > section has NOBITS set), try runtime file. We can do this, as "objcopy
> > > --only-keep-debug" per documentation preserves all sections, but clears
> > > data of some of them (the runtime ones) and marks them as NOBITS.
> > > 
> > > The correct result is now:
> > >       0.38%  main2    libantlr4-runtime.so.4.8  [.] antlr4::IntStream::~IntStream
> > > 
> > > Note that these LTO symbols are properly skipped anyway as they belong
> > > neither to *text* nor to *data* (is_label && !elf_sec__filter(&shdr,
> > > secstrs) is true).
> > > 
> > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Cc: Jiri Olsa <jolsa@redhat.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >   tools/perf/util/symbol-elf.c | 10 +++++++++-
> > >   1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > > index f3577f7d72fe..a31b716fa61c 100644
> > > --- a/tools/perf/util/symbol-elf.c
> > > +++ b/tools/perf/util/symbol-elf.c
> > > @@ -1226,12 +1226,20 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
> > >   		if (sym.st_shndx == SHN_ABS)
> > >   			continue;
> > > -		sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
> > > +		sec = elf_getscn(syms_ss->elf, sym.st_shndx);
> > >   		if (!sec)
> > >   			goto out_elf_end;
> > 
> > we iterate symbols from syms_ss, so the fix seems to be correct
> > to call elf_getscn on syms_ss, not on runtime_ss as we do now
> > 
> > I'd think this worked only when runtime_ss == syms_ss
> > 
> > >   		gelf_getshdr(sec, &shdr);
> > > +		if (shdr.sh_type == SHT_NOBITS) {
> > > +			sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
> > > +			if (!sec)
> > > +				goto out_elf_end;
> > > +
> > > +			gelf_getshdr(sec, &shdr);
> > > +		}
> > 
> > is that fallback necessary? the symbol is from syms_ss
> 
> To resume this and answer:
> 
> Yes, the fallback is necessary.
> 
> It's because syms_ss section header has NOBITS set for the sections, so file
> offset is not incremented. So shdr.sh_offset (the file offset) used further
> in dso__load_sym has different values for syms and runtime. The syms_ss (the
> NOBITS) one is invalid as it has 0x1000 here. The runtime one contains good
> values (like 000509d0 here):
> 
> .text         00082560  00000000000509d0  00000000000509d0  [-00001000-]
> {+000509d0+}  2**4
> 
> That is, without the fallback, the computed symbol address is wrong.

thanks for explanation, could you please put this comment in the code?

thanks,
jirka

