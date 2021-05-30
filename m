Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F039E394EF7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 04:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhE3CW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 22:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhE3CWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 22:22:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A4EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 19:21:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so6683781pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 19:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t5ZoeWRn1djhDlR2EvTyLkwYeHtchskFNmoEn+GOOwU=;
        b=nNXdZ5smDrbole6kRReKofcg3iIqk7hZwKGnSesJIo/TB6YS9INEjNnCQAyo6DJkWq
         Udvx1eHTJ7moXsJJkCnI31X3VtrTzjpRay38ja5o6PN+tW9PLjO8Cr/475/Pbb0zbcBY
         pDcfgP2lQqkrkkMZX+sSxXbtdtFMyxRnuPwwLmToSWTm/qgHpctTjwrn5jYK5C5f4HXE
         wFlx9rFRHQtfHQBuve+OK65ZBa6ma7nvlJ9fIWc7CH2GrnHGHFFxpogNCLMDazygMXIL
         9l1ao0n3Gho9vJ2wMjONglqz6VMY+d4W31pVtlCUQZ8WBB4bvNUkhbZOwjWakBWK3++h
         dL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t5ZoeWRn1djhDlR2EvTyLkwYeHtchskFNmoEn+GOOwU=;
        b=LfzFpGKbybs94d/pboAjBxUl+9hIgHPtcNu0McnnuuKYzGBcoU+x0gAqYi0mGry+UM
         hlMy3aZ26aaQ4f++6jTIePTWWdj6DxOs3sJ+WaDx0BULYJK4dWe8Wjlsc4mxy08AQhHc
         VZ/7ifIL4rPX/fewhGBzaF0TCuJ2As9a1keAI77mFY8JWFSTMS71064D1mpY5opRxNe9
         KQz69XWGvhogmrsGA3ii4X5qiG3Kc63ecIX6ILvK/BDiMFrvWSO49P1tGn5V10f4r7w9
         vcbb7V7nYpO/E9vjxmlpQUxFNAESfWs8vKA/UdWekHaUa+5BiRf1npBgSVBR+rPrsggr
         iI0g==
X-Gm-Message-State: AOAM530a5RccoMismfnZTMCZNl+BZ0fCswK0KP6APPfkw5O86PaCOhGf
        PA9sqM+uU3/RDoDpdPL2D7imsA==
X-Google-Smtp-Source: ABdhPJzCq9RdjGrBQ+JFanmdQv6Nv3yDMNSwu5CScLxFhXGxVof+y04UWgueHBPyjKTnNPXn5ToB4A==
X-Received: by 2002:a17:902:eccb:b029:102:23ab:27a8 with SMTP id a11-20020a170902eccbb029010223ab27a8mr4866417plh.70.1622341277637;
        Sat, 29 May 2021 19:21:17 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id t1sm2554098pfe.61.2021.05.29.19.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 19:21:17 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mt6315: Fix function prototype for mt6315_map_mode
Date:   Sun, 30 May 2021 10:21:09 +0800
Message-Id: <20210530022109.425054-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_map_mode should has below function prototype:
	unsigned int (*of_map_mode)(unsigned int mode);

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mt6315-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/mt6315-regulator.c b/drivers/regulator/mt6315-regulator.c
index 8c5d72869c2b..865a292bedcb 100644
--- a/drivers/regulator/mt6315-regulator.c
+++ b/drivers/regulator/mt6315-regulator.c
@@ -59,7 +59,7 @@ static const struct linear_range mt_volt_range1[] = {
 	REGULATOR_LINEAR_RANGE(0, 0, 0xbf, 6250),
 };
 
-static unsigned int mt6315_map_mode(u32 mode)
+static unsigned int mt6315_map_mode(unsigned int mode)
 {
 	switch (mode) {
 	case MT6315_BUCK_MODE_AUTO:
-- 
2.25.1

