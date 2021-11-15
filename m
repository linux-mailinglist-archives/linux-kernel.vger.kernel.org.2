Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCAC4515B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 21:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346888AbhKOUs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 15:48:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240256AbhKOSH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:07:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC552632B4;
        Mon, 15 Nov 2021 17:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636998244;
        bh=fi2tMOxqhnQ+/2k5cabOxx3Wrm847QYTHSmSkasymKc=;
        h=From:To:Cc:Subject:Date:From;
        b=W8zwlURt98JYH9bqACSFLr0xEzTz8vHeegi77PvnIsr3Ie9ciQ4kCBVSwu16Oj7Wv
         jFKIBATIZbtNaPb5CnijOSWoMiKAVE+qxkxjcaANzD0T4mb0tFXVkgBHYsVQ9G836O
         y0g6L9x2CzXn9ZtWoC+uBC6Zt8S+5kOv71J1DIN3QO726ApKP6z8ohxppkXQFfh0jH
         Bzd53anF5WboaizIBr2USc3+nfdB/sd3NVM70E/cq0cel11mzG4qAqdGHeezm16RTH
         lx9GPE8QE7EvYu6zKQeJ6wCck1LNquEwNLTUVwJJ1dp+3iTSL+ChnvJ2UfOEsxMzQt
         WFO1ezjdJhZgg==
From:   Mark Brown <broonie@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] random: Document add_hwgenerator_randomness() with other input functions
Date:   Mon, 15 Nov 2021 17:42:57 +0000
Message-Id: <20211115174257.2736738-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The section at the top of random.c which documents the input functions
available does not document add_hwgenerator_randomness() which might lead
a reader to overlook it. Add a brief note about it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/char/random.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 605969ed0f96..456a4f43d935 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -228,6 +228,14 @@
  * particular randomness source.  They do this by keeping track of the
  * first and second order deltas of the event timings.
  *
+ * There is also an interface for true hardware RNGs:
+ *
+ *	void add_hwgenerator_randomness(const char *buffer, size_t count,
+ *				size_t entropy);
+ *
+ * This will credit entropy as specified by the caller, if the entropy
+ * pool is full it will block until more entropy is needed.
+ *
  * Ensuring unpredictability at system startup
  * ============================================
  *
-- 
2.30.2

