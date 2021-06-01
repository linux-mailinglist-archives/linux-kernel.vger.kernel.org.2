Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9174C397CFB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 01:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbhFAXYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 19:24:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234766AbhFAXYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 19:24:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F246461026;
        Tue,  1 Jun 2021 23:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622589755;
        bh=Se0vr8HjjuDI8G7XYVGiPoR/r6XQrsDheJYzxnwLFiA=;
        h=From:To:Cc:Subject:Date:From;
        b=lm5J/tOLNt1E6CBn8MvYDvNyPnF6vnpKrF7mLRGMR5DjINnhiOWID2oaRBxMdKnoH
         hfVeg5z9RDRwYGuaZUiXAZxKlqk3czXqV04hFTUpW6U6gyZhMmCKwTCPmP2KQB/HaH
         myQ5Z1TP0piPwxBlAxRiyKo5HStdz7iaRo6VR2PBwY0bviyRM2q0ki9sxrBbAugpdJ
         Lu6S5WPGpbXfpBGdwtc+TYkOpQVMKGF/5BrflodcqhDYa0bwkmhotrE1kyNpK24S2B
         gdeN7evdS/69FUK0IcZ6xrmC6+OAKeJpshrNiTkwZk1eY7zwK/gSVuIlLar72jrrds
         7xEhG4SwjOCuw==
From:   Ming Lin <mlin@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Simon Ser <contact@emersion.fr>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ming Lin <mlin@kernel.org>
Subject: [PATCH 0/2] mm: adds MAP_NOSIGBUS extension for shmem read
Date:   Tue,  1 Jun 2021 16:22:31 -0700
Message-Id: <1622589753-9206-1-git-send-email-mlin@kernel.org>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These 2 patches are based on the discussion of "Sealed memfd & no-fault mmap"
at https://bit.ly/3pdwOGR

patch 1: make "vm_flags" be an u64, so we can have enough bits on 32-bit
architectures. Then we can add VM_NOSIGBUS which is bit 38.

patch 2: support no-fault mmap for shmem read

Ming Lin (2):
  mm: make "vm_flags" be an u64
  mm: adds NOSIGBUS extension for out-of-band shmem read

 arch/arm64/Kconfig                     |   1 -
 arch/powerpc/Kconfig                   |   1 -
 arch/x86/Kconfig                       |   1 -
 include/linux/mm.h                     | 102 ++++++++++++++++-----------------
 include/linux/mm_types.h               |   4 +-
 include/linux/mman.h                   |   5 +-
 include/uapi/asm-generic/mman-common.h |   1 +
 mm/Kconfig                             |   2 -
 mm/memory.c                            |   2 +-
 mm/mmap.c                              |   5 +-
 mm/shmem.c                             |  17 +++++-
 11 files changed, 76 insertions(+), 65 deletions(-)

-- 
1.8.3.1

