Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B40F432E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 08:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhJSGcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 02:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJSGcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:32:02 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0597C06161C;
        Mon, 18 Oct 2021 23:29:50 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id c4so11385069pgv.11;
        Mon, 18 Oct 2021 23:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dnXn+h5taVTZko0OST5Rrf452xL+m2nCHrGrWQWsoO8=;
        b=pL4ipHDmG3TfyQE5wlMTOb8U/OdBLqTm607+cLDZdIFBBFRpgfFMDf45EWwDFFVbg8
         liUD57wxDtfz3Hg+kwalp2G9MJEYVeC8M55bEmf7+riBxIZtxEtMCXQDUHb5Pi9wD2bw
         pv8dKByL5OobbvsJG6jQ08xkwPQGwY4cP4Oa78d3dhrNTetjPFDCYLwdJvF271RaBhgx
         CK8ETdWLB879kZldQWhqCopY7baJMQgz8BN/iZIJLoUbx5M59dd4azMftALHWC22bPzj
         D7hxx5kcPa5nCWQgpnXejbm5Z5T9MINwkfEodZbo/32G4lAv3/hhwa323Q68d9xKnla4
         mgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dnXn+h5taVTZko0OST5Rrf452xL+m2nCHrGrWQWsoO8=;
        b=Ojnl6N4+QpfxO8hcL5fQ/8be3Uw9YG538t2FmXph7zcR7GAmRqBUV1x/sFu3/Zzcx0
         grPBGnc3nDX/LBwANJKllgXOpNwCXKYxSx25UcRd6qyznl3xKoI5GyjB1AJYKw+YDOcL
         A9Umrrw7yyMf53sd6ug3huF8YW+5wBKFm/WqW2HhvJa5ZO2mjsMlEVkV7S171TUINhHu
         6ZCaqmLmGRTFxAssiYkW2GDdOySfFVAZLjb4g/YCXVa6UT3Vcv3VKDrf5Ljcv4HO/0Ka
         zRgI/5rVIESPjOwT4z93FLuzhcssUtx1YXtAgI5g8Ha7h2b0NFy5XhsR20Z0pOUBywSA
         OeeQ==
X-Gm-Message-State: AOAM5306xMIh9d0aNsOFAIDsyHY9ltPRhzNIOAkh4XRH7FPpa8wglEGG
        +dfY9st/ao6iIKkh7RBudQE=
X-Google-Smtp-Source: ABdhPJwExjdwTxD3Dj/lgIOSPSS3R74iQXiAt6bQeFWHIwggACFsS+Lj/fzO+5rgWMmY8wHSm3+4xg==
X-Received: by 2002:a05:6a00:2390:b0:44d:bccd:7bc with SMTP id f16-20020a056a00239000b0044dbccd07bcmr16462708pfc.4.1634624990209;
        Mon, 18 Oct 2021 23:29:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d14sm6469690pfu.124.2021.10.18.23.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 23:29:49 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     mturquette@baylibre.com, wenst@chromium.org
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com, ran.jianping@zte.com.cn,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2 clk:mediatek] clk:mediatek: remove duplicate include in  clk-mt8195-imp_iic_wrap.c
Date:   Tue, 19 Oct 2021 06:29:39 +0000
Message-Id: <20211019062939.979660-1-ran.jianping@zte.com.cn>
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

v2:
  delete extra empty line.

---
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c | 2 --
 1 file changed, 2 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
index 0e2ac0a30aa0..1aa5afc05929 100644
--- a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
@@ -10,8 +10,6 @@
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
 
-#include <dt-bindings/clock/mt8195-clk.h>
-
 static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
 	.set_ofs = 0xe08,
 	.clr_ofs = 0xe04,
-- 
2.25.1

