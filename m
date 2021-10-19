Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4929432B84
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 03:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhJSBk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 21:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJSBkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 21:40:55 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C740FC06161C;
        Mon, 18 Oct 2021 18:38:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s1so10729003plg.12;
        Mon, 18 Oct 2021 18:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CaPcF3lLntgPi4dtmIgmORhsMIR+dCPTrmx/7W3scZs=;
        b=gaS9hJyuilcF5+JKjLFe8um9uxdmcEPQEj276Rpl1z99TTJ1xSi3qSdkS7u9WdEN2G
         /69cd2OVP1xQNkDgmiVmHkNvLM9poNJnhRnoRNxIMAmDs89Mu2GYws8oagVjNC50QMA9
         1AMbuT3AhQDHg/le8tD9rKMLJIoIc9XRIHuLPN02A4L7Jgyo95aGZ24UoAcfZXBIuhR+
         rnIj4/b3R5xvZ6tCuNgNOljEmhcMABeB2urGNFCGFgdSRFDbp4py4AcYuBx+CXm1PF8/
         8M6Purtsg2PM9tVSHYWqq3dexwNwrgzXqDayW6ljPltxrAqjBrx6y9A7WN8/IDTJ75q3
         Bp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CaPcF3lLntgPi4dtmIgmORhsMIR+dCPTrmx/7W3scZs=;
        b=fXQZnSZjK7E45bxbQVDm+rJOWG0/jAOhfWr54bslxJwmO9EuNsAGffF3B7bSV7oQF3
         9PH2CV3dsx312keeljMIAlMZm8ENW37IdMkl41uBOnVMT8uKCuuF+qT1LpK3IAjCwa5i
         T+JLk1mYiV/Mme4BLgn8y/HsBkysNSYfSeYCTlcBvnsj0NRwiyHfpzhXngBrYCrak2rq
         y47d5D7Z4X15evK8MeHNxo59PbsYta1056aU66jhxRk5P1y33XRX69HNfxai3poEKe0D
         aZwulRmauT1odfB8RxMgGqFLYPuoUDPqjIYk2Pwjs5P86Nvmap14QuCtIjviafjzNgy+
         /UWg==
X-Gm-Message-State: AOAM530efr1UZjreRtdMp3tN0hDI33aN4zheYcf8D14W0sjmV2Xi/mTt
        TWtBBXRj4i+N/vOm1qwaAGU=
X-Google-Smtp-Source: ABdhPJyHCs6f10hqJrvEiziHyRg9yorV3VFk0caNl/+VA1adXRXrroKqi1IQvEWZJyezciCO42MWgQ==
X-Received: by 2002:a17:902:70cb:b0:13e:91f3:641a with SMTP id l11-20020a17090270cb00b0013e91f3641amr30226304plt.13.1634607523184;
        Mon, 18 Oct 2021 18:38:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t3sm13660314pgu.87.2021.10.18.18.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 18:38:42 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com, ran.jianping@zte.com.cn,
        wenst@chromium.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH clk:mediatek] clk:mediatek: remove duplicate include in  clk-mt8195-imp_iic_wrap.c
Date:   Tue, 19 Oct 2021 01:37:59 +0000
Message-Id: <20211019013759.970600-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ran Jianping <ran.jianping@zte.com.cn>

'dt-bindings/clock/mt8195-clk.h' included in
'/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c' is duplicated.It is
also included on the 13 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ran Jianping <ran.jianping@zte.com.cn>
---
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
index 0e2ac0a30aa0..1aa5afc05929 100644
--- a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
@@ -10,7 +10,7 @@
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
 
-#include <dt-bindings/clock/mt8195-clk.h>
+
 
 static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
 	.set_ofs = 0xe08,
-- 
2.25.1

