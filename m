Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A257398D06
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhFBOft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhFBOfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:35:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CAEC0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 07:33:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v23so2533432wrd.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+mad90AtNlCIQqeONJLgwNjgy3qTN43q4JqhckiOfdA=;
        b=ExgmwiJMlS0eRraN2kHbb0Ihbru+U+mZwxjE9wzZHHKQkqrHsrk3enpg1hFU9j+oDL
         ekIU7tjAs5rhizmS3T2H0X969HshiCtOYtJ0HEgwm4sbKX/J3QPaX0YBHw68X3GxyOf5
         /0mWlLkzvVx1O/vvv/9xmiqVEjdCmd986lpGHFOeOA6wlyZHO/FuPTdOb+rlGP0c+KG/
         4tiRvZU2Q0johCTwk70k8ziUMQadlY1ZTPyEJzgcMWaniqYTBhLjlH/GkXdMU4UYbL4C
         zFo8vutbbvWfUI3BSjNb53fqs46HG7mY4fOzcxK9EDNns6B8NPr3lP4u5vA2PF50FHPh
         x9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+mad90AtNlCIQqeONJLgwNjgy3qTN43q4JqhckiOfdA=;
        b=GpAfVG6+yHOHqE3C8h/1XDofOV5DdLbIn1Rm5BlW2BQL/0xfgs88eRrZaFs0seeJUB
         4mTBhwV2XtSBv8O1pVbFQOyXVklV9sdq9T5tFBMhvN4+FI2MkuuFY2bYDCm8ZjoHmLr6
         YSNDuWDX0u2HHoW/tVuG+x7nMrGgpi7mG3E0eoBaO0RA1lIpq7pgUggogaVpRLF/+rAm
         CesYg2euguS0uDUZITaUmCDTJZXogekd7qhFDKbidhhd9Apr5rnH71Jm4+Swd1q9vAtK
         s3ufyxXL77MP0rU32SSEJMRpUXsB4im+tKyNehDadnvPZFIxsOzrujkTqnHNnAry5694
         oYPg==
X-Gm-Message-State: AOAM533rDRea4mu4tk0vgTDuL79hHHLuNtvXtfXuiWo1IMaONdyuo4Yb
        6CPPqZjqpcmr7w/hYS78pU84tg==
X-Google-Smtp-Source: ABdhPJxJR+DAmRu3LRD0lFSDK005qWO7ULh1N0b3KxxqVF1PwKK8vsdmXuNc8EdYh1jdRA5kCHa3Ng==
X-Received: by 2002:adf:ea86:: with SMTP id s6mr27047293wrm.75.1622644410937;
        Wed, 02 Jun 2021 07:33:30 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:30 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org
Subject: [RESEND 20/26] drm/panel/panel-raspberrypi-touchscreen: Demote kernel-doc abuse
Date:   Wed,  2 Jun 2021 15:32:54 +0100
Message-Id: <20210602143300.2330146-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
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

