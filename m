Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2633F0496
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbhHRN06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:26:58 -0400
Received: from mail-m973.mail.163.com ([123.126.97.3]:38652 "EHLO
        mail-m973.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbhHRN0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:26:50 -0400
X-Greylist: delayed 969 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Aug 2021 09:26:48 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=taKp/
        E45SaXAh+5bkQyLWRHD7gStayUwqqa2jx5aMK4=; b=bQ/Np4ppHpl8uLTtq0cQf
        nIc3piQYh6NaOE7avZayLPDEJL8e6vq2Ym826TfyqCiwgI6DQCt3afmUdzGPYsi4
        o4TFfxI+3hbrUKqNWgjyZ3O8xabw6yLbnMdzyADL+m9mWHJ2F6bwRcY2b1yeANv1
        Thv04zrG/+VqH4nYAF/Ih8=
Received: from localhost.localdomain (unknown [111.201.47.26])
        by smtp3 (Coremail) with SMTP id G9xpCgCnADmgBh1hOahZDA--.137S4;
        Wed, 18 Aug 2021 21:10:01 +0800 (CST)
From:   Wentao_Liang <Wentao_Liang_g@163.com>
To:     robh+dt@kernel.org
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wentao_Liang <Wentao_Liang_g@163.com>
Subject: [PATCH] drivers:of:property.c: fix a potential double put (release) bug
Date:   Wed, 18 Aug 2021 21:09:50 +0800
Message-Id: <20210818130950.3715-1-Wentao_Liang_g@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgCnADmgBh1hOahZDA--.137S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WryxCFWUuFyDAw1UKF1fXrb_yoW8Aw15pF
        W5GayYkFykWw12gFW8AF48ZrWa9F4UG398trWqka9Fvws8X34fXF18Xw1Ivwn5Ar95uFWf
        JFy0qrZrJF1UAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07juhFsUUUUU=
X-Originating-IP: [111.201.47.26]
X-CM-SenderInfo: xzhq3t5rboxtpqjbwqqrwthudrp/1tbiQwnyL1c7VIDfaQAAsZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In line 1423 (#1), of_link_to_phandle() is called. In the function
(line 1140, #2), "of_node_put(sup_np);" drops the reference to phandle
and may cause phandle to be released. However, after the function
returns, the phandle is subsequently dropped again (line 1424, #3) by
the same put function. Double putting the phandle can lead to an
incorrect reference count.

We believe that the first put of the phandle is unnecessary (#3). We
can fix the above bug by removing the redundant "of_node_put()" in line
1423.

1401 static int of_link_property(struct device_node *con_np,
				const char *prop_name)
1402 {
...
1409     while (!matched && s->parse_prop) {
...
1414
1415         while ((phandle = s->parse_prop(con_np, prop_name, i))) {
...
                 //#1 phandle is dropped in this function
1423             of_link_to_phandle(con_dev_np, phandle);

1424             //#3 the second drop to phandle
		 of_node_put(phandle);

1425             of_node_put(con_dev_np);
1426         }
...
1428     }
1429     return 0;
1430 }

1095 static int of_link_to_phandle(struct device_node *con_np,
1096                   struct device_node *sup_np)
1097 {
1098     struct device *sup_dev;
1099     struct device_node *tmp_np = sup_np;
...
1140     of_node_put(sup_np);  //#2 the first drop to phandle
			       //   (unnecessary)
1141
1142     return 0;
1143 }

Signed-off-by: Wentao_Liang <Wentao_Liang_g@163.com>
---
 drivers/of/property.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 6c028632f425..408fdde1a20c 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1137,7 +1137,6 @@ static int of_link_to_phandle(struct device_node *con_np,
 	put_device(sup_dev);
 
 	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np));
-	of_node_put(sup_np);
 
 	return 0;
 }
-- 
2.25.1

