Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE1328E60
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 20:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbhCAT3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 14:29:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:44236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235820AbhCAQxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:53:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614617536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=U+5ZpAg7k3GbYMv33RTf8RSn8xdW5qBDE9NV7DZ/Z9o=;
        b=rNwQ0jFHFzkq2MlfMI6+lmnqz7EbgnPPXTLiZ43kunSCGpzEFxBCbAX4N+c2fsPhuxaHld
        PV7O9RUWl1e1CP+1nLLPzo+42nCvOvSiRmlGAF9r/9dAihywK29Kko26TxEQa0KPaZcsOu
        eHomxFWrS1Aiol/K/17pi7lYBwFN28s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9EEC8ADDD;
        Mon,  1 Mar 2021 16:52:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 00E44DA7AA; Mon,  1 Mar 2021 17:50:21 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        ira.weiny@intel.com, linux-mm@kvack.org
Subject: [GIT PULL] Kmap conversions for 5.12, take 2
Date:   Mon,  1 Mar 2021 17:50:13 +0100
Message-Id: <cover.1614616683.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this pull request contains changes regarding kmap API use and eg.
conversion from kmap_atomic to kmap_local_page.

Changes against v1 [1]:

- dropped patches using zero_user
- retested with my regular fstests-based workloads over the weekend

I'm keeping the original merge changelog as it seems to apply to v2 as
well.

Please pull, thanks.

[1] https://lore.kernel.org/lkml/cover.1614090658.git.dsterba@suse.com/

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

----------------------------------------------------------------
The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git kmap-conversion-for-5.12

for you to fetch changes up to 80cc83842394e5ad3e93487359106aab3420bcb7:

  btrfs: use copy_highpage() instead of 2 kmaps() (2021-02-26 12:45:15 +0100)

----------------------------------------------------------------
Ira Weiny (6):
      mm/highmem: Lift memcpy_[to|from]_page to core
      mm/highmem: Convert memcpy_[to|from]_page() to kmap_local_page()
      mm/highmem: Introduce memcpy_page(), memmove_page(), and memset_page()
      mm/highmem: Add VM_BUG_ON() to mem*_page() calls
      btrfs: use memcpy_[to|from]_page() and kmap_local_page()
      btrfs: use copy_highpage() instead of 2 kmaps()

 fs/btrfs/compression.c  |  6 ++----
 fs/btrfs/lzo.c          |  4 ++--
 fs/btrfs/raid56.c       | 10 +--------
 fs/btrfs/reflink.c      |  6 +-----
 fs/btrfs/send.c         |  7 ++-----
 fs/btrfs/zlib.c         |  5 ++---
 fs/btrfs/zstd.c         |  6 ++----
 include/linux/highmem.h | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
 lib/iov_iter.c          | 14 -------------
 9 files changed, 68 insertions(+), 46 deletions(-)
