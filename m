Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9976437EEEA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345776AbhELW0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 18:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443298AbhELWR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 18:17:28 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553DAC061351
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 15:08:42 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id o192so12761564vsd.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 15:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m8Z9v9rqwpkIhm5d0T1tD8MPHQ9hhGCiPTcb09mMSfI=;
        b=W4QGlfjflsVJ+sMxfmG+MJUqumYQi5f6pujcnwHC7DQqimNu8GFUb/VGUu+uzd25pN
         AAipLswYxLg3Aq++XWgKQ83W7BO+k5zUGaLrBJSwfnU+ydx88FEJpL4A4F85QMJJSLCH
         BlsxseB0++gsNYf+2EVu/z+PmeXbkVSKkycp8JLS4LxeIlbp5YKBWdgilpBgAOd1YXUn
         14mCrw931FU50DOp7Keg4ayRKhTbGOqX7cGuZCvQhy+c/Ii4IxamBgpYKCsF5sHr8o7B
         k7Hc5XU1teuSJ53L6HT043B9KwCSjI/UByV2syzNWoSvtvbvuty8kfTevNnrnLh6Jfbe
         8q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8Z9v9rqwpkIhm5d0T1tD8MPHQ9hhGCiPTcb09mMSfI=;
        b=fZHu5Hnw5n8u3ReT1jWB371LEy0d2UjSd+IYNZQE+k3gFkt+b3pTM2YKJJC+lpsYEK
         UbJ2M2QQKI9yHypmZFrfwnUE+Qc9ClaJUejE/nNFsP5TPjh9V79MaLgl50Mw1Kgq3Aq1
         HRn1HPFIzgP7qpdQi5KZpjpDXULnvV/Xwkq2ZD+SICD6oFoQr3E6nMQQypGCjTqXN9o3
         yP36Umc8p9/j1Qq3We8RD7tQV1Cg+aD/Rxb+LemNwZj7+vZGOASOaaBl0nsEmsdk2LEN
         xbd81PLuSjOncELs+oxo/pUlb7nEhoDIzjXsQKVJlH4fZcgVw8+PbfsGyWaSxgkdFpnu
         8wLg==
X-Gm-Message-State: AOAM5300lP3FMu8UQWuYhbu64/r4MHPZJlXilxMmDKOY/xPY4AdYFEwC
        YrP79Bk3vVybykhT5IVoLV977V1IbuzyStngMlIU8P3SjYTDeg==
X-Google-Smtp-Source: ABdhPJw5o6z2hDIdhak5ujNCXs5EM/+apPufeTuNDWjxy+JDU4dZVRgcnQM9NOlxuMul+i8fDijrtS7ZtIIp9g+WOxA=
X-Received: by 2002:a67:d48e:: with SMTP id g14mr20967507vsj.7.1620857321123;
 Wed, 12 May 2021 15:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
From:   jim.cromie@gmail.com
Date:   Wed, 12 May 2021 16:08:15 -0600
Message-ID: <CAJfuBxyjfopQMzMyFrrZK7YppsL8kh0VVWySrJDXeUB15uwFag@mail.gmail.com>
Subject: Fwd: [RFC PATCH v5 00/28] dynamic debug diet plan
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I appear to have not used git send-email quite right,
0000-cover didnt get to lkml.

Andi, you expressed curiosity re v3

---------- Forwarded message ---------
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, May 11, 2021 at 12:51 PM
Subject: [RFC PATCH v5 00/28] dynamic debug diet plan
To:
Cc: <linux-mm@kvack.org>, Jim Cromie <jim.cromie@gmail.com>


DYNAMIC_DEBUG has extra weight/memory in its data table/section; its
(module,filename,function) columns have ordered, repeating data
(90%,55%,45%), and is highly compressible (~110/300) with simple RLE.

On my i7 laptop, the compressible chunk is ~70kb, This patchset
prepares for compression, but doesn't try it; RFC.  Using that RLE
compression estimate, we could save ~45kb; Id hope for better with ZSTD.

Series Overview:

1st, split the struct _ddebug & __dyndbg elf section into 2, moving
compressible fields into their own section/array/block.  A temporary
site pointer connects the 2 halves of the composite callsite, it will
be obsoleted later, after we verify our replacement against it, we can
drop the .site pointer.

table change:
 from:  [ key,mod,func,filenm,fmt,ln,flg ]
 into:  [ key,fmt,ln,flg,site-> ]       [ mod,func,filenm ]

2nd, make the 'site' data optional.  The "module:function:line"
log-message prefix is fundamentally an optional decoration, if we can
do without it, we simplify codepath, and we could drop the storage in
those cases, possibly reducing memory footprint.

 into:  [ key,fmt,ln,flg,site->? ]  0

Then things get more interesting:

3rd, make kernel/module handle "__dyndbg_sites" ELF section (which was
added in 1) as is already done for "__dyndbg".

Hide/replace ->site with site_get/_put api
this will let us retrieve site info from compressed storage.

Add _index.
gives us the fixed offset from __dyndbg[N] to __dyndbg[0].

 into:  [ key,fmt,ln,flg,_index,site->? ]  0

Add table/header record-pair.
These 2 records are created into ".gnu.linkonce.dyndbg*" sections.
The linker script places these 2 sections in front of their respective
"__dyndbg*" sections.
So this header-pair becomes __dyndbg[0], __dyndbg_sites[0].
we can use __dyndbg[0]->site[N] to get the site info.

module.lds.h - insert ".gnu.linkonce.dyndbg*" sections into "__dyndbg*".
Without this, headers arent part of the sections that kernel/module loads.

validate ddebug_site_get() invariants.
prove that our indirection to ->site[N] is correct.
BUG_ON uses survived 0-day tests.
they go away with !SITE_CHK

 into:
    0:  [ ...,_index,site-> ]           --->  0:[ ... ]
                ^
  ..N:  [ key,fmt,ln,flg,_index ]             N:[ ... ]

specialize header from _ddebug, keep header.site, drop _ddebug.site
RFC: needs refinement, better type choices?


Status:
  recent revs passed 0day compile grind, including BUG_ONs
  I got one KASAN report, quick reproduction failed, none more recently
  memory footprint is same as master.

Whats Next ? Compression: RFC !!!

POC: could compress during __init, decompress on-demand.  Doing this
would give something to decompress, to build out that code.

ISTM Compression during build is best, but targets are unclear:
initrd, initramfs, cpio, FW-blob all seem suitable at some level, but
so does (ro) zram & zswap.  How should I think about this ?

Also, I understand that support exists for compressed elf sections, I
dunno if/how kernel uses it currently, which would considerably ease
this.  Builtin __dyndbg_site data is in .data, probably needs to be
moved to a separate elf section to get generic tool support for
compressed sections.

It would be nice if a compressed "__dyndbg_sites" elf section could be
loaded by unchanged kernel/module.c.  A magic number in the attached
memory block could distinguish it from the current elf block.  There
is room in the 2 header records for new private data; we could store
decompression contexts there while iterating thru a block.

Decompression - a few use-cases:

= for builtins, each loadable module:
1- stream, for `cat control` etc.
   these are 1 visit and forget
2- `module foo +mfp > control` - enable contiguous blocks w decorations
3- pr_debug - semi-random access - by (ptr - _index)
   [0-5k] for builtin pr-debugs, [0-20] for most loadable modules
   _index is 16 bit currently

Simplest, minimum-memory strategy is late-fetch; to wait until a
pr_debug is actually called, then check flags before fetching the
site-rec, and save it to a hash on modname+_index (and delete on -p).
Without the save, it works for (1) too.

The only downside with late-fetch is that during pr_debug, a 1st fetch
of site-info maybe cant come from io/zswap without locking/latency
concerns.  A forced-prefetch ala (2) with a new flag '!' could work
around this, but might look like a wart.

So thats it. I hope its clear and concise.

Jim Cromie (28):

trivial cleanup:
  dyndbg: avoid calling dyndbg_emit_prefix when it has no work
  dyndbg: drop uninformative vpr_info

split to 2 vectors of callsite:
  dyndbg: split struct _ddebug's display fields to new _ddebug_site
  dyndbg: __init iterate over __dyndbg & __dyndbg_site in parallel

make site info optional:
  dyndbg: refactor part of ddebug_change to ddebug_match_site
  dyndbg: accept null site in ddebug_match_site
  dyndbg: hoist ->site out of ddebug_match_site
  dyndbg: accept null site in ddebug_change
  dyndbg: accept null site in dynamic_emit_prefix
  dyndbg: accept null site in ddebug_proc_show
  dyndbg: refactor ddebug_alter_site out of ddebug_change
  dyndbg: allow deleting site info via control interface

interesting:
  dyndbg+module: expose ddebug_sites to modules
  dyndbg: add ddebug_site(_get|_put) abstraction
  dyndbg: ddebug_add_module avoid adding empty modules
  dyndbg: add _index to struct _ddebug
  dyndbg: prevent build bugs via -DNO_DYNAMIC_DEBUG_TABLE
  dyndbg: RFC - DEFINE_DYNAMIC_DEBUG_TABLE
  dyndbg: RFC handle __dyndbg* sections in module.lds.h
  dyndbg: ddebug_add_module() handle headers.
  dyndbg: validate ddebug_site_get invariants
  dyndbg: fix NULL deref after deleting sites
  dyndbg: dont show header records in control
  dyndbg: make site pointer and checks on it optional (not quite)
  dyndbg: swap WARN_ON for BUG_ON see what 0-day says
  dyndbg: fixup protect header when deleting site
  dyndbg: unionize _ddebug*_headers with struct _ddebug*
  dyndbg: drop _ddebug.site pointer

 arch/arm/boot/compressed/Makefile     |   2 +
 arch/sparc/vdso/Makefile              |   2 +
 arch/x86/boot/compressed/Makefile     |   1 +
 arch/x86/entry/vdso/Makefile          |   3 +
 arch/x86/purgatory/Makefile           |   1 +
 drivers/firmware/efi/libstub/Makefile |   3 +-
 include/asm-generic/module.lds.h      |  12 +-
 include/asm-generic/vmlinux.lds.h     |  24 +-
 include/linux/dynamic_debug.h         | 135 ++++++++--
 kernel/module-internal.h              |   1 +
 kernel/module.c                       |   9 +-
 lib/dynamic_debug.c                   | 363 +++++++++++++++++++-------
 12 files changed, 437 insertions(+), 119 deletions(-)

--
2.31.1
