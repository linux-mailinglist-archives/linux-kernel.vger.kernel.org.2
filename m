Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBAC349C67
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 23:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhCYWia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 18:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhCYWiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 18:38:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A0E661A3A;
        Thu, 25 Mar 2021 22:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616711903;
        bh=avDQo70jyLVlZwplCA1vAeUbTnOiqdYs1TebXaMbdnk=;
        h=From:To:Cc:Subject:Date:From;
        b=S9zGop5FjZn0ne2gCJwrwMtDLLIYkiq8kLKss27x/99AaEHni1Egu9OsrFnk1oYlW
         upcWJa0o1ND8d0wQMk/d2R+b/aHfaIyNx/EPxCCRvuUDcyoknG1J4fiIAmmp9oXaug
         1k3bJ8WX8fMnFNZbQkLBCgsZPUNAjerJYkjh6CKaO08AKDCPxR/ikmfV/AH4fY34CJ
         JIiY9E/4imdjpWxyifhuP501yGsz1kzVOrGVnK7wmwLQUbPgjzIuwZr7Nu80BB48Zv
         TBxF+yV+tOndA50w8A7Th4MOuydCuZECihgqjFt2B3OHzESRUZwmiV1vzYOQCe//4C
         o6vInuThyjQ4A==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/3] Fix CONFIG_FUNCTION_TRACER with clang
Date:   Thu, 25 Mar 2021 15:38:04 -0700
Message-Id: <20210325223807.2423265-1-nathan@kernel.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series fixes function tracing with clang.

Patch 1 adjusts the mcount regex in scripts/recordmcount.pl to handle
the presence of PLT relocations, which happen with clang. Without this,
the mcount_loc section will not be created properly.

Patch 2 adds a workaround for clang less than 13.0.0 in relation to the
mcount symbol name, which was "mcount" rather than "_mcount". This was
written as a separate patch so that it can be reverted when the minimum
clang version is bumped to clang 13.0.0.

Patch 3 avoids a build error when -fpatchable-function-entry is not
available, which is the case with clang less than 13.0.0. This will make
dynamic ftrace unavailable but all of the other function tracing should
work due to the prescence of the previous patch.

I am hoping this series can go in as fixes for 5.12, due to patch 3, but
if not, they can always be backported (patches 1 and 2 are already
marked for stable).

This series has been build tested with gcc-8 through gcc-10 and clang-11
through clang-13 with defconfig and nommu_virt_defconfig plus
CONFIG_FTRACE=y and CONFIG_FUNCTION_TRACER=y then boot tested under
QEMU.

Cheers,
Nathan

Nathan Chancellor (3):
  scripts/recordmcount.pl: Fix RISC-V regex for clang
  riscv: Workaround mcount name prior to clang-13
  riscv: Select HAVE_DYNAMIC_FTRACE when -fpatchable-function-entry is
    available

 arch/riscv/Kconfig              |  2 +-
 arch/riscv/include/asm/ftrace.h | 14 ++++++++++++--
 arch/riscv/kernel/mcount.S      | 10 +++++-----
 scripts/recordmcount.pl         |  2 +-
 4 files changed, 19 insertions(+), 9 deletions(-)

-- 
2.31.0

