Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A324407099
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 19:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhIJRf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 13:35:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhIJRf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 13:35:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 424DD60F6C;
        Fri, 10 Sep 2021 17:34:44 +0000 (UTC)
Date:   Fri, 10 Sep 2021 18:34:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.15-rc1
Message-ID: <YTuXMRtjCu51AUj3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 65266a7c6abfa1ad915a362c41bf38576607f1f9:

  Merge remote-tracking branch 'tip/sched/arm64' into for-next/core (2021-08-31 09:10:00 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 85f58eb1889826b9745737718723a80b639e0fbd:

  arm64: kdump: Skip kmemleak scan reserved memory for kdump (2021-09-10 11:58:59 +0100)

----------------------------------------------------------------
arm64 fixes:

- Limit the linear region to 51-bit when KVM is running in nVHE mode
  otherwise, depending on the placement of the ID map, kernel-VA to
  hyp-VA translations may produce addresses that either conflict with
  other HYP mappings or generate addresses outside of the 52-bit
  addressable range.

- Instruct kmemleak not to scan the memory reserved for kdump as this
  range is removed from the kernel linear map and therefore not
  accessible.

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: mm: limit linear region to 51 bits for KVM in nVHE mode

Chen Wandun (1):
      arm64: kdump: Skip kmemleak scan reserved memory for kdump

 arch/arm64/mm/init.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

-- 
Catalin
