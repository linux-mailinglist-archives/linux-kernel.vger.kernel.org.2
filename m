Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE03B35F9E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351013AbhDNRaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350752AbhDNRaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:30:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF94AC061346
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:29:40 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id r13so6838408pjf.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70dSAhdvNf9rW7naVyB8FacZo/tKpmgYTIzZpzN71Cs=;
        b=LsiMLszNVSqTMFSOmT7Vt7BL2HWjYpQnn9/Ah8Ahmt14VXi38iwnxuRRnAMd7nV+F4
         L8OiYKIW4vYpw8N0fUeTwgUCiDMq5+HbPF+3sOym2H36ZFwtvq4PnCKSeplaTzdczwh+
         M1/M+ijlrnFtXNjeEsgG7aN63y8Ce7LLt8uSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70dSAhdvNf9rW7naVyB8FacZo/tKpmgYTIzZpzN71Cs=;
        b=G6FBmg8po7Sj+hKysMgPOn5Pcvn/bRBAM4jmIz1Bp0YlnOcXwf/iVGiG+26ycIp2yG
         tffu0+0Qp8Dw9WvjQ0/463N1ZToAnUsGAEObOUUSxr8n+v73NDw5XthUYPu9G4U40o3M
         rDS7SLq8837utDFqYnldwKQu3B/arQElLTBjMO1HCpotsX6s/713yMjTzr5uq+pS1+4m
         MiWQ0CIo6za0/KXnWYW5BAt/qdIOlThvc/suOdtcMNy6PQgEGF8blkURrPvHwkkOy1+p
         spTYj6FYs/xMAK10ghstFHgirQR2oDeymrVusxxUF6ZvYbtwf1V6y3JqS2fWyh2u33cW
         4tJQ==
X-Gm-Message-State: AOAM530H212q9VesZ+nI/rMfaaPV7As67FYLW2EUPunHJIBc45qGHREF
        afVIWxOUceJZbVVR8qa2dLGiIKRqF18uug==
X-Google-Smtp-Source: ABdhPJwqy6xfsxSkXZwh4yhPlR+yx5Kxrr/lleQqawAAaqaYA9AZc2k7rgE80MSaJDQAOD1ejSDS8w==
X-Received: by 2002:a17:90a:ca83:: with SMTP id y3mr4896192pjt.191.1618421380273;
        Wed, 14 Apr 2021 10:29:40 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:bae3:4af0:9792:1539])
        by smtp.gmail.com with ESMTPSA id e31sm63460pjk.4.2021.04.14.10.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 10:29:39 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Wolfram Sang <wsa@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-i2c@vger.kernel.org, Qii Wang <qii.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v19 6/6] drm/i915/selftests: Rename functions names
Date:   Thu, 15 Apr 2021 01:29:16 +0800
Message-Id: <20210414172916.2689361-7-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210414172916.2689361-1-hsinyi@chromium.org>
References: <20210414172916.2689361-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_resume and pm_suspend might be conflict with the ones defined in
include/linux/suspend.h. Rename pm_resume{suspend} to
i915_pm_resume{suspend} since they are only used here.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/i915/selftests/i915_gem.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_gem.c b/drivers/gpu/drm/i915/selftests/i915_gem.c
index dc394fb7ccfa..525afda9d31f 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem.c
@@ -94,7 +94,7 @@ static int pm_prepare(struct drm_i915_private *i915)
 	return 0;
 }
 
-static void pm_suspend(struct drm_i915_private *i915)
+static void i915_pm_suspend(struct drm_i915_private *i915)
 {
 	intel_wakeref_t wakeref;
 
@@ -116,7 +116,7 @@ static void pm_hibernate(struct drm_i915_private *i915)
 	}
 }
 
-static void pm_resume(struct drm_i915_private *i915)
+static void i915_pm_resume(struct drm_i915_private *i915)
 {
 	intel_wakeref_t wakeref;
 
@@ -152,12 +152,12 @@ static int igt_gem_suspend(void *arg)
 	if (err)
 		goto out;
 
-	pm_suspend(i915);
+	i915_pm_suspend(i915);
 
 	/* Here be dragons! Note that with S3RST any S3 may become S4! */
 	simulate_hibernate(i915);
 
-	pm_resume(i915);
+	i915_pm_resume(i915);
 
 	err = switch_to_context(ctx);
 out:
@@ -192,7 +192,7 @@ static int igt_gem_hibernate(void *arg)
 	/* Here be dragons! */
 	simulate_hibernate(i915);
 
-	pm_resume(i915);
+	i915_pm_resume(i915);
 
 	err = switch_to_context(ctx);
 out:
-- 
2.31.1.295.g9ea45b61b8-goog

