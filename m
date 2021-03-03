Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF8532BCA0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383295AbhCCOUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842949AbhCCKWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B27C08ED36
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:15:32 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614766531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOZMuUgkwAWprihzNIesBPOQH08R4L3VRbLmef0+nuU=;
        b=cYBakqc9eMiv7gnWgoA2EqrUfnvTnDyRocqCJcRI/miV+38hT70ORCn+LqaXDt+ZhwhD9a
        TamQ8uIBhJ9qA1pgyPZb/+XknyjUgPgkK11N/i+vcwQ+He5fRacWHTqq5gtAJdiNkTYzP6
        2UXFO3AdBL1fMUSneqqJzkHngYBFD4oE6h0HSMfHDHFLZaaeZghEYElkV4Az3ZBfHVax3Y
        uaH2vBYLIxeXg6HTE1MTk4Fre9/+PpkZjnl++YbwyXb6JrQ2BrcHEPFIXW3OZnSYYjLskt
        yA+nx1lNsANFx6BJk9LVpEKIJH8lumzfoAHaR0gv7N06dtE8WgLIJ28ssH/8vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614766531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOZMuUgkwAWprihzNIesBPOQH08R4L3VRbLmef0+nuU=;
        b=I12GCqIeQp8PXwt/+bhwKkRpbz4Sv0VzZnmR59lakzsWEnP2iNwTutwWVcEcJEjM4NbmFV
        NZhGNYJrhWpBNUBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH next v4 04/15] printk: kmsg_dump: remove unused fields
Date:   Wed,  3 Mar 2021 11:15:17 +0100
Message-Id: <20210303101528.29901-5-john.ogness@linutronix.de>
In-Reply-To: <20210303101528.29901-1-john.ogness@linutronix.de>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct kmsg_dumper still contains some fields that were used to
iterate the old ringbuffer. They are no longer used. Remove them
and update the struct documentation.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/kmsg_dump.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index 3378bcbe585e..ae38035f1dca 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -36,6 +36,9 @@ enum kmsg_dump_reason {
  * 		through the record iterator
  * @max_reason:	filter for highest reason number that should be dumped
  * @registered:	Flag that specifies if this is already registered
+ * @active:	Flag that specifies if this is currently dumping
+ * @cur_seq:	Points to the oldest message to dump
+ * @next_seq:	Points after the newest message to dump
  */
 struct kmsg_dumper {
 	struct list_head list;
@@ -45,8 +48,6 @@ struct kmsg_dumper {
 	bool registered;
 
 	/* private state of the kmsg iterator */
-	u32 cur_idx;
-	u32 next_idx;
 	u64 cur_seq;
 	u64 next_seq;
 };
-- 
2.20.1

