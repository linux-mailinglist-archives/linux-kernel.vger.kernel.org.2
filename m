Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCED3F2E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbhHTOsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240894AbhHTOsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:48:06 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30D6B61101;
        Fri, 20 Aug 2021 14:47:28 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mH5nq-006D0z-1S; Fri, 20 Aug 2021 15:47:26 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     frowand.list@gmail.com, robh+dt@kernel.org, kernel-team@android.com
Subject: [PATCH] of: Don't allow __of_attached_node_sysfs() without CONFIG_SYSFS
Date:   Fri, 20 Aug 2021 15:47:22 +0100
Message-Id: <20210820144722.169226-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, frowand.list@gmail.com, robh+dt@kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to boot without SYSFS, but with OF_DYNAMIC quickly
results in a crash:

[    0.088460] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
[...]
[    0.103927] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc3 #4179
[    0.105810] Hardware name: linux,dummy-virt (DT)
[    0.107147] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
[    0.108876] pc : kernfs_find_and_get_ns+0x3c/0x7c
[    0.110244] lr : kernfs_find_and_get_ns+0x3c/0x7c
[...]
[    0.134087] Call trace:
[    0.134800]  kernfs_find_and_get_ns+0x3c/0x7c
[    0.136054]  safe_name+0x4c/0xd0
[    0.136994]  __of_attach_node_sysfs+0xf8/0x124
[    0.138287]  of_core_init+0x90/0xfc
[    0.139296]  driver_init+0x30/0x4c
[    0.140283]  kernel_init_freeable+0x160/0x1b8
[    0.141543]  kernel_init+0x30/0x140
[    0.142561]  ret_from_fork+0x10/0x18

While not having sysfs isn't a very common option these days,
it is still expected that such configuration would work.

Paper over it by bailing out from __of_attach_node_sysfs() if
CONFIG_SYSFS isn't enabled.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/of/kobj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
index a32e60b024b8..6675b5e56960 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -119,7 +119,7 @@ int __of_attach_node_sysfs(struct device_node *np)
 	struct property *pp;
 	int rc;
 
-	if (!of_kset)
+	if (!IS_ENABLED(CONFIG_SYSFS) || !of_kset)
 		return 0;
 
 	np->kobj.kset = of_kset;
-- 
2.30.2

