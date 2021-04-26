Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962A036B19A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 12:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhDZK0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:26:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:42288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232253AbhDZKZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:25:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29189AC6A;
        Mon, 26 Apr 2021 10:25:07 +0000 (UTC)
Date:   Mon, 26 Apr 2021 12:25:05 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/vmware for v5.13
Message-ID: <YIaVAdqPcW2mQyBA@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single fix for vmware guests, for v5.13.

Thx.

---

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_vmware_for_v5.13

for you to fetch changes up to 0b4a285e2c65c2c9449c6eccb87298e385213e7b:

  x86/vmware: Avoid TSC recalibration when frequency is known (2021-03-28 21:11:43 +0200)

----------------------------------------------------------------
Have vmware guests skip the refined TSC calibration when the TSC
frequency has been retrieved from the hypervisor.

----------------------------------------------------------------
Alexey Makhalov (1):
      x86/vmware: Avoid TSC recalibration when frequency is known

 arch/x86/kernel/cpu/vmware.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
