Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E116D3FB36F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhH3JxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:53:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38936 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbhH3JxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:53:18 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EFA681FDE9;
        Mon, 30 Aug 2021 09:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630317143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pBe5u7+StEsF4mF45pswAHL6PC45sCT0A/S6tjF00l4=;
        b=QwE85+f7LMj1TX7pkuk+ZUPpKXmXebQ45pCreAoh+t9k+VpvFjjkEEOpvinkQmdw8kai+B
        QdkNt/REN66t/FgiVFoedgi0z0KX06Cjw2/hfFShF+WTkZxOkRiVvUAdwGcB+mV+3/9w8t
        hGhMV+v1jEkIN+cb0JgMf4AZHkPwviY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630317143;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pBe5u7+StEsF4mF45pswAHL6PC45sCT0A/S6tjF00l4=;
        b=Zr+GQaqWqS4SYiGF0EcMw0afHxaGWeRke/p3uaFmPMkIMSyjbuSnSYrzVQ1MlQva+78PuM
        vSTWnHECPLSg9GDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DE7FE13670;
        Mon, 30 Aug 2021 09:52:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 1l3NNVeqLGHAPAAAGKfGzw
        (envelope-from <bp@suse.de>); Mon, 30 Aug 2021 09:52:23 +0000
Date:   Mon, 30 Aug 2021 11:53:05 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/build updates for v5.15
Message-ID: <YSyqgcGmQckC60DH@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the x86/build updates for v5.15.

Thx.

---

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.15

for you to fetch changes up to 081551266d2fbf6ce69a30c13a355ee476b2e745:

  x86/build: Move the install rule to arch/x86/Makefile (2021-08-25 11:57:38 +0200)

----------------------------------------------------------------
- Remove cc-option checks which are old and already supported by the
minimal compiler version the kernel uses and thus avoid the need to
invoke the compiler unnecessarily.

- Cleanups

----------------------------------------------------------------
Borislav Petkov (1):
      x86/tools/relocs: Mark die() with the printf function attr format

Masahiro Yamada (2):
      x86/build: Remove the left-over bzlilo target
      x86/build: Move the install rule to arch/x86/Makefile

Nick Desaulniers (1):
      x86/build: Remove stale cc-option checks

 arch/x86/Makefile       | 53 +++++++++++++++++--------------------------------
 arch/x86/boot/Makefile  |  7 +------
 arch/x86/tools/relocs.c | 37 ++++++++++++++++++----------------
 arch/x86/tools/relocs.h |  1 +
 4 files changed, 40 insertions(+), 58 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
