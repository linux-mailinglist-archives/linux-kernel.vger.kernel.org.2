Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A2C3FB359
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbhH3Jpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:45:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53040 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbhH3Jpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:45:36 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D802B220E6;
        Mon, 30 Aug 2021 09:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630316682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8fnGBsBHP7F6BkO6UBA2MnOFkJTaWP/EGrAsH+Z8vOA=;
        b=rjyFtEGIkE2U9HVMQi5XIq3AL1I7ndD5cC20+PW29MekaRi65WjFV+xnubH0D04deyuW7d
        Tb/1vhjecj45n4yELRXZCa9tJicXe5ggI+4ctyYSBiyuo1DL3kMZnVA+dqARJp9FRIP6KN
        NxUK2Q1HHpgViFf5DS4g7fhPYyBmgPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630316682;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8fnGBsBHP7F6BkO6UBA2MnOFkJTaWP/EGrAsH+Z8vOA=;
        b=pfWuV68ktSryVt1eqaI+FuStDhZf1jMC1KiLle/gYJUL+/BReLzX1Dizm/x9mfX9ACOCB8
        VdZDgGbZpBZoJLCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C582B13656;
        Mon, 30 Aug 2021 09:44:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Dyk4L4qoLGE8OgAAGKfGzw
        (envelope-from <bp@suse.de>); Mon, 30 Aug 2021 09:44:42 +0000
Date:   Mon, 30 Aug 2021 11:45:24 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS update for v5.15
Message-ID: <YSyotFTc4bX5PrlD@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single RAS change for 5.15.

Thx.

---

The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:

  Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.15

for you to fetch changes up to 3bff147b187d5dfccfca1ee231b0761a89f1eff5:

  x86/mce: Defer processing of early errors (2021-08-24 10:40:58 +0200)

----------------------------------------------------------------
- Do not start processing MCEs logged early because the decoding chain
is not up yet - delay that processing until everything is ready

----------------------------------------------------------------
Borislav Petkov (1):
      x86/mce: Defer processing of early errors

 arch/x86/include/asm/mce.h     |  1 +
 arch/x86/kernel/cpu/mce/core.c | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
