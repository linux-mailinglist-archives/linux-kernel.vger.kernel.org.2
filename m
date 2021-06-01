Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927EB397195
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhFAKiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:38:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40070 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAKit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:38:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lo1lj-0000wN-Lr; Tue, 01 Jun 2021 10:37:07 +0000
From:   Colin King <colin.king@canonical.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch: microblaze: Fix spelling mistake "vesion" -> "version"
Date:   Tue,  1 Jun 2021 11:37:07 +0100
Message-Id: <20210601103707.9701-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the comment. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/microblaze/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index b41f323e1fde..6d4af39e3890 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -3,7 +3,7 @@ KBUILD_DEFCONFIG := mmu_defconfig
 
 UTS_SYSNAME = -DUTS_SYSNAME=\"Linux\"
 
-# What CPU vesion are we building for, and crack it open
+# What CPU version are we building for, and crack it open
 # as major.minor.rev
 CPU_VER   := $(shell echo $(CONFIG_XILINX_MICROBLAZE0_HW_VER))
 CPU_MAJOR := $(shell echo $(CPU_VER) | cut -d '.' -f 1)
-- 
2.31.1

