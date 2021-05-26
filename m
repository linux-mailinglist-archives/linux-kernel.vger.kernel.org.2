Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF86391210
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhEZIMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbhEZIM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:12:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A26C06138C
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z17so78696wrq.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ErXHhW8xGHFawKpNhWm+WyBOe9UNeis6EV9FDiSv/0=;
        b=TpRDQnxBYFKaTHZuK850nLRMN6h/uxvH0Jc0dRoosj4UrswXmcdMGwgzWhk8TPy7Cq
         nqauEOEkzJfYx4D4cYnVVBhgbbPEaE3zIP2trpfoEL2lgtEiKoeLg9RuMxdk6H4k9NGF
         54lPMn2ReOcrcgcGLDvq1yYN7PlqBVdFDKlZBRdHAoHB1caF2hUHpWxWFtu2bIvdDQxn
         KO5j+oaezbP5dcodv9lxH9qib9f0MfGz/qx4M54cRaxyeqD1hpUUf9Q0lPFDKjbZEOiE
         ljoNfA+JldhQRCLSEjnNQvh9aKl6oyfB7jNERD21DftEZXr/O6gmQ0IbK1Ltqj0e31tH
         m9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ErXHhW8xGHFawKpNhWm+WyBOe9UNeis6EV9FDiSv/0=;
        b=Elk/v7JEsagJmUDOIYyR1ug+u/pvJJ2R43ZbkE//bJyyAZhO+RWZaNwe1nZ79VwpqS
         ZcDT1+dMiKgS/coggYilsiu3DwwDLr36XXFssNpeHqPn8KLRyiFeqIOWjs1Tgh4/isDJ
         u2dn0NcGzrFBqtC6MEWhASqOBDGzzKepQaTDle/K3YeeiTSKoeRbmkkj4LXhUawfxcB+
         g+/qJyIwKaGzZopWhYFMO7e6Dvt+Lcclecxl2ZXee7iUdBcfuJvL3a+ifqO2t8RIMY4D
         FiM+DjmaDoO2t4p0SJPYGIz7CJrJHdJJZfFqvdrhp1EQkg1C5XjaVWHXlrdWhY3BXnOQ
         XrTA==
X-Gm-Message-State: AOAM532tMCcgYVq6NGrpCsGGN3IB3U2vtjx1oQxK2ZA3Y8cXuk3GsCH7
        ksUFX0zkZuWZxACavLx16SweyA==
X-Google-Smtp-Source: ABdhPJyJEctOCXMGCr6neiGO+uEak1nyRRwrBbGKTsiGCJ02ldF3FE6GzH6eEVOey+mKVtHXvwAETw==
X-Received: by 2002:a05:6000:551:: with SMTP id b17mr30929720wrf.32.1622016653832;
        Wed, 26 May 2021 01:10:53 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id v11sm22628319wrs.9.2021.05.26.01.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:10:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        German Rivera <German.Rivera@freescale.com>
Subject: [PATCH 08/10] bus: fsl-mc-msi: Fix a little doc-rot pertaining to 'np' to 'fwnode' conversion
Date:   Wed, 26 May 2021 09:10:36 +0100
Message-Id: <20210526081038.544942-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526081038.544942-1-lee.jones@linaro.org>
References: <20210526081038.544942-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/bus/fsl-mc/fsl-mc-msi.c:164: warning: Function parameter or member 'fwnode' not described in 'fsl_mc_msi_create_irq_domain'
 drivers/bus/fsl-mc/fsl-mc-msi.c:164: warning: Excess function parameter 'np' description in 'fsl_mc_msi_create_irq_domain'

Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: German Rivera <German.Rivera@freescale.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/bus/fsl-mc/fsl-mc-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 8edadf05cbb76..cf974870ba55d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -148,7 +148,7 @@ static void fsl_mc_msi_update_chip_ops(struct msi_domain_info *info)
 
 /**
  * fsl_mc_msi_create_irq_domain - Create a fsl-mc MSI interrupt domain
- * @np:		Optional device-tree node of the interrupt controller
+ * @fwnode:	Optional firmware node of the interrupt controller
  * @info:	MSI domain info
  * @parent:	Parent irq domain
  *
-- 
2.31.1

