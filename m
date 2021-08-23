Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C573F459B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 09:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhHWHI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 03:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbhHWHI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 03:08:27 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6A4C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 00:07:45 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id a21so14530260pfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 00:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vnPnOFH15WpjpkJv0XH5507vJbN9niQmMmw2orYb31I=;
        b=JhPcxKchFojBd1dibPlBCZz0bpgG91lTP/lRCCVq8bLbMh7akKFv7mrk1t0s/u+rAn
         LgQ149yDLBDdsP02AaRZ+JcAfIQheWVJTxbJM21rPfiBEmAVj4Di6SY/HsCDiyvLl0LE
         HCylrstFglc7+aikichH2KVdtSSHLTmJwGoInvr/Cdcu171mtOZb/6moMARF+WPV2tWE
         PUoL5w/ZdRsotFZ/nCmLK41sDT6rJfg0qIojcisFUGMo6zhN9+Gii7k9TzR8HrWQXpxD
         XWcKLlZau11VU/L18ui9z2cNidBPNzxM6AZUZAUBwxqEfGYg79k1BMlSwXXBClOBVmGj
         +pUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vnPnOFH15WpjpkJv0XH5507vJbN9niQmMmw2orYb31I=;
        b=tQsfYoFQn4OVq/+5UHLhwEXd5ANQMKUsdAaYf2Q0BSFtJpgyFjVCt8rWOihfkKyqTG
         gbMA63ng4UzJcnZFgfZyEFvLWqh8epVInDCEdgaVXGxFHH0Waja+KsTAlzU+bcIMtQza
         SKUNSmoqMm/2NWySznsKJrXjul2djrh+eCUcgUECXDwO/nRUlgfEMyQRlE8XW5WE98Au
         cPSJD89BP3haGQlxcRat2OX7t28p4vhwNntdjjxg0HoEECks1mYZ7RY1QCEb7HEIKsGY
         kk7Py8Ys8W9eXwzBXUp+c+Exp6k1lzdSX56K6cZ4HvN+7K5ZNh3LIUiNlpa6utkEgwYc
         v65w==
X-Gm-Message-State: AOAM53218MrAxDR+vReP1Y/po839K1tsM7v4OCQlhxHvUqJq2stIOMUv
        NztuKl3BO3ipa799lwPp+VnoBw==
X-Google-Smtp-Source: ABdhPJxPAei6q6vdBM3KEZMSIC/2N9YtKUNnIkb1B7hCpOxZyA9kBSg3joEAsIFVhl8W8FfXb8KuPQ==
X-Received: by 2002:a05:6a00:1583:b0:3e2:2ae3:2ba8 with SMTP id u3-20020a056a00158300b003e22ae32ba8mr32120979pfk.58.1629702464717;
        Mon, 23 Aug 2021 00:07:44 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id h3sm8967833pgm.87.2021.08.23.00.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 00:07:44 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch_topology: Export cpu_scale and topology_set_thermal_pressure()
Date:   Mon, 23 Aug 2021 12:37:41 +0530
Message-Id: <a1053bd0e63ec0d985691b8a37bf7f6d5a1156aa.1629702403.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are now used from a cpufreq driver which can be built as module,
export them.

Fixes: 86afc1df661a ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
This needs to go via my ARM cpufreq tree. I will probably merge it with the
concerned commit.

 drivers/base/arch_topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 921312a8d957..bf9d47a16d30 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -149,6 +149,7 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 }
 
 DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
+EXPORT_SYMBOL_GPL(cpu_scale);
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
 {
@@ -165,6 +166,7 @@ void topology_set_thermal_pressure(const struct cpumask *cpus,
 	for_each_cpu(cpu, cpus)
 		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
 }
+EXPORT_SYMBOL_GPL(topology_set_thermal_pressure);
 
 static ssize_t cpu_capacity_show(struct device *dev,
 				 struct device_attribute *attr,
-- 
2.31.1.272.g89b43f80a514

