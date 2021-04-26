Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD6636B160
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 12:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhDZKN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:13:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:47172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232655AbhDZKNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:13:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7B5EB1A6;
        Mon, 26 Apr 2021 10:13:13 +0000 (UTC)
Date:   Mon, 26 Apr 2021 12:13:11 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/seves for v5.13
Message-ID: <YIaSN9AnCi2jSQ/Y@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the SEV-ES pile for v5.13.

Thx.

---

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_seves_for_v5.13

for you to fetch changes up to 799de1baaf3509a54ff713efb768020f8defd709:

  x86/sev-es: Optimize __sev_es_ist_enter() for better readability (2021-03-19 13:37:22 +0100)

----------------------------------------------------------------
Add support for SEV-ES guests booting through the 32-bit boot path, along with
cleanups, fixes and improvements.

----------------------------------------------------------------
Borislav Petkov (2):
      x86/sev-es: Remove subtraction of res variable
      Merge tag 'v5.12-rc3' into x86/seves

Joerg Roedel (9):
      x86/boot/compressed/64: Cleanup exception handling before booting kernel
      x86/sev: Do not require Hypervisor CPUID bit for SEV guests
      x86/boot/compressed/64: Reload CS in startup_32
      x86/boot/compressed/64: Setup IDT in startup_32 boot path
      x86/boot/compressed/64: Add 32-bit boot #VC handler
      x86/boot/compressed/64: Add CPUID sanity check to 32-bit boot-path
      x86/boot/compressed/64: Check SEV encryption in the 32-bit boot-path
      x86/sev-es: Replace open-coded hlt-loops with sev_es_terminate()
      x86/sev-es: Optimize __sev_es_ist_enter() for better readability

Tom Lendacky (1):
      x86/virtio: Have SEV guests enforce restricted virtio memory access

 arch/x86/Kconfig                       |   1 +
 arch/x86/boot/compressed/head_64.S     | 170 ++++++++++++++++++++++++++++++++-
 arch/x86/boot/compressed/idt_64.c      |  14 +++
 arch/x86/boot/compressed/mem_encrypt.S | 130 +++++++++++++++++++++++--
 arch/x86/boot/compressed/misc.c        |   7 +-
 arch/x86/boot/compressed/misc.h        |   6 ++
 arch/x86/boot/compressed/sev-es.c      |  12 +--
 arch/x86/kernel/sev-es-shared.c        |  16 +---
 arch/x86/kernel/sev-es.c               |  38 +++++---
 arch/x86/mm/mem_encrypt.c              |   6 ++
 arch/x86/mm/mem_encrypt_identity.c     |  35 +++----
 11 files changed, 372 insertions(+), 63 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
