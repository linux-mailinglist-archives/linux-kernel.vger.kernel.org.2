Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E9730A75A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhBAMPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhBAMPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:15:00 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2753C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 04:14:19 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id p15so16273622wrq.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 04:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0G9x29ODayyoEjGhdJzqiDx/sbh28ndUxLSuBK0gkBo=;
        b=Eehqg6mFJjzThcX5yVYlkRRPhFEandBN/vOqG0HKP8bsQ0BDqvlFYWUUW+MXY7HT+I
         j6k1xmqlQZFNBcYwzi67eo4HPfQhYNGpJThOiEvpeRRiAqH6mHhdxkQTCcqehCTjXjxs
         zV13Me4W+I41pHz2PRuYRYei6yMmdmaHD3nEICrL4nd1BO0AGjc0qdrk1u9zd6NSEYUc
         1NawBVehTnQdjI0kEx27WZ5ubAdlsx5KS2A4NWrsxQcl51jkKn2+nmJl4HINnH5mTeuA
         NiQYEvKzdw0GQqOjEaRecplBa2rSEBd4xBzlgnuJeV0JltvCED0+rjN8RcKGE31UgAaF
         867g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0G9x29ODayyoEjGhdJzqiDx/sbh28ndUxLSuBK0gkBo=;
        b=OEAAAyCtMZSRVbWQiE9s5RgYRTNwxKlcWNeUvpPKpjxNNiSPKavbg8BjYIEttOzSoq
         vKZeb6FbyHDkIvAhZ8zGhxsMcptd4BSC34QtOw3t14/VSd8y7Xlh4ElHnOAHTgpazEOR
         az/9JWBKoUKW/ov8K+4mN/9he2iIF8NsqiKqxHII9CYucR8Hvjjd7f+ZNiFL/AsAeE+j
         P8aHD5oVUcbVt/aegPExtVM8OSS8SiwfjP5jUdVik2KEHVn3zsSqhD/8PPfarU5XiHul
         7P/1Hm37gRK+evb8K9ogze9+iwaU/69xIZufHJjAwtN2/vcX3eq2903SOSOdPv7xCsXW
         z9bA==
X-Gm-Message-State: AOAM530reLT5rC+I2AzuaLPdaP6e53pDFx8KsOzCDzLq01pZZFTAKDpi
        47Wkxzx9KUyZxGyL+PyGRHg=
X-Google-Smtp-Source: ABdhPJx8LIEpPzcTp1mOi1bbjhVYmEG9rMDdQ13+9KZYOiZxoqvtPAxBaAn1r/shZYUsQBKKC8wQKQ==
X-Received: by 2002:adf:dd45:: with SMTP id u5mr17596132wrm.392.1612181658737;
        Mon, 01 Feb 2021 04:14:18 -0800 (PST)
Received: from localhost.localdomain (cpc141888-watf13-2-0-cust663.15-2.cable.virginm.net. [86.14.42.152])
        by smtp.googlemail.com with ESMTPSA id j13sm20698332wmi.24.2021.02.01.04.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 04:14:18 -0800 (PST)
From:   Bilal Wasim <bilalwasim676@gmail.com>
X-Google-Original-From: Bilal Wasim <Bilal.Wasim@imgtec.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, enric.balletbo@collabora.com,
        hsinyi@chromium.org, weiyi.lu@mediatek.com
Subject: [PATCH v2 1/3] soc: mediatek: pm-domains: Use correct mask for bus_prot_clr
Date:   Mon,  1 Feb 2021 17:14:14 +0500
Message-Id: <20210201121416.1488439-2-Bilal.Wasim@imgtec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201121416.1488439-1-Bilal.Wasim@imgtec.com>
References: <20210201121416.1488439-1-Bilal.Wasim@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When "bus_prot_reg_update" is true, the driver should use
INFRA_TOPAXI_PROTECTEN for both setting and clearing the bus
protection. However, the driver does not use this mask for
clearing bus protection which causes failure when booting
the imgtec gpu.

Corrected and tested with mt8173 chromebook.

Signed-off-by: Bilal Wasim <Bilal.Wasim@imgtec.com>
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/soc/mediatek/mtk-pm-domains.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 141dc76054e6..7454c0b4f768 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -60,7 +60,7 @@
 #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
 		BUS_PROT_UPDATE(_mask,				\
 				INFRA_TOPAXI_PROTECTEN,		\
-				INFRA_TOPAXI_PROTECTEN_CLR,	\
+				INFRA_TOPAXI_PROTECTEN,		\
 				INFRA_TOPAXI_PROTECTSTA1)
 
 struct scpsys_bus_prot_data {
-- 
2.25.1

