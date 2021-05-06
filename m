Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430AE3751B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhEFJmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhEFJmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:42:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720F9C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 02:41:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s8so4869932wrw.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 02:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KDuP19RIvFr3oYQnO2ffHmKNK3OSRhOK3RHFKslMECA=;
        b=k0Xs3EkXrnyoP2PbgSrq8y2ftS9kgvDiDnida+rHIzEoM7j3qDw36lGXYrV/8N/vmH
         idvneoPCQPd45bMDsZKDKLypoyJw9q97iEl81Cs5tbrs7Ui0U1jYyg+AmwvayaGeH1Pe
         YFJbH/UH0XRk6jO8wJcn+2OOoHkjbCm2kg+zuTz6HTt7XEH/LqRUOLVmF/AR7g104Qsq
         BN3qBi1QKZ9LmDznT+hygxT234aAmLA21J7C9Ybe3SU8n6moRzYxHhzRG277VeIlgM6L
         zjQbjWWy6iFfHcYrFT9zuTemmuFru1UPK82rVg5euKSzZ2cnVXOBSMeVcHd39lKV6V7o
         MHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KDuP19RIvFr3oYQnO2ffHmKNK3OSRhOK3RHFKslMECA=;
        b=EVsS8kuQiWniIP66kkVbHmh5F3tzkiJCCE8L+qQDmqQdLlatheuDG1y2vX3SM5OLW/
         g/L1ZxnCauv7qJ0kIIVcp2rgHPtn0Z77gy3OQpFGFoRxaZ7ynwqtUc/99cEFHxaBByHO
         ciVQWNkESvcRaSQyVcjr61YZwvgRUnKeQvPlYzyMf4261EXjY/T/ms20fR/CpgILZ4EA
         dU3WGDp7YznO+i69d8vS4VzFrOPkHRNT1/5wSgpJmxLvEfCYOUjuHs53VrpWCeS/H1WT
         Ino/hVqLcDAwQMSiG+mA+idU73cp2p38OBn6vqQaKQX7qqzGXv6n/TCwfN14oJPdXQSq
         GQ8g==
X-Gm-Message-State: AOAM531hPmYqp6eWYtI0hB9YzfMcGz+kk9TRO7PTc5d6xHVejDVQIlYD
        oY5uKJOln6KcFL5+tasz+zD4hQ==
X-Google-Smtp-Source: ABdhPJzwRD5YwKJypFE4rH6ogHDtfIjZiYWqGARQDqBZhdYYG/mrrB63EhsuHj3vNlIwsukv1vsMMA==
X-Received: by 2002:a5d:60cd:: with SMTP id x13mr3784698wrt.377.1620294084131;
        Thu, 06 May 2021 02:41:24 -0700 (PDT)
Received: from groot.home ([2a01:cb19:826e:8e00:2492:c5b6:6c3f:6de4])
        by smtp.gmail.com with ESMTPSA id y14sm3360421wrs.64.2021.05.06.02.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 02:41:23 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 1/3] mfd: mt6397: add mt6358 register definitions for power key
Date:   Thu,  6 May 2021 11:41:13 +0200
Message-Id: <20210506094116.638527-2-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210506094116.638527-1-mkorpershoek@baylibre.com>
References: <20210506094116.638527-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support power/home key detection, add definitions for
two more MT6358 PMIC registers:

- TOPSTATUS: homekey and powerkey debounce status
- TOP_RST_MISC: controls homekey,powerkey long press reset time

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/linux/mfd/mt6358/registers.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mfd/mt6358/registers.h b/include/linux/mfd/mt6358/registers.h
index 2ad0b312aa28..201139b12140 100644
--- a/include/linux/mfd/mt6358/registers.h
+++ b/include/linux/mfd/mt6358/registers.h
@@ -8,6 +8,8 @@
 
 /* PMIC Registers */
 #define MT6358_SWCID                          0xa
+#define MT6358_TOPSTATUS                      0x28
+#define MT6358_TOP_RST_MISC                   0x14c
 #define MT6358_MISC_TOP_INT_CON0              0x188
 #define MT6358_MISC_TOP_INT_STATUS0           0x194
 #define MT6358_TOP_INT_STATUS0                0x19e
-- 
2.27.0

