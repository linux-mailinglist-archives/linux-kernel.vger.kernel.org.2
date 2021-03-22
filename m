Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0BF3440E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhCVM0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhCVMZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:25:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EB5C061574;
        Mon, 22 Mar 2021 05:25:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j18so16487090wra.2;
        Mon, 22 Mar 2021 05:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DGlVH/z6AUneSXkTaU6Us2MYmJ8DP9BEj41zBXWjRaQ=;
        b=CdLxL9vxfxfEOK8O/aRcklGoAV8Mq2DFTnxOY7sfTtalvMiNQ/htQ7igCwvrDISCeA
         ArlP0pV9zagkKMpgNskhO01r5IeiQdrC4quDzF9Hr8TEDQuqjobw1LmyMQFLCiL2OgeA
         PbJlgSardXEpxnvrLwrlLM6DGUen0+VRafPnPyKod5Fv47vvkV2a3+3CQqEMwmmzNild
         cI25enb9ZB/04vJv0lbifMOHyYc9rLxVK5eG8W/4uTYqIJOSx6jZZI8OqImBXH+Y9b7p
         whWL8hVFCyY9x/uJZ6MUjle+1cstP8JEuLhRk3lKtdcNEoz0ArEsm88SHOFyk7UcMstL
         989w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DGlVH/z6AUneSXkTaU6Us2MYmJ8DP9BEj41zBXWjRaQ=;
        b=K6mzjb935Bdx4fTA9cKUxrA8MQEUHWWqxCEgDivKp1m2GTcMh7dFErfRSlOG+FBLqL
         TKXkUAoQ6S2k4IRATSoKdvpL5wM1HOoEmTpUFSD7V7U4cxbULIQoRUeBKgG38FkFRtjS
         neYdXr8AZPavWN3i+dNj2HEWFVPG8iWGaZbzfuDL8ig8KWHV0SdPdP+ISGtsvQuWbODA
         quRU3piBu6rVlZSeivmqcB83EiQPmlsw5w7qX9UDEy5KMdccB7fyr2RC2UXR7ZlkG7gT
         J5lfJ19s9Hzbvd2tgAXGLNS3mEnxTTPMBhVe8JaD8nSiYuMlcYrisTcb1vpFF6IcYR2N
         PTFQ==
X-Gm-Message-State: AOAM531dowKIf8PNeickQXiff5cJPuWfIpg/J9+egYqHEKmvQeqRCHDl
        KL2cM2wnWPPW2HacsebOWYE=
X-Google-Smtp-Source: ABdhPJw+eHBj2KVeDbm7TygBhjGJNoFQ+/Qn1A6XGoCBeSsem+1cwpXiWbSXFu2mbxJZFe7y6qxhVA==
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr17867999wrm.32.1616415956354;
        Mon, 22 Mar 2021 05:25:56 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d8a:8e00:5079:bba3:3b0:9023])
        by smtp.gmail.com with ESMTPSA id u17sm19088558wrw.51.2021.03.22.05.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 05:25:56 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/2] pagewalk: prefix struct kernel-doc descriptions
Date:   Mon, 22 Mar 2021 13:25:42 +0100
Message-Id: <20210322122542.15072-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210322122542.15072-1-lukas.bulwahn@gmail.com>
References: <20210322122542.15072-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The script './scripts/kernel-doc -none ./include/linux/pagewalk.h' reports:

  include/linux/pagewalk.h:37: warning: cannot understand function prototype: 'struct mm_walk_ops '
  include/linux/pagewalk.h:85: warning: cannot understand function prototype: 'struct mm_walk '

A kernel-doc description for a structure requires to prefix the struct name
with the keyword 'struct'. So, do that such that no further kernel-doc
warnings are reported for this file.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 include/linux/pagewalk.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index b1cb6b753abb..ac7b38ad5903 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -7,7 +7,7 @@
 struct mm_walk;
 
 /**
- * mm_walk_ops - callbacks for walk_page_range
+ * struct mm_walk_ops - callbacks for walk_page_range
  * @pgd_entry:		if set, called for each non-empty PGD (top-level) entry
  * @p4d_entry:		if set, called for each non-empty P4D entry
  * @pud_entry:		if set, called for each non-empty PUD entry
@@ -71,7 +71,7 @@ enum page_walk_action {
 };
 
 /**
- * mm_walk - walk_page_range data
+ * struct mm_walk - walk_page_range data
  * @ops:	operation to call during the walk
  * @mm:		mm_struct representing the target process of page table walk
  * @pgd:	pointer to PGD; only valid with no_vma (otherwise set to NULL)
-- 
2.17.1

