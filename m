Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48976394E0F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhE2UEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhE2UEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:13 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E13CC061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:35 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso7007237ote.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h5OtzTEwc+WwvGDtUrmoOFleYaMNmg9m6EN9iI8Xrcw=;
        b=DWrCzYMqu6uplGi0HCezAbkhjhEZwiAzCX1jX3BfmpwrYKdiDJld/ZO3CZquKDmjBd
         bFL0wzhdJvD3dqUPzZ/ZioRWocEQOFIu/9cAp2q5WtHJ++Zor9KKJTktQh4b8MnFAsbq
         grtenRKZAeC8ZB0tcQOrl1bAjT38tV3FN4QJQ1GfdqgW908vsRLUGMDvUtPzzoiCNd7F
         rK7Q8wI8z+N2WpR4OmrF2xE7C9G0JCg/xvd+iXRuAINk/YzCyxqURu1v53Us2PPYkA/e
         FPZherB0Bs66U9sJT3KGbC5X7q7sJf9VfJU0vhs8DmQJrNJ/iWATyoUX6gjJxubGddDI
         TdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h5OtzTEwc+WwvGDtUrmoOFleYaMNmg9m6EN9iI8Xrcw=;
        b=BQ3AokzzO0WCHB31i29sahP++nQEVzheo+2eKPZYnH/giBvQN88ilvsH0qS6mfswD0
         ciMq6ohH5VBDu5BtUsTEBT1d7aWL8qMQKIHZTD13zZ3UkhxB0Btwnzjlui04AVg4tTMc
         79qRCrSuk+BljmAtd3zSNcxU3Kp39TIHHDiz7/l5NniyP1cHWJUEPtC58fl0zdglkq/g
         gMGZypvtwilRhb89jXPxkxO3WE/VivqO2kOCzPOPi6cL4PG2ok+PsLjvbeFepQQqFBEx
         AtPPMn8sRWBjFQ7xlxoSwVKNV9fZspu9SfufPedNDZ1t6tNsh+1KwNfU3cgBhCBfHKd/
         IdVQ==
X-Gm-Message-State: AOAM530QuvGnssG4qAESlQz8rUBgkDFM1c9qy5XgFIJRRPWgyBOzOSyv
        n7cY1WBX6IaQRMtjxeT9ahg=
X-Google-Smtp-Source: ABdhPJzvKV1dqFULNWmcXrdiFpN7xWUh/FF660J1lA12IAMGEEev2dv7cBfuAuSVSvy8/X4KO89hcQ==
X-Received: by 2002:a9d:170e:: with SMTP id i14mr11709969ota.356.1622318554383;
        Sat, 29 May 2021 13:02:34 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:33 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 20/34] dyndbg: RFC handle __dyndbg* sections in module.lds.h
Date:   Sat, 29 May 2021 14:00:15 -0600
Message-Id: <20210529200029.205306-21-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until now, loadable modules have tacitly linked the 2 __dyndbg*
sections into the .ko, as observable in log by enabling module.c's
pr_debugs and loading a module.

But now, we need to explicitly compose our named output sections,
placing the header sections in front of their respective __dyndbg*
input sections.  We reuse input section names for the output.

This gives us the placement we need for the header record, which we
can see in the "add-module:"s and elements "0 0" below:

    "0 0" lines are headers: predicate (function==module && !lineno)
    "X debug prints in" are 1 too high, they count headers.
    we are adding tables for empty modules (1st 2 below)

[    7.578873] dyndbg: add-module: ghash_clmulni_intel
[    7.579716] dyndbg:  0 0 ghash_clmulni_intel.ghash_clmulni_intel.0
[    7.608995] dyndbg:   1 debug prints in module ghash_clmulni_intel
[    8.078085] dyndbg: add-module: rapl
[    8.078977] dyndbg:  0 0 rapl.rapl.0
[    8.079584] dyndbg:   1 debug prints in module rapl
[    8.082009] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
[    8.099294] dyndbg: add-module: intel_rapl_common
[    8.100177] dyndbg:  0 0 intel_rapl_common.intel_rapl_common.0
[    8.101026] dyndbg:  1 1 intel_rapl_common.rapl_remove_package.1279
[    8.101931] dyndbg:  2 2 intel_rapl_common.rapl_detect_domains.1245
[    8.102836] dyndbg:  3 3 intel_rapl_common.rapl_detect_domains.1242
[    8.103778] dyndbg:  4 4 intel_rapl_common.rapl_package_register_powercap.1159
[    8.104960] dyndbg:  5 5 intel_rapl_common.rapl_package_register_powercap.1145
[    8.106246] dyndbg:  6 6 intel_rapl_common.rapl_package_register_powercap.1114
[    8.107302] dyndbg:  7 7 intel_rapl_common.rapl_package_register_powercap.1108
[    8.108338] dyndbg:  8 8 intel_rapl_common.rapl_update_domain_data.1083
[    8.109278] dyndbg:  9 9 intel_rapl_common.rapl_check_unit_atom.824
[    8.110255] dyndbg:  10 10 intel_rapl_common.rapl_check_unit_core.796
[    8.111361] dyndbg:  11 11 intel_rapl_common.rapl_read_data_raw.722
[    8.112301] dyndbg:  12 12 intel_rapl_common.contraint_to_pl.303
[    8.113276] dyndbg:  13 debug prints in module intel_rapl_common
[    8.130452] dyndbg: add-module: intel_rapl_msr
[    8.131140] dyndbg:  0 0 intel_rapl_msr.intel_rapl_msr.0
[    8.132026] dyndbg:  1 1 intel_rapl_msr.rapl_msr_probe.172
[    8.132818] dyndbg:  2 2 intel_rapl_msr.rapl_msr_read_raw.104
[    8.133794] dyndbg:   3 debug prints in module intel_rapl_msr

This gives us the property we need:

   fixed offset from &__dyndbg[N] to &__dyndbg[0]
   container_of gets &header
   header has ptr to __dyndbg_sites[]
   we can (in principle) drop __dyndbg.site ptr
   (after we adapt header to keep it)

TODO:

At this point, for loaded modules, ddebug_add_module() sees the header
as 0'th element, as we need in order to drop site (and regain worst
case footprint parity).

It could/should properly init this header to support the _sites[n]
lookup for loaded mods.  Or at least handle it explicitly.  Or at
least see what proc-show does with it currently.

Note that for builtins, decided by (__start <= dp < __stop), we use
__start___dyndbg_sites[N] directly, and dont need the header.

But maybe we should use it anyway, double-checking/BUGing when wrong.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/module.lds.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/module.lds.h b/include/asm-generic/module.lds.h
index f210d5c1b78b..70e744c953f5 100644
--- a/include/asm-generic/module.lds.h
+++ b/include/asm-generic/module.lds.h
@@ -4,7 +4,14 @@
 
 /*
  * <asm/module.lds.h> can specify arch-specific sections for linking modules.
- * Empty for the asm-generic header.
+ *
+ * Normally, sections get thru tacitly, but for CONFIG_DYNAMIC_DEBUG,
+ * we need to insert the .gnu.linkonce sections into the output
+ * sections, so we have to say everything explicitly.
  */
+SECTIONS {
+__dyndbg_sites	: ALIGN(8) { *(.gnu.linkonce.dyndbg_site) *(__dyndbg_sites) }
+__dyndbgs	: ALIGN(8) { *(.gnu.linkonce.dyndbg)	  *(__dyndbgs) }
+}
 
 #endif /* __ASM_GENERIC_MODULE_LDS_H */
-- 
2.31.1

