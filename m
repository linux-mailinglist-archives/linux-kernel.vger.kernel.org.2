Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276B1309C19
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 13:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhAaMr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 07:47:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:60892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230437AbhAaLpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 06:45:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92C47AC55;
        Sun, 31 Jan 2021 10:57:20 +0000 (UTC)
Date:   Sun, 31 Jan 2021 11:57:17 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/entry for v5.11-rc6
Message-ID: <20210131105717.GA4432@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull x86/entry for v5.11-rc6.

This was originally going to go during the merge window but people can
already trigger a build error with binutils-2.36 which doesn't emit
section symbols - something which objtool relies on - so let's expedite
it.

Thx.

---

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_entry_for_v5.11_rc6

for you to fetch changes up to 0bab9cb2d980d7c075cffb9216155f7835237f98:

  x86/entry: Remove put_ret_addr_in_rdi THUNK macro argument (2021-01-19 11:06:14 +0100)

----------------------------------------------------------------
A single fix for objtool to generate proper unwind info for newer
toolchains which do not generate section symbols anymore. And a cleanup
ontop.

----------------------------------------------------------------
Borislav Petkov (1):
      x86/entry: Remove put_ret_addr_in_rdi THUNK macro argument

Nick Desaulniers (1):
      x86/entry: Emit a symbol for register restoring thunk

 Documentation/asm-annotations.rst |  5 +++++
 arch/x86/entry/thunk_64.S         | 15 +++++----------
 include/linux/linkage.h           |  5 +++++
 3 files changed, 15 insertions(+), 10 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
