Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25CA3F4166
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 22:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhHVUKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 16:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhHVUKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 16:10:47 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB452C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 13:10:05 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g11so12177531qtk.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 13:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:date:message-id;
        bh=0xXGH7bWWYuv3ONKF+7+Rl/Qg0qZfUB/lDsOTynnxS8=;
        b=rWPCvG5dp4/QpXGPGvc4fE5lBwBu0Gs5A4VE4sztRp+5nTzTbsv/1nZWMjqWEM0JI+
         Z4EgWPEpLCKJiR2qlsCJc/KxvbeyWHU2UjWFruAJOZXiSQdzv/2SQvpDDJnXsjturHCC
         EHoa9B4z2fmwz59dzWPegZBLrKmSBZvtseR00auN10QDRgDR8xZXndbvBLAg98rYzpr/
         P2dfBlXZPnzLVQTGrRuB+ncArn+jTpTqJ8KwPnyEhUhf756mKXC4vheRMFuNELZfIM13
         twIzKiAePnuKdKNFcNgUy9wxShuMbCU2e8ILI20+nawX6mfjt/eMpoVIqovSZTWlOkzk
         a2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=0xXGH7bWWYuv3ONKF+7+Rl/Qg0qZfUB/lDsOTynnxS8=;
        b=Iea6oWecJd6F3JpLIUS7Csrfu3PbzK38TrgUeOZcVUZN1992mtHM/RQkQ0uahGWzWu
         Dmpv4zIsY5TgeclEX7ihsKS95w3xiuugDNbKjdmCT0fuUiuoz9g6BrDpj3rSHwYwx7tN
         UtWftRdJkz03gS+BghS7xRzJZ/RDxlgEcHAXQBKrhxOEME8MS3B4HTu0nFG4l/Eclcwz
         ZUaXxLQk3PYIV3KnZi+rqiN1YSNWf1TWIm9PkbUOPjdIEjOOe1bOn6QGUq3U2Hr1bCL4
         kcy5kGbhhYR39JudD+klpooETBvflzJG4W4AIfo5LadTUGjMpaBs1tlNDSKsqoFRnGL2
         md/w==
X-Gm-Message-State: AOAM531A+Gh9ia5Bb/Aw3Tzw/Xt42OLWw/AJn4RtOQHln611pP2CyFAK
        VcPX675bjg/eQzjRgZL9vso/PDWz62tgaQ==
X-Google-Smtp-Source: ABdhPJwANglA9LiKbDMfvUv2PirqDGUqs1l1iHcLRhgqlTzyu/ShcGkHr8GVj4RxOwV8cJ+ZRF1tMQ==
X-Received: by 2002:ac8:5386:: with SMTP id x6mr1746295qtp.378.1629663004907;
        Sun, 22 Aug 2021 13:10:04 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id m19sm5358904qtx.84.2021.08.22.13.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 13:10:04 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.7+dev
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: qcom-cpufreq-hw: Fix 'make allmodconfig' build
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sun, 22 Aug 2021 16:10:03 -0400
Message-ID: <438052.1629663003@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 86afc1df661a adds a reference to a symbol that doesn't have an
EXPORT_SYMBOL, which fails if qcom-cpufreq-hw is built as a module.

ERROR: modpost: "topology_set_thermal_pressure" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!

Add the missing EXPORT_SYMBOL.

Fixes: 86afc1df661a ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 921312a8d957..fbc39ca67124 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -165,6 +165,7 @@ void topology_set_thermal_pressure(const struct cpumask *cpus,
 	for_each_cpu(cpu, cpus)
 		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
 }
+EXPORT_SYMBOL(topology_set_thermal_pressure);
 
 static ssize_t cpu_capacity_show(struct device *dev,
 				 struct device_attribute *attr,

