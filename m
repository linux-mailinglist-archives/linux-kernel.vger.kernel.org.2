Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B08344018
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCVLpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhCVLpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:45:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 945126198D;
        Mon, 22 Mar 2021 11:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616413518;
        bh=liwkJr++xOmGVh9TPdenTt5K01dJM4oOTKgZCRao8aE=;
        h=From:To:Cc:Subject:Date:From;
        b=kbYalYvBeuLzPrVLtbx44T1v/8Z+M7nARJqzUOvEZS21sWRUC+xT2rbuhnUHSyV/h
         G7NJO4+Wut5U+8JT8eTSvosRajsGXhrJ/vlWqESbNQSIn8qVFXebo9AwV3LLlaE5J6
         4/ebt+CABMqJJmpigDR20TD5DnkL1Nuvg9UqlUTV9ji3n4rC5fU7IXesHPBhvK2rN9
         zl2IIWE5DEV6+pwzMsrRMm1Xg1yIjiAfvlVdnuo/uTZGRDq5dUUNUiGFVxlcICymrO
         Pys3xfKwfKBTuyy/6Ra8mqke1DWkKRVQqP3V0Bni0wlL6sOi/0izhgbF8kjWPdFebC
         USNdtP74Gsd0A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dax: avoid -Wempty-body warnings
Date:   Mon, 22 Mar 2021 12:44:58 +0100
Message-Id: <20210322114514.3490752-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc warns about an empty body in an else statement:

drivers/dax/bus.c: In function 'do_id_store':
drivers/dax/bus.c:94:48: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
   94 |                         /* nothing to remove */;
      |                                                ^
drivers/dax/bus.c:99:43: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
   99 |                 /* dax_id already added */;
      |                                           ^

In both of these cases, the 'else' exists only to have a place to
add a comment, but that comment doesn't really explain that much
either, so the easiest way to shut up that warning is to just
remove the else.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dax/bus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 452e85ae87a8..5aee26e1bbd6 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -90,13 +90,11 @@ static ssize_t do_id_store(struct device_driver *drv, const char *buf,
 				list_add(&dax_id->list, &dax_drv->ids);
 			} else
 				rc = -ENOMEM;
-		} else
-			/* nothing to remove */;
+		}
 	} else if (action == ID_REMOVE) {
 		list_del(&dax_id->list);
 		kfree(dax_id);
-	} else
-		/* dax_id already added */;
+	}
 	mutex_unlock(&dax_bus_lock);
 
 	if (rc < 0)
-- 
2.29.2

