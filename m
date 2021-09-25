Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1182A417F82
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 05:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347790AbhIYDb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 23:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343920AbhIYDb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 23:31:27 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DFDC061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 20:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=YXq0yg/+s7gyJxLsGmCyiqJhXQyWvjLSfEUQmNba9eY=; b=YJE3pEYZM0XUFsN/dQLItrvz3O
        8N5LCDnlBVEfG8K6Vi4MOFcZbljYyBfl7106vhBMV8CsHtN6lSCuISMxpB3XJph86SMw5EEV4wmT9
        FQ1mrMUBeUSLj7JGNN8G7v1KdSnFR21XvH4OMHhtmwR/xLNL90uVBzENRfGAiVTyY+vX3eO/ivQOI
        4DQxuN/dR7DfVyRP7aY9vmGmefDbO33Hfdyy7LsKmKinzqbCNHNYSSarLg7nJQiXiTER9th4TUzBH
        Sv0aGudYb945G8P5+HHcIILIdDBHpVjWUxuEcURoG6nOMgSRJv+mZGbNcM6WBddMydNog148QMHuD
        rPuxVWmw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTyNs-00G3Ol-EW; Sat, 25 Sep 2021 03:29:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org
Subject: [RFC PATCH] xtensa: setup: use CONFIG_USE_OF instead of CONFIG_OF
Date:   Fri, 24 Sep 2021 20:29:51 -0700
Message-Id: <20210925032951.6767-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_OF can be set by a randconfig or by a user -- without setting the
early flattree option (OF_EARLY_FLATTREE).  This causes build errors.
However, if randconfig or a user sets USE_OF in the Xtensa config,
the right kconfig symbols are set to enable xtensa/kernel/setup.c to
build.

Fixes these build errors:

../arch/xtensa/kernel/setup.c: In function 'xtensa_dt_io_area':
../arch/xtensa/kernel/setup.c:201:14: error: implicit declaration of function 'of_flat_dt_is_compatible'; did you mean 'of_machine_is_compatible'? [-Werror=implicit-function-declaration]
  201 |         if (!of_flat_dt_is_compatible(node, "simple-bus"))
../arch/xtensa/kernel/setup.c:204:18: error: implicit declaration of function 'of_get_flat_dt_prop' [-Werror=implicit-function-declaration]
  204 |         ranges = of_get_flat_dt_prop(node, "ranges", &len);
../arch/xtensa/kernel/setup.c:204:16: error: assignment to 'const __be32 *' {aka 'const unsigned int *'} from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
  204 |         ranges = of_get_flat_dt_prop(node, "ranges", &len);
      |                ^
../arch/xtensa/kernel/setup.c: In function 'early_init_devtree':
../arch/xtensa/kernel/setup.c:228:9: error: implicit declaration of function 'early_init_dt_scan'; did you mean 'early_init_devtree'? [-Werror=implicit-function-declaration]
  228 |         early_init_dt_scan(params);
../arch/xtensa/kernel/setup.c:229:9: error: implicit declaration of function 'of_scan_flat_dt' [-Werror=implicit-function-declaration]
  229 |         of_scan_flat_dt(xtensa_dt_io_area, NULL);

Fixes: da844a81779e ("xtensa: add device trees support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/kernel/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20210917.orig/arch/xtensa/kernel/setup.c
+++ linux-next-20210917/arch/xtensa/kernel/setup.c
@@ -183,7 +183,7 @@ static int __init parse_bootparam(const
 }
 #endif
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_USE_OF
 
 #if !XCHAL_HAVE_PTP_MMU || XCHAL_HAVE_SPANNING_WAY
 unsigned long xtensa_kio_paddr = XCHAL_KIO_DEFAULT_PADDR;
@@ -232,7 +232,7 @@ void __init early_init_devtree(void *par
 		strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 }
 
-#endif /* CONFIG_OF */
+#endif /* CONFIG_USE_OF */
 
 /*
  * Initialize architecture. (Early stage)
@@ -253,7 +253,7 @@ void __init init_arch(bp_tag_t *bp_start
 	if (bp_start)
 		parse_bootparam(bp_start);
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_USE_OF
 	early_init_devtree(dtb_start);
 #endif
 
