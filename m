Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6CA313DB3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhBHSh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:37:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233595AbhBHQbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:31:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B02B364D87;
        Mon,  8 Feb 2021 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612801826;
        bh=fQFemOSgifpQI5wwJyQgh1a2E7JZ/QeOPL5Rh0GR4f4=;
        h=Date:From:To:Cc:Subject:From;
        b=YgFNhZtmzhuq9k++dNKsRqYefk0X4+fTPp7t0GGz3M4S3MLcHKOVlN9ZtrGrfFTqW
         UT09fplJQzm1bUqsSKVoomfdBM8mWNi9yg3XpX1cqbZLhlo98boAhLc6CBI+iZAoTz
         jOs0XEpvYZmjX1pQpPVp3t0zxZZXK5g661bVnDsp0Cggwt/HqWtm8tO0EFsKzO6seP
         PQBhxMFeGcBBMTIhEdLQAL1PbgmiCpxHm3Tn/VtZlst7RJtgSk4sOh1rPlxWEAj5ku
         mA6QmdLdpxzUYxVKJ3uAANKWjpvh1IJpXpa0fbpCOmJ3X/bo+3gM6rFmXP1cn/R/r6
         4F8hZXCU/QuWQ==
Date:   Mon, 8 Feb 2021 18:30:22 +0200
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs second pull request for kernel 5.12
Message-ID: <20210208163022.GA5745@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is habanalabs second pull request for the merge window of
kernel 5.12.
It contains important fixes, especially in the firmware-related code.
Details are in the tag.

Thanks,
Oded

The following changes since commit 369aea84595189200a2e6b028f556a7efa0ec489:

  mei: implement client dma setup. (2021-02-06 15:48:11 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2021-02-08

for you to fetch changes up to da5dfbb97a82ff698e1dc7b229d4d4f5759dad2b:

  habanalabs/gaudi: don't enable clock gating on DMA5 (2021-02-08 18:20:08 +0200)

----------------------------------------------------------------
This tag contains the following changes for 5.12-rc1:

- Improve communication protocol with device CPU CP application.
  The change prevents random (rare) out-of-sync errors.

- Notify F/W to start sending events only after initialization of
  device is done. This fixes the issue where fatal events were received
  but ignored.

- Fix integer handling (static analysis warning).

- Always fetch HBM ECC errors from F/W (if available).

- Minor fix in GAUDI-specific initialization code.

----------------------------------------------------------------
Oded Gabbay (4):
      habanalabs: fix integer handling issue
      habanalabs: enable F/W events after init done
      habanalabs: return block size + block ID
      habanalabs/gaudi: don't enable clock gating on DMA5

Ofir Bitton (2):
      habanalabs: improve communication protocol with cpucp
      habanalabs: support fetching first available user CQ

Ohad Sharabi (2):
      habanalabs/gaudi: use HBM_ECC_EN bit for ECC ERR
      habanalabs: update security map after init CPU Qs

 drivers/misc/habanalabs/common/device.c            | 23 ++++++++--
 drivers/misc/habanalabs/common/firmware_if.c       | 14 ++++++-
 drivers/misc/habanalabs/common/habanalabs.h        | 15 +++++--
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |  3 +-
 drivers/misc/habanalabs/common/memory.c            | 19 +++++----
 drivers/misc/habanalabs/common/mmu/mmu.c           |  2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 49 ++++++++++++++++++----
 drivers/misc/habanalabs/goya/goya.c                | 27 +++++++++---
 .../misc/habanalabs/include/common/hl_boot_if.h    |  5 +++
 include/uapi/misc/habanalabs.h                     | 30 ++++++++++---
 10 files changed, 148 insertions(+), 39 deletions(-)
