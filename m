Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D90358AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhDHRKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbhDHRKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:10:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837A2C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:09:49 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ha17so1492668pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qe/vp6A9DI5p5DjJuNBfDEup96GoMwjNV5uyR96qpY8=;
        b=Gne3yB9QSvrA+D+ranKQP69VC0pgchkWT7urSiuDMLBnm/KaWGnUquRF+stWhYJ5oP
         dPRj+ynr/ld521k1NFyCn/wnoIdYRwzdX91J2SfU64EUYQKTd6QeS0Ahy1BSHZBu7QVu
         LogOzRhXU9cTHK0zRPwU67VcPtylaHD4oGrfd7XecjeF36QqgquQ5LwiGhlEFwJ92NkX
         +OVfT1RIQxMz0Ui6kvZ+BxpCYCDRvsvppJemjFUjRxXx/sJ4WWqoZJXWu5pbn8/djF2U
         mPrrbngnuFNNxC8/dibiuUsJuNn/VjABanEvbUKShAYrhoPQPOBYxVBrjPZQytQ442Lk
         wjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qe/vp6A9DI5p5DjJuNBfDEup96GoMwjNV5uyR96qpY8=;
        b=OsZ+RL4uQZuk9Sx7QQq/dThVkhdZHHtWqC57NL2t/s/2/wCBpy79cHzW90Z/h/D6to
         aouCit0s1rZTuC/0NrLi3kHf3UmNv0HtlW2MziHRrpHqYQI8vae9IRWLc6CrFfUBPY53
         YqSJpI6FBSABeEng7TET1zDOSEpY/bXXbtf+sx/2YYEvSNwPBqJXECHk+b9f+rnrDRyR
         cCr+BoxkJmIrtZiEzNbyJpom3zo/6Fcy/DOtP4LBKsx/chxqThGkgEYRoBUS87VU2JH3
         aAPWefaVV4wzE6gJYnZ96oHppLAzc98dsRWMn3stwSn1IFF69Qm56qjPT8anBnSig2SS
         jh/g==
X-Gm-Message-State: AOAM530RfLZVM783+RrWr8/UlZHR5iRGHHo7HO4a++MkjMT+sQ/F0NJv
        xgWJgX4rUIGY0I6L2dqy9Y0/qKj1aDJI
X-Google-Smtp-Source: ABdhPJwvRPxbNbUoZ0DtLvkZdLF89QzWV8d8DUn7T9Twhp1cUhtrIKFcEDJqO+FodFy4x6ErjXocuQ==
X-Received: by 2002:a17:90a:aa11:: with SMTP id k17mr9100087pjq.60.1617901789087;
        Thu, 08 Apr 2021 10:09:49 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id a191sm57921pfa.115.2021.04.08.10.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:09:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/7] ARM: configs: qcom_defconfig: Enable SDX55 A7 PLL and APCS clock driver
Date:   Thu,  8 Apr 2021 22:39:25 +0530
Message-Id: <20210408170930.91834-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408170930.91834-1-manivannan.sadhasivam@linaro.org>
References: <20210408170930.91834-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable A7 PLL driver and APCS clock driver on SDX55 platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 0b9da27f923a..02f6185f31a6 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -215,6 +215,8 @@ CONFIG_DMADEVICES=y
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_STAGING=y
 CONFIG_COMMON_CLK_QCOM=y
+CONFIG_QCOM_A7PLL=y
+CONFIG_QCOM_CLK_APCS_SDX55=y
 CONFIG_QCOM_CLK_RPM=y
 CONFIG_QCOM_CLK_RPMH=y
 CONFIG_QCOM_CLK_SMD_RPM=y
-- 
2.25.1

