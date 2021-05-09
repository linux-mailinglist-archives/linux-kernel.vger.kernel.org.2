Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8A63775FD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 11:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhEIJM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 05:12:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:39566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhEIJM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 05:12:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6FC7AADDD;
        Sun,  9 May 2021 09:11:55 +0000 (UTC)
Date:   Sun, 9 May 2021 11:11:51 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v5.13-rc1
Message-ID: <YJenV2X0Xo0i5TKE@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single perf/urgent fix for 5.13-rc1.

Thx.

---

The following changes since commit 635de956a7f5a6ffcb04f29d70630c64c717b56b:

  Merge tag 'x86-mm-2021-04-29' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2021-04-29 11:41:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.13_rc1

for you to fetch changes up to e10de314287c2c14b0e6f0e3e961975ce2f4a83d:

  x86/events/amd/iommu: Fix invalid Perf result due to IOMMU PMC power-gating (2021-05-06 15:33:37 +0200)

----------------------------------------------------------------
Handle power-gating of AMD IOMMU perf counters properly when they are used.

----------------------------------------------------------------
Suravee Suthikulpanit (1):
      x86/events/amd/iommu: Fix invalid Perf result due to IOMMU PMC power-gating

 arch/x86/events/amd/iommu.c | 47 +++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
