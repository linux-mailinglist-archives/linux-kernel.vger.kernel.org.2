Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D4E343E14
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCVKg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhCVKgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:36:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A354E6198F;
        Mon, 22 Mar 2021 10:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616409356;
        bh=jrHBX/HLRZtzoQhT2R3gMkK4qqxzt3mtlKLFiEw5HP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r1GcUI3CodBI120K8W9OfN3fxMdAxZbFiwZ0Av2N5stN3MchlfKWRyZFQE7etM/yC
         QmXPHRn9HuLn1oXh6WWd4qLqw3zWfVRoype0A+A50Tn9EMZDKnsWVELkKGSJdwUOmF
         fOsNJUlPNAxE/NYPd/VEFZXRoKDSDmN3cwVCC5mRV72c3J4xHjZ45En7JJ6DlGPiTl
         Lbu7hzIhthDafzE8qo5lenJFaao4/KK28cytGj8RbbiCc9/Cy1LUhAvTVpa1AQqGct
         MBHvbi+8h5Ehm95EaHIHIRxmVBBHevCxne/tJ14+9Vc+brJal5FzOPI+WH9nMZBPPN
         emByPzwLHMGmg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging/nvec:: avoid Wempty-body warning
Date:   Mon, 22 Mar 2021 11:35:40 +0100
Message-Id: <20210322103545.704121-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210322103545.704121-1-arnd@kernel.org>
References: <20210322103545.704121-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This driver has a few disabled diagnostics, which can probably
just get removed, or might still be helpful:

drivers/staging/nvec/nvec_ps2.c: In function 'nvec_ps2_notifier':
drivers/staging/nvec/nvec_ps2.c:94:77: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
   94 |                         NVEC_PHD("unhandled mouse event: ", msg, msg[1] + 2);

Changing the empty macro to the usual 'do {} while (0)' at least
shuts up the compiler warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/nvec/nvec_ps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/nvec/nvec_ps2.c b/drivers/staging/nvec/nvec_ps2.c
index 157009015c3b..06041c7f7d4f 100644
--- a/drivers/staging/nvec/nvec_ps2.c
+++ b/drivers/staging/nvec/nvec_ps2.c
@@ -28,7 +28,7 @@
 	print_hex_dump(KERN_DEBUG, str, DUMP_PREFIX_NONE, \
 			16, 1, buf, len, false)
 #else
-#define NVEC_PHD(str, buf, len)
+#define NVEC_PHD(str, buf, len) do { } while (0)
 #endif
 
 enum ps2_subcmds {
-- 
2.29.2

