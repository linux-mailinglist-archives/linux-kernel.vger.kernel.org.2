Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099603CB220
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 07:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbhGPGBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 02:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbhGPGBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 02:01:00 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B53C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 22:58:04 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a6so12518657ljq.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 22:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=UMHofSB6HJnSeyqJoZbABW7A5gujb3us5XO5jkbBEkU=;
        b=KThkaL8MHL7GEyxa4McnKup2GKMuNBFOJRTUO+PntmAZjmv1reu3uQE+QYdXDLsFuw
         uh/6bKLX2EbUs/dj6qnQ1WJU8tKuUP94CBuZRABF5UmtamdkpFQnST70wkH3D3KhnLCm
         2ls1PlY1WY0SVJ4HSn0M/agPxsgkeedDPjSw1bxSFkHXJsozb8SsnSaUE/rdcMJYHwnM
         R+CCeXiUDjbjQ02wcwJ9nT9HApNKsgPO4MbHzC2tSdR17D5EVBAjVtvkXPz+9J61B+Tc
         VX2CAS7cJQHJCOUUSnVsL09poC+o2bihy/WbVyVDf+DGgzOWr8xSbM5kcV/QjknT91nq
         N8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UMHofSB6HJnSeyqJoZbABW7A5gujb3us5XO5jkbBEkU=;
        b=lYZF/gsOMQSUvmm334tVaaUWcMgGQyGTainvRC0Pnq6djlDBN1OWtvSkkGLWc+eZWv
         eP1HwIWcWkAlvl8yG41vSu5pa7/p6OLiEx5VZTw+02OKJWllcq06231OHpkI0GMr5D1U
         vlcF1tISYNzkiKrif32OehPJeza55XiVaaZoYDYL9Mulne+hj+ClX/2gJYZLZyZymztz
         Sp4T6ORbYOGzRIr4s63cGeJOjhwS2kiN4gX1StNFaS0AVeedE12l5SgAy6PcW0PP+Xid
         gvv4zmBmjnTaDOUuEv0IB6XuZB0RX9ODr7GhT4rXdO2ArnhgqxtehkhZKs5v46v5wsTM
         nlpw==
X-Gm-Message-State: AOAM531jPVUrc/HnZEtBfRzKVZW/Io+E8EQtq5UiJZdnhvruzqHzDImw
        wXpy7SrkKX+nPbAUlPYx80OEa8nclWQXaA==
X-Google-Smtp-Source: ABdhPJwLSUu7WV9inVDh1Mi5xmt8hlOuKMWJ2apbyIP22ZITV1wVZqXtGYea4gdOt6PzEMJ3rYUlTw==
X-Received: by 2002:a2e:bd81:: with SMTP id o1mr1833286ljq.504.1626415083268;
        Thu, 15 Jul 2021 22:58:03 -0700 (PDT)
Received: from asus ([37.151.208.206])
        by smtp.gmail.com with ESMTPSA id x74sm564011lff.254.2021.07.15.22.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 22:58:02 -0700 (PDT)
Date:   Fri, 16 Jul 2021 11:58:00 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     akpm@linux-foundation.org
Cc:     tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: KSM: fix data types
Message-ID: <20210716055800.GA255851@asus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change data types of ksm_run and ksm_stable_node_chains_prune_millisecs
as there were a few discrepancies between the types and actual values
that were stored:
1) ksm_run is declared as unsigned long but in run_store(), it is
converted to unsigned int. Change its type to unsigned int.
2) ksm_stable_node_chains_prune_millisecs is declared as int, but in
stable__node_chains_prune_millisecs_store(), it can store values up to
UINT_MAX. Change its type to unsigned int.

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
v1 -> v2:
- merge two patches into one

 mm/ksm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 3fa9bc8a67cf..2e4bd7662e52 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -259,7 +259,7 @@ static unsigned long ksm_stable_node_chains;
 static unsigned long ksm_stable_node_dups;
 
 /* Delay in pruning stale stable_node_dups in the stable_node_chains */
-static int ksm_stable_node_chains_prune_millisecs = 2000;
+static unsigned int ksm_stable_node_chains_prune_millisecs = 2000;
 
 /* Maximum number of page slots sharing a stable node */
 static int ksm_max_page_sharing = 256;
@@ -289,7 +289,7 @@ static int ksm_nr_node_ids = 1;
 #define KSM_RUN_MERGE	1
 #define KSM_RUN_UNMERGE	2
 #define KSM_RUN_OFFLINE	4
-static unsigned long ksm_run = KSM_RUN_STOP;
+static unsigned int ksm_run = KSM_RUN_STOP;
 static void wait_while_offlining(void);
 
 static DECLARE_WAIT_QUEUE_HEAD(ksm_thread_wait);
@@ -2874,7 +2874,7 @@ KSM_ATTR(pages_to_scan);
 static ssize_t run_show(struct kobject *kobj, struct kobj_attribute *attr,
 			char *buf)
 {
-	return sysfs_emit(buf, "%lu\n", ksm_run);
+	return sysfs_emit(buf, "%u\n", ksm_run);
 }
 
 static ssize_t run_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -3105,11 +3105,11 @@ stable_node_chains_prune_millisecs_store(struct kobject *kobj,
 					 struct kobj_attribute *attr,
 					 const char *buf, size_t count)
 {
-	unsigned long msecs;
+	unsigned int msecs;
 	int err;
 
-	err = kstrtoul(buf, 10, &msecs);
-	if (err || msecs > UINT_MAX)
+	err = kstrtouint(buf, 10, &msecs);
+	if (err)
 		return -EINVAL;
 
 	ksm_stable_node_chains_prune_millisecs = msecs;
-- 
2.25.1

