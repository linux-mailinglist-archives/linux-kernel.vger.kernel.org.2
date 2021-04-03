Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99ADB353544
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 20:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbhDCSjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 14:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhDCSjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 14:39:43 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AC6C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 11:39:38 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id l76so5546163pga.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 11:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=zD8wauqUMw0TlD45wfByZ3K32WygFAL1fLRSXJC1e/Q=;
        b=DWtISbdUdqv4RGLKQXay9ogRu8c8kArSRreQHu3wGJN29oVK7gGAh6ZsRaBjBAlrRD
         hRxuu7SJh1RXBk5l1+KYE1SJM5PMb1p2sJY887Muf0U3Sc15NLKYxCdngd/nD31X6ssG
         UM4qbRNFBRy4JUbHVrQUGTaTBYGcdzGalcw7JYt0nGm4FeCD0YFYfK2itFljE38TT2p8
         w8RQD7YTbsJtMwIQwl00Kwn9j+449bx0U0wK6j0oy3YWvkrzSLbPz3NF9rxNt6txc5ew
         IB9S+CJ5nfRJt/5uhbrfePQ3zHdxJ/JVSilQlbLJTCbGmEYOVm02+wf8YcBYYQewmrYd
         9Omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=zD8wauqUMw0TlD45wfByZ3K32WygFAL1fLRSXJC1e/Q=;
        b=jA3VHzwL5MBjy+07pnwOlWr6GJYxnGsY0Z0EQGHbPi2E2dPV2hxsrVBWXLPy8d3Hs1
         /vLE+nhmaB+I3a/h260Z1CL47vtu//Bu27fwijvGIz8DAHQenwqUGPtzolFWgtjiw75E
         UOrcXBlU8BWNcCDMm9NTS4AdzxWcNOPKk2YqqgRTgrf9vl5D67ZtlGP+KOAjsu8jJhFD
         iAZmR76nBg3aeX5cRusm/ZisafdWuTtWOpgZaRWQYh6FmnLw8rtRukn00ct5e5IH7P2Y
         fWsb7EgLwyiV3Bb1krCT7KqlhNsSsQyHSo0E22WKW9H7sSJ5k79suBkl5zgeMcgbs4DU
         GKgw==
X-Gm-Message-State: AOAM531MhSkcrY2xKCDJPhPOXudIIlGznlrXZAMuj+wu3heHh8HifaDy
        ACvJreS/rjMguPnf/hQpb2VHCeNeF6qsgw==
X-Google-Smtp-Source: ABdhPJzBgIekprwFPtdRSoK+vU59Ehl7CiAQGJdsf3oqCIHFklsg0IAQJYMY70GDCXtJ3hwAlsq6lg==
X-Received: by 2002:a63:181c:: with SMTP id y28mr17174906pgl.175.1617475177611;
        Sat, 03 Apr 2021 11:39:37 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v134sm11473034pfc.182.2021.04.03.11.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 11:39:36 -0700 (PDT)
Date:   Sat, 03 Apr 2021 11:39:36 -0700 (PDT)
X-Google-Original-Date: Sat, 03 Apr 2021 11:39:28 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.12-rc6
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-7c342428-c3ce-4ed5-b311-cd79458c2f32@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a5e13c6df0e41702d2b2c77c8ad41677ebb065b3:

  Linux 5.12-rc5 (2021-03-28 15:48:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.12-rc6

for you to fetch changes up to 1adbc2941eee8acbe3c7dc6b51cdbc5a9bf19565:

  riscv: Make NUMA depend on MMU (2021-04-01 21:37:08 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.12-rc6

I have a handful of fixes for 5.12:

* A fix for a stack tracing regression related to "const register asm"
  variables, which have unexpected behavior.
* A fix to put_user() that ensures the value to be written is evaluated
  before enabling access to userspace memory..
* A fix to align the exception vector table correctly, so we don't rely
  on the firmware's handling of unaligned accesses.
* A build fix to make NUMA depend on MMU, which triggers some
  randconfigs.

----------------------------------------------------------------
Ben Dooks (1):
      riscv: evaluate put_user() arg before enabling user access

Kefeng Wang (2):
      riscv: Drop const annotation for sp
      riscv: Make NUMA depend on MMU

Yang Li (1):
      riscv: remove unneeded semicolon

Zihao Yu (1):
      riscv,entry: fix misaligned base for excp_vect_table

 arch/riscv/Kconfig               | 2 +-
 arch/riscv/include/asm/uaccess.h | 7 +++++--
 arch/riscv/kernel/entry.S        | 1 +
 arch/riscv/kernel/stacktrace.c   | 2 +-
 arch/riscv/mm/kasan_init.c       | 2 +-
 5 files changed, 9 insertions(+), 5 deletions(-)
