Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1CC381D21
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 08:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbhEPGbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 02:31:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:49752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbhEPGbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 02:31:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621146620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=v8til0hEEG2JW3BLQ4jQ4a/ff0IVW6Ge5T7xlA6EHMc=;
        b=i3+w7E43uApRIFjjRPrk53E9roPfVn2nk/KLRgw44xW2S4mCZCBvBx6m5oN/6Z/ZsE0O8s
        EKcO/KbRVF44/RZcWPPCBLfsnzb3ZL3h22zp7xqZLXuPouMF/KQ8BA/Bs6mzDqND+jSxPI
        MF09hpK2S2YICkwnv7hHHARUy4OAzhA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31C65AED7;
        Sun, 16 May 2021 06:30:20 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.13-rc2
Date:   Sun, 16 May 2021 08:30:19 +0200
Message-Id: <20210516063019.3296-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.13b-rc2-tag

xen: branch for v5.13-rc2

It contains the following patches:

- 2 patches for error path fixes
- a small series for fixing a regression with swiotlb with Xen on Arm


Thanks.

Juergen

 arch/arm/xen/mm.c               | 20 +++++++-------------
 arch/arm64/mm/init.c            |  3 ++-
 drivers/xen/gntdev.c            |  4 +++-
 drivers/xen/swiotlb-xen.c       |  5 +++++
 drivers/xen/unpopulated-alloc.c |  4 +++-
 include/xen/arm/swiotlb-xen.h   | 15 ++++++++++++++-
 6 files changed, 34 insertions(+), 17 deletions(-)

Christoph Hellwig (1):
      arm64: do not set SWIOTLB_NO_FORCE when swiotlb is required

Juergen Gross (2):
      xen/gntdev: fix gntdev_mmap() error exit path
      Merge tag 'for-linus-5.13b-rc2-tag' of gitolite.kernel.org:pub/scm/linux/kernel/git/xen/tip into __for-linus-5.13b-rc2-tag

Stefano Stabellini (2):
      xen/arm: move xen_swiotlb_detect to arm/swiotlb-xen.h
      xen/swiotlb: check if the swiotlb has already been initialized

Zhen Lei (1):
      xen/unpopulated-alloc: fix error return code in fill_list()
