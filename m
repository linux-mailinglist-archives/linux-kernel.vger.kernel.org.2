Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CC53B441C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhFYNMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:12:30 -0400
Received: from m12-12.163.com ([220.181.12.12]:48047 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230151AbhFYNMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PGtDY
        CSq9zKaPNy5qvE4Gnm2PlQeboV8cEN4SPgg3xs=; b=DmzLUcfQmW65demmR3+Xr
        a+qaS1EzFzpjsxXkO1VdnU4rNjRVDd0VShLoSsMDwXGVe3z9ifXM+0aV0zx+/GtM
        9tJFYnRxBCfgl5AWDww5icQvC0xwat29uuxbOync0yG5dkhoMsLkQA0RYjWQuF6N
        erGUvfTBcPbBjT0dAuuVBU=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp8 (Coremail) with SMTP id DMCowACHgv5PktVgu+rYLg--.34583S2;
        Fri, 25 Jun 2021 16:22:40 +0800 (CST)
From:   13145886936@163.com
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, gushengxian <gushengxian@yulong.com>
Subject: [PATCH] tools: virtio-trace: remove unneeded semicolon
Date:   Fri, 25 Jun 2021 01:22:38 -0700
Message-Id: <20210625082238.23529-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowACHgv5PktVgu+rYLg--.34583S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrArW7AF4rCw45ur4kZFyfXrb_yoWxGFbEkF
        4IqayIvrW5JF1vy3y3AryfZF4Sq3Z5WF4qvF45tryrZFWUJw15X3ZxCw4qgF13Zr12gF43
        XF4fGwnYyw43KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5byCJUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/xtbBzh68g1QHNBBrawABsZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Remove unneeded semicolon.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 tools/virtio/virtio-trace/trace-agent-ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/virtio-trace/trace-agent-ctl.c b/tools/virtio/virtio-trace/trace-agent-ctl.c
index 73d253d4b559..39860be6e2d8 100644
--- a/tools/virtio/virtio-trace/trace-agent-ctl.c
+++ b/tools/virtio/virtio-trace/trace-agent-ctl.c
@@ -75,7 +75,7 @@ static int wait_order(int ctl_fd)
 
 		if (ret)
 			break;
-	};
+	}
 
 	return ret;
 
-- 
2.25.1


