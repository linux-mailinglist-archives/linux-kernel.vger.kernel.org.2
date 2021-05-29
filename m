Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77601394DFB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhE2UCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhE2UCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:02:20 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B533FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:00:42 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so6977485oth.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kYzzI4lVon/TxpFK6Nqj5+4lyPJ7jIor5Ufde4NVpmo=;
        b=jC3QVFY9/GpMw48TUwMjAsQNciaDoOLmpeJ6UmdPf+APbetERFPfD2cciEgEzeBmYC
         4HZ1ti5uscJN/HkZjPDWZK+xIMgFdQkuozHfAVv+qLY6ggzbYjp78kZiRQTboHwf3jOF
         tB3mdoDxCZfpSz+PGg4op2540ftBRzgA+oxE5/RHJ5YbzuhwySQmpmK9Zt9WRjcfIbYz
         qP/Lwq/xkA2l24fGklmYsfC6AxdqBVR9aUklpbpxRqnkSubq10O2K2JL5iFT5hTj4NZj
         8cueTZauv/cb2+hgoLQL8KbYxUd5ebyRUAID/VwkBUKYWzbeh3awEYG5Cq+TtsbtbJGg
         jTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kYzzI4lVon/TxpFK6Nqj5+4lyPJ7jIor5Ufde4NVpmo=;
        b=cIb1jDP3y9BhYuE1vHDwCdnjzFLg3tysLbURpNAZ4rTQkJUUHe4qtUdT96ZY8wd0vr
         aPfSUFFNS38VLxiUXz567zgfvjx9NCtPe4WEyatb9wcBNjn5BV4JmFBsXC72ReltZ0x2
         soAOO8TX1M/ov084KtXsNgWeN3+JdY8C2CToQAOa/DiyNGpZuDAwrGkm/gYt98dxEqcv
         2p80OURM2gLQi+vQa00/K8gX00PEVKLHc9ae5R8QuqIxXDctJ8eSdbMEu+ci5JQklHKy
         hHKX0hu1EcRfvus6/U3SdqQsW1UmwikHZsgz18CG3CRTTTz6wQTycW1/IQMJjeW6kEQt
         Crbg==
X-Gm-Message-State: AOAM532GX4Y+9ByI6c/bM7sp4b35TJ34Rl6rS6BK2dKfqJzXnOd1WxbX
        zSAwg67+XKl7d7q8GjlMgPo=
X-Google-Smtp-Source: ABdhPJw+vJEvsgat+QbRm4g++1Bi1iqP9dVPtnIClGCEcQooVvK0usNBuk8vOcZG3jijd1MwHaDNWQ==
X-Received: by 2002:a9d:684d:: with SMTP id c13mr5661791oto.201.1622318441772;
        Sat, 29 May 2021 13:00:41 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:00:41 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 00/34] DYNAMIC_DEBUG diet progress, dropped 30kb
Date:   Sat, 29 May 2021 13:59:55 -0600
Message-Id: <20210529200029.205306-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DYNAMIC_DEBUG plants a vector/table of struct _ddebug's in kernel
data; its (module,filename,function) columns have ordered, repeating
data (90%,55%,45%), which is readily compressible.

This patchset restructures the table to isolate that redundant data,
then packs out the duplicates, achieving 40% reduction in the memory
needed for that data, about 30kb on my laptop. No de/compression used.

On my i7 laptop kernel:

dyndbg:  62 44 2899 1728 mptcp.check_fully_established.895  <== 1728/2899 compresion
dyndbg:  63 debug prints in module mptcp (in 44 functions)
dyndbg: 2900 prdebugs in 277 modules, \
	12 KiB in ddebug tables, \
	90 KiB in __dyndbg section, \
	67 KiB in __dyndbg_sites section  <== on this data

It should be practical to actually reclaim that memory; RFC on how
that could be done.  On a hail-mary, I kreallocd sites on a module,
it panic'd.

To isolate the compressible part, we split the table/struct in 2.  The
redundant columns (modname, filename, function) are moved to struct
_ddebug_site ("__dyndbg_sites" elf-section), and refd by a
new/temporary _ddebug.site pointer.  The site data can then be made
optional (6 patches), managed separately, and "compressed".

The pointer adds 8/56 to the memory footprint, we want to replace it
with indexing; the _index only needs to span ~10k callsites, and comes
"free" from unused bits in struct _ddebug.

The difficulty with this, and the reason for the multi-commit
adaptation, is that we have only a struct _ddebug pointer. 
We know its in __dyndbgs[], but we dont know &__dyndbg_sites[],
which we need to finally get __dyndbg_sites[_index].

We get it with an "up-over-and-down" maneuver;

1. __dyndbgs[._index] ==> __dyndbgs[0]
   pretty trivial with ._index
2. __dyndbgs[0].site
   indirectly use __dyndbgs[0].site instead of [._index].site
3. insert "header" record - just _ddebug, renamed
   uses .gnu.linkonce to create headers, linker script to insert it - RFC
   becomes __dyndbgs[0]
   provides .site for [2]
4. __dyndbgs[0].site->__dyndbg_sites[_index]
   trivial

With "up-over-and-down" working, we can get rid of .site pointer

Next is specialization and unionization: 

We create a header union, containing a struct _ddebug to make it "fit"
in __dyndbgs[], and an anonymous struct with .site and a several other
struct _ddebug fields checked to validate headers.

This allows the header to keep its .site pointer, while struct _ddebug
drops it, shrinking memory usage 8/56 back to parity.

It is working, but Im certain it can be restructured more tightly.
In particular, [header,__dyndbgs[]] fits well in a flex-array.
My anonymous struct/union fu is insufficient, hints or examples
are solicited.

Finally comes "consolidation" (not compression).  To do this, we
split/clone ._index to its two tasks (1,4 above); ._back (to n=0), then
._map (to soon to be repacked site).  When adding each module, we scan
__dyndbg_sites[], repack it with its unique entries, and ._map it and
the function's remaining _ddebugs to use that unique entry in the
repacked vector.

Version-5 is here:
https://lore.kernel.org/lkml/CAJfuBxyjfopQMzMyFrrZK7YppsL8kh0VVWySrJDXeUB15uwFag@mail.gmail.com/#t

Version-6 differs from -v5 by:

It works so far..
it's been surviving 0day tests:

It compresses, can save 30kb of 70kb table, of 200kb total data overhead.

Ive resolved most of my previous QsRFCs, but Im using .gnu.linkonce
sections and linker script tweaks for the 1st time and figured it
needs more scrutiny than usual.  Several of the commit messages say
"RFC" where I have most uncertainty.

The "most broken" part of the patchset is the specialization &
unionization, Im certain theres a tighter way to construct it.  ISTM
theres a good chance that [header,__dyndbgs[]] fits well in a
flex-array, and container_of could help.  Hints, tips, pointers to
examples are welcome.


Patch 34 - prototype pr_debug_once(), pr_debug_ratelimited()

= print-once.

$> echo function foo lineno 1234 +po > control

Doable with just a new flag, and a new "did_print" data bit, both
which will fit in struct _ddebug, no separate storage needed.  Its
just one more flag check for dynamic_pr_debug, AFTER its +p enabled.

Unsetting flag and reseting it would clear the "did_print" bit.
Maybe just resetting "+o" too.

= Rate-Limiting

We don't need this often, so allocate RLs only when enabled & needed,
and store in hash on [ &builtin|&module, ._back|._map ]

$> echo module serio_raw +rp > control

By default, we could allocate a rate-limiting (RL) structure for every
pr-debug flagged, store them in a RLs-hash (on ._back + module), and
retrieve and evaluate them only when the pr-debug is enabled.  We
could even defer RL alloc/attach until the pr-debug is actually
called.

If we also (optionally) hash RLs on (._map + module), then they are
shared across a function.  This could be useful behavior, and would
save lots of memory where it is appropriate.

$> echo function foo +rg > control
- on function alone, RL-group capable
- flag modifier. use _map not _back.

Next ? More Dieting

_ddebug as 3 vectors of components.

We have split _ddebug in 2, maybe also split out static-keys to a 3rd
vector ?  This would smoothe the path towards a single struct _ddebug
per function, which controls all N pr_debugs in that function.

We could recapitulate the repack, with some changes in details;
- we're packing the referring table, not the referred table.
  ie: we'd condense __dyndbgs[], keep the vector of static-keys.
- we'd lose meaning of lineno, could reclaim bits for something else.


New API elements ?

. pr_debug_once() etal
. pr_debug_ratelimited() etal
. pr_debug_rl_grouped() etal ??

This is good for signaling programmer intent.  A tweak to DD_METADATA
could set the corresponding bits at compile-time, causing its
provisioning when prdebug'd.


RL contol - Some speculation:

$> echo module serio_raw +r rate 10 burst 3 > control
- after required flags.
- only legal with +r
- suggests sharing across group (by default)
- should rates scale per callsite count ? or only by user ?

$> echo module serio_raw lineno 333 +r rate 100 burst 3 > control
- individual RLs are possible


Jim Cromie (33):






Jim Cromie (34):

3 trivial patches, 2 are in -rc3:
  dyndbg: avoid calling dyndbg_emit_prefix when it has no work
  dyndbg: drop uninformative vpr_info
  dyndbg: display KiB of data memory used.

split struct _ddebug in 2:

  dyndbg: split struct _ddebug's display fields to new _ddebug_site
  dyndbg: __init iterate over __dyndbg & __dyndbg_site in parallel
  dyndbg+module: expose ddebug_sites to modules

make site info optional:
Even though !.site is impossible, by linker init + DD_METADATA,
lets allow it, to shorten codepaths and work towards dropping site data.

  dyndbg: refactor part of ddebug_change to ddebug_match_site
  dyndbg: accept null site in ddebug_match_site
  dyndbg: hoist ->site out of ddebug_match_site
  dyndbg: accept null site in ddebug_change
  dyndbg: accept null site in dynamic_emit_prefix
  dyndbg: accept null site in ddebug_proc_show
  dyndbg: refactor ddebug_alter_site out of ddebug_change
  dyndbg: allow deleting site info via control interface

decoupling:
  dyndbg: add ddebug_site(_get|_put) abstraction
  
cleanup, tidy:
  dyndbg: ddebug_add_module avoid adding empty modules

do the "up-over-down" maneuver:
  dyndbg: add _index to struct _ddebug
  dyndbg: prevent build bugs via -DNO_DYNAMIC_DEBUG_TABLE
  dyndbg: RFC - DEFINE_DYNAMIC_DEBUG_TABLE
  dyndbg: RFC handle __dyndbg* sections in module.lds.h
  dyndbg: ddebug_add_module() handle headers.
  dyndbg: validate ddebug_site_get invariants
  dyndbg: fix NULL deref after deleting sites
  dyndbg: dont show header records in control
  dyndbg: make site pointer and checks on it optional (almost)
  dyndbg: swap WARN_ON for BUG_ON see what 0-day says
  dyndbg: fixup protect header when deleting site
  dyndbg: unionize _ddebug*_headers with struct _ddebug*
  dyndbg: RFC drop _ddebug.site pointer

condense unique site data:
  dyndbg: split/copy ._index into 2 new fields: ._back, ._map
  dyndbg: detect repeated site recs in add_module
  dyndbg: pack module pr_debug sites
  dyndbg: pack pr-debug site-recs in builtin modules

new features - _once, _ratelimited:
  dyndbg: prototype print-once and print-ratelimited RFC

 arch/arm/boot/compressed/Makefile     |   2 +
 arch/sparc/vdso/Makefile              |   2 +
 arch/x86/boot/compressed/Makefile     |   1 +
 arch/x86/entry/vdso/Makefile          |   3 +
 arch/x86/purgatory/Makefile           |   1 +
 drivers/firmware/efi/libstub/Makefile |   3 +-
 include/asm-generic/module.lds.h      |   9 +-
 include/asm-generic/vmlinux.lds.h     |  24 +-
 include/linux/dynamic_debug.h         | 143 +++++++--
 kernel/module-internal.h              |   1 +
 kernel/module.c                       |  11 +-
 lib/dynamic_debug.c                   | 421 ++++++++++++++++++++------
 12 files changed, 499 insertions(+), 122 deletions(-)

-- 
2.31.1

