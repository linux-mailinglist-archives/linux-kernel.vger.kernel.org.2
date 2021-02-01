Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3083C30A1A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 06:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhBAFtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 00:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhBAFqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 00:46:52 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3F2C061786
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:45:46 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m13so15191332wro.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9xqpeCBfVk8R05gxk9ASEmNGjJ7u5/VBiUnlJBQKPVA=;
        b=HeEiP4EKNiLQqx/eMp7WsrTlFOoIrvTk4jz31ZbAovOdGS9mO2+TsTuQgN0zsRIqtn
         YJYsh1fSX1tXL1PX56dwqQb16PHIkbvuAqJpQevRtdbqTYtbgWI65ddse4zgQcbh1UCV
         REQSDmjynovnXAV+5PC3xOei2iLreX67YQU9IP0FrN+F6hm99Fy129BzTlyWmbeQo3qJ
         g31GUYGJxoMviG6LpB6NZEctMJFj2391v4DsYv4l+1/I/T0f9tY6j8nNSjDhP9aN4W12
         noYjZ7OZHkty7UZIqVnlYJ1hw+PI5AjG6jT0ujpS6btcgFVdjgFxAJR+zDPzMRbTABem
         lPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9xqpeCBfVk8R05gxk9ASEmNGjJ7u5/VBiUnlJBQKPVA=;
        b=XtIyyH5f7hQg6AmSlsXHXLysnZq9PMQkb5nP9IlkCwrOoO9Jxwsb+9J7MTor5Zhs4N
         s+MFiikSpNQoPrQ/4cai8oB9Sx4jToLl0WwHGGKYDAkthwl+PZXAxTRvPtClc8dj/1EQ
         oopYxiaaY8DvQx2+0/Is+BCju9FTo68CGkH7GkxZeEZJb1ICT6iBiozJU07GM0EoRMor
         PzEAHJ99TSJI93uL3b/dlG3M3Kc/0ASHSfBOK3k9Pv8+e6Ilq2xRiW99bNWKcPVAc8gp
         w7nWpZ55Z/jej+Ba52iV4u2gl03Lxj9WtooNdh2lCY6T4Uab5US+yWrsAgqSeXZI97jU
         TW4Q==
X-Gm-Message-State: AOAM531lwdlIL3jIO/q63m3fpfxUPNij06gEm3wHRGyzFBAqnxso2geD
        sLL4BdBBOZqRchJxCEGFMZQ=
X-Google-Smtp-Source: ABdhPJx5/3HJTSnShyp3E+2DkQGoHwNB07bsPh2NWECRc1vYO9mVW+Qbk+SioZbcANp+tj3990m7wA==
X-Received: by 2002:adf:9f54:: with SMTP id f20mr5611294wrg.362.1612158344996;
        Sun, 31 Jan 2021 21:45:44 -0800 (PST)
Received: from localhost.localdomain (cpc141888-watf13-2-0-cust663.15-2.cable.virginm.net. [86.14.42.152])
        by smtp.googlemail.com with ESMTPSA id r25sm27123540wrr.64.2021.01.31.21.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 21:45:44 -0800 (PST)
From:   Bilal Wasim <bilalwasim676@gmail.com>
X-Google-Original-From: Bilal Wasim <Bilal.Wasim@imgtec.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, enric.balletbo@collabora.com,
        hsinyi@chromium.org, weiyi.lu@mediatek.com
Subject: [PATCH 1/2] soc: mediatek: pm-domains: Use correct mask for bus_prot_clr
Date:   Mon,  1 Feb 2021 10:45:41 +0500
Message-Id: <20210201054542.1470695-2-Bilal.Wasim@imgtec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201054542.1470695-1-Bilal.Wasim@imgtec.com>
References: <20210201054542.1470695-1-Bilal.Wasim@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When "bus_prot_reg_update" is false, the driver should use
INFRA_TOPAXI_PROTECTEN for both setting and clearing the bus
protection. However, the driver does not use this mask for
clearing bus protection which causes failure when booting
the imgtec gpu.

Corrected and tested with mt8173 chromebook.

Signed-off-by: Bilal Wasim <Bilal.Wasim@imgtec.com>
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

