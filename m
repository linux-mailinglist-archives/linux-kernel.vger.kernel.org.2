Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030FD3281E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbhCAPKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbhCAPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:08:46 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EFDC061797
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 07:07:25 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lGk8k-00AJOK-TL; Mon, 01 Mar 2021 16:07:18 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-um@lists.infradead.org
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 6/8] um: irqs: allow invoking time-travel handler multiple times
Date:   Mon,  1 Mar 2021 16:07:06 +0100
Message-Id: <20210301160501.55ca8a7f5c73.I0344b4c8a7e79d8ac1645acad97371f202837777@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210301150708.244970-1-johannes@sipsolutions.net>
References: <20210301150708.244970-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we happen to get multiple messages while IRQS are already
suspended, we still need to handle them, since otherwise the
simulation blocks.

Remove the "prevent nesting" part, time_travel_add_irq_event()
will deal with being called multiple times just fine.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/irq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index ccf5e4d27202..2ee0a368aa59 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -101,10 +101,12 @@ static bool irq_do_timetravel_handler(struct irq_entry *entry,
 	if (!reg->timetravel_handler)
 		return false;
 
-	/* prevent nesting - we'll get it again later when we SIGIO ourselves */
-	if (reg->pending_on_resume)
-		return true;
-
+	/*
+	 * Handle all messages - we might get multiple even while
+	 * interrupts are already suspended, due to suspend order
+	 * etc. Note that time_travel_add_irq_event() will not add
+	 * an event twice, if it's pending already "first wins".
+	 */
 	reg->timetravel_handler(reg->irq, entry->fd, reg->id, &reg->event);
 
 	if (!reg->event.pending)
-- 
2.26.2

