Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3703E35FA99
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352448AbhDNSPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352508AbhDNSMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:44 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EA4C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:22 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id bx20so23682289edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ori8skrXk7XGT4Hu5sGfSKgV6wISnGrIrTQqBDWCdU8=;
        b=mc7ISKM8IN8NNd9RhWdufKtE/0GM1jWiulogYO894V62UamO8Q8cMagF3YzTmibCUD
         ORUiqNnjO0sfF8UROSDEdcdfLRwHfK7cpKI/OwXyc+xvkGBfQvMe7A6Yka+PqqTbGlMM
         S9qgv04mPI5zyY5dTVun7p8xNHntl8VQObUO5Q1g0Kb8x78JzKirmHyVDiPHVjzj2dl8
         vmgVV9dvAHv4fL66XOxgctBXWJMArNjXNmWnVTRMRfBREBvhnabsZEpWtEe2XgxkBfCb
         1kvH3F4Q67jpXHCeTWxsaN5IDkzlzluUNmjY9azLBdJCJsr5HWS2ATYDSVChZO7ItI2I
         r2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ori8skrXk7XGT4Hu5sGfSKgV6wISnGrIrTQqBDWCdU8=;
        b=TjY8zHCSQQUY0AoFESYpFKh8/69Eq2IenJd4I/Ss7G9QBHylun9VBfMiA00g3uFTEh
         bUI7XTtxMrqwVX7pqDxVCCzjlMCW5PB4gctbHDPQEqJr9ckINMEXwOd7rPjtgMJhLrGz
         xJAxRv4GZupMOniYF2Q76HrMcrYb8qneQdGkW1ROnmwpAB34G+g5IDbZSU2QN8kx+xva
         9tTaE8+/IAxnt/Lpit9lvaIiovA+ur0UxlHgjRbXLxe7JjhoVihVMDpChEC04rep1Nrq
         0s/nR3SpWlxrVBM0IA2nmtfDbCevXCF0liee8LV3p1Mn+63oxuiIIVg7gzwDZWMcptaa
         B8AA==
X-Gm-Message-State: AOAM531dlRAB1NvHKqqNrmMZpglszRq8EMwqmOaWqsiU5dEkvMHOcwhu
        CJTKQfzgZwEaQLv/7ZTWSm6Xkw==
X-Google-Smtp-Source: ABdhPJzo7+4P9rNWMYYRVWtHAsqJEkY58c1jqCvNyFz94yYXpm9GwQ+fFUOqUdnyWRkmaeIsoMBJEA==
X-Received: by 2002:a05:6402:254f:: with SMTP id l15mr164633edb.189.1618423941585;
        Wed, 14 Apr 2021 11:12:21 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>, Stanley@BB.SD3,
        linux-staging@lists.linux.dev
Subject: [PATCH 45/57] staging: rtl8723bs: hal: sdio_halinit: 'start' is only used if debug is enabled
Date:   Wed, 14 Apr 2021 19:11:17 +0100
Message-Id: <20210414181129.1628598-46-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8723bs/hal/sdio_halinit.c: In function ‘_ReadAdapterInfo8723BS’:
 drivers/staging/rtl8723bs/hal/sdio_halinit.c:1170:16: warning: variable ‘start’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
Cc: Stanley@BB.SD3
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 2098384efe927..f6d734dd1a24f 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1153,7 +1153,7 @@ static void _InitOtherVariable(struct adapter *Adapter)
 static s32 _ReadAdapterInfo8723BS(struct adapter *padapter)
 {
 	u8 val8;
-	unsigned long start;
+	unsigned long __maybe_unused start;
 
 	/*  before access eFuse, make sure card enable has been called */
 	if (!padapter->hw_init_completed)
-- 
2.27.0

