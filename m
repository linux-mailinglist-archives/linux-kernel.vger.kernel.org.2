Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84010322D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhBWPFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:05:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:38212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232695AbhBWPEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:04:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614092607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=l0lZhoa3dmJ6W/wL3TjQ0i4ENPMTPDH4uzwTUL0qFPo=;
        b=fdm51yzYLQesQMXZx7LTZK/3MXbq5A2WJzulEStY9vO1bwvdtX3amBg4nq/OIZpPC1Zgr6
        1KW/e83tmPYyRzGW0ECZE5DJvgvrcxf/Jr5dXzNgNrZzSdKKon0KGx7xSAch8JdPIjY1TV
        yYumkzRw1POSR/5fPKtfTqkvBtdlHRg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75311AFF0;
        Tue, 23 Feb 2021 15:03:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 290EFDA7AA; Tue, 23 Feb 2021 16:01:28 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.cz>, linux-kernel@vger.kernel.org,
        ira.weiny@intel.com, linux-mm@kvack.org
Subject: [GIT PULL] Kmap conversions for 5.12
Date:   Tue, 23 Feb 2021 16:01:25 +0100
Message-Id: <cover.1614090658.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Sterba <dsterba@suse.cz>

Hi,

this pull request contains changes regarding kmap API use and eg.
conversion from kmap_atomic to kmap_local_page.

The API belongs to memory management but to save cross-tree dependency
headaches we've agreed to take it through the btrfs tree because there
are some trivial conversions possible, while the rest will need some
time and getting the easy cases out of the way would be convenient.

The final patchset arrived shortly before merge window, which is not
perfect, but given that it's straightforward I don't think it's too
risky.

I've added it to my for-next branch and it's been in linux-next for more
than a week.  Meanwhile I've been testing it among my regular branches
with additional MM related debugging options.

The changes can be grouped:

- function exports, new helpers

- new VM_BUG_ON for additional verification; it's been discussed if it
  should be VM_BUG_ON or BUG_ON, the former was chosen due to
  performance reasons

- code replaced by relevant helpers

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git kmap-conversion-for-5.12-tag

for you to fetch changes up to bbc24c42f2c0ea037db3c7f319c860fd790aeb28:

  btrfs: convert to zero_user() (2021-02-11 20:18:25 +0100)

----------------------------------------------------------------
Ira Weiny (8):
      mm/highmem: Lift memcpy_[to|from]_page to core
      mm/highmem: Convert memcpy_[to|from]_page() to kmap_local_page()
      mm/highmem: Introduce memcpy_page(), memmove_page(), and memset_page()
      mm/highmem: Add VM_BUG_ON() to mem*_page() calls
      iov_iter: Remove memzero_page() in favor of zero_user()
      btrfs: use memcpy_[to|from]_page() and kmap_local_page()
      btrfs: use copy_highpage() instead of 2 kmaps()
      btrfs: convert to zero_user()

 fs/btrfs/compression.c  | 11 +++-------
 fs/btrfs/extent_io.c    | 22 ++++---------------
 fs/btrfs/inode.c        | 32 ++++++++--------------------
 fs/btrfs/lzo.c          |  4 ++--
 fs/btrfs/raid56.c       | 10 +--------
 fs/btrfs/reflink.c      | 12 ++---------
 fs/btrfs/send.c         |  7 ++-----
 fs/btrfs/zlib.c         | 10 +++------
 fs/btrfs/zstd.c         | 11 +++-------
 include/linux/highmem.h | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
 lib/iov_iter.c          | 26 +++--------------------
 11 files changed, 88 insertions(+), 113 deletions(-)
