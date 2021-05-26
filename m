Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867403917FC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbhEZMxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:53:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56964 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhEZMth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:49:37 -0400
Received: from mail-vs1-f70.google.com ([209.85.217.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llsxB-00014a-9i
        for linux-kernel@vger.kernel.org; Wed, 26 May 2021 12:48:05 +0000
Received: by mail-vs1-f70.google.com with SMTP id q16-20020a67d7900000b0290228198e77b6so192698vsj.23
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0G840/6Lxcb0Mf0VQ/EHwzTpuJEk0LuU0gTLTIwmZhs=;
        b=RfaRzCjmyG9uKG96VIDqbeCUvoe6vIxLplOJ9skPvcqMhwFrrGIg8UnX4fLyjZ+oDz
         HpAFHEBAqb+C126iB8e45yximCmtwJHVyCK0JMLj5Q0/LrPzKxAwuP4XyQjfS1FZNBdt
         8jFASykW4YNQ6lEPI0yNbwYuoJuUT9dsWhy+2rvf/JG9TJggBA70LFLx/mMZanVYKcwO
         O30rNyXspOxQZZx8MQMQnAQdzzL1fLe1N1r8KqUmbOzHh6q2OMPA4rQurAHBm2ftf7Ua
         WzZXiAdJHt4OW7fAmEPJHbjGdUIP0JwMVADeu9tAKSwb3r4ZYeV/cYn46ilOFngQh634
         Wx/Q==
X-Gm-Message-State: AOAM532Bn0GHQPY+zaiVtjIjrpu3wTn/tB33wgd+AjWIR4kBHiG5yvip
        Z+eHKVH6HSsZvIW4pJCNk29OQpekG3Wf8onumnxNZCzFLvIFaaa+1QJYDhUZxwhiW8b0VCp7g4v
        7OnmrkoXdftCQG3Lkxl5X2NvyLhw6w5DHg1VTXpe4RA==
X-Received: by 2002:a67:ec4f:: with SMTP id z15mr29705044vso.27.1622033284483;
        Wed, 26 May 2021 05:48:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCoTnt6t9OzH8wpF2Ii6dBrFO6A3IuSsgipAxOrGMJk8cgaaL0/Ep+nV8/pkm14FWQbrzLzQ==
X-Received: by 2002:a67:ec4f:: with SMTP id z15mr29705029vso.27.1622033284342;
        Wed, 26 May 2021 05:48:04 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id c126sm875817vkh.47.2021.05.26.05.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 05:48:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [RESEND PATCH v2 13/13] mfd: sec: Remove unused platform data members
Date:   Wed, 26 May 2021 08:47:11 -0400
Message-Id: <20210526124711.33223-14-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210526124711.33223-1-krzysztof.kozlowski@canonical.com>
References: <20210526124711.33223-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung PMIC drivers for early chipsets like S5M8767 stored quite a
lot in platform data (struct sec_platform_data).  The s5m8767 regulator
driver currently references only some of its fields.  Newer regulator
drivers (e.g. s2mps11) use even less platform data fields.

Clean up the structure to reduce memory footprint and source code size.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 include/linux/mfd/samsung/core.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index b0d049a56d16..f92fe090473d 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -80,8 +80,6 @@ struct sec_platform_data {
 	struct sec_opmode_data		*opmode;
 	int				num_regulators;
 
-	bool				buck_voltage_lock;
-
 	int				buck_gpios[3];
 	int				buck_ds[3];
 	unsigned int			buck2_voltage[8];
@@ -91,35 +89,12 @@ struct sec_platform_data {
 	unsigned int			buck4_voltage[8];
 	bool				buck4_gpiodvs;
 
-	int				buck_set1;
-	int				buck_set2;
-	int				buck_set3;
-	int				buck2_enable;
-	int				buck3_enable;
-	int				buck4_enable;
 	int				buck_default_idx;
-	int				buck2_default_idx;
-	int				buck3_default_idx;
-	int				buck4_default_idx;
-
 	int				buck_ramp_delay;
 
-	int				buck2_ramp_delay;
-	int				buck34_ramp_delay;
-	int				buck5_ramp_delay;
-	int				buck16_ramp_delay;
-	int				buck7810_ramp_delay;
-	int				buck9_ramp_delay;
-	int				buck24_ramp_delay;
-	int				buck3_ramp_delay;
-	int				buck7_ramp_delay;
-	int				buck8910_ramp_delay;
-
-	bool				buck1_ramp_enable;
 	bool				buck2_ramp_enable;
 	bool				buck3_ramp_enable;
 	bool				buck4_ramp_enable;
-	bool				buck6_ramp_enable;
 
 	int				buck2_init;
 	int				buck3_init;
-- 
2.27.0

