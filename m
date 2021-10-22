Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19939436F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 03:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhJVBCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 21:02:51 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60156 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231770AbhJVBCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:02:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1277D201B22;
        Fri, 22 Oct 2021 03:00:30 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F3C68201A98;
        Fri, 22 Oct 2021 03:00:28 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 4BA2E40BF1;
        Thu, 21 Oct 2021 18:00:28 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] soc/fsl drivers changes for next(v5.16)
Date:   Thu, 21 Oct 2021 20:00:27 -0500
Message-Id: <20211022010027.11866-2-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211022010027.11866-1-leoyang.li@nxp.com>
References: <20211022010027.11866-1-leoyang.li@nxp.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.16

for you to fetch changes up to 54c8b5b6f8a868b9c21a7b0efe92ed2fbcc67080:

  soc: fsl: dpio: rename the enqueue descriptor variable (2021-10-21 19:38:56 -0500)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.16

DPIO Driver
- Code cleanup and fix compile warning

RCMP and Guts Driver
- Make use of the helper function devm_platform_ioremap_resource()

----------------------------------------------------------------
Cai Huoqing (2):
      soc: fsl: guts: Make use of the helper function devm_platform_ioremap_resource()
      soc: fsl: rcpm: Make use of the helper function devm_platform_ioremap_resource()

Ioana Ciornei (1):
      soc: fsl: dpio: use an explicit NULL instead of 0

Youri Querry (1):
      soc: fsl: dpio: rename the enqueue descriptor variable

 drivers/soc/fsl/dpio/dpio-service.c | 2 +-
 drivers/soc/fsl/dpio/qbman-portal.c | 8 ++++----
 drivers/soc/fsl/guts.c              | 4 +---
 drivers/soc/fsl/rcpm.c              | 7 +------
 4 files changed, 7 insertions(+), 14 deletions(-)
