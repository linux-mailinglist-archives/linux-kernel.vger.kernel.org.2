Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1901432ADFA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360275AbhCBWSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:18:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381306AbhCBUzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 15:55:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4D3860234;
        Tue,  2 Mar 2021 20:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614718449;
        bh=WPES5mJbL/WtQJ26AB+MkiRseYFGbbHed1t6CUB9uC4=;
        h=Date:From:To:Cc:Subject:From;
        b=fbVplROGUho2msPJqkJwHcO/2OmD+s9MA0YB3PVGurpU/WWRKUevc0+zDGAx+4OnZ
         WMYE88MJILFND/yjlzKiYUawG+B9TYb5l9I2DHPWo3IPKkcw0UdNn0Os+VlYm3EKPC
         nc4uCaA35tLLT5kPGoc4IgRfBE1vgEw6ZAAnx8jWhEB8K6IHmhxGPQVXiJRVnjK1bq
         BHYhFgkNmbM8OY/kK4xtfufsswgv+GEdIFjbS4V/9hcvNr6q4IWcBroQWJGNy0ZyKX
         K7SciUTbiic222PbQNwd/9wZYrr86wqVc8qfYT0b+dImxuW6SZ73fDcI83pZmiSjvr
         91e0RieTzs0qg==
Date:   Tue, 2 Mar 2021 22:54:05 +0200
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.12-rc2
Message-ID: <20210302205405.GA648@CORE.localdomain>
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

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2021-03-02

for you to fetch changes up to bbcbfc85556ed9b2a15955eb6f9b5b732e6b1795:

  habanalabs: fix debugfs address translation (2021-03-02 15:07:09 +0200)

----------------------------------------------------------------
This tag contains the following fixes for 5.12-rc2:

- Call put_pid() when the user releases the control device.
- Disable file operations after a PCI device is removed.
- Fix address translation when displaying the memory mappings
  through our debugFS.
- Remove unused dentry pointer for debugFS files.
- Mark function as static.

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
