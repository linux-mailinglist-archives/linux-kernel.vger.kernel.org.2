Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8A130AED6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhBASOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhBASOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:14:35 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB49C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:13:54 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id e9so10470636plh.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b+kKbPCM5QoqG+cAM7BJq0jTSCBBxgPJ++jOnTflRKg=;
        b=cFsuGWLqZGXtcoWEE6SkenuYrfeXD7dE3JlwBdjuyByI2PGOyWc848IIP2VMjqFNZO
         iJHxp9A/9twFqd/E2hEpmG1bylTBTz7mSY3IhXfJrIEB5Dg+fEJMcsMGHV8eBtH1gZu9
         2ecqEQgbAdSY3fnSaNiYkTSsULft83XwWXV37WTFKaC7w4l8EI/38mLQFebQZw/Vg7BT
         YqCGhLXZrnP7X/C6eIwJTWX6F821CCQgPvLYRV6pIUJzVI+ZJUB2PTHNYFoxyVdqMS5r
         EslxIMEarkAqcKrW3W2Y60bT5TGXFB/sdeDExia8Te1w/vPPhWOh7CnRjGfgJgzx+ep8
         v98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b+kKbPCM5QoqG+cAM7BJq0jTSCBBxgPJ++jOnTflRKg=;
        b=psQOpDmpibbzX1Vk6tOzf5Nvry9d1+Fb2jyLQWd3/e5O6MkxXE43m9iFxmVCR0ORZB
         dke+XPi1LYFtOA0Fsn7lnCDKUWvqVxc4xYu6DiOljb34q4Ql7CrGNt1MF79KvzP0HBAR
         YYVQGkd2OOICjYQI+GtogSE8SwfUceWXBoTdmjj4AsWO3YT1/2TJ8+XIj5r3KAma6jHF
         xKxBQnecUuPJorm0MZ3HXvXPjTbMU7UzxlI3rcNbyBdTa6Wyh3xyj4pOGGam+cr02Yf9
         H73Y/Min9nRvRzZ86Z+yAjST2OEONncQViyVMGp/PVi0gBb9TmBhp/tzIrkmSTzDfZgw
         9KUQ==
X-Gm-Message-State: AOAM533Ezmq4GmXOUV2HFkGPtA5wdNFPBLYhhS1MgYZJPd62Qb66ZI/T
        RcRCjEtXDesVbVejglUeSnMZKQ==
X-Google-Smtp-Source: ABdhPJzQ1f1Hgx/4Da5FS+4mKuRxEPGRYlAIhEpnhnpzJ6rV6iLHUQF9XPG3g9NECjecf+Yt7722dg==
X-Received: by 2002:a17:902:ba85:b029:de:ba16:818b with SMTP id k5-20020a170902ba85b02900deba16818bmr18585225pls.75.1612203233966;
        Mon, 01 Feb 2021 10:13:53 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:13:53 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/31] coresight: cti: Reduce scope for the variable 'cs_fwnode' in cti_plat_create_connection()
Date:   Mon,  1 Feb 2021 11:13:21 -0700
Message-Id: <20210201181351.1475223-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>

A local variable was used only within an else branch.
Thus move the definition for the variable “cs_fwnode” into
the corresponding code block.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Link: https://lore.kernel.org/r/c1b09b27-9012-324f-28d0-ba820dc468a5@web.de
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cti-platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
index 98f830c6ed50..ccef04f27f12 100644
--- a/drivers/hwtracing/coresight/coresight-cti-platform.c
+++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
@@ -343,7 +343,6 @@ static int cti_plat_create_connection(struct device *dev,
 {
 	struct cti_trig_con *tc = NULL;
 	int cpuid = -1, err = 0;
-	struct fwnode_handle *cs_fwnode = NULL;
 	struct coresight_device *csdev = NULL;
 	const char *assoc_name = "unknown";
 	char cpu_name_str[16];
@@ -397,8 +396,9 @@ static int cti_plat_create_connection(struct device *dev,
 		assoc_name = cpu_name_str;
 	} else {
 		/* associated device ? */
-		cs_fwnode = fwnode_find_reference(fwnode,
-						  CTI_DT_CSDEV_ASSOC, 0);
+		struct fwnode_handle *cs_fwnode = fwnode_find_reference(fwnode,
+									CTI_DT_CSDEV_ASSOC,
+									0);
 		if (!IS_ERR(cs_fwnode)) {
 			assoc_name = cti_plat_get_csdev_or_node_name(cs_fwnode,
 								     &csdev);
-- 
2.25.1

