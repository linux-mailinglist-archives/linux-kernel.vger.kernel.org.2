Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B622D4519CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 00:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354017AbhKOX2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 18:28:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:44604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245061AbhKOTTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:19:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45060634FD;
        Mon, 15 Nov 2021 18:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637000863;
        bh=o2vNYiXQqL0DzCXCOJyEVsB4e/WMcKZ77Rb17LF1dX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xyt89mIA+eDpYT2iQCjWWIpABYgWN7gMhzZoTayLD+3K81XhGM8IogwRW/unshyA5
         CL/yEW0iqZw3Vjw0fyhilvesRck9N5qUddwOcPZrxB29Velj27WJzNphMZydasIJ+J
         p1jL+Cx/2DcNQgyCP8WkMJhpjlzuu1IexRYHUr7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.14 778/849] net: stmmac: allow a tc-taprio base-time of zero
Date:   Mon, 15 Nov 2021 18:04:21 +0100
Message-Id: <20211115165446.559851352@linuxfoundation.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115165419.961798833@linuxfoundation.org>
References: <20211115165419.961798833@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit f64ab8e4f368f48afb08ae91928e103d17b235e9 ]

Commit fe28c53ed71d ("net: stmmac: fix taprio configuration when
base_time is in the past") allowed some base time values in the past,
but apparently not all, the base-time value of 0 (Jan 1st 1970) is still
explicitly denied by the driver.

Remove the bogus check.

Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler API")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 8160087ee92f2..1c4ea0b1b845b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -786,8 +786,6 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 		goto disable;
 	if (qopt->num_entries >= dep)
 		return -EINVAL;
-	if (!qopt->base_time)
-		return -ERANGE;
 	if (!qopt->cycle_time)
 		return -ERANGE;
 
-- 
2.33.0



