Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB2C351250
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhDAJcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:32:16 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:39070 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbhDAJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:31:41 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id B62489800C2;
        Thu,  1 Apr 2021 17:31:39 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] sunrpc: xprtrdma: Remove repeated struct declaration
Date:   Thu,  1 Apr 2021 17:31:33 +0800
Message-Id: <20210401093133.1004922-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTh9LGBpOHUhMTR5IVkpNSkxJTUJPQkJCS0NVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PjY6Izo4ED8UQysDLjETGgMo
        SzMaCilVSlVKTUpMSU1CTktLSk9JVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKSUJINwY+
X-HM-Tid: 0a788cc627b0d992kuwsb62489800c2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct rpcrdma_req is declared twice. One is declared at 216th line.
The blew one is not needed. Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 net/sunrpc/xprtrdma/xprt_rdma.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index fe3be985e239..11e5fbfc642c 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -239,7 +239,6 @@ struct rpcrdma_frwr {
 	};
 };
 
-struct rpcrdma_req;
 struct rpcrdma_mr {
 	struct list_head	mr_list;
 	struct rpcrdma_req	*mr_req;
-- 
2.25.1

