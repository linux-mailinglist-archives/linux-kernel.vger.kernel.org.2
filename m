Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BDA36FCC9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbhD3Oql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbhD3OqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:46:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B15C061349
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t4so22343937ejo.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vvsMkKSxObWfrYf5zpIINvfbNjNueuFKMoVjdC9Jfxw=;
        b=m0KOGYIA5/VfFfq0uaQiUbOwOrfPt4Be0Hh7t9woZUoxBVwzn09M+XN8NfSdKiSVJw
         MVW3zN0MS8SDIy5v4SSL8lEJVtDSWSRcQI6MG0qWUaX514JuEBR69w37uOaLquPCWLK+
         ezcX0DxUgjCkYH32KcBfRwhYk+mLAHXSUrAXdDgdRMXBdIN6FzcLQbcwQAD/nG/4HLHE
         xzqnPHfF5NpKuNfak6Zr39S2RXbh/GLCOdal3LVFF8x8+Xr+WtPYbtpD7Dxy4UM4D7Ca
         +Yih+9vu8umYwI9ymEvdLrSgx3mhWxp0qaP3BWp4C3gmLHwXE9j0kTB00jGjL9rGLkWe
         gyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvsMkKSxObWfrYf5zpIINvfbNjNueuFKMoVjdC9Jfxw=;
        b=SAXgiTf6aAnYx9ab4zEZLLFAgPYRgjI5TqROZUQxyOcl3PFkTkWT+d25xzWCSzKbC1
         De11IdZDW5Vw0Fo5fNJBm59irLU/JTnHcXicwI44nOkc21SnLiQfXQbVKfVddOcVDl4t
         s2YzaJpiWA7F+igUX3ksMNTyUiSn1Dt5snx0+0+TxQI68zF6UF494Q9OCOVhj3utOtS7
         pTI/HqzX7ZK4oJH+Rs0bo8RszfYCOnNfWEFt0AehXgbZYi1KzjRy7bHYlsOdfKAO38pM
         rqg9RIj7OwuNE7dV61mDcpMLO64EP86tKQ69X3BR37pbFyP9v+/3KPKdEaK1U0SesPe2
         mW3A==
X-Gm-Message-State: AOAM531/CKmpO0MAwKHzGl5ZXpPosjN4fMyWP7+Z7EzOq5j150GV1toK
        1cnEhlCsxnVCVk/v92imv7jar0qtEog=
X-Google-Smtp-Source: ABdhPJz4qnedGXiWBOucuM9Gvvu+0eqMN3iz27s5wwFAy8gqk32Xt5JkYDV2vXWt/GGBhLx/SHHeRw==
X-Received: by 2002:a17:906:a006:: with SMTP id p6mr4794139ejy.350.1619793896558;
        Fri, 30 Apr 2021 07:44:56 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id k12sm1388931edo.50.2021.04.30.07.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:56 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 28/43] staging: rtl8723bs: remove empty #ifdef block
Date:   Fri, 30 Apr 2021 16:43:58 +0200
Message-Id: <2e8d7412862296eabbc64f0b5e7f23994c13e36a.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty #ifdef block.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index 9c9ad29870e2..f2793d5d9a30 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -112,11 +112,6 @@ extern u32 		GLBtcDbgType[];
 #define CL_SPRINTF	snprintf
 #define CL_PRINTF	DCMD_Printf
 
-/*  The following is for dbgview print */
-#if DBG
-#else
-#endif
-
 struct btc_board_info {
 	/*  The following is some board information */
 	u8 btChipType;
-- 
2.20.1

