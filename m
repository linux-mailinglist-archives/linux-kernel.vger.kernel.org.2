Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011C942F445
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbhJONyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231278AbhJONyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:54:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 468AB6054F;
        Fri, 15 Oct 2021 13:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634305951;
        bh=fi2tMOxqhnQ+/2k5cabOxx3Wrm847QYTHSmSkasymKc=;
        h=From:To:Cc:Subject:Date:From;
        b=FKVHtTx5+lYWaGpyCMIZ0MiYmg9CQf7R2SOI2u6akDNxIgpkoHlAydcjjexrltGe3
         0+GUMMpJtSSr7YSF8/WrU827uQht8WiS55EoIYH/AihacMopnPSilGKzsIPHRJiv99
         nTaaiOhDGxeB02xKjTbVVlVHcCMw/rnJEW29aUCKvAdo6Uxm8yQxklHBqTrncduq3f
         cN+RNY+iewikBP+/fHBPhW5GzrtIKuGp/eTohbseEqg+NPj10dzx35hpVq+R9KA3mG
         V1uBqa5NFixv9uf7C6ya5ucSQFjtEk0k1uqgW7Wv4Y6kXnhofX92O4lRzyIA71D4Jt
         KSwFEr1DGqtjw==
From:   Mark Brown <broonie@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] random: Document add_hwgenerator_randomness() with other input functions
Date:   Fri, 15 Oct 2021 14:34:30 +0100
Message-Id: <20211015133430.111886-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063; h=from:subject; bh=fi2tMOxqhnQ+/2k5cabOxx3Wrm847QYTHSmSkasymKc=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhaYM1Ff3mACyCF6nxOjVy8ZboZeCgjmMVuwFtErVU G0PiwWSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYWmDNQAKCRAk1otyXVSH0OgoB/ 0Ug3byfLS+LGDaFATkGNr+ydTyvIaSbeIhGsWzTG3sF4Jwb+Pv2F377CHI3kUfuLchpTRFB4VlWZKe W6mRt0cnnNRPijQzOz6gvz/jJu8WNrMmVlIYtah2MqcXUsgtmITtbJhcBPFqxEIQb/z+w78IGMzWAK U10/BaRmQ3N4DhbQ+5b9X+srt4Hgit3hjMDJMfmxV3wLNw7wJv1LWxflPhbxmGDe7oCOhkZK4kiIMN cr92JEj6MES4EkqTsQKgqIcVjT64AcA9Su50sMC7QvF846sbnfe+eAaH2BwrLEJl9TPYlTRii5NsxP 9+Vr20TQadi8odbjTmIRPNpuUd799F
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
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

