Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AF036B00A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhDZI4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 04:56:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:41646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232068AbhDZI4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:56:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F7FBB01E;
        Mon, 26 Apr 2021 08:55:24 +0000 (UTC)
Date:   Mon, 26 Apr 2021 10:55:26 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS update for v5.13
Message-ID: <YIZ//qeE42t1Sr+D@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single ras/core commit for v5.13.

Thx.

---

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.13

for you to fetch changes up to 2ffdc2c34421561c12f843e497dd7ce898478c0f:

  x86/mce/inject: Add IPID for injection too (2021-03-24 00:04:45 +0100)

----------------------------------------------------------------
Provide the ability to specify the IPID (IP block associated with the
MCE, AMD-specific) when injecting an MCE.

----------------------------------------------------------------
Borislav Petkov (1):
      x86/mce/inject: Add IPID for injection too

 arch/x86/kernel/cpu/mce/inject.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
