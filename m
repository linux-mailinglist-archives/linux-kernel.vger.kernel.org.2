Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332F033EC42
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCQJLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCQJKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:10:53 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D295C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:10:42 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id u7so835719qtq.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DCO4SGpYTn48obrAClA1NxmQHtXTT1+p+wX7tLZUWso=;
        b=hheYuEzHbFUasFyKNJkgy946IunncImPTQG00VXga+Ouk8mNnufmqL5dk01c3VzmNo
         5wPhJ7Q/Q/jZtFzlpW9nvkGPXLf+obb0QCIKkDF+yBV05cT+cE14PnXI6VunS7WIZZ4X
         jKrCXgAFt0OUjy2GC18IDhSFanXuURGoIOPnpqUUWNcdwkQORuYoHGpTXkhRqrYb2TMn
         xgDoGyUIhF/AyrnNl98JlhhfzXZp+Rlc4DaXJL5tfAQqfEn2AhnrUlrZwUGxvon18mD4
         PknLy+AL2xvBCuezSIJQgdZLvKcvyNofTDs/IjsTY8ElyKaGtNXJ2uXNhnpok3bEQp1u
         K0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DCO4SGpYTn48obrAClA1NxmQHtXTT1+p+wX7tLZUWso=;
        b=kWCzqSkuO8BIXNhpvgo0UzyfCcDRq3YbAGRT2oGQVNWlfScMTEjXkd/AU7DLxXmINn
         5UvoYaSzhK9+9H/pPCE/xWXuJx1T3z8+lD6LFXAgEGDTTtB4WrvQqVMdr68V13AUL4si
         SE4Oddvp7tNsa6PHrgrNPyjxaSCjccitpe80/hBVAD7L4CUb6ekTXTWK9L4kx5CTWWSf
         oDjnVD9PjIvUZgdHZloXFfc3ojImSXDBx/CElBmzQrOVXtfnQ8SvLHmTlzvZuh8M0CGr
         2HSIdIM9XUZqpPPT7czW8JgsYmxT+lNMjwkJNr4PlRqGy+59gQE0aavCIWM6UKuVl8RW
         lg7A==
X-Gm-Message-State: AOAM532BFZSI5t/aJi+dmPXJgPY78y4hvOgd2VNQU4ucIr52pFepQBcU
        MPlnBHRsAhY6IzXGHAS4fNo=
X-Google-Smtp-Source: ABdhPJyoORE5Q/k6SAwAzPgVJG6xpYOSlFLnqKSoDOiX1WlidPqqx1CTOLAXNGqvJOkUEIjpV2xhMg==
X-Received: by 2002:ac8:5047:: with SMTP id h7mr3107983qtm.22.1615972241644;
        Wed, 17 Mar 2021 02:10:41 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id v137sm5092004qkb.109.2021.03.17.02.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:10:41 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] kernel: debug: Ordinary typo fixes in the file gdbstub.c
Date:   Wed, 17 Mar 2021 14:40:22 +0530
Message-Id: <20210317091022.347258-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/'O'utput/'Output/
s/overwitten/overwritten/
s/procesing/processing/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 kernel/debug/gdbstub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index e149a0ac9e9e..5c96590725f1 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -204,7 +204,7 @@ void gdbstub_msg_write(const char *s, int len)
 	if (len == 0)
 		len = strlen(s);

-	/* 'O'utput */
+	/* 'Output */
 	gdbmsgbuf[0] = 'O';

 	/* Fill and send buffers... */
@@ -321,7 +321,7 @@ int kgdb_hex2long(char **ptr, unsigned long *long_val)
 /*
  * Copy the binary array pointed to by buf into mem.  Fix $, #, and
  * 0x7d escaped with 0x7d. Return -EFAULT on failure or 0 on success.
- * The input buf is overwitten with the result to write to mem.
+ * The input buf is overwritten with the result to write to mem.
  */
 static int kgdb_ebin2mem(char *buf, char *mem, int count)
 {
@@ -952,7 +952,7 @@ static int gdb_cmd_exception_pass(struct kgdb_state *ks)
 }

 /*
- * This function performs all gdbserial command procesing
+ * This function performs all gdbserial command processing
  */
 int gdb_serial_stub(struct kgdb_state *ks)
 {
--
2.30.2

