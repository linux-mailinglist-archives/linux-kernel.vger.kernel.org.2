Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15693CBA0B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 17:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240861AbhGPPpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 11:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbhGPPpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 11:45:20 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D455C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 08:42:24 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id m68so9077205qke.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mwp7oTGIXROotf7qHF/Jt3JgjnlhVFvYZWuK3fGjYek=;
        b=oaK833dH5tJcJOsxI5BknMARAG69RYCKufYnST/AIg7Qoji+P332QsKrSpLPcg7Uqo
         zHZFJBHJtI+eJAPc0PjaECZM2G9KvpZtAkopGKmW/tOEeMobtr5LDVJrhQU5nboq/5Jp
         nj5Ez/egp/8yFKRVp6UShxzBTx3IltVfW/vYcfsa+6GYI7893x4N6Vl4bxfW1CsFz9hb
         WYKwiXLdJY08RCeXFZYQrS8tyfd1i+Ud9XsvDlL8O6ORh9ybO1jORlrLqtL2AK5uzstr
         oOxt9d1OYdSXTxDkd+7ZVNkSeJMR9UA5arT5aBSodW0nP1b7i8KKkqmEHQ/3JF5Ar3sF
         9GwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mwp7oTGIXROotf7qHF/Jt3JgjnlhVFvYZWuK3fGjYek=;
        b=SqU5F2w9ZjD8NR1EzpFd2keWk++DuYbIh8LBi/YjeT7u+d13yfKrFB70A4snsMxGXD
         NBvZdCQZ5J7chdEQytMVJFMnw6UsfqMqpW9RgmFK5u38YHBGQD9JaAgXPlVCuoaebfsf
         M/y6tNN9JbGaBFcXlVBc2U2oP06MUczmgao0V/cdr+c9SFjGHVjBzA6KRbg0JfcZwgp9
         mQCt1wpSmcJTxvIPIRGr9pBTQ0lqpK/9Jcp3HyKr0lzmV3H3lcCbmB6IKU7SJh8cSDvv
         +MFWk5PhnBr0EKJFGl+UlRFDIyIn1KuQif3VV/UcJSKkUqCkRInx51RZDKBnPyQJorfe
         sTqQ==
X-Gm-Message-State: AOAM5320FKuqqM03RUW3Ub9w4I8DOuV77Vvz9DwoVb+UYC+/IFI9rkY+
        /QFgO/65ca2oxHwoWhxDcrnZtbDcrWKJYogCU1I=
X-Google-Smtp-Source: ABdhPJxLOzLuQUTQ0KTU8zfSh5h/p8ffFaiFVvWEgI3ujJs00uyDiDVE3B+5rggq4x5BnAdm45uU5PqlAsZ7N7d+we0=
X-Received: by 2002:a37:59c7:: with SMTP id n190mr10444585qkb.146.1626450143390;
 Fri, 16 Jul 2021 08:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <YPGXXt6Z3O1W0AYS@arkam>
In-Reply-To: <YPGXXt6Z3O1W0AYS@arkam>
From:   Khem Raj <raj.khem@gmail.com>
Date:   Fri, 16 Jul 2021 08:41:57 -0700
Message-ID: <CAMKF1spJKc+vyiOg_upfEZmVKzyHCW569yJNYjHD2cJkA_4buA@mail.gmail.com>
Subject: Re: Unknown __always_inline in linux/swab.h
To:     =?UTF-8?Q?Petr_Van=C4=9Bk?= <arkamar@atlas.cz>
Cc:     Denys Vlasenko <dvlasenk@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Chanho Park <parkch98@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Stephane Eranian <eranian@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 7:27 AM Petr Van=C4=9Bk <arkamar@atlas.cz> wrote:
>
> Hi all,
>
> I cannot build the kernel on my box with musl libc since release 5.12,
> see the kernel 5.13.1 build log below.  Bisect points to the commit
> 1d509f2a6ebc ("x86/insn: Support big endian cross-compiles") merged to
> 5.12-rc1, but it probably only triggers the issue from different place.
>
> I searched through the mailing list [1] and it seems that people face to
> a similar issue with perf tool as well [2-5]. Related issues were also
> reported in Gentoo [6] and alpinelinux [7]. Both distributions basically
> fixed it with the patch from [3] which works for me and it is the best
> solution, in my opinion. I believe it should be applied to the upstream
> and backported to 5.12 and 5.13.
>
> Systems with glibc are not affected because glibc defines its own
> __always_inline in sys/cdefs.h which is indirectly included with stdio.h
> and/or stdlib.h in top of tools/objtool/arch/x86/decode.c file.
>
> Note: I CCed you because your address was mentioned in [2-5] or in
> bisected commit.
>

does https://lore.kernel.org/lkml/20181213180129.1373-1-raj.khem@gmail.com/
work for you ?
It was not applied but there were no comments on rejecting it either,
so I guess it either fell through cracks somehow.

> Thanks,
> Petr
>
> References:
>
> [1] https://lore.kernel.org/lkml/?q=3Dswab+__always_inline
> [2] https://lore.kernel.org/lkml/20210204005810.GZ854763@kernel.org/
> [3] https://lore.kernel.org/lkml/1514973450-12447-1-git-send-email-matt.r=
edfearn@mips.com/
> [4] https://lore.kernel.org/lkml/20181213180129.1373-1-raj.khem@gmail.com=
/
> [5] https://lore.kernel.org/lkml/20201210144844.72580-1-chanho61.park@sam=
sung.com/
> [6] https://bugs.gentoo.org/791364
> [7] https://gitlab.alpinelinux.org/alpine/aports/-/issues/11119
>
> Build log:
>
> make[1]: Entering directory '/var/tmp/portage/linux'
>   GEN     Makefile
>   DESCEND objtool
>   CALL    /usr/src/linux-5.13.1-gentoo/scripts/atomic/check-atomics.sh
>   CALL    /usr/src/linux-5.13.1-gentoo/scripts/checksyscalls.sh
>   CC      /var/tmp/portage/linux/tools/objtool/arch/x86/decode.o
>   CC      /var/tmp/portage/linux/tools/objtool/str_error_r.o
>   CC      /var/tmp/portage/linux/tools/objtool/librbtree.o
> In file included from /usr/include/linux/byteorder/little_endian.h:13,
>                  from /usr/include/asm/byteorder.h:5,
>                  from /usr/src/linux-5.13.1-gentoo/tools/arch/x86/include=
/asm/insn.h:10,
>                  from arch/x86/decode.c:10:
> /usr/include/linux/swab.h:136:23: error: expected ';' before 'unsigned'
>   136 | static __always_inline unsigned long __swab(const unsigned long y=
)
>       |                       ^~~~~~~~~
>       |                       ;
> /usr/include/linux/swab.h:171:8: error: unknown type name '__always_inlin=
e'
>   171 | static __always_inline __u16 __swab16p(const __u16 *p)
>       |        ^~~~~~~~~~~~~~~
> /usr/include/linux/swab.h:171:30: error: expected '=3D', ',', ';', 'asm' =
or '__attribute__' before '__swab16p'
>   171 | static __always_inline __u16 __swab16p(const __u16 *p)
>       |                              ^~~~~~~~~
> /usr/include/linux/swab.h:184:8: error: unknown type name '__always_inlin=
e'
>   184 | static __always_inline __u32 __swab32p(const __u32 *p)
>       |        ^~~~~~~~~~~~~~~
> /usr/include/linux/swab.h:184:30: error: expected '=3D', ',', ';', 'asm' =
or '__attribute__' before '__swab32p'
>   184 | static __always_inline __u32 __swab32p(const __u32 *p)
>       |                              ^~~~~~~~~
> /usr/include/linux/swab.h:197:8: error: unknown type name '__always_inlin=
e'
>   197 | static __always_inline __u64 __swab64p(const __u64 *p)
>       |        ^~~~~~~~~~~~~~~
> /usr/include/linux/swab.h:197:30: error: expected '=3D', ',', ';', 'asm' =
or '__attribute__' before '__swab64p'
>   197 | static __always_inline __u64 __swab64p(const __u64 *p)
>       |                              ^~~~~~~~~
> /usr/include/linux/swab.h:252:23: error: expected ';' before 'void'
>   252 | static __always_inline void __swab32s(__u32 *p)
>       |                       ^~~~~
>       |                       ;
> /usr/include/linux/swab.h:265:23: error: expected ';' before 'void'
>   265 | static __always_inline void __swab64s(__u64 *p)
>       |                       ^~~~~
>       |                       ;
> In file included from /usr/include/asm/byteorder.h:5,
>                  from /usr/src/linux-5.13.1-gentoo/tools/arch/x86/include=
/asm/insn.h:10,
>                  from arch/x86/decode.c:10:
> /usr/include/linux/byteorder/little_endian.h:44:8: error: unknown type na=
me '__always_inline'
>    44 | static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
>       |        ^~~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:44:31: error: expected '=3D'=
, ',', ';', 'asm' or '__attribute__' before '__cpu_to_le64p'
>    44 | static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
>       |                               ^~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:48:8: error: unknown type na=
me '__always_inline'
>    48 | static __always_inline __u64 __le64_to_cpup(const __le64 *p)
>       |        ^~~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:48:30: error: expected '=3D'=
, ',', ';', 'asm' or '__attribute__' before '__le64_to_cpup'
>    48 | static __always_inline __u64 __le64_to_cpup(const __le64 *p)
>       |                              ^~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:52:8: error: unknown type na=
me '__always_inline'
>    52 | static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
>       |        ^~~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:52:31: error: expected '=3D'=
, ',', ';', 'asm' or '__attribute__' before '__cpu_to_le32p'
>    52 | static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
>       |                               ^~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:56:8: error: unknown type na=
me '__always_inline'
>    56 | static __always_inline __u32 __le32_to_cpup(const __le32 *p)
>       |        ^~~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:56:30: error: expected '=3D'=
, ',', ';', 'asm' or '__attribute__' before '__le32_to_cpup'
>    56 | static __always_inline __u32 __le32_to_cpup(const __le32 *p)
>       |                              ^~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:60:8: error: unknown type na=
me '__always_inline'
>    60 | static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
>       |        ^~~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:60:31: error: expected '=3D'=
, ',', ';', 'asm' or '__attribute__' before '__cpu_to_le16p'
>    60 | static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
>       |                               ^~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:64:8: error: unknown type na=
me '__always_inline'
>    64 | static __always_inline __u16 __le16_to_cpup(const __le16 *p)
>       |        ^~~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:64:30: error: expected '=3D'=
, ',', ';', 'asm' or '__attribute__' before '__le16_to_cpup'
>    64 | static __always_inline __u16 __le16_to_cpup(const __le16 *p)
>       |                              ^~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:68:8: error: unknown type na=
me '__always_inline'
>    68 | static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
>       |        ^~~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:68:31: error: expected '=3D'=
, ',', ';', 'asm' or '__attribute__' before '__cpu_to_be64p'
>    68 | static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
>       |                               ^~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:72:8: error: unknown type na=
me '__always_inline'
>    72 | static __always_inline __u64 __be64_to_cpup(const __be64 *p)
>       |        ^~~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:72:30: error: expected '=3D'=
, ',', ';', 'asm' or '__attribute__' before '__be64_to_cpup'
>    72 | static __always_inline __u64 __be64_to_cpup(const __be64 *p)
>       |                              ^~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:76:8: error: unknown type na=
me '__always_inline'
>    76 | static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
>       |        ^~~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:76:31: error: expected '=3D'=
, ',', ';', 'asm' or '__attribute__' before '__cpu_to_be32p'
>    76 | static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
>       |                               ^~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:80:8: error: unknown type na=
me '__always_inline'
>    80 | static __always_inline __u32 __be32_to_cpup(const __be32 *p)
>       |        ^~~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:80:30: error: expected '=3D'=
, ',', ';', 'asm' or '__attribute__' before '__be32_to_cpup'
>    80 | static __always_inline __u32 __be32_to_cpup(const __be32 *p)
>       |                              ^~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:84:8: error: unknown type na=
me '__always_inline'
>    84 | static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
>       |        ^~~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:84:31: error: expected '=3D'=
, ',', ';', 'asm' or '__attribute__' before '__cpu_to_be16p'
>    84 | static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
>       |                               ^~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:88:8: error: unknown type na=
me '__always_inline'
>    88 | static __always_inline __u16 __be16_to_cpup(const __be16 *p)
>       |        ^~~~~~~~~~~~~~~
> /usr/include/linux/byteorder/little_endian.h:88:30: error: expected '=3D'=
, ',', ';', 'asm' or '__attribute__' before '__be16_to_cpup'
>    88 | static __always_inline __u16 __be16_to_cpup(const __be16 *p)
>       |                              ^~~~~~~~~~~~~~
> make[5]: *** [/usr/src/linux-5.13.1-gentoo/tools/build/Makefile.build:97:=
 /var/tmp/portage/linux/tools/objtool/arch/x86/decode.o] Error 1
> make[4]: *** [/usr/src/linux-5.13.1-gentoo/tools/build/Makefile.build:139=
: arch/x86] Error 2
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [Makefile:56: /var/tmp/portage/linux/tools/objtool/objtool-i=
n.o] Error 2
> make[2]: *** [Makefile:69: objtool] Error 2
> make[1]: *** [/usr/src/linux-5.13.1-gentoo/Makefile:1974: tools/objtool] =
Error 2
> make[1]: Leaving directory '/var/tmp/portage/linux'
> make: *** [Makefile:215: __sub-make] Error 2
