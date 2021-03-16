Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DA833CCE7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbhCPFIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhCPFIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:20 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45296C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:20 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 81so35832813iou.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ZBVKpJjXIEYiW46a+IeAA6a7AdgcVMstPVy2S4iyNI=;
        b=K2u3lZbmhC62hakGGJJg6WJ7l4xfiGKPGswYJkdUQXiCDyTRn8LxNmyxL/pE/Wu8r4
         kcDj5q2oIEV8PUuW+6uPCXm2AisYlVpYpy0CRDibhd6XNnQUz3LS742fWl6tkdInGEcB
         AzsBeUA3xKGRbGBBjYPDrbtPEZRj7jJg+WcmhuAWtX2CpbbrY9hZ89s7x/FZ8NHKwVrm
         Dding7mSQyoYIYCl0pLfmjD7hNGWFFx2CajQCkb8wvjUPg2JJ0Xh7v/NpMIMHIjoxfGr
         FrosoCQceekUZYXw4G617lKi3xpMZLEKzlnG2ez6/3BJj+y7q/6MknDEmfGT02zlA/t7
         Iy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ZBVKpJjXIEYiW46a+IeAA6a7AdgcVMstPVy2S4iyNI=;
        b=UvgDfvpF5XpKfiZpjJVxlTcbDM2knMbDGX6T7kbGqvmXkq4hRT9NIXmdDEpKgZ4PXV
         p3bdMGLeNoBnY44pGFUuGrX2FR4GPP4Z94F2/5w9RcKSJhRccpNTDmj7/Zh60tZXs47C
         bek7IpC+TyzegW8IXkt6FqMD2mJ7kB/RnGLMJqiMilTltBn5ibemCGuCYZD+aawWLeZ6
         AhtEuZEfx4P+qJqAWsCvSK6rcJFmMOFd6tbPZq3dbqlV4SqNGnu2OK7IcJqK4+8iFcHf
         BrNF1p3mL+fgYfL16AvWr++bqOYBAkluWoAUrtfZKooP7CGJ2BT7ROAlzVsMnqFhBl+G
         +y8Q==
X-Gm-Message-State: AOAM531KAz1fjpGcJCpts/fFZj0wPF941xJmEGDpSa7UN4bpwKRtPW99
        +9jScVJF+MsDRklJTM36AiU=
X-Google-Smtp-Source: ABdhPJwWYR6U6Xj/RLSWjwAV3h6BJpUG716YmlRSBNqj69PAnXo3U59+10huEbztRYahVac5hZYZBw==
X-Received: by 2002:a02:c002:: with SMTP id y2mr12449530jai.107.1615871299712;
        Mon, 15 Mar 2021 22:08:19 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:19 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 00/18] dynamic debug diet plan
Date:   Mon, 15 Mar 2021 23:07:43 -0600
Message-Id: <20210316050801.2446401-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

At this point, actually compressing __dyndbg_sites[] and using that is
doable: ddebug_site_get() has the info (compressed-table-ref, N) to do
the decompress / lookup, and could stick it (the retrieved records)
into a hash if the site is enabled for printing with the prefix.

Whats my (ideal?) decompressing interface ?
And whats the name of the api call ? I couldnt suss it out yet.

For any control read, a simple block decompress and cache is close to
ideal; all site data is then available to iterate over, and each
ddebug_site_get() just indexes into it.  A stream of decompressed site
records would also work well, with less lumpy memory allocs and frees,
or maybe none at all.

Actually dropping _ddebug.site is not yet possible.  While we could
drop it for builtin modules, thats cuz we know __start___dyndbg_sites.
For loaded modules, I need the elf section: __dyndbg_sites.  This is
in load-info, but I dont have a path to it.  In:

- add _ddebug_header/table

I managed to add a single header entry (a struct _ddebug with special
initialization) to the array, and it links to the front of the array,
where its useful.  But creating this header entry only works for
vmlinux itself (because of vmlinux.ld.h patch), not for loadable
modules.  Some breakout & reuse of the macro I added to vmxlinux.ld.h
might be the ticket.  Please signal agreement, and suggest how.

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

- the mapping: __dyndbg[N] --> __dyndbg_sites[N] # we NEED this
- we can enlist them directly in ddebug_tables.	 # freebie
  ie avoid the kzalloc in ddebug_add_module()  

And if not all fields fit in the space available in __dyndbg[0], there
is space available in __dyndbg_sites[0].

Additionally, at the end of __init, ddebug_tables list is composed of
memory entirely in __dyndbg[], which can then be make readonly (by
means I dont know).  If this breaks insertions of loadable modules, we
can easily a 2nd list for that.



Jim Cromie (18):
  dyndbg: split struct _ddebug, move display fields to new _ddebug_site
  dyndbg: __init iterate over __dyndbg & __dyndbg_site in parallelg
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




 arch/x86/boot/compressed/Makefile     |   1 +
 arch/x86/entry/vdso/Makefile          |   3 +
 arch/x86/purgatory/Makefile           |   1 +
 drivers/firmware/efi/libstub/Makefile |   3 +-
 drivers/gpu/drm/i915/i915_drv.c       |   2 +
 include/asm-generic/vmlinux.lds.h     |  24 +-
 include/linux/dynamic_debug.h         | 180 +++++++++++++--
 kernel/module-internal.h              |   1 +
 kernel/module.c                       |   9 +-
 lib/dynamic_debug.c                   | 313 +++++++++++++++++++-------
 scripts/Makefile.lib                  |   2 +
 11 files changed, 428 insertions(+), 111 deletions(-)

-- 
2.29.2

