Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337253B0730
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhFVOSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhFVOR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:17:59 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDFEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 07:15:43 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b3so2863228plg.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oprAVs1wiobkVIzLVu52IdLo4/dGcuOXZp3bCELfRwA=;
        b=YKGs+JcjJrWJq+doKxDgjeoV5+bT1T5Tus6gTKd534/Ae8tlyYPAZDQt7AEMelosoD
         I5Ai1OKs8UlDvUlhV+gmgQzzQvi/wyPv2pBQ2lZTgZGF1yLHFDdsUToY40SNmBkQRiap
         iqWNH1YbDwpeu+WAqtG3L54WB/cgO7QvqMrnacl5F/j9kFVfKclGYCm6UrdHIRovhbdW
         dlKAVKxQ4471Y8+a3gr9Cy2gojSW9j+2X4yy472X8SqY+F1b5Ivi4UVspUxfZ8/MmYI/
         zeVBDDNxq01gxfmv7g5euRUzQPrfcJCwMtZvVVyobw0cV1juaNLhCP5chS4wOJJQpoDn
         +5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oprAVs1wiobkVIzLVu52IdLo4/dGcuOXZp3bCELfRwA=;
        b=aPmlhDFbEVUJB7p52mtkCOK/kYNrsmc4B5Qlxj/4cP6n5GiwOHryvWA4N3CApWhHVq
         ClXUFEoo8rzJBzRlBJxKkSnW1czzd6TRTWh8edYUc+i6mDaFyz7hFUCEqUCsNQyWAu4f
         rgWTDDxbA8HYTqAFnOevWwotfle46h815OeuoyMdG/MJ7Cqx1Nzbj2X89SHAKDYEVn7x
         wFs7ImFizxIxB1ziyJMHPwHp/+MtsbTc+ZB3y3YPU8a9m9D/wU6eeckUzPdBzMtOgIqi
         YVW5E3aslp9bLbzbbFs2RZOA7ackDG57dQKs1cOcZU2tEcQ30IJrxSKj+Xs32EA5Blpf
         UB4Q==
X-Gm-Message-State: AOAM532Aw+xebrgIOkT1DA/gaciYWyxaJxI8dFWhFxZwlJvZZIdp3zqw
        5aX5GfRd64KiiTeKlaHff/s2Dw==
X-Google-Smtp-Source: ABdhPJyYtCJl8GsI5UBKjL75kOaLoo6c8QkTVksrJoW9GUjZG4Slc8W6euEfjj0QUYjjy1DTiMao9Q==
X-Received: by 2002:a17:90a:bb97:: with SMTP id v23mr4338195pjr.146.1624371342833;
        Tue, 22 Jun 2021 07:15:42 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id y20sm21351086pfb.207.2021.06.22.07.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 07:15:42 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sergey Larin <cerg2010cerg2010@mail.ru>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: max8893: Select REGMAP_I2C to fix build error
Date:   Tue, 22 Jun 2021 22:15:26 +0800
Message-Id: <20210622141526.472175-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error if REGMAP_I2C is not set.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 55148dd7c6f1..24ce9a17ab4f 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -581,6 +581,7 @@ config REGULATOR_MAX8660
 config REGULATOR_MAX8893
 	tristate "Maxim 8893 voltage regulator"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  This driver controls a Maxim 8893 voltage output
 	  regulator via I2C bus.
-- 
2.25.1

