Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E27356A09
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351351AbhDGKlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:41:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351173AbhDGKkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:40:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F44461359;
        Wed,  7 Apr 2021 10:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791992;
        bh=LI3EAIik89YYWfrjfBlEy8Rou74U6p2uSQKDwYIr75A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cx/yiBlKc6DgKFv66iHzwMJzlblD6+OdfoT3qCbxzSFvIwQ/23P+pm6gEsQLViU5l
         3gPmpMHEYcKNQxFuVyphdR9d0MgLB9bxc76xhV5JMye5ivGet9a8s80Sc5mwOL26hH
         KntF4OF6jHmbv+u5QNo3ZBMtY9wTq/ZVl26Yc3nC3CMtkX9p6O4t3wgJdfJvU+0UaF
         fK1bp5xAFrJw39QsnuEHofLg0PfSRvOIhgRIfNEdbAwXayBzhdrHNpQni9hgZit04E
         hohiMSgRuoJqMtfComTLQMQS8ebOv63SmJgrCSoEHGUdJgCzYU40D8XQHvwJaYeqDA
         aB5hueNjHAxTw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b6-0000Fa-7f; Wed, 07 Apr 2021 12:39:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/24] USB: serial: ftdi_sio: ignore baud_base changes
Date:   Wed,  7 Apr 2021 12:39:23 +0200
Message-Id: <20210407103925.829-23-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407103925.829-1-johan@kernel.org>
References: <20210407103925.829-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TIOCSSERIAL error handling is inconsistent at best, but drivers tend
to ignore requests to change parameters which cannot be changed rather
than return an error.

The FTDI driver ignores change requests for all immutable parameters but
baud_base so return success also in this case for consistency.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 16d3e50487e6..3fd7875200b9 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1509,10 +1509,6 @@ static int set_serial_info(struct tty_struct *tty,
 		goto check_and_exit;
 	}
 
-	if (ss->baud_base != priv->baud_base) {
-		mutex_unlock(&priv->cfg_lock);
-		return -EINVAL;
-	}
 
 	/* Make the changes - these are privileged changes! */
 
-- 
2.26.3

