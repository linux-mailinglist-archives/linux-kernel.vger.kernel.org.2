Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0B741D110
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 03:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347677AbhI3BqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 21:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347576AbhI3BqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 21:46:22 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC45DC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 18:44:40 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r75so5569386iod.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 18:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sSTf0Q/LqQFqSVoi1ntGqPxKXQXY5qANDX1ffBRmmsM=;
        b=c4yT+CLntdEApsVzbtbC2+/1txS45LvbG1+GK/cWy2fNCvoCC4B0CTAFHPHYDHRYhj
         Hk2OK4IewfhhhcHz9StQFwVs6WHxBLxuGNj6DlEVW7Vif2P9zxVJyevS21QuLkPkJ+LQ
         CqQ/ml4bq50TCEJFB/FHPU0VLXB4qauHEEmO8ET8wZ+4uUEYYDDtaBR34KF0hnrFR9zD
         SNspkOC9Y7zm6lvKkxGWHW80ptraXCWySWRTwM+NBaM2SEzO9e7rwuRo6ZlT7R1wvN8J
         Sfp/ZbOdowH2EROCSxA3sIwoWklYZApgw97r9Q5HpkWBM/QD9VOhvPIqJSVVR1u0/sGa
         pzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sSTf0Q/LqQFqSVoi1ntGqPxKXQXY5qANDX1ffBRmmsM=;
        b=VMcWZr1VSVkZSE8nRzvHuIl+bb547NvZ+CDnVV1LFgsD4PR5yNE6PUr3O7/dHmOpvM
         sANZU/tR6Qr+zez8piNnv/P6klDpc6rBUxjKJSoNlHy7NH1s5Vsny+AjhVvycmI0ULcg
         /qequdLPii1l8mEqFnkvBR2hCbnBwyI710pBSQpmBaNvitf92m5ORAe56+C0m6Sy3JoN
         3x6ADMztTYfs74SY89KJZjb+qSKcPLeMZncGXDnADseSW5qS/i+fM0Wflf5Ua5DdL3d9
         Baprc/XVwUFdvEMl4Gi45QI3dP7dNR+Dfvf+/fbbBK777jFizToTBOEMM8tqsS3vfZ0x
         ZiGQ==
X-Gm-Message-State: AOAM532eK6pNXGcHmlwg8dFgymG/FzmfA6DbnZBw9MkHATgWn3479a9u
        cv3aPN7jJmj0gh59TeU9KfwaobZ+GJw=
X-Google-Smtp-Source: ABdhPJxGKBw3SidegsW+vS8vep9U/RF9MmSFOlfQ5DQkw9xbqbqeKT+6Op3uwvvnvmkXmfUo9xSTBw==
X-Received: by 2002:a02:964c:: with SMTP id c70mr2457000jai.85.1632966280278;
        Wed, 29 Sep 2021 18:44:40 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id h23sm1155414ila.32.2021.09.29.18.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 18:44:39 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/4] drm: fix doc grammar error
Date:   Wed, 29 Sep 2021 19:44:24 -0600
Message-Id: <20210930014427.14239-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210930014427.14239-1-jim.cromie@gmail.com>
References: <20210930014427.14239-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

no code changes, good for rc

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 0cd95953cdf5..4b29261c4537 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -486,7 +486,7 @@ void *__devm_drm_dev_alloc(struct device *parent,
  * @type: the type of the struct which contains struct &drm_device
  * @member: the name of the &drm_device within @type.
  *
- * This allocates and initialize a new DRM device. No device registration is done.
+ * This allocates and initializes a new DRM device. No device registration is done.
  * Call drm_dev_register() to advertice the device to user space and register it
  * with other core subsystems. This should be done last in the device
  * initialization sequence to make sure userspace can't access an inconsistent
-- 
2.31.1

