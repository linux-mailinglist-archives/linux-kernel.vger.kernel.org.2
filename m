Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B803B44191D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 10:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhKAJzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 05:55:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39300 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbhKAJwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 05:52:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0CF311FD72;
        Mon,  1 Nov 2021 09:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635760200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pPWz0IZcIYAAGw7mv4IEsSvl712O5VEW9gJs5fBFzZA=;
        b=edtQPo0C9jhiimTdAsMpqf/swoiKuenExAfwd9HY4xFyauFCCCevMBskzVjPvmtDCraqCn
        7SAeUSnSc2AvRUkIs0AMvz6aAZ1ZQicDkwh/8kFkIepEm3EHePBp7TGKWT6OpE/aqz5xZG
        wSIe+P5CPc+Ut2xZdGLStqu0FIc/yUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635760200;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pPWz0IZcIYAAGw7mv4IEsSvl712O5VEW9gJs5fBFzZA=;
        b=1zcqB2jkY3t9nPKBf1P1V44leijjc3Zew2OPCwaRjp2CUQmTVMw7ubnwKlQi/wAik3VC7R
        NXRZmlRjMbD49ZCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8E0213AB7;
        Mon,  1 Nov 2021 09:49:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3fbWOEe4f2GHQAAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Nov 2021 09:49:59 +0000
Date:   Mon, 1 Nov 2021 10:49:57 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/build for v5.16
Message-ID: <YX+4RQjpxHyEa1KU@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single x86/build fix for v5.16.

Thx.

---

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.16_rc1

for you to fetch changes up to 067595d728179219c120dd50b4dc711e92f1eb16:

  x86/boot: Fix make hdimage with older versions of mtools (2021-09-29 11:06:47 +0200)

----------------------------------------------------------------
- A single fix to hdimage when using older versions of mtools

----------------------------------------------------------------
H. Peter Anvin (Intel) (1):
      x86/boot: Fix make hdimage with older versions of mtools

 arch/x86/boot/genimage.sh    | 15 ++++++++-------
 arch/x86/boot/mtools.conf.in |  5 +++--
 2 files changed, 11 insertions(+), 9 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
