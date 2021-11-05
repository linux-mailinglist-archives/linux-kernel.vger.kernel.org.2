Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DA44468D1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 20:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhKETWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 15:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbhKETWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 15:22:02 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C229C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 12:19:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v23so1745740pjr.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 12:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1D403wDZlwgRv4lGaRdAf+80WasZvx7ixzH/KrjC85Y=;
        b=jkQC9cTNktZNdwl5hOjJCP7ahZDgZeinNX+ZQU4ir/wEOnKOA8kYL5EtPOEmTPWe8X
         OC/VBOkhDygCDZnmjYoAdkrQdEid7lis7jDvxwZLDCNY6DNAmv+pFfFtAlrem8tI8rt1
         Nzv1AD/TyrffOB7zWvXybhz/Or+X7crRjdVImGzkkFO6QYtwCr7/t6FtdwCrynzhPQJl
         1efE0b5d/ULvJeVqBASsdP9ILTWkipPUxccpf9fCX6k6JBNFpchFulpx7xwDnQUVKE40
         /oDuPZVlynSQcccXeFHni45hfGjAheTazyMfE/RuC+MkFnerZs8JMlsURZy/oVFoF7eC
         IuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1D403wDZlwgRv4lGaRdAf+80WasZvx7ixzH/KrjC85Y=;
        b=QGgBY/c0obQq91z7rC/42QFKbuGM+FRlqcK/ijQALGKitm6vBY2wn2U4gdYyZbgagX
         /VszJ48fTQY00zoQQM6yV1SUlLRecwssUTiEgfaT+dc40FSvlI+OM2aDlVI5jH/dqMJe
         TRUjQ2D1XDzc9hslD4KYlx25omE0OOQumTJhTq8poAztdtoNBV/4zPM/s5IOBdydIXwt
         ifHH17I9BwAW+oXXibGmzcAkvjjRXP0IGEryXp/obWgHnnoWBbJopz53nJzykZej/X0u
         S+4Kv7Okmk5Sv41rQIQg0E8mwJmdXZyf3vb/BmSB3Ssd2M9tEpFqWvRKFLSyRhkEEk+m
         lnTg==
X-Gm-Message-State: AOAM531NDOoLSPMAjZ6Qc+GNf6hgVVqxCBNoRhIfwd22yPl/0xXU3EVK
        4XcKvsdpgdtLrxukhvprACs=
X-Google-Smtp-Source: ABdhPJzh9VGTe/XQrZFrwlxzu2jcl3AdE6vZDahyENl8PiEDmtObiMikYgfzQXIFPgUY975yvePgqg==
X-Received: by 2002:a17:90a:ad47:: with SMTP id w7mr31750914pjv.16.1636139961907;
        Fri, 05 Nov 2021 12:19:21 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:f835:72eb:3372:626f])
        by smtp.gmail.com with ESMTPSA id 8sm10112759pjt.46.2021.11.05.12.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 12:19:21 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 00/10] xtensa updates for v5.16
Date:   Fri,  5 Nov 2021 12:19:05 -0700
Message-Id: <20211105191905.7979-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following Xtensa architecture updates for v5.16:

The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20211105

for you to fetch changes up to bd47cdb78997f83bd170c389ef59de9eec65976a:

  xtensa: move section symbols to asm/sections.h (2021-10-18 22:19:35 -0700)

----------------------------------------------------------------
Xtensa updates for v5.16

- add support for xtensa cores witout windowed registers option

----------------------------------------------------------------
Max Filippov (10):
      xtensa: move _SimulateUserKernelVectorException out of WindowVectors
      xtensa: use a14 instead of a15 in inline assembly
      xtensa: don't use a12 in strncpy_user
      xtensa: don't use a12 in __xtensa_copy_user in call0 ABI
      xtensa: definitions for call0 ABI
      xtensa: implement call0 ABI support in assembly
      xtensa: use register window specific opcodes only when present
      xtensa: only build windowed register support code when needed
      xtensa: remove unused variable wmask
      xtensa: move section symbols to asm/sections.h

 arch/xtensa/boot/boot-elf/bootstrap.S     |   2 +
 arch/xtensa/boot/boot-redboot/bootstrap.S |  72 +++++-----
 arch/xtensa/include/asm/asmmacro.h        |  65 +++++++++
 arch/xtensa/include/asm/atomic.h          |  26 ++--
 arch/xtensa/include/asm/cmpxchg.h         |  16 +--
 arch/xtensa/include/asm/core.h            |  11 ++
 arch/xtensa/include/asm/processor.h       |  32 ++++-
 arch/xtensa/include/asm/sections.h        |  41 ++++++
 arch/xtensa/include/asm/traps.h           |   2 +
 arch/xtensa/kernel/align.S                |   2 +
 arch/xtensa/kernel/entry.S                | 216 +++++++++++++++++++-----------
 arch/xtensa/kernel/head.S                 |  24 ++--
 arch/xtensa/kernel/mcount.S               |  38 +++++-
 arch/xtensa/kernel/process.c              |  27 +++-
 arch/xtensa/kernel/setup.c                | 102 +++++---------
 arch/xtensa/kernel/signal.c               |  12 +-
 arch/xtensa/kernel/traps.c                |   6 +-
 arch/xtensa/kernel/vectors.S              |  55 +++++---
 arch/xtensa/kernel/vmlinux.lds.S          |  12 +-
 arch/xtensa/lib/strncpy_user.S            |  17 ++-
 arch/xtensa/lib/usercopy.S                |  28 +++-
 21 files changed, 541 insertions(+), 265 deletions(-)
 create mode 100644 arch/xtensa/include/asm/sections.h

-- 
Thanks.
-- Max
