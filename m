Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DF5368522
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbhDVQrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:47:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43388 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhDVQrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:47:03 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lZcTD-00042O-Ay
        for linux-kernel@vger.kernel.org; Thu, 22 Apr 2021 16:46:27 +0000
Received: by mail-wr1-f69.google.com with SMTP id j72-20020adf914e0000b02901073cdd9d65so4520563wrj.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 09:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XYldf2TteN67NE5BlJ6J2IbXhjnoE0H+GTr8M/L8WwI=;
        b=j/o6JqhFdi0eTTQxFAdHw6uZj56EVnKcvguHxZrnJUeub6z6h31fMCA5ISaBVBjm1W
         F/+Ec0JrWdMNDaC8VFyHBzrQFMyTP032QSY/9TN/OiUHarlxPfWWPUbxSplj5pTosynn
         rYejeN7OGctBzxa61SmytRkaGKxh1YuTYzGBu9tSjDArGJCRQPVl3jtabbFMbHaT+EnF
         wMbvqiyCcewaNUhhVPng1ssUjJkBlv0rtgjKo18l8metzXqQiNYoE8DVQEzb2/mVDBsd
         ffsvXC2MHCQgT4UMnsi21V2NMkuQo2e+PgHBAsD06HxpFrhEkXr1vlCbaretZqjfcCkF
         7a4A==
X-Gm-Message-State: AOAM532L/AkUtfP56/3fbp6gzXWZ4qqS72V/oJDISu0TTFWdPA/qZR0o
        UiVUD41wuaN9KRG9SNyxrsrtfoEB65TUlZ82l0beIn7xQgfwosvEtcMG2tWnnIra0inVW2QxvqR
        nuOxAx/CzEAsGPTHbTBfCS5BcuJ1N4e3kDZG6OmSTuA==
X-Received: by 2002:a1c:4d0e:: with SMTP id o14mr4622117wmh.141.1619109987036;
        Thu, 22 Apr 2021 09:46:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxprj5Ratdxj2heyEnHtCrorf+F3fovhQ6zhM57BgDznrU5G1NFgZkzoVUqy+ROm0Zf4gKKPA==
X-Received: by 2002:a1c:4d0e:: with SMTP id o14mr4622110wmh.141.1619109986913;
        Thu, 22 Apr 2021 09:46:26 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id k22sm4825386wrh.5.2021.04.22.09.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 09:46:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] PM: runtime: document common mistake with pm_runtime_get_sync()
Date:   Thu, 22 Apr 2021 18:46:06 +0200
Message-Id: <20210422164606.68231-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync(), contradictory to intuition, does not drop the
runtime PM usage counter on errors which lead to several wrong usages in
drivers (missing the put).  pm_runtime_resume_and_get() was added as a
better implementation so document the preference of using it, hoping it
will stop bad patterns.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/power/runtime_pm.rst | 4 +++-
 include/linux/pm_runtime.h         | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 18ae21bf7f92..478f08942811 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -378,7 +378,9 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
 
   `int pm_runtime_get_sync(struct device *dev);`
     - increment the device's usage counter, run pm_runtime_resume(dev) and
-      return its result
+      return its result;
+      be aware that it does not drop the device's usage counter on errors so
+      usage of pm_runtime_resume_and_get(dev) usually results in cleaner code
 
   `int pm_runtime_get_if_in_use(struct device *dev);`
     - return -EINVAL if 'power.disable_depth' is nonzero; otherwise, if the
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 6c08a085367b..0dfd23d2cfc3 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -380,6 +380,9 @@ static inline int pm_runtime_get(struct device *dev)
  * The possible return values of this function are the same as for
  * pm_runtime_resume() and the runtime PM usage counter of @dev remains
  * incremented in all cases, even if it returns an error code.
+ * Lack of decrementing the runtime PM usage counter on errors is a common
+ * mistake, so consider using pm_runtime_resume_and_get() instead for a cleaner
+ * code.
  */
 static inline int pm_runtime_get_sync(struct device *dev)
 {
-- 
2.25.1

