Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E3444416F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 13:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhKCM13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 08:27:29 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:28389 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231434AbhKCM12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 08:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1635942292; x=1667478292;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z00lcqhZKxm6cRgN3F0meupfTSXsJK00NC3Jk6wxYPs=;
  b=W2+58/cmfvx39Jxt/CnmOW8wCfLKIgTym17U8k/Ag/SpbMqkdZvOI2Ev
   JNYXfU6A2QFQZYSP3InlZDhF08PCuHMeBwOnZl3VTB3GFAyJUSEeUSSFd
   Lv2Icbd0rqBqCg/EhNbzQ+wpumFJu/XHXtQkOihWSthMmpm6aFbHpa45N
   xSkdsaG39TPsD+i2IrZYlyIXhgl4z49SIwF3nDWleXdQWgsck4NUABRAF
   ng8ly1j9VdAjaYL2W1fpyhY+Uy73+e5psjK1xdp7IRLIQTiSF5SZedqpu
   NAsPOWh0H29KxI+KLyrapdnjlJtVLIgQfIs9ZTC1/ld3huIf1/AOxLvuB
   A==;
X-IronPort-AV: E=Sophos;i="5.87,205,1631570400"; 
   d="scan'208";a="20324227"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Nov 2021 13:24:50 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 03 Nov 2021 13:24:50 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 03 Nov 2021 13:24:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1635942290; x=1667478290;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z00lcqhZKxm6cRgN3F0meupfTSXsJK00NC3Jk6wxYPs=;
  b=GqSmWbEQ9yW3bDGGwdU10oMwVF1OEyr3IlfPoYcCwXuGxfG5FrnB+711
   tbBrAFobRwoLYc4my87d37apLjYGjcXmLRJW5Tq2oM+B1d9hlOEQxFqIz
   LZJH+tAD+3btWMyQKfHfEkubu55wziNQvlHlnNn0H//1O1zUx4LZGfXv7
   S0CwtQ0Zcbor1Q6IIquY/exoKYpNJF+AjqWYavnTtMvnitOzSwiQa0PFe
   fHt7alVTVcHJgZIHUavVwpNC+Y+LdvmUEOMR1GNE+B80J35HjpaYtAAQu
   RSWQnaykwGklGG9Yr8F4NzAZw5E4f7fGNYagZzwlqf979Zq+svnFQeBVa
   g==;
X-IronPort-AV: E=Sophos;i="5.87,205,1631570400"; 
   d="scan'208";a="20324226"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Nov 2021 13:24:50 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 4132B280065;
        Wed,  3 Nov 2021 13:24:50 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] clk: composite: Fix 'switching' to same clock
Date:   Wed,  3 Nov 2021 13:24:41 +0100
Message-Id: <20211103122441.3208576-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During commit 6594988fd625 ("clk: composite: Use rate_ops.determine_rate
when also a mux is available") setting req->best_parent_hw got lost,
so best_parent_hw stays NULL during switch to the same parent. This
results in the (debug) message:
  clk_calc_new_rates: lcdif_pixel not gated but wants to reparent
and the following rate change is dropped.

Fixes: 6594988fd625 ("clk: composite: Use rate_ops.determine_rate when also a mux is available")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
This is on linux-next tag 'next-20211101' and platform is a custom
imx8mq board.

 drivers/clk/clk-composite.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index c04ae0e7e4b4..b9c5f904f535 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -97,6 +97,7 @@ static int clk_composite_determine_rate(struct clk_hw *hw,
 				return ret;
 
 			req->rate = tmp_req.rate;
+			req->best_parent_hw = tmp_req.best_parent_hw;
 			req->best_parent_rate = tmp_req.best_parent_rate;
 
 			return 0;
-- 
2.25.1

