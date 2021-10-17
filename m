Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8284307F0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 12:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241929AbhJQKfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 06:35:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57824 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbhJQKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 06:35:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 818DB2199E;
        Sun, 17 Oct 2021 10:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634466820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LUCmm0C+IGcAvMONxwoQz9FKA27U05Ib5FV7xi9MwoA=;
        b=xQdJ6TtLM1okCFajJsCalX5PW0YQ2yL7S63kMZG9MopnxmfKJm2CLxbPCZt1jTFxHBS9VE
        IrhBrdf/iW5ffu4rFf2s0drgtdbqAndQI8HE5982JgXexT9eushYcpReKZS5mwfwfY44SO
        uVZrgRNVtqs1dgtACoJg/kly43qYiNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634466820;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LUCmm0C+IGcAvMONxwoQz9FKA27U05Ib5FV7xi9MwoA=;
        b=Den8AjGmi7K66pUC8uNfd63I/JLlIU3TZr4ufIq0YmpAh2uCND8rFAZWg1rlvXsD2/mkB0
        E5mRSKSE21TBZgDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 726411377A;
        Sun, 17 Oct 2021 10:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YoC2GwT8a2HVPAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 17 Oct 2021 10:33:40 +0000
Date:   Sun, 17 Oct 2021 12:33:38 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] objtool/urgent for v5.15-rc6
Message-ID: <YWv8Ah1dgKZ0ckyR@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two more urgent objtool fixes for 5.15.

Thx.

---

The following changes since commit fe255fe6ad97685e5a4be0d871f43288dbc10ad6:

  objtool: Remove redundant 'len' field from struct section (2021-10-05 12:03:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.15_rc6

for you to fetch changes up to 86e1e054e0d2105cf32b0266cf1a64e6c26424f7:

  objtool: Update section header before relocations (2021-10-06 20:11:57 -0700)

----------------------------------------------------------------
- Update section headers before the respective relocations to not
trigger a safety check in elftoolchain's implementation of libelf

- Do not add garbage data to the .rela.orc_unwind_ip section

----------------------------------------------------------------
Michael Forney (2):
      objtool: Check for gelf_update_rel[a] failures
      objtool: Update section header before relocations

 tools/objtool/elf.c | 56 ++++++++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
