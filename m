Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3480413CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 23:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhIUVmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 17:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235138AbhIUVmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:42:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC17B61159;
        Tue, 21 Sep 2021 21:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632260434;
        bh=ws7c32By7Yah23i6ZVsT0SmTg7GkCW7FLFsyG2F4VNg=;
        h=From:To:Cc:Subject:Date:From;
        b=tvYpKN0QFACI2HAXPapSOhijBgvMZd5DU/o8KQR/I0laAVURKvQxh66ZWJpIkdFC4
         5AjHqqtQOxZC3Z7VL42UCMibIVOyHGvWYbTbXHb83V3SdL3301+5En++zOjdZ2fhSR
         RbpqajjK5Lto2dp3N4RbRYOP3BgcMCUiQMlp/jS2BmQamkwMAewYP7W1OUfawGmPjo
         0AMzZmnzAayGqlzIfYt81We68TjvD5ppI06qcB68LTonJTt0tTYZ+MgV8P0NDAmNCt
         blRDE0rllXX4EUWFA6sLns4DMPpxkr4CRa8QzK6/iPVv6YncHzZ7EoAciaOonj9mZQ
         UxcVWLhphMc7A==
From:   Mark Brown <broonie@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] random: Document add_hwgenerator_randomness() with other input functions
Date:   Tue, 21 Sep 2021 22:39:19 +0100
Message-Id: <20210921213919.31875-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063; h=from:subject; bh=ws7c32By7Yah23i6ZVsT0SmTg7GkCW7FLFsyG2F4VNg=; b=owGbwMvMwMWocq27KDak/QLjabUkhkSvgHstXjYs4q/XVC+vufLWPH6P31nZfRvnrbEqkZB8bur8 akZqJ6MxCwMjF4OsmCLL2mcZq9LDJbbOfzT/FcwgViaQKQxcnAIwkcJ09v+5nc2xGUf0/Pe1HPFm4j EPNxfL5VLxYVs8eynj9OipD5kL3y8Kbwg+ECr+bM0nW0uLqyoKjtG9a9hTd+fe/tjNYMfSl3UjMXxl +qs3/ro59u+dir6KPF7jfXzbAp2LG1c27rvwMF2rWtnt69XS1Bb/Ip1vjGY9Lm8Pmn5vFvBpyhbI1H K/kXlN8E+oo0/7pl+K1qWLdjyeqZFV0HTCxs+S60PrzBnWbesvy+kek5fjlnyXnzC3uPOgaO58ERZ2 iTyB75Nv/PZqN1oXG1izU3ndfRm1BbwmjKtTjaavcr+2du7dOcUNzDv4H+RHiL6N/L63/7ZMn8HnYr sPnzrWh3bt2vLWeoY/T69ewqWlAA==
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
2.20.1

