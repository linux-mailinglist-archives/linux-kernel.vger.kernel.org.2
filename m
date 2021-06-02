Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BF4398D1E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhFBOhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:37:12 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:54976 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbhFBOg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:36:27 -0400
Received: by mail-wm1-f52.google.com with SMTP id o127so1445680wmo.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ggE8ksbwsKIQV0Iz58/vSuT7hydgMXkIFUzJg2iRL3g=;
        b=j1G7oiOUGHpTTpz7N1iwCK31eRewhRnoAF2xf8UwzdvPqQglJHQm5wgoBIQ6wjwMjg
         q+7qtBtnoyK12VxJOtlQOffmMwgKbTIuSsCd68GxxfeKwYjeWzIsYGzSEVDq2HndGIUb
         s0CfACPN1haeU3M0PD3alT3nwpJs9FIPgQjWXh23qOIpQObjaH8OUA3kWOxCOAWVj+E7
         2W9MnyRFUEmy6xxuzqsPyyQ3tox+X6w7nOqTZ7BSJUVFprJlOmAmTG+6GciYpvGRtIcS
         P59EGzETOn/uvHje/qBYMvMjNLgD9tTLbcKTSAizUGThSDsa/RcOaV+T8FOJGiJ8ozDS
         dulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ggE8ksbwsKIQV0Iz58/vSuT7hydgMXkIFUzJg2iRL3g=;
        b=kWcA6doacTZVggn2Su4MgLGmHbfdsxlT7r2m4A3RJSRLo7Odf4q6BXOwO+jw7d62om
         oXClKE1yv/Feq5Z8kn1W+43SEOe9TXCeB+J6IFLs4CUU+n5Dz596VzelZxc72PqJ+pbw
         zCgw8wNf1oHUNH0TgZZ9Tn8ZtHzkNE5mZ4ABFczBu7zroAxjLyUteQorDAbrboBmqPq9
         mKH/QGFQWiHFACOnLSEeAbgQuNk5E/lhEJDMAundUNKJ070JONNoqWRKEYbdKo1XbOD3
         xWzEYiccTwhwVlFDvZ88pVubMBO21Xxe2fTZFthvdyBw1xZlqbpS7pIpKrQ7eOpwNnQc
         9CUw==
X-Gm-Message-State: AOAM532RiF5vQmM6TZQ/BXOrJquXc+VBh1kZngIc2Pezf9033eR79uu9
        Pg75+Rv7fthOrOKSBlU6nvjhKcT4A+e8Ag==
X-Google-Smtp-Source: ABdhPJxuui5QGQFjB6ghdF42kN+HT/+I/xxE44H9hpyRue/mdRNGI3/PcvlzK7bQqwgrsMF4W/P4qQ==
X-Received: by 2002:a1c:a7d4:: with SMTP id q203mr5573033wme.39.1622644413721;
        Wed, 02 Jun 2021 07:33:33 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Akshu Agarwal <akshua@gmail.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [RESEND 23/26] drm/exynos/exynos7_drm_decon: Fix incorrect naming of 'decon_shadow_protect_win()'
Date:   Wed,  2 Jun 2021 15:32:57 +0100
Message-Id: <20210602143300.2330146-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/exynos/exynos7_drm_decon.c:355: warning: expecting prototype for shadow_protect_win(). Prototype was for decon_shadow_protect_win() instead

Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc: Akshu Agarwal <akshua@gmail.com>
Cc: Ajay Kumar <ajaykumar.rs@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/exynos/exynos7_drm_decon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index 431c5d32f9a47..9b5e6f94e5585 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -344,7 +344,7 @@ static void decon_win_set_colkey(struct decon_context *ctx, unsigned int win)
 }
 
 /**
- * shadow_protect_win() - disable updating values from shadow registers at vsync
+ * decon_shadow_protect_win() - disable updating values from shadow registers at vsync
  *
  * @ctx: display and enhancement controller context
  * @win: window to protect registers for
-- 
2.31.1

