Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6324531F7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbhKPMTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:19:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232525AbhKPMTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:19:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D50E61B3D;
        Tue, 16 Nov 2021 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637064987;
        bh=fL8h2bzFQrA0lzfVmaVp8ZfiSOqe5iddtVdo/Hfxxhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktFhykgHXRSnzl+F39TxO6efdXnEY7eBj7yl936Q1RBNAYDJkf7H9D2PpdlVe5EON
         vMGSeS0zoy04zcffXj0akUKcaUx8QUt/BDTyi2xIf5syOqkNVMFK4vbJZ5g1C0ik4N
         Tmdp0qtnQeGlrzEsr7KODqsIJCdlyDPQ1Rq2/gO9QN5iHqz2F3H21vzN8hps26+bkp
         5NKI+mLaNO7F1UQyeP60QCKO2qX7E06tSFIZ9acQQJzAAPqz+ohB6tmvT5TpVuwFSq
         X++9vsRhK3gMsdYdmKGXI3Bnk1NGL9sgYYp7A+Y+cm0kbNbhmGj8P/JUfB4oSGkSyD
         B8flTPbyCI4+Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mmxNw-00A9Pu-Pr; Tue, 16 Nov 2021 12:16:24 +0000
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        David Kershner <david.kershner@unisys.com>,
        linux-kernel@vger.kernel.org, sparmaintainer@unisys.com
Subject: [PATCH v3 RESEND 1/1] visorbus: fix a copyright symbol that was bad encoded
Date:   Tue, 16 Nov 2021 12:16:23 +0000
Message-Id: <e83ef078c5235de38da07859e8cc0b39236b2cf3.1637064818.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637064818.git.mchehab+huawei@kernel.org>
References: <cover.1637064818.git.mchehab+huawei@kernel.org>
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

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 RESEND 0/1] at: https://lore.kernel.org/all/cover.1637064818.git.mchehab+huawei@kernel.org/

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
2.33.1

