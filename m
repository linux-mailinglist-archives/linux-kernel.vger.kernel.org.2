Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2147E4534A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbhKPOxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbhKPOwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:52:46 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B56C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 06:49:47 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w1so22922595edc.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 06:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B5pDTBy+I7lU7vLFbrJGqNNUjmcP1vrbHR8Bdse3Iv4=;
        b=OphKVacGpm785IfpXcR2LZD9IxBec/6niFy2eBX3iuVWtyv+HUHft55kbxhhQYKQ3h
         sMYWxxAE0lADiJU8YF6KHQvf0sG3ctDv7FzuIXEFbRJdExqTrjDDTxOr1vLcutZxsenr
         R9vcG+Josps2oNOfFC6TCmxTn3L2cmQhOsMKYqo9+LPPIHEPnIGt7urW4aQdtdl9Gxe5
         e1htssHbddIc9Z/e2xr06gXZjuH1jJ9fMUb2lz2Pa9XuGEvv4KvJBYz/dhTRBgYnuKoW
         oFQZEhQ8sR9hjnhBOogCqwMQ4JedpsmBJiWhxlb043O5sxnXejyhea6Vtgjnk+opJjpW
         V+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B5pDTBy+I7lU7vLFbrJGqNNUjmcP1vrbHR8Bdse3Iv4=;
        b=O1dfiCAz1qHzkoKIiX15qjeCbJvgshsWWBSiDOQw1CeIZX2cYad13E8IBZsgYDwgfb
         +KgCtMRABsaPeCVEPTIZ/ApCGPHOK57cIf1LRPq8DCHHlIQnKwuA59O6Nxg/dACwFU8R
         0I+YD1aN4IVFiL0tHFCdZjR7HjFUPmLyfBLhKDSWrr4TGMbLxDDzbTj5lS3Mc3S4VbDS
         nhK4nWgmX65bKryb/tA/lucjR3BMjwk4jbauLMF24Ed0qyd4GifseNmVJ6SY1xFd6NmX
         OWF4QcObOoyd7BXDlQmVsKTE54DihJ2xSI3RpiIlHMf8QGau2yFAh272tjLm3h8AMIEC
         Bf6w==
X-Gm-Message-State: AOAM531ynAR3DduO7g6153VaYhOBMXDV1yE7wEXh9fKXGq4OQeWPACrd
        z3WSgVpY6P6cdkrALbFGfO4=
X-Google-Smtp-Source: ABdhPJzQiVjY0DZaoUi2trNBeXjOQJzFsie+gi0YshrkuJyBSil3m13RQgcdjc1WPmcqdfjRgJuccA==
X-Received: by 2002:a05:6402:2744:: with SMTP id z4mr298379edd.310.1637074186374;
        Tue, 16 Nov 2021 06:49:46 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id nc30sm8893908ejc.35.2021.11.16.06.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 06:49:46 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        nick black <dankamongmen@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com,
        Marco Elver <elver@google.com>
Subject: [PATCH] vt: Fix sleeping functions called from atomic context
Date:   Tue, 16 Nov 2021 15:49:37 +0100
Message-Id: <20211116144937.19035-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two sleeping functions called from atomic context by doing immediate
return to the caller if !preemptible() evaluates 'true'. Remove two
in_interrupt() tests because they are not suited for being used here.

Since functions do_con_write() and con_flush_chars() might sleep in
console_lock(), it must be assured that they are never executed in
atomic contexts.

This issue is reported by Syzbot which notices that they are executed
while holding spinlocks and with interrupts disabled. Actually Syzbot
emits a first report and then, after fixing do_con_write(), a second
report for the same problem in con_flush_chars() because these functions
are called one after the other by con_write().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/tty/vt/vt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7359c3e80d63..508f8a56d361 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2902,7 +2902,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 	struct vt_notifier_param param;
 	bool rescan;
 
-	if (in_interrupt())
+	if (!preemptible())
 		return count;
 
 	console_lock();
@@ -3358,7 +3358,7 @@ static void con_flush_chars(struct tty_struct *tty)
 {
 	struct vc_data *vc;
 
-	if (in_interrupt())	/* from flush_to_ldisc */
+	if (!preemptible())	/* from flush_to_ldisc */
 		return;
 
 	/* if we race with con_close(), vt may be null */
-- 
2.33.1

