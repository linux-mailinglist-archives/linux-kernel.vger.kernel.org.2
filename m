Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCFC331480
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhCHRTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhCHRSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:18:37 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E265EC06174A;
        Mon,  8 Mar 2021 09:18:36 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b7so15860709edz.8;
        Mon, 08 Mar 2021 09:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r9qTSZ8pXkbJjsf87TrGpRoyj07qm0gGBH/J86fk7+Y=;
        b=BLmR99duGmJJ0gfn5ATU+9mnhp/peA1yLufD1JIV/qJYRIsqXjxNUjdEs81EsZLBuk
         aGJQjYXR6ZEnqaF65TJ91SQMlzSyPpWvK4rRiwENkcC+VsHEMjGuXLAy3yvKPsF2iGhW
         YKH0Z/6V5B5qMevFVMSlHo8uYRvqyTudIV/ezT2fblT7MLRO7ZuCY+ueXsSQoAJeFGhB
         mICHtwiDGgvgYjrJNxiuIkmP+UF+dQ0LQfDClrC/tGV507WQ9Pm20Kd6o/M1trFikBWW
         +zfvQ7IWOMFmJgPaWmSnXBGb7I6k+fyXIubNqVgN9dOKkbwuwyG497pK/y3WGx9CCGvV
         16ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r9qTSZ8pXkbJjsf87TrGpRoyj07qm0gGBH/J86fk7+Y=;
        b=eFnHy9U13rxLA8qYTaZka3y/Sfs/CTFpuKDlWo8ps0adwLCSYocJA9NPuQ+aMVRet1
         iB+lwSk0M3pMzFlP/NtvlSYgOzQC1onYqHD69ohYJwKyDMgTrv3WIZGITlPSmgb3rBXi
         N7XDOQPKG3olVkd+eqDZhFCa6RMbWsXslHixS/2YoLgdSGb/Ve4XtXNXeqdsA+tr6t/D
         bEAAG5TSz2lTPQW/Gwz4JDq4531J1+3ex/4ZEDPdxJvV5bihIcU/Rw9hy1Aq+65uuLM1
         AgqJ0bYoxNKMNzNVsELsy68E3lZHsC9tUnNfk6HwHqVPjss0F3qucN+GKUhO2Bh1igGS
         6ldA==
X-Gm-Message-State: AOAM533LXy35xr15KuKqYYDXWNOUaH8sSEYr2yeuKCUPT2j/uTVNwYk8
        6PFQKwqDu8NoEAK08hPzgaM=
X-Google-Smtp-Source: ABdhPJzutZpnRgcMtQ6TaXSnRWL6adNIER4UuJX8pHUQwy0XQo4hywqUx28dNQ1uWy0ALzfg2letOg==
X-Received: by 2002:a05:6402:1d39:: with SMTP id dh25mr23701758edb.282.1615223914890;
        Mon, 08 Mar 2021 09:18:34 -0800 (PST)
Received: from localhost.localdomain ([81.18.95.223])
        by smtp.gmail.com with ESMTPSA id r5sm7457714eds.49.2021.03.08.09.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:18:34 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/6] clk: actions: Fix UART clock dividers on Owl S500 SoC
Date:   Mon,  8 Mar 2021 19:18:26 +0200
Message-Id: <3d3118fc3e0973cc1cbbdbb98b643f0c82dd74fc.1615221459.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use correct divider registers for the Actions Semi Owl S500 SoC's UART
clocks.

Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/clk/actions/owl-s500.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index 61bb224f6330..75b7186185b0 100644
--- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -305,7 +305,7 @@ static OWL_COMP_FIXED_FACTOR(i2c3_clk, "i2c3_clk", "ethernet_pll_clk",
 static OWL_COMP_DIV(uart0_clk, "uart0_clk", uart_clk_mux_p,
 			OWL_MUX_HW(CMU_UART0CLK, 16, 1),
 			OWL_GATE_HW(CMU_DEVCLKEN1, 6, 0),
-			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
+			OWL_DIVIDER_HW(CMU_UART0CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
 			CLK_IGNORE_UNUSED);
 
 static OWL_COMP_DIV(uart1_clk, "uart1_clk", uart_clk_mux_p,
@@ -317,31 +317,31 @@ static OWL_COMP_DIV(uart1_clk, "uart1_clk", uart_clk_mux_p,
 static OWL_COMP_DIV(uart2_clk, "uart2_clk", uart_clk_mux_p,
 			OWL_MUX_HW(CMU_UART2CLK, 16, 1),
 			OWL_GATE_HW(CMU_DEVCLKEN1, 8, 0),
-			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
+			OWL_DIVIDER_HW(CMU_UART2CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
 			CLK_IGNORE_UNUSED);
 
 static OWL_COMP_DIV(uart3_clk, "uart3_clk", uart_clk_mux_p,
 			OWL_MUX_HW(CMU_UART3CLK, 16, 1),
 			OWL_GATE_HW(CMU_DEVCLKEN1, 19, 0),
-			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
+			OWL_DIVIDER_HW(CMU_UART3CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
 			CLK_IGNORE_UNUSED);
 
 static OWL_COMP_DIV(uart4_clk, "uart4_clk", uart_clk_mux_p,
 			OWL_MUX_HW(CMU_UART4CLK, 16, 1),
 			OWL_GATE_HW(CMU_DEVCLKEN1, 20, 0),
-			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
+			OWL_DIVIDER_HW(CMU_UART4CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
 			CLK_IGNORE_UNUSED);
 
 static OWL_COMP_DIV(uart5_clk, "uart5_clk", uart_clk_mux_p,
 			OWL_MUX_HW(CMU_UART5CLK, 16, 1),
 			OWL_GATE_HW(CMU_DEVCLKEN1, 21, 0),
-			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
+			OWL_DIVIDER_HW(CMU_UART5CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
 			CLK_IGNORE_UNUSED);
 
 static OWL_COMP_DIV(uart6_clk, "uart6_clk", uart_clk_mux_p,
 			OWL_MUX_HW(CMU_UART6CLK, 16, 1),
 			OWL_GATE_HW(CMU_DEVCLKEN1, 18, 0),
-			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
+			OWL_DIVIDER_HW(CMU_UART6CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
 			CLK_IGNORE_UNUSED);
 
 static OWL_COMP_DIV(i2srx_clk, "i2srx_clk", i2s_clk_mux_p,
-- 
2.30.1

