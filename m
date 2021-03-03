Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BA132BBD9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358706AbhCCNCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 08:02:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1842848AbhCCIOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:14:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E82664E4A;
        Wed,  3 Mar 2021 08:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614759206;
        bh=b5SxC+H+cvkxpArFsunrLLawT4SeX25oPPqB53vqkdw=;
        h=Date:From:To:Cc:Subject:From;
        b=eoTzFd121sN+Ycjr0YMQp9KBlYGjd/Eu8edTrCvZVcDwCUo6PKb/pvF8dfOwbi5aB
         GKx4bhxqC4+td6nwb65mTkndLde7pUp9PG5AEaFvROvax2R6KyGCDLUpsfiyyD4Bm5
         YlNFE2RvZy+jh+W7T4v6/3Bs5BJMwoQ3QvSzGiR8jFkFhNklXYoLj3DFNzoWMrzq2W
         U/9G+N5RbAtjd8hqyNbfJVWWLMYqn7+SC9rZPbw5qy8eomZdvgbd68Xdqna7kipaMT
         E6eXaPz0SspCS0pCJXIjImXtwcLabzn5EofUIVpTT51P7oK4rK6FZr6su39+UH4usA
         mNBqXxOwXJEbQ==
Date:   Wed, 3 Mar 2021 10:13:21 +0200
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull resend] habanalabs fixes for 5.12-rc2
Message-ID: <20210303081321.GA6609@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This pull request contains some fixes of the habanalabs driver for
5.12-rc2.
Nothing too scary, more details are in the tag.

Thanks,
Oded

The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:

  Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2021-03-03

for you to fetch changes up to 3612e9f5df4c0c605ab2e4b569214786cc701cb9:

  habanalabs: fix debugfs address translation (2021-03-03 09:56:58 +0200)

----------------------------------------------------------------
This tag contains the following fixes for 5.12-rc2:

- Call put_pid() when the user releases the control device.
- Disable file operations after a PCI device is removed.
- Fix address translation when displaying the memory mappings
  through our debugFS.
- Remove unused dentry pointer for debugFS files.

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      drivers: habanalabs: remove unused dentry pointer for debugfs files

Oded Gabbay (1):
      habanalabs: mark hl_eq_inc_ptr() as static

Tomer Tayar (2):
      habanalabs: Call put_pid() when releasing control device
      habanalabs: Disable file operations after device is removed

farah kassabri (1):
      habanalabs: fix debugfs address translation

 drivers/misc/habanalabs/common/debugfs.c          |  5 +--
 drivers/misc/habanalabs/common/device.c           | 40 ++++++++++++++++++++---
 drivers/misc/habanalabs/common/habanalabs.h       |  2 --
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 12 +++++++
 drivers/misc/habanalabs/common/irq.c              |  2 +-
 drivers/misc/habanalabs/common/mmu/mmu.c          | 38 ++++++++++++++-------
 6 files changed, 75 insertions(+), 24 deletions(-)
