Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E0735F55F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349067AbhDNNrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:47:19 -0400
Received: from m12-13.163.com ([220.181.12.13]:60644 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345747AbhDNNrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EwR7Y
        maNzMnTWlCwuzu9rGM9euqfHcYpRoRM9HqWawQ=; b=NF8/QUYVtND8drmycdWI+
        92L+V65+hYED2ANRa0tmoDUnOqE5RxicVJZUX++2KVIKz/3CjnHK+U69rV/2WfvY
        PZFzcbbJ8FEecmcrOasPsoLW7R1mU5CGyI1nk4F6klBlMSeykGL1Ivf3Pauv3GXs
        CMSBRs3DMM17wLCkZfPWJw=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp9 (Coremail) with SMTP id DcCowACHtL0+8nZgU4mXFw--.25576S2;
        Wed, 14 Apr 2021 21:46:42 +0800 (CST)
From:   zuoqilin1@163.com
To:     mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] tools/bootconfig: Simplify expression
Date:   Wed, 14 Apr 2021 21:46:47 +0800
Message-Id: <20210414134647.1870-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowACHtL0+8nZgU4mXFw--.25576S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF13XF43urWxtw1kZryDGFg_yoW3Kwb_Kr
        95Zr18KrWfJry8ArsrWrZ8Wr40gF98WFs7t3yIkFy3ta1UXw17J3WkCwsxXFy5Wa9rtFy3
        WF4FkasFkw43ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1zVbJUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbiZQJ0iV8ZN04rRAAAsK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

It is not necessary to define the variable ret to receive
the return value of the xbc_node_compose_key() method.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 tools/bootconfig/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 7362bef..5fb309b 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -84,11 +84,9 @@ static void xbc_show_list(void)
 	char key[XBC_KEYLEN_MAX];
 	struct xbc_node *leaf;
 	const char *val;
-	int ret = 0;
 
 	xbc_for_each_key_value(leaf, val) {
-		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
-		if (ret < 0)
+		if (xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX) < 0)
 			break;
 		printf("%s = ", key);
 		if (!val || val[0] == '\0') {
-- 
1.9.1


