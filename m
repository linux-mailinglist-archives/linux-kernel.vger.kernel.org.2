Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8C937A569
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 13:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhEKLEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 07:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230382AbhEKLEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 07:04:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 323C26134F;
        Tue, 11 May 2021 11:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620731022;
        bh=tw5HfF8xYh87wMrBFo0/ZtdS7DMiri+xzso5dPVpu0g=;
        h=From:To:Cc:Subject:Date:From;
        b=skdHh2Z1MCwopQGHg5MSrMXocdzaI+3126OJ+uX4lA6l8o2kZGkZFvGkOA+z8juIv
         orrqddF5DbKb9MWoueAlBYU2lJKFW3WODtXuS4jOjX/bPBu6xsJSD0NqI1B56neqXf
         ttDI0Zi92oqC4ldbHlFv3ePSVHfJ6VoWpUwBsJaUU8zW4sYcl6nDOsQbdR8PnSeZ3W
         vVkAM/S2gu/9rknGtE7WP5XiIVm2b9SM0InJKtmWh52WcKdI56V065eUHeZ0GEwUr+
         QJqAgLD6JBrZSkpAGO1hKW4U4gtxz5tTTU/DjO+WYOX6UKnBqASEa+Gw+nCngMAaoi
         Arq67pTICEUzQ==
From:   Mark Brown <broonie@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] tools/nolibc: Implement msleep()
Date:   Tue, 11 May 2021 12:01:59 +0100
Message-Id: <20210511110159.57286-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=WROh5SBSWd//p/Sxtx1sSZhXRJr/pNHGmfIOZDLA1ME=; m=DsG0GUH5Pq7W2vv4GT6Z0e1qoDZBWwgUNihInvr8Y2M=; p=uI6rJRHY1iGIfFBtYuNH6fe9oqnsuaPQvKSVXMmA/oA=; g=aa85c5cf6d011757b3dea394f8a5b5b3dcff9cae
X-Patch-Sig: m=pgp; i=broonie@kernel.org; s=0xC3F436CA30F5D8EB; b=iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCaYd8ACgkQJNaLcl1Uh9CC6wf8Dwy C7t2VdnX1ljxgEf+k0JquyjMEWYHB12xbz3wkfii7TWM4ge0xLkgKbTPp8b90vLb8RQo0IBCwqVZw j47+z5u48X3n2iPY10B8ExCm98ry4o0UPjLVOa4NxqzwjtqR2Y/LUjjb7WKK9DbgGzIyt8pzF3WhB 1FO2lIYSkebUVS3YNK7H0x80HcQby0y1U3DPe3iSoriQVWL5g/PUZIrHWh02rikNJ7v7mhs2UH8aZ kyx/gZiRmavZaWEhYBFbXbfjlpir3sO4db5JO8kapyaw+mp1kzu2p3BU+32JcU0di8H7FgIt8FjPT Hk/Liqt3rEoE3ncxC11qWz3XeaUlyvw==
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow users to implement shorter delays than a full second by implementing
msleep().

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/include/nolibc/nolibc.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 8b7a9830dd22..d045d8bb5f0a 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -2243,6 +2243,14 @@ unsigned int sleep(unsigned int seconds)
 		return 0;
 }
 
+static __attribute__((unused))
+void msleep(unsigned int msecs)
+{
+	struct timeval my_timeval = { 0, msecs * 1000 };
+
+	sys_select(0, 0, 0, 0, &my_timeval);
+}
+
 static __attribute__((unused))
 int stat(const char *path, struct stat *buf)
 {
-- 
2.20.1

