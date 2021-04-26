Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D0F36AFEF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhDZIs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 04:48:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:33680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232068AbhDZIs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:48:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB013AFF0;
        Mon, 26 Apr 2021 08:47:44 +0000 (UTC)
Date:   Mon, 26 Apr 2021 10:47:41 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode for v5.13
Message-ID: <YIZ+LcDiBCcxYPpB@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single fix to the late microcode uploading machinery, for
v5.13.

Thx.

---

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v5.13

for you to fetch changes up to 7189b3c11903667808029ec9766a6e96de5012a5:

  x86/microcode: Check for offline CPUs before requesting new microcode (2021-03-22 22:29:40 +0100)

----------------------------------------------------------------
A single fix to the late microcode loading machinery which corrects
the ordering of when new microcode is loaded from the fs, vs checking
whether all CPUs are online.

----------------------------------------------------------------
Otavio Pontes (1):
      x86/microcode: Check for offline CPUs before requesting new microcode

 arch/x86/kernel/cpu/microcode/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
