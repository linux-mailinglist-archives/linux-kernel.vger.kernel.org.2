Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7787939863D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhFBKUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhFBKTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:19:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099BAC061349
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so3410250wmd.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5FEzmO9RZgKtbCHPkiUM3cWX79WWEVOe+3S3XV/eYg=;
        b=C2GCEG54UusFDC++LW8FQGhMV9Ae2/NdAiCrbnLSn8Dfc9HJl+/4P0+sz06JqzuqWm
         /QbsnbxardHjL/6AaH8fWYkB2yByRBcs4tJxiB7fVwBPGf1SUddsjDEpdmUV1HN17SPY
         hIfBZzGerb0kFyltrpIhV0t+K1sNRmYOieTWrjQZGgSNu6/PJHfj5PHkYIr2JUgIYeCX
         uRoJNNonKzF5LGjgs45qE8gZkQyILHHaH74MneW1jnQ00vRJ9DGo5ycXZU2JQMG136rU
         UtxvuZE6+utEsPcNZmXCEusQFKdXGlnFXPHnG/IlFcBic8QHpVKgX+HjD0MWYtjmG1wD
         kIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5FEzmO9RZgKtbCHPkiUM3cWX79WWEVOe+3S3XV/eYg=;
        b=CSUYRRRJMBk0T8cCEFqONIttbiGcjaQRl2CfoudUZTW3fDOmrQBOq4X1YupoyXWJbV
         dA3R+cjC80oN927BSkO6mfgdCwx9cZVchD8IErpSpDLOjMIkGA7rHSnOqO/djChaBXOw
         Fj8fNUIL/V0Wa+YF69/jhBvuZBZId91lei+AWFeIIRoUv3VaIsDI0DmJar+qeW+jkS/7
         ExG9BWK/eLJTP5EwJhp2+R1y1MJCy6tsuos5luFqPjeKb8lFTS24EA00C5BdYYecsRFB
         aJa7TnEQIiwjfx1tXIFxyA/nklA5SKM6190lIJXJIZEgMgTq2uewrp7YXjobzm6L1KIf
         EPgw==
X-Gm-Message-State: AOAM533DS89dxHKAzXnIi7yW4+V4cI/46gWsJ4ZJGfw3Vtc81ClmpTld
        rmRR+uFlzEujsFiywlOJDClq2gGGf6M4iw==
X-Google-Smtp-Source: ABdhPJxL98eynQkJFFkPBCCkEwJ33W9JN6L7a5MWz5uDvW4J9kyCTOJk0pF9VP0/RZ3Cq3Hp/W4C4Q==
X-Received: by 2002:a7b:cf23:: with SMTP id m3mr4526415wmg.24.1622629064563;
        Wed, 02 Jun 2021 03:17:44 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andre Hedrick <andre@linux-ide.org>,
        "Software, Inc" <source@mvista.com>, linux-ide@vger.kernel.org
Subject: [PATCH 11/21] ide: slc90e66: Remove unused variable 'sitre'
Date:   Wed,  2 Jun 2021 11:17:12 +0100
Message-Id: <20210602101722.2276638-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/slc90e66.c: In function ‘slc90e66_set_dma_mode’:
 drivers/ide/slc90e66.c:80:6: warning: variable ‘sitre’ set but not used [-Wunused-but-set-variable]

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: "Software, Inc" <source@mvista.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/slc90e66.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ide/slc90e66.c b/drivers/ide/slc90e66.c
index cd47445fda1ff..0b06c74dddf36 100644
--- a/drivers/ide/slc90e66.c
+++ b/drivers/ide/slc90e66.c
@@ -77,13 +77,12 @@ static void slc90e66_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 {
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
 	u8 maslave		= hwif->channel ? 0x42 : 0x40;
-	int sitre = 0, a_speed	= 7 << (drive->dn * 4);
+	int a_speed		= 7 << (drive->dn * 4);
 	int u_speed = 0, u_flag = 1 << drive->dn;
 	u16			reg4042, reg44, reg48, reg4a;
 	const u8 speed		= drive->dma_mode;
 
 	pci_read_config_word(dev, maslave, &reg4042);
-	sitre = (reg4042 & 0x4000) ? 1 : 0;
 	pci_read_config_word(dev, 0x44, &reg44);
 	pci_read_config_word(dev, 0x48, &reg48);
 	pci_read_config_word(dev, 0x4a, &reg4a);
-- 
2.31.1

