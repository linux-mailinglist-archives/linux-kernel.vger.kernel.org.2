Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92988365A22
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhDTNb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhDTNb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:31:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC3FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 06:30:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u15so11127626plf.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 06:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aHz5AHGIJOCN6El7KH5rcuP6uHYumsVN1J8d0zR8Sl4=;
        b=WJMXVyyRgaaGiq4QghNgTJZ2i5N+7y17unDN66yMk/VjRNpAEmw4xvS3SdRu/WGflA
         vMb/OAII46HQ43OVVLOTTtrq9Kuzhf2D1Id6D86bWrDrQ9WUfYJUyIolFd58iiSwakwI
         0kM0uWj43GLOZcBZTl2atXqMoMGi+3chm+gHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aHz5AHGIJOCN6El7KH5rcuP6uHYumsVN1J8d0zR8Sl4=;
        b=JmM+QyNOles9/B6YVv5nDFGnje70W72z3LBHv8mRIGfzQaIcTRfd/vpqHhe6/4BfFZ
         I6de3EscXqyJD/OJXHLKHvfvrpS978woBevTaXBeTfb7BZNWctYHU5htA8POnIoucQuA
         YEc4gG+WCtNb91Nu+XTf9jYKkGSp4q6H5JwNeMK/cP0d/sOBwGF3OsHgSgk33h0UfBqf
         dLIJ7hOFgs0poHwMuncE/KMuFyIqmbk3oyPK4FSXaVm/uQEOJfEL651Don4IMa1KgTat
         EYZ6Biflel4M3X2R07+WN1v//2X0+qnzmf/5cax6ptsCD5s+yDk1hDjhqnSlojSGsW6O
         PaQA==
X-Gm-Message-State: AOAM532wLf+LfZRsANQRrkqmfwowIgEdK5aqxnKL5Lk14jzt7B9PpuU6
        /yd87hJZUwj6XvfDcODi4OQkYQ==
X-Google-Smtp-Source: ABdhPJwOQbxWB6lznWwRRMkY+UhBC5RN2VH25PSDhcpX4tzH8sX7E+3E+719WIBZxEYYHLE2DjwiAA==
X-Received: by 2002:a17:902:6b43:b029:e6:3d73:e9fb with SMTP id g3-20020a1709026b43b02900e63d73e9fbmr29174032plt.37.1618925456060;
        Tue, 20 Apr 2021 06:30:56 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dd8a:99b8:c84f:86a2])
        by smtp.gmail.com with ESMTPSA id 25sm16852484pgx.72.2021.04.20.06.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:30:55 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: eeprom: at24: check suspend status before disable regulator
Date:   Tue, 20 Apr 2021 21:30:50 +0800
Message-Id: <20210420133050.377209-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cd5676db0574 ("misc: eeprom: at24: support pm_runtime control") disables
regulator in runtime suspend. If runtime suspend is called before
regulator disable, it will results in regulator unbalanced disabling.

Fixes: cd5676db0574 ("misc: eeprom: at24: support pm_runtime control")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
This patch is originally in
https://patchwork.kernel.org/project/linux-mediatek/patch/20210414172916.2689361-5-hsinyi@chromium.org/
---
 drivers/misc/eeprom/at24.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 926408b41270..7a6f01ace78a 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -763,7 +763,8 @@ static int at24_probe(struct i2c_client *client)
 	at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
 	if (IS_ERR(at24->nvmem)) {
 		pm_runtime_disable(dev);
-		regulator_disable(at24->vcc_reg);
+		if (!pm_runtime_status_suspended(dev))
+			regulator_disable(at24->vcc_reg);
 		return PTR_ERR(at24->nvmem);
 	}
 
@@ -774,7 +775,8 @@ static int at24_probe(struct i2c_client *client)
 	err = at24_read(at24, 0, &test_byte, 1);
 	if (err) {
 		pm_runtime_disable(dev);
-		regulator_disable(at24->vcc_reg);
+		if (!pm_runtime_status_suspended(dev))
+			regulator_disable(at24->vcc_reg);
 		return -ENODEV;
 	}
 
-- 
2.31.1.368.gbe11c130af-goog

