Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F9C31E83C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhBRJdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:33:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50504 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhBRITU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:19:20 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613636298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P1qGalyRkusw+OWM5DdRUrXGxUPJbPrxcxo09FjgB9U=;
        b=tBdPKa1c4z4jc4cX77qQC30l2gEIW8W8MLJY/aE/qsPlKaADHAo1XA2lyhnWZLqILhnbyy
        rH7G/n/DSjWsK3T7oEN6vOb19iMCJC/uESYqULHV3ftlwPRJIGh2ZyjsGHSgwOmA5oUG2T
        2aaURnf6CPvLziHiqRsTDKPFFt2km2lmY31/Sjxp4DFDmkrBhumQDc75hf2NpckrsEY1gL
        epGdgyvYiPQpClJFUcoGqFrV33CPOykRMEzstdBkBXdAE3QJS7To2Y1Y3EN4FUMAr6yCFk
        sQAIPMmd3LwZWGypo+G2p3SzXrk1duKT10FuHHN9/oS+r92bARW2BfoPKhK/VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613636298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P1qGalyRkusw+OWM5DdRUrXGxUPJbPrxcxo09FjgB9U=;
        b=iVib0QQx3P31jFXfO2V5A0gDv6w69sMf9han8/5NQBCrURMxP8Lr2a4DIllEmwvXmRn/zN
        NEMkiqkVqVhsZVBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 01/14] printk: limit second loop of syslog_print_all
Date:   Thu, 18 Feb 2021 09:18:04 +0100
Message-Id: <20210218081817.28849-2-john.ogness@linutronix.de>
In-Reply-To: <20210218081817.28849-1-john.ogness@linutronix.de>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
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
---
 kernel/printk/printk.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c7239d169bbe..411787b900ac 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1495,6 +1495,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	struct printk_info info;
 	unsigned int line_count;
 	struct printk_record r;
+	u64 max_seq;
 	char *text;
 	int len = 0;
 	u64 seq;
@@ -1513,9 +1514,15 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
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

