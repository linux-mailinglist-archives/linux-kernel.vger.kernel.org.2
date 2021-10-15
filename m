Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4561542E582
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 02:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbhJOA5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 20:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhJOA5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:57:16 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AC0C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:55:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso510653pjw.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3+5b06haTPMyGtomaiqAwErioMcClLD7g8Ln+zY+qQ4=;
        b=Q750YQILdfzpohGDrnI1r7WzNcoHQNL4HeozRXQA6yPy3mwf0PDnZT6veY4owUzd4U
         y1taUbA9pO1kERe8PW6zQu9JCU4dkVZfVF3AGA8EjxhjDlxv7H6g1TH2zYU8U+uO3Rnr
         vF6pFmk4Y43+7ZVnZMb/lK9spxzfm9oR4Hp0s+WFrexJ2++SH1GDZ22TSThftAkegRh2
         FtVl+2lqIps0+agfw1L9B+IWKerrKNQLJnCT8oeH8/qImGXAW4dY2yjoDRxEumyv9wgE
         TminGtVI3vlo9zX7cW+T3zY7PMUaMd51Kd2LwJUxr98LFuF/V/9QGvFmmzPYe10pgn74
         673w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3+5b06haTPMyGtomaiqAwErioMcClLD7g8Ln+zY+qQ4=;
        b=LaM8bC7h5mP/NVnGyGj5N4qB+kPIWy+4LfHXF0Idmotd9jk0VxIEHUG80PfzQILr1K
         bIY6ZH3HsGsIlSjSHfv5hhM63Gwq72FtXvZu+YuXLH7Qdkg+1CYBOG4fOCzEX8osrTN7
         B14axhUgE6BfZjydCmh7tTjdtWURUFNIRTuJiAeyJCqIGWoG/vkebhv1hMyOFwd6FI52
         fAomkflJBbDPiukgcUaDIjAfvVEk3GtOMdXCbeEwYVuRcxtmFsflKUxZ2xd7MP1tyGXr
         vJG+IiqV9ypGszX+grIfxDJ8EVp5RHRvPzYHwnKAuVZSTFjrSxumTy60mKGxGnrTK0mm
         AaKg==
X-Gm-Message-State: AOAM532EENFtevKUfKSMSanhbi0w41niHlUFP/5/gpjchAywlyfmFqIg
        yuPNUVtVWSZ9kSZ7Ph07i6pr53s1W8IinuekC9w=
X-Google-Smtp-Source: ABdhPJyrD5spv8jJGt19Jk773G8ziuWAxUbYKTnwqJTDPSRF079szbF8wTmnLFZZOVJS8qDF6aR6/2NJyrSKhqXBkpQ=
X-Received: by 2002:a17:90a:7345:: with SMTP id j5mr24394426pjs.48.1634259310278;
 Thu, 14 Oct 2021 17:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211014143507.4ad2c0f7@gandalf.local.home>
In-Reply-To: <20211014143507.4ad2c0f7@gandalf.local.home>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 15 Oct 2021 08:54:35 +0800
Message-ID: <CAEbi=3d=yO+D_SjQavqizc2tHyWda3t9zXbN84cbvYYNP=epKA@mail.gmail.com>
Subject: Re: [PATCH] nds32/ftrace: Fix Error: invalid operands (*UND* and
 *UND* sections) for `^'
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Zong Li <zong@andestech.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Alan Kao <alankao@andestech.com>, kclin@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=8815=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=882:35=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> [ Resending with "PATCH" in subject ]
>
> I received a build failure for a new patch I'm working on the nds32
> architecture, and when I went to test it, I couldn't get to my build erro=
r,
> because it failed to build with a bunch of:
>
>   Error: invalid operands (*UND* and *UND* sections) for `^'
>
> issues with various files. Those files were temporary asm files that look=
ed
> like:  kernel/.tmp_mc_fork.s
>
> I decided to look deeper, and found that the "mc" portion of that name
> stood for "mcount", and was created by the recordmcount.pl script. One th=
at
> I wrote over a decade ago. Once I knew the source of the problem, I was
> able to investigate it further.
>
> The way the recordmcount.pl script works (BTW, there's a C version that
> simply modifies the ELF object) is by doing an "objdump" on the object
> file. Looks for all the calls to "mcount", and creates an offset of those
> locations from some global variable it can use (usually a global function
> name, found with <.*>:). Creates a asm file that is a table of references
> to these locations, using the found variable/function. Compiles it and
> links it back into the original object file. This asm file is called
> ".tmp_mc_<object_base_name>.s".
>
> The problem here is that the objdump produced by the nds32 object file,
> contains things that look like:
>
>  0000159a <.L3^B1>:
>     159a:       c6 00           beqz38 $r6, 159a <.L3^B1>
>                         159a: R_NDS32_9_PCREL_RELA      .text+0x159e
>     159c:       84 d2           movi55 $r6, #-14
>     159e:       80 06           mov55 $r0, $r6
>     15a0:       ec 3c           addi10.sp #0x3c
>
>
> Where ".L3^B1 is somehow selected as the "global" variable to index off o=
f.
>
> Then the assembly file that holds the mcount locations looks like this:
>
>         .section __mcount_loc,"a",@progbits
>         .align 2
>         .long .L3^B1 + -5522
>         .long .L3^B1 + -5384
>         .long .L3^B1 + -5270
>         .long .L3^B1 + -5098
>         .long .L3^B1 + -4970
>         .long .L3^B1 + -4758
>         .long .L3^B1 + -4122
>         [...]
>
> And when it is compiled back to an object to link to the original object,
> the compile fails on the "^" symbol.
>
> Simple solution for now, is to have the perl script ignore using function
> symbols that have an "^" in the name.
>
> Fixes: fbf58a52ac088 ("nds32/ftrace: Add RECORD_MCOUNT support")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> index 8f6b13ae46bf..7d631aaa0ae1 100755
> --- a/scripts/recordmcount.pl
> +++ b/scripts/recordmcount.pl
> @@ -189,7 +189,7 @@ if ($arch =3D~ /(x86(_64)?)|(i386)/) {
>  $local_regex =3D "^[0-9a-fA-F]+\\s+t\\s+(\\S+)";
>  $weak_regex =3D "^[0-9a-fA-F]+\\s+([wW])\\s+(\\S+)";
>  $section_regex =3D "Disassembly of section\\s+(\\S+):";
> -$function_regex =3D "^([0-9a-fA-F]+)\\s+<(.*?)>:";
> +$function_regex =3D "^([0-9a-fA-F]+)\\s+<([^^]*?)>:";
>  $mcount_regex =3D "^\\s*([0-9a-fA-F]+):.*\\s(mcount|__fentry__)\$";
>  $section_type =3D '@progbits';
>  $mcount_adjust =3D 0;
loop in Alan and KC
