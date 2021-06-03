Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5830939A445
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhFCPSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:18:17 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:59086 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232136AbhFCPSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:18:15 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d75 with ME
        id CfFu2500H0zjR6y03fGTTY; Thu, 03 Jun 2021 17:16:29 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 03 Jun 2021 17:16:29 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 1/2] can: netlink: remove redundant check in can_validate()
Date:   Fri,  4 Jun 2021 00:15:49 +0900
Message-Id: <20210603151550.140727-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603151550.140727-1-mailhol.vincent@wanadoo.fr>
References: <20210603151550.140727-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

can_validate() does a first check:
|	if (is_can_fd) {
|		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING])
|			return -EOPNOTSUPP;
|	}

If that first if succeeds, we know that if is_can_fd is true then
data[IFLA_CAN_BITTIMING is set.

However, the next if switch does not leverage on above knowledge and
redoes the check:
| 	if (data[IFLA_CAN_DATA_BITTIMING]) {
|		if (!is_can_fd || !data[IFLA_CAN_BITTIMING])
|		                   ^~~~~~~~~~~~~~~~~~~~~~~~
| 			return -EOPNOTSUPP;
| 	}

This patch removes that redundant check.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index e38c2566aff4..32c603a09809 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -47,7 +47,7 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	}
 
 	if (data[IFLA_CAN_DATA_BITTIMING]) {
-		if (!is_can_fd || !data[IFLA_CAN_BITTIMING])
+		if (!is_can_fd)
 			return -EOPNOTSUPP;
 	}
 
-- 
2.31.1

