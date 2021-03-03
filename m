Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BF132C0D5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386779AbhCCSqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:46:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243006AbhCCRaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:30:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFE9B64EDB;
        Wed,  3 Mar 2021 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614792597;
        bh=b5SxC+H+cvkxpArFsunrLLawT4SeX25oPPqB53vqkdw=;
        h=Date:From:To:Cc:Subject:From;
        b=sJXKvt6W9xR2eYDqhvM6JYd7pUhz5eI6bMUcy5F5lIn94G8TJ+BcgPwxoGHWSVgZd
         gig5fXkj87IXrC/Tuf8Avvo8MDGbQXvF0G7IPUIPnnkhOSC9NNvfNTeSk2XLzcMVVh
         PCewE90xx0vpX/cmePISmhOeyrpw/mKmsTCD5LXX9Q9Qsg1vvxmWV42e0/tR1eu3dI
         Fxtp8oyWfTbxOkvghM7ArEtcSKfVNnFVgJ6iTEJ58RD3F7MpuTDEG9Zgm05Gf1z98t
         sD2FQSOApc9K5C1OFO2xQw9LDH/4Jnl1B1jYuDC3TJGV7SxUoy9H4863kR5IsCneTp
         edfNHINyvdF4w==
Date:   Wed, 3 Mar 2021 19:29:50 +0200
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull resend] habanalabs fixes for 5.12-rc2
Message-ID: <20210303172950.GA3624@CORE.localdomain>
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
