Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D439311711
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhBEXYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbhBEOZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:25:16 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3BCC061A86
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:02:01 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BFF15387; Fri,  5 Feb 2021 17:01:58 +0100 (CET)
Date:   Fri, 5 Feb 2021 17:01:57 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fix for Linux v5.11-rc6
Message-ID: <20210205160146.GA28800@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac:

  Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.11-rc6

for you to fetch changes up to 4c9fb5d9140802db4db9f66c23887f43174e113c:

  iommu: Check dev->iommu in dev_iommu_priv_get() before dereferencing it (2021-02-02 15:57:23 +0100)

----------------------------------------------------------------
IOMMU Fix for Linux v5.11-rc6

	- Fix a possible NULL-ptr dereference in dev_iommu_priv_get()
	  which is too easy to accidentially trigger from IOMMU drivers.
	  In the current case the AMD IOMMU driver triggered it on some
	  machines in the IO-page-fault path, so fix it once and for
	  all.

----------------------------------------------------------------
Joerg Roedel (1):
      iommu: Check dev->iommu in dev_iommu_priv_get() before dereferencing it

 include/linux/iommu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg
