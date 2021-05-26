Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1377391CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 18:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhEZQZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 12:25:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35263 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbhEZQZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 12:25:03 -0400
Received: from mail-vs1-f69.google.com ([209.85.217.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llwJf-0008D1-BO
        for linux-kernel@vger.kernel.org; Wed, 26 May 2021 16:23:31 +0000
Received: by mail-vs1-f69.google.com with SMTP id q16-20020a67d7900000b0290228198e77b6so466534vsj.23
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 09:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6NwA8NmUwiZmbFBWUe/+uyLFAYgt93yKUAUW2ekHfg4=;
        b=oIOGMDnt9HZPdhpP8puKArqGaAYhcznfWkp0y2U1H1zPpGbMwDtp2jA3EIW2HmW4Rc
         89oVIa10ZRdhwEaUaEQtCuORYByXwk6U/AZKSbkGhJFRrYDiLk3nY/vrGf02OgD9ymN1
         VfsU4T338xSob5RNJmkcPAX+Vy4oj3L23NEh0Bb7yMQkKFKW9P6AFGajWW05MyySNGUS
         vhexf17Ee0qGsDVdp4bHb77alJwH0o2JLFPpfR1A0ff8gfqLVSvzfvSDVTM1etI+lEd5
         TqdWL7N8WMq6vlEB0A9LTz/qhx31QWSEA34rRpyPjR0BX/brHJi0liEARvw25S3RiVET
         HrLg==
X-Gm-Message-State: AOAM533ZDPtzLLTP+0EIzbWN6aRRit+nBc/2XSs/PY3mgcmJWkTCJLZy
        u3S7URN++GYu8nzn4xJ77rR94Oszjk+heqdb9DwMF6Vi9I+zrlDURVut47/dG+BKVqOVgog++7u
        RI01VcUv6KBmBCBktkeQGIQQ7mAvU9tL/bcqzJxQyIg==
X-Received: by 2002:ab0:2b15:: with SMTP id e21mr34132866uar.102.1622046208936;
        Wed, 26 May 2021 09:23:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq+aNeLdtNs2xkhZJ1UzALGUp4kKfuJC0kkp93ok5ZySBg2n0E8vSWq5sGiiq8LBThjDFJMQ==
X-Received: by 2002:ab0:2b15:: with SMTP id e21mr34132748uar.102.1622046207995;
        Wed, 26 May 2021 09:23:27 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.4])
        by smtp.gmail.com with ESMTPSA id t16sm574459uao.0.2021.05.26.09.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:23:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2] PM: runtime: document common mistake with pm_runtime_get_sync()
Date:   Wed, 26 May 2021 12:22:51 -0400
Message-Id: <20210526162251.125600-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
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

Changes since v1:
1. Reword after comments from Rafael.
---
 Documentation/power/runtime_pm.rst | 6 +++++-
 include/linux/pm_runtime.h         | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 18ae21bf7f92..33619bf83f69 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -378,7 +378,11 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
 
   `int pm_runtime_get_sync(struct device *dev);`
     - increment the device's usage counter, run pm_runtime_resume(dev) and
-      return its result
+      return its result;
+      be aware that it does not drop the device's usage counter on errors so
+      so consider using pm_runtime_resume_and_get() instead of it, especially
+      if its return value is checked by the caller, as this is likely to result
+      in cleaner code.
 
   `int pm_runtime_get_if_in_use(struct device *dev);`
     - return -EINVAL if 'power.disable_depth' is nonzero; otherwise, if the
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 6c08a085367b..aab8b35e9f8a 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -380,6 +380,9 @@ static inline int pm_runtime_get(struct device *dev)
  * The possible return values of this function are the same as for
  * pm_runtime_resume() and the runtime PM usage counter of @dev remains
  * incremented in all cases, even if it returns an error code.
+ * Consider using pm_runtime_resume_and_get() instead of it, especially
+ * if its return value is checked by the caller, as this is likely to result
+ * in cleaner code.
  */
 static inline int pm_runtime_get_sync(struct device *dev)
 {
-- 
2.27.0

