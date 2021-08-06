Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1ED13E294A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbhHFLOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245375AbhHFLOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:14:12 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875F2C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 04:13:56 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id o10so11448017ljp.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 04:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=go/Ikxz+9YJxXVqFDIWifEDBhNwe5cwdk3IxCbit3ac=;
        b=iIXjHiU8tDqwt3Im+osAnO0L5k2DYaoqtUZakPy5L8itMC4b/1MGTyHBmPxP4vLAFt
         aZcLS560YuZhW3c+AV1TMxmACEtOao3xq9p9N2ITB+Mv6OILnpxCVxJFw0VIJqMRRj2e
         GaT5EVBRcYBNE1xg59ZIKeQGlSnvGN9w2HQSqkWyPjwRKUI8akRgvXuBr72K3Kfly6nb
         0agM6wn6lFbw7xGue2O0sAJe7HyF6HMpJGjUidaTtDVMs+9wzn7Em5AlIivHOUXZxPWE
         SEG8DHUYGZjzC3WkXvp6FJj3noJi8En8L79KZBBzdkijel3e7ogb/PUUyQS0CjK4YZoh
         dRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=go/Ikxz+9YJxXVqFDIWifEDBhNwe5cwdk3IxCbit3ac=;
        b=GggilCSpzo19ngaybmq6eOkWSKZ4DTy15SyAVvdSICOphikSOto1yVGcsUANhyzxss
         4eEUPnZexOgXUiO06agxmPX6Qlv4pMoz749Pwia1EVhTVuKXPR1tBD02onDWBXSZAfrW
         6enfCiYCskUbQHV98hnOqGJoS3pZrBgFqxYX/FCTZVR1tuDJ/U8Rtocb5WR3AjZsNPxw
         MliHgb2wLVFYWQaWxnQ5niHJ/oUAAlfJi69Ptw7vzeP/VSx5KJ6aTIqpkZAhUVzNtNqa
         sZ/zN6e02I3jjHm+55bop1hgLHULbhgMoneIDfgnFhIgsM3aAq/Y/t6WLP0ym9sr+9ka
         r7SQ==
X-Gm-Message-State: AOAM531f8ibJoV/Knivi1DKkjlX/A+dtb+iE0CnD+RKVN1jqVqUTrI5g
        MVnqB5p3wYaQ/w/wqs2/2ws=
X-Google-Smtp-Source: ABdhPJwivc4jWE5IzbAz8FexMnq16ypilJeHpuD5TYjpPsNxwD5XgWoCouP30v53V3gtag13UmnEKA==
X-Received: by 2002:a2e:98d1:: with SMTP id s17mr5947754ljj.457.1628248434912;
        Fri, 06 Aug 2021 04:13:54 -0700 (PDT)
Received: from asus ([93.95.240.58])
        by smtp.gmail.com with ESMTPSA id z21sm663477ljj.47.2021.08.06.04.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:13:54 -0700 (PDT)
Date:   Fri, 6 Aug 2021 17:13:51 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, hughd@google.com
Subject: [PATCH v3] mm: KSM: fix data type
Message-ID: <20210806111351.GA71845@asus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ksm_stable_node_chains_prune_millisecs is declared as int, but in
stable__node_chains_prune_millisecs_store(), it can store values up to
UINT_MAX. Change its type to unsigned int.

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
v2 -> v3:
 As suggested by Hugh Dickins,
 - discard changes to ksm_run

v1 -> v2:
 - merge two patches into one

v2: https://lore.kernel.org/lkml/20210716055800.GA255851@asus 
v1: https://lkml.org/lkml/2021/7/15/866

 mm/ksm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 3fa9bc8a67cf..025338128cd9 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -259,7 +259,7 @@ static unsigned long ksm_stable_node_chains;
 static unsigned long ksm_stable_node_dups;
 
 /* Delay in pruning stale stable_node_dups in the stable_node_chains */
-static int ksm_stable_node_chains_prune_millisecs = 2000;
+static unsigned int ksm_stable_node_chains_prune_millisecs = 2000;
 
 /* Maximum number of page slots sharing a stable node */
 static int ksm_max_page_sharing = 256;
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

