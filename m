Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D899A31208F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 01:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhBGAB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 19:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhBGABw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 19:01:52 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D27AC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 16:01:12 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id fa16so5443869pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 16:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=49j9bFVs9sCOGw2ixwC0MgfE+ogeiIPqYGQMyoD5/0A=;
        b=BwemQyQiVMP+bEiS91OOT+Mp90CR9Fz7Akqf+uA511dHPx/cSJPcqxTYSJrgipbQuK
         pwseCfDeK4djao7YPa8HBKE6u4PIT3b50PumWrf3uCr5qRwJvi5QkcefjCNDUuMhXU6C
         RUxvUpUYqktCMtsEMHyZBJ9XNzzBdP9KkPopO0dSSGZHWvT9xFcQaBWtLZvhXhK4hN4K
         kvlLJTiMBKydR4oROV/cA4Afu1lvVR8VpZP2u1NBN0xKD31ANpHQlcBKYoxfPCmxx1K/
         vT1ILhpo9iYsFtzwNbJ63JjQ+LqR7P+CjSDmDs3cVSV1PjsaU3spjTn3b0XlVws0PFzO
         cQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=49j9bFVs9sCOGw2ixwC0MgfE+ogeiIPqYGQMyoD5/0A=;
        b=szRcUW9RlGzdLg6irQDMhhK65OvZnpoVOkFpmiRmnr3F3Ai1Wty0V9x5V1SkF1kZDZ
         +YHg6zuaHT8/AqT83uu3xQSFMYyKowTEs4ZURAj6p43QdZDjLLinfnqr+cj7vIzqRCCe
         witGnAL2FqxJuDehT6Z5gwsNvOFlEnEZ2ouZ8IxcbnXzlKkX6UQhmua+Py28sAcJhNaY
         tmieZ/zaFfY9JQ4Tw2N1JX18BDWSnxYNMhOPVTuvESLipX0HEYMyCrGZGzUZUBrZwoDU
         X2R03ZYsPYwFMgP8uzIli/f04lITave2WXky7o5gHbBcS9wy32LLGTEqOvsyFex4UVAm
         DpWA==
X-Gm-Message-State: AOAM533GjlANHrBee3O5Q31vqrmgt6hgdPIx3YoCwJ+QGjXy2ieqeNfC
        EKixn4sJ+CsltYquqUeAAspce3Y+RgM=
X-Google-Smtp-Source: ABdhPJyWuVqKhirhqLn1YjW9Lq1WhJkofF7i+q80zAYd3zV5UcHeuVtn93ajTvQI3BGHtNa//0sKDA==
X-Received: by 2002:a17:90b:1c0d:: with SMTP id oc13mr10337933pjb.156.1612656071855;
        Sat, 06 Feb 2021 16:01:11 -0800 (PST)
Received: from localhost ([2402:3a80:11d3:34df:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id r30sm14081138pfq.12.2021.02.06.16.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 16:01:11 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] staging: emxx_udc: Fix incorrectly defined global
Date:   Sun,  7 Feb 2021 05:30:31 +0530
Message-Id: <20210207000030.256592-1-memxor@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global gpio_desc pointer and int were defined in the header,
instead put the definitions in the translation unit and add an extern
declaration for consumers of the header (currently only one, which is
perhaps why the linker didn't complain about symbol collisions).

This fixes sparse related warnings for this driver:
drivers/staging/emxx_udc/emxx_udc.c: note: in included file:
drivers/staging/emxx_udc/emxx_udc.h:23:18: warning: symbol 'vbus_gpio' was not declared. Should it be static?
drivers/staging/emxx_udc/emxx_udc.h:24:5: warning: symbol 'vbus_irq' was not declared. Should it be static?

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 3 +++
 drivers/staging/emxx_udc/emxx_udc.h | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index a30b4f5b1..6983c3e31 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -34,6 +34,9 @@
 #define	DRIVER_DESC	"EMXX UDC driver"
 #define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
 
+struct gpio_desc *vbus_gpio;
+int vbus_irq;
+
 static const char	driver_name[] = "emxx_udc";
 static const char	driver_desc[] = DRIVER_DESC;
 
diff --git a/drivers/staging/emxx_udc/emxx_udc.h b/drivers/staging/emxx_udc/emxx_udc.h
index bca614d69..b3c4ccbe5 100644
--- a/drivers/staging/emxx_udc/emxx_udc.h
+++ b/drivers/staging/emxx_udc/emxx_udc.h
@@ -20,8 +20,8 @@
 /* below hacked up for staging integration */
 #define GPIO_VBUS 0 /* GPIO_P153 on KZM9D */
 #define INT_VBUS 0 /* IRQ for GPIO_P153 */
-struct gpio_desc *vbus_gpio;
-int vbus_irq;
+extern struct gpio_desc *vbus_gpio;
+extern int vbus_irq;
 
 /*------------ Board dependence(Wait) */
 
-- 
2.29.2

