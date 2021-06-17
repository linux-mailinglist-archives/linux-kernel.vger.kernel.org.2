Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1176F3AB1E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhFQLIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbhFQLHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:07:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7F0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:05:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a11so6268933wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aSzExTVUsadO4V7ANNESO8z5qJFdtG4+Cn9kR8zvWdQ=;
        b=i0h25As3fHBOG4TFNG19N2W6zhyjKS9ghE2UfANmALFAWGvls6nt4SULj5WBD3YJFe
         ipAOGXufisXX7A/D8BlGAC8m5D8NeMkDGolFCQpWkNwO+WDhICLRZ8Tii2oNV1t7Br51
         Kn7fye5l0oQK3oZbhOXLcpudCA3LcacxaO5vmrT2xEpxSUawJIUoCNh10Mngs7eJVGum
         ojj+gTKYN9KfuJVVsiuwxYnzBpkdYGVAdyj5T3BeZ8WwocJ7+n7ypc/uXONU1uA97w/y
         ub5gYF3j9NE1ilbRuRacorivsmF5cChUHPaDJOt8Py+rWeAs2UMAB/UXHZBwbDd9mUVt
         g0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aSzExTVUsadO4V7ANNESO8z5qJFdtG4+Cn9kR8zvWdQ=;
        b=RSgbd9ejafmh2imCKrdg830d/kUnQ2uMq83AZVuyUs0B8iksAqQM+1Wbhm7sHRbl/7
         43lGnzZs15e6vBHapGg3lGvfTKkLxlLxBuoYKpoRcL99w2Nl/o6eIVPMvC+/ZlcPS4zk
         8/aQlwZ/A+Lu+cV7cTWTlFGH+L0Nd0nUXGXI98c1d3E2/nIp/y+ecp6zqb1qsKxjtq0h
         lAm072Liw6/SI045TaEzbfg9zdVQLz7rCxTt55r0PoryddUCtjw/bYEWFbGAC99l8Pm5
         xiqvB5rt9PQ2Kgoun/MnQVC3t26EFqOeglmxxgnLXAkD+/G7fQDTsqZegpBrgG0V1ist
         aolA==
X-Gm-Message-State: AOAM5311t/X7+mAqjHF25wPrqUBtyvY139eJSq1k7YRLOif7c5JWyeiH
        I6MFoghpYurRKsEX9VFQTgIuCNacmZubCA==
X-Google-Smtp-Source: ABdhPJwVhpmBvx6ReXEBF3Q/3h+dZqlgzt+yen/2pxEsSrgmrpKC2d90SnkBFwkIdb/uCII9mqbFqw==
X-Received: by 2002:adf:e50b:: with SMTP id j11mr4811004wrm.377.1623927935825;
        Thu, 17 Jun 2021 04:05:35 -0700 (PDT)
Received: from dell.default ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id v18sm5249487wrb.10.2021.06.17.04.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:05:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        German Rivera <German.Rivera@freescale.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 7/8] bus: fsl-mc-msi: Fix a little doc-rot pertaining to 'np' to 'fwnode' conversion
Date:   Thu, 17 Jun 2021 12:04:59 +0100
Message-Id: <20210617110500.15907-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617110500.15907-1-lee.jones@linaro.org>
References: <20210617110500.15907-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/bus/fsl-mc/fsl-mc-msi.c:164: warning: Function parameter or member 'fwnode' not described in 'fsl_mc_msi_create_irq_domain'
 drivers/bus/fsl-mc/fsl-mc-msi.c:164: warning: Excess function parameter 'np' description in 'fsl_mc_msi_create_irq_domain'

Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: German Rivera <German.Rivera@freescale.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
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
2.32.0

