Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C0935A1B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhDIPIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbhDIPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:08:46 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DFAC061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 08:08:31 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z136so6207932iof.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 08:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cCFJuttyy8eCQKuqwC8jHMTRi5/7/igYdp67UcammQ8=;
        b=D2PfUAVo/McRS5nCNWJcy6N9Q3CrJvnePVhVjQ4scg1XWL3v9iQjT3ndw16xytyJX3
         BaIVXmEStcj+A0WC+yVanwe8YQZVmf3Z3LYCy3519m18uts+/l5iKyAyWXi/Uj0QmN2c
         vfRO9M2AflM1NpWLXc0gQOZC4aFB6pbFOLRP+KXcbi2JM4lba1l0exmY8qrkczhSbeCa
         1azdC+Jo0/o/eTjQmao4w0XnaN6J2aniAXQdWghkuc+NyjzgisTsRmUwLNlXRN5kK6oH
         DlviqUJJh8UJFfV+4W0T4umCKUQQn7c6cglBUC4xhhphwVC4f4biDhh978dHJ4w+nUv5
         KkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cCFJuttyy8eCQKuqwC8jHMTRi5/7/igYdp67UcammQ8=;
        b=LiNdlcyWPT5kygUM2t1vv9rBkraBBAuEEMZzz5rKJ/ajT7VrsqwqnId/oJyDQf6FYs
         fR8UM6nogYsZTZdRjqmtuvWYdEsRzHYlprejEkmIJbM9IpybSlP5VkC/qKLnXh8SrXw/
         LPxbEssObMVvvwRiIxa0Pl6MoAseTJPX75QcjvjuQEtb0wY0rZpCz+7JUotOD6UCgtm0
         2JvWlT8kVRVBwV8nSjuYM6/C8yG6PcaV3HPuVYszgtqfHAwqRGshqgufFFAHsA0kfuU4
         lb5o4FjlG3D9To4VtyO5xpGVZeVzj5wj/MTmiJAvXupBwJn7cjSlXZJ2gEY5+jx1SBhj
         XlvA==
X-Gm-Message-State: AOAM532itdcXZJH4cxPEX2mCfLRqYlaYHP0KnPtkawkG541boLtf/u4O
        8udvE3NQ6OLpi+nRRyTyHPnx/g==
X-Google-Smtp-Source: ABdhPJwlIqoqGcKo6Zz/1e3L1gb+ZMrLq9L8rpR/dYRv8moFhhGduwFkid2PL+bH0+ZKYCG/5xNJGg==
X-Received: by 2002:a6b:5811:: with SMTP id m17mr11293185iob.102.1617980911188;
        Fri, 09 Apr 2021 08:08:31 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id m11sm1366606iop.11.2021.04.09.08.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:08:30 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     linux@armlinux.org.uk, bjorn.andersson@linaro.org
Cc:     mani@kernel.org, krzk@kernel.org, alexandre.belloni@bootlin.com,
        andrey.zhizhikin@leica-geosystems.com, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: configs: qcom_defconfig: enable IPA and RMNET
Date:   Fri,  9 Apr 2021 10:08:27 -0500
Message-Id: <20210409150827.946289-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDX55 is a 32-bit ARM device that includes IPA v4.5.  Add
CONFIG_QCOM_IPA=m and CONFIG_RMNET=m to "qcom_defconfig".

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 3f36887e83330..b30f57399477d 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -85,7 +85,9 @@ CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
 CONFIG_ATL1C=y
 CONFIG_KS8851=y
+CONFIG_RMNET=m
 CONFIG_SMSC911X=y
+CONFIG_QCOM_IPA=m
 CONFIG_MDIO_BITBANG=y
 CONFIG_MDIO_GPIO=y
 CONFIG_SLIP=y
-- 
2.27.0

