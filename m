Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7B64419E2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 11:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhKAKb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 06:31:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47526 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbhKAKb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 06:31:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2E84A218C8;
        Mon,  1 Nov 2021 10:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635762563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2tAQlkX5dqDNgEhpTucxQpxhwif5yeErWAKq3VlEFSI=;
        b=uyegI94bhOoN69axtRbTxfGEWVWCZvSI7iPj77RxojuAnTQ65rQXmr39UMTKXDxObfB9k+
        xreN+bwvya7wr9YCc3ZHk/bnPM8mr9OnLB6a+souN3IFtJ12o9CHfUbX3nA2WWr/7JTQd4
        kBSViGJefJTHI1Vry3/qWbtdqQowwZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635762563;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2tAQlkX5dqDNgEhpTucxQpxhwif5yeErWAKq3VlEFSI=;
        b=NZjjh2PpsnYgfXQDMsDUiV39mMuDO0f4qEMaIOrM2KTROO7vQU2iQaPUe1lj2T/zb4vsOn
        pSp50jl0KGL43rCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C35813AA9;
        Mon,  1 Nov 2021 10:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OHH5BYPBf2GSTgAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Nov 2021 10:29:23 +0000
Date:   Mon, 1 Nov 2021 11:29:24 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for v5.16
Message-ID: <YX/BhEUBTK4bkQNm@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull x86/cpu updates for v5.16.

Thx.

---
The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.16_rc1

for you to fetch changes up to 415de44076640483648d6c0f6d645a9ee61328ad:

  x86/cpu: Fix migration safety with X86_BUG_NULL_SEL (2021-10-21 20:49:16 +0200)

----------------------------------------------------------------
- Start checking a CPUID bit on AMD Zen3 which states that the CPU
clears the segment base when a null selector is written. Do the explicit
detection on older CPUs, zen2 and hygon specifically, which have the
functionality but do not advertize the CPUID bit. Factor in the presence
of a hypervisor underneath the kernel and avoid doing the explicit check
there which the HV might've decided to not advertize for migration
safety reasons, a.o.

- Add support for a new X86 CPU vendor: VORTEX. Needed for whitelisting
those CPUs in the hardware vulnerabilities detection

- Force the compiler to use rIP-relative addressing in the fallback path of
static_cpu_has(), in order to avoid unnecessary register pressure

----------------------------------------------------------------
Borislav Petkov (1):
      x86/umip: Downgrade warning messages to debug loglevel

H. Peter Anvin (1):
      x86/asm: Avoid adding register pressure for the init case in static_cpu_has()

H. Peter Anvin (Intel) (1):
      x86/asm: Add _ASM_RIP() macro for x86-64 (%rip) suffix

Jane Malalane (1):
      x86/cpu: Fix migration safety with X86_BUG_NULL_SEL

Marcos Del Sol Vives (1):
      x86/CPU: Add support for Vortex CPUs

 arch/x86/Kconfig.cpu              | 13 +++++++++++
 arch/x86/include/asm/asm.h        |  5 +++++
 arch/x86/include/asm/cpufeature.h | 13 +++++++----
 arch/x86/include/asm/processor.h  |  3 ++-
 arch/x86/kernel/cpu/Makefile      |  1 +
 arch/x86/kernel/cpu/amd.c         |  2 ++
 arch/x86/kernel/cpu/common.c      | 46 +++++++++++++++++++++++++++++++++------
 arch/x86/kernel/cpu/cpu.h         |  1 +
 arch/x86/kernel/cpu/hygon.c       |  2 ++
 arch/x86/kernel/cpu/vortex.c      | 39 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/umip.c            |  8 +++----
 11 files changed, 117 insertions(+), 16 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/vortex.c

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
