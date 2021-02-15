Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF93331B86F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 12:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhBOLxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 06:53:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:33404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhBOLw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 06:52:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B831FAC32;
        Mon, 15 Feb 2021 11:52:11 +0000 (UTC)
Date:   Mon, 15 Feb 2021 12:52:14 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/fpu for v5.12
Message-ID: <20210215115214.GB7265@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull an x86/fpu usage optimization and cleanups for v5.12.

Thx.

---

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_v5.12

for you to fetch changes up to 0a74d61c7d842b583f33f74d7a9e93201826f4c5:

  x86/fpu/xstate: Use sizeof() instead of a constant (2021-01-29 12:33:17 +0100)

----------------------------------------------------------------
- Have 64-bit kernel code which uses 387 insns request a x87 init
(FNINIT) explicitly when using the FPU + cleanups.

----------------------------------------------------------------
Andy Lutomirski (2):
      x86/fpu: Make the EFI FPU calling convention explicit
      x86/fpu/64: Don't FNINIT in kernel_fpu_begin()

Yejune Deng (1):
      x86/fpu/xstate: Use sizeof() instead of a constant

 arch/x86/include/asm/efi.h     | 24 ++++++++++++++++++++----
 arch/x86/include/asm/fpu/api.h | 12 ++++++++++++
 arch/x86/kernel/fpu/xstate.c   |  4 ++--
 arch/x86/platform/efi/efi_64.c |  4 ++--
 4 files changed, 36 insertions(+), 8 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
