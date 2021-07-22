Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2343D2144
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhGVJK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231406AbhGVJKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:10:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 968C760725;
        Thu, 22 Jul 2021 09:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626947485;
        bh=bpIM64MitjT0L278MXyuSFiAmcVN5+3I+6bnlUhY+Ss=;
        h=From:To:Cc:Subject:Date:From;
        b=uL4hAEM6Yx16KeztFOYfgPEeouMHXewehRlZFhjGRROSOEXD1RQi/aRoo7IPP9UUt
         37F5onvToR1EsQPpOFLyqLeVV43XHFRR6DpgWE/q89SMkMgggn9w7yGhoOxVr4mp0R
         Zqx4sKkojgsReSsOFSMT7jIno6pVtWPLIY/H9x6sBu0YzmEncyOqUiXkEhH4IwEw2m
         U/QO3tjVceLks2uo7PlnbD7xZP8Qo6Am+UjAdQmuIMcas1sxkacGvETmrPgjb0oNXG
         +O2sD+eHzr27Zl5891jS6seSRJncfy5C1JzuY9L+/2tVm+WEb4YUrakw5zmRUyU8xn
         v48hznlFWDs/A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6VMR-008lNv-Dr; Thu, 22 Jul 2021 11:51:23 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     David Kershner <david.kershner@unisys.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        sparmaintainer@unisys.com
Subject: [PATCH] visorbus: fix a copyright symbol that was bad encoded
Date:   Thu, 22 Jul 2021 11:51:16 +0200
Message-Id: <dd3f8e1fbd57a060761287c4f0bd80f20aab9a41.1626947440.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
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

