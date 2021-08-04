Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629913E08D7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 21:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbhHDT3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 15:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhHDT3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:29:16 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5DBC061799
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 12:29:02 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g5-20020a9d6b050000b02904f21e977c3eso2673296otp.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 12:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=auFQAqlgCrKWrcj2wTgyCwrQ8LuB5Vgp2FCt8uNfzBY=;
        b=Rcy2g/ksuJPuFWN319M4hTbby/3rxVhxL1dfpT2Pr0Qxmcn5yV0FX/bqKuEAhOz28O
         SkzEmjRMJnQFG9JjqqYbQsbkUaZEyOoYd3qQ3GbLsC3ZQrjS9fOwb9WIlsva2A98PgvO
         t12A8iFaXMuBJ65Lo585POu2DbcmD06dXv5ACLKrNLmdSn12mx/wY7pQgGFABqwTbVsX
         Yb5zSuCQM7W7X/2vNVM3R9evc/F2y1Niq2u6oecm0IfFYDcP94zK5izamKau/MXMZ+fR
         XbQflCG3HZVutMjpPtTv9r5y7xsdbuKlirka9xaJAoAMC7QLt30COi5XIuOYntJQ6ekR
         RVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=auFQAqlgCrKWrcj2wTgyCwrQ8LuB5Vgp2FCt8uNfzBY=;
        b=FUzNPxhXZOglZ3hJL6AsEgFK8ENiko4+pu5lW8LqlOBMhkOmRZCkfEMhUrCKXEqH1C
         t0rxPZZf2nxfZFIdz4OtqvKxgjrMAqhBA97hXsbAVIJtw9PDA+2C/8xJNbizG0KwRD5T
         sePj0AhcRm4DVZXoA7SkLD6ZSdGo+BguOHqWiS4s9WhtivzKKJ6IkdKwoCg3KLepdpYN
         9QP+Mz1DbK7rHDIULnGy8/89sUCri33rkCmctOj8SH0gddyKQy5aK4EwxHoBXspzk96Q
         C9O0+dNQNDu7RTlV7KeYmv49Bvd3sdfSJB+e7WzQ7YiXHMs9Gbu+4aqBAGLbEAYp8Iy/
         G3LQ==
X-Gm-Message-State: AOAM530NsVgsYDMXQQX2SwfqyfizxScVro/g0A7jNXvQTRTH8F3Nny5N
        zlDeJJo79AizOfnRY6j/gxXlJw==
X-Google-Smtp-Source: ABdhPJztWHJvrr5MpjusvGtLLS0KDH1rGm6g2Dc2IdWXeFlCnEYhTsi/QSA21kCKx5j06NDLCjZuuA==
X-Received: by 2002:a9d:62d4:: with SMTP id z20mr918565otk.305.1628105342003;
        Wed, 04 Aug 2021 12:29:02 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t24sm544509otq.66.2021.08.04.12.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 12:29:01 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, konrad.dybcio@somainline.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable Qualcomm MSM8996 CPU clock driver
Date:   Wed,  4 Aug 2021 12:30:42 -0700
Message-Id: <20210804193042.1155398-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSM8996 supports CPU frequency scaling, so enable the clock driver
for this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c7cf0d1ad34e..3bf6f8a86aae 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -974,6 +974,7 @@ CONFIG_TI_SCI_CLK=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_A53PLL=y
 CONFIG_QCOM_CLK_APCS_MSM8916=y
+CONFIG_QCOM_CLK_APCC_MSM8996=y
 CONFIG_QCOM_CLK_SMD_RPM=y
 CONFIG_QCOM_CLK_RPMH=y
 CONFIG_IPQ_GCC_8074=y
-- 
2.29.2

