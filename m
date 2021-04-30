Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2B436FEA2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhD3Qdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 12:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhD3Qd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 12:33:27 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0EBC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:32:37 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id y12so52036497qtx.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OiXGBYh6AS1+vJXONKdcYd62wJfq7GaysjOR/jycH2Q=;
        b=TN6LtF3Th4ycVIHgYe+3cJJ5SMJSRQY1Hbw219ZaRTEgz9f9UAqQooUSDndK23sBZ4
         E75o/7cqX14DfdeVWzPjC+mzXZGpkvDHKqYMYInaewBhIMUhqTYwO55b3Pv5sGy8P3Qr
         jrK3WvBBfisDFFS9OFxB4MPNWCs6XWzTC4Ct0iHH3PC6B5H0dH2PmsQwRgOrenRoYhCb
         zY8wI6HwIc2Ua7ukZSfzStkcavFAsbESeyIxbYbGcNkcLBUtZlc7dSyYfh1CW9H5ygSM
         zAj2V0IsPn6QMev111eJcs4/n1RcJq6WwR7hcBBByyL525byI2p5EaAMIFoM1G2+Xr+V
         v+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OiXGBYh6AS1+vJXONKdcYd62wJfq7GaysjOR/jycH2Q=;
        b=mG2uDSB0fj8JNk8iXfaOgzK6EnKI0D5yKzO5rPZy/M96rRihjaJUeYh1IUqxx9xEKt
         WEkHjWvv7MPs90fN1SEushjaR9W/61mp4ORfnf7IK3GyWwon/8YZK6ujVXZWMp7fhObD
         4KrfsrSwuNSNh7Tl1/2+ow0lXUG+H9t7wU3lCF0Tjiguj2UkLwXHfMJkupUwKfyPicA5
         pj74u8IRjtYEeVolazx+SDRokb/A7bge+uPffWbKvalBkhAcTe7TeI+vjoS3bLsv4sVh
         MDwCPcwBpazCqjEbzSJfDqGEQNR6A7kz8a6WtyTI4SmwjI4gPYCKGBiPZCD8pVjTbbiO
         kuaQ==
X-Gm-Message-State: AOAM530+umWiZ/xGvwVl7aatkvRsZm3Ti7HxXb+XAOCMX2kDoD2knVEx
        lKlK0z/Mk8D5JJucoVMrq94=
X-Google-Smtp-Source: ABdhPJzpMLibl6PMQhMsgv1f/vDJB0UrlvMRFvCJ7wpvliS1xYrO2p1k59nH7YaLFUjnf8ZtnUSqDQ==
X-Received: by 2002:ac8:584f:: with SMTP id h15mr5310682qth.97.1619800357053;
        Fri, 30 Apr 2021 09:32:37 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([2804:14c:482:7b04::1001])
        by smtp.gmail.com with ESMTPSA id p1sm2624334qtu.89.2021.04.30.09.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 09:32:36 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/11] powerpc/pseries/iommu: Find existing DDW with given property name
Date:   Fri, 30 Apr 2021 13:31:44 -0300
Message-Id: <20210430163145.146984-10-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210430163145.146984-1-leobras.c@gmail.com>
References: <20210430163145.146984-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment pseries stores information about created directly mapped
DDW window in DIRECT64_PROPNAME.

With the objective of implementing indirect DMA mapping with DDW, it's
necessary to have another propriety name to make sure kexec'ing into older
kernels does not break, as it would if we reuse DIRECT64_PROPNAME.

In order to have this, find_existing_ddw_windows() needs to be able to
look for different property names.

Extract find_existing_ddw_windows() into find_existing_ddw_windows_named()
and calls it with current property name.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index f8922fcf34b6..de54ddd9decd 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -888,24 +888,21 @@ static struct direct_window *ddw_list_new_entry(struct device_node *pdn,
 	return window;
 }
 
-static int find_existing_ddw_windows(void)
+static void find_existing_ddw_windows_named(const char *name)
 {
 	int len;
 	struct device_node *pdn;
 	struct direct_window *window;
-	const struct dynamic_dma_window_prop *direct64;
-
-	if (!firmware_has_feature(FW_FEATURE_LPAR))
-		return 0;
+	const struct dynamic_dma_window_prop *dma64;
 
-	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
-		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
-		if (!direct64 || len < sizeof(*direct64)) {
-			remove_ddw(pdn, true, DIRECT64_PROPNAME);
+	for_each_node_with_property(pdn, name) {
+		dma64 = of_get_property(pdn, name, &len);
+		if (!dma64 || len < sizeof(*dma64)) {
+			remove_ddw(pdn, true, name);
 			continue;
 		}
 
-		window = ddw_list_new_entry(pdn, direct64);
+		window = ddw_list_new_entry(pdn, dma64);
 		if (!window)
 			break;
 
@@ -913,6 +910,14 @@ static int find_existing_ddw_windows(void)
 		list_add(&window->list, &direct_window_list);
 		spin_unlock(&direct_window_list_lock);
 	}
+}
+
+static int find_existing_ddw_windows(void)
+{
+	if (!firmware_has_feature(FW_FEATURE_LPAR))
+		return 0;
+
+	find_existing_ddw_windows_named(DIRECT64_PROPNAME);
 
 	return 0;
 }
-- 
2.30.2

