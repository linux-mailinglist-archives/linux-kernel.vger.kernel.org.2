Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCA83770B3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 10:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhEHIkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 04:40:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhEHIkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 04:40:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1A8C6143C;
        Sat,  8 May 2021 08:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620463175;
        bh=uerozKR51MTH+wgIUkFNh89+nB4r6+wEZYiHNYTi8TE=;
        h=Date:From:To:Cc:Subject:From;
        b=j2i+BiidZb5CwgM9H1xsKCpau729NbH6I4eE6tTU6oRC9Vvl2UPzMQne3Izl6Bxpx
         QfpLQiru+k40xIRSMzYQLjnfdlJkTukwDuNefZATeuZKnlNyMYxF/wQOjdvEsuUhmQ
         WCDtoAcfyGUNJBYj7MPYcWNPA4wfuf+p2nS2fasN3m0NixpbMmttE/3hl+tbIRt8pK
         +ll6gMkjBwS3bXX3vAcLHf5nUKGKKU89BCok0dDx49ziLNs+WwmitKZvimBrGfYQdp
         fIO06zdxp4vrWaBq0F8uOJGSYOSuCodiXoX8DVVoeSlNOHncI78ZHHQ2fKd80kN13M
         XxpfnUaCeWD8Q==
Date:   Sat, 8 May 2021 11:39:31 +0300
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.13-rc2
Message-ID: <20210508083931.GA21544@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This pull request contains a number of important fixes for 5.13-rc2.
Mainly fixes to support our new F/W with enhanced security features,
but also additional bugs.
See details in the tag message below.

Thanks,
Oded

The following changes since commit a48b0872e69428d3d02994dcfad3519f01def7fa:

  Merge branch 'akpm' (patches from Andrew) (2021-05-07 00:34:51 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2021-05-08

for you to fetch changes up to 115726c5d312b462c9d9931ea42becdfa838a076:

  habanalabs/gaudi: Fix a potential use after free in gaudi_memset_device_memory (2021-05-08 11:36:07 +0300)

----------------------------------------------------------------
This tag contains the following fixes for 5.13-rc2:

- Expose PLL information per ASIC. This also fixes some casting warnings.
- Skip reading further firmware errors in case PCI link is down.
- Security firmware error should be handled as error and not warning.
- Allow user to ignore firmware errors.
- Fix bug in timeout calculation when waiting for interrupt of CS.
- Fix bug of potential use-after-free.

----------------------------------------------------------------
Bharat Jauhari (1):
      habanalabs: expose ASIC specific PLL index

Lv Yunlong (1):
      habanalabs/gaudi: Fix a potential use after free in gaudi_memset_device_memory

Oded Gabbay (3):
      habanalabs: skip reading f/w errors on bad status
      habanalabs: change error level of security not ready
      habanalabs: ignore f/w status error

Ofir Bitton (1):
      habanalabs: wait for interrupt wrong timeout calculation

 .../misc/habanalabs/common/command_submission.c    |  2 +-
 drivers/misc/habanalabs/common/firmware_if.c       | 53 +++++++++++--------
 drivers/misc/habanalabs/common/habanalabs.h        | 23 ++++++---
 drivers/misc/habanalabs/common/habanalabs_drv.c    |  7 +++
 drivers/misc/habanalabs/common/sysfs.c             |  4 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 59 +++++++++-------------
 drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c        | 12 ++---
 drivers/misc/habanalabs/goya/goya.c                | 47 +++++++----------
 drivers/misc/habanalabs/goya/goya_hwmgr.c          | 40 +++++++--------
 include/uapi/misc/habanalabs.h                     | 33 ++++++++++++
 10 files changed, 156 insertions(+), 124 deletions(-)
