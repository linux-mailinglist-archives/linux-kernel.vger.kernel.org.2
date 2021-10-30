Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BF7440A26
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 18:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhJ3QIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 12:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ3QIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 12:08:13 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BD6C061570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 09:05:43 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y1so8823248plk.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:message-id:cc:from:to;
        bh=6VwdY920IT0wmuMCZoXGOCvpa/shHqhuGOaRMVKSK/g=;
        b=rAoO6wAtROQh0CGD4m9G4K7cCR70fw8f2+OXWDCxFNk0Z6pXlHmErnmY7N9/5gXOaH
         wjEY+f6v7Bh8ir8fbdw2+WILDBHVLn1+Pf22VETKlBGTG9KduFfkDo30TXqd3Au2JSOc
         VtShTgTkTZs/6Jyzz1gr5fmI19OG0j/tdxYWDJJbStwGkiombChsquXNHwM2zza3Xg8m
         dAHq8thrEJ/vjueXVfl9pqnhtxxPoNBX1IvjXylVYJb8pVd4iHlEqiDCYbTNWWZNWRv9
         dCnEyLd74l7sS+UKN1TBC+yQQxdAtF1VaehW2qzIDXJ2vRq7b95dcPyT8KZC/qU3xTtr
         Tjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:message-id:cc:from:to;
        bh=6VwdY920IT0wmuMCZoXGOCvpa/shHqhuGOaRMVKSK/g=;
        b=EGr5ebe5GuEtKEWDvpgmM/rUz89RNjhTWfhiIPKtf+Ol4LW0NbOdgwZ3prkot3CVI7
         NFPkzqciWRSu0mcUChgYgA8Y9gLAIMyUjE8L69PbyzOb5h1HB9SQtXAhZ8OxtDX34P4Z
         wXPXq7gz5CE5WmIBo6ZP0hc2HvxKKNeynEybAAnxxeWSIImh+hVI9Q05oH9CvJBriN4g
         R0S29UYAtKuYzLctPe8utUheKIOKxkVjMAqvFoP7cCtQTVVvdRVszXt7VNPIZwkmxFC2
         DB+wvSOooj9WCagL5OkGfbS6RylCjTcP5VnVY55b7JhbJLiPMCt4fk+0f510xt0FBTNz
         WmxQ==
X-Gm-Message-State: AOAM531oWCFYkUajgsPmre7mOQd42GAj4QIOKEjmQfoS8zrLPfdrMgjE
        jAWlugteIU+7h2kN6eYP0WSgatvLV2yuXw==
X-Google-Smtp-Source: ABdhPJxVqTLHMZANaoRY1Xt8kG25qX7Ff5XydcgriVC51+IzCFGJ9KjKfox5gKkr/hwv7k9pZ+cAhw==
X-Received: by 2002:a17:90b:1a87:: with SMTP id ng7mr944834pjb.230.1635609942038;
        Sat, 30 Oct 2021 09:05:42 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id nv5sm9513337pjb.10.2021.10.30.09.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 09:05:40 -0700 (PDT)
Date:   Sat, 30 Oct 2021 09:05:40 -0700 (PDT)
X-Google-Original-Date: Sat, 30 Oct 2021 09:04:54 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.15 (or -rc8)
Message-ID: <mhng-5efadc14-a2c3-4c9d-a383-8ecb782399e7@penguin>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3ef6ca4f354c53abf263cbeb51e7272523c294d8:

  checksyscalls: Unconditionally ignore fstat{,at}64 (2021-10-07 17:16:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.15-rc8

for you to fetch changes up to 54c5639d8f507ebefa814f574cb6f763033a72a5:

  riscv: Fix asan-stack clang build (2021-10-29 08:54:50 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.15 (or -rc8)

* A fix to ensure the trap vector's address is aligned.
* A fix to avoid re-populating the KASAN shadow memory.
* A fix to allow kasan to build without warnings, which have recently
  become errors.

----------------------------------------------------------------
I know these are pretty late, but they do fix concrete issues.  It's not a big
deal if they don't make it for 5.15, as it's very likely they end up on stable
either way.

----------------------------------------------------------------
Alexandre Ghiti (2):
      riscv: Do not re-populate shadow memory with kasan_populate_early_shadow
      riscv: Fix asan-stack clang build

Chen Lu (1):
      riscv: fix misalgned trap vector base address

 arch/riscv/Kconfig             |  6 ++++++
 arch/riscv/include/asm/kasan.h |  3 +--
 arch/riscv/kernel/head.S       |  1 +
 arch/riscv/mm/kasan_init.c     | 14 +++-----------
 4 files changed, 11 insertions(+), 13 deletions(-)
