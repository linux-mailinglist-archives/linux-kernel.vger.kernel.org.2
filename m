Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432D9307D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhA1SFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhA1SDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:03:07 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285C8C061786
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:46 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id z6so6287294wrq.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cK/LGNOy9DsyBBjFZYPOvNZ8xWqyFdDwYmos4fe8lCA=;
        b=l6j6sHisEv3Syi3TRnQNqc6U3bhlxtCL6A+8C76hJHNJyVyr2m5puQfClCPg6ZQlYy
         qIKIMq29we6Ef0IFTdty05v59otQXhQpGmu00fGYgNcVq8S1dohwX+DfUYzv5f8rjxyc
         Op/DMGdmrp5jxBiUJqDn5BhvW+8aIV81BH/L1ULv14ruptw2hVA9jmGmdjd0Fl8q2L18
         Qkc+9TkH/UESqbJzNw7c9r4QbOiXRd3S6vNHnrjcg372P1gE103rhsJB73kSxPCbsZdd
         Jeq0lMdmK3c9QVQcgjKjcXUWIOH32xuIn5bbrE0PTyUQWjLMeQw0uTIZDvCyNBxOC1Y7
         9DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cK/LGNOy9DsyBBjFZYPOvNZ8xWqyFdDwYmos4fe8lCA=;
        b=huBzIXuX881RJjXz0Qf/CdC145qsdoFs9N/9ZgoGxLZ5YepfGjO7wweO2bsNba6H6c
         5dm23bw0K0r4IUfrsZL+RGbnewXeO3b+dDsymczEVnLTlT5QoEplyRDKB3zHQEIeB5pg
         Qbk+BKpgTkIATFqXwsdtVGCGGXGYRcknVulfmnjLU1NVdObmMx3pyO0rwskil1IUjmFy
         Y9PqlEra4BzUIkydWIaFG1s6B+cwEHc/DStYdvhGFTs1MQDZCy1XO6tEUXbDOWjEFHMD
         DXEORLuySV0rq1vn+FYDyp9JG9uTULI3373XNxyiEA90K79+MZtRvhfULN5aV7Ksf7at
         aIfQ==
X-Gm-Message-State: AOAM532lEB67+BsV6sYdqKFHdl7BxsebeRDEhhDVXG3lWBkRN1SEA3fV
        1TwsZ4+sw05SPJ3HXxS70VQ9Yw==
X-Google-Smtp-Source: ABdhPJzEkZVqERpDZYMPU4xNVbLl99aNDBErtpPPLk/+9aUXBl1cYJw/1Z0WP+KPvVGOpdjOKb/3hw==
X-Received: by 2002:adf:f512:: with SMTP id q18mr291783wro.55.1611856964946;
        Thu, 28 Jan 2021 10:02:44 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 02/20] ata: libata-transport: Fix some potential doc-rot issues
Date:   Thu, 28 Jan 2021 18:02:21 +0000
Message-Id: <20210128180239.548512-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
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

