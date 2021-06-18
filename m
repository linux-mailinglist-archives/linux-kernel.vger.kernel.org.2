Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7128C3AC35F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhFRGS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:18:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46246 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbhFRGRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AFAED1FDF1;
        Fri, 18 Jun 2021 06:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eAxFk5BUNdVrHksKGizhyIj//K73Z70eGUSV+FbEDP0=;
        b=OK1uaBQx3iJxVZahHVvMvuQwDKGe/A2MshY3ZCj+kqUvLAdGTAXFoh2POX3/xTvPuEg1wt
        iu1tUIgf3qhVNTUUaMxS4vgbi8IdojmG+ZepIYlAJoZssawObLxXCOmwvndBxKr+4SPIya
        hIcWgraoazAbWu5fFOycmeUyGWJ8HCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996920;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eAxFk5BUNdVrHksKGizhyIj//K73Z70eGUSV+FbEDP0=;
        b=r7d7xOpUeTftkOUhFZ/WD3W+0JQTNriVilZcCR8aSCv8ORhGDKPBBpCJmv37MQxZSap5F9
        wWShaIo1yjrMiYAA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 88EB2A3BCB;
        Fri, 18 Jun 2021 06:15:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 17/70] mxser: remove else from LSR bits checks
Date:   Fri, 18 Jun 2021 08:14:23 +0200
Message-Id: <20210618061516.662-18-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART_LSR_SPECIAL is composed of UART_LSR_BI, UART_LSR_PE, UART_LSR_FE,
UART_LSR_OE. So status cannot be anything else. Remove the unused else
branch.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 6b8f2b0e0726..1b8032c9351e 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -2124,8 +2124,7 @@ static u8 mxser_receive_chars_old(struct tty_struct *tty,
 				} else if (status & UART_LSR_OE) {
 					flag = TTY_OVERRUN;
 					port->icount.overrun++;
-				} else
-					flag = TTY_BREAK;
+				}
 			}
 			tty_insert_flip_char(&port->port, ch, flag);
 			(*cnt)++;
-- 
2.32.0

