Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1279367AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhDVHJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbhDVHJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:09:16 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3BAC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:08:40 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id gv2so12238690qvb.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AoZXrUkv0udXNoT8w/Ft93InRMYUvDvZ87CDQIYBZaw=;
        b=aA9nvDxyuCeSQ4HVCXeg+DEtYFyCJb130yUW3vJxks1Y+9wAkgy9KIjudn4gNT0CZk
         LcooEzOH0tis4RXDQsge4LnwQyVnSYH+VlAiPDCRT39WSuXFXs9NEnJms2pkPdYahjyo
         1/k/WwBntOHmHaiLILClZiNy5zuGAvOY1Sksgkslcu61V7196+ygBeoqGuMJLbXdVgP2
         5j/RUTaFd3H5dD0NvEBQSdWG8jSP71Jc9oUPaeHrH1+f7gQ6+xt3RrtsUrcB6FvvcI1s
         5aWDlWho+uG+LMNRxdfQiaAilqCI595MRuZEGl+9wwiETDP7BJFvualpZFtBcE1BLPsW
         ojwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AoZXrUkv0udXNoT8w/Ft93InRMYUvDvZ87CDQIYBZaw=;
        b=dJbmsK4FzI24saqRwU9+VFPa/KjVzgTeLFDkZcO/kmB94+9GHZK9wOb2eX/wWtDMzd
         tWeIZQ/z7JkF/5H94iGKFFFT00HJvRlT7S9KriAKjqMsJq5xi8gHZix4qUS0DEi2AKse
         lyeWIMdGOP7pwytXyLmMoLA8uYb63YDjl3Q+VR3q57akakeWtqJWRZeYZ37zYjFoJS0Z
         cu1vpddQT0tQZWsQfNM0rZKjovgaJAdQ7aQ0avSl6l/Dk6f8vxSK+ADWygkKVEW4aG0s
         RcrpDzVJQrKmunTTDB4OrSsNhHw4m0l/zl0qjPvBQ4a1OpQ1wsVikX0DOKu/vPuFOHvw
         rgdA==
X-Gm-Message-State: AOAM530kijj/glELKMQNvMtnW5HR7a/A6fDxm2asQmDW3rS4NFxmza4z
        BHn2MvcpnRz5QsUqxh5Brso=
X-Google-Smtp-Source: ABdhPJz819j68z8ZrvwHt6aGkXaKBd8CmPhMQ5J9o9pbkP4mCfkCbf5mVa15tlwx3Dy0Fv2AjoVLTA==
X-Received: by 2002:a0c:f9c5:: with SMTP id j5mr1877385qvo.36.1619075320201;
        Thu, 22 Apr 2021 00:08:40 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([177.35.200.187])
        by smtp.gmail.com with ESMTPSA id w67sm1658329qkc.79.2021.04.22.00.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 00:08:39 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/11] powerpc/pseries/iommu: Find existing DDW with given property name
Date:   Thu, 22 Apr 2021 04:07:21 -0300
Message-Id: <20210422070721.463912-10-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210422070721.463912-1-leobras.c@gmail.com>
References: <20210422070721.463912-1-leobras.c@gmail.com>
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
index 075c6e08f012..3367233a5535 100644
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

