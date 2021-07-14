Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5C43C812D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbhGNJQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:16:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57938 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbhGNJQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:16:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AC24F205A1;
        Wed, 14 Jul 2021 09:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626253997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lAf4/ogYK8mPAuVj4Z35FdYEHZc00lKG2zOC5b1ViLU=;
        b=wmJyhZhvyf70NH025iZqb21mddQhnsaTOZFmpkT5Bjr9JARsPq0TEU69ESEHzrWGjNAxeo
        V9GlZQzpoCycRppUrZax6yOh2DEDgs41ZH0BZ+t/DTUQE/cEot6xRpIhu3S0kwacxsiMAM
        5Zm16mJH8QznQrnLr+04S+fg7bkPqtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626253997;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lAf4/ogYK8mPAuVj4Z35FdYEHZc00lKG2zOC5b1ViLU=;
        b=dXE2+o7byiCDu3veS13MulTITutnAXZdV07c96XSSnMmPjpp2MbIRtjyWy6RIydosrn+eJ
        5BW1u94tUGrSxbDg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 83F30A3B81;
        Wed, 14 Jul 2021 09:13:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 11/11] amiserial: remove unused state from shutdown
Date:   Wed, 14 Jul 2021 11:13:14 +0200
Message-Id: <20210714091314.8292-11-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714091314.8292-1-jslaby@suse.cz>
References: <20210714091314.8292-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'state' variable is only set but never read in amiserial's shutdown.
Drop it.

It was like this since the driver was added to the tree as far as I can
tell.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/amiserial.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index dffaff5a587a..7ad103e128ac 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -517,13 +517,10 @@ static int startup(struct tty_struct *tty, struct serial_state *info)
 static void shutdown(struct tty_struct *tty, struct serial_state *info)
 {
 	unsigned long	flags;
-	struct serial_state *state;
 
 	if (!tty_port_initialized(&info->tport))
 		return;
 
-	state = info;
-
 #ifdef SERIAL_DEBUG_OPEN
 	printk("Shutting down serial port %d ....\n", info->line);
 #endif
-- 
2.32.0

