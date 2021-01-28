Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C583078C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhA1Ozs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:55:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:47862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231204AbhA1Ova (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:51:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D15FACBA;
        Thu, 28 Jan 2021 14:50:49 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/1] bcm2835-dt-next-2021-01-28
Date:   Thu, 28 Jan 2021 15:50:36 +0100
Message-Id: <20210128145036.7144-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 5878b8087904a5827c3551698be83da1ccf84e11:

  ARM: dts: bcm2711: Add the BSC interrupt controller (2021-01-25 21:49:41 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2021-01-28

for you to fetch changes up to e2b539707aeaba45574bb6532d2d0c804a8bfeac:

  ARM: dts: bcm2711: Add the CEC interrupt controller (2021-01-28 15:47:13 +0100)

----------------------------------------------------------------
Maxime enables CEC support on both RPi4 HDMI ports

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: dts: bcm2711: Add the CEC interrupt controller

 arch/arm/boot/dts/bcm2711.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
