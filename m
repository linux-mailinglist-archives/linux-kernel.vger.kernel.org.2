Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81E939D3A1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 05:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhFGDsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 23:48:53 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4492 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGDsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 23:48:52 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fyzkg26bfzZdkV;
        Mon,  7 Jun 2021 11:44:11 +0800 (CST)
Received: from dggemi758-chm.china.huawei.com (10.1.198.144) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 11:46:59 +0800
Received: from huawei.com (10.175.101.6) by dggemi758-chm.china.huawei.com
 (10.1.198.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 11:46:59 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <stuyoder@gmail.com>, <laurentiu.tudor@nxp.com>
CC:     <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiaosong2@huawei.com>
Subject: [PATCH -next] bus/fsl-mc: fix doc warning
Date:   Mon, 7 Jun 2021 11:53:19 +0800
Message-ID: <20210607035319.289741-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggemi758-chm.china.huawei.com (10.1.198.144)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc W=1 warning:

drivers/bus/fsl-mc/dprc.c:345: warning: Function parameter or member 'attr' not described in 'dprc_get_attributes'
drivers/bus/fsl-mc/dprc.c:521: warning: Function parameter or member 'obj_type' not described in 'dprc_get_obj_region'

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 drivers/bus/fsl-mc/dprc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
index 27b0a01bad9b..c862e9119b4d 100644
--- a/drivers/bus/fsl-mc/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -334,7 +334,7 @@ int dprc_clear_irq_status(struct fsl_mc_io *mc_io,
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
  * @token:	Token of DPRC object
- * @attributes	Returned container attributes
+ * @attr	Returned container attributes
  *
  * Return:     '0' on Success; Error code otherwise.
  */
@@ -504,7 +504,7 @@ EXPORT_SYMBOL_GPL(dprc_set_obj_irq);
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
  * @token:	Token of DPRC object
- * @obj_type;	Object type as returned in dprc_get_obj()
+ * @obj_type:	Object type as returned in dprc_get_obj()
  * @obj_id:	Unique object instance as returned in dprc_get_obj()
  * @region_index: The specific region to query
  * @region_desc:  Returns the requested region descriptor
-- 
2.25.4

