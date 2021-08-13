Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831AA3EBE3E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 00:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbhHMWXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 18:23:37 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45542 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235029AbhHMWXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 18:23:36 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B4242002CD;
        Sat, 14 Aug 2021 00:23:07 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C8B4320005D;
        Sat, 14 Aug 2021 00:23:06 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 0BD8F40A55;
        Fri, 13 Aug 2021 15:23:06 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] soc/fsl drivers changes for fix(v5.14)
Date:   Fri, 13 Aug 2021 17:23:05 -0500
Message-Id: <20210813222305.13663-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi soc maintainers,

Please merge the following fixes for soc/fsl drivers.

Regards,
Leo

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-fix-v5.14

for you to fetch changes up to c1e64c0aec8cb0499e61af7ea086b59abba97945:

  soc: fsl: qe: fix static checker warning (2021-08-13 16:56:10 -0500)

----------------------------------------------------------------
NXP/FSL SoC driver fixes for v5.14

QE interrupt controller driver
- Convert it to platform_device driver to make it work with fw_devlink
- Fix static analysis issue

----------------------------------------------------------------
Maxim Kochetkov (2):
      soc: fsl: qe: convert QE interrupt controller to platform_device
      soc: fsl: qe: fix static checker warning

 drivers/soc/fsl/qe/qe_ic.c | 84 ++++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 36 deletions(-)
