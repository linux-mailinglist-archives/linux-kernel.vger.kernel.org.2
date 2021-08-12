Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1D83EABFF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbhHLUm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbhHLUmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:42:24 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE286C061756;
        Thu, 12 Aug 2021 13:41:58 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id m3so3988632qvu.0;
        Thu, 12 Aug 2021 13:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hx5BuYzZPlLV9cghut3Gli/VGI9yvAZxeJLB5iai7aI=;
        b=Uo0SaS5+c2j3JVzxT/dk+lYUMvJcuYKusi9DYRPX72lmSMv5ww48jGaJBKViR4IXFq
         3SY2rQa+xWUpvn6pkxidJGv1rKSPIbooq+NkaSp2tQtOYNS9WeZ7XBtq+VJ3ytjAIsA+
         tQc3WGZHG7tAlt3fmXtlkdqgIks6tSwU/7V4IOcp2juhPsBXYO3X151vhLwOBPMqIaC/
         IhjCAm6ITN4avuSXbr2r3hbF5EmXkmYtFvQwVLIJ4CH1CvhZ0Bq1VMyUVOgOfqNFoDCq
         8HRM5TVIk4dlTfP6udGt0jHNCu3Qbt1zmjOIH5kVxWIcIXV+82NHcyUT82+Q3I2iESuc
         dg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hx5BuYzZPlLV9cghut3Gli/VGI9yvAZxeJLB5iai7aI=;
        b=P9WQrttAVsUNwwQewgACMkbcRkmO0i2lOo1Hsm7F5fpkYUmNxleji1sfLssbWLa6y4
         QBbD2N/6usEg595KD1dEzGFxR2UbhIt/HUi1NfC8je8RNmh4HPcsqAUED+UGGUa1t9wt
         suRbiIXdb3MRu6FuOYE0+UGL6YDOKtXfUoGT3XGLKeYTOBzOGA/dACKmHerg3nLRZsOT
         tQM+L66YL8hC2uA46LkRZPrqMymx7RskDsEO40U8w1l6inN+jEtdmAi4/ZrxGKgpadPw
         4AbgZYxwjKkrA/V3IK9u3O7CANif+4Ax0havt/XuD6kWl5NhwXQgyx1OZSd/lQYZdABy
         2cAw==
X-Gm-Message-State: AOAM530aITuPk5HlIB583Op6wjbyqlMMOk/h1yqaVVeb/eCt6POngVQt
        1MGz+Rvdz3fsgNdVICj2Kic=
X-Google-Smtp-Source: ABdhPJzjHPWchl6zyo/ohEEqq2f1YdiTc1K38TF7iQgvhO/0YWaAWT/TrAAEri29ZU6KZ0Hve9zsLg==
X-Received: by 2002:a0c:fdcc:: with SMTP id g12mr5953858qvs.54.1628800917825;
        Thu, 12 Aug 2021 13:41:57 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:e89f:d077:9161:1bd7])
        by smtp.gmail.com with ESMTPSA id m16sm1940361qki.19.2021.08.12.13.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 13:41:57 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] dt-bindings: soc: rockchip: add rk3568-usb2phy-grf
Date:   Thu, 12 Aug 2021 16:41:09 -0400
Message-Id: <20210812204116.2303617-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812204116.2303617-1-pgwipeout@gmail.com>
References: <20210812204116.2303617-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the documentation for the rk3568-usb2phy-grf node, which is separate
from the usb2phy node on this chip.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index fa010df51a5c..78ff91db0f06 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - rockchip,rk3288-sgrf
+              - rockchip,rk3568-usb2phy-grf
               - rockchip,rv1108-usbgrf
           - const: syscon
       - items:
-- 
2.25.1

