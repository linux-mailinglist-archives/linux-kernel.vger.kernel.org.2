Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A6737AD2F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhEKRjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231517AbhEKRjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:39:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EEC561363;
        Tue, 11 May 2021 17:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620754683;
        bh=ws7c32By7Yah23i6ZVsT0SmTg7GkCW7FLFsyG2F4VNg=;
        h=From:To:Cc:Subject:Date:From;
        b=vO7CVKFfeQFQbPaeCgw07/oV0kuv2Y5z4N4aNF7/8E5QL/zAerIqmSu+I+hCZAsUh
         /rAOmSjxIMEERyM9HJ3jK7JV4niV6IIHv16cWini7+YVLWd3pTvRdx+cy2jZgJSuwZ
         pyHg4Fc4ZnMsgRKsG90TfFwsZ7KFZurs+0R+BHlgWUt2C+du+n0E0RF4AC+pbdnhqd
         kRJluRDuQCuwkCn8+qfw5fiANU3V8NyFu584iU8wdlCGcWq6QOLzSJ3Tm6Y4rh9kwg
         9qgmqH4/RvWX3PPNrAUC53fNNh6Q29JSoJXG5jLo45cZbOGqmNrGmDUh7A+zkRooYm
         JH93LwdOgGTxA==
From:   Mark Brown <broonie@kernel.org>
To:     tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] random: Document add_hwgenerator_randomness() with other input functions
Date:   Tue, 11 May 2021 18:29:45 +0100
Message-Id: <20210511172945.9137-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=hpfB/Fev0ElGAV6LAJtaW15TSyFeBveuDgewjphaBoA=; m=LEzWeJzwAfBLT8UOBAkDOF8NlIKUhb/roLorr18qc+k=; p=g8Hjiwl8JBuD8/Sb0q/D00vkl4KlHYD6ijgJCLHbo7o=; g=8071162e9aea1d2280a5fa789a80c7735472fa77
X-Patch-Sig: m=pgp; i=broonie@kernel.org; s=0xC3F436CA30F5D8EB; b=iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCavogACgkQJNaLcl1Uh9Dstgf/e8Q 7dF+5CEn4z+xrQNFVejiEos5XtPg78euFORPYI/IKyM9vkCveLvSIiJaIdmDmVCEQ9/jOfUmAx16W Tb38QKjfw8OauNF9lqxHE+CV5AfIIVgOPRgX2pOj5w94vWx3PTCfFMoPRn+Ev3OBEkeuBpr8Kq1gU zbgg973pYvYS0b0A4zKmsKW7Q7iz8WvCUDog9cwboPdZPfKq9r2ajuF0KrUVeLzpxajTfhIU0BJc4 09VgIf8gPrwLiH/lwZbN9LDF4ycy37L/qByKpnHpUzv4aHVOo5YugGcN8X3Y6qo++BRpM1COcDDqH xSG3wvTl/Mj3A7/Hk/1hylG3tZ4MESQ==
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

