Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCD9436F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 03:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhJVBCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 21:02:50 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41030 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232385AbhJVBCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:02:46 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 12F221A1ADF;
        Fri, 22 Oct 2021 03:00:29 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CB7941A1ADD;
        Fri, 22 Oct 2021 03:00:28 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 0E6A040007;
        Thu, 21 Oct 2021 18:00:28 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] soc/fsl drivers changes for fix(v5.15)
Date:   Thu, 21 Oct 2021 20:00:26 -0500
Message-Id: <20211022010027.11866-1-leoyang.li@nxp.com>
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

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-fix-v5.15

for you to fetch changes up to 7e5e744183bbb0ad02412b21b1e61380c998dd18:

  soc: fsl: dpio: fix qbman alignment error in the virtualization context (2021-10-21 18:20:21 -0500)

----------------------------------------------------------------
NXP/FSL SoC driver fixes for v5.15

DPAA2 DPIO driver
- replace smp_processor_id with raw_smp_processor_id to fix preempt
debug BUG
- use the combined functions to protect critical zone to fix deadlock
- fix qbman alignment error in the virtualization context

DPAA2 console
- free buffer before returning from dpaa2_console_read

----------------------------------------------------------------
Diana Craciun (1):
      soc: fsl: dpio: fix qbman alignment error in the virtualization context

Meng Li (2):
      soc: fsl: dpio: replace smp_processor_id with raw_smp_processor_id
      soc: fsl: dpio: use the combined functions to protect critical zone

Robert-Ionut Alexa (1):
      soc: fsl: dpaa2-console: free buffer before returning from dpaa2_console_read

 drivers/soc/fsl/dpaa2-console.c     |  1 +
 drivers/soc/fsl/dpio/dpio-service.c |  2 +-
 drivers/soc/fsl/dpio/qbman-portal.c | 33 +++++++++++++++------------------
 3 files changed, 17 insertions(+), 19 deletions(-)
