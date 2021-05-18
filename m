Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF58B38719B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 08:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344360AbhERGIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 02:08:52 -0400
Received: from m12-17.163.com ([220.181.12.17]:56790 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343548AbhERGIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 02:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oSCdD
        cWXTFCTgOMARGDGNz+PLQ1W3cZ3WXZVxydYTQQ=; b=k+jSMH9RhW6KPA/fx1s8n
        gKNFyUqTan7a7+axUab1J/Iqwoh9QG4PF1RnDopetH20CqoFTVgS2iD5AG7I80sM
        vTwdTagEnM8XAcm2qf41zE3MrX3azTRBEOIDztKhU69CA162bg6ouWaxNzsmZ0YV
        rWnUF4xnQjhVHTguEuwRhE=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp13 (Coremail) with SMTP id EcCowAD3H4SVWaNg+C+M1w--.3239S2;
        Tue, 18 May 2021 14:07:20 +0800 (CST)
From:   zuoqilin1@163.com
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] scripts/dtc: Assign value when defining variables
Date:   Tue, 18 May 2021 14:07:25 +0800
Message-Id: <20210518060725.1984-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAD3H4SVWaNg+C+M1w--.3239S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1kuF48tr4kJF48CFW3Wrg_yoW8GrW5pr
        Z8Cw12qrs5tFWjvrs0kryDWr4UC3yDXr15K3yUCwnxZFZxt3yxKFWak3WSvw17W3yDXr1a
        vrsYqas5WF1xWw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jyZXOUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbipRiWiVUMeJnvugAAsP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

When defining variables and assigning values can be done at the same time.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 scripts/dtc/util.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/dtc/util.c b/scripts/dtc/util.c
index 40274fb..d1f7608 100644
--- a/scripts/dtc/util.c
+++ b/scripts/dtc/util.c
@@ -292,7 +292,7 @@ int utilfdt_write_err(const char *filename, const void *blob)
 {
 	int fd = 1;	/* assume stdout */
 	int totalsize;
-	int offset;
+	int offset = 0;
 	int ret = 0;
 	const char *ptr = blob;
 
@@ -303,7 +303,6 @@ int utilfdt_write_err(const char *filename, const void *blob)
 	}
 
 	totalsize = fdt_totalsize(blob);
-	offset = 0;
 
 	while (offset < totalsize) {
 		ret = write(fd, ptr + offset, totalsize - offset);
@@ -421,7 +420,7 @@ void NORETURN util_usage(const char *errmsg, const char *synopsis,
 	const char a_arg[] = "<arg>";
 	size_t a_arg_len = strlen(a_arg) + 1;
 	size_t i;
-	int optlen;
+	int optlen = 0;
 
 	fprintf(fp,
 		"Usage: %s\n"
@@ -429,7 +428,6 @@ void NORETURN util_usage(const char *errmsg, const char *synopsis,
 		"Options: -[%s]\n", synopsis, short_opts);
 
 	/* prescan the --long opt length to auto-align */
-	optlen = 0;
 	for (i = 0; long_opts[i].name; ++i) {
 		/* +1 is for space between --opt and help text */
 		int l = strlen(long_opts[i].name) + 1;
-- 
1.9.1


