Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E337D040
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 19:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348041AbhELRaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 13:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239336AbhELQHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:07:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB07F61D1D;
        Wed, 12 May 2021 15:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620833851;
        bh=SfNP/GQECSkZeIGOR0B7vM9t5zWSbsxJFDeCrUlQTwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZhXzSy0jFNFwO4Io06ggyCbFVvCM52UBpwgZEDgVvhImdVzZ0rxCfkpRBNdiJr6x
         RBuqpxg2Wle/P9T7ShFmcTeov/D2ECReHzkrlWSXGv2ruYJKldePkZzsNLpyls+k+/
         dONJ4g1VxgZLHDOf66k21LA1+rJkWYsU/+oPEVYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.11 313/601] printk: limit second loop of syslog_print_all
Date:   Wed, 12 May 2021 16:46:30 +0200
Message-Id: <20210512144838.126082326@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512144827.811958675@linuxfoundation.org>
References: <20210512144827.811958675@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Ogness <john.ogness@linutronix.de>

[ Upstream commit bb07b16c44b2c6ddbafa44bb06454719002e828e ]

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
Signed-off-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20210303101528.29901-4-john.ogness@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.30.2



