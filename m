Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6483124AC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhBGOZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhBGOZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:25:04 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73680C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:24:11 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id t2so2126055pjq.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IB0O63AOzgOLQF077zwXAfFu2gqJi21zlryIQXSvD7U=;
        b=dJEzL6DvkRQ2PPyaJlfuGglUW1RpxEbRkQ8RbcDc8PXqR+lTaGmWd5m+Wo28bSYLqt
         JlpFXqTeNyTcrT3R7N5G72ME5L56Trc5IY1fXyQxpbIqgfjn5XHgdV/Qxf3jn/Di5aOz
         GJf/1UTjFONL/bilsP7VThhcPwwAqtsjLmpInOkrvXidY7NUxY7dZUuGDd1QSYFO39MI
         HxKlGUvqFD1WBzwNlBfVYdYhsHbQWSp08GQNsa7p6T9LCVxlyOtmk5sbCulbAF2DFTOe
         DF3AeMlZQ06wHko6vRjktSgTSUcNWXERy7o3gUzsSimWfsSyEo6MFeOI/6GUATpEWZbM
         70/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IB0O63AOzgOLQF077zwXAfFu2gqJi21zlryIQXSvD7U=;
        b=QuzUtN0CKm0Iz0mYaZJdPKHnS36TyP6oFoKKoU1uRuaPdC83x1rv5Ydgg1qGZ6KDyS
         Y7986VE48JtJOIAnE8sdjKFqhzAvpK3RDlnRVdV0AC9Zyhq1TjGWhPRrI1QO5ow+OGHF
         0yim5rQRNxRqlZpz9NwKsEG4BBmwVmmOM6SS/EhQc213+TVLf221o6H2PACTeOBa2osQ
         c/Xoz4RNAOCWBkxKQJFTAK7EkPbV6U6Qylxsbh40oqYB/NDM84ItaYTpbIIy5O4ZLMbO
         fqwzs1LVtLE1Gvkar2KuUQV/Xo/4rRRLNc83A20xC6WOTmCv5AMlp38v+CEs/19kmKl+
         wHYw==
X-Gm-Message-State: AOAM532RSrWHt9TK2xpfo56MuDLPM0iNO+L8ZlGALGxjWLEWUuLxfutG
        YIIKbmPf8PIikul0LQdEGJI=
X-Google-Smtp-Source: ABdhPJy0d37yemtPPxvwEnY05X8LllYQSCUAZEYvsuhSKhMLogKzjPVTdxP+gkqBsMua+sVhove58g==
X-Received: by 2002:a17:90a:650b:: with SMTP id i11mr4409080pjj.204.1612707849607;
        Sun, 07 Feb 2021 06:24:09 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id a9sm9982902pfr.204.2021.02.07.06.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:24:08 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     axboe@kernel.dk, andy.shevchenko@gmail.com
Cc:     davem@davemloft.net, dong.menglong@zte.com.cn,
        viro@zeniv.linux.org.uk, kuba@kernel.org,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next] net: socket: use BIT() for MSG_*
Date:   Sun,  7 Feb 2021 06:23:49 -0800
Message-Id: <20210207142349.4539-1-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

The bit mask for MSG_* seems a little confused here. Replace it
with BIT() to make it clear to understand.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
v3:
- move changelog here
v2:
- use BIT() instead of BIT_MASK()
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

