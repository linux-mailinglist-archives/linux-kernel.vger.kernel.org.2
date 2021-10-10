Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5503C428020
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 11:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhJJJHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 05:07:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57580 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhJJJHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 05:07:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C1E151FE36;
        Sun, 10 Oct 2021 09:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633856711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Je4Qry92SIQWaxQOPBWfp2Gr2MiLRQzL1dNHzr4QPLA=;
        b=B18pLTwc37yZUIcJBR+Z+3J5I0CYZm9ngFBqYGUFe1JkRL+3FKbLAA0bKZ1Aha0h/+vqCc
        9vZGzwCmpX1wdXZesMDGcQf17hlzeIbUKZW2KUW5pB8POIW0TgLhBQcl6dEZPOLo8QU6dH
        7jNajt+ExqKryUmqFv03390yhnk289w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633856711;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Je4Qry92SIQWaxQOPBWfp2Gr2MiLRQzL1dNHzr4QPLA=;
        b=LomWZsL/67g0pXNmS1dyoJC6Qx7y/ZozDxIRI3JVUSjcLOEwVuLjbprz14FldZmjmTKqty
        W4yFG9g7+hhRgiAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B165B13B21;
        Sun, 10 Oct 2021 09:05:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WWIYK8esYmFSSgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 10 Oct 2021 09:05:11 +0000
Date:   Sun, 10 Oct 2021 11:05:13 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] objtool/urgent for v5.15-rc5
Message-ID: <YWKsyUevMivmrxdZ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull three urgent objtool fixes for v5.15-rc5.

Thx.

---

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.15_rc5

for you to fetch changes up to fe255fe6ad97685e5a4be0d871f43288dbc10ad6:

  objtool: Remove redundant 'len' field from struct section (2021-10-05 12:03:21 -0700)

----------------------------------------------------------------
- Remove an extra section.len member in favour of section.sh_size

- Align .altinstructions section creation with the kernel's by creating
them with entry size of 0

- Fix objtool to convert a reloc symbol to a section offset and not to
not warn about not knowing how

----------------------------------------------------------------
Joe Lawrence (2):
      objtool: Make .altinstructions section entry size consistent
      objtool: Remove redundant 'len' field from struct section

Josh Poimboeuf (1):
      objtool: Remove reloc symbol type checks in get_alt_entry()

 tools/objtool/arch/x86/decode.c     |  2 +-
 tools/objtool/check.c               | 16 +++++++--------
 tools/objtool/elf.c                 | 14 ++++++-------
 tools/objtool/include/objtool/elf.h |  1 -
 tools/objtool/orc_gen.c             |  2 +-
 tools/objtool/special.c             | 40 +++++++++----------------------------
 6 files changed, 25 insertions(+), 50 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
