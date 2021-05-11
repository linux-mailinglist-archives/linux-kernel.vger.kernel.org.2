Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C5F37ADF1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhEKSJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhEKSJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:09:16 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB315C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:08:09 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 197so19645675qkl.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MC52AvU8yTi/lCNA6BimEkKB2wKFkd/KekP+O2t6FxE=;
        b=Vdz8fvLuCohalVsPL1b+SjeaCADacEduuQntDk85lHx7xeA0WiEWGmwz+nVpIf4Ifs
         aYcNzBmg1200+8EYAvvPiPi2RIUfW5kwW+aSgfIEZIj4kdagjRQx4/sOpFU7W7voOdfN
         e987fvLTeKiIg4QumKnwFQQGPs/iBaMSgZx7v3z1EzMHgwu1jwzblEBuz0Fft+fJSdFg
         BivYC4HejhHRMtfMvPc3YTYYGNNgPoLXl/ONUSN0RjiMZPgBrPZKa7mRjFzLBgKOI/M9
         YGsoy9xIOzxAsUROlX9kFq6RkkNfHYSfnmz6IorxjJfckwAV/5ndTD1hwMmTsvHSsSsK
         Ka5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MC52AvU8yTi/lCNA6BimEkKB2wKFkd/KekP+O2t6FxE=;
        b=bntAPjTRXOhAKY3XvxGQ0IgFTV0sY5xZbMngxCxiJaG79krLjE+c1Crcko6xkf3xhZ
         ykM7lDWJF1m5Pkl0a8yGQwl24hHKnBs0rR5C0zZKlx9puw+8DaRtWno7d5zvDKdXeR2I
         eYGaFsRfDZDNt8UEbrHse4mvg5d8JYhe1Uym8ZIuLBc1aBpAzm3o6KLgcbjg2+ZOkjic
         opUk4Vg6BMZgzHNz52x3/shxhJpg/vgqaLaQrRHzYudjnaawy9Rk3otUukaB9rvuoXpX
         1PauwNWb3jUKO2jhs3VtAUwwdToVCpiAj2PwWhFfibDQRwFxq/yo0mGoEEwUcKYs7KDI
         lmwQ==
X-Gm-Message-State: AOAM530k9frCnH/unp6AJ8lz6toig72baLEABX6ju5BuJDXkQ1Nlj8Sr
        e3sU/fFLrX251FhipAoAvvc0bQ==
X-Google-Smtp-Source: ABdhPJx+SOyMflZBYI28atocWsr1QztLmz98kXzxJdZ4S1QJROf1E3vSxNyUNTTcTcKop+KANu3nMA==
X-Received: by 2002:a37:6714:: with SMTP id b20mr29012977qkc.289.1620756488973;
        Tue, 11 May 2021 11:08:08 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id g5sm17104476qtm.2.2021.05.11.11.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:08:08 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     robert.foss@linaro.org, andrey.konovalov@linaro.org,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org (open list:QUALCOMM CAMERA SUBSYSTEM DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 02/17] media: camss: csiphy-3ph: disable interrupts
Date:   Tue, 11 May 2021 14:07:09 -0400
Message-Id: <20210511180728.23781-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210511180728.23781-1-jonathan@marek.ca>
References: <20210511180728.23781-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does nothing with the interrupts, so set the irq mask registers
to zero to avoid wasting CPU time for thing.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../qcom/camss/camss-csiphy-3ph-1-0.c         | 35 ++-----------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
index 5948abdcd220..783b65295d20 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
@@ -352,38 +352,9 @@ static void csiphy_lanes_enable(struct csiphy_device *csiphy,
 	else if (csiphy->camss->version == CAMSS_845)
 		csiphy_gen2_config_lanes(csiphy, settle_cnt);
 
-	val = 0xff;
-	writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(11));
-
-	val = 0xff;
-	writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(12));
-
-	val = 0xfb;
-	writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(13));
-
-	val = 0xff;
-	writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(14));
-
-	val = 0x7f;
-	writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(15));
-
-	val = 0xff;
-	writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(16));
-
-	val = 0xff;
-	writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(17));
-
-	val = 0xef;
-	writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(18));
-
-	val = 0xff;
-	writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(19));
-
-	val = 0xff;
-	writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(20));
-
-	val = 0xff;
-	writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(21));
+	/* IRQ_MASK registers - disable all interrupts */
+	for (i = 11; i < 22; i++)
+		writel_relaxed(0, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(i));
 }
 
 static void csiphy_lanes_disable(struct csiphy_device *csiphy,
-- 
2.26.1

