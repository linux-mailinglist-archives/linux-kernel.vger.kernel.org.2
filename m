Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACA1420119
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 11:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhJCJp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 05:45:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58426 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJCJp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 05:45:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0841F220F4;
        Sun,  3 Oct 2021 09:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633254219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WDBmH0b+Cg7h1JL2TZzT1gJTTeOsVzAH2yDozlCq4RU=;
        b=QpcMOpPg2JcGeZboe6TtKmiIRjwvCvreOJFDm16ldkvyuT+k/aNsimy5MdiXWpApLzET8h
        muZel123AxUVA3CAknqFdL02yCHH9EJTEQw9YILRXz5Mhua1ROA6tRrULlm5M1dMk92XpS
        RXU4PdcE+L6x1dJTyNVwESiWxXpcym8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633254219;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WDBmH0b+Cg7h1JL2TZzT1gJTTeOsVzAH2yDozlCq4RU=;
        b=mfZPZOQiio/jof43N2TCDzNilBrhfKZsYpFh0+4to9ifVa59oee9sVd+MXbZFA2EqEfmhL
        R6sgeANBDWMMOtDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5BFB13BFC;
        Sun,  3 Oct 2021 09:43:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ST2wN0p7WWEmfgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 03 Oct 2021 09:43:38 +0000
Date:   Sun, 3 Oct 2021 11:43:33 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] objtool/urgent for v5.15-rc4
Message-ID: <YVl7RR5NcbPyiXgO@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single objtool urgent fix for 5.15.

Thx.

---

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.15_rc4

for you to fetch changes up to 24ff652573754fe4c03213ebd26b17e86842feb3:

  objtool: Teach get_alt_entry() about more relocation types (2021-10-01 13:57:47 +0200)

----------------------------------------------------------------
- Handle symbol relocations properly due to changes in the toolchains
which remove section symbols now

----------------------------------------------------------------
Peter Zijlstra (1):
      objtool: Teach get_alt_entry() about more relocation types

 tools/objtool/special.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
