Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E974E3C67F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 03:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhGMBSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 21:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbhGMBSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 21:18:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A01C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 18:15:16 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso1201686wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 18:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rcTIYdyi6H2cwO1YwuS6Iulo37UiyPKtTS3fTlhkkXk=;
        b=NyJZBnxhm3xXZ1rNHqZCytD5uaRm6p6/8CtiM2ppiH3ycV3pFpJ4IQXmqsSSJ1AzAp
         KWsAq3QOd2qwQz3EOZlO9neK8NvISfEarpkRsQQiQ1xBzY40xR370H9rSTuZVVOXYSjX
         DO/h8qME2nqf9Jh3YBBn8cjMQPGoFVeWiAZPW8UIpPd2JsQmMwg5HwlmJsC6z/WD+9a0
         Kj/5kBH/fwYTGYpYh1geI9VO/AQV2TGFT6Y6ai1uw931aUn5fk3Y/7EaEH3PGR0MNLYs
         vpGJUQ0Y4AREUhywno6RMNwgCZjEp4n7uPl9EQu69Nr3l226zs+1ckyD6U4twxqFWOln
         5WsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rcTIYdyi6H2cwO1YwuS6Iulo37UiyPKtTS3fTlhkkXk=;
        b=NnkXtg8bpRgEFdL1eNHn2Ou5XPBGSnJXZvebJ1EtuNnFa3/TOutbkgPIhxjDCOlS65
         W/6LM5A3vLBo/W4Msn+S5ENd0ll8Ekr6KTwGwqO5zwE7aaam88sPu+kmeM8okB96LY6Y
         tmMxO90FkWF4fiPGVlaC4Z2QNrOGsykc7T5gXk1DKftErMrugC2BJF4n3qbiua7aPnPY
         pkoKPinz6bcJoLwpF7+6+sJIpNXIggy7HklM2RgUXMICwOZ6sgkmEI8D3VDnGFx7ghdn
         FqCNomuHb19hWGpfPNKtefJVq6BdlSJ89aEAo56Q61081wuR8nnR3KM7m2OspGxFdhZY
         ZQYQ==
X-Gm-Message-State: AOAM5300PGUW0x0dbSRW20+PW5fhtcI96BKM8ns/wTgVQPdT//NBol5s
        NJguruYdnaCLAov3EI0CGy4oEeB+/JYMCQ==
X-Google-Smtp-Source: ABdhPJweYpUc9bMjdQHkWBbpDQEEt2QtE6cOxHWvfOQEUmp4yFra9cU4keOSzTlinUf+avIubBAg8w==
X-Received: by 2002:a7b:ce82:: with SMTP id q2mr17054803wmj.60.1626138914493;
        Mon, 12 Jul 2021 18:15:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id x8sm8479566wrt.93.2021.07.12.18.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 18:15:14 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 1/2] printk: Remove console_silent()
Date:   Tue, 13 Jul 2021 02:15:10 +0100
Message-Id: <20210713011511.215808-2-dima@arista.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713011511.215808-1-dima@arista.com>
References: <20210713011511.215808-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It' unused since removal of mn10300:
commit 739d875dd698 ("mn10300: Remove the architecture")
x86 stopped using it in v2.6.12 (see history git):
commit 7574828b3dbb ("[PATCH] x86_64: add nmi button support")

Let's clean it up from the header.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/printk.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index e834d78f0478..a63f468a8239 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -70,11 +70,6 @@ extern int console_printk[];
 #define minimum_console_loglevel (console_printk[2])
 #define default_console_loglevel (console_printk[3])
 
-static inline void console_silent(void)
-{
-	console_loglevel = CONSOLE_LOGLEVEL_SILENT;
-}
-
 static inline void console_verbose(void)
 {
 	if (console_loglevel)
-- 
2.32.0

