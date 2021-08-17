Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07D43EE6B0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 08:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbhHQGlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 02:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238222AbhHQGk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 02:40:58 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950BFC0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:40:25 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x1so2891726qtw.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rpa8D3N/U7YRxvFW0CzHkpRMhz6bKnxNujofI9Dw/U4=;
        b=admbMO5SOXR6pazzWogTfD0bs52/z1T4mY0zJNH8E0yZuVTEePne13ZBUM4X7HqezB
         7lon47yTuzBmHMrNXdpF8rJl2tLDovptvNYtX2iP/OiuMbd7+ugeVqwLZWoBQMXHHgqV
         O2UD/JCkNDIk/DHB/S7NzOoBkT0WUof4JQGIRGGLnI5bcasIMmbIjTALfOer7ny2kEQD
         DbqeeLAIheZBzY4UYIgvYMFayaz/eGKvFd5TxTGQCQv4/qK31nLNUGsKlP2+LxHeOHvu
         7veD5sehqn148IrzJCMZEweYx7/o1YRCHMqLY1n0r/cGB2h0y+VQv0AXPldTOZQgbD0W
         IKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpa8D3N/U7YRxvFW0CzHkpRMhz6bKnxNujofI9Dw/U4=;
        b=Q7nehqO5GE7C3hb51U5LLbM3VXxhy1zRO8LzQ+5mlwiJ4D06r0JFIjxRbxJ3e7QC4o
         ACXZTzXKx0C5YV7Na03OUX7E1+/1okU3Q5AyVXF0gYjr3BnRojfvTvn8VRt652xrnIB+
         GM/+JyVJ9v62TdwSOzQdYczOiaSiVpvPCmcN129MXhWV976hvDEPl6sR0S1cJ8r6SGug
         In6Dit1W7/HEWaCuvet+Vw+N1a45QOW8I3bUW7g37eoK10WbZL742QhqozEgO7FbrBRK
         DaFU1vzAa4kODFl49SA8ps7Ebx0KXNJcQ/hLYgDVcgJGJ/HpT0+6ekX8RoukGfvEEM2v
         +h1w==
X-Gm-Message-State: AOAM530lYoRUvuXW98PgDQ+d9GPdtdjq6Sb4s/ij9UXCvW7bZykkyLFM
        D/tdH7JPo7o45Zl0gQ4TrIA=
X-Google-Smtp-Source: ABdhPJxEvclZm7VvFy7GURUqpud+J60nI5WXGBRNSirUiyjGK2d9qcZFNYlmruBzR41ZPLbgX+pEkg==
X-Received: by 2002:ac8:5dc7:: with SMTP id e7mr1706135qtx.94.1629182424864;
        Mon, 16 Aug 2021 23:40:24 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:431:c7f0:30b2:5c9e:50:88f3:269a])
        by smtp.gmail.com with ESMTPSA id c11sm526938qth.29.2021.08.16.23.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 23:40:24 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/11] powerpc/pseries/iommu: Add ddw_list_new_entry() helper
Date:   Tue, 17 Aug 2021 03:39:22 -0300
Message-Id: <20210817063929.38701-5-leobras.c@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817063929.38701-1-leobras.c@gmail.com>
References: <20210817063929.38701-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two functions creating direct_window_list entries in a
similar way, so create a ddw_list_new_entry() to avoid duplicity and
simplify those functions.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 32 +++++++++++++++++---------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 33d82865d6e6..712d1667144a 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -874,6 +874,21 @@ static u64 find_existing_ddw(struct device_node *pdn, int *window_shift)
 	return dma_addr;
 }
 
+static struct direct_window *ddw_list_new_entry(struct device_node *pdn,
+						const struct dynamic_dma_window_prop *dma64)
+{
+	struct direct_window *window;
+
+	window = kzalloc(sizeof(*window), GFP_KERNEL);
+	if (!window)
+		return NULL;
+
+	window->device = pdn;
+	window->prop = dma64;
+
+	return window;
+}
+
 static int find_existing_ddw_windows(void)
 {
 	int len;
@@ -886,18 +901,15 @@ static int find_existing_ddw_windows(void)
 
 	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
 		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
-		if (!direct64)
-			continue;
-
-		window = kzalloc(sizeof(*window), GFP_KERNEL);
-		if (!window || len < sizeof(struct dynamic_dma_window_prop)) {
-			kfree(window);
+		if (!direct64 || len < sizeof(*direct64)) {
 			remove_ddw(pdn, true);
 			continue;
 		}
 
-		window->device = pdn;
-		window->prop = direct64;
+		window = ddw_list_new_entry(pdn, direct64);
+		if (!window)
+			break;
+
 		spin_lock(&direct_window_list_lock);
 		list_add(&window->list, &direct_window_list);
 		spin_unlock(&direct_window_list_lock);
@@ -1307,7 +1319,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	dev_dbg(&dev->dev, "created tce table LIOBN 0x%x for %pOF\n",
 		  create.liobn, dn);
 
-	window = kzalloc(sizeof(*window), GFP_KERNEL);
+	window = ddw_list_new_entry(pdn, ddwprop);
 	if (!window)
 		goto out_clear_window;
 
@@ -1326,8 +1338,6 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		goto out_free_window;
 	}
 
-	window->device = pdn;
-	window->prop = ddwprop;
 	spin_lock(&direct_window_list_lock);
 	list_add(&window->list, &direct_window_list);
 	spin_unlock(&direct_window_list_lock);
-- 
2.32.0

