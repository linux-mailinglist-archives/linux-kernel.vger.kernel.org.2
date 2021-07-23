Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3153D38C0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 12:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhGWJvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:51:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:32876 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbhGWJvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:51:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E4D221FF88;
        Fri, 23 Jul 2021 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627036308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yf0djCljuJJguXHyKfihPisWwIah/VO7t2KXK3iROZw=;
        b=3So/AB2Um2kelehc0CvaAhFzr3+/jJJzEDAUZKTWgfP8uy5Yc/ZC5uTinL7uPo8BoDeW5t
        VQAkk5pZ9uTJmLGvrEDLw+z8Z3osxGfpawxKzL6e77yEbDztfLoxo+k3MTAtS65+e06BvM
        pVDFey9cqO7dMFYEEPFs86mxzPFFOr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627036308;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yf0djCljuJJguXHyKfihPisWwIah/VO7t2KXK3iROZw=;
        b=v7rmyi6+p2Ns9GKO7XX8IemPvnC/frZ6qa88SE1ch2FfE9DuiUkbQ2KfFczspWGQ5hEThw
        91klnFr7UoDQTaBw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C94BFA3B9E;
        Fri, 23 Jul 2021 10:31:48 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 8/8] tty: tty_flip.h needs only tty_buffer and tty_port
Date:   Fri, 23 Jul 2021 12:31:47 +0200
Message-Id: <20210723103147.18250-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723103147.18250-1-jslaby@suse.cz>
References: <20210723103147.18250-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tty_flip.h currently includes whole tty.h. In fact, it needs only
tty_buffer and tty_port definitions. Provided, we separated tty_buffer
and tty_port into separate headers in the previous patch, we can make
tty_flip.h to include only much lighter tty_buffer.h and tty_port.h.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tty_flip.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index 615a2a87b2a7..32284992b31a 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -2,7 +2,8 @@
 #ifndef _LINUX_TTY_FLIP_H
 #define _LINUX_TTY_FLIP_H
 
-#include <linux/tty.h>
+#include <linux/tty_buffer.h>
+#include <linux/tty_port.h>
 
 struct tty_ldisc;
 
-- 
2.32.0

