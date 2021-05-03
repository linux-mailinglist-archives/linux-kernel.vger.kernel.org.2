Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2343714D6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhECMBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233771AbhECMA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:00:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E6496135C;
        Mon,  3 May 2021 12:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043205;
        bh=KdUHwxkIFiD0jf+mGXeEl/ZC/+KMZxkVoV0Jve9l4m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UmNk5DQkqftTavnZMnlb8K54sX4SfzUZLy3lEmYWfALsLoZxjBLzAGP3HEePMbs6I
         tLplutvFMu5R91tmq8IBm5qiLP4fZ0C7rbNWdRqfu0C2p0ebIG33skOXIBeDlDAzUj
         1ocOCOvBg5s/9ebLiFnkkNDdGOoibH6Kc3U4u8z4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 10/69] Revert "serial: max310x: pass return value of spi_register_driver"
Date:   Mon,  3 May 2021 13:56:37 +0200
Message-Id: <20210503115736.2104747-11-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 51f689cc11333944c7a457f25ec75fcb41e99410.

Because of recent interactions with developers from @umn.edu, all
commits from them have been recently re-reviewed to ensure if they were
correct or not.

Upon review, this commit was found to be incorrect for the reasons
below, so it must be reverted.  It will be fixed up "correctly" in a
later kernel change.

This change did not properly unwind from the error condition, so it was
not correct.

Cc: Kangjie Lu <kjlu@umn.edu>
Acked-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/max310x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 8534d6e45a1d..a3ba0e6520a1 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1518,10 +1518,10 @@ static int __init max310x_uart_init(void)
 		return ret;
 
 #ifdef CONFIG_SPI_MASTER
-	ret = spi_register_driver(&max310x_spi_driver);
+	spi_register_driver(&max310x_spi_driver);
 #endif
 
-	return ret;
+	return 0;
 }
 module_init(max310x_uart_init);
 
-- 
2.31.1

