Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416A5347BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbhCXPEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhCXPEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:04:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE097C061763;
        Wed, 24 Mar 2021 08:04:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so1319517pjc.2;
        Wed, 24 Mar 2021 08:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y7euH5yOXTToONzoAXK5U4+rRHWz0rknjZEdozlEFGw=;
        b=VDCYMZ2i+UIkF0bRoD2Wegyzez8CwM5rqvICzEoxsB6zjeY9rww4o0iyd1EWqC3TeO
         bXZcKWFXVblSc7OAxQr9xSGNT2IiDH3VHWAz8jADMbKCtaWx2roO443CZoI2UieiTbRi
         0wQxzd8MLUhO62RdnK8yGw+26dDTL/T7rlfaDCFBvoCtnkiuJg+KdYLr2eYHVPp7ZFWU
         b+Wsv3vyNjjMpEL4iA3kKvAj77w+mJJl7puk53sBCE+q0XFCuJL7qT9gnywZyDTg9SKy
         TNyWf50ojJ/8SmQGYyh4qmt12gB+9LLA+gqKicBQYfkLzgk2v4JHQ8dJ9o83P28PHBtU
         vxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y7euH5yOXTToONzoAXK5U4+rRHWz0rknjZEdozlEFGw=;
        b=PGPyQQliw8HS5TgXjzIgNjUgC57PpJ4p50HbzmbYNa6U2HRE3HL6U8oMfGLnpkjwl+
         +1CJbi5buLRklo+F2VAh9+si3CVBUz0dqzTtgbevg/XtLvBJjxrFnf7MlY/1ah5/2nWp
         nyXDGSXk2MiTYwIgtDoS1/jJR1tpoCbLxA1gl3ZW3gy48dwHllO0xljveF7enBdkW8RL
         +ZLLo6OC+noYFrACjU7U1ItlYLNN3AlrUFzb9MqkFkQ/eB+ptYZ32uY6M3CuXdbVFxm9
         1UbrixF7DfgDCbuo4U6PYfTwfPDmuUgksHPID3YpiHtsjIsyi6Tt4wrZSvtKHDqSP4HX
         CgnQ==
X-Gm-Message-State: AOAM5303IsgS5xdBzMXti8NWPtjT/yxNmGSBbFKaQY3W4c3rfsKG9/4P
        u6fj9gasLVb5Cet89ndxCGOpQ+BMOpxJn0Iv
X-Google-Smtp-Source: ABdhPJwG07AWe19Exd7mzxFlBqC6ckXmmi3aIfICqr07BirPFjhw2GdWzyAu02x8ucx4dzOJdxJdjg==
X-Received: by 2002:a17:902:8bc3:b029:e6:8d84:4d50 with SMTP id r3-20020a1709028bc3b02900e68d844d50mr3959677plo.31.1616598272391;
        Wed, 24 Mar 2021 08:04:32 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id l20sm3070700pfd.82.2021.03.24.08.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 08:04:32 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] of/fdt: Check dtb pointer first in unflatten_device_tree
Date:   Wed, 24 Mar 2021 23:04:25 +0800
Message-Id: <20210324150425.20688-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setup_arch() would invoke unflatten_device_tree() even no
valid fdt found. So we'd better check it first and return early.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 drivers/of/fdt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index dcc1dd96911a..05d439d63bc5 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1225,6 +1225,11 @@ bool __init early_init_dt_scan(void *params)
  */
 void __init unflatten_device_tree(void)
 {
+	if (!initial_boot_params) {
+		pr_warn("No valid device tree found, continuing without\n");
+		return;
+	}
+
 	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
 				early_init_dt_alloc_memory_arch, false);
 
-- 
2.30.2

