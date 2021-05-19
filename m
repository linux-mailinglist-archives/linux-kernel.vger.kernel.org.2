Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA24C388934
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244636AbhESIRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:17:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244517AbhESIRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:17:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B7196109F;
        Wed, 19 May 2021 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621412147;
        bh=bpIM64MitjT0L278MXyuSFiAmcVN5+3I+6bnlUhY+Ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dxtoMhteOEpGkByxMLEFpe95TZQKWNb8CNsa8YnQcDFn6rAbx6zLMl2kJOwZ1ikWi
         tvA63iK2eY6s1gtI2ju9hk4Y3Sj0P/UlbohDEMYjc1gi6vE+1MZ6TZeQVt9Os+ha5+
         9qBI2EBx5eeMJtfx+FpfuKlMBU428Tu2eFa3f7mN930wtJF/1YknTMZXNzn2JHBgWh
         3COIhv+HNUKh0gnrnb/7uBmleK5ideugLqsNDSz22Qw/SlZAQk4MYh2cJv/9SfwUFy
         +D440D9y6oZoWKR3mts2mibecAktR05DrXUI5xO3PoOo9Q6nyPClxu0SogRWLK5QUD
         vIwPCAEswbPHw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ljHMn-007fBD-0d; Wed, 19 May 2021 10:15:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     David Kershner <david.kershner@unisys.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, sparmaintainer@unisys.com
Subject: [PATCH 3/3] visorbus: fix a copyright symbol that was bad encoded
Date:   Wed, 19 May 2021 10:15:37 +0200
Message-Id: <8cbcb23e248f77535389e398b456c3da8211ed88.1621412009.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <e606930c73029f16673849c57acac061dd923866.1621412009.git.mchehab+huawei@kernel.org>
References: <e606930c73029f16673849c57acac061dd923866.1621412009.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The copyright symbol was badly encoded using the
REPLACEMENT CHARACTER U+fffd ('�'), probably due to some
bad charset conversion.

Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/visorbus/visorbus_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/visorbus/visorbus_main.c b/drivers/visorbus/visorbus_main.c
index 152fd29f04f2..0aa4cff670dc 100644
--- a/drivers/visorbus/visorbus_main.c
+++ b/drivers/visorbus/visorbus_main.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright � 2010 - 2015 UNISYS CORPORATION
+ * Copyright © 2010 - 2015 UNISYS CORPORATION
  * All rights reserved.
  */
 
-- 
2.31.1

