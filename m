Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBD3325B44
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 02:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhBZBYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 20:24:10 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:46344 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230014AbhBZBXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 20:23:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UPaRmgn_1614302587;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPaRmgn_1614302587)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Feb 2021 09:23:08 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mpe@ellerman.id.au
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        benh@kernel.crashing.org, paulus@samba.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH v2] crypto/nx: add missing call to of_node_put()
Date:   Fri, 26 Feb 2021 09:23:06 +0800
Message-Id: <1614302586-15095-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In one of the error paths of the for_each_child_of_node() loop,
add missing call to of_node_put().

Fix the following coccicheck warning:
./drivers/crypto/nx/nx-common-powernv.c:927:1-23: WARNING: Function
"for_each_child_of_node" should have of_node_put() before return around
line 936.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

Changes in v2:
-add braces for if

 drivers/crypto/nx/nx-common-powernv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/nx/nx-common-powernv.c b/drivers/crypto/nx/nx-common-powernv.c
index 13c65de..446f611 100644
--- a/drivers/crypto/nx/nx-common-powernv.c
+++ b/drivers/crypto/nx/nx-common-powernv.c
@@ -932,8 +932,10 @@ static int __init nx_powernv_probe_vas(struct device_node *pn)
 			ret = find_nx_device_tree(dn, chip_id, vasid,
 				NX_CT_GZIP, "ibm,p9-nx-gzip", &ct_gzip);
 
-		if (ret)
+		if (ret) {
+			of_node_put(dn);
 			return ret;
+		}
 	}
 
 	if (!ct_842 || !ct_gzip) {
-- 
1.8.3.1

