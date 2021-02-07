Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAFC312152
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 05:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhBGEdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 23:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhBGEdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 23:33:03 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7156C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 20:32:23 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id c132so8097876pga.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 20:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AbJ0OtQGNNaJXewTdNwqZi/vo3HypKPqhLztrUsNzxI=;
        b=JhACa+SgI4tkMog+osvmFQK3s9LK48rdgw4c44Z/87ERD1z1cLgzU62m1NOpBomKlZ
         7YMQrT8R5pom/dFLOrKskSVc2cFv7HcdmVtNKu/OjUOiPLvgb6TSPPBljgpsj75ykrHI
         PogKBVKKzTqphFJg47iIEaaov+RxNPtfZ1KoN1QOu4EKui9arhpmGsKJvd8WFt3Lii5p
         Gd7tOpHEqnbryZ3gs9rvPsnx9p3RVxgB4BfkJ0Fzhq3BTUD7FWwfPCmiaAJEk+GsuTX0
         7xSXMwyxCA/qX52xCjfZPPnHC2bf7/YNnfcCyGsRNCLsahHbBWLEsH1vCCo8XoZaTOhl
         4U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AbJ0OtQGNNaJXewTdNwqZi/vo3HypKPqhLztrUsNzxI=;
        b=jQrSvAoFVCutkO5K86YcTcYQ1e1q1p0t+rHtQykRGzw6ht/J45X3xnJwPTRC0YcKex
         QFIQQnXNv26JRCdm0rxYzoAl6bJ/Aun/DjkpRXgbcQZ0pQK5gcxlsYc80VnYpm3/pphv
         8o4/Pi9nIPoslucR0EYxeN6rqAvCW/xH768kZu8/wA2xIW25WpfCUKxGogpXZMRbilcV
         TH3TjyD7GLEe7yOsYk2j7i+Vitr/JkQ39t/oERN1PsYggZn/LWgh80f8+wgVXPNPsYPs
         3XC1L3igW22WGrpLPzOTvMpcSGoOr5r4s6fJRfs5JDCBQvczjE/aliLtxFfMufjqCCi2
         zmZw==
X-Gm-Message-State: AOAM530HJ0NZ7RUbEt1lNqWo3sFL3C9v5QDv7WcGdYa9hR22mM5YOWSX
        8bRKeC+91fiQo5wyMSbxhsQ+pLmTQTpyzw==
X-Google-Smtp-Source: ABdhPJxWt8DEgqgDy3aBcL3ZCHQfclIcfbrbiuGHS+eiAY/Hg1KyYesWP2AVYN4lPYWeHhhNmRWYZg==
X-Received: by 2002:a62:2785:0:b029:1d2:7de2:c56f with SMTP id n127-20020a6227850000b02901d27de2c56fmr12319438pfn.59.1612672343059;
        Sat, 06 Feb 2021 20:32:23 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id 12sm11907351pjm.28.2021.02.06.20.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 20:32:22 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     axboe@kernel.dk, andy.shevchenko@gmail.com
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        dong.menglong@zte.com.cn, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next] net: socket: use BIT() for MSG_*
Date:   Sat,  6 Feb 2021 20:32:00 -0800
Message-Id: <20210207043200.2386-1-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

The bit mask for MSG_* seems a little confused here. Replace it
with BIT() to make it clear to understand.

Changes since v1:
- use BIT() instead of BIT_MASK()

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 include/linux/socket.h | 71 ++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 385894b4a8bb..e88859f38cd0 100644
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
+#define MSG_OOB		BIT(0)
+#define MSG_PEEK	BIT(1)
+#define MSG_DONTROUTE	BIT(2)
+#define MSG_TRYHARD	BIT(2)	/* Synonym for MSG_DONTROUTE for DECnet		*/
+#define MSG_CTRUNC	BIT(3)
+#define MSG_PROBE	BIT(4)	/* Do not send. Only probe path f.e. for MTU	*/
+#define MSG_TRUNC	BIT(5)
+#define MSG_DONTWAIT	BIT(6)	/* Nonblocking io		*/
+#define MSG_EOR		BIT(7)	/* End of record		*/
+#define MSG_WAITALL	BIT(8)	/* Wait for a full request	*/
+#define MSG_FIN		BIT(9)
+#define MSG_SYN		BIT(10)
+#define MSG_CONFIRM	BIT(11)	/* Confirm path validity	*/
+#define MSG_RST		BIT(12)
+#define MSG_ERRQUEUE	BIT(13)	/* Fetch message from error queue */
+#define MSG_NOSIGNAL	BIT(14)	/* Do not generate SIGPIPE	*/
+#define MSG_MORE	BIT(15)	/* Sender will send more	*/
+#define MSG_WAITFORONE	BIT(16)	/* recvmmsg(): block until 1+ packets avail */
+#define MSG_SENDPAGE_NOPOLICY	BIT(16)	/* sendpage() internal : do no apply policy */
+#define MSG_SENDPAGE_NOTLAST	BIT(17)	/* sendpage() internal : not the last page  */
+#define MSG_BATCH	BIT(18)		/* sendmmsg(): more messages coming */
+#define MSG_EOF		MSG_FIN
+#define MSG_NO_SHARED_FRAGS	BIT(19)	/* sendpage() internal : page frags
+					 * are not shared
+					 */
+#define MSG_SENDPAGE_DECRYPTED	BIT(20)	/* sendpage() internal : page may carry
+					 * plain text and require encryption
+					 */
+
+#define MSG_ZEROCOPY	BIT(26)		/* Use user data in kernel path */
+#define MSG_FASTOPEN	BIT(29)		/* Send data in TCP SYN */
+#define MSG_CMSG_CLOEXEC	BIT(30)	/* Set close_on_exec for file
+					 * descriptor received through
+					 * SCM_RIGHTS
+					 */
 #if defined(CONFIG_COMPAT)
-#define MSG_CMSG_COMPAT	0x80000000	/* This message needs 32 bit fixups */
+#define MSG_CMSG_COMPAT	BIT(31)	/* This message needs 32 bit fixups */
 #else
-#define MSG_CMSG_COMPAT	0		/* We never have 32 bit fixups */
+#define MSG_CMSG_COMPAT	0	/* We never have 32 bit fixups */
 #endif
 
 
-- 
2.25.1

