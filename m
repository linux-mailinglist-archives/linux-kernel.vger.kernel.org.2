Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B2C3B5A61
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhF1IU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:20:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45392 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbhF1IUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:20:25 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD14C20222;
        Mon, 28 Jun 2021 08:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624868279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0pr4INJqtbpP86WptXrBBLXgFkS/D7HN73evBlmog3o=;
        b=TksUHIZ/jys2MoGFLGSDOGUqe9LdHPCDMtKySumOh0Ju7r8aT/VeJwpk8o7iHkG+WXdR2W
        w2CIMaCmO+pYBiKzICqEoCfZYfEJvaHCpaT9LdN+lmRZtsNMukzq46IZNm2wwzdAuu8h3v
        YEOu2O6bVxZ1JFCzntE4ALTkp7McGTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624868279;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0pr4INJqtbpP86WptXrBBLXgFkS/D7HN73evBlmog3o=;
        b=VMUd/kSnPZ9c1RmGb7Z/K84EWSGY3wEhElo4chQLIBHoNn6H37c6K/O5GQIucK5pzLXpLb
        rP/ejD+bd1H3W7Bw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 93263118DD;
        Mon, 28 Jun 2021 08:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624868279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0pr4INJqtbpP86WptXrBBLXgFkS/D7HN73evBlmog3o=;
        b=TksUHIZ/jys2MoGFLGSDOGUqe9LdHPCDMtKySumOh0Ju7r8aT/VeJwpk8o7iHkG+WXdR2W
        w2CIMaCmO+pYBiKzICqEoCfZYfEJvaHCpaT9LdN+lmRZtsNMukzq46IZNm2wwzdAuu8h3v
        YEOu2O6bVxZ1JFCzntE4ALTkp7McGTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624868279;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0pr4INJqtbpP86WptXrBBLXgFkS/D7HN73evBlmog3o=;
        b=VMUd/kSnPZ9c1RmGb7Z/K84EWSGY3wEhElo4chQLIBHoNn6H37c6K/O5GQIucK5pzLXpLb
        rP/ejD+bd1H3W7Bw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id t0XjIreF2WCTMwAALh3uQQ
        (envelope-from <bp@suse.de>); Mon, 28 Jun 2021 08:17:59 +0000
Date:   Mon, 28 Jun 2021 10:17:59 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS updates for v5.14
Message-ID: <YNmFt5yMpePkeb6Z@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two small RAS updates for 5.14.

Thx.

---

The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.14_rc1

for you to fetch changes up to 429b2ba70812fc8ce7c591e787ec0f2b48d13319:

  EDAC/mce_amd: Fix typo "FIfo" -> "Fifo" (2021-06-04 15:44:25 +0200)

----------------------------------------------------------------
- Add the required information to the faked APEI-reported mem error so
that the kernel properly attempts to offline the corresponding page, as
it does for kernel-detected correctable errors.

- Fix a typo in AMD's error descriptions.

----------------------------------------------------------------
Colin Ian King (1):
      EDAC/mce_amd: Fix typo "FIfo" -> "Fifo"

Muralidhara M K (1):
      x86/MCE/AMD, EDAC/mce_amd: Add new SMCA bank types

Tony Luck (1):
      x86/mce: Include a MCi_MISC value in faked mce logs

 arch/x86/include/asm/mce.h     | 13 +++++---
 arch/x86/kernel/cpu/mce/amd.c  | 55 ++++++++++++++++++++-------------
 arch/x86/kernel/cpu/mce/apei.c |  3 +-
 drivers/edac/mce_amd.c         | 70 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 26 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
