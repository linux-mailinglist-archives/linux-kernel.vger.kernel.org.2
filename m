Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE353A9960
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhFPLif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:38:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhFPLie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:38:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B175F6128C;
        Wed, 16 Jun 2021 11:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623843388;
        bh=5mpb027OseCJGiyudLKZTRazv+1roXKTYHTgruHF6xM=;
        h=From:To:Cc:Subject:Date:From;
        b=EY4Inpaay/TP1l83ym79Oa07lO1khYMI1EOVFF3gB7/RNk4x8EkPU1JXkC0e7E1MR
         90Q/V2wHVIaIxAyolz9435HtyyZIjyc7XL3gxmTB+f4X+vAiS+iW0BWeCNj66+tP+o
         AG2Z6w08MWLGYLTVYmfDuqsMnz5qgri4BCW1l6ACKo+PhqqsK/oU7uUUgL7r0mmjdh
         +nNp+f7ilNk8AwW/I6eawER00RFk5WvCCBFVTH5xHMytr32Nu1UPnbXyqWOjv/0esn
         oz9OEWcY40pa7SmBSDeImZxbkur8rnU944rkf3xvLCHAxk0YfsLQY9wfNUS6U74aVT
         ntkhq1PNgds7A==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 1/2] MAINTAINERS: fix my identity again
Date:   Wed, 16 Jun 2021 13:36:23 +0200
Message-Id: <20210616113624.19351-1-kabel@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix my name to use diacritics, since MAINTAINERS supports it.

Fix my e-mail address in MAINTAINERS' marvell10g PHY driver description,
I accidentaly put my other e-mail address here.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc0ceef87b73..bf98b44710ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1816,7 +1816,7 @@ F:	drivers/pinctrl/pinctrl-gemini.c
 F:	drivers/rtc/rtc-ftrtc010.c
 
 ARM/CZ.NIC TURRIS SUPPORT
-M:	Marek Behun <kabel@kernel.org>
+M:	Marek Behún <kabel@kernel.org>
 S:	Maintained
 W:	https://www.turris.cz/
 F:	Documentation/ABI/testing/debugfs-moxtet
@@ -10946,7 +10946,7 @@ F:	include/linux/mv643xx.h
 
 MARVELL MV88X3310 PHY DRIVER
 M:	Russell King <linux@armlinux.org.uk>
-M:	Marek Behun <marek.behun@nic.cz>
+M:	Marek Behún <kabel@kernel.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/phy/marvell10g.c
-- 
2.31.1

