Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5636935C2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243549AbhDLJvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239136AbhDLJjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:39:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39C1E6124A;
        Mon, 12 Apr 2021 09:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618220314;
        bh=QDJTgFMDEzH6DCtgRlJKFTIuSBVCHxr3ft9FZhxyCi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ksO6PHELWPjo9hpVVRkHo3k02/yR6PObodqvYUkJQGR6P8dsWfdBtPoLKSWCDgg9P
         aJ6nU2mTGG9YVniKrKUuqRvPQi/oaNeMeSBra+0e/+NTIBR3uSHsqBoWyy7SDjnkg4
         6pJDRVDZbofyghD+JgqMBJCNAfAdRSz9x2Om5Cj8b9OGE9upVgZcemyJSmsCwLzO6T
         JosMUEYPrY3saNTLRf5kSZb+mo2KC1cX7zjw8GKiERG43+LexJlu2bsSNZzM8yvIdz
         sQBxyEKhacMVtETbm9FXiMmLl5D4rSdPWg1zn/vBiBXSmI8m1zAiYeGWoUEFQJSa/5
         lzbU7L5nrC0aA==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lVt1Y-0000Ci-B9; Mon, 12 Apr 2021 11:38:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] USB: serial: f81232: drop time-based drain delay
Date:   Mon, 12 Apr 2021 11:38:12 +0200
Message-Id: <20210412093815.736-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210412093815.736-1-johan@kernel.org>
References: <20210412093815.736-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The f81232 driver now waits for the transmit FIFO to drain during close
so there is no need to keep the time-based drain delay, which would add
up to two seconds on every close for low line speeds.

Fixes: 98405f81036d ("USB: serial: f81232: add tx_empty function")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/f81232.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index b4b847dce4bc..a7a7af8d05bf 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -948,7 +948,6 @@ static int f81232_port_probe(struct usb_serial_port *port)
 
 	usb_set_serial_port_data(port, priv);
 
-	port->port.drain_delay = 256;
 	priv->port = port;
 
 	return 0;
-- 
2.26.3

