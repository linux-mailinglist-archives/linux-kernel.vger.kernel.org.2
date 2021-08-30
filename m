Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8013FBA38
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbhH3Qfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhH3Qfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:35:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD50C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:35:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id e26so3798330wmk.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norberthealth-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=BlM1qgwK78ZJD3Qinqyqb58/9qg2GmD42jGtidijjH4=;
        b=WNB/soJYe7oDJbFB4ip+Nlqf6OKTHD/1+otQvv07EsMWwfz/Dqrf22Bkr9+6/OSjLK
         0EM7GB2czEF4Tb6tBLgP845xSw3qcUHnL5pilTYMU9xGcxv9PKSZlS2a+3OxR/TSsbb6
         wwhn8UZmPKmiV/edIrYzYTn149O/lBJHaRLsuNti7RbhjVtJeKM76jHFc03ZylTdaSDa
         fgpMH3A20a66uM0eM3uwnXdqmk8Rubj7rE84CDSeCfE3cIO4RvEvldj5m4lcdWzXVp8+
         DEbVkYGIb+nX/2BaLxETNZWMqH/R6Cu7pXIlU5p1+EE3zqPKCqRxe+nV2/ruBDl7pOBu
         NW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BlM1qgwK78ZJD3Qinqyqb58/9qg2GmD42jGtidijjH4=;
        b=k3wMsYZH/zxJnpyu/SqrJ8ClmEWLC7J/r2ygu2t29h/ENrO5gMNVVMrCtaPMMKTYhM
         FtK3QdTtwAXz+NMCfxnnudnUPU8V7/BW5WpfB05e7oAfRJQQp/Du48YuMkIcuqecwepA
         /nWkfGmQ4Qt3N1k0UR/jIULdVknDzYP3XUIctaoCfbZejj5WmwTDCKvhqron8+POb5uw
         icbNzjubiojHOnmig21+eRyXwvBQXTn77sFAPv2wFs7aDo08wqkuLCypfyyOXjy87hNi
         NSZg4H+laEBN8Az8VFErfuIV2UPNPn3p9ZHhNge5Zpi521IxIlTL4co4l5u1j9aHeFVQ
         y7Yw==
X-Gm-Message-State: AOAM533OR8A0epv1BbDNnHOk8G5gn33yCbpp4L0j52G36PI1hRmg6SKt
        BRpUvdUMY2zazUVNPaALabJFUw==
X-Google-Smtp-Source: ABdhPJy4I+aibeJuzvIOHpqt9YWkSYmFMHOTdoSoTTAiAsOBrSZJwAeJdb4M//1hkf/y3i1zQoaGbw==
X-Received: by 2002:a7b:c405:: with SMTP id k5mr22936394wmi.87.1630341299337;
        Mon, 30 Aug 2021 09:34:59 -0700 (PDT)
Received: from localhost.localdomain (81.227.26.93.rev.sfr.net. [93.26.227.81])
        by smtp.gmail.com with ESMTPSA id z5sm5225wmp.26.2021.08.30.09.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 09:34:58 -0700 (PDT)
From:   Roger Knecht <roger@norberthealth.com>
To:     Jiri Kosina <jkosina@suse.cz>
Cc:     Jiri Kosina <trivial@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roger Knecht <roger@norberthealth.com>
Subject: [PATCH RESEND v2] Trivial comment fix for the CRC ITU-T polynom
Date:   Mon, 30 Aug 2021 18:33:24 +0200
Message-Id: <20210830163324.12537-1-roger@norberthealth.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a small typo in the CRC ITU-T polynom documentation.

The code comment says that the polynom is x^16 + x^12 + x^15 + 1, but the
correct polynom is x^16 + x^12 + x^5 + 1.

Quote from page 2 in the ITU-T V.41 specification:
  "2 Encoding and checking process

  The service bits and information bits, taken in conjunction, correspond
  to the coefficients of a message polynomial having terms from x^(n-1) 
  (n = total number of bits in a block or sequence) down to x^16. This 
  polynomial is divided, modulo 2, by the generating polynomial 
  x^16 + x^12 + x^5 + 1. [...]"

Source: https://www.itu.int/rec/T-REC-V.41-198811-I/en)

The hex polynom 0x1021 and CRC code implementation are correct.

Changes for the resend:
  - Extended patch description
  - Added additional CCs

Thanks,
Roger

Signed-off-by: Roger Knecht <roger@norberthealth.com>
---
 include/linux/crc-itu-t.h | 2 +-
 lib/crc-itu-t.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/crc-itu-t.h b/include/linux/crc-itu-t.h
index a4367051e192..2f991a427ade 100644
--- a/include/linux/crc-itu-t.h
+++ b/include/linux/crc-itu-t.h
@@ -4,7 +4,7 @@
  *
  * Implements the standard CRC ITU-T V.41:
  *   Width 16
- *   Poly  0x1021 (x^16 + x^12 + x^15 + 1)
+ *   Poly  0x1021 (x^16 + x^12 + x^5 + 1)
  *   Init  0
  */
 
diff --git a/lib/crc-itu-t.c b/lib/crc-itu-t.c
index 1974b355c148..56e6e0d63d1e 100644
--- a/lib/crc-itu-t.c
+++ b/lib/crc-itu-t.c
@@ -7,7 +7,7 @@
 #include <linux/module.h>
 #include <linux/crc-itu-t.h>
 
-/** CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^15 + 1) */
+/** CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^5 + 1) */
 const u16 crc_itu_t_table[256] = {
 	0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7,
 	0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,
-- 
2.17.1

