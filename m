Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6446443079F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 11:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245217AbhJQJ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 05:57:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44290 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245202AbhJQJ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 05:57:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 501D91FD5B;
        Sun, 17 Oct 2021 09:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634464507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=06TNCNi37ZXj+Ox0cY7DkqXs5djBP1tqOPPk5Ny6a1Y=;
        b=IVHXhe2aRqghqO8hXEHoVDzxsnE9NxPLIH0almgFF0Mia0K0KTqa5/cZWCSrClszqKVSAm
        A++mNgyTM7qimxJM7zm80CUijfR5daAYrV2um97pfobkRkHs1kfxSrKe6HDPV0qh1g20dV
        Sv4bOoIiCga5MAcN241aLft48j0ACA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634464507;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=06TNCNi37ZXj+Ox0cY7DkqXs5djBP1tqOPPk5Ny6a1Y=;
        b=Beu0mlGiqQbhReLsloU5rQOsSEpcyfJnGUYLu3UazI86Ag7zpArnv09bN3PaCfhvSOWnnZ
        QfdUZnj6sVkb/TCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33C981377A;
        Sun, 17 Oct 2021 09:55:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wKYrDPvya2G5MgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 17 Oct 2021 09:55:07 +0000
Date:   Sun, 17 Oct 2021 11:55:01 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.15-rc6
Message-ID: <YWvy9bSRaC+m1sV+@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

two more urgent x86 fixes for 5.15.

Please pull,
thx.

---

The following changes since commit 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc:

  Linux 5.15-rc5 (2021-10-10 17:01:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.15_rc6

for you to fetch changes up to b2381acd3fd9bacd2c63f53b2c610c89959b31cc:

  x86/fpu: Mask out the invalid MXCSR bits properly (2021-10-16 12:37:50 +0200)

----------------------------------------------------------------
- Do not enable AMD memory encryption in Kconfig by default due to
shortcomings of some platforms, leading to boot failures.

- Mask out invalid bits in the MXCSR for 32-bit kernels again because
Thomas and I don't know how to mask out bits properly. Third time's the
charm.

----------------------------------------------------------------
Borislav Petkov (2):
      x86/Kconfig: Do not enable AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT automatically
      x86/fpu: Mask out the invalid MXCSR bits properly

 arch/x86/Kconfig             | 1 -
 arch/x86/kernel/fpu/signal.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
