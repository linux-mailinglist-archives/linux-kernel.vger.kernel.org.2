Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78D03124A4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhBGOQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:16:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:60654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhBGOQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:16:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EE0AFACB7;
        Sun,  7 Feb 2021 14:15:45 +0000 (UTC)
Date:   Sun, 7 Feb 2021 15:15:43 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v5.11-rc7
Message-ID: <20210207141543.GE32127@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two irq/urgent fixes for v5.11.

Thx.

---

The following changes since commit 13391c60da3308ed9980de0168f74cce6c62ac1d:

  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2021-01-25 15:26:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.11_rc7

for you to fetch changes up to 4c7bcb51ae25f79e3733982e5d0cd8ce8640ddfc:

  genirq: Prevent [devm_]irq_alloc_desc from returning irq 0 (2021-02-05 20:48:28 +0100)

----------------------------------------------------------------
- Prevent device managed IRQ allocation helpers from returning IRQ 0.

- A fix for MSI activation of PCI endpoints with multiple MSIs.

----------------------------------------------------------------
Hans de Goede (1):
      genirq: Prevent [devm_]irq_alloc_desc from returning irq 0

Marc Zyngier (1):
      genirq/msi: Activate Multi-MSI early when MSI_FLAG_ACTIVATE_EARLY is set

 include/linux/irq.h |  4 ++--
 include/linux/msi.h |  6 ++++++
 kernel/irq/msi.c    | 44 ++++++++++++++++++++------------------------
 3 files changed, 28 insertions(+), 26 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
