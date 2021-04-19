Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904F5364256
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 15:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbhDSNHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 09:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbhDSNHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:07:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB57EC061760
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 06:06:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h8so457187edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 06:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devtank-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1zgCFjor3XnFUiqS8luN2jabhXdNkHgx+yBFmbZRtKE=;
        b=rS/GHKCu3RCmJE+NAGg6FoCU7E/J7DkCYs8yay6X6LojOoL4tQC80/DcOQyxadagkU
         BQpWzFHdew0DfnVKy3L2qs6c8t+Wctc6fTWaXHW8/Z0rrRBZWbKVK2oyaf9VPlTx1+Kp
         DBzu0bWfDvYaKoNdXZQ0BeE5zIpxY9sgfyu8TlTVI5FNc/uFvpd7JWYgzTR0aD7+82sG
         WzJzB0xAmBrdVxtrYSPsn8dhc+QKN+KsK/rYwtn42BSiXajnu1Slbs2eybFkO4Ia8FXw
         W9mUoNig1C/bSRHoqEvcd46anIETzC5XGMNffDIRMnSmo6FSTZlNMD2mSH+qK68kUQP2
         t8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1zgCFjor3XnFUiqS8luN2jabhXdNkHgx+yBFmbZRtKE=;
        b=lO5QKiWZkDn6akWNVH14YD0lSrgXgyeeCftgZ6IF4rIrw1bQg7slJbnBNEST4Rkvf1
         hu+VIS0xgu6zjFL27pRLNpi/NQUH4EgJ2/x0wh8vkEJJ2qqAXHwGXpYHezQuO70jr+wc
         QahfNjGPLHlrj0PW2RhEeY/Vivh3bsoiPVXDtSohaKwzIZ+d6PGOUHhvXY1HEIH/ZdPl
         2fVwxIfbtgPJ/lLd2btmhSKlNV/q2C8W/qr2IUJM6G1pHK5SmRPPWm4DQgrVyelWoPyt
         BglhanSSpe9bVE1XDjb72jrR6IDw8UuZRmmmgBLQymhwOkl1C0RyXB+RM/26/gPnU+bf
         ymxg==
X-Gm-Message-State: AOAM533eFBWbCQaPVkAQstyf38Z5bhL5IGmplgcYKwp5pa2RaH4bUaHc
        r6eSNCDV8LQR0vBXqB9/6cVdMA==
X-Google-Smtp-Source: ABdhPJzYojtclLmQoIIsAvWeGdEI7bB9mMxO6N7G/Aok58dOaXdiehW2yc7inVlG5iobG5J0rGL9EQ==
X-Received: by 2002:a05:6402:1ad9:: with SMTP id ba25mr25583421edb.264.1618837596569;
        Mon, 19 Apr 2021 06:06:36 -0700 (PDT)
Received: from jabjoe-desktop.lan ([2a02:8010:673b:0:27d5:da8f:c244:7b8a])
        by smtp.googlemail.com with ESMTPSA id g20sm13277249edu.91.2021.04.19.06.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 06:06:36 -0700 (PDT)
From:   Joe Burmeister <joe.burmeister@devtank.co.uk>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joe.burmeister@devtank.co.uk
Subject: [PATCH] spi: Handle SPI device setup callback failure.
Date:   Mon, 19 Apr 2021 14:06:31 +0100
Message-Id: <20210419130631.4586-1-joe.burmeister@devtank.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the setup callback failed, but the controller has auto_runtime_pm
and set_cs, the setup failure could be missed.

Signed-off-by: Joe Burmeister <joe.burmeister@devtank.co.uk>
---
 drivers/spi/spi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8b283b2c1668..0c39178f4401 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3388,8 +3388,15 @@ int spi_setup(struct spi_device *spi)
 
 	mutex_lock(&spi->controller->io_mutex);
 
-	if (spi->controller->setup)
+	if (spi->controller->setup) {
 		status = spi->controller->setup(spi);
+		if (status) {
+			mutex_unlock(&spi->controller->io_mutex);
+			dev_err(&spi->controller->dev, "Failed to setup device: %d\n",
+				status);
+			return status;
+		}
+	}
 
 	if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
 		status = pm_runtime_get_sync(spi->controller->dev.parent);
-- 
2.30.2

