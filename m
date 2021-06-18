Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B7D3AC3A2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhFRGU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:20:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59680 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhFRGRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4B99A21B56;
        Fri, 18 Jun 2021 06:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+qJzeN0GB4Du+0oC8C7gQGWeXvYtyew0tyei0BR1Ls=;
        b=JnSyqgqmcpRCObZRJCUwuTHSEotw+MQWu8z6YmJeOBUNP8eWAG7IhLvC5lRE0bianUZmkX
        0KBNALhpeEWnxnhmPbGK/n409SJn3doTqOfz/qCObiBugJwS3TmNKem5wD9CTmkyaHaAWl
        ChTyGj3eZe0AjjCRPAK71A8vCWXdgsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+qJzeN0GB4Du+0oC8C7gQGWeXvYtyew0tyei0BR1Ls=;
        b=1hKXhLumKuSZ2FYcHNTbq4H4526MU2O/p2Yu5JjEH1U/T3Qy/fTYXVuMVFVYWamBL7d1CW
        soetHcmfRybmtCBQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2555AA3BA2;
        Fri, 18 Jun 2021 06:15:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 57/70] mxser: don't start TX from tty_operations::put_char
Date:   Fri, 18 Jun 2021 08:15:03 +0200
Message-Id: <20210618061516.662-58-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TX is not supposed to be started from tty_operations::put_char. Line
disciplines ought to call tty_operations::put_char several times and
then do a single tty_operations::flush_chars to start TX.

Fix this in mxser by removing TX startup from mxser_put_char.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index daf820c086f4..52dbdd4282b2 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -998,17 +998,7 @@ static int mxser_put_char(struct tty_struct *tty, unsigned char ch)
 	info->xmit_head &= SERIAL_XMIT_SIZE - 1;
 	info->xmit_cnt++;
 	spin_unlock_irqrestore(&info->slock, flags);
-	if (!tty->flow.stopped) {
-		if (!tty->hw_stopped ||
-				(info->type == PORT_16550A) ||
-				info->board->must_hwid) {
-			spin_lock_irqsave(&info->slock, flags);
-			outb(info->IER & ~UART_IER_THRI, info->ioaddr + UART_IER);
-			info->IER |= UART_IER_THRI;
-			outb(info->IER, info->ioaddr + UART_IER);
-			spin_unlock_irqrestore(&info->slock, flags);
-		}
-	}
+
 	return 1;
 }
 
-- 
2.32.0

