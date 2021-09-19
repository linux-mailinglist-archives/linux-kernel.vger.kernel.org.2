Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F9B410AF4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 11:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbhISJp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 05:45:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237818AbhISJpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 05:45:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73712610A8;
        Sun, 19 Sep 2021 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632044657;
        bh=XvNnS/0B+zW3GGy7xwtCUzNn/A2pr7pa4LjzYtMKWSk=;
        h=Date:From:To:Cc:Subject:From;
        b=rGnEPxj2T/BEjjqe+27gnv/VytWeKdtHuYNhPUEbFCqdlAHuba1asW3D+sAeeq4vT
         MIWdwI1uUX7qGoce0xY3dTfr+V4xE61sbG5adWxSGw2YItr3l6OuwXw7ZgrF5GVMT6
         zP5VOOxriPmylJn53kgsNWmD6wgxPcnR5IjxFCiFpFJ/qDHnY26GLNO2Z5hfU/d+Ho
         wZs7NFiT1wcp78E3OMXCgpjTpUClOSl1x/pvUaz+OoUvzmvBnIagzSoqS/2EPQXCbL
         pf9HvD2TPglmCGAO1uSnkVMm1PORyDa33y9Juv8ToHNJEC+Nc5Uu2gLglNIP8BsCrJ
         hEDBvXY7/J69w==
Date:   Sun, 19 Sep 2021 12:44:13 +0300
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.15-rc3
Message-ID: <20210919094413.GA25155@ogabbay-vm2.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Some important fixes for the habanalabs driver for 5.15.
They fix a couple of bugs that can result in kernel BUG,
data race, kernel log spamming, etc.

Full details are in the tag.

Thanks,
Oded

The following changes since commit 25a1433216489de4abc889910f744e952cb6dbae:

  mcb: fix error handling in mcb_alloc_bus() (2021-09-14 11:22:26 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2021-09-19

for you to fetch changes up to c8fee41957f036cbc8e840bd91e2087731df7f7e:

  habanalabs: expose a single cs seq in staged submissions (2021-09-14 15:00:04 +0300)

----------------------------------------------------------------
This tag contains the following fixes for 5.15-rc3:

- Fix potential race when user waiting for interrupt ioctl
- Prevent possible kernel oops in staged CS ioctl
- Use direct MSI mechanism in Gaudi as a WA for a H/W issue
  regarding FLR
- Don't support collective wait ioctl operation when it
  is not supported. e.g. when the NIC ports are disabled
- Fix configuration of one of the security mechanism.
- Change error print to be rate-limited as it can be initiated
  by the user and spam the kernel log
- Fix return value of CS ioctl when doing staged CS
- Fix CS ioctl code when user doesn't supply an offset for
  the memory area that we use as fence.
- Spelling mistake fix

----------------------------------------------------------------
Colin Ian King (1):
      habanalabs: Fix spelling mistake "FEADBACK" -> "FEEDBACK"

Oded Gabbay (1):
      habanalabs/gaudi: fix LBW RR configuration

Ofir Bitton (4):
      habanalabs: fix potential race in interrupt wait ioctl
      habanalabs: fail collective wait when not supported
      habanalabs: rate limit multi CS completion errors
      habanalabs: expose a single cs seq in staged submissions

Omer Shpigelman (1):
      habanalabs/gaudi: use direct MSI in single mode

farah kassabri (2):
      habanalabs: fix kernel OOPs related to staged cs
      habanalabs: fix wait offset handling

 .../misc/habanalabs/common/command_submission.c    |  71 +++++++++----
 drivers/misc/habanalabs/common/hw_queue.c          |   9 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |  11 +-
 drivers/misc/habanalabs/gaudi/gaudi_security.c     | 115 ++++++++++++---------
 .../habanalabs/include/gaudi/asic_reg/gaudi_regs.h |   2 +
 5 files changed, 134 insertions(+), 74 deletions(-)
