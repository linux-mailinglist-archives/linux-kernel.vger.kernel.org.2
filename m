Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058E733EA37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhCQGy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCQGyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:54:22 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40047C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:22 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id g27so39900167iox.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SlYC70Tmixg0bkawcmpqrM0Twaey/BX+R82iQOZSGdk=;
        b=Qoh+X3845ZucsGg9cbiSywQJizgtyrSxDQ8gr3zcEPDPnHcwXqUwnO6FPn5QusV7RY
         UWnnEttJYYRai6xRX/c9C32yvyk2x44Y3JaQF0u6yhrh3AOjumURKMc1oe3ezCqF/7qa
         qOEWyyKUzeZpyVr1oJIosk/JO5JO91zMcDJOLwz7A0AygspNbdkBMJFlPHOTvDSqa9fH
         MFkX2sQLORgMN5MT9Ct3nlUqw1vorHUCxanqV6Q1lT2l0ZU1tu7HUNPkNJX5H7sMIDbE
         9JSRFiWac2x00r5IzLM5+rjeEcFj1kWr+ize2qqmA3Q4Smph9MfdzsGx8eYVP7SqAJ5K
         CrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SlYC70Tmixg0bkawcmpqrM0Twaey/BX+R82iQOZSGdk=;
        b=pwt5DJ+q2rPYpv1+esZRee6MPvU9UpjAWBgglUmHs2n346EdJ5EzJc2BR2i2exzcqC
         6b2zbAnL/k9I62qZGZfgeg4CbgUoHQHU5R3xDQPU4W7mjOgww8L/Duy79yhfJn4Z2cjV
         7UuLSOWy75arvQ79x6my0MYVwnHubypFjBsT//CViCXAd6ScgQeGuOzBN8jZB1tIWo7V
         h4qFgPoub21nDna4HidH4KWPRY1bD6zuYUPojBrSZ7gC146kkpYDSAnlj3IKGnrsGsje
         x8G9U9bx2UPCH/6iuXh2r2UYWAVZ4sKzgQPMArt3E5ufpLerbdbv0LRAy1tQK3R1XAEJ
         /A9w==
X-Gm-Message-State: AOAM533itziue954mnhRyHI4fWoJq4LpzIqK2kB0gp4BbsQY6NZ3H/mA
        brIJer1upsxaWyYKWa3nxRI=
X-Google-Smtp-Source: ABdhPJy+4qkeJaSy1Eb1RlWjQEsPf0PsKtX4ASEgbMIvVbEz9ATqhI16TZ41VxjQ7ZRGf7ygmRlKbg==
X-Received: by 2002:a05:6638:2711:: with SMTP id m17mr1727138jav.115.1615964061410;
        Tue, 16 Mar 2021 23:54:21 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id w13sm10583057ilg.48.2021.03.16.23.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:54:20 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [RFC PATCH v4 00/19] dynamic debug diet plan
Date:   Wed, 17 Mar 2021 00:53:53 -0600
Message-Id: <20210317065412.2890414-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4 fixes 'series grooming errors',
Reported-by: kernel test robot <lkp@intel.com>

CONFIG_DYNAMIC_DEBUG creates a struct _ddebug (56 bytes) for each
callsite, which includes 3 pointers to: module, filename, function.
These are repetetive, and compressible, this patch series goes about
doing that, it:

- splits struct _ddebug and __dyndbg[] section/array into 2
  creating struct _ddebug_site and __dyndbg_sites[]
  temporary _ddebug.site connects them.
  
- makes _ddebug_site data optional
- minor optimizations
- makes _ddebug_site data deleteable
  not necessary, proof of optionality

The RFC stuff comes at the end:

- attach __dyndbg_sites[] to module-info, like __dyndbg[]
- add index to struct _ddebug, use it for builtins
- add ddebug_site(_get|_put) abstraction to hide _ddebug.site

At this point, its practical to: compress __dyndbg_sites[] & replace
the section, then expand it on-demand to serve ddebug_site_get()
calls.  For enabled callsites (with decorations flags), the retrieved
records can be cached in a hash after theyre 1st needed/used (when
callsite is actually executed).

Whats my (ideal?) decompressing interface ?
And whats the name of the api call ? I couldnt suss it out yet.

For any control read, a simple block decompress and cache is close to
ideal; all site data is then available to iterate over, and each
ddebug_site_get() just indexes into it.  A stream of decompressed site
records would also work well, with less lumpy memory allocs and frees.

Actually dropping _ddebug.site is not yet possible.  While we could
drop it for builtin modules, thats cuz we know __start___dyndbg_sites.
For loaded modules, I need the elf section: __dyndbg_sites.  This is
in load-info, but I dont have a path to it.  In:

- add _ddebug_header/table

That adds a single header entry pair (structs _ddebug*s with special
initialization) into the arrays, and it links to the front of the
array, where its useful.  But creating this header entry only works
for vmlinux itself (because of vmlinux.ld.h patch), not for loadable
modules.

- add linker rules to module.lds.h

I tried to re-use the DYMAMIC_DEBUG_DATA macro added above for
modules, this failed, commit msg guesses the cause.  This breaks with
a linker script syntax error

TODO

Presuming the fixed header can be linked reliably in front doing
something like I tried, it can be recast as a ddebug_header and
unionized with struct _ddebug, and the _ddebugs[] will fit nicely as a
flex-array:

struct ddebug_table2 {
       struct ddebug_header foo;
       struct _ddebug ddebugs[];
}

A header would have 40 bytes, room to contain most/all of struct
ddebug_table's fields, a pointer to the __dyndbg_sites[] table, and a
list-head too, meaning it supports essential and nice-to-have
properties:

- the mapping: __dyndbg[N] --> __dyndbg_sites[N]	 # NEEDed to drop .site
  using container_of_flex() for flex-arrays

- we can add them directly to ddebug_tables list	 # freebie
  ie avoid the kzalloc in ddebug_add_module()  

If not all fields fit in the space available in __dyndbg[0], there is
space available in __dyndbg_sites[0].

Additionally, at the end of __init, ddebug_tables list is composed of
memory entirely in __dyndbg[], which could then be make readonly (by
means I dont know).  If this breaks insertions of loadable modules, we
can easily a 2nd list for that.


Jim Cromie (19):
  dyndbg: split struct _ddebug, move display fields to new _ddebug_site
  dyndbg: __init iterate over __dyndbg & __dyndbg_site in parallel
  dyndbg: refactor part of ddebug_change to ddebug_match_site
  dyndbg: accept null site in ddebug_match_site
  dyndbg: hoist ->site out of ddebug_match_site
  dyndbg: accept null site in ddebug_change
  dyndbg: accept null site in dynamic_emit_prefix
  dyndbg: accept null site in ddebug_proc_show
  dyndbg: optimize ddebug_emit_prefix
  dyndbg: avoid calling dyndbg_emit_prefix when it has no work
  dyndbg: refactor ddebug_alter_site out of ddebug_change
  dyndbg: allow deleting site info via control interface
  dyndbg+module: expose ddebug_sites to modules
  dyndbg: add ddebug_site(_get|_put) abstraction
  dyndbg: add _index to struct _ddebug
  dyndbg: prevent build bugs via -DNO_DYNAMIC_DEBUG_TABLE
  dyndbg: RFC - DECLARE/DEFINE_DYNAMIC_DEBUG_TABLE
  dyndbg: shuffle ddebug_table fields
  dyndbg: RFC add linker rules to module.lds.h

 arch/x86/boot/compressed/Makefile     |   1 +
 arch/x86/entry/vdso/Makefile          |   3 +
 arch/x86/purgatory/Makefile           |   1 +
 drivers/firmware/efi/libstub/Makefile |   3 +-
 drivers/gpu/drm/i915/i915_drv.c       |   2 +
 include/asm-generic/module.lds.h      |  21 ++
 include/asm-generic/vmlinux.lds.h     |  24 +-
 include/linux/dynamic_debug.h         | 180 +++++++++++++--
 kernel/module-internal.h              |   1 +
 kernel/module.c                       |   9 +-
 lib/dynamic_debug.c                   | 313 +++++++++++++++++++-------
 scripts/Makefile.lib                  |   2 +
 12 files changed, 449 insertions(+), 111 deletions(-)

-- 
2.29.2

