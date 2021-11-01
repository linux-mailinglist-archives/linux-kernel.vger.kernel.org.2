Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74496441A05
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 11:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhKAKjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 06:39:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41062 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhKAKjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 06:39:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4449E1FD6F;
        Mon,  1 Nov 2021 10:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635763026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=khloEd1E0p2VCXEZP8kotWXJ5MACj0u6IEn97Bssqqw=;
        b=s9hVey2O284pRTD9ATmpa9uKlcjP+zAgr680PRtHoa+esmmcN+NvRr04CndOuNG3e2KNw9
        QYI4BBeqXnwkQZD8XDNQulErnclcdQRQjuMf/ltRMlAu/kL5XCQQn9Kntn8Qxd30nGwOWy
        PI4F9x5jMjiuKzMkC3VkCRu8lfR0jYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635763026;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=khloEd1E0p2VCXEZP8kotWXJ5MACj0u6IEn97Bssqqw=;
        b=EoLa/qTXXqECFESaQaueM1wH/mHIOGBa6hWnxsaEMOH/ylXbfudKVy32NhRBYYUhJeUMsR
        kk0ki56ndSms3WCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26E4F13AA8;
        Mon,  1 Nov 2021 10:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gjz4CFLDf2FUUQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Nov 2021 10:37:06 +0000
Date:   Mon, 1 Nov 2021 11:37:07 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/misc for v5.16
Message-ID: <YX/DU1kH6/cRrgxR@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the x86/misc updates which do not fit into any other bucket,
for v5.16.

Thx.

---

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.16_rc1

for you to fetch changes up to f96b4675839b66168f5a07bf964dde6c2f1c4885:

  x86/insn: Use get_unaligned() instead of memcpy() (2021-10-06 11:56:37 +0200)

----------------------------------------------------------------
- Use the proper interface for the job: get_unaligned() instead of
memcpy() in the insn decoder

- A randconfig build fix

----------------------------------------------------------------
Borislav Petkov (1):
      x86/insn: Use get_unaligned() instead of memcpy()

Randy Dunlap (1):
      x86/Kconfig: Fix an unused variable error in dell-smm-hwmon

 arch/x86/Kconfig                       |  3 ++-
 arch/x86/lib/insn.c                    |  5 +++--
 tools/arch/x86/lib/insn.c              |  5 +++--
 tools/include/asm-generic/unaligned.h  | 23 +++++++++++++++++++++++
 tools/perf/util/intel-pt-decoder/Build |  2 ++
 5 files changed, 33 insertions(+), 5 deletions(-)
 create mode 100644 tools/include/asm-generic/unaligned.h


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
