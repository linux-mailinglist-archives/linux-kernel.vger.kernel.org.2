Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA673F40BD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 19:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhHVRzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 13:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhHVRzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 13:55:19 -0400
X-Greylist: delayed 597 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 Aug 2021 10:54:38 PDT
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEEFC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 10:54:38 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 3BC423E7B4;
        Sun, 22 Aug 2021 19:44:37 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: core: Check for pending links before reading required_opp pointers
Date:   Sun, 22 Aug 2021 19:44:10 +0200
Message-Id: <20210822174410.82595-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4fa82a87ba55 ("opp: Allow required-opps to be used for non genpd
use cases") dereferences the pointers in required_opp_tables but these
might be set to an ERR_PTR if the list still has lazy links pending,
resulting in segfaults.  Prior to this patch IS_ERR was also checked on
required_opp_tables[i] before reading ->is_genpd inside
_opp_table_alloc_required_tables, which is at the same time the
predicate to add this table to the lazy list.  This segfault is solved
by reordering the checks to bail on lazy pending tables before reading
->is_genpd.

Fixes: 4fa82a87ba55 ("opp: Allow required-opps to be used for non genpd use cases")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/opp/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index b335c077f215..4dd26a165c91 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -893,6 +893,10 @@ static int _set_required_opps(struct device *dev,
 	if (!required_opp_tables)
 		return 0;
 
+	/* required-opps not fully initialized yet */
+	if (lazy_linking_pending(opp_table))
+		return -EBUSY;
+
 	/*
 	 * We only support genpd's OPPs in the "required-opps" for now, as we
 	 * don't know much about other use cases. Error out if the required OPP
@@ -903,10 +907,6 @@ static int _set_required_opps(struct device *dev,
 		return -ENOENT;
 	}
 
-	/* required-opps not fully initialized yet */
-	if (lazy_linking_pending(opp_table))
-		return -EBUSY;
-
 	/* Single genpd case */
 	if (!genpd_virt_devs)
 		return _set_required_opp(dev, dev, opp, 0);
-- 
2.33.0

