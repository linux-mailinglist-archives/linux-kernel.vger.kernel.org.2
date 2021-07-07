Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970003BED84
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 19:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhGGR46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 13:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhGGR44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 13:56:56 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C8CC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 10:54:16 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g8so2646387qth.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 10:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:organization:mime-version
         :content-transfer-encoding;
        bh=bfM1wAOaWaUzrRzrQoIIgI8cYWuLRVyNlVdaNaynf5c=;
        b=AUdBuVukHCW5c2WRatnWjnKha7SPBvFp7Y6XtSyAguOZskLwXmIVfvutKR+wg7PiaM
         xnLbzFh1fG//F3kArbu07njdW33ZQi/YoZDXUfXtl2AcgGR0Sq0ITZizNnb6aYxaYARX
         nGAK+FF0wMVKogZGrnnME3lm6M4XabE99wuPXC0nQS4vVcdy68o7SQpXSY+OAYa5jqUF
         Ufgubzt71DyQ+Ichj7niN2jp/rcoDErbDc4Wm6PLEfpqygYZhfQQOOAg2v+XNh6mJxk5
         oX9xn7F0zYANKZAAn9O3Rm9dnf1YIG7l5Lg/hqFY4PQn0MoPtwhbOTXIzodheGQ7Ug8e
         QxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:organization
         :mime-version:content-transfer-encoding;
        bh=bfM1wAOaWaUzrRzrQoIIgI8cYWuLRVyNlVdaNaynf5c=;
        b=T+n5/JiNcw+E4lC3DTt02hKQeA0N/bRUN06c8gaFRDPhEcz/xR+oCgvTYikfdR5CNt
         1wjhSkFzgFhCpu9dqUPxJqQLMbTsPqLlhYzdWLkJYQPtWayw3J5i2B9shH3QjH9KUhHT
         W7nisPO3q2C9ZWBEaD/ytjzI9fo40IQF7IIIKLpFby4V5l9SGuU9FkFRk4welyWZ//hM
         UL2Gmm8HGUoPZD2hvXcTNjQLM15BEB590msaUKUEs0CR87ctGk6LtColYbuPGPV+dVZ7
         qb0IJxxVYy54vZgzgLmi6mDkEvgasWgKcJca7+J+fzxVf2qEZxFbKZzKtAh/IbMhZrZZ
         HtWA==
X-Gm-Message-State: AOAM530NY8DMiOT30g014XhvhclnzFnPDhwp9OiGwB3FyoPyDJX+VFXC
        nrlMfPFPILTmOI8w3vg6uoDrBw==
X-Google-Smtp-Source: ABdhPJzm1RqPFFxAQZhA0tdMO/9/W3qTtC+1uyS6SacxScxtziWny/MZsP7+y7CMBzp1AIHE2iRAeQ==
X-Received: by 2002:aed:2162:: with SMTP id 89mr23781485qtc.182.1625680455081;
        Wed, 07 Jul 2021 10:54:15 -0700 (PDT)
Received: from iron-maiden.localnet (50-200-151-121-static.hfc.comcastbusiness.net. [50.200.151.121])
        by smtp.gmail.com with ESMTPSA id a66sm438286qkg.73.2021.07.07.10.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 10:54:14 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        maz@kernel.org, linux-arm-kernel@lits.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: Add missing header <asm/smp.h> in two files
Date:   Wed, 07 Jul 2021 13:54:13 -0400
Message-ID: <5726396.lOV4Wx5bFT@iron-maiden>
Organization: Virginia Tech
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing header <asm/smp.h> on include/asm/smp_plat.h, as it calls function
cpu_logical_map(). Also include it on kernel/cpufeature.c since it has calls to
functions cpu_panic_kernel() and cpu_die_early().
 
Both files call functions defined on this header, make the header dependencies 
less fragile.

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
---
 arch/arm64/include/asm/smp_plat.h | 1 +
 arch/arm64/kernel/cpufeature.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include/asm/smp_plat.h
index 99ad77df8f52..140c7a03a901 100644
--- a/arch/arm64/include/asm/smp_plat.h
+++ b/arch/arm64/include/asm/smp_plat.h
@@ -11,6 +11,7 @@
 #include <linux/cpumask.h>
 
 #include <asm/types.h>
+#include <asm/smp.h>
 
 struct mpidr_hash {
        u64     mask;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 125d5c9471ac..350d8601ff28 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -84,6 +84,7 @@
 #include <asm/sysreg.h>
 #include <asm/traps.h>
 #include <asm/virt.h>
+#include <asm/smp.h>
 
 /* Kernel representation of AT_HWCAP and AT_HWCAP2 */
 static unsigned long elf_hwcap __read_mostly;
-- 
2.25.1



