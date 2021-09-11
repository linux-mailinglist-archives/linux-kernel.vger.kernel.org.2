Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA804074F5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 05:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbhIKDuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 23:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbhIKDuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 23:50:23 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AB0C0613EE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 20:49:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d18so2375751pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 20:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=DzaIdSdfFubKopkCOrptYgOiLd7HKVfZtJyuoqzoNt8=;
        b=C8UBBiko8kEn/wSOUZVcwwN7OH6XGDrT1X48dR7/CZ7kTBkVKWQu5rR/jHct9gqFnU
         h/gmZWSW2MGUKMqlW7/AA/WhBbDPTc3n1mKjHYCPYj2+0f8ffubhgbjvujGkWobH/uAl
         ATnCNhGYlbPR0TLuymKV1KyJIfIN5aJ8Ry+iBkaO7AtYTR6hnZTJ4Dbi0Rf83N62Y+bi
         eEemDpRXY2M7PQaHc1HZ17clcosVJFGZg76MRO/QeF0F+z2L2QqOo9aQB/qkJn5ctKC9
         plth2//1t4vWhVWIdxFprrxCz92FN+zRf4bNKfPudl2oeQSiLHus29sp6gNmLY7+7jNz
         lJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=DzaIdSdfFubKopkCOrptYgOiLd7HKVfZtJyuoqzoNt8=;
        b=vlgn9LYEF1Qr1lgv1rnhIIyqyxaLHiBgdzBolNKR2wSBf48go1JKD98bEKRYjn+Qdv
         sFkmEZ+OI+PC55NcfOAi3Au5t+SG60ngn+MMzFfyz4W/PL7M5JjSJ4EkHguO9o9RjbrC
         Gqk3jp9vETkatk0HkLFxwVMzCcZVnOycgy4PJm7EeBUsKD/cihT3NddvbuEV6zdrR17J
         n0ds2GNULDgUUEqUuIbkyykGctNLmQXZ2ckjFVMPtB/UTyoE9ee1d7C0/MqlNJHIGcZ3
         6rX1Ms0cWnJxC6jrN9G/5sAuSnrZ7E5CLpyOweUHqnEPHcwrymz+snbbVKYY81CivHvX
         cZkA==
X-Gm-Message-State: AOAM530KyOhAv/HEzR+PHFEImh9s1gbuTpXSFumEDaXoLf1qstovK0vT
        /3MKEn7yxalOMlCQRqQstK6ZMw==
X-Google-Smtp-Source: ABdhPJwvLN8bfHfGluy9Iw3pbtnJt2AuK5+jLiz6yCRmD84GF/OziqDW9kPdqQEWqXQfc8FHYONa2g==
X-Received: by 2002:a17:90a:da02:: with SMTP id e2mr1051170pjv.89.1631332144742;
        Fri, 10 Sep 2021 20:49:04 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n1sm301315pfv.209.2021.09.10.20.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 20:49:04 -0700 (PDT)
Subject: [PATCH v2] drm/rockchip: cdn-dp-core: Fix cdn_dp_resume unused warning
Date:   Fri, 10 Sep 2021 20:43:18 -0700
Message-Id: <20210911034317.1719619-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     hjc@rock-chips.com, heiko@sntech.de, Arnd Bergmann <arnd@arndb.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

cdn_dp_resume is only used under PM_SLEEP, and now that it's static an
unused function warning is triggered undner !PM_SLEEP.  This marks the
function as possibly unused, to avoid triggering compiler warnings.

Fixes: 7c49abb4c2f8 ("drm/rockchip: cdn-dp-core: Make cdn_dp_core_suspend/resume static")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
This is breaking my builds and looks like it'll land after -rc1, so I've put it
on a shared tag for-rockchip-cdn_dp_resume-v2 which will let me pull it in to
my fixes.  LMK if you guys want me to send this up on my own, but I'm assuming
that the drm/rockchip folks will handle it.
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 8ab3247dbc4a..13c6b857158f 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1123,7 +1123,7 @@ static int cdn_dp_suspend(struct device *dev)
 	return ret;
 }
 
-static int cdn_dp_resume(struct device *dev)
+static __maybe_unused int cdn_dp_resume(struct device *dev)
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
 
-- 
2.33.0.309.g3052b89438-goog

