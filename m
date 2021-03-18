Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB45340159
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhCRIwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhCRIwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:52:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2F0C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:52:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so2818265wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8THP7/U46oj2AdA7yORlA1l0cGJIRsmbqUZT9U01N10=;
        b=owBn+xS4OiRerAuKPY02l2lKcDg4A7rfCxSZlOaV5n+p4Anewb0qiJgnRGois5rJ53
         otiPAUHyB1hiJmM966DeXNQGH3Y/Vl5TNAyPGd9mNWF7yhCRp3LL9z4zkgLNfj40onmH
         miY9VIe/aPvbVgMkUH65Qgxe8KEtSs9fkM3dMCrXUIpohGmfGfQvnKt/kVI0O8sZ2xDA
         zVbl/T/SpSUdCh8n5+yuA3OZQfxRIBucBvs9ZHClC/zyv05YgKQla+7hTZLfoegwNwbr
         8FDQsG7hBlEd6Fd42wAih5yRSgbFXMGjnHhTEbjb+RqqhmGBio7PbeRT1j4UlWgRWvQ0
         tnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8THP7/U46oj2AdA7yORlA1l0cGJIRsmbqUZT9U01N10=;
        b=Y4A+tCiarGMCNPc9JxfhEi3Fexl2t+/bocpKxeQoYpnDNAH59D0TwHZspSA8demE1Y
         5ni3+CppU3i6meX3XKlqFzjQhajICJbA1sjcbnYdRsFvv3+82oKjWkboakkg4ioMKliw
         flKwdfeXNS5dZseUHl16coMiBMXzP9cUcF5mM6BxcHnMJULZh7yesCIUus+y08l0i74R
         tKWTbxeR+D2JQho3kuhcOypbBz9xn8zTl1CPv3PJs4GcsigQmrco2euJbOY3rBP8SwoO
         Ik5fj05KaOLeV+yfIpcmB6Hj0ZVBiZ20bVW1l5QpOQ6oVCYc6y465eP5PssVUeF0Mutv
         32Yw==
X-Gm-Message-State: AOAM5335sb1ihOE08VETE281idv+KFJvuWe5FIs25acC1yqv1DIZ4QDw
        2aj3A6gy+CB0IA6VrUjptWPnPw==
X-Google-Smtp-Source: ABdhPJx9R9zd3as8Zx677i6YSfsUD2ksgApi6t1IlIfShE3hBRcdI0WVmZkNaqTIURd+qmu0fXnifg==
X-Received: by 2002:a05:600c:3541:: with SMTP id i1mr2521821wmq.97.1616057525014;
        Thu, 18 Mar 2021 01:52:05 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:52:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 14/15] ata: libata-acpi: Fix function name and provide description for 'prev_gtf'
Date:   Thu, 18 Mar 2021 08:51:49 +0000
Message-Id: <20210318085150.3131936-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/libata-acpi.c:493: warning: expecting prototype for ata_acpi_gtm_xfermode(). Prototype was for ata_acpi_gtm_xfermask() instead
 drivers/ata/libata-acpi.c:648: warning: Function parameter or member 'prev_gtf' not described in 'ata_acpi_run_tf'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/libata-acpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 224e3486e9a5d..7a7d6642edcc5 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -476,7 +476,7 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf)
 }
 
 /**
- * ata_acpi_gtm_xfermode - determine xfermode from GTM parameter
+ * ata_acpi_gtm_xfermask - determine xfermode from GTM parameter
  * @dev: target device
  * @gtm: GTM parameter to use
  *
@@ -624,6 +624,7 @@ static int ata_acpi_filter_tf(struct ata_device *dev,
  * ata_acpi_run_tf - send taskfile registers to host controller
  * @dev: target ATA device
  * @gtf: raw ATA taskfile register set (0x1f1 - 0x1f7)
+ * @prev_gtf: previous command
  *
  * Outputs ATA taskfile to standard ATA host controller.
  * Writes the control, feature, nsect, lbal, lbam, and lbah registers.
-- 
2.27.0

