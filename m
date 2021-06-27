Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BF93B541F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 17:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhF0P5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 11:57:02 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:57036 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhF0P5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 11:57:00 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d54 with ME
        id NFuY2500E21Fzsu03FuYhQ; Sun, 27 Jun 2021 17:54:33 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 27 Jun 2021 17:54:33 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
        ulf.hansson@linaro.org, maz@kernel.org, gustavoars@kernel.org,
        jckuo@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] soc/tegra: Fix an error handling path in 'tegra_powergate_power_up()'
Date:   Sun, 27 Jun 2021 17:54:31 +0200
Message-Id: <46d3af4a83e2e7b680c857e8969167f0d2d94841.1624809134.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after a successful 'tegra_powergate_enable_clocks()'
call, it must be undone by a 'tegra_powergate_disable_clocks()' call, as
already done in the below and above error handling paths of this function.

Update the 'goto' to branch at the correct place of the error handling
path.

Fixes: a38045121bf4 ("soc/tegra: pmc: Add generic PM domain support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
/!\ This patch is speculative /!\
Review with care.
---
 drivers/soc/tegra/pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index ea62f84d1c8b..b8ef9506f3de 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -782,7 +782,7 @@ static int tegra_powergate_power_up(struct tegra_powergate *pg,
 
 	err = reset_control_deassert(pg->reset);
 	if (err)
-		goto powergate_off;
+		goto disable_clks;
 
 	usleep_range(10, 20);
 
-- 
2.30.2

