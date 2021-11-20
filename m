Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B09457C04
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 07:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbhKTGa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 01:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbhKTGaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 01:30:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799C8C061574;
        Fri, 19 Nov 2021 22:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=PbHcHIDGnaO98GdsC8MJFh1P9E0OzFrxVx/JQdU71tA=; b=2zo/LHdD88ho3wj6CMV0SQwLpW
        YQ1cLae5g9M0jKDve67uVKRMHH5Qn7qE3wLO1OCmZ3qNIRgtwZFl3+kAgJh/36Lv+TYZzQ1cdpN/J
        MOkT4zHzFUEwi4a03/Rud5CPw8LgVxB5obB5RY8XC7qB2QebJAg66xovpyEgEP2e1xzrwcLnbFX58
        j1GR+Al2fwKyrNsCCScayvySxS/xveLXkpj5oa2ij2prljre190rrwQaRbViV71jN6jP04zXEnLZT
        znJzL7SCj/PpWBDefyw0jo5jcCy+2BKX2+XQ/VRepDEJWlRHm8AXOpHCEbOLgtQlxDA5YsAf4ppor
        Aba+0jLg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1moJqK-00C73R-4F; Sat, 20 Nov 2021 06:27:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org
Subject: [PATCH] clk: Gemini: fix struct name in kernel-doc
Date:   Fri, 19 Nov 2021 22:27:19 -0800
Message-Id: <20211120062719.21395-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in the struct name in the kernel-doc notation so that
kernel-doc won't complain about it.

Fixes this warning:

drivers/clk/clk-gemini.c:64: warning: expecting prototype for struct gemini_data_data. Prototype was for struct gemini_gate_data instead

Fixes: 846423f96721 ("clk: Add Gemini SoC clock controller")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: linux-clk@vger.kernel.org
---
 drivers/clk/clk-gemini.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211118.orig/drivers/clk/clk-gemini.c
+++ linux-next-20211118/drivers/clk/clk-gemini.c
@@ -50,7 +50,7 @@ static DEFINE_SPINLOCK(gemini_clk_lock);
 #define PCI_DLL_TAP_SEL_MASK		0x1f
 
 /**
- * struct gemini_data_data - Gemini gated clocks
+ * struct gemini_gate_data - Gemini gated clocks
  * @bit_idx: the bit used to gate this clock in the clock register
  * @name: the clock name
  * @parent_name: the name of the parent clock
