Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770363EC80B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 09:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbhHOH4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 03:56:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39384 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbhHOH4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 03:56:39 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 474361FDFA;
        Sun, 15 Aug 2021 07:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629014169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QXA3fIm+NS35/rFgvpD30eneLUveGC/X9otVlfhIEqk=;
        b=PdyvX+0cydaXvsvpnv9unlR3RUoURyoNkWYoJ8SBE9HQGPU52nkoIRIb/JGNjOWduc068Y
        mXcLvNnrLYWtLVYT0RhPRDxE6rDQqgVBXeRKsV8DWM6cRA26nSUM+laoiKGHkufu8Cyeml
        sl01CRQwjjIVPznstnBOrYx26c03PdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629014169;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QXA3fIm+NS35/rFgvpD30eneLUveGC/X9otVlfhIEqk=;
        b=ssgCiXEyZ0fbldX6Gg+dTudbwkcef9O5Te910GET3XM1WSC2vibOvec5hEsFCRhY2881bJ
        105Zua8bkbXx9cCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 2F9D113668;
        Sun, 15 Aug 2021 07:56:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id pVYyC5nIGGFFPgAAGKfGzw
        (envelope-from <bp@suse.de>); Sun, 15 Aug 2021 07:56:09 +0000
Date:   Sun, 15 Aug 2021 09:56:46 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.14-rc6
Message-ID: <YRjIvlrCb8YjXdvJ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two x86/urgent fixes for 5.14.

Thx.

---

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.14_rc6

for you to fetch changes up to 064855a69003c24bd6b473b367d364e418c57625:

  x86/resctrl: Fix default monitoring groups reporting (2021-08-12 20:12:20 +0200)

----------------------------------------------------------------
- An objdump checker fix to ignore parenthesized strings in the objdump
version

- Fix resctrl default monitoring groups reporting when new subgroups get
  created

----------------------------------------------------------------
Babu Moger (1):
      x86/resctrl: Fix default monitoring groups reporting

Randy Dunlap (1):
      x86/tools: Fix objdump version check again

 arch/x86/kernel/cpu/resctrl/monitor.c | 27 +++++++++++++--------------
 arch/x86/tools/chkobjdump.awk         |  1 +
 2 files changed, 14 insertions(+), 14 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
