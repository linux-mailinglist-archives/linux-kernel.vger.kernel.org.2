Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7EA3E87CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 03:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhHKB4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 21:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhHKB4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 21:56:51 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BA9C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 18:56:29 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q2so576161plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 18:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L7Vrio5869xJ4kniJiHaeZ3njHxK4MBP7ptl9ZaNmz4=;
        b=XIcnMHJS0HzJBvAbvZ13pC1p40eEQLgprLUgRvZ3vfpOAFDh8pWyjoa3KWK7fGUiy4
         EcuCtI13WYHPLAju1Bd0PyMkG07Q47ms+7RjwG5mgeqfkUa9qejDPPQAnJsExZBuLbmo
         fDX4JB9rHBup99Fd/hZjvUMqIbxZJ/TUF/4yZX7YUx6RsngSRRzituHuCmZ3Aa5oM+XF
         6cNExX2P3dtnvOdLputjHedNw8G+M1BZde39uDjOmk2o0yghqSUIQUaIahXR1MyVMU5w
         K8Y6pf4B6KCCV+xYv8xgicVqpyH6nOta0y0Q50Fzwo8DrCydrBUJoM10OO1IxidBzwYu
         qNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L7Vrio5869xJ4kniJiHaeZ3njHxK4MBP7ptl9ZaNmz4=;
        b=eZjLKfJu/LZANsO5ZiOtXrd2Gf6Kj5hJgJ6ZtIZ4r8G2VtykqWAL0u0wruOrT2DV32
         EUcUvDNFCBqurWeczi3It5PM67t+1uPmYFaFJ5k/Hky0idoMV/glMByr5lF7XzdyD9Rk
         xznSOhmsZr1gHrFnuyExkBF1zrqL+0P7oKVPpniVzjGXOCZMvRIWA0Y4uGrfwgQXo6NG
         nWsKJFxeLJsEbKu3BdzBoZSYCyqcVn9YLr2qM55/016MyF/V6iKlBwVorDprGKxqyhIa
         6hw49jxWOlsKaT6+xfdPrbc2yvozJjVZaaWy6j3+YGPTL49Fv3G8W2AFvKX5Z+6vgIks
         U0Vg==
X-Gm-Message-State: AOAM53364kzkv41omfu6+mw/mmd9ylKxD/juXISB+Uku7UQ+sR8k3mq2
        cN+ydF4nHkkwxG8LCy6vYXo=
X-Google-Smtp-Source: ABdhPJzP2dBQDbSEySU5K2vyqGn+5swpOpL5QinPxvehFmTVDMJLEuVqBb6qaDtjl2wc0lt2SliKKQ==
X-Received: by 2002:a17:90a:2c0c:: with SMTP id m12mr32992607pjd.107.1628646988847;
        Tue, 10 Aug 2021 18:56:28 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z3sm22996407pjn.43.2021.08.10.18.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 18:56:28 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     airlied@linux.ie
Cc:     linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH agp] [amd64] Remove redundant assignment to variable
Date:   Tue, 10 Aug 2021 18:57:17 -0700
Message-Id: <20210811015717.9186-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

The variable i has been assigned in the for loop and has not been used
elsewhere. From the perspective of clean code, it can be deleted.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/char/agp/amd64-agp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index b40edae32817..0413b3136541 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -333,7 +333,6 @@ static int cache_nbs(struct pci_dev *pdev, u32 cap_ptr)
 	if (!amd_nb_has_feature(AMD_NB_GART))
 		return -ENODEV;
 
-	i = 0;
 	for (i = 0; i < amd_nb_num(); i++) {
 		struct pci_dev *dev = node_to_amd_nb(i)->misc;
 		if (fix_northbridge(dev, pdev, cap_ptr) < 0) {
-- 
2.25.1

