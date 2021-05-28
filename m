Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12389393E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbhE1IFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhE1IE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:04:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F261C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:03:24 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lmXSh-00FkUX-Ad; Fri, 28 May 2021 10:03:19 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] devcoredump: remove contact information
Date:   Fri, 28 May 2021 10:03:14 +0200
Message-Id: <20210528100314.d419f6e8e2d2.Ica8076036c755d6f782becd62d04c41361323130@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

That email address hasn't existed for a long time, and the
mailing address is pretty useless; remove all of this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
Greg, can you take this through some of your trees, since
it's drivers/base/?
---
 drivers/base/devcoredump.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 8eec0e0ddff7..f4d794d6bb85 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -3,10 +3,6 @@
  * Copyright(c) 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2015 Intel Deutschland GmbH
  *
- * Contact Information:
- *  Intel Linux Wireless <ilw@linux.intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  * Author: Johannes Berg <johannes@sipsolutions.net>
  */
 #include <linux/module.h>
-- 
2.31.1

