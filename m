Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE94F3BD7F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 15:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhGFNnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 09:43:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:36054 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232106AbhGFNnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 09:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
        Content-Type; bh=Gr/c5AJsfFUWC5R2kC+uemsBZtl8wZmZPqeMQkw+uws=; b=mmyJ1z7Rf+OH
        MHZQl9TJIzmAv/zjEjl8wAq4IQhyMAqnAUEsNxQ7udG0QB14y7XbwxnbVRJ4VKsdadjDIhSmy7Hsv
        PJM70dSaYd15irwLCEQutD3MLrp8lB7st+Q4tV0qXx/A8Am6E+7EFz1rjzpbY3oNDOIWwQSiCCZr+
        VvfiY=;
Received: from [192.168.15.247] (helo=mikhalitsyn-laptop.sw.ru)
        by relay.sw.ru with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <alexander.mikhalitsyn@virtuozzo.com>)
        id 1m0l2b-0034RU-Eh; Tue, 06 Jul 2021 16:23:09 +0300
From:   Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Milton Miller <miltonm@bga.com>,
        Jack Miller <millerjo@us.ibm.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: [PATCH 2/2] ipc: WARN if trying to remove ipc object which is absent
Date:   Tue,  6 Jul 2021 16:22:59 +0300
Message-Id: <20210706132259.71740-3-alexander.mikhalitsyn@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210706132259.71740-1-alexander.mikhalitsyn@virtuozzo.com>
References: <20210706132259.71740-1-alexander.mikhalitsyn@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lets produce a warning if we trying to remove non-existing
IPC object from IPC namespace kht/idr structures.

This allows to catch possible bugs when ipc_rmid() function was
called with inconsistent struct ipc_ids*, struct kern_ipc_perm*
arguments.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Milton Miller <miltonm@bga.com>
Cc: Jack Miller <millerjo@us.ibm.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Signed-off-by: Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
---
 ipc/util.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index 0027e47626b7..45bb8ce6c42c 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -447,8 +447,8 @@ static int ipcget_public(struct ipc_namespace *ns, struct ipc_ids *ids,
 static void ipc_kht_remove(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
 {
 	if (ipcp->key != IPC_PRIVATE)
-		rhashtable_remove_fast(&ids->key_ht, &ipcp->khtnode,
-				       ipc_kht_params);
+		WARN_ON(rhashtable_remove_fast(&ids->key_ht, &ipcp->khtnode,
+				       ipc_kht_params));
 }
 
 /**
@@ -498,7 +498,7 @@ void ipc_rmid(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
 {
 	int idx = ipcid_to_idx(ipcp->id);
 
-	idr_remove(&ids->ipcs_idr, idx);
+	WARN_ON(idr_remove(&ids->ipcs_idr, idx) != ipcp);
 	ipc_kht_remove(ids, ipcp);
 	ids->in_use--;
 	ipcp->deleted = true;
-- 
2.31.1

