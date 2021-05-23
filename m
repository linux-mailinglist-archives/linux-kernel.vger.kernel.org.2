Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0508038DAD7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 12:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhEWKOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 06:14:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:44740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231666AbhEWKOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 06:14:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621764762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sYYsOVd9TGiZAPCmlUwxN6ygnZdvnBlAiVSZ0cLl6l8=;
        b=Z2iityQNB5vdczG5dAQGUsqtZ/Rt+YNpJoJsGzxFvs/fMHin8Y/4QdaHqC4RIJi1YR0gZ9
        GAXgefX3VvkkRC27KHBYQab3KphSIGFnPF0faQul4Zbu694hdHGu5kNsckhwye8HS/bAHX
        Yz3NYZCb2IbRadvkXQ6UrRQMHGNVI4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621764762;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sYYsOVd9TGiZAPCmlUwxN6ygnZdvnBlAiVSZ0cLl6l8=;
        b=UNJmQ0q0o3qGfog6y1LrFaNnRYx2d5NgzZdgxLXEvvZnqf68CMfNY4OIZy6uQnffxdiB+U
        h+JH6ORjsRbqr7AA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8F0EACFD;
        Sun, 23 May 2021 10:12:42 +0000 (UTC)
Date:   Sun, 23 May 2021 12:12:35 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.13-rc3
Message-ID: <YKoqk6WplkzaAitt@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of x86/urgent fixes which accumulated recently.

Thx.

---

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13_rc3

for you to fetch changes up to 4954f5b8ef0baf70fe978d1a99a5f70e4dd5c877:

  x86/sev-es: Use __put_user()/__get_user() for data accesses (2021-05-19 18:45:37 +0200)

----------------------------------------------------------------
- Fix how SEV handles MMIO accesses by forwarding potential page faults instead
of killing the machine and by using the accessors with the exact functionality
needed when accessing memory.

- Fix a confusion with Clang LTO compiler switches passed to the it

- Handle the case gracefully when VMGEXIT has been executed in userspace

----------------------------------------------------------------
Joerg Roedel (3):
      x86/sev-es: Don't return NULL from sev_es_get_ghcb()
      x86/sev-es: Forward page-faults which happen during emulation
      x86/sev-es: Use __put_user()/__get_user() for data accesses

Nathan Chancellor (1):
      x86/build: Fix location of '-plugin-opt=' flags

Tom Lendacky (2):
      x86/sev-es: Move sev_es_put_ghcb() in prep for follow on patch
      x86/sev-es: Invalidate the GHCB after completing VMGEXIT

 arch/x86/Makefile            |  12 ++--
 arch/x86/kernel/sev-shared.c |   1 +
 arch/x86/kernel/sev.c        | 136 +++++++++++++++++++++++++++----------------
 3 files changed, 92 insertions(+), 57 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
