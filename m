Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310EB33A28E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 05:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCNECm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 23:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbhCNEC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 23:02:26 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27713C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 20:02:26 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id 73so6937284qtg.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 20:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e8VikujQeByHVJXrpXJghO8MTbKzF0R8lztCzl3I2kY=;
        b=Ca6UrF0+bJ3scLBybza+wAMJaNVlZT/F2xXoTS6d0/ifuEgd/DYGyCLO1cGBa66q89
         wyCHPbia6UwcwCToZVc2wFmnYyNR96sUI325yPyVOP2buOyIsc0+bmizdFv2oj0A1ARN
         VkLKn8tRH1fxnTjdfWC4KyTTSSo51NMNAyr7i9vLX6/kymJf4pMteep1YqxO34md5ArV
         ML88WPJmA6OLQdfDw3dWr0m8lhd0tyM0M8Ve/Tt4EnLuYUub3Ze9mXrfS8hPL7WYs6Dr
         iYnyjvAPURN9ZgNNenYxg4TsFbaCGZFvYS4x+S08xHeQx6RtfblEeJ0496bH2JCUriiJ
         UNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e8VikujQeByHVJXrpXJghO8MTbKzF0R8lztCzl3I2kY=;
        b=gbXZyC1ifQVM1RWBL3seYoXL7iSfg/JJUY9WjET2v7tVw/pF6QHzJ9pLBXk0GXwsVV
         Ax7oTeJaOIv6kVLiYdguCdPEYfhxWIO5JY4JoUbbXwEx/Jum5k7tiER9ld09sb8nV/1A
         BgNF9U+C3BHdWxgHgK/ZuuGqLun51UafbsmBhEwmqtFJfTjtzaOXiPUbn9f9oeb3XZX+
         iq+eUCMorYqtT4lfJdTNkpVQJi9IXSVfpbqXkHbhIwQcSlVEQ1HG2qqQaVlnQQNCUpp3
         qa6vqvaOWqoaQUNu7sZ0wiVxGCSbJa1j3JDwyUz6ZVFXpwKM6HB6+w2GnEd3e238KwGN
         D5pQ==
X-Gm-Message-State: AOAM530EPg+z0/36ltr+VW+PsfSwHNB4kEWTqfubAOPTSxK9WQlTQQKm
        ZBkBinS7omDzCkVHiZ1cgmY=
X-Google-Smtp-Source: ABdhPJyntX2dFkGbHZvvrzewysT7A5TiEBLY0OLU9dmgtRuGbsW4PUNcU2u4gXjL/nwsgkiKJMfIMA==
X-Received: by 2002:ac8:dc2:: with SMTP id t2mr17850867qti.234.1615694545332;
        Sat, 13 Mar 2021 20:02:25 -0800 (PST)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:4c0:b220:fc67:f404])
        by smtp.googlemail.com with ESMTPSA id v4sm7310450qte.18.2021.03.13.20.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 20:02:24 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Tong Zhang <ztong0001@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: cb_pcidas: replace slash in name
Date:   Sat, 13 Mar 2021 23:02:20 -0500
Message-Id: <20210314040221.2740750-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() wont accept a name which contains slash so we need to
repalce it with something else -- otherwise it will trigger a warning
and the entry in /proc/irq/ will not be created

[    1.630764] name 'pci-das1602/16'
[    1.630950] WARNING: CPU: 0 PID: 181 at fs/proc/generic.c:180 __xlate_proc_name+0x93/0xb0
[    1.634009] RIP: 0010:__xlate_proc_name+0x93/0xb0
[    1.639441] Call Trace:
[    1.639976]  proc_mkdir+0x18/0x20
[    1.641946]  request_threaded_irq+0xfe/0x160
[    1.642186]  cb_pcidas_auto_attach+0xf4/0x610 [cb_pcidas]

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/staging/comedi/drivers/cb_pcidas.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/comedi/drivers/cb_pcidas.c b/drivers/staging/comedi/drivers/cb_pcidas.c
index d740c4782775..df0960d41cff 100644
--- a/drivers/staging/comedi/drivers/cb_pcidas.c
+++ b/drivers/staging/comedi/drivers/cb_pcidas.c
@@ -230,7 +230,7 @@ struct cb_pcidas_board {
 
 static const struct cb_pcidas_board cb_pcidas_boards[] = {
 	[BOARD_PCIDAS1602_16] = {
-		.name		= "pci-das1602/16",
+		.name		= "pci-das1602-16",
 		.ai_speed	= 5000,
 		.ao_scan_speed	= 10000,
 		.fifo_size	= 512,
@@ -248,7 +248,7 @@ static const struct cb_pcidas_board cb_pcidas_boards[] = {
 		.has_ao		= 1,
 	},
 	[BOARD_PCIDAS1602_12] = {
-		.name		= "pci-das1602/12",
+		.name		= "pci-das1602-12",
 		.ai_speed	= 3200,
 		.ao_scan_speed	= 4000,
 		.fifo_size	= 1024,
@@ -257,12 +257,12 @@ static const struct cb_pcidas_board cb_pcidas_boards[] = {
 		.is_1602	= 1,
 	},
 	[BOARD_PCIDAS1200_JR] = {
-		.name		= "pci-das1200/jr",
+		.name		= "pci-das1200-jr",
 		.ai_speed	= 3200,
 		.fifo_size	= 1024,
 	},
 	[BOARD_PCIDAS1602_16_JR] = {
-		.name		= "pci-das1602/16/jr",
+		.name		= "pci-das1602-16-jr",
 		.ai_speed	= 5000,
 		.fifo_size	= 512,
 		.is_16bit	= 1,
-- 
2.25.1

