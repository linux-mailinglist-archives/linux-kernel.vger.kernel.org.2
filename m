Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D014572B2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbhKSQWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbhKSQVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:21:49 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8092C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:18:47 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b13so8516163plg.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=wHMnioS1SZyknkUyv7AocjIhtj+qn+WcPXcl1nykX+Y=;
        b=W9JeVDE+WhAmxRB3it5KnwnrO8Jvss7tz7DU4QAn6HKNgbnKk3fjDHwo9NeiswiE2w
         hkzChjTbnbtcDuOL7/+XPpRRuhFARKIKizewUIagavRn1p8X93FHM7L1Wnz0T1Jof+6U
         Z8kew/8wFI3REqkiLB7tghPnjrWOXuScI97R8EcqP7eNDOFyejNNDbK1gkv53K7xDE6Y
         aXLkgGHwFV+oFZkaoBWL6n/tjzwhkGMGJPaHsGqD+CrIhd/qgafnLK91K4fS2nnnaFAK
         LU9JI+TsWVoTHMos2IiUN2NwQKUW8qu8g2f/UWnjNdnFimQrmqgbgnZSOaV4O12qtvnL
         PE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=wHMnioS1SZyknkUyv7AocjIhtj+qn+WcPXcl1nykX+Y=;
        b=q8LqUiFpjjSYXIUxHplXuWOkrkknh+6cKrH7JLdif74+frHDFbXbWTzkUsMrDYqtLA
         08iiGTKuxM4O68bQAGy4fiLGyaqZxGMMX0fajo+bHNWiIsq2Bv7Sp4m2CnJW1y5OaUQl
         6dwcuVn4sQG5SyJ9rQl7IFXm9sy4YYG+HKpIQJ678s9kcsfEoWU+G4pLNDQiug/pqYe/
         KMqR8nMeU9ryAlOVD7/K0XyGFYbfcrcEtbiTvrqUan65aPoXqrodAuIJLeJ5ubYWgZYB
         CKMG+17kkHGW9Mze54gkgzBHSOH0cCRBCUAvyWCAhF1tCuGFbG8F1ShcxjXGEeKYEes5
         hAAg==
X-Gm-Message-State: AOAM531kzEOWmep5m8arfcFpbbPDQkV5Q4kLDvxqkxAbIRydLR9mkSBQ
        yB0svGLQULSYduBACzIkA0cs6kWYCpNayYC8
X-Google-Smtp-Source: ABdhPJzjmS5V2wIIaC1HU4Rmy1qIXHjsn6Zv8FzHkeJ8a6W0dmllyr8Op80tsvKKEwoVjeVB51xJEA==
X-Received: by 2002:a17:902:c086:b0:142:7169:1573 with SMTP id j6-20020a170902c08600b0014271691573mr78123137pld.13.1637338726911;
        Fri, 19 Nov 2021 08:18:46 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id lp12sm149899pjb.24.2021.11.19.08.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:18:46 -0800 (PST)
Date:   Fri, 19 Nov 2021 08:18:46 -0800 (PST)
X-Google-Original-Date: Fri, 19 Nov 2021 08:18:47 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 5.16-rc2
CC:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-fbf2cd0e-320d-4e42-a2f2-d5343d0a58b0@palmer-ri-x1c9>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.16-rc2

for you to fetch changes up to 5a19c7e06236a9c55dfc001bb4d1a8f1950d23e7:

  riscv: fix building external modules (2021-11-18 23:06:23 -0800)

----------------------------------------------------------------
RISC-V Fixes for 5.16-rc2

I have two patches for 5.16:

* A fix that allows external modules to be built against read-only
  source trees.
* A patch to turn KVM on in the defconfigs.

The second one isn't technically a fix, but it got tied up pending some
defconfig cleanups that ended up finding some larger issues.  I figured
it'd be better to get the config changes some more testing, but didn't
want to hold up turning KVM on for that.

----------------------------------------------------------------
Andreas Schwab (1):
      riscv: fix building external modules

Anup Patel (1):
      RISC-V: Enable KVM in RV64 and RV32 defconfigs as a module

 arch/riscv/Makefile               | 2 ++
 arch/riscv/configs/defconfig      | 2 ++
 arch/riscv/configs/rv32_defconfig | 2 ++
 3 files changed, 6 insertions(+)
