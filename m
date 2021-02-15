Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A3D31B72F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 11:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBOKbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 05:31:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:38586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229944AbhBOKb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 05:31:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CEAEDAC32;
        Mon, 15 Feb 2021 10:30:45 +0000 (UTC)
Date:   Mon, 15 Feb 2021 11:30:43 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sgx for v5.12
Message-ID: <20210215103043.GC23409@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some SGX fixes for v5.12.

Thx.

---

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.12

for you to fetch changes up to 848477782bfa2b6aec738045246abd6cd104006c:

  MAINTAINERS: Add Dave Hansen as reviewer for INTEL SGX (2021-02-06 14:15:27 +0100)

----------------------------------------------------------------
Random small fixes which missed the initial SGX submission. Also, some
procedural clarifications.

----------------------------------------------------------------
Daniel Vetter (1):
      x86/sgx: Drop racy follow_pfn() check

Jarkko Sakkinen (2):
      MAINTAINERS: Fix the tree location for INTEL SGX patches
      MAINTAINERS: Add Dave Hansen as reviewer for INTEL SGX

Sami Tolvanen (1):
      x86/sgx: Fix the return type of sgx_init()

 MAINTAINERS                    |  3 ++-
 arch/x86/kernel/cpu/sgx/encl.c |  8 --------
 arch/x86/kernel/cpu/sgx/main.c | 14 +++++++++-----
 3 files changed, 11 insertions(+), 14 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
