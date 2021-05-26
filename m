Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065E13912F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbhEZIub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhEZItc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBB1C061343
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:48:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p7so180288wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+mad90AtNlCIQqeONJLgwNjgy3qTN43q4JqhckiOfdA=;
        b=rDtWdIyU6k0Cu5EI0Xlh1Az0oi7vs4Rth10DNmiyY6J6hI++dGQgjhk0Ys7zL9Zffb
         4njHjsoCQFlwcTujCSBLYl/jQKTw9l/Fc7oYmViTqq+nSag3QAXqaW1PWbx7mA724IrN
         etOcBgE3E4D4L7jpS9zuUTeLSizvoLtiNbXFR3BYha4kSt4fXo/bc+ubcSigbUFa7J8h
         6f0XO14rRjVWzK5KGbVgkPdQICuiMB/Eth5vyt4C3DTWBpC9u7qhl5G1/EnhNo+eNPQc
         ahnftmb6732uEKdskUfq9+EkUKctnVZXLnSi7quTT+3ewG0j5rJqHVAt/3GZ2436Yldh
         tbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+mad90AtNlCIQqeONJLgwNjgy3qTN43q4JqhckiOfdA=;
        b=hYHER5MnPqImldOFZ+irHYoAagPKei7st5P6eMNZdTGc69bXdwFsVajzPPDjFVrH5x
         9KZrKZi6bIv3JOQX/JPX3Nyjb6WMv48Rz4SnHoWzaHVv0OTyxtPokfoZ13U8Lr6ggcUV
         5PKqLusPfLO/SvmeNYjK9DeUwdW/zyJrSXhblPI0cV9UBnpW0/4aGMTWyOvX8jYM16H2
         0yEV3zQ/kT4LjIbeQAKUiDms/HNLot2PhXW1lVk7hP7G0uxBOYdfN+MRwSDFw/PkPzpZ
         k+QMUD6Gb3ngICnPnUdFV41q7X4BxwwEJR151LyDPWTPrV2wSKDGoP3ah0EwiUG1myyy
         OABA==
X-Gm-Message-State: AOAM530sZ7k8Q3GPiPr7e5oH41IrP9j43gxb80rBc3wGBnrgjhRQmEXn
        y/PcJhpCKlntke6t7VShOJF4+Q==
X-Google-Smtp-Source: ABdhPJy2slfQ3QCAf471u3XJ0KZjA6HRnV8JDSY7c/reI6yg8Wjtmsz0gglvZK/wgOQqkD9TjiZs0A==
X-Received: by 2002:a5d:678c:: with SMTP id v12mr32334508wru.246.1622018879881;
        Wed, 26 May 2021 01:47:59 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 28/34] drm/panel/panel-raspberrypi-touchscreen: Demote kernel-doc abuse
Date:   Wed, 26 May 2021 09:47:20 +0100
Message-Id: <20210526084726.552052-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c:33: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 5e9ccefb88f62..2229f1af2ca8c 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -29,7 +29,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
-/**
+/*
  * Raspberry Pi 7" touchscreen panel driver.
  *
  * The 7" touchscreen consists of a DPI LCD panel, a Toshiba
-- 
2.31.1

