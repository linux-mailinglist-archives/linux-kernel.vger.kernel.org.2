Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A4F307D72
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhA1SIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhA1SEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:04:36 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792B8C0612F2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:54 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s7so3347713wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MvoGC7duOzp4QbVV73i8hwf4OtQFHAIOE3fctv618Vg=;
        b=LCSL/fcwhlSrm7/lPGXpRlMQ0n2aJQsdeAOcuIr7kBIZyWGO4wpdPQ3TUqEgqrxZA0
         UMkH9ME6yeqoYFSIQnabalTsyaacEnMVFhkVr1ipyzQsoI+JO5RNSw3V93yhVo6vn33h
         G2OhqiZzDjzJVgIWhHhm0szCYXY4TBHp7P/G9LVdxZ/c0FZSEJjFEUyFSLNNtJiIEC6O
         5B7SIsdJhLuG8JwhcDL1QYWQgXLcN+GMDFNV1TKFXEmFd4E+UzHQdmWrzTXDBkgnYvDJ
         BZSKMH3/TfZg3sdClckaTszuFVK11UbU+Yber7oT1ea+wdx0+EcSrCutdlkh60sA2OWF
         bHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MvoGC7duOzp4QbVV73i8hwf4OtQFHAIOE3fctv618Vg=;
        b=s9V6lRhLibKdeakwCdYv500iW3IuHyVuW9m017wX+LnzL/ldjv/eLUy7qIwXX/A3Rg
         izRRdUa26vXShS+14YMydqA6eJZ8NBGCDWLfFDyHDHI+c+BU4rAe0t1jlnf1wXJp6TkS
         xb1DtiXD6t/T0uXJlJ4SE1garLPiQHv6WKAFg6aYdj9Zy5LBfbKLGJmHMZIqZA8VS2zG
         cPeNbL+Q1mjbCtnDkyjIuGQH0YTRK56vpzPElWXUQGQ+t6wLPsmCLxucpd6DEqNcTZF0
         PMix3lEFxvjCt/kjqRv5WXi1BAvF8oB0c9ag38rud+fTIJLqXa+j3QISF7rzgZgTILq3
         DkoA==
X-Gm-Message-State: AOAM533lCu88C5zSLkVO1cjT3/3KVtVArfIlQCIvb1fq7K9aigTs3SZ7
        3X19oBMYX1pZG3rwOf9hSR+9PQ==
X-Google-Smtp-Source: ABdhPJwlRmBQ0XlMBMJkoz0Jvfl43UE6ncweVPFdcFHqoMnwtYyXiwnmj5wsqPFr3KRph9ft58miLw==
X-Received: by 2002:a5d:6884:: with SMTP id h4mr359995wru.106.1611856973290;
        Thu, 28 Jan 2021 10:02:53 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Alessandro Zummo <alessandro.zummo@towertech.it>,
        linux-ide@vger.kernel.org
Subject: [PATCH 08/20] ata: pata_artop: Fix a function name and parameter description
Date:   Thu, 28 Jan 2021 18:02:27 +0000
Message-Id: <20210128180239.548512-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_artop.c:278: warning: expecting prototype for artop_6210_qc_defer(). Prototype was for artop6210_qc_defer() instead
 drivers/ata/pata_artop.c:359: warning: Function parameter or member 'id' not described in 'artop_init_one'
 drivers/ata/pata_artop.c:359: warning: Excess function parameter 'ent' description in 'artop_init_one'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Thibaut VARENE <varenet@parisc-linux.org>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_artop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 6bd2228bb6ffa..02e4fd5e3b934 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -344,7 +344,7 @@ static void atp8xx_fixup(struct pci_dev *pdev)
 /**
  *	artop_init_one - Register ARTOP ATA PCI device with kernel services
  *	@pdev: PCI device to register
- *	@ent: Entry in artop_pci_tbl matching with @pdev
+ *	@id: PCI device ID
  *
  *	Called from kernel PCI layer.
  *
-- 
2.25.1

