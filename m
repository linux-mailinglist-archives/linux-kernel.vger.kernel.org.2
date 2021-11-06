Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE115446C03
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 03:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhKFCLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 22:11:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35952 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhKFCLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 22:11:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8A8A7218F8;
        Sat,  6 Nov 2021 02:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636164545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gI3pVf2yiR5r/UEtG9xEBfrAQBOq8foMeThoRbLJKbY=;
        b=nPqUMv49auVsiO6ac9F9VZud6lAO8EnqnPYWyo/i1jKns3bUoKdJYLuITP/TiJwRrW8tVV
        GOVuFbkmAdN7X7M3AMMsX3s14ZVadLQcoemsITq9pNcQ28bhO83ylaRrmGqff28tFVvXCQ
        WNT2vIoVGOZRuZ0CKOHM7KmOq0VKJ9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636164545;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gI3pVf2yiR5r/UEtG9xEBfrAQBOq8foMeThoRbLJKbY=;
        b=dHX4a5zhXH9QJztD0665QVeRyJ0VbXgp55EiQgGLLfE5Uj7P+cq9o/E1gVv2GpLGz1dJ/3
        wKJ4fAYWPWbhuOAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1140413DA1;
        Sat,  6 Nov 2021 02:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r9kwMsDjhWH7FQAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Sat, 06 Nov 2021 02:09:04 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     Enzo Matsumiya <ematsumiya@suse.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] nvme: add NO APST quirk for Kioxia device
Date:   Fri,  5 Nov 2021 23:08:57 -0300
Message-Id: <20211106020858.18625-1-ematsumiya@suse.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This particular Kioxia device times out and aborts I/O during any load,
but it's more easily observable with discards (fstrim).

The device gets to a state that is also not possible to use "nvme set-feature"
to disable APST. Booting with nvme_core.default_ps_max_latency=0 solves the issue.

We had a dozen or so of these behaving this same way on customer
environment.

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 drivers/nvme/host/core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 838b5e2058be..a698c099164c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2469,7 +2469,19 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
 		.vid = 0x14a4,
 		.fr = "22301111",
 		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
-	}
+	},
+	{
+		/*
+		 * This Kioxia device times out and aborts I/O during any load,
+		 * but more easily reproducible with discards (fstrim).
+		 *
+		 * Device is left in a state that is also not possible to use "nvme set-feature"
+		 * to disable APST, but booting with nvme_core.default_ps_max_latency=0 works.
+		 */
+		.vid = 0x1e0f,
+		.mn = "KCD6XVUL6T40",
+		.quirks = NVME_QUIRK_NO_APST,
+ 	}
 };
 
 /* match is null-terminated but idstr is space-padded. */
-- 
2.33.0

