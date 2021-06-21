Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B830C3AF526
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhFUSiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:38:02 -0400
Received: from david.siemens.de ([192.35.17.14]:42896 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230380AbhFUSh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:37:59 -0400
X-Greylist: delayed 1624 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jun 2021 14:37:59 EDT
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 15LI8U5T007004
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 20:08:30 +0200
Received: from [167.87.243.122] ([167.87.243.122])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 15LI8TnN008010;
        Mon, 21 Jun 2021 20:08:29 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] soc: ti: pruss: fix referenced node in error message
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Message-ID: <d6e24953-ea89-fd1c-6e16-7a0142118054@siemens.com>
Date:   Mon, 21 Jun 2021 20:08:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

So far, "(null)" is reported for the node that is missing clocks.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/soc/ti/pruss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index f22ac1edbdd0..afc8aae68035 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -129,7 +129,7 @@ static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
 
 	clks_np = of_get_child_by_name(cfg_node, "clocks");
 	if (!clks_np) {
-		dev_err(dev, "%pOF is missing its 'clocks' node\n", clks_np);
+		dev_err(dev, "%pOF is missing its 'clocks' node\n", cfg_node);
 		return -ENODEV;
 	}
 
-- 
2.26.2
