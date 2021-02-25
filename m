Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2670E32578E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhBYUZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhBYUZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:25:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DC2C061786
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:24:43 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614284681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TiujYZwqXTbI1RjkTHv+2Z/Pkwu+Ea0IXXEIKR3RaYE=;
        b=Lfs4TvUGYNgdqJ2OGGdBl91ZpATFsh6LhKHcEOKeuqSw2b6JhdkiqZoC0muo1bIFdA/VBf
        vFD9riXhKsaowIi4L3c9rl+nemLNA0t6V14b91xXKjoHpqKjyGGOlcus6e79BzQm3oE26u
        fLB2tvxnU6uSMU0rvaVHUB3cN8HUJwk8JGrXsLWe0PYW/aoS55ajISQMaTB/bklEBgTlpP
        Fc08PYUkajOdZbV76NHMpPi4+gqCjdMo2Dg2GPvH7lk350KzciS8Rrc3QBD3rHtLdxx3Vg
        2DGgaOWu2m9gq/0hlWqgvo1d5AWa536dWzkDV3d6eEsmSYw8nqA0am3nLiRB8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614284681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TiujYZwqXTbI1RjkTHv+2Z/Pkwu+Ea0IXXEIKR3RaYE=;
        b=UUstzkaT71FdlM4/8ElORQ9wsSPplG2w6jyBcqNUDsXjb9X2dPF+tOpFHDlaI2nQ0FEELA
        euU20heDbNFQsVDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v3 03/15] printk: limit second loop of syslog_print_all
Date:   Thu, 25 Feb 2021 21:24:26 +0100
Message-Id: <20210225202438.28985-4-john.ogness@linutronix.de>
In-Reply-To: <20210225202438.28985-1-john.ogness@linutronix.de>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second loop of syslog_print_all() subtracts lengths that were
added in the first loop. With commit b031a684bfd0 ("printk: remove
logbuf_lock writer-protection of ringbuffer") it is possible that
records are (over)written during syslog_print_all(). This allows the
possibility of the second loop subtracting lengths that were never
added in the first loop.

This situation can result in syslog_print_all() filling the buffer
starting from a later record, even though there may have been room
to fit the earlier record(s) as well.

Fixes: b031a684bfd0 ("printk: remove logbuf_lock writer-protection of ringbuffer")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 575a34b88936..77ae2704e979 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1494,6 +1494,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	struct printk_info info;
 	unsigned int line_count;
 	struct printk_record r;
+	u64 max_seq;
 	char *text;
 	int len = 0;
 	u64 seq;
@@ -1512,9 +1513,15 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	prb_for_each_info(clear_seq, prb, seq, &info, &line_count)
 		len += get_record_print_text_size(&info, line_count, true, time);
 
+	/*
+	 * Set an upper bound for the next loop to avoid subtracting lengths
+	 * that were never added.
+	 */
+	max_seq = seq;
+
 	/* move first record forward until length fits into the buffer */
 	prb_for_each_info(clear_seq, prb, seq, &info, &line_count) {
-		if (len <= size)
+		if (len <= size || info.seq >= max_seq)
 			break;
 		len -= get_record_print_text_size(&info, line_count, true, time);
 	}
-- 
2.20.1

