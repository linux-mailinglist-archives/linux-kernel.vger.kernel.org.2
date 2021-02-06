Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA6F311CB9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 11:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhBFKuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 05:50:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:52492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhBFKul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 05:50:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612608587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VlVL2Y2ASTFVpwcU4SmdSz79vlZWGd1T5oGBYzvUtKQ=;
        b=CaAOHRpv7RYB3U4+TM6JjEfbGxTHtF6cA58Si23ab7AwqoG6YglxUsLmvFuf0c94PPFVIm
        SpAadYtJiVApk9QAnqoPFKPJPHt+6euf4qwQg6uIr8CsiyoWiW+qlFD/zWnyEkhfhkHS8b
        Gs1DtsywWPRDSXVKB3DIktuDeZYkblE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1DFC9AD78;
        Sat,  6 Feb 2021 10:49:47 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH 3/7] xen/events: fix lateeoi irq acknowledgment
Date:   Sat,  6 Feb 2021 11:49:28 +0100
Message-Id: <20210206104932.29064-4-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210206104932.29064-1-jgross@suse.com>
References: <20210206104932.29064-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When having accepted an irq as result from receiving an event the
related event should be cleared. The lateeoi model is missing that,
resulting in a continuous stream of events being signalled.

Fixes: 54c9de89895e0a ("xen/events: add a new late EOI evtchn framework")
Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/events/events_base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 6a836d131e73..7b26ef817f8b 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1826,6 +1826,7 @@ static void lateeoi_ack_dynirq(struct irq_data *data)
 	if (VALID_EVTCHN(evtchn)) {
 		info->eoi_pending = true;
 		mask_evtchn(evtchn);
+		clear_evtchn(evtchn);
 	}
 }
 
@@ -1838,6 +1839,7 @@ static void lateeoi_mask_ack_dynirq(struct irq_data *data)
 		info->masked = true;
 		info->eoi_pending = true;
 		mask_evtchn(evtchn);
+		clear_evtchn(evtchn);
 	}
 }
 
-- 
2.26.2

