Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F47E36B201
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 12:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhDZK7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:59:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:33812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233159AbhDZK7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:59:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7310EAD69;
        Mon, 26 Apr 2021 10:58:32 +0000 (UTC)
Date:   Mon, 26 Apr 2021 12:58:35 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/platform for v5.13
Message-ID: <YIac22TH/Lcp/aBe@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

x86/platform consists solely of SGI UV stuff this time around. Please
pull.

Thx.

---

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.13

for you to fetch changes up to 27743f01e391ee1d80e3be2a09237507b965f91b:

  x86/platform/uv: Remove dead !CONFIG_KEXEC_CORE code (2021-04-20 10:08:34 +0200)

----------------------------------------------------------------
A bunch of SGI UV improvements, fixes and cleanups.

----------------------------------------------------------------
Georges Aureau (1):
      x86/platform/uv: Add more to secondary CPU kdump info

Ingo Molnar (2):
      x86/platform/uv: Fix !KEXEC build failure
      x86/platform/uv: Remove dead !CONFIG_KEXEC_CORE code

Justin Ernst (1):
      x86/platform/uv: Fix indentation warning in Documentation/ABI/testing/sysfs-firmware-sgi_uv

Mike Travis (2):
      x86/platform/uv: Set section block size for hubless architectures
      x86/platform/uv: Use x2apic enabled bit as set by BIOS to indicate APIC mode

 Documentation/ABI/testing/sysfs-firmware-sgi_uv |  2 +-
 arch/x86/Kconfig                                |  1 +
 arch/x86/kernel/apic/x2apic_uv_x.c              | 33 +++++++++---------
 arch/x86/platform/uv/uv_nmi.c                   | 46 ++++++++++++-------------
 4 files changed, 41 insertions(+), 41 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
