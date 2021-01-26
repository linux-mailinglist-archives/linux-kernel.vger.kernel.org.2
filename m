Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA5C30500C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbhA0Dmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:42:53 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:36308 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbhAZWP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:15:28 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 4D8F1ADF39B; Tue, 26 Jan 2021 23:14:46 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: replace tricky statement by two simple ones
Date:   Tue, 26 Jan 2021 23:14:44 +0100
Message-Id: <20210126221444.713837-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct fw_driver::remove returns void, still the comma expression's value
is zero. This is harder to parse than necessary, so replace the single
expression by two easier ones.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/firewire/core-device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 80db43a22069..68216988391f 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -192,7 +192,9 @@ static int fw_unit_remove(struct device *dev)
 	struct fw_driver *driver =
 			container_of(dev->driver, struct fw_driver, driver);
 
-	return driver->remove(fw_unit(dev)), 0;
+	driver->remove(fw_unit(dev));
+
+	return 0;
 }
 
 static int get_modalias(struct fw_unit *unit, char *buffer, size_t buffer_size)
-- 
2.29.2

