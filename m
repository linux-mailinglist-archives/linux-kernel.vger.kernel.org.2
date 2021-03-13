Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EFC339D9E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 11:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhCMKmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 05:42:38 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:49970 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230380AbhCMKm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 05:42:29 -0500
Received: by sf.home (Postfix, from userid 1000)
        id 34F4C5A22061; Sat, 13 Mar 2021 10:42:20 +0000 (GMT)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] ia64: fix format string for ia64-acpi-cpu-freq
Date:   Sat, 13 Mar 2021 10:42:14 +0000
Message-Id: <20210313104214.1548076-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning with %lx / s64 mismatch:

  CC [M]  drivers/cpufreq/ia64-acpi-cpufreq.o
    drivers/cpufreq/ia64-acpi-cpufreq.c: In function 'processor_get_pstate':
      warning: format '%lx' expects argument of type 'long unsigned int',
      but argument 3 has type 's64' {aka 'long long int'} [-Wformat=]

CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Viresh Kumar <viresh.kumar@linaro.org>
CC: linux-pm@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 drivers/cpufreq/ia64-acpi-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
index 2efe7189ccc4..c6bdc455517f 100644
--- a/drivers/cpufreq/ia64-acpi-cpufreq.c
+++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
@@ -54,7 +54,7 @@ processor_set_pstate (
 	retval = ia64_pal_set_pstate((u64)value);
 
 	if (retval) {
-		pr_debug("Failed to set freq to 0x%x, with error 0x%lx\n",
+		pr_debug("Failed to set freq to 0x%x, with error 0x%llx\n",
 		        value, retval);
 		return -ENODEV;
 	}
@@ -77,7 +77,7 @@ processor_get_pstate (
 
 	if (retval)
 		pr_debug("Failed to get current freq with "
-			"error 0x%lx, idx 0x%x\n", retval, *value);
+			"error 0x%llx, idx 0x%x\n", retval, *value);
 
 	return (int)retval;
 }
-- 
2.30.2

