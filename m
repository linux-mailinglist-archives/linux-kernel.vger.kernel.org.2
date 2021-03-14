Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEEB33A28A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 04:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhCND6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 22:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCND6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 22:58:04 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D111C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 19:58:04 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id a9so28538720qkn.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 19:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QIX/OYXluftRX3F6f7sy8Odgf2fjZdfFe5EJGVyxxE8=;
        b=hrPTPH1HCBe+8Poeb47+CXeL3A6a4JQMOoNbTFUfx6igFNSCIuaBGt6RBRVM6joqrE
         3a32xBGumxM7E4BolvSEOSWjh9+pOlocsAsvJ54rP8470bmrl/vMyB5q4x76ARmNdoEw
         /8DTuV6kGWJ/exGitwmcxC6Kl4IoGELOmXneSwSb7sE4q8SVP+b85jVuVgpUhjxvcckq
         Q6yrBg+M/JrwoBhzAisvT/e3k3Jih9oW48JyL3PxSdhZaMP/9I88nujz1tMbEALcW9ip
         Npbv/1bihoa+cSlfNX78BbNh78xgkH1WhmAYR2EA3dS/21DBSlTw6vQY1iEkRNJjVppb
         8IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QIX/OYXluftRX3F6f7sy8Odgf2fjZdfFe5EJGVyxxE8=;
        b=MW3jdxBdXPyOJKlO+jlDEVOX9gpklm3mRnffel5Hf1Lt6U9RdLeaQ8iDSzvm+drd8B
         XBLbI0PUNlJ2wZOvPklaFcugnlaZjkfSAW2zg8LzBva95tzuntPg4Y2bec/h1zKtXq5m
         OPEGI7jlhXRcu2sVdl/T5gvkW8mc2+gWe67hwuZKjGUDKeHm2+VanJwPA03a/CJIJY3A
         8zbU7R2nLsmOGl9sSyKO3RqavSfkFc0+RWVACf34PRH0L4oY4Hu3HKx62nPnKUD3nrfn
         gKkfk6jlm2uAzzm5TiozTntc8oasonCvJkJ0Qegr+PpyWmE0jk0XPWQy5YNikWRzkSEj
         F4Mg==
X-Gm-Message-State: AOAM533mr0LNMdDm7FVd356R7eMwIhNSANfjF/GHt4UR/2srv4jHukex
        ETRDwzBCQKOJMO6cL9h7OHo=
X-Google-Smtp-Source: ABdhPJzOFvVUnt+zW/OOQs2RwoiFQ9MmAem/e+KaMyPvPpSf1f1WrvISkYPpYZylpUTcXUZmYy1azA==
X-Received: by 2002:a37:9d84:: with SMTP id g126mr19779855qke.183.1615694283179;
        Sat, 13 Mar 2021 19:58:03 -0800 (PST)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:4c0:b220:fc67:f404])
        by smtp.googlemail.com with ESMTPSA id j15sm7311399qtr.34.2021.03.13.19.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 19:58:02 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Tong Zhang <ztong0001@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: replace slash in name
Date:   Sat, 13 Mar 2021 22:57:57 -0500
Message-Id: <20210314035757.2740146-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() wont accept a name which contains slash so we need to
repalce it with something else -- otherwise it will trigger a warning
and the entry in /proc/irq/ will not be created

[    1.565966] name 'pci-das6402/16'
[    1.566149] WARNING: CPU: 0 PID: 184 at fs/proc/generic.c:180 __xlate_proc_name+0x93/0xb0
[    1.568923] RIP: 0010:__xlate_proc_name+0x93/0xb0
[    1.574200] Call Trace:
[    1.574722]  proc_mkdir+0x18/0x20
[    1.576629]  request_threaded_irq+0xfe/0x160
[    1.576859]  auto_attach+0x60a/0xc40 [cb_pcidas64]

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/staging/comedi/drivers/cb_pcidas64.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/comedi/drivers/cb_pcidas64.c b/drivers/staging/comedi/drivers/cb_pcidas64.c
index fa987bb0e7cd..662d6ffb8f60 100644
--- a/drivers/staging/comedi/drivers/cb_pcidas64.c
+++ b/drivers/staging/comedi/drivers/cb_pcidas64.c
@@ -677,7 +677,7 @@ static const int bytes_in_sample = 2;
 
 static const struct pcidas64_board pcidas64_boards[] = {
 	[BOARD_PCIDAS6402_16] = {
-		.name		= "pci-das6402/16",
+		.name		= "pci-das6402-16",
 		.ai_se_chans	= 64,
 		.ai_bits	= 16,
 		.ai_speed	= 5000,
@@ -693,7 +693,7 @@ static const struct pcidas64_board pcidas64_boards[] = {
 		.has_8255	= 1,
 	},
 	[BOARD_PCIDAS6402_12] = {
-		.name		= "pci-das6402/12",	/* XXX check */
+		.name		= "pci-das6402-12",	/* XXX check */
 		.ai_se_chans	= 64,
 		.ai_bits	= 12,
 		.ai_speed	= 5000,
@@ -709,7 +709,7 @@ static const struct pcidas64_board pcidas64_boards[] = {
 		.has_8255	= 1,
 	},
 	[BOARD_PCIDAS64_M1_16] = {
-		.name		= "pci-das64/m1/16",
+		.name		= "pci-das64-m1-16",
 		.ai_se_chans	= 64,
 		.ai_bits	= 16,
 		.ai_speed	= 1000,
@@ -725,7 +725,7 @@ static const struct pcidas64_board pcidas64_boards[] = {
 		.has_8255	= 1,
 	},
 	[BOARD_PCIDAS64_M2_16] = {
-		.name = "pci-das64/m2/16",
+		.name = "pci-das64-m2-16",
 		.ai_se_chans	= 64,
 		.ai_bits	= 16,
 		.ai_speed	= 500,
@@ -741,7 +741,7 @@ static const struct pcidas64_board pcidas64_boards[] = {
 		.has_8255	= 1,
 	},
 	[BOARD_PCIDAS64_M3_16] = {
-		.name		= "pci-das64/m3/16",
+		.name		= "pci-das64-m3-16",
 		.ai_se_chans	= 64,
 		.ai_bits	= 16,
 		.ai_speed	= 333,
@@ -984,7 +984,7 @@ static const struct pcidas64_board pcidas64_boards[] = {
 		.has_8255	= 0,
 	},
 	[BOARD_PCIDAS4020_12] = {
-		.name		= "pci-das4020/12",
+		.name		= "pci-das4020-12",
 		.ai_se_chans	= 4,
 		.ai_bits	= 12,
 		.ai_speed	= 50,
-- 
2.25.1

