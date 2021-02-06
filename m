Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7B4311B9F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 06:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhBFFc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 00:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhBFFcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 00:32:24 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726EFC06174A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 21:31:44 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q20so5732191pfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 21:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FKowa1RDI4gAn2i/8CsmokscP0DHk0rQuUmtfUOkf14=;
        b=QG1aw+8E+12v902XHpwzldqxb4A1Lj3qdFRH7WE6qJINMFYl3F0ngeaj+xgzyzdC7L
         RWJvyeBNpkbz7LGYJUO29iQCc/PIN9dh8djANSNc4nAwMcpKL8osSsxJzBtUkKvv1KSX
         rlBz5rM8K73S2j7khgYT76XLTq66M6L23rvRsOGpYT8RyX3fyTLMXYwVqg1XLIoRnU5h
         4+zrtTLTXXAEiPagj37w3im/D2+5Q/EInXnG9Lr3g1VZkFE4tYSUx+x+mlCLRAxHBhx0
         2zS11pc9uFPjinNL1MvZVCZcSraPtkG2ATlSEWV0LlWMhRc43QKd6M2k7PYrmJsifHsD
         sH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FKowa1RDI4gAn2i/8CsmokscP0DHk0rQuUmtfUOkf14=;
        b=NZM0PjrDgv906D7SJrvPdcOBS3lp3x4fjqe66zeHJT8VIxWlduFzSu/Csk8umU8Z5d
         cXyWFTaYn06qgBbgcZbirQ6S7JZcjcVfqR96iZz3eGZK+qG+36h+aI15Km5F60HbuphD
         /fZbIh3AdpCY7o8JM/TIvKtOLPr/l6yQWr3hY9uAG8oj5N1t+hTBNCSpIRBmQOtgx53p
         l61j0NsPab/ZDqJLTX6S+W37GGcgdP90B4HdsSlIeoiPRHJl72wQ0ZX11NJgU7jY2Gab
         jGUdsKzc5xAZL4PrHi+9k9/c1QI93IFRMP14dwQB1B53+mpEP+OtTySFLvoaQMaXXs4g
         rwTw==
X-Gm-Message-State: AOAM530mWis648wOltyyTaofzZyq294W49WqZJzipNdeGff13s3Mb42y
        /IOAUpxvwrsSk4Vdu0NeAro=
X-Google-Smtp-Source: ABdhPJyiQfrptj44lHTEls1Z9UOVQ8TI1XHyDIMBcWkjUEATqjNkafEd+Xrr4CQ5mlJx2MNUrxqoVg==
X-Received: by 2002:a65:50c3:: with SMTP id s3mr7547967pgp.269.1612589503269;
        Fri, 05 Feb 2021 21:31:43 -0800 (PST)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id g5sm11473590pfm.115.2021.02.05.21.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 21:31:42 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     axboe@kernel.dk
Cc:     davem@davemloft.net, viro@zeniv.linux.org.uk,
        herbert@gondor.apana.org.au, dong.menglong@zte.com.cn,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: socket: use BIT_MASK for MSG_*
Date:   Sat,  6 Feb 2021 13:31:09 +0800
Message-Id: <20210206053109.78205-1-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

The bit mask for MSG_* seems a little confused here. Replace it
with BIT_MASK to make it clear to understand.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 include/linux/socket.h | 71 ++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 385894b4a8bb..671d31c41582 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -283,42 +283,45 @@ struct ucred {
    Added those for 1003.1g not all are supported yet
  */
 
-#define MSG_OOB		1
-#define MSG_PEEK	2
-#define MSG_DONTROUTE	4
-#define MSG_TRYHARD     4       /* Synonym for MSG_DONTROUTE for DECnet */
-#define MSG_CTRUNC	8
-#define MSG_PROBE	0x10	/* Do not send. Only probe path f.e. for MTU */
-#define MSG_TRUNC	0x20
-#define MSG_DONTWAIT	0x40	/* Nonblocking io		 */
-#define MSG_EOR         0x80	/* End of record */
-#define MSG_WAITALL	0x100	/* Wait for a full request */
-#define MSG_FIN         0x200
-#define MSG_SYN		0x400
-#define MSG_CONFIRM	0x800	/* Confirm path validity */
-#define MSG_RST		0x1000
-#define MSG_ERRQUEUE	0x2000	/* Fetch message from error queue */
-#define MSG_NOSIGNAL	0x4000	/* Do not generate SIGPIPE */
-#define MSG_MORE	0x8000	/* Sender will send more */
-#define MSG_WAITFORONE	0x10000	/* recvmmsg(): block until 1+ packets avail */
-#define MSG_SENDPAGE_NOPOLICY 0x10000 /* sendpage() internal : do no apply policy */
-#define MSG_SENDPAGE_NOTLAST 0x20000 /* sendpage() internal : not the last page */
-#define MSG_BATCH	0x40000 /* sendmmsg(): more messages coming */
-#define MSG_EOF         MSG_FIN
-#define MSG_NO_SHARED_FRAGS 0x80000 /* sendpage() internal : page frags are not shared */
-#define MSG_SENDPAGE_DECRYPTED	0x100000 /* sendpage() internal : page may carry
-					  * plain text and require encryption
-					  */
-
-#define MSG_ZEROCOPY	0x4000000	/* Use user data in kernel path */
-#define MSG_FASTOPEN	0x20000000	/* Send data in TCP SYN */
-#define MSG_CMSG_CLOEXEC 0x40000000	/* Set close_on_exec for file
-					   descriptor received through
-					   SCM_RIGHTS */
+#define MSG_OOB		BIT_MASK(0)
+#define MSG_PEEK	BIT_MASK(1)
+#define MSG_DONTROUTE	BIT_MASK(2)
+#define MSG_TRYHARD	BIT_MASK(2)	/* Synonym for MSG_DONTROUTE for DECnet		*/
+#define MSG_CTRUNC	BIT_MASK(3)
+#define MSG_PROBE	BIT_MASK(4)	/* Do not send. Only probe path f.e. for MTU	*/
+#define MSG_TRUNC	BIT_MASK(5)
+#define MSG_DONTWAIT	BIT_MASK(6)	/* Nonblocking io		*/
+#define MSG_EOR		BIT_MASK(7)	/* End of record		*/
+#define MSG_WAITALL	BIT_MASK(8)	/* Wait for a full request	*/
+#define MSG_FIN		BIT_MASK(9)
+#define MSG_SYN		BIT_MASK(10)
+#define MSG_CONFIRM	BIT_MASK(11)	/* Confirm path validity	*/
+#define MSG_RST		BIT_MASK(12)
+#define MSG_ERRQUEUE	BIT_MASK(13)	/* Fetch message from error queue */
+#define MSG_NOSIGNAL	BIT_MASK(14)	/* Do not generate SIGPIPE	*/
+#define MSG_MORE	BIT_MASK(15)	/* Sender will send more	*/
+#define MSG_WAITFORONE	BIT_MASK(16)	/* recvmmsg(): block until 1+ packets avail */
+#define MSG_SENDPAGE_NOPOLICY	BIT_MASK(16)	/* sendpage() internal : do no apply policy */
+#define MSG_SENDPAGE_NOTLAST	BIT_MASK(17)	/* sendpage() internal : not the last page  */
+#define MSG_BATCH	BIT_MASK(18)		/* sendmmsg(): more messages coming */
+#define MSG_EOF		MSG_FIN
+#define MSG_NO_SHARED_FRAGS	BIT_MASK(19)	/* sendpage() internal : page frags
+						 * are not shared
+						 */
+#define MSG_SENDPAGE_DECRYPTED	BIT_MASK(20)	/* sendpage() internal : page may carry
+						 * plain text and require encryption
+						 */
+
+#define MSG_ZEROCOPY	BIT_MASK(26)	/* Use user data in kernel path */
+#define MSG_FASTOPEN	BIT_MASK(29)	/* Send data in TCP SYN */
+#define MSG_CMSG_CLOEXEC	BIT_MASK(30)	/* Set close_on_exec for file
+						 * descriptor received through
+						 * SCM_RIGHTS
+						 */
 #if defined(CONFIG_COMPAT)
-#define MSG_CMSG_COMPAT	0x80000000	/* This message needs 32 bit fixups */
+#define MSG_CMSG_COMPAT	BIT_MASK(31)	/* This message needs 32 bit fixups */
 #else
-#define MSG_CMSG_COMPAT	0		/* We never have 32 bit fixups */
+#define MSG_CMSG_COMPAT	0	/* We never have 32 bit fixups */
 #endif
 
 
-- 
2.30.0

