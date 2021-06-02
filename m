Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C98398CED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhFBOfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhFBOfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:35:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D59BC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 07:33:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n4so2556119wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMk1TNRyjEkKfMz8CVM0q7dVL5MOXxkVaJNdLWr+qvs=;
        b=ayCwXdOagW91dL4geRSSIvnIoAy86Hw+zvDhq8hVyXqOhpdz6XnC/vzBQeIRDy+wlr
         dG84f/OXE+BKJ1dq68TKWtirOA9ai92ZbczPg2Ymw0FxCLRRfPZ45fDP9yQ5vTweuxvA
         J8/gVUsJy/tJPAiJBDLOSiEndiAZ9+Fv4X5M6kMqT5PVlYWZsnKgMFma7iwMyYQS02qx
         iU24y4Kfsm8O9Qclj31wnRtZ/VeHfg/J6l0iZUJM5RipSOUUuMbSccDzfdotqZYiQSRi
         SN1rDPmp+PimibgpfQtWz8X4pD7tHebO8silLsR1u4KY89QPdSkjYyakOc8D2fGohhxA
         VuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LMk1TNRyjEkKfMz8CVM0q7dVL5MOXxkVaJNdLWr+qvs=;
        b=iyvxp/EIL1G8G34B8nLsTWr/6Pf9uVk/P3FmcHYXvaTzjNKKwSNzmuo4aAaM2S3YDZ
         Sq23H2EFHByp8b3mR5floE0/pqxpgShs+aV/8JmmxeqcjKAG6wwZevQ4nPLl6dTBJIN0
         sKJpmThKWVWZREN8r2ZVqTvIOR/zGYVkJg/NO/gbEIDpWW7rbBlIXQfhpItpIDMLILje
         9V4t/vN2YPSlMWsCN0ZYBQss5KmabLJflu8dpRWYEhOrJaaC2LvWWV1gmTvPKJX3Apap
         jilAtVxDhcF8iw0i0tSH9qBprXgwSr1ZPXOVqZC8XTu6dnpa/ydfrFU5TSl9qJZrKgpD
         ihVw==
X-Gm-Message-State: AOAM532xngewdun8jgYjoS5YwowqcciQ3HERl8q6te4V+HItfc4TJu3o
        DJuUYbxhdD+OuTXNNWsAOc6eBw==
X-Google-Smtp-Source: ABdhPJy36YCMrmcz7kEQrnj2vN6WxprS9/r3ZzMpDck/Tqk9lITU0jhcTqTjWCIH0Nh9IhtVqvOUKg==
X-Received: by 2002:adf:9dd1:: with SMTP id q17mr21515165wre.402.1622644404009;
        Wed, 02 Jun 2021 07:33:24 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [RESEND 13/26] drm/msm/dp/dp_catalog: Correctly document param 'dp_catalog'
Date:   Wed,  2 Jun 2021 15:32:47 +0100
Message-Id: <20210602143300.2330146-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/msm/dp/dp_catalog.c:206: warning: Function parameter or member 'dp_catalog' not described in 'dp_catalog_aux_reset'
 drivers/gpu/drm/msm/dp/dp_catalog.c:206: warning: Excess function parameter 'aux' description in 'dp_catalog_aux_reset'

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Chandan Uddaraju <chandanu@codeaurora.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index f4f53f23e331e..9ba75b994595d 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -193,7 +193,7 @@ int dp_catalog_aux_clear_hw_interrupts(struct dp_catalog *dp_catalog)
 /**
  * dp_catalog_aux_reset() - reset AUX controller
  *
- * @aux: DP catalog structure
+ * @dp_catalog: DP catalog structure
  *
  * return: void
  *
-- 
2.31.1

