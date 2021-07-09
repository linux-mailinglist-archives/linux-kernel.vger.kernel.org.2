Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A313C2934
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 20:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhGIStX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 14:49:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230123AbhGIStX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 14:49:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1966613C2;
        Fri,  9 Jul 2021 18:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625856399;
        bh=VnebZJHhnbph+O650HrQvvkh14jKb5Oq2xbw35OBKaE=;
        h=Date:From:To:Cc:Subject:From;
        b=l0591HlaUwSzKzwX8XbUV22xLOd5TaICOeEE226OFbpuB9qJh/7RUciKBtQScSO9q
         m6S6hZC+OYZInYvSIIIpagXsRCUHEQjCFP/T9HMJ7jlIMYROb/l1iEGqIVxPvtPhjl
         5s69E7oeERziQyjUNDq4O0DAvK/Y4Wk87I9QUQtbSf9mWiqcHN6JlCtA/8OBWJP0Bl
         1xb19G1G2JcLghU8CkiJxdPX24nzE4MDG9NNcIs3V7NKGEoMpqt0l6Bg+xzdQTfbGc
         mcOglWwBVueLQjhQHTO4wWd8cM2NnROTb0ccf04GV4D4ranCkr1VzjrL3e4Iz6MQug
         /R73JSspM22QA==
Date:   Fri, 9 Jul 2021 21:46:33 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [GIT PULL] memblock, arm: fixup for the pfn_valid() rework for
 v5.14-rc1
Message-ID: <YOiZif/oQWkVzDgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is a fix for the rework of ARM's pfn_valid() implementation merged
during this merge window.

The following changes since commit a180bd1d7e16173d965b263c5a536aa40afa2a2a:

  iov_iter: remove uaccess_kernel() warning from iov_iter_init() (2021-07-04 16:12:42 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/fixes-2021-07-09

for you to fetch changes up to 024591f9a6e0164ec23301784d1e6d8f6cacbe59:

  arm: ioremap: don't abuse pfn_valid() to check if pfn is in RAM (2021-07-06 09:01:47 +0300)

----------------------------------------------------------------
arm: ioremap: don't abuse pfn_valid() to check if pfn is in RAM

The semantics of pfn_valid() is to check presence of the memory map for a
PFN and not whether a PFN is in RAM. The memory map may be present for a
hole in the physical memory and if such hole corresponds to an MMIO range,
__arm_ioremap_pfn_caller() will produce a WARN() and fail:

Use memblock_is_map_memory() instead of pfn_valid() to check if a PFN is in
RAM or not.

----------------------------------------------------------------
Mike Rapoport (1):
      arm: ioremap: don't abuse pfn_valid() to check if pfn is in RAM

 arch/arm/mm/ioremap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
-- 
Sincerely yours,
Mike.
