Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B953B1AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhFWNLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:11:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51428 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhFWNLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:11:40 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3764521962;
        Wed, 23 Jun 2021 13:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624453760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fvLe4EDcZBFIJFV4utDnoKGG4SlCKvEBy8vMSAJDpnk=;
        b=JvFAJrnRk4z9JofF9qR8IZLIrtA/HR4LsTpSYytHLGr/baiqJyKWcoa8i77iQYjkHGDtPG
        nYCqIBCJPS3jLWcXfr2juHvEIVvlZd0a1X2+W61iXuQ1PV0TMhkYUzTbGzHjeNOQrJm9Ix
        TgdnlutnZLfBh6DyZ7HJqAeYOQKMUPk=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id F245A11A97;
        Wed, 23 Jun 2021 13:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624453760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fvLe4EDcZBFIJFV4utDnoKGG4SlCKvEBy8vMSAJDpnk=;
        b=JvFAJrnRk4z9JofF9qR8IZLIrtA/HR4LsTpSYytHLGr/baiqJyKWcoa8i77iQYjkHGDtPG
        nYCqIBCJPS3jLWcXfr2juHvEIVvlZd0a1X2+W61iXuQ1PV0TMhkYUzTbGzHjeNOQrJm9Ix
        TgdnlutnZLfBh6DyZ7HJqAeYOQKMUPk=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id ol9pOX8y02DIMQAALh3uQQ
        (envelope-from <jgross@suse.com>); Wed, 23 Jun 2021 13:09:19 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
Subject: [PATCH] xen/events: reset active flag for lateeoi events later
Date:   Wed, 23 Jun 2021 15:09:13 +0200
Message-Id: <20210623130913.9405-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid a race condition for user events when changing
cpu affinity reset the active flag only when EOI-ing the event.

This is working fine as all user events are lateeoi events. Note that
lateeoi_ack_mask_dynirq() is not modified as there is no explicit call
to xen_irq_lateeoi() expected later.

Reported-by: Julien Grall <julien@xen.org>
Fixes: b6622798bc50b62 ("xen/events: avoid handling the same event on two cpus at the same time")
Tested-by: Julien Grall <julien@xen.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/events/events_base.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 7bbfd58958bc..d7e361fb0548 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -642,6 +642,9 @@ static void xen_irq_lateeoi_locked(struct irq_info *info, bool spurious)
 	}
 
 	info->eoi_time = 0;
+
+	/* is_active hasn't been reset yet, do it now. */
+	smp_store_release(&info->is_active, 0);
 	do_unmask(info, EVT_MASK_REASON_EOI_PENDING);
 }
 
@@ -811,6 +814,7 @@ static void xen_evtchn_close(evtchn_port_t port)
 		BUG();
 }
 
+/* Not called for lateeoi events. */
 static void event_handler_exit(struct irq_info *info)
 {
 	smp_store_release(&info->is_active, 0);
@@ -1883,7 +1887,12 @@ static void lateeoi_ack_dynirq(struct irq_data *data)
 
 	if (VALID_EVTCHN(evtchn)) {
 		do_mask(info, EVT_MASK_REASON_EOI_PENDING);
-		event_handler_exit(info);
+		/*
+		 * Don't call event_handler_exit().
+		 * Need to keep is_active non-zero in order to ignore re-raised
+		 * events after cpu affinity changes while a lateeoi is pending.
+		 */
+		clear_evtchn(evtchn);
 	}
 }
 
-- 
2.26.2

