Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880AE36A61B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 11:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhDYJbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 05:31:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:43432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhDYJbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 05:31:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8C86AFE5;
        Sun, 25 Apr 2021 09:31:10 +0000 (UTC)
Date:   Sun, 25 Apr 2021 11:31:13 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v5.12
Message-ID: <YIU24WgaUnl0kh7g@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

one last urgent sched fix for v5.12.

Thx.

---

The following changes since commit bf05bf16c76bb44ab5156223e1e58e26dfe30a88:

  Linux 5.12-rc8 (2021-04-18 14:45:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.12

for you to fetch changes up to 0c89d87d1d43d9fa268d1dc489518564d58bf497:

  preempt/dynamic: Fix typo in macro conditional statement (2021-04-19 20:02:57 +0200)

----------------------------------------------------------------
- Fix a typo in a macro ifdeffery.

----------------------------------------------------------------
Zhouyi Zhou (1):
      preempt/dynamic: Fix typo in macro conditional statement

 kernel/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
