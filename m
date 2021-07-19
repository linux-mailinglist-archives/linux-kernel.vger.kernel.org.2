Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9754F3CE9AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 19:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354290AbhGSQ7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 12:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236773AbhGSPcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:32:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68F1861426;
        Mon, 19 Jul 2021 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626711052;
        bh=YnmAZuv+GSQjLqz/EuVkIS3SgkjoBz3aow2yGCSvJEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yblrE4ThPrayBv5AAv9b9+wsPolvZzTOi5hz8y9slZsc/9A4LMapRi85i2WKSyXi9
         tOnwk+gPuQYu45Jc+YaNXPN50yxEFKEi/Sq1RUzVE3qux0DEX5i7FeeIlwdhICE3GL
         V20VR1xHZOAE2L0ZBad+tmmX0FPspce9sBLoTjsU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.13 210/351] power: supply: surface-charger: Fix type of integer variable
Date:   Mon, 19 Jul 2021 16:52:36 +0200
Message-Id: <20210719144951.917110715@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719144944.537151528@linuxfoundation.org>
References: <20210719144944.537151528@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maximilian Luz <luzmaximilian@gmail.com>

[ Upstream commit 601423bc0c06467d019cf2a446962a5bf1b5e330 ]

The ac->state field is __le32, not u32. So change the variable we're
temporarily storing it in to __le32 as well.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: e61ffb344591 ("power: supply: Add AC driver for Surface Aggregator Module")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/surface_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/supply/surface_charger.c
index 81a5b79822c9..a060c36c7766 100644
--- a/drivers/power/supply/surface_charger.c
+++ b/drivers/power/supply/surface_charger.c
@@ -66,7 +66,7 @@ struct spwr_ac_device {
 
 static int spwr_ac_update_unlocked(struct spwr_ac_device *ac)
 {
-	u32 old = ac->state;
+	__le32 old = ac->state;
 	int status;
 
 	lockdep_assert_held(&ac->lock);
-- 
2.30.2



