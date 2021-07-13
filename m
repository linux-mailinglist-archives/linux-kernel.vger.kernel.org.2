Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EB93C6B59
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhGMHnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:43:17 -0400
Received: from comms.puri.sm ([159.203.221.185]:51572 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233762AbhGMHnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:43:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id E6D8AE0494;
        Tue, 13 Jul 2021 00:39:56 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7ofEuaigVpKE; Tue, 13 Jul 2021 00:39:56 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     grandmaster@al2klimov.de, kernel@puri.sm,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] usb: typec: tipd: Don't block probing of consumer of "connector" nodes
Date:   Tue, 13 Jul 2021 09:39:46 +0200
Message-Id: <20210713073946.102501-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar as with tcpm this patch lets fw_devlink know not to wait on the
fwnode to be populated as a struct device.

Without this patch, USB functionality can be broken on some previously
supported boards.

Fixes: 28ec344bb891 ("usb: typec: tcpm: Don't block probing of consumers of "connector" nodes")
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
hi,

at least the boards based on imx8mq-librem5.dtsi suffer from this, possibly
more.

thanks,
                           martin


 drivers/usb/typec/tipd/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 938219bc1b4b..b31aaf57eb3b 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -629,6 +629,8 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (!fwnode)
 		return -ENODEV;
 
+	fw_devlink_purge_absent_suppliers(fwnode);
+
 	tps->role_sw = fwnode_usb_role_switch_get(fwnode);
 	if (IS_ERR(tps->role_sw)) {
 		ret = PTR_ERR(tps->role_sw);
-- 
2.30.2

