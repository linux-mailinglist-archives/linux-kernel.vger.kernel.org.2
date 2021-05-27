Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AFD39312C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhE0Oof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:44:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39663 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbhE0Oob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:44:31 -0400
Received: from mail-ua1-f72.google.com ([209.85.222.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmHDt-0003qk-UY
        for linux-kernel@vger.kernel.org; Thu, 27 May 2021 14:42:57 +0000
Received: by mail-ua1-f72.google.com with SMTP id d30-20020ab007de0000b029020e2f98646dso285475uaf.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 07:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTOMF3BFhA7Q2GthQd58+C6CYzGKBNh1lIt8RiOHr+I=;
        b=qA5PKoAKWlp2RAbC9FG8iDQv7nOJ7hkUx/Ei8G5mkgpEsN7UyyZjyhXW9aRY/+F4g9
         mrJ8VVpdur+zs5KPjtBZVDSc1o3de+ONDvMiOfxDd2sd/E8hh+64HmdjE1qhIAGu8NE+
         B2Ct4wTe/sWYe1IFPm3k1U/ionQisEvEfUuiGj/ymtfw29b+ILG5+By1ocjAPPxONESc
         uhuCqa3FjabBoA2KnyKuAVkJ3u7q/wegWJdux0pjKoJd9soKgG10SL3ADllTshlY1ab+
         SvvCqmL9+mYgqNMRZzwRCZJ3jDRvgHk1DncKR6MjNM14hYY4Se+gtCxiGip57d5fNJJV
         s13g==
X-Gm-Message-State: AOAM531pT8UYfHZWrhQm6YT2tzwaZgZ2g2vmm2TRGVfgfclPiG8TA0SP
        xbRNbbRlGfhUeRVSL+YQ+F/FIeF7RRXcgOS4iny+i5EGIfn/3xcHRg7py9QlyiQdy5jZQVQXIh+
        pmjvc1CPfc9yX7T6r1DxXlMXylixuF0ZT2///a70sfg==
X-Received: by 2002:a05:6102:b0e:: with SMTP id b14mr2876212vst.30.1622126575373;
        Thu, 27 May 2021 07:42:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzevwVwZgemlOh2sLltMNffk6abW/suavhra9DVql+awEQQDoSpx8ZJb5kpSYBbnBON1vIsDg==
X-Received: by 2002:a05:6102:b0e:: with SMTP id b14mr2876115vst.30.1622126574480;
        Thu, 27 May 2021 07:42:54 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id i7sm459198uab.14.2021.05.27.07.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 07:42:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liu Shuo <b35362@freescale.com>,
        Prabhakar Kushwaha <prabhakar@freescale.com>,
        Li Yang <leoyang.li@nxp.com>,
        Dipen Dudhat <Dipen.Dudhat@freescale.com>,
        linux-kernel@vger.kernel.org, Raghav Dogra <raghav.dogra@nxp.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>
Subject: [RFT PATCH 2/2] memory: fsl_ifc: fix leak of private memory on probe failure
Date:   Thu, 27 May 2021 10:42:40 -0400
Message-Id: <20210527144240.56365-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210527144240.56365-1-krzysztof.kozlowski@canonical.com>
References: <20210527144240.56365-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On probe error the driver should free the memory allocated for private
structure.  Fix this by using resource-managed allocation.

Fixes: a20cbdeffce2 ("powerpc/fsl: Add support for Integrated Flash Controller")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Only build tested.
---
 drivers/memory/fsl_ifc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index a6324044a085..3ee7183b20fb 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -209,7 +209,8 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 
 	dev_info(&dev->dev, "Freescale Integrated Flash Controller\n");
 
-	fsl_ifc_ctrl_dev = kzalloc(sizeof(*fsl_ifc_ctrl_dev), GFP_KERNEL);
+	fsl_ifc_ctrl_dev = devm_kzalloc(&dev->dev, sizeof(*fsl_ifc_ctrl_dev),
+					GFP_KERNEL);
 	if (!fsl_ifc_ctrl_dev)
 		return -ENOMEM;
 
-- 
2.27.0

