Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3D83567CE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350014AbhDGJQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:16:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16008 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbhDGJQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:16:40 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FFdx310tBzPnwC;
        Wed,  7 Apr 2021 17:13:43 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 17:16:18 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/1] usb: typec: tcpm: remove unused static variable 'tcpm_altmode_ops'
Date:   Wed, 7 Apr 2021 17:15:40 +0800
Message-ID: <20210407091540.2815-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning:

drivers/usb/typec/tcpm/tcpm.c:2107:39: warning: ‘tcpm_altmode_ops’ defined but not used [-Wunused-const-variable=]

The reference to the variable 'tcpm_altmode_ops' is deleted by the
commit a079973f462a ("usb: typec: tcpm: Remove tcpc_config configuration
mechanism").

By the way, the static functions referenced only by the variable
'tcpm_altmode_ops' are deleted accordingly.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 60 -------------------------------------------
 1 file changed, 60 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index ce7af398c7c1c1f..2f89bae29c0c297 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1365,14 +1365,6 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
 	mod_vdm_delayed_work(port, 0);
 }
 
-static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
-				    const u32 *data, int cnt)
-{
-	mutex_lock(&port->lock);
-	tcpm_queue_vdm(port, header, data, cnt);
-	mutex_unlock(&port->lock);
-}
-
 static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
 {
 	u32 vdo = p[VDO_INDEX_IDH];
@@ -1705,8 +1697,6 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 	 *
 	 * And we also have this ordering:
 	 * 1. alt-mode driver takes the alt-mode's lock
-	 * 2. alt-mode driver calls tcpm_altmode_enter which takes the
-	 *    tcpm port lock
 	 *
 	 * Dropping our lock here avoids this.
 	 */
@@ -2060,56 +2050,6 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
 	return 0;
 }
 
-static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
-{
-	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
-	int svdm_version;
-	u32 header;
-
-	svdm_version = typec_get_negotiated_svdm_version(port->typec_port);
-	if (svdm_version < 0)
-		return svdm_version;
-
-	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
-	header |= VDO_OPOS(altmode->mode);
-
-	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0);
-	return 0;
-}
-
-static int tcpm_altmode_exit(struct typec_altmode *altmode)
-{
-	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
-	int svdm_version;
-	u32 header;
-
-	svdm_version = typec_get_negotiated_svdm_version(port->typec_port);
-	if (svdm_version < 0)
-		return svdm_version;
-
-	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
-	header |= VDO_OPOS(altmode->mode);
-
-	tcpm_queue_vdm_unlocked(port, header, NULL, 0);
-	return 0;
-}
-
-static int tcpm_altmode_vdm(struct typec_altmode *altmode,
-			    u32 header, const u32 *data, int count)
-{
-	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
-
-	tcpm_queue_vdm_unlocked(port, header, data, count - 1);
-
-	return 0;
-}
-
-static const struct typec_altmode_ops tcpm_altmode_ops = {
-	.enter = tcpm_altmode_enter,
-	.exit = tcpm_altmode_exit,
-	.vdm = tcpm_altmode_vdm,
-};
-
 /*
  * PD (data, control) command handling functions
  */
-- 
1.8.3


