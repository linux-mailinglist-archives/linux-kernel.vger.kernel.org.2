Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04273C5BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 14:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhGLMKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 08:10:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233391AbhGLMKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 08:10:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82E816044F;
        Mon, 12 Jul 2021 12:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626091663;
        bh=ws7c32By7Yah23i6ZVsT0SmTg7GkCW7FLFsyG2F4VNg=;
        h=From:To:Cc:Subject:Date:From;
        b=ZPA3LXKZGgJ8c3NoWfjSakxf78YpaMM9laNSMM3xyM5Urd9hW8oKVEoThV/qD16UM
         Z4fm8lMLJuLSjvINhe+2vCdFeV4qrZ3gHVK5p1fQO6K2l/FMUbetLUW8234i06366p
         xUdhaGjugZxV+dQ+TMZZiuvqMio8VJS6gewCe1NVJ2NM0YdEEiXn3Dd8Shjr4bXwOR
         JD6CwyCh7T8MlyY0Vk0w1PTdrBjwFnUstVMdzyBZjTwF+NXJ4QXc1Rel9z19ehCJvd
         YpUZHmERHFEK+uabZRHYgBh/WK8czjHG8cCxaJiz8w/kBVW5LujAIsXdE+obXzceLJ
         lKyNAP4BgltFg==
From:   Mark Brown <broonie@kernel.org>
To:     tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] random: Document add_hwgenerator_randomness() with other input functions
Date:   Mon, 12 Jul 2021 13:07:03 +0100
Message-Id: <20210712120703.53661-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063; h=from:subject; bh=ws7c32By7Yah23i6ZVsT0SmTg7GkCW7FLFsyG2F4VNg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBg7DAphEo8BBfrrHunfNTtN1+8Ts0dvrGerDp0GBnn NUPqmGWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYOwwKQAKCRAk1otyXVSH0HNfB/ 9KfBEEV9Z9gIrT4tyD05Nh1QAydFUbRbgvEUVLy/JWUsN9mk5XWlVtdZd+8W3OeZV53GdT2n2dIrIa eW4Dmw61LjYHny5CT0oqrxtIFjZo40U5AV+XoDp1096tNmMtHb51+rU2VHmq6NqCXR6vr3uthpsSxU uoXZobdCoRR+mlO3ggrWm46e0qRUHJA1bhkPhTZeF/70+19RjR0ibt7OZvl/SKp44vMXAxbP3q0mHP Ht7W8hbdX827x9BA5EqbI/oZtyDcDPILM1zd5O3v0lpn7+I89+co2TDy8ZAr1TvesVpqCzE08uB822 hdVM3JPhNQfT84oT2jtJsD3XDTYQGd
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

