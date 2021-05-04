Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13894373249
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 00:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhEDWYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 18:24:41 -0400
Received: from fgw21-7.mail.saunalahti.fi ([62.142.5.82]:48740 "EHLO
        fgw21-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232456AbhEDWYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 18:24:41 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 62d009b2-ad27-11eb-9eb8-005056bdd08f;
        Wed, 05 May 2021 01:23:44 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/1] usb: typec: ucsi: Put fwnode in any case during ->probe()
Date:   Wed,  5 May 2021 01:23:37 +0300
Message-Id: <20210504222337.3151726-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_for_each_child_node() bumps a reference counting of a returned variable.
We have to balance it whenever we return to the caller.

Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 282c3c825c13..0e1cec346e0f 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -999,6 +999,7 @@ static const struct typec_operations ucsi_ops = {
 	.pr_set = ucsi_pr_swap
 };
 
+/* Caller must call fwnode_handle_put() after use */
 static struct fwnode_handle *ucsi_find_fwnode(struct ucsi_connector *con)
 {
 	struct fwnode_handle *fwnode;
@@ -1033,7 +1034,7 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 	command |= UCSI_CONNECTOR_NUMBER(con->num);
 	ret = ucsi_send_command(ucsi, command, &con->cap, sizeof(con->cap));
 	if (ret < 0)
-		goto out;
+		goto out_unlock;
 
 	if (con->cap.op_mode & UCSI_CONCAP_OPMODE_DRP)
 		cap->data = TYPEC_PORT_DRD;
@@ -1151,6 +1152,8 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 	trace_ucsi_register_port(con->num, &con->status);
 
 out:
+	fwnode_handle_put(cap->fwnode);
+out_unlock:
 	mutex_unlock(&con->lock);
 	return ret;
 }
-- 
2.31.1

