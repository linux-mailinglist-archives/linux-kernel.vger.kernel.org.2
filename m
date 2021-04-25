Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DA236A610
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 11:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhDYJZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 05:25:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:42594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhDYJZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 05:25:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 98397AF38;
        Sun, 25 Apr 2021 09:24:31 +0000 (UTC)
Date:   Sun, 25 Apr 2021 11:24:29 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.12
Message-ID: <YIU1Tap67cOpUHMb@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull one final x86/urgent fix for 5.12.

Thx.

---

The following changes since commit bf05bf16c76bb44ab5156223e1e58e26dfe30a88:

  Linux 5.12-rc8 (2021-04-18 14:45:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.12

for you to fetch changes up to 5849cdf8c120e3979c57d34be55b92d90a77a47e:

  x86/crash: Fix crash_setup_memmap_entries() out-of-bounds access (2021-04-20 17:32:46 +0200)

----------------------------------------------------------------
- Fix an out-of-bounds memory access when setting up a crash kernel with kexec.

----------------------------------------------------------------
Mike Galbraith (1):
      x86/crash: Fix crash_setup_memmap_entries() out-of-bounds access

 arch/x86/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
