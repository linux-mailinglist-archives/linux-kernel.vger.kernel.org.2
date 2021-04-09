Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F254C35A831
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhDIU5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:57:36 -0400
Received: from inva020.nxp.com ([92.121.34.13]:53868 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234278AbhDIU5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:57:35 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D2FC1A5347;
        Fri,  9 Apr 2021 22:57:20 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 335131A5340;
        Fri,  9 Apr 2021 22:57:20 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 73E1940A63;
        Fri,  9 Apr 2021 13:57:19 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] soc/fsl drivers changes for next(v5.13)
Date:   Fri,  9 Apr 2021 15:57:19 -0500
Message-Id: <20210409205719.27927-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi soc maintainers,

Please merge the following new changes for soc/fsl drivers.

Regards,
Leo

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.13

for you to fetch changes up to 242b0b398ccd34f73772120bd27a87a1bf00e30b:

  soc: fsl: enable acpi support in RCPM driver (2021-04-08 16:34:15 -0500)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.13

- Add ACPI support for RCPM driver
- Use generic io{read,write} for QE drivers after performance optimized
  for PowerPC
- Fix QBMAN probe to cleanup HW states correctly for kexec
- Various cleanup and style fix for QBMAN/QE/GUTS drivers

----------------------------------------------------------------
Aditya Srivastava (1):
      soc: fsl: guts: fix comment syntax in file

Christophe Leroy (3):
      soc: fsl: qe: replace qe_io{read,write}* wrappers by generic io{read,write}*
      tty: serial: ucc_uart: replace qe_io{read,write}* wrappers by generic io{read,write}*
      Revert "soc: fsl: qe: introduce qe_io{read,write}* wrappers"

Peng Ma (1):
      soc: fsl: enable acpi support in RCPM driver

Roy Pledge (1):
      soc: fsl: qbman: Ensure device cleanup is run for kexec

Yang Li (1):
      soc: fsl: guts: remove unneeded semicolon

Zheng Yongjun (2):
      soc: fsl: qbman: Delete useless kfree code
      soc: fsl: qe: Use DEFINE_SPINLOCK() for spinlock

 drivers/soc/fsl/guts.c              |   2 +-
 drivers/soc/fsl/qbman/bman.c        |   1 -
 drivers/soc/fsl/qbman/bman_portal.c |   3 +-
 drivers/soc/fsl/qbman/qman_portal.c |   3 +-
 drivers/soc/fsl/qe/gpio.c           |  20 +++---
 drivers/soc/fsl/qe/qe.c             |  24 +++----
 drivers/soc/fsl/qe/qe_common.c      |   3 +-
 drivers/soc/fsl/qe/qe_ic.c          |   4 +-
 drivers/soc/fsl/qe/qe_io.c          |  36 +++++------
 drivers/soc/fsl/qe/ucc_fast.c       |  68 ++++++++++----------
 drivers/soc/fsl/qe/ucc_slow.c       |  42 ++++++------
 drivers/soc/fsl/rcpm.c              |  24 ++++++-
 drivers/tty/serial/ucc_uart.c       | 124 ++++++++++++++++++------------------
 include/linux/fsl/guts.h            |   4 +-
 include/soc/fsl/qe/qe.h             |  34 +++-------
 15 files changed, 198 insertions(+), 194 deletions(-)
