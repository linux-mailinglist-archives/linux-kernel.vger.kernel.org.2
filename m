Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C494137BC94
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhELMfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232486AbhELMfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:35:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03B6761041;
        Wed, 12 May 2021 12:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620822846;
        bh=X8/54ommkyt5Go8X5+Hbcai9kTbma//sxP0eeZHH9Y4=;
        h=From:To:Cc:Subject:Date:From;
        b=izWxN+DPeGXYA+WjUt7F+MRI/ifjvWJNi0kifRDQpFZ2uL7iqGN+u8AiOhr0qGpLd
         OHRhsurkYh/6pGrTjaR4/BE0ssTkAWS1IIpRPg17rKVGf/bW3Ml0uzGbp+vUG6TPCm
         UzV4tDfi7Fx3LT7yzpzc5zerW2jS8ALCe+eMweTfDBFBj3PEhq7MCIamWzeC3Ym+jT
         wvlAuzpplWD18jsS52u4g95rngN3AMvzvJpfqswP7JczyoZ2Mu9atwX4hcoRq4zOu3
         9satxjZIDpmoR7jkJlqb3UO25bnkFOonsXL7J5l6uLHBly7B40eNS50jm9K97gG1tF
         XQkrCrtdlIoCA==
From:   Mark Brown <broonie@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3] tools/nolibc: Implement msleep()
Date:   Wed, 12 May 2021 13:32:15 +0100
Message-Id: <20210512123215.42321-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=WROh5SBSWd//p/Sxtx1sSZhXRJr/pNHGmfIOZDLA1ME=; m=DsG0GUH5Pq7W2vv4GT6Z0e1qoDZBWwgUNihInvr8Y2M=; p=Uq9qwA09rFw9e6qEJ6WyyeNvYSBC/dhgo3azkyzvnSk=; g=e3987dff811e06d2d493f10034fbb8ea59bf6b54
X-Patch-Sig: m=pgp; i=broonie@kernel.org; s=0xC3F436CA30F5D8EB; b=iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCbyKMACgkQJNaLcl1Uh9AmaQf+Jyb p6eNIv2My43VvhLuaHv2Tmn2YF6niS1fMW5y1HbkjBD4CXtVFnJm4Q2hLMaUcBUlJ+QMQEGRJ8l+4 HtAYBOEIIRwHxOMp+hFWTZWtdZnXLTBQr5YWGQEaxug1NeUJGSloB+oFF+kMsl1SX6i3j18XoE23I SSxVX1E9ELWfckjHputFGuvMXXeTnZHOyh0FiMiySEpoRhxj4AGD9gkExmca5WEJws29XK24OOURZ IcBXoUGtMgWQonBkhB94AA5aaaJ5hXm+O/T+oJqi4d6wzoAWOhf5D5UxJXdo54NaP5BeIyGPUiB9f k4u29hmUMltyIHVaNdmbRf0nS689Dfw==
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow users to implement shorter delays than a full second by implementing
msleep().

Signed-off-by: Mark Brown <broonie@kernel.org>
---
v3:
 - Return the number of milliseconds remaining if the delay does not
   complete.
v2:
 - Support delays of more than a second.
 - Return the number of seconds remaining if the delay does not
   complete.

 tools/include/nolibc/nolibc.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 8b7a9830dd22..ba6b6f1ad846 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -2243,6 +2243,19 @@ unsigned int sleep(unsigned int seconds)
 		return 0;
 }
 
+static __attribute__((unused))
+int msleep(unsigned int msecs)
+{
+	struct timeval my_timeval = { msecs / 1000, (msecs % 1000) * 1000 };
+
+	if (sys_select(0, 0, 0, 0, &my_timeval) < 0)
+		return (my_timeval.tv_sec * 1000) +
+			(my_timeval.tv_usec / 1000) +
+			!!(my_timeval.tv_usec % 1000);
+	else
+		return 0;
+}
+
 static __attribute__((unused))
 int stat(const char *path, struct stat *buf)
 {
-- 
2.20.1

