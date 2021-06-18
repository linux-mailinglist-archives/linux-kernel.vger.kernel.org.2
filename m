Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D783AC375
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhFRGSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:18:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46728 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbhFRGRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 31D851FDFC;
        Fri, 18 Jun 2021 06:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F5/FmGrKE5ZFei42H0MztKDKgh/V6X8PtUx5LYCmr7s=;
        b=Vqm5iFk6Qq6iq3cIm1gz8jFI0zOB60Km+3XWaCkhZR5bWV3K9EW/NFmljf0E2LAW7SPEGg
        04h+sUL83p3f7lLimDjZYvZKSC0eaLnfPId1g22gF9BqnrPGWkFHpeAWGnLJTUbslj7Kz6
        nU3/3c/zundT6gLW6skDH6kINrBuxBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996921;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F5/FmGrKE5ZFei42H0MztKDKgh/V6X8PtUx5LYCmr7s=;
        b=3D6fjC/4WBynAMzenbdUjmnwqqe0tTvWbwEokIokb4y2kT9h/DU8NNpE6dH/0aI2gev59V
        1f9WJui9P/gP70DA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 062C7A3BBA;
        Fri, 18 Jun 2021 06:15:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 19/70] mxser: make xmit ring buffer variables unsigned
Date:   Fri, 18 Jun 2021 08:14:25 +0200
Message-Id: <20210618061516.662-20-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the xmit ring buffer pointers and counter (xmit_head, xmit_tail,
xmit_cnt) unsigned. Now, the assumptions for the compiler are clear --
they cannot be negative.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 45f36d92c5ea..53136a7d92b1 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -351,9 +351,9 @@ struct mxser_port {
 	u8 read_status_mask;
 	u8 ignore_status_mask;
 	u8 xmit_fifo_size;
-	int xmit_head;
-	int xmit_tail;
-	int xmit_cnt;
+	unsigned int xmit_head;
+	unsigned int xmit_tail;
+	unsigned int xmit_cnt;
 	int closing;
 
 	struct ktermios normal_termios;
-- 
2.32.0

