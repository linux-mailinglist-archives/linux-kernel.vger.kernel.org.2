Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E127C30AA03
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhBAOlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhBAOk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:40:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592E3C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:39:46 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 7so16853786wrz.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cK/LGNOy9DsyBBjFZYPOvNZ8xWqyFdDwYmos4fe8lCA=;
        b=v7jsGj3c2vJL0l7/Fu2OSvsuxoyQFhNE4460l4Oc/ZpdEjZIPWubnmtOTaHB+ZH1nd
         JlKrNKlAnJe9xP4T+XhobMsQgAZ8+72DYoqRddOxCwUxVg6zn7ccvOaQE8+/QMeEf0e5
         dr10Uqyy5cYD60fNSDrzIPMSDQHw61wO40qV2bGU3EqEFm0o35VsWU1AwXK99FVUgAvL
         QFvdcFRggJKIyjxkECKikuYzJz2Tace8M66CJIhJNuMhet5GJicaNUklymubJuZ+rqA5
         XQY9eeTQecQ5Z7R3ThUe+OR7Tl5Zk7pEJ5rNm2SnE9AYxNXvAZiOLLFmIvlYxngGs3Wk
         jRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cK/LGNOy9DsyBBjFZYPOvNZ8xWqyFdDwYmos4fe8lCA=;
        b=jPlqj/r4YYWsReT4sbkSv691jumNTYSeUvft/lybNOczM+pXR8aBmUfhFk+Z3C/BDR
         ++jvgcvbKC2X5eCDeZQ7siiZDth7EFAQjYmJbztNgO304AsTMcrHjaivFwHtuCpXM/o5
         vRlIQ6FRuldVTwvUAcLw2RommS/kBG1LTOb9plv2NTO9uzol5ZWCRviiPr3/vSEMNt2s
         surXPUXQ5hxvwbZP9zMwK8hyq1DN9xUtmCSzplZKc2Mmt6sCTbFSgEM7WwqRmGhqJyYr
         27ju0dO75smHSjTPLRa6Jhb6xPI/uw24JXlT6+wVACl4E8shl3JCGDk9dyGaq7r+xDaE
         ZEBw==
X-Gm-Message-State: AOAM5319BRfI1G4EkKmMlKe4UX8BPepofSKu8D3+WWwCxcW4bryjNKgg
        XvuBLM5G05ChcpMCarD1G9PDnw==
X-Google-Smtp-Source: ABdhPJwuQyoZQsAT9aMUOrjHlteD3alQz281cVZJn0OBUEwFjaOkfuf4odwSaW6VYXE3F1Uii2uHRg==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr18521703wrm.207.1612190384969;
        Mon, 01 Feb 2021 06:39:44 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 01/20] ata: libata-transport: Fix some potential doc-rot issues
Date:   Mon,  1 Feb 2021 14:39:21 +0000
Message-Id: <20210201143940.2070919-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/libata-transport.c:258: warning: Function parameter or member 'ap' not described in 'ata_tport_delete'
 drivers/ata/libata-transport.c:258: warning: Excess function parameter 'port' description in 'ata_tport_delete'
 drivers/ata/libata-transport.c:384: warning: Function parameter or member 'link' not described in 'ata_tlink_delete'
 drivers/ata/libata-transport.c:384: warning: Excess function parameter 'port' description in 'ata_tlink_delete'
 drivers/ata/libata-transport.c:640: warning: Function parameter or member 'ata_dev' not described in 'ata_tdev_delete'
 drivers/ata/libata-transport.c:640: warning: Excess function parameter 'port' description in 'ata_tdev_delete'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/libata-transport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 6a40e3c6cf492..34bb4608bdc67 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -250,7 +250,7 @@ static int ata_tport_match(struct attribute_container *cont,
 
 /**
  * ata_tport_delete  --  remove ATA PORT
- * @port:	ATA PORT to remove
+ * @ap:	ATA PORT to remove
  *
  * Removes the specified ATA PORT.  Remove the associated link as well.
  */
@@ -376,7 +376,7 @@ static int ata_tlink_match(struct attribute_container *cont,
 
 /**
  * ata_tlink_delete  --  remove ATA LINK
- * @port:	ATA LINK to remove
+ * @link:	ATA LINK to remove
  *
  * Removes the specified ATA LINK.  remove associated ATA device(s) as well.
  */
@@ -632,7 +632,7 @@ static void ata_tdev_free(struct ata_device *dev)
 
 /**
  * ata_tdev_delete  --  remove ATA device
- * @port:	ATA PORT to remove
+ * @ata_dev:	ATA device to remove
  *
  * Removes the specified ATA device.
  */
-- 
2.25.1

