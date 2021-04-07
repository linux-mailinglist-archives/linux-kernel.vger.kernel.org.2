Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF93E356167
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 04:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348106AbhDGC2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 22:28:08 -0400
Received: from m12-12.163.com ([220.181.12.12]:50950 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233994AbhDGC2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 22:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Me5hN
        OF2h0y0yS3J/7We7nlIRtQIvPxa/0EyPfwDP70=; b=C97c5CQVvlZsRxAslaMhN
        PerQbr22PMUP1usdZznfcKqb7pt805Szboi+O7RafrOlGdAKu3K14FwNpSEYA4Mn
        L5HW1N8mEMrkux1RxbIzJrvUI7pStjcfMtl2XM0XnS87+XsCXLGhK2L1fh5CJuEt
        lF9i7CkkLGC8sRqwoWfz4Q=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp8 (Coremail) with SMTP id DMCowABHieSTGG1gTazQYA--.7038S2;
        Wed, 07 Apr 2021 10:27:34 +0800 (CST)
From:   liliu_096@163.com
To:     sfrench@samba.org, samba-technical@lists.samba.org
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "jack1.li_cp" <liliu1@yulong.com>
Subject: [PATCH] fs: cifs: Fix spelling of 'security'
Date:   Wed,  7 Apr 2021 10:26:55 +0800
Message-Id: <20210407022655.21124-1-liliu_096@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowABHieSTGG1gTazQYA--.7038S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw15tF1rKFWxWr43KryUWrg_yoWfXrg_GF
        4vkw1kW345AF43Xw13CrZ5Wrs29a4IyFWSk3ZxWF1UGasxGFW8Ga4Dtrn3ZF48CrsrCryq
        vrnFqFyUCr1fJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1D5rDUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5olox3bbqzlqqrwthudrp/1tbiRRZtx1l914Vv0QAAsx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "jack1.li_cp" <liliu1@yulong.com>

secuirty -> security

Signed-off-by: jack1.li_cp <liliu1@yulong.com>
---
 fs/cifs/cifsacl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index 562913e..d2d8e26 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -1418,7 +1418,7 @@ int set_cifs_acl(struct cifs_ntsd *pnntsd, __u32 acllen,
 	 * Add three ACEs for owner, group, everyone getting rid of other ACEs
 	 * as chmod disables ACEs and set the security descriptor. Allocate
 	 * memory for the smb header, set security descriptor request security
-	 * descriptor parameters, and secuirty descriptor itself
+	 * descriptor parameters, and security descriptor itself
 	 */
 	secdesclen = max_t(u32, secdesclen, DEFAULT_SEC_DESC_LEN);
 	pnntsd = kmalloc(secdesclen, GFP_KERNEL);
-- 
1.9.1


