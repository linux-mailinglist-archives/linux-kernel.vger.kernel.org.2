Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5079B45153F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 21:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351090AbhKOUbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 15:31:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240188AbhKOSHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:07:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21EBC63389;
        Mon, 15 Nov 2021 17:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636998196;
        bh=+cRVGDX7Sl8y+R4yFnKNAcU2pi6NOfJ9gNgSyoE5d/M=;
        h=From:To:Cc:Subject:Date:From;
        b=bCTEuiBM6GatYDrfo2RCIN8ai8Pk0Ys/ylCly6tdj20NtCUJapWJzYfc43Ro2X3ds
         zCdSOwTS9AG3E5Na43o7u9MvDBCQaw1PaoVIoOk+aDyfq6/KwFDPZ8HCZCo8X9he7Q
         azXrc17i5fzAxOle+vkP2vVQ+NOuW4s3dPAWW76PlabVUtgXhVURs35CEQ7sVH4U5j
         JxvUahUwtIGH5fA260TcP3axqknQDw8MBxaoog7z5ZY7mJL3raAAnXgkEU8vpmKaVV
         1sGeak7IzBiLA7zKGCyTfYl6KYk303fy67mAnf5djVjdO6afmzKZeDzEp7uw5h/MPs
         OAd3bqHG4SYZA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Brian Cain <bcain@codeaurora.org>
Cc:     linux-hexagon@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 0/3] Fixes for ARCH=hexagon allmodconfig
Date:   Mon, 15 Nov 2021 10:42:48 -0700
Message-Id: <20211115174250.1994179-1-nathan@kernel.org>
X-Mailer: git-send-email 2.34.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes some issues noticed with ARCH=hexagon allmodconfig.

The first two patches were previously sent as individual patches but it
makes sense to bundle them together after CONFIG_WERROR as they are both
required to fix the build.

The third patch is new, I only noticed it when building "normally", as
opposed to with O=...

I would like to see these merged into mainline sooner rather than later
since I initially sent them in July.

v1 -> v2:

https://lore.kernel.org/r/20210708233849.3140194-1-nathan@kernel.org/
https://lore.kernel.org/r/20210728001729.1960182-1-nathan@kernel.org/

* Add patch 3.
* Add Brian Cain's ack on patches 1 and 2.
* The warning in patch 2 is now an error because CONFIG_WERROR is
  enabled with allmodconfig.
* Add stable CC for patches 1 and 2 because they fix build errors.

Nathan Chancellor (3):
  hexagon: Export raw I/O routines for modules
  hexagon: Clean up timer-regs.h
  hexagon: Ignore vmlinux.lds

 arch/hexagon/include/asm/timer-regs.h | 26 --------------------------
 arch/hexagon/include/asm/timex.h      |  3 +--
 arch/hexagon/kernel/.gitignore        |  1 +
 arch/hexagon/kernel/time.c            | 12 ++++++++++--
 arch/hexagon/lib/io.c                 |  4 ++++
 5 files changed, 16 insertions(+), 30 deletions(-)
 delete mode 100644 arch/hexagon/include/asm/timer-regs.h
 create mode 100644 arch/hexagon/kernel/.gitignore


base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
2.34.0.rc0

