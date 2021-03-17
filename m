Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBD433EF8E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhCQL12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:27:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52533 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhCQL1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:27:00 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lMUKJ-0004ZC-7f
        for linux-kernel@vger.kernel.org; Wed, 17 Mar 2021 11:26:59 +0000
Received: by mail-ej1-f70.google.com with SMTP id v27so10246471ejq.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 04:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W3i1S5nSI5GQ1Rm3eTV6gENUYn6kHPlchBLYEZp476o=;
        b=ENmvYk6+nDZMzN1sZ8IfNtikrrw7MkAjLW7ydWs8DlmQHkt73eMSgc86kfQlE9OuEX
         GwbrFUdi+A/zuFCGLWmStfQyk+NF2HXWCNNLXlOZ/6iKuGIPlwNfbe3nOtv3TzfGi0Xg
         RettGcPqDz7xeGR96opIeQzc0UtBt82gvvOdDHj8WyRpCH046oCzj8+d4YCBBFppQFaR
         G+4PPRC3RZIQBKKc+1H/LLdjC6N1eoNL000e6Ytp+gntigcc+mjXTIkG5N/Gij2zj7R4
         px8L522edFOZOpoES00RoDQYuSntQCLopdArKs/9UTsFIDlcs9OtQtq1zyhIo2uUxGzc
         oPcw==
X-Gm-Message-State: AOAM531IlOKQ9BuEoyYZS7DBOviDccOpxqe+2fOfvWtenmgG2OQfLFKu
        ihR7HSanAq7Zh3o2gMXT3MNXh428sOVQ4cWrsh0D+jZzwtzFyKZrkupNknD4JGLhlkEt7Fv1vrm
        72I0NWGPbyemIFPG60ktzJl9y9e8cvqXzSc4T2aKBuA==
X-Received: by 2002:a05:6402:382:: with SMTP id o2mr42341116edv.238.1615980418961;
        Wed, 17 Mar 2021 04:26:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5x/cDlMw6SaEJj9H5rTOUDY1Yw09Ll4aykisHylVG8DI6vUze0EVsqSRYodfykEC0ngmVbA==
X-Received: by 2002:a05:6402:382:: with SMTP id o2mr42341106edv.238.1615980418807;
        Wed, 17 Mar 2021 04:26:58 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id l18sm11143936ejk.86.2021.03.17.04.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 04:26:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sergei.shtylyov@gmail.com, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, balbi@kernel.org, digetx@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] MIPS: ralink: define stubs for clk_set_parent to fix compile testing
Date:   Wed, 17 Mar 2021 12:26:44 +0100
Message-Id: <20210317112644.24502-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ralink MIPS platform does not use Common Clock Framework and does
not define certain clock operations leading to compile test failures:

    /usr/bin/mips-linux-gnu-ld: drivers/usb/phy/phy-tegra-usb.o: in function `tegra_usb_phy_init':
    phy-tegra-usb.c:(.text+0x1dd4): undefined reference to `clk_get_parent'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: John Crispin <john@phrozen.org>

---

Changes since v1:
1. Use EXPORT_SYMBOL_GPL like two other stubs in the file.
2. Add Ack
---
 arch/mips/ralink/clk.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
index 2f9d5acb38ea..f0bcb1051c30 100644
--- a/arch/mips/ralink/clk.c
+++ b/arch/mips/ralink/clk.c
@@ -70,6 +70,20 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(clk_round_rate);
 
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	WARN_ON(clk);
+	return -1;
+}
+EXPORT_SYMBOL_GPL(clk_set_parent);
+
+struct clk *clk_get_parent(struct clk *clk)
+{
+	WARN_ON(clk);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(clk_get_parent);
+
 void __init plat_time_init(void)
 {
 	struct clk *clk;
-- 
2.25.1

