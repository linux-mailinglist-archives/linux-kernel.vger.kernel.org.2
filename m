Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890A639F966
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhFHOoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:44:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:2354 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233420AbhFHOoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:44:11 -0400
IronPort-SDR: hc7Rl6dO/Yy7e18S/KD6pmCgqn5vA0YSLbyy/A6fiqCONDVDMxy1u8zIwyn4mDq5I7vhoathNr
 e8Bi+4dAt2LQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="201836383"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="201836383"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 07:42:18 -0700
IronPort-SDR: Hr7HJpGQqGj7EaXEcHfhWzCEI5kqrWykCGUd4+3eTA9C+w8vtHO54Gqbjq1Fd4b25X+U5ZHDtA
 1ruwJkXmXUOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="552299816"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jun 2021 07:42:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D028D147; Tue,  8 Jun 2021 17:42:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v1 1/3] serial: 8250_exar: Avoid NULL pointer dereference at ->exit()
Date:   Tue,  8 Jun 2021 17:42:37 +0300
Message-Id: <20210608144239.12697-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that during ->exit() the private_data is NULL,
for instance when there was no GPIO device instantiated.
Due to this we may not dereference it. Add a respective check.

Note, for now ->exit() only makes sense when GPIO device
was instantiated, that's why we may use the check for entire
function.

Fixes: 81171e7d31a6 ("serial: 8250_exar: Constify the software nodes")
Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 2f49c580139b..bd4e9f6ac29c 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -553,7 +553,11 @@ static void pci_xr17v35x_exit(struct pci_dev *pcidev)
 {
 	struct exar8250 *priv = pci_get_drvdata(pcidev);
 	struct uart_8250_port *port = serial8250_get_port(priv->line[0]);
-	struct platform_device *pdev = port->port.private_data;
+	struct platform_device *pdev;
+
+	pdev = port->port.private_data;
+	if (!pdev)
+		return;
 
 	device_remove_software_node(&pdev->dev);
 	platform_device_unregister(pdev);
-- 
2.30.2

