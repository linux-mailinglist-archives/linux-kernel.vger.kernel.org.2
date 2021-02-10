Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073D1316150
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhBJIpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhBJIjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:39:03 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1764C061756;
        Wed, 10 Feb 2021 00:38:22 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id t5so1849276eds.12;
        Wed, 10 Feb 2021 00:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FC23kK9l4Y+AmBOl3hxKM27Ymb4/vFiZ7s/f3NCHXFc=;
        b=afLGtRGPqaIuDJhnxaaU0/3sFtta6QFmaZHhjYAYJkiptmKylrXeFVU7fXZDie3gQu
         Y0a/rVOM5vn5FaKL8v5PQlbri8mrOpNGWQgIhJkyNPoJoe9KHFXFlkfsgmgrfNjwBLaG
         /ymmaNUFhrjqEFuih2krNZfn1dPXLfiW00JuNNrqWCrrQlpZJKk9XYj4s8reORLGCUF8
         pOOFCnlTIr0od/dOP9z3cK3Co/vn7Di5QVizLr1v+ZbE9znTCCfpduZkR7pnDHAMe8NU
         JPvKDUeTh0ZCnvESuYhKGlLHBeBf0h3Bxy5MMRV5SNRMxoBdv24yWBC8X8V1KjZ14Gsc
         HIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FC23kK9l4Y+AmBOl3hxKM27Ymb4/vFiZ7s/f3NCHXFc=;
        b=nGlWG84NqlkU4F6MGeII9uCadRCrupJeQt9f8HH8GccVK7Yd17505RKOQ54wN/05Pc
         clIP88RQyA5IudC6vyDSH8nDDRxKqBh+XHtAu/QDEjXq6GlDNxOc2xbbpTLkWpCyg1u/
         wAq6HActenneWyj16KSIRF+aD1xayJo90gNQkMcRGsdlCMnikHgXseNmt6WWufbh1zsD
         A/Pwf/zm/dLhJDtllh6kwajJGcr+rgPd/VVNZOtXAUZgvvW0fs6LAJTaOd+eVa+CxwSs
         AUZcqTlYy33EwacxPViv59dGUM2VgvZpSirA9AxTWrq3tE/V74etLV0Tbnp/UEThC6j5
         e9dg==
X-Gm-Message-State: AOAM530hbTuOhSJlMDtVmcFLLE0nQO/c6mzhEoebnLXs++2K/5Ep5xwt
        /3fAtmMjErdvSDmF9cKk/MU=
X-Google-Smtp-Source: ABdhPJzxYmpe3XmKO5QxPT2B70wJtkEanUMqmOysq7XfFUpBIwe7/x/B6MFTkhwVErBSYKPQOqCU9A==
X-Received: by 2002:a05:6402:4316:: with SMTP id m22mr2186877edc.64.1612946301316;
        Wed, 10 Feb 2021 00:38:21 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d7e:e500:60d3:cde9:82a5:6b47])
        by smtp.gmail.com with ESMTPSA id kv24sm626676ejc.117.2021.02.10.00.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 00:38:20 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org
Cc:     Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND] MAINTAINERS: replace non-matching patterns for loongson{2,3}
Date:   Wed, 10 Feb 2021 09:38:12 +0100
Message-Id: <20210210083812.6126-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ffe1f9356fbe ("MAINTAINERS: Add Loongson-2/Loongson-3 maintainers")
adds quite generic file entries for drivers/*/*loongson{2,3}* and
drivers/*/*/*loongson{2,3}* to be informed on changes to all loongson{2,3}
files in drivers.

However, only the pattern 'drivers/*/*loongson2*' matches to one file in
the repository, i.e., drivers/cpufreq/loongson2_cpufreq.c; all other
patterns have no file matches.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F:    drivers/*/*/*loongson2*
  warning: no file matches    F:    drivers/*/*/*loongson3*
  warning: no file matches    F:    drivers/*/*loongson3*

As in the last two and half years, no further files and drivers have
showed up to match those patterns, just name the one file that matches
explicitly and delete the others without a match.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20210209

Keguang, Huacai, Jiaxun, please ack.

Thomas, please pick this minor non-urgent cleanup patch.

 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e2ab01363df..4bdf2fdb0456 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11946,8 +11946,7 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	arch/mips/include/asm/mach-loongson2ef/
 F:	arch/mips/loongson2ef/
-F:	drivers/*/*/*loongson2*
-F:	drivers/*/*loongson2*
+F:	drivers/cpufreq/loongson2_cpufreq.c
 
 MIPS/LOONGSON64 ARCHITECTURE
 M:	Huacai Chen <chenhuacai@kernel.org>
@@ -11956,8 +11955,6 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	arch/mips/include/asm/mach-loongson64/
 F:	arch/mips/loongson64/
-F:	drivers/*/*/*loongson3*
-F:	drivers/*/*loongson3*
 F:	drivers/irqchip/irq-loongson*
 F:	drivers/platform/mips/cpu_hwmon.c
 
-- 
2.17.1

