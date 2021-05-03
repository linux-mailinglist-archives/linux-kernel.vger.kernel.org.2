Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DC23714B1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhECMAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233353AbhECMAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:00:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D6236121D;
        Mon,  3 May 2021 11:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043150;
        bh=mZZgUJN7S8ehEpZrjCrMgLzaVUg61xObJtcf+RMK1Ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JniMMyfDZ8RMeaCf3Jo7dEWGwXx5Ao28/ngzDM+IYzS9aob+FtrkB2mrEKXxrmnK7
         n0hU9UtXqBSkpk66rUHhLDuRXgCzW+M24fAVfU5Nl/zNAvya5Rvb4RK37qXySx0s95
         vJInkKri0MM9IhKrPdL1W7OmZlCZsFdbsPdcVe7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 17/69] net/smc: properly handle workqueue allocation failure
Date:   Mon,  3 May 2021 13:56:44 +0200
Message-Id: <20210503115736.2104747-18-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anirudh Rayabharam <mail@anirudhrb.com>

In smcd_alloc_dev(), if alloc_ordered_workqueue() fails, properly catch
it, clean up and return NULL to let the caller know there was a failure.
Move the call to alloc_ordered_workqueue higher in the function in order
to abort earlier without needing to unwind the call to device_initialize().

Cc: Ursula Braun <ubraun@linux.ibm.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/smc_ism.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 6558cf7643a7..94b31f2551bc 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -402,6 +402,14 @@ struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
 		return NULL;
 	}
 
+	smcd->event_wq = alloc_ordered_workqueue("ism_evt_wq-%s)",
+						 WQ_MEM_RECLAIM, name);
+	if (!smcd->event_wq) {
+		kfree(smcd->conn);
+		kfree(smcd);
+		return NULL;
+	}
+
 	smcd->dev.parent = parent;
 	smcd->dev.release = smcd_release;
 	device_initialize(&smcd->dev);
@@ -415,8 +423,6 @@ struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
 	INIT_LIST_HEAD(&smcd->vlan);
 	INIT_LIST_HEAD(&smcd->lgr_list);
 	init_waitqueue_head(&smcd->lgrs_deleted);
-	smcd->event_wq = alloc_ordered_workqueue("ism_evt_wq-%s)",
-						 WQ_MEM_RECLAIM, name);
 	return smcd;
 }
 EXPORT_SYMBOL_GPL(smcd_alloc_dev);
-- 
2.31.1

