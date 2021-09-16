Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F3340D5B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhIPJPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:15:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235405AbhIPJPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:15:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66A9B61214;
        Thu, 16 Sep 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783661;
        bh=bpIM64MitjT0L278MXyuSFiAmcVN5+3I+6bnlUhY+Ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pQsy/8lY6agDj3GmN35JCspGL3usiFjgFsx9UAhOzbl1a8c/1Mc5mtGHdJU31a+rb
         /pU2Lt9xxelFJlq8Lg0Sfv80u2/YSEAXExrMs0YK5dnszgerOvdHc8Cmj5KXycgEWL
         HEPmx9oEBKhJO8pHkP+6IyrP3P4vn1S+BAQML/9x4JWOFxV/u943VyerHkHUlZdFhE
         ZVRHuGgR2ndfytB6po+E419xXQC3nku8Hw0IQELaNbfgdi8BJnSD+qJ2y6CnjLAJkJ
         rm76670+0NclKCyHsgjKBiesXN8BijqoQ4yIe62ZZc+QkpmrQvehpsJnNrytO/RIrq
         n7q9TVyQTIe9g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnTH-001sKd-9U; Thu, 16 Sep 2021 11:14:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Kershner <david.kershner@unisys.com>,
        linux-kernel@vger.kernel.org, sparmaintainer@unisys.com
Subject: [PATCH 01/24] visorbus: fix a copyright symbol that was bad encoded
Date:   Thu, 16 Sep 2021 11:13:54 +0200
Message-Id: <be5fae76111c41c62866686a386fbe21ee7a7b33.1631783482.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631783482.git.mchehab+huawei@kernel.org>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
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

