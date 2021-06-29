Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF723B78E0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 21:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbhF2Txy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 15:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbhF2Txu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:53:50 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B4DC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 12:51:22 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id x1so264645vsc.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 12:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NG+cTGXBqzzgiSWpwuEcT/DJIG7xsjC2R4cbzn21sWw=;
        b=T8glcQ5gYHLw0BnH680qzcdu/YzNcmgzmPrpxSqvyPOrr0cVD8rdwIJtxqazrQhRFm
         8f1yB/SHBje4S3iWG2QM5lQsuG7AgLTQSXn4r2VrQ8DBdM+UVW3QLkxmgagFoMwtFyrJ
         iqWGGW3g8rrpes98kLPlacOrz5T8pQ5RFA3uBmulHkIHjVyyyXWnl04EfedM1H4ROFEF
         cMzlyPOVKvgc1Etfcz2Mpn6zKGEl18LA1xu/NI09AiIvKNkQr2F1FuvCnbNWAMB8NLjJ
         hlJ08+mWbv0raT5b3vR3RPNihAT2Dvx5Om6IpJHpq2iZDrOVME/KxQqXzr+n6SZz/wpN
         XDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NG+cTGXBqzzgiSWpwuEcT/DJIG7xsjC2R4cbzn21sWw=;
        b=e1EeMuSDxVdEot7VeqBZP4+8rO3hLBllMf3xb17BUybid6dEKO9o06+8WzGI5c724K
         SLpKtsGzZ1+YIHvcerMF3K0McxNTFzwb5jIn24DScNj3CSYVcVigQsQBMOIYhenTJ+ka
         DTZyrpAN3IHi0hop64bdkPm2GHTxlgCLnr0XLFun2GsqApx4XDyMVUyFkU9HEBmNx1uv
         VmImUr22pdEXch6o/32XZCn8nR9izbyPNzkTcMQRKCTtuHNQycF2h4wT5i9ex/91ejBj
         tQZKcyLLjhAmu53inBDoGCECEzpQb6SNWp+OUCusNRMKoqXjRGPncVMMpg3vfElObspY
         KXkA==
X-Gm-Message-State: AOAM530C13qxJWK2wbVzoOuTjkJ8h172DLBxu0tP9wj+zZQOLabxuYmC
        cEWiDjO7ccSCEXsvXRhLDS1sEafscBBAJ1rIemA=
X-Google-Smtp-Source: ABdhPJxiigY8231l2NlphZBpvEmAesBozWCt9s43Y+7dxf/Upa9RqPgPT+y+Y7q3+18u7z8izy5XVJrRpj43PEC2nak=
X-Received: by 2002:a67:ed4a:: with SMTP id m10mr26461401vsp.56.1624996280934;
 Tue, 29 Jun 2021 12:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210626034016.170306-1-jim.cromie@gmail.com> <20210626034016.170306-2-jim.cromie@gmail.com>
 <075e07c40b99f93123051ef8833612bc88a55120.camel@perches.com>
 <CAJfuBxxzBevMJYSWq5feO20S4h_T-+EZoifOTYJ1NB4B+J1hqQ@mail.gmail.com>
 <CAJfuBxywc=oc00F7b=dJU9y_vgrncCUYzvLNgM5VaMsuOiDAyg@mail.gmail.com> <5d28704b131e375347f266b10fc54891ba2a4fc4.camel@perches.com>
In-Reply-To: <5d28704b131e375347f266b10fc54891ba2a4fc4.camel@perches.com>
From:   jim.cromie@gmail.com
Date:   Tue, 29 Jun 2021 13:50:54 -0600
Message-ID: <CAJfuBxyQ8OX8+A64SQPG4pXYKBDhyab7_-Dcc_C2_t-4oG9xng@mail.gmail.com>
Subject: Re: [PATCH 1/3] checkpatch: skip spacing tests on linker scripts
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 12:28 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2021-06-29 at 10:48 -0600, jim.cromie@gmail.com wrote:
> > hi Joe,
>
> hey Jim.
>
> > > > This .lds.h test is also used in one other place.
> > > >
> > > > It might be better to avoid all tests in .lds.h files by using a
> > > > "next if" much earlier.
> >
> > checkpatch: subtle decrufting
> >
> > sub process() uses a next-if statement to end a block of tests early,
> > because following tests pertain only to certain types of source files.
> > That statement has some history:
> >
> >  $ grep -P 'sub process|next if \(\$realfile' blame-check
> >  0a920b5b666d0 (Andy Whitcroft      2007-06-01 00:46:48 -0700 2558) sub process {
> >  d6430f71805aa (Joe Perches         2016-12-12 16:46:28 -0800 3621) next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts)$/);
> >  de4c924c26504 (Geert Uytterhoeven  2014-10-13 15:51:46 -0700 3712) next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
>
> Looks like I should have also removed the |pl from this block
> when I removed it from commit d6430f71805aa.
>
> Oh well, no real harm done...
>
> >  b9ea10d691ecb (Andy Whitcroft      2008-10-15 22:02:24 -0700 3973) next if ($realfile !~ /\.(h|c)$/);
> >
> > Commit:b9ea adds the early-block-termination line, then 2 subsequent
> > commits (de4c, d643) copy that line up/earlier in sub process (with
> > different filetype selection), largely masking the purposes of the
> > older/later lines (block-early-terminate to skip file-type specific
> > tests).
>
> Not really.
>
> The first in file order next-if commit d6430f71805aa was a
> modification of the earlier commits listed below:
>
> 5368df20fb364e
> 00df344fd06fd6
> 0a920b5b666d0b
>
> All of these were just additions of various file types to the test.
>
> > This code is hurting my brain.
>
> Perhaps Advil or another leaded or unleaded beverage might help.
> They help me...
>
> > changing d643 to allow *.pl to fall thru for further testing
> > is probably the best small move.
>
> Definitely not as it's there specifically to avoid long line tests in perl.
>

Ok, I see that..  its all pretty subtle.


> > FWIW, one version of a 1-line fix for *.lds.h files.
> > this one adds the new line after the 1st of the 3 blame-lines.
> > Maybe it should be added after the SPDX check (which would complain)
>

I tried that 1-liner : next if lds.h
after each of those 3 blame-lines,  the latter 2 have effect
(subtracting errors)
the first doesnt improve on the later one.


[jimc@frodo wk-other]$ git log
commit 6825b43bae4cd51808050de3769f1d3df5b0bc76 (HEAD -> checkpatch-2)
Author: Jim Cromie <jim.cromie@gmail.com>
Date:   Tue Jun 29 12:34:40 2021 -0600

    checkpatch: skip more tests on linker scripts

    before:
    total: 1 errors, 7 warnings, 1152 lines checked

    after:
    total: 0 errors, 1 warnings, 1152 lines checked

commit a9f9a26a299097f9b6524a25681cc45c04aec6b5
Author: Jim Cromie <jim.cromie@gmail.com>
Date:   Tue Jun 29 12:31:29 2021 -0600

    checkpatch: skip (c|h) tests on linker scripts

    testing with:
    $ scripts/checkpatch.pl -f include/asm-generic/vmlinux.lds.h

    before:
    total: 18 errors, 8 warnings, 1152 lines checked

    after:
    total: 1 errors, 7 warnings, 1152 lines checked




> Maybe a slight reworking of all the "next if" tests would work.
>
> I moved the incorrect spdx line number test up, but didn't test
> whether or not it's appropriate here as I don't know of a case
> of the top of my head.  I also don't know if the linker .lds.h
> files should be tested for long lines or not.

ISTM the -f option is that test-case - use existing file ( vmlinux.lds.h )
as that reference, since it exists, everything in it is "approved style"

The current reference elicits 18 errors and 8 warnings,
ISTM those tests are inappropriate for this kind of file.


>
> It looks like these files are mostly < 80 columns
>
> $ git ls-files -- '*.lds.h'| xargs cat | awk '{print length($0), $0;}' | sort -rn | head
> 106 #define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
> 94 #if defined(CONFIG_GCOV_KERNEL) || defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN) || \
> 79 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
> 78  * [__init_begin, __init_end] is the init section that may be freed after init
> 78 #if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
> 77  * .init section and thus will be preserved for later use in the decompressed
> 77 #define RESERVEDMEM_OF_TABLES()      OF_TABLE(CONFIG_OF_RESERVED_MEM, reservedmem)
> 77  * <asm/module.lds.h> can specify arch-specific sections for linking modules.
> 76 #define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
> 76  * .boot.data variables are kept in separate .boot.data.<var name> sections,
>
> ---
>  scripts/checkpatch.pl | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)


this does 3 different things

- non-capturing matches  -  these add no functionality,

- moves the skip-remaining-tests check after SPDX
   that feels like a legal Q: should it be on all files ?
   moving it does seem proper though.

- adds the skip linker-script
  since i went ahead and added it 3 times to see errs/warns
  I didnt consider your precise placement,
  how does it do with 18/8 errs/warnings on ref-test ?


>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 461d4221e4a4a..ea198499e16df 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3617,9 +3617,6 @@ sub process {
>                              "It's generally not useful to have the filename in the file\n" . $herecurr);
>                 }
>
> -# check we are in a valid source file if not then ignore this hunk
> -               next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts)$/);
> -
>  # check for using SPDX-License-Identifier on the wrong line number
>                 if ($realline != $checklicenseline &&
>                     $rawline =~ /\bSPDX-License-Identifier:/ &&
> @@ -3628,6 +3625,9 @@ sub process {
>                              "Misplaced SPDX-License-Identifier tag - use line $checklicenseline instead\n" . $herecurr);
>                 }
>
> +# check we are in a valid source file if not then ignore this hunk
> +               next if ($realfile !~ /\.(?:h|c|s|S|sh|dtsi|dts)$/);
> +
>  # line length limit (with some exclusions)
>  #
>  # There are a few types of lines that may extend beyond $max_line_length:
> @@ -3708,8 +3708,8 @@ sub process {
>                              "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/asm-annotations.rst\n" . $herecurr);
>                 }
>
> -# check we are in a valid source file C or perl if not then ignore this hunk
> -               next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
> +# check we are in a valid source C or .dts? file, if not then ignore this hunk
> +               next if ($realfile !~ /\.(?:h|c|dtsi|dts)$/);
>
>  # at the beginning of a line any tabs must come first and anything
>  # more than $tabsize must use tabs.
> @@ -3737,6 +3737,9 @@ sub process {
>                         }
>                 }
>
> +# skip all following test for linker files.
> +               next if ($realfile =~ /\.lds\.h$/);
> +
>  # check for assignments on the start of a line
>                 if ($sline =~ /^\+\s+($Assignment)[^=]/) {
>                         my $operator = $1;
> @@ -3970,7 +3973,7 @@ sub process {
>                 }
>
>  # check we are in a valid C source file if not then ignore this hunk
> -               next if ($realfile !~ /\.(h|c)$/);
> +               next if ($realfile !~ /\.(?:h|c)$/);
>
>  # check for unusual line ending [ or (
>                 if ($line =~ /^\+.*([\[\(])\s*$/) {
>
