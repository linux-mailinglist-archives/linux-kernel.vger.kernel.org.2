Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F7331B7A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 11:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhBOKwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 05:52:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:50108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230331AbhBOKuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 05:50:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3576ACD4;
        Mon, 15 Feb 2021 10:49:19 +0000 (UTC)
Date:   Mon, 15 Feb 2021 11:49:22 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/platform for v5.12
Message-ID: <20210215104922.GE23409@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull x86/platform fixes for v5.12.

Thx.

---

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.12

for you to fetch changes up to 604303018221d00b58422e1d117ba29ce84295cb:

  x86/platform/geode: Convert alix LED to GPIO machine descriptor (2021-01-15 18:55:53 +0100)

----------------------------------------------------------------
- Convert geode drivers to look up the LED controls from a GPIO machine
  descriptor table.

- Remove arch/x86/platform/goldfish as it is not used by the android emulator
  anymore.

----------------------------------------------------------------
Linus Walleij (3):
      x86/platform/geode: Convert net5501 LED to GPIO machine descriptor
      x86/platform/geode: Convert geode LED to GPIO machine descriptor
      x86/platform/geode: Convert alix LED to GPIO machine descriptor

Roman Kiryanov (1):
      x86/platform: Retire arch/x86/platform/goldfish

Zheng Yongjun (1):
      x86/platform/intel-mid: Convert comma to semicolon

 arch/x86/platform/Makefile                         |  1 -
 arch/x86/platform/geode/alix.c                     | 19 +++++---
 arch/x86/platform/geode/geos.c                     | 19 +++++---
 arch/x86/platform/geode/net5501.c                  | 13 +++++-
 arch/x86/platform/goldfish/Makefile                |  2 -
 arch/x86/platform/goldfish/goldfish.c              | 54 ----------------------
 .../platform/intel-mid/device_libs/platform_bt.c   |  4 +-
 7 files changed, 39 insertions(+), 73 deletions(-)
 delete mode 100644 arch/x86/platform/goldfish/Makefile
 delete mode 100644 arch/x86/platform/goldfish/goldfish.c

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
