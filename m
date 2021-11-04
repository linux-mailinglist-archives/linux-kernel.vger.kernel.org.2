Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287F5444F5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 07:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhKDGzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 02:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhKDGzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:55:22 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E9CC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 23:52:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id l3so2974041pfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 23:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=97HkIATvrXALCqUv25iSceKHB9vr5nNeTL//UX0Vwbc=;
        b=krZaMoMzrcgDc8XhtCnoyCQMDm3QcQzl/SpgVBjX015UIZRG0ZL43RSw1n0JRNARDH
         j4xoaFrT3oSQ98Ude/dhrBI4otvutN0Jm/xDoLaGJV7eLFPdNJBTFJc7NzpK4U5qIKzy
         ys/R5JyY+pyWon2ykPCht49SSCSWAiKIaN6141zdzq+VqCrn9ZHNYLob20UTIT6H2DJ4
         EyTdsdkXPXoh6mM9u4JGadRxRJJSbWPrnD1qDqbDZ4Mf5WKZJ446CZd4oL2RQ9W6S5TW
         UhgQPy7DkIqpbVRCoCBDeJy5b6vQEr3laR9uyL1BdKKZDr3t+i0oTJi8/i/zHv+bRmkO
         ytAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=97HkIATvrXALCqUv25iSceKHB9vr5nNeTL//UX0Vwbc=;
        b=spsTeAnwjcmoeLbWx4ujtKgPPuMIB6zG7EYjAA8SlUufb2qmBfCzehS9OzAEEYpvUD
         t7OVjePTPKtUcFuEEtdK+T29/pfvjyYoensof0SBZskGbP0q29LaYSfDqJhv5YeVRpdA
         8AVeFrX9u3HkKx1wed+HSTnWiCQ7hA+Wu2Itltsr3xAEzeo2VQQmgcsfIgVJZcyUndl0
         IM21I+bDxyKsMUFs76IHRSJ9fF8P5Q3AXZEK9hN4goc3+RnAoL5qTsbLKrjUxUSlaPsS
         Ul98Ljq7H5weuUHXJkeILxB5I2G1Mxcgzm+56d5iq4MfEPJd+j560Gl9PWPb1m2wDtJH
         zXmQ==
X-Gm-Message-State: AOAM532ulrBvcGx2Vk2+JU+N8Cfb2OMT+Kk/Mc3H0hf/+WvzBD01zBBT
        30nFgigYsn6REPrmSZUWXQ+XYpadN0Q=
X-Google-Smtp-Source: ABdhPJxUlDVGMvpv0DAhpGuY6d+N7paM1BO5zZliH874uCa4NpDQVzkwuI3Q0TGAQ0OjFF8423gc6A==
X-Received: by 2002:a05:6a00:888:b0:44c:c00e:189c with SMTP id q8-20020a056a00088800b0044cc00e189cmr49918547pfj.79.1636008764422;
        Wed, 03 Nov 2021 23:52:44 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id j1sm3338773pgb.5.2021.11.03.23.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 23:52:44 -0700 (PDT)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     kishon@ti.com
Cc:     davidcomponentone@gmail.com, vkoul@kernel.org,
        sjakhade@cadence.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] phy: cadence-torrent: use swap() to make code cleaner
Date:   Thu,  4 Nov 2021 14:52:33 +0800
Message-Id: <20211104065233.1833499-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 5786166133d3..7c4b8050485f 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -2278,7 +2278,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
 	enum cdns_torrent_ref_clk ref_clk = cdns_phy->ref_clk_rate;
 	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
-	enum cdns_torrent_phy_type phy_t1, phy_t2, tmp_phy_type;
+	enum cdns_torrent_phy_type phy_t1, phy_t2;
 	struct cdns_torrent_vals *pcs_cmn_vals;
 	int i, j, node, mlane, num_lanes, ret;
 	struct cdns_reg_pairs *reg_pairs;
@@ -2304,9 +2304,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 			 * configure the PHY for second link with phy_t2.
 			 * Get the array values as [phy_t2][phy_t1][ssc].
 			 */
-			tmp_phy_type = phy_t1;
-			phy_t1 = phy_t2;
-			phy_t2 = tmp_phy_type;
+			swap(phy_t1, phy_t2);
 		}
 
 		mlane = cdns_phy->phys[node].mlane;
-- 
2.30.2

