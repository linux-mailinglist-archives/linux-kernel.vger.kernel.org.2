Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC083546AE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 20:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhDESPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 14:15:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33078 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbhDESPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 14:15:34 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lTTl1-0004pb-C3
        for linux-kernel@vger.kernel.org; Mon, 05 Apr 2021 18:15:27 +0000
Received: by mail-wr1-f72.google.com with SMTP id o11so8650827wrc.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 11:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MLkw/W1VWG6EFfaPc0X5WGBh7Sa2+Rr55CF9ZvrmlGo=;
        b=JuBlqkVdF/9ZnShpkBq/nd57Dq4QeRuyPC4ThgM2mWctfaOoaLoR+tTMOktY+1jvCf
         AvW95OOG/LOd8Fobnzu0mZgrExtd8G6ReAsY/0wqOGM8WVlJuFr+7FUtat/XrQYX5fii
         cWvWb1Ya+GqJ9yeaCc2XJ5yhhrzJRfY5CUBhlr66fSgZe39um0GZ5SmWkMkGsgJrulko
         BKJoQUqEciuImP3Vt7YiT1ki4Z9OFJSw7JiKUVla1gHvDCWMwknQJ07BN9v51IgN4M0b
         IqL46h6m4Od3AMnjewF/TL2TplHUkneYLPALEHuIoNuyRyqpWl4/Y5Sb0aA1jjV6YGvy
         b8Mg==
X-Gm-Message-State: AOAM531xucZOTYROGmpO8vR+kDKMAy7MIKOKmjHwzTf/uIk4coIeCuVV
        SY9gnlT42inylVk0w5uaoB1ztvT7qSFK5EgFsIqnCjzYXT+iN5jNlbjnlwSBrRJkQtOlLYQNE7D
        kZ5Ujq+Ceb8Z2GaQ+/XtswMgIs2LSbhfePJjy+p9N4w==
X-Received: by 2002:a05:600c:3594:: with SMTP id p20mr301456wmq.173.1617646526996;
        Mon, 05 Apr 2021 11:15:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7mZ+bLz94q3v3cBPpPKjuOK3slg8uVtnf/BhAOY8wOnY5kSV0Phjy7PdABD6JqdP+P4BFGQ==
X-Received: by 2002:a05:600c:3594:: with SMTP id p20mr301443wmq.173.1617646526872;
        Mon, 05 Apr 2021 11:15:26 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id 61sm18298925wrn.25.2021.04.05.11.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 11:15:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/exynos: correct exynos_drm_fimd kerneldoc
Date:   Mon,  5 Apr 2021 20:15:24 +0200
Message-Id: <20210405181524.52426-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the kerneldoc of fimd_shadow_protect_win() to fix W=1 warnings:

  drivers/gpu/drm/exynos/exynos_drm_fimd.c:734: warning:
    expecting prototype for shadow_protect_win(). Prototype was for fimd_shadow_protect_win() instead

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 49a2e0c53918..ae576122873e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -723,7 +723,7 @@ static void fimd_win_set_colkey(struct fimd_context *ctx, unsigned int win)
 }
 
 /**
- * shadow_protect_win() - disable updating values from shadow registers at vsync
+ * fimd_shadow_protect_win() - disable updating values from shadow registers at vsync
  *
  * @ctx: local driver data
  * @win: window to protect registers for
-- 
2.25.1

