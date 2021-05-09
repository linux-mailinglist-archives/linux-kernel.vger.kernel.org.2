Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED14C377942
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 01:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhEIXbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 19:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhEIXbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 19:31:00 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167C0C061573;
        Sun,  9 May 2021 16:29:55 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i9so14082925lfe.13;
        Sun, 09 May 2021 16:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yut1BlmA5AWyF7gd5kvyTypdD7uP31bWplbxWHFtFOg=;
        b=QouvQiEmk32pi6E8URL5n5tcOQ6ykDgoNI56h/pQUqdLhLZ0gprNG2WIvOtx2RsArQ
         mBCFYlBiPlSUv0EoAF19eQZmxahtdgB7MB/7VLGVUUpc8ehDiDjhfWEzHL6Enw5UgVOn
         eOf2HghUsIONqfJHNjGk414gUMhSDf+XBOF7tnZH2ITQCEfG66AcdHXGkS7nAXzdTyli
         uF/Dk2J98arLit6hGzGw8lZD9d0y3GHieTtsb5X89KBempXCIRjiRKhold69zYBZGoTB
         QWg6r0ihh8MGntEo2ocKUs8Tvg648/1tyrOiI/1DZK6v+qJa9jD8n/yzwb+MsnhQpCoN
         pRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yut1BlmA5AWyF7gd5kvyTypdD7uP31bWplbxWHFtFOg=;
        b=k+91hrVgXd9J24lVlTpG8YcrdWuQi8Qgpo/p/1OxLeM7w9xAjjVy9q74Yec5OAvl/r
         MjnAYsbBQrsgSMLrFTeqO70S3BUO3KU5+I8lTPwh/IKIJ9SAAoPD5bL3bqP6qTGjRHCK
         R6y3zPgkK+oQ+Lrqx4XWdj2H7JHvjTwRtJ+QrWJkR+9rcOF3C4Q5O9nDg3XNUtz3v/9E
         Rc5M83P+1sD93VNZ6vSXiPn8daWjQPYnJtWQpV3//ovKTh/Xdk0gS9PXmY/9XeQZsQ8X
         ccNRdY7qAeGr/quCCkdqXlHlRwFDYLM2SlEOZW6JKeUTVOGdSH4yJ92adyrK2xAXIgA1
         VxuQ==
X-Gm-Message-State: AOAM533bFKCqwCirGFnFY/A2swpVOcXPHyVDlvxNfNnF5WnAtHv0Hygg
        Ew+/ryF7D1Nv/KlpuCn0nCK64+A4wySt2g==
X-Google-Smtp-Source: ABdhPJw1gR1s5trHbe7Ub2nSS09v+Oe57pzsbKIrPdo+N8ewlFpohg0hPHSP1S9SnJAGOLSPZ02pKA==
X-Received: by 2002:a05:6512:3e16:: with SMTP id i22mr15489508lfv.250.1620602993651;
        Sun, 09 May 2021 16:29:53 -0700 (PDT)
Received: from localhost ([85.249.34.38])
        by smtp.gmail.com with ESMTPSA id h25sm1378330lfe.3.2021.05.09.16.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 16:29:53 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: Add entry for BCM43430B0 UART Bluetooth
Date:   Mon, 10 May 2021 02:28:37 +0300
Message-Id: <20210509232838.2477651-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device ID for the BCM43430B0 module, found e.g. in
certain revisions of AMPAK AP6212 chip. The required firmware file is
named 'BCM43430B0.hcd'.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/bluetooth/btbcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 1b9743b7f2ef..e5d706ed55ea 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -404,6 +404,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x4217, "BCM4329B1"   },	/* 002.002.023 */
 	{ 0x6106, "BCM4359C0"	},	/* 003.001.006 */
 	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
+	{ 0x410c, "BCM43430B0"	},	/* 002.001.012 */
 	{ }
 };
 
-- 
2.31.1

