Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E1D345503
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhCWBay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:30:54 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:50184 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhCWBaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:30:30 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id AF17E9800C8;
        Tue, 23 Mar 2021 09:30:27 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] soc: litex: Remove duplicate include of errno.h
Date:   Tue, 23 Mar 2021 09:30:15 +0800
Message-Id: <20210323013015.134366-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZS0JJGkNNHx9PThgdVkpNSk1PTUhLSUxCSEpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxg6Nww6OD8cEjpCASNKOS4t
        SUMKFEpVSlVKTUpNT01IS0lDQ09CVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKT05CNwY+
X-HM-Tid: 0a785cb45e7dd992kuwsaf17e9800c8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/errno.h has been included at line 11, so remove the 
duplicate include at line 16.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/soc/litex/litex_soc_ctrl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
index 6268bfa7f0d6..c3e379a990f2 100644
--- a/drivers/soc/litex/litex_soc_ctrl.c
+++ b/drivers/soc/litex/litex_soc_ctrl.c
@@ -13,7 +13,6 @@
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/module.h>
-#include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/reboot.h>
 
-- 
2.25.1

