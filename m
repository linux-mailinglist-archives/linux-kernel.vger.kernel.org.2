Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7343622EB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245125AbhDPOkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244292AbhDPOi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2C1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:00 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e7so32475660edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tnd3CCiOTU6oRai7K6vIdbIrWXk2JdXqV/lmbbBung=;
        b=HI74TewrvzX00NmCH+IL7CJ5pNK8/FG90QDJLwNNOsPf9pK80IK3XLopWTolQGqBZ1
         l66Xp92uOfThrHapM4RL52WP+Tq1/QZ7NhDl+vJ7vTV/FnlP18Ut2bi7+pjHFLgIonM7
         L8TdNjsCTalQdSV76CluMM3eewdeJ1xo9ZwVD4YYFnQtbB5wxsFnJ2X1msTClEX5Ihxt
         62RZuzoQpM/TWMVjiY8gkLu4AA+Pc6HKNrDi4bde2w3MfbVJkohMJ588/36cL5+Axbjl
         R07gelnAn7ICrYX1Lxn3DyUy5kX4gGvWOVmBkhSZoAH80jX37IxAVa92M6SURCDPTXMM
         Wc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tnd3CCiOTU6oRai7K6vIdbIrWXk2JdXqV/lmbbBung=;
        b=hGYylbOhxdNDj0/owG6cjXX7Y5uCSgZdY9VE9atSgl1DNxjK9+nZkIk8cn8SR9sBpf
         /ZPWk5P95juIyUwt8ivcDj2jauo7QqYW9g8plFrysQFHwrehGsYUelIwHt1BCjm1xeZ3
         DLFw/jVCAuH/WJdZ7ZPb3yxNslJ7UlZVTXiN1Oe0P0oJeHGKeW0ZT4s5f3o/rPHVBOl/
         KjBXR0OKwSRM5h3X2Y9M/8G5Xehl96ycqJ6eJVsLcR6N+p3ukJhvoHIhh5hpz//vHOtu
         DLIV73I0KeoQHoOTT0mloBFSIA9QbMvWvBN+cdTRrI/4IWpdjAQcpm3MR8f0GyCUiUuC
         +wTQ==
X-Gm-Message-State: AOAM532m9qRXKyXjiWByOrarJGl6swT6twSd4BHZQY7wrPCN6T3irdV6
        qYaFyVpW+tfYMMoItALzy3IJsA==
X-Google-Smtp-Source: ABdhPJzOAqEdWjMEk3fAEKmtY/yRpSZ10LT8MjLqMMrqvYXPj4js3DUS3SKLuNiq1CnKaRGz62pd3Q==
X-Received: by 2002:aa7:dc0b:: with SMTP id b11mr10548194edu.124.1618583879454;
        Fri, 16 Apr 2021 07:37:59 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 28/40] drm/panel/panel-raspberrypi-touchscreen: Demote kernel-doc abuse
Date:   Fri, 16 Apr 2021 15:37:13 +0100
Message-Id: <20210416143725.2769053-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
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
2.27.0

