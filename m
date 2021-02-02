Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4901330B743
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 06:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhBBFmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 00:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhBBFml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 00:42:41 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA11C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 21:42:01 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q72so163033pjq.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 21:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=frAkgVL2A/flsUkD71GYFVNqrXgLKUeulhJ4Bqnppzk=;
        b=MGUcjiyjgz3PsYXoJzyHlHKBA3biuY/GtlAnY21YDnrJbf0oyCTLdHywQ1wJcX7pbI
         3ahWvyl/Uw5KoHE1EA/7kgFFrqS9xMDyOJjxgWKBssojs90KY0TmgjbQhCebtfe7rTmq
         mIcFJSpSQModv1IRNycmrkbvJ1vGKGuHGmjTAM3PbgXe5OV9dz5NCiuIGBDtU4md9BSH
         quW8ivdCsZUJYWkYkDAwPBLwrd+ugRfdrfj8rc/UfsH8xAgXCi8Rd9O72Ovh5dwIzWOw
         xxEVpjGRy8HJHgbOdkXWEW3/AR3j8ZsCIUTm9+HM8t+Kr1gK2ja/4Pg40HhIDT1ZDl/4
         qqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=frAkgVL2A/flsUkD71GYFVNqrXgLKUeulhJ4Bqnppzk=;
        b=TqJGdiNMLxwbrOUy6c/9U6mRoBNLitHlzjUxljHpDHxCCKOrvefJEQaa7t98THa5A2
         zIHQhKCztoJZvk5EIsJmupPWVY3SpvXLOaARZBckr2PZauCobrWv1dr6vIW3oX5sdHa+
         IntsDTBY46npBai3IBZoearCR3j5ycvadl4Qa+0jps0hGsRlOpWq3YYxcs6E3HDmqoCN
         Giif1P3BMF7uEpyCiyLDxF+CXsLYlX4X08/8zgW1F7VhAVna4zXiqz5ZIeRe5H4AFNKI
         WZEMgSDRITDKwgJD/m7AhllU6SAzkAIrOdfBEVaREeWludfd3XmZzapAtWrnUg2tLJ5z
         AfZA==
X-Gm-Message-State: AOAM531TMk5sqr1xcnKT+QpBhJkmkr6XJD/boUsEivPMtlxE+kJ0KlQ6
        X7fTu+mDFj9Qx+B7ZUVDvJr+pYtcVFjR2w==
X-Google-Smtp-Source: ABdhPJwBL3bzLIVURLuDJ0SFZ1X8RZlHop4HFGhEpJeW2qWp66VPCr62gyAbZxLYCJVhILDjbWheLw==
X-Received: by 2002:a17:902:ec83:b029:df:e942:93c0 with SMTP id x3-20020a170902ec83b02900dfe94293c0mr20605223plg.55.1612244521019;
        Mon, 01 Feb 2021 21:42:01 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 184sm20062304pgi.92.2021.02.01.21.41.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 21:41:59 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Remove unused flag CPUFREQ_PM_NO_WARN
Date:   Tue,  2 Feb 2021 11:11:55 +0530
Message-Id: <bed6bc7e15c3ed398dd61b8f3968049f1f16b1b6.1612244449.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag is set by one of the drivers but it isn't used in the code
otherwise. Remove the unused flag and update the driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Rebased over:

https://lore.kernel.org/lkml/a59bb322b22c247d570b70a8e94067804287623b.1612241683.git.viresh.kumar@linaro.org/

 drivers/cpufreq/pmac32-cpufreq.c |  3 +--
 include/linux/cpufreq.h          | 13 +++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index 73621bc11976..4f20c6a9108d 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -439,8 +439,7 @@ static struct cpufreq_driver pmac_cpufreq_driver = {
 	.init		= pmac_cpufreq_cpu_init,
 	.suspend	= pmac_cpufreq_suspend,
 	.resume		= pmac_cpufreq_resume,
-	.flags		= CPUFREQ_PM_NO_WARN |
-			  CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
+	.flags		= CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
 	.attr		= cpufreq_generic_attr,
 	.name		= "powermac",
 };
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c8e40e91fe9b..353969c7acd3 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -398,8 +398,11 @@ struct cpufreq_driver {
 /* loops_per_jiffy or other kernel "constants" aren't affected by frequency transitions */
 #define CPUFREQ_CONST_LOOPS			BIT(1)
 
-/* don't warn on suspend/resume speed mismatches */
-#define CPUFREQ_PM_NO_WARN			BIT(2)
+/*
+ * Set by drivers that want the core to automatically register the cpufreq
+ * driver as a thermal cooling device.
+ */
+#define CPUFREQ_IS_COOLING_DEV			BIT(2)
 
 /*
  * This should be set by platforms having multiple clock-domains, i.e.
@@ -431,12 +434,6 @@ struct cpufreq_driver {
  */
 #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	BIT(6)
 
-/*
- * Set by drivers that want the core to automatically register the cpufreq
- * driver as a thermal cooling device.
- */
-#define CPUFREQ_IS_COOLING_DEV			BIT(7)
-
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
-- 
2.25.0.rc1.19.g042ed3e048af

