Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AA34307BD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 12:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbhJQKMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 06:12:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57578 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbhJQKMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 06:12:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B19822199E;
        Sun, 17 Oct 2021 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634465443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cNYpvRQl0L0sXJwGVDZQ2Iuqli37exNPS5euq8LShEI=;
        b=lFY32vgd08LL3mvHEQXrfSUlSolOUB5MkreDMSEw1s3rjGnmqXK2IZ1YOrY+VwKP5U5klY
        cQNb70ica9eZmGQAkt304hy+TEbmq8i8Hv+CpUZ1FacxUBS3leRg2Qo8HEVGev51spzpUz
        u2AbvvLojj2bjFiZ1L8LQ47dxVzzzhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634465443;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cNYpvRQl0L0sXJwGVDZQ2Iuqli37exNPS5euq8LShEI=;
        b=gAYLtU5KACpS5KAz3oADSSXArteQa3Jn3pd8xf5XzgDmfGm1shYS/fR+t7jPuNu6Fr9Phn
        eIlhqQPBYb0nwXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95C3C13A39;
        Sun, 17 Oct 2021 10:10:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d20oJKP2a2HaNgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 17 Oct 2021 10:10:43 +0000
Date:   Sun, 17 Oct 2021 12:10:46 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v5.15-rc6
Message-ID: <YWv2pgdrR0xgfoRI@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single perf/urgent enhancement for v5.15.

Thx.

---

The following changes since commit 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc:

  Linux 5.15-rc5 (2021-10-10 17:01:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.15_rc6

for you to fetch changes up to 71920ea97d6d1d800ee8b51951dc3fda3f5dc698:

  perf/x86/msr: Add Sapphire Rapids CPU support (2021-10-15 11:25:26 +0200)

----------------------------------------------------------------
- Add Sapphire Rapids to the list of CPUs supporting the SMI count MSR

----------------------------------------------------------------
Kan Liang (1):
      perf/x86/msr: Add Sapphire Rapids CPU support

 arch/x86/events/msr.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
