Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C679A457358
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbhKSQsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236664AbhKSQsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:48:01 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF89C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:45:00 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id n85so9801395pfd.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=2p/KFqt/ZADbSAzTepwM8vdeVayJBy01ZQFHi24kNM4=;
        b=cXnJ0Mef1u3KUxfz8OHEsN9OmkwYgvnraNTsYjxJ3MKnYEEgXZ6tL8esNvtPN7wU1w
         eS3lCzYiXMSKF5+CIgCIVmeBCko/kXof2cYYqfacqIbcOXtyVQRBhykpy/U/s/ShQ998
         YX+OKMNiZMmmFvEMYuhLN1Z+JagtuSoH12V079RIVC+hdG2WtbYOOrbk7QAMp9WELrru
         U6UX6SLSX0TgO4F6G2W4uIrleo+0q5LzDSEmgb7GgCop8AK2agifKlfmSx3Snc0uaucB
         SLyMjykEZf5UPbXoqRFRtyKxa9Ag9kQ7XBG7cXl07O9jLpiPC4KqVN+nFcvyucJuclts
         xKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=2p/KFqt/ZADbSAzTepwM8vdeVayJBy01ZQFHi24kNM4=;
        b=JkJnG1njtzsbwQ6ovCpldijsSbcW9lh3bpKRvzywZcUXIZivayoAVjzdTHr3UygqUB
         lv9t4hOCa0E1cW1uCmTn+xSMz8Zs4SRMxQZdEnJ6jz/IibO4x0fN3KSNE6d2DTvukz7v
         3u5Dvjm5ambRNLwtUqy0K9vug2MuUWhlxWfZ8+JNNYDD9TeHfe+AMKqdL/ybf2IxPv3U
         YU3Ja1/m8iUrDI3hYRXILIoDAJBSQDmblVL5nphEE0UvIhz44oxRf4V4lCDclASc9Cuc
         HMjXzeQ1V88hg3DCE6CTUxQfmNRZcB0ScXkHRfyN7bqEG+qEPQvjUaCdzB/Cn1S+XMMh
         lnbw==
X-Gm-Message-State: AOAM533QAkP8GLwSJ3OSpRVI4gOKvnTUHwzenqonRBy7e0hYfJda8f9b
        WsSL8r0t23Vyz3Yt4+cDNgZedg==
X-Google-Smtp-Source: ABdhPJz4LrUZWT0R8rNhNOefr57C60C60P7WGoXavFq81PH0cgQ01ztvYBneRGwD/QO2VStrNrY7+g==
X-Received: by 2002:a05:6a00:148d:b0:49f:def7:9cfe with SMTP id v13-20020a056a00148d00b0049fdef79cfemr24944991pfu.69.1637340299119;
        Fri, 19 Nov 2021 08:44:59 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id lb4sm12657350pjb.18.2021.11.19.08.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:44:58 -0800 (PST)
Subject: [PATCH 06/12] RISC-V: defconfigs: Sort CONFIG_PTP_1588_CLOCK
Date:   Fri, 19 Nov 2021 08:44:07 -0800
Message-Id: <20211119164413.29052-7-palmer@rivosinc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211119164413.29052-1-palmer@rivosinc.com>
References: <20211119164413.29052-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup.patel@wdc.com, heinrich.schuchardt@canonical.com,
        atish.patra@wdc.com, bin.meng@windriver.com,
        sagar.kadam@sifive.com, damien.lemoal@wdc.com, axboe@kernel.dk,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

This should have no functional change, it just sorts
CONFIG_PTP_1588_CLOCK the same way savedefconfig does.  This only
touches the rv64 defconfig because rv32_defconfig was already sorted
correctly.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 0f4fe5790fb5..fa9017c60b3d 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -71,9 +71,9 @@ CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
 CONFIG_SPI=y
 CONFIG_SPI_SIFIVE=y
+# CONFIG_PTP_1588_CLOCK is not set
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SIFIVE=y
-# CONFIG_PTP_1588_CLOCK is not set
 CONFIG_POWER_RESET=y
 CONFIG_DRM=m
 CONFIG_DRM_RADEON=m
-- 
2.32.0

