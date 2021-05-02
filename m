Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FFC370DD8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 18:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhEBQRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 12:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhEBQRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 12:17:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C51A61186;
        Sun,  2 May 2021 16:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619972204;
        bh=pIDWk6FyAtEOLQrgZAggBNgXLjZd4wjRiQSPTrBfdh0=;
        h=Date:From:To:Cc:Subject:From;
        b=RBCGyk3h03N2jSLziY9s89TStOiEKP/Qlz5bnqZoTqHBukCsJsbFCAaFPZIBvly6H
         CDHzGt6cNO0IVmN80MLjW4Q4Do0+GT5w8N9EGO+6EkFN0/XGUhY6RjCaspQlPlM0E/
         eqGz/aHeF5O9/All9W2P3R6VQdfrmG1FeJ+3oQuDZCV/Q5HOvHNPbTNz24hXY/3Suu
         NQxfcba45JWrTRKr7xzoAvRrfqDpaSZJfkTM/Ng82AC+996wvt8pHeW9cQnZ/fCqgb
         M4oseX6DPZdLH91WNOLli6bnWKcSLd8fiBS7Jg658ajuq4PHRWQ4dWTB8+nHe8305J
         Ex/B2FPj7unVA==
Date:   Sun, 2 May 2021 19:16:40 +0300
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.13-rc2
Message-ID: <20210502161640.GA14011@CORE.localdomain>
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

The following changes since commit 7b1ae248279bea33af9e797a93c35f49601cb8a0:

  dyndbg: fix parsing file query without a line-range suffix (2021-04-30 07:43:20 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2021-05-02

for you to fetch changes up to 0552cea3a2e8af3e099d2b8c05aa290ffe680d92:

  habanalabs: wait for interrupt wrong timeout calculation (2021-05-02 18:54:54 +0300)

----------------------------------------------------------------
This tag contains the following fixes for 5.12-rc2:

- Expose PLL information per ASIC. This also fixes some casting warnings.
- Skip reading further firmware errors in case PCI link is down.
- Security firmware error should be handled as error and not warning.
- Allow user to ignore firmware errors.
- Fix bug in timeout calculation when waiting for interrupt of CS.

----------------------------------------------------------------
Bharat Jauhari (1):
      habanalabs: expose ASIC specific PLL index

Oded Gabbay (3):
      habanalabs: skip reading f/w errors on bad status
      habanalabs: change error level of security not ready
      habanalabs: ignore f/w status error

Ofir Bitton (1):
      habanalabs: wait for interrupt wrong timeout calculation

 .../misc/habanalabs/common/command_submission.c    |  2 +-
 drivers/misc/habanalabs/common/firmware_if.c       | 53 ++++++++++++---------
 drivers/misc/habanalabs/common/habanalabs.h        | 23 +++++----
 drivers/misc/habanalabs/common/habanalabs_drv.c    |  7 +++
 drivers/misc/habanalabs/common/sysfs.c             |  4 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 55 ++++++++--------------
 drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c        | 12 ++---
 drivers/misc/habanalabs/goya/goya.c                | 47 +++++++-----------
 drivers/misc/habanalabs/goya/goya_hwmgr.c          | 40 ++++++++--------
 include/uapi/misc/habanalabs.h                     | 33 +++++++++++++
 10 files changed, 153 insertions(+), 123 deletions(-)
