Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B9F4008F3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 03:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242103AbhIDBaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 21:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbhIDBaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 21:30:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191A3C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 18:29:03 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id c6so682274pjv.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 18:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H1Ln6hv72OKBGVNw8VIbLOd146KuoRddxElMTNgiTwo=;
        b=UMHePT9qrKHyZLT94A0qGZyCXL/o33XG//QEGkZ7RinQUQi5ONTst3ymscZv48zKb6
         DAtaQTttcSeQ6f93tyHLJv29tMQ9FaWpr7IqsIb+OtsjGdAsyJVzEEjHtEgU4jwffxbC
         ta7dIINT3TG/rCzAHbKcn0bIywt1oz02WQ3Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H1Ln6hv72OKBGVNw8VIbLOd146KuoRddxElMTNgiTwo=;
        b=bEEw1WsYdHmIf5HV6xbjfgGwZpx279imUgza4MuvOtr8BHADAPGRWU+4RmvoMUIXD4
         tQmwaYO9VU3KWKHSDwxRdbSyFEnd12PiZfG1wCbhhswLwf9LkLp1KI6Ytjrjtf/FU4Ex
         RJ4HX/kprjrYIihlf2MnKdiMwht/tiYE8TLVbCOqNe4Scj98epUYmsPuQepUG7JFB+iG
         +cZUQ9DjSGrRlYtEzwmv0d8f4XD9tP/V17GobL82W4zuy2rIIPo6VVWSKbe6p+QiQiyJ
         3QWL3MAPpf2HFWBhizACnQBE+d+moocyGd6PACRtr5XG25sQ4lDqg6RyhR6vzR6E8n6X
         WKWA==
X-Gm-Message-State: AOAM531nVBWoGq+KXD9naMWGlwWAzU2iun5DCBWoglGZFWnOvevPU66J
        9HDhzZ+kfjXKWxMnR6xdfvWRCw==
X-Google-Smtp-Source: ABdhPJxZgp6fhHdM2sKxklUhtd+XQ31IJFZ293SUkbTGfVcmwQREKfoxXQ8ZydQkLhFtJaFTyH+EvQ==
X-Received: by 2002:a17:90a:3ec4:: with SMTP id k62mr1752244pjc.32.1630718942636;
        Fri, 03 Sep 2021 18:29:02 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:42bd:ff8f:35eb:3fc5])
        by smtp.gmail.com with UTF8SMTPSA id m2sm278903pgd.70.2021.09.03.18.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 18:29:02 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] coresight: cpu-debug: control default behavior via Kconfig
Date:   Fri,  3 Sep 2021 18:28:54 -0700
Message-Id: <20210903182839.1.I20856983f2841b78936134dcf9cdf6ecafe632b9@changeid>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debugfs is nice and so are module parameters, but
 * debugfs doesn't take effect early (e.g., if drivers are locking up
   before user space gets anywhere)
 * module parameters either add a lot to the kernel command line, or
   else take effect late as well (if you build =m and configure in
   /etc/modprobe.d/)

So in the same spirit as these
  CONFIG_PANIC_ON_OOPS (also available via cmdline or modparam)
  CONFIG_INTEL_IOMMU_DEFAULT_ON (also available via cmdline)
add a new Kconfig option.

Module parameters and debugfs can still override.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/hwtracing/coresight/Kconfig               | 13 +++++++++++++
 drivers/hwtracing/coresight/coresight-cpu-debug.c |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index f026e5c0e777..8b638eb3cb7d 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -150,6 +150,19 @@ config CORESIGHT_CPU_DEBUG
 	  To compile this driver as a module, choose M here: the
 	  module will be called coresight-cpu-debug.
 
+config CORESIGHT_CPU_DEBUG_DEFAULT_ON
+	bool "Enable CoreSight CPU Debug by default
+	depends on CORESIGHT_CPU_DEBUG
+	help
+	  Say Y here to enable the CoreSight Debug panic-debug by default. This
+	  can also be enabled via debugfs, but this ensures the debug feature
+	  is enabled as early as possible.
+
+	  Has the same effect as setting coresight_cpu_debug.enable=1 on the
+	  kernel command line.
+
+	  Say N if unsure.
+
 config CORESIGHT_CTI
 	tristate "CoreSight Cross Trigger Interface (CTI) driver"
 	depends on ARM || ARM64
diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 00de46565bc4..8845ec4b4402 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -105,7 +105,7 @@ static DEFINE_PER_CPU(struct debug_drvdata *, debug_drvdata);
 static int debug_count;
 static struct dentry *debug_debugfs_dir;
 
-static bool debug_enable;
+static bool debug_enable = IS_ENABLED(CONFIG_CORESIGHT_CPU_DEBUG_DEFAULT_ON);
 module_param_named(enable, debug_enable, bool, 0600);
 MODULE_PARM_DESC(enable, "Control to enable coresight CPU debug functionality");
 
-- 
2.33.0.153.gba50c8fa24-goog

