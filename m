Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7720A452F56
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhKPKoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:44:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234367AbhKPKnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:43:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0380C61A58;
        Tue, 16 Nov 2021 10:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637059214;
        bh=d2c7/cvf4goFuY/ZG1KO0aHiDqa+L1wLp9mPZr+E3SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aIUOpCTIhwWaRvPJOwenE9tcC9LKRQ+cHbYLsun0xPkjVpvCA9b+2dx9aSsVUCSAM
         MAeJcF3JrDfjE6dHoSW/UOZGknL6V+kT71cgzfzTOW3LyT4l0IMF5XsLPp0+EN3Zw0
         owYufzd99YhukQ8QB1UupBtGFEuhBbJf5p7s62+1ZImk2RplkeCqPxIyK4EPcZ6HRW
         dV+UIAoDkMwd4m2OT8iE4qEzZkqgz7zMyeZKr9WhjJhR3XPR1K6pM4J8q5o6P+pBqg
         7Fxfiy3ErSa4IiGE1EaAagblS4p917XK+0sJcFLn4eoISAKgmBWuA/7y0YQpvuoXoA
         usk2OEFNU2ehg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Roger Quadros <rogerq@ti.com>, Liam Beguin <lvb@xiphos.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] phy: ti: tusb1210: Fix the kernel-doc warn
Date:   Tue, 16 Nov 2021 16:09:51 +0530
Message-Id: <20211116103951.34482-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211116103951.34482-1-vkoul@kernel.org>
References: <20211116103951.34482-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment is not kernel-doc one and starts with /**, so fix that.

drivers/phy/ti/phy-tusb1210.c:16: warning: expecting prototype for tusb1210.c(). Prototype was for TUSB1210_VENDOR_SPECIFIC2() instead

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/ti/phy-tusb1210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
index a63213f5972a..15c1c79e5c29 100644
--- a/drivers/phy/ti/phy-tusb1210.c
+++ b/drivers/phy/ti/phy-tusb1210.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * tusb1210.c - TUSB1210 USB ULPI PHY driver
  *
  * Copyright (C) 2015 Intel Corporation
-- 
2.31.1

